<?php
require_once("../../config.php");

class dbHelper
{

    private $db;
    private $err;
    function __construct()
    {
        $dsn = 'mysql:host='.DB_HOST.';dbname='.DB_NAME.';charset=utf8';
        try {
            $this->db = new PDO($dsn, DB_USERNAME, DB_PASSWORD, array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION));
        } catch (PDOException $e) {
            $response["status"] = "error";
            $response["message"] = 'Connection failed: ' . $e->getMessage();
            $response["data"] = null;
            //echoResponse(200, $response);
            exit;
        }
    }

    function select($data)
    {
        try 
        {

            $select = $data[0];
            $from = $data[1];
            $items = $data[2];
            $joins = $data[3];
            $order = $data[4];
            $limit = $data[5];

            $binds = array();
            $where = "";

            foreach ($items as $key => $value)
            {
                $placeholder = str_replace('.','',$key); //Since the query needs [table].[column] and '.' is not allowed in a PDO placeholder.
                $where .= " AND ".$key. " LIKE :".$placeholder;
                $binds[":".$placeholder] = $value;
            }

            $query = 'SELECT '.$select.' FROM '.$from.' '.$joins.' WHERE 1=1 '.$where.' '.$limit.' '.$order;

            $stmt = $this->db->prepare($query);
            $stmt->execute($binds);
            $rows = $stmt->fetchALL(PDO::FETCH_ASSOC);

            if (count($rows)<=0)
            {
                $response["status"] = "warning";
                $response["message"] = "No data found.";
                $response["query"] = $query;
            }
            else
            {
                $response["status"] = "success";
                $response["message"] = "Data select from database";
            }

            $response["data"] = $rows;
        }
        catch(PDOException $e)
        {
            $response["status"] = "error";
            $response["message"] = "Select Failed: " .$e->getMessage();
            $response["data"] = null;
            $response["query"] = $query;
        }

        return $response;
    }

    function insert($table, $items, $addedColumns, $addedValues)
    {
        
        try
        {

            $binds = $values = $columns = array();

            foreach ($items as $key => $value)
            {
                $columns[] = $key;
                $binds[":".$key] = $value;
                $values[] = ":".$key;
            }

            $columns = "(".implode(",",$columns).$addedColumns.")";
            $values = implode(',',$values);
            $values = '('.$values.$addedValues.')';

            $query = "INSERT INTO ".$table." ".$columns." VALUES ".$values;

            $stmt = $this->db->prepare($query);
            $stmt->execute($binds);
            $bindsffected_rows = $stmt->rowCount();

            $response["status"] = "success";
            $response["message"] = $bindsffected_rows." inserted into database";

        }
        catch(PDOException $e)
        {
            $response["status"] = "failure";
            $response["message"] = "Insert Failed: ".$e->getMessage();
            $response["query"] = $query;
        }

        return $response;
    }

    function update($table, $columnsArray, $where, $requiredColumnsArray)
    {
        $this->verifyRequiredParams($columnsArray, $requiredColumnsArray);

        try
        {
            $a = array();
            $w = "";
            $c = "";

            foreach ($where as $key => $value)
            {
                $w .= " and ".$key." = :".$key;
                $a[":".$key] = $value;
            }

            foreach ($columnsArray as $key => $value)
            {
                $c .= $key." = :".$key.", ";
                $a[":".$key] = $value;
            }

            $c = rtrim($c,", ");

            $stmt =  $this->db->prepare("UPDATE $table SET $c WHERE 1=1 ".$w);
            $stmt->execute($a);
            $affected_rows = $stmt->rowCount();
            if($affected_rows<=0){
                $response["status"] = "warning";
                $response["message"] = "No row updated";
            }else{
                $response["status"] = "success";
                $response["message"] = $affected_rows." row(s) updated in database";
            }
        }
        catch(PDOException $e)
        {
            $response["status"] = "error";
           $response["message"] = "Update Failed: " .$e->getMessage();
        }

        return $response;
    }

    function delete($table, $where)
    {
        if(count($where)<=0)
        {
            $response["status"] = "warning";
            $response["message"] = "Delete Failed: At least one condition is required";
        }
        else
        {
            try
            {
                $a = array();
                $w = "";

                foreach ($where as $key => $value)
                {
                    $w .= " and " .$key. " = :".$key;
                    $a[":".$key] = $value;
                }

                $stmt =  $this->db->prepare("DELETE FROM $table WHERE 1=1 ".$w);
                $stmt->execute($a);
                $affected_rows = $stmt->rowCount();

                if($affected_rows<=0)
                {
                    $response["status"] = "warning";
                    $response["message"] = "No row deleted";
                }
                else
                {
                    $response["status"] = "success";
                    $response["message"] = $affected_rows." row(s) deleted from database";
                }
            }
            catch(PDOException $e)
            {
                $response["status"] = "error";
                $response["message"] = 'Delete Failed: ' .$e->getMessage();
            }
        }
        return $response;
    }

    function verifyRequiredParams($inArray, $requiredColumns)
    {
        $error = false;
        $errorColumns = "";
        foreach ($requiredColumns as $field)
        {
            if (!isset($inArray[$field]) || strlen(trim($inArray[$field])) <= 0)
            {
                $error = true;
                $errorColumns .= $field . ', ';
            }
        }

        if ($error)
        {
            $response = array();
            $response["status"] = "error";
            $response["message"] = 'Required field(s) ' . rtrim($errorColumns, ', ') . ' is missing or empty';
            print_r($response);
            exit;
        }
    }
}

?>