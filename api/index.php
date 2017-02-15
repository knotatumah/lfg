<?php
require '../vendor/slim/slim/Slim/Slim.php';
require_once 'dbHelper.php';
 
\Slim\Slim::registerAutoloader();
$app = new \Slim\Slim();
$app = \Slim\Slim::getInstance();
$db = new dbHelper();
 
$app->post('/addGroup', function() 
{
    if (!($post = file_get_contents("php://input"))) {
        echoResponse(400, array("status" => "error", "reason" => "input failure", "errorCode" => "1"));
        return;
    }

    if(!($post = json_decode($post))){
        echoResponse(400, array("status" => "error", "reason" => "decode failure", "errorCode" => "2"));
        return;
    }

    if (!count($post))
    {
        echoResponse(400, array("status" => "error", "reason" => "empty input", "errorCode" => "3"));
        return;
    }

    global $db;
    global $app;

    $into = 'Groups';
    $items = (array)$post;

    //We need the timestamp but can't use it as a prepared value
    $addedColumns = ',group_time';
    $addedValues = ",UNIX_TIMESTAMP()";

    $response = $db->insert($into, $items, $addedColumns, $addedValues);
    echoResponse(200, $response);
});

$app->post('/groups', function() 
{

    if (!($post = file_get_contents("php://input"))) {
        return 'POST: input failed';
    }

    if(!($post = json_decode($post))){
        return 'POST: decode failed';
    }

    global $db;
    global $app;

    $select = 'Groups.group_user, Groups.group_iam, Groups.group_details, Groups.group_language, Groups.group_time, Systems.system_name, Games.game_name, Activities.activity_name';
    $from = 'Groups';
    $items = $post[0];
    $joins = 'INNER JOIN Systems on Groups.group_system = Systems.system_id INNER JOIN Games on Groups.group_game = Games.game_id INNER JOIN Activities on Groups.group_activity = Activities.activity_id';
    $order = 'ORDER BY group_time DESC';
    $limit = 'LIMIT '.$post[1];

    $data = array($select,$from,$items,$joins,$limit,$order);
    $rows = $db->select($data);
    echoResponse(200, $rows);
});

$app->get('/systems', function()
{ 
    global $db;
    global $app;

    $select = 'system_id, system_name';
    $from = 'Systems';
    $joins = '';
    $items = array();
    $order = '';
    $limit = '';

    $data = array($select,$from,$items,$joins,$order,$limit);

    $rows = $db->select($data);
    echoResponse(200, $rows);
});

$app->get('/games', function() 
{ 
    global $db;
    global $app;

    $select = 'game_id, game_name';
    $from = 'Games';
    $joins = '';
    $items = array();
    $order = 'ORDER BY game_name ASC';
    $limit = '';

    $data = array($select,$from,$items,$joins,$order,$limit);

    $rows = $db->select($data);
    echoResponse(200, $rows);
});

$app->get('/games/:systemId', function($systemId) 
{ 
    global $db;
    global $app;

    $select = 'Games.game_id, Games.game_name';
    $from = 'Games';
    $joins = 'INNER JOIN SystemsGames ON Games.game_id = SystemsGames.game_id';
    $items = array('system_id' => $systemId);
    $order = 'ORDER BY game_name ASC';
    $limit = '';

    $data = array($select,$from,$items,$joins,$order,$limit);

    $rows = $db->select($data);
    echoResponse(200, $rows);
});

$app->get('/activities/:systemId/:gameId', function($systemId, $gameId) 
{
    global $db;
    global $app;

    $select = 'Activities.activity_id, Activities.activity_name';
    $from = 'Activities';
    $joins = 'INNER JOIN ActivitiesSystemsGames ON Activities.activity_id = ActivitiesSystemsGames.activity_id';
    $items = array("ActivitiesSystemsGames.system_id" => $systemId, "ActivitiesSystemsGames.game_id" => $gameId);
    $order = '';
    $limit = '';

    $data = array($select,$from,$items,$joins,$order,$limit);

    $rows = $db->select($data);
    echoResponse(200, $rows);
});

$app->get('/activities/:gameId', function($gameId) 
{
    global $db;
    global $app;

    $select = 'DISTINCT Activities.activity_id, Activities.activity_name';
    $from = 'Activities';
    $joins = 'INNER JOIN ActivitiesSystemsGames ON Activities.activity_id = ActivitiesSystemsGames.activity_id';
    $items = array("ActivitiesSystemsGames.game_id" => $gameId);
    $order = '';
    $limit = '';

    $data = array($select,$from,$items,$joins,$order,$limit);

    $rows = $db->select($data);
    echoResponse(200, $rows);
});

function echoResponse($status_code, $response) 
{
    global $app;
    $app->status($status_code);
    $app->contentType('application/json');
    echo json_encode($response,JSON_NUMERIC_CHECK);
}
 
$app->run();
?>