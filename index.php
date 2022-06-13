<?php

declare(strict_types=1);

spl_autoload_register(function ($class) {
    require __DIR__ . "/src/$class.php";
});

set_error_handler("ErrorHandler::handleError");
set_exception_handler("ErrorHandler::handleException");

header("Content-type: application/json; charset=UTF-8");

$parts = explode("/", $_SERVER["REQUEST_URI"]);

if ($parts[1] != "incidentes") {
    http_response_code(404);
    exit;
}

$id = $parts[2] ?? null;

//incidentes
$database = new Database("us-cdbr-east-05.cleardb.net", "heroku_94ea94d006b36a4", "b338104b34438e", "b45c87a2");
$gateway = new IncidentesGateway($database);
$controller = new IncidentesController($gateway);

$controller->processRequest($_SERVER["REQUEST_METHOD"], $id);
