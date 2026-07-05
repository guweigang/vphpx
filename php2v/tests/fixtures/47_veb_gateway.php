<?php
$user = $_GET['user'] ?? 'anonymous';
$method = $_SERVER['REQUEST_METHOD'] ?? 'GET';
echo "Hello, " . $user . "! Method is " . $method;
