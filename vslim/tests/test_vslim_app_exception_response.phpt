--TEST--
VSlim app exceptionResponse maps common exception types to framework-friendly responses
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$app->set_error_response_json(true);

$invalid = $app->exceptionResponse(new InvalidArgumentException('Bad input'));
echo $invalid->status . PHP_EOL;
echo (str_contains($invalid->body, '"invalid_argument"') ? 'invalid_code_yes' : 'invalid_code_no') . PHP_EOL;

try {
    $app->container()->get('missing.service');
} catch (Throwable $e) {
    $missing = $app->exceptionResponse($e);
    echo $missing->status . PHP_EOL;
    echo (str_contains($missing->body, '"not_found"') ? 'missing_code_yes' : 'missing_code_no') . PHP_EOL;
}

$runtime = $app->exceptionResponse(new RuntimeException('Boom'));
echo $runtime->status . PHP_EOL;
echo (str_contains($runtime->body, '"runtime_error"') ? 'runtime_code_yes' : 'runtime_code_no') . PHP_EOL;

$config = $app->exceptionResponse(new RuntimeException('config load failed: missing file'));
echo $config->status . PHP_EOL;
echo (str_contains($config->body, '"config_error"') ? 'config_code_yes' : 'config_code_no') . PHP_EOL;

$dbUnavailable = $app->exceptionResponse(new RuntimeException('connect_failed: no route to host'));
echo $dbUnavailable->status . PHP_EOL;
echo (str_contains($dbUnavailable->body, '"database_unavailable"') ? 'db_unavailable_yes' : 'db_unavailable_no') . PHP_EOL;

$dbError = $app->exceptionResponse(new RuntimeException('query_failed: syntax error'));
echo $dbError->status . PHP_EOL;
echo (str_contains($dbError->body, '"database_error"') ? 'db_error_yes' : 'db_error_no') . PHP_EOL;
?>
--EXPECT--
400
invalid_code_yes
404
missing_code_yes
500
runtime_code_yes
500
config_code_yes
503
db_unavailable_yes
500
db_error_yes
