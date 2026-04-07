--TEST--
VSlim app error helpers produce framework-friendly responses
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();
$app->set_error_response_json(true);

$errors = ['email' => ['The email field is required.']];
$validation = $app->validationError($errors, 422);
echo $validation->status . PHP_EOL;
echo $validation->content_type . PHP_EOL;
echo (str_contains($validation->body, '"validation_error"') ? 'validation_yes' : 'validation_no') . PHP_EOL;
echo (str_contains($validation->body, '"email"') ? 'field_yes' : 'field_no') . PHP_EOL;

$unauthorized = $app->unauthorized();
echo $unauthorized->status . PHP_EOL;
echo (str_contains($unauthorized->body, '"unauthorized"') ? 'unauthorized_yes' : 'unauthorized_no') . PHP_EOL;

$forbidden = $app->forbidden('Stop');
echo $forbidden->status . PHP_EOL;
echo (str_contains($forbidden->body, '"Stop"') ? 'forbidden_yes' : 'forbidden_no') . PHP_EOL;
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
