--TEST--
VSlim validator validates array input and returns validated fields
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$validator = VSlim\Validate\Validator::make(
    [
        'name' => 'alice',
        'age' => '18',
        'email' => 'alice@example.com',
        'role' => 'admin',
    ],
    [
        'name' => 'required|string|min:3',
        'age' => 'required|int|min:1',
        'email' => 'required|email',
        'role' => 'in:admin,editor',
    ]
);

echo ($validator->passes() ? 'pass' : 'fail') . PHP_EOL;
echo json_encode($validator->validated(), JSON_UNESCAPED_SLASHES) . PHP_EOL;
echo json_encode($validator->errors(), JSON_UNESCAPED_SLASHES) . PHP_EOL;

$bad = VSlim\Validate\Validator::make(
    [
        'name' => '',
        'age' => 'oops',
        'email' => 'bad-email',
        'role' => 'guest',
    ],
    [
        'name' => 'required|string|min:3',
        'age' => 'required|int|min:1',
        'email' => 'required|email',
        'role' => 'in:admin,editor',
        'nick' => 'nullable|string|max:8',
    ]
);

echo ($bad->fails() ? 'fail' : 'pass') . PHP_EOL;
$errors = $bad->errors();
echo $errors['name'][0] . PHP_EOL;
echo $errors['age'][0] . PHP_EOL;
echo $errors['email'][0] . PHP_EOL;
echo $errors['role'][0] . PHP_EOL;
echo json_encode($bad->validated(), JSON_UNESCAPED_SLASHES) . PHP_EOL;
?>
--EXPECT--
pass
{"name":"alice","age":"18","email":"alice@example.com","role":"admin"}
[]
fail
The name field is required.
The age field must be an integer.
The email field must be a valid email address.
The role field must be one of: admin, editor.
[]
