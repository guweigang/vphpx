--TEST--
VPHP emits native PHP intersection and DNF signatures
--SKIPIF--
<?php if (!extension_loaded('vphptest') || PHP_VERSION_ID < 80200) print 'skip'; ?>
--FILE--
<?php
$extension = new ReflectionExtension('vphptest');
$function = $extension->getFunctions()['v_compiler_probe_intersection'];
echo $function->getExtensionName(), PHP_EOL;
echo get_debug_type($function->getParameters()[0]->getType()), PHP_EOL;
echo $function->getParameters()[0]->getType(), PHP_EOL;
echo $function->getReturnType(), PHP_EOL;

interface CompoundContract {
    public function compoundIdentity((Iterator&Countable)|ArrayObject|int|null $value): (Iterator&Countable)|ArrayObject|int|null;
}
class CompoundBox extends VPHP\Compiler\ModuleProbeBox implements CompoundContract {}
$box = new CompoundBox;
$method = new ReflectionMethod($box, 'compoundIdentity');
$type = $method->getParameters()[0]->getType();
echo get_debug_type($type), PHP_EOL;
echo $type, PHP_EOL;
echo $method->getReturnType(), PHP_EOL;

$both = new ArrayIterator([1]);
$alternative = new ArrayObject([1]);
$onlyIterator = (static function () { yield 1; })();
var_dump(v_compiler_probe_intersection(value: $both) === $both);
var_dump($box->compoundIdentity(value: $both) === $both);
var_dump($box->compoundIdentity($alternative) === $alternative);
var_dump($box->compoundIdentity(42), $box->compoundIdentity(null));
try { v_compiler_probe_intersection($alternative); } catch (TypeError $e) { echo "intersection rejected\n"; }
try { $box->compoundIdentity($onlyIterator); } catch (TypeError $e) { echo "DNF argument rejected\n"; }
try { v_compiler_probe_wrong_dnf_return(); } catch (TypeError $e) { echo "DNF return rejected\n"; }
?>
--EXPECT--
vphptest
ReflectionIntersectionType
Iterator&Countable
Iterator&Countable
ReflectionUnionType
ArrayObject|(Iterator&Countable)|int|null
ArrayObject|(Iterator&Countable)|int|null
bool(true)
bool(true)
bool(true)
int(42)
NULL
intersection rejected
DNF argument rejected
DNF return rejected
