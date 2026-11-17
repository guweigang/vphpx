<?php

http_response_code(202);
echo $_SERVER['REQUEST_METHOD'], '|', $_GET['name'];
exit;
