--TEST--
VSlim Request input helpers merge query and parsed body values
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$req = new VSlim\Vhttpd\Request('POST', '/submit?from=query&same=qv', 'from=body&same=bv&n=1');
$req->setHeaders(['content-type' => 'application/x-www-form-urlencoded']);
echo $req->input('from') . PHP_EOL;
echo $req->input('same') . PHP_EOL;
echo ($req->has_input('n') ? 'yes' : 'no') . PHP_EOL;
echo $req->inputOr('none', 'fallback') . PHP_EOL;
echo $req->parsedBody()['from'] . PHP_EOL;
echo $req->allInputs()['from'] . '|' . $req->allInputs()['same'] . PHP_EOL;

$jsonReq = new VSlim\Vhttpd\Request('POST', '/json?trace=query', '{"trace":"body","ok":"yes"}');
$jsonReq->setHeaders(['content-type' => 'application/json']);
echo $jsonReq->input('trace') . PHP_EOL;
echo $jsonReq->input('ok') . PHP_EOL;
echo $jsonReq->parsedBody()['ok'] . PHP_EOL;
?>
--EXPECT--
body
bv
yes
fallback
body
body|bv
body
yes
yes
