--TEST--
VSlim validator can read PSR-7 server request query and parsed body
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$request = (new VSlim\Psr7\ServerRequest())
    ->withQueryParams([
        'page' => '2',
        'filter' => 'recent',
    ])
    ->withParsedBody([
        'name' => 'neo',
        'email' => 'neo@matrix.io',
        'page' => '5',
    ]);

$validator = VSlim\Validate\Validator::make($request, [
    'name' => 'required|string|min:2',
    'email' => 'required|email',
    'page' => 'required|int|min:1',
    'filter' => 'required|string',
]);

echo ($validator->passes() ? 'pass' : 'fail') . PHP_EOL;
echo json_encode($validator->validated(), JSON_UNESCAPED_SLASHES) . PHP_EOL;

$bad = VSlim\Validate\Validator::make(
    (new VSlim\Psr7\ServerRequest())
        ->withQueryParams(['page' => '0'])
        ->withParsedBody(['email' => 'wrong']),
    [
        'name' => 'required|string',
        'email' => 'required|email',
        'page' => 'required|int|min:1',
    ]
);

echo ($bad->fails() ? 'fail' : 'pass') . PHP_EOL;
$errors = $bad->errors();
echo $errors['name'][0] . PHP_EOL;
echo $errors['email'][0] . PHP_EOL;
echo $errors['page'][0] . PHP_EOL;
?>
--EXPECT--
pass
{"name":"neo","email":"neo@matrix.io","page":"5","filter":"recent"}
fail
The name field is required.
The email field must be a valid email address.
The page field must be at least 1.
