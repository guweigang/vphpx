--TEST--
VSlim app exceptionResponse maps common exception types to framework-friendly responses
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$app->setErrorResponseJson(true);

function response_status($response): int { return $response->getStatusCode(); }
function response_body($response): string { return (string) $response->getBody(); }

$invalid = $app->exceptionResponse(new InvalidArgumentException('Bad input'));
echo response_status($invalid) . PHP_EOL;
echo (str_contains(response_body($invalid), '"invalid_argument"') ? 'invalid_code_yes' : 'invalid_code_no') . PHP_EOL;

try {
    $app->container()->get('missing.service');
} catch (Throwable $e) {
	$missing = $app->exceptionResponse($e);
	echo response_status($missing) . PHP_EOL;
	echo (str_contains(response_body($missing), '"not_found"') ? 'missing_code_yes' : 'missing_code_no') . PHP_EOL;
}

$runtime = $app->exceptionResponse(new RuntimeException('Boom'));
echo response_status($runtime) . PHP_EOL;
echo (str_contains(response_body($runtime), '"runtime_error"') ? 'runtime_code_yes' : 'runtime_code_no') . PHP_EOL;

$config = $app->exceptionResponse(new RuntimeException('config load failed: missing file'));
echo response_status($config) . PHP_EOL;
echo (str_contains(response_body($config), '"config_error"') ? 'config_code_yes' : 'config_code_no') . PHP_EOL;

$dbUnavailable = $app->exceptionResponse(new RuntimeException('connect_failed: no route to host'));
echo response_status($dbUnavailable) . PHP_EOL;
echo (str_contains(response_body($dbUnavailable), '"database_unavailable"') ? 'db_unavailable_yes' : 'db_unavailable_no') . PHP_EOL;

$dbError = $app->exceptionResponse(new RuntimeException('query_failed: syntax error'));
echo response_status($dbError) . PHP_EOL;
echo (str_contains(response_body($dbError), '"database_error"') ? 'db_error_yes' : 'db_error_no') . PHP_EOL;

$dbError2 = $app->exceptionResponse(new RuntimeException('database query failed: syntax error'));
echo response_status($dbError2) . PHP_EOL;
echo (str_contains(response_body($dbError2), '"database_error"') ? 'db_error2_yes' : 'db_error2_no') . PHP_EOL;

$dbError3 = $app->exceptionResponse(new RuntimeException('database commit failed: deadlock'));
echo response_status($dbError3) . PHP_EOL;
echo (str_contains(response_body($dbError3), '"database_error"') ? 'db_error3_yes' : 'db_error3_no') . PHP_EOL;
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
500
db_error2_yes
500
db_error3_yes
