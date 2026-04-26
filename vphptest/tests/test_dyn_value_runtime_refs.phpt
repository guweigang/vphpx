--TEST--
DynValue exposes runtime refs through semantic wrappers
--FILE--
<?php
class DynValueBox
{
    public function __construct(public string $name) {}

    public function greet(): string
    {
        return "hello {$this->name}";
    }
}

$stream = fopen('php://temp', 'r+');
fwrite($stream, 'runtime-ref');
$callback = fn(string $value): string => strtoupper($value);

echo v_dyn_value_runtime_refs(new DynValueBox('codex'), $callback, $stream) . PHP_EOL;
fclose($stream);
?>
--EXPECT--
dyn=object_ref:callable_ref:resource_ref;refs=true:false:true;object=codex:hello codex:true:true:dyn_data;call=DYN:CLOSURE:dyn_data;persistent=codex:dyn_data:STORED:dyn_data;resource=stream:true;string=string_:strlen
