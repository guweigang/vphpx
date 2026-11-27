<?php

header('X-Replace: first');
header('X-Replace: second');
header('X-Multi: one', false);
header('X-Multi: two', false);
header('X-Remove: gone');
header_remove('X-Remove');
http_response_code(207);

echo implode('|', [
    $_GET['user']['name'],
    implode(',', $_GET['tags']),
    $_POST['profile']['role'],
    $_COOKIE['token'],
    $_SERVER['VPHP_TEST_VALUE'],
    bin2hex(file_get_contents('php://input')),
]);
