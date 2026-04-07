--TEST--
VSlim app validate helper returns a validated validator instance
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();

$validator = $app->validate(
    [
        'name' => 'trinity',
        'email' => 'trinity@matrix.io',
    ],
    [
        'name' => 'required|string|min:3',
        'email' => 'required|email',
    ]
);

echo ($validator->passes() ? 'pass' : 'fail') . PHP_EOL;
echo json_encode($validator->validated(), JSON_UNESCAPED_SLASHES) . PHP_EOL;

$bad = $app->validate(
    [
        'name' => '',
        'email' => 'bad',
    ],
    [
        'name' => 'required|string',
        'email' => 'required|email',
    ]
);

echo ($bad->fails() ? 'fail' : 'pass') . PHP_EOL;
$errors = $bad->errors();
echo $errors['name'][0] . PHP_EOL;
echo $errors['email'][0] . PHP_EOL;
?>
--EXPECT--
pass
{"name":"trinity","email":"trinity@matrix.io"}
fail
The name field is required.
The email field must be a valid email address.
