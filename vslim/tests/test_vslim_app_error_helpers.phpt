--TEST--
VSlim app error helpers produce framework-friendly responses
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$app->setErrorResponseJson(true);

$errors = ['email' => ['The email field is required.']];
$validation = $app->validationError($errors, 422);
echo $validation->status . PHP_EOL;
echo $validation->contentType . PHP_EOL;
echo (str_contains($validation->body, '"validation_error"') ? 'validation_yes' : 'validation_no') . PHP_EOL;
echo (str_contains($validation->body, '"email"') ? 'field_yes' : 'field_no') . PHP_EOL;

$unauthorized = $app->unauthorized();
echo $unauthorized->status . PHP_EOL;
echo (str_contains($unauthorized->body, '"unauthorized"') ? 'unauthorized_yes' : 'unauthorized_no') . PHP_EOL;

$forbidden = $app->forbidden('Stop');
echo $forbidden->status . PHP_EOL;
echo (str_contains($forbidden->body, '"Stop"') ? 'forbidden_yes' : 'forbidden_no') . PHP_EOL;

$badRequest = $app->badRequest();
echo $badRequest->status . PHP_EOL;
echo (str_contains($badRequest->body, '"bad_request"') ? 'bad_request_yes' : 'bad_request_no') . PHP_EOL;

$notFound = $app->notFound('Missing');
echo $notFound->status . PHP_EOL;
echo (str_contains($notFound->body, '"not_found"') ? 'not_found_yes' : 'not_found_no') . PHP_EOL;

$conflict = $app->conflict();
echo $conflict->status . PHP_EOL;
echo (str_contains($conflict->body, '"conflict"') ? 'conflict_yes' : 'conflict_no') . PHP_EOL;

$serviceUnavailable = $app->serviceUnavailable();
echo $serviceUnavailable->status . PHP_EOL;
echo (str_contains($serviceUnavailable->body, '"service_unavailable"') ? 'service_unavailable_yes' : 'service_unavailable_no') . PHP_EOL;

$exception = $app->exceptionResponse(new InvalidArgumentException('Wrong'));
echo $exception->status . PHP_EOL;
echo (str_contains($exception->body, '"invalid_argument"') ? 'exception_yes' : 'exception_no') . PHP_EOL;
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
