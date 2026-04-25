--TEST--
VSlim Request body format helpers support json/form/multipart
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$formReq = new VSlim\VHttpd\Request('POST', '/forms/echo?token=demo', 'name=neo&city=shanghai');
$formReq->setHeaders(['content-type' => 'application/x-www-form-urlencoded']);
echo $formReq->bodyFormat() . PHP_EOL;
echo ($formReq->isFormBody() ? 'yes' : 'no') . PHP_EOL;
echo $formReq->formBody()['name'] . PHP_EOL;

$jsonReq = new VSlim\VHttpd\Request('POST', '/json', '{"ok":"yes","trace":"demo"}');
$jsonReq->setHeaders(['content-type' => 'application/json']);
echo $jsonReq->bodyFormat() . PHP_EOL;
echo ($jsonReq->isJsonBody() ? 'yes' : 'no') . PHP_EOL;
echo $jsonReq->jsonBody()['ok'] . PHP_EOL;

$boundary = '----vslimBoundary';
$multipartBody = ''
    . '--' . $boundary . "\r\n"
    . "Content-Disposition: form-data; name=\"name\"\r\n\r\n"
    . "neo\r\n"
    . '--' . $boundary . "\r\n"
    . "Content-Disposition: form-data; name=\"file\"; filename=\"hello.txt\"\r\n"
    . "Content-Type: text/plain\r\n\r\n"
    . "hello from body\r\n"
    . '--' . $boundary . "--\r\n";
$multipartReq = new VSlim\VHttpd\Request('POST', '/forms/echo', $multipartBody);
$multipartReq->setHeaders(['content-type' => 'multipart/form-data; boundary=' . $boundary]);
echo $multipartReq->bodyFormat() . PHP_EOL;
echo ($multipartReq->isMultipartBody() ? 'yes' : 'no') . PHP_EOL;
echo $multipartReq->multipartBody()['name'] . PHP_EOL;
echo implode(',', $multipartReq->uploaded_files()) . PHP_EOL;
?>
--EXPECT--
form
yes
neo
json
yes
yes
multipart
yes
neo
hello.txt
