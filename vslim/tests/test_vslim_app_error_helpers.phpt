--TEST--
VSlim app error helpers produce framework-friendly responses
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$app->setErrorResponseJson(true);

function response_status($response): int { return $response->getStatusCode(); }
function response_body($response): string { return (string) $response->getBody(); }

$errors = ['email' => ['The email field is required.']];
$validation = $app->validationError($errors, 422);
echo response_status($validation) . PHP_EOL;
echo $validation->getHeaderLine('content-type') . PHP_EOL;
echo (str_contains(response_body($validation), '"validation_error"') ? 'validation_yes' : 'validation_no') . PHP_EOL;
echo (str_contains(response_body($validation), '"email"') ? 'field_yes' : 'field_no') . PHP_EOL;

$unauthorized = $app->unauthorized();
echo response_status($unauthorized) . PHP_EOL;
echo (str_contains(response_body($unauthorized), '"unauthorized"') ? 'unauthorized_yes' : 'unauthorized_no') . PHP_EOL;

$forbidden = $app->forbidden('Stop');
echo response_status($forbidden) . PHP_EOL;
echo (str_contains(response_body($forbidden), '"Stop"') ? 'forbidden_yes' : 'forbidden_no') . PHP_EOL;

$badRequest = $app->badRequest();
echo response_status($badRequest) . PHP_EOL;
echo (str_contains(response_body($badRequest), '"bad_request"') ? 'bad_request_yes' : 'bad_request_no') . PHP_EOL;

$notFound = $app->notFound('Missing');
echo response_status($notFound) . PHP_EOL;
echo (str_contains(response_body($notFound), '"not_found"') ? 'not_found_yes' : 'not_found_no') . PHP_EOL;

$conflict = $app->conflict();
echo response_status($conflict) . PHP_EOL;
echo (str_contains(response_body($conflict), '"conflict"') ? 'conflict_yes' : 'conflict_no') . PHP_EOL;

$serviceUnavailable = $app->serviceUnavailable();
echo response_status($serviceUnavailable) . PHP_EOL;
echo (str_contains(response_body($serviceUnavailable), '"service_unavailable"') ? 'service_unavailable_yes' : 'service_unavailable_no') . PHP_EOL;

$exception = $app->exceptionResponse(new InvalidArgumentException('Wrong'));
echo response_status($exception) . PHP_EOL;
echo (str_contains(response_body($exception), '"invalid_argument"') ? 'exception_yes' : 'exception_no') . PHP_EOL;
?>
--EXPECT--
422
application/json; charset=utf-8
validation_yes
field_yes
401
unauthorized_yes
403
forbidden_yes
400
bad_request_yes
404
not_found_yes
409
conflict_yes
503
service_unavailable_yes
400
exception_yes
