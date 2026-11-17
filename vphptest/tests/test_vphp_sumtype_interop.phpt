--TEST--
vphp compiler supports PHP Union Types and V SumTypes interop with structs and enums
--SKIPIF--
<?php if (!extension_loaded('vphptest')) print 'skip'; ?>
--FILE--
<?php
$box = new VPHP\Compiler\ModuleProbeBox();
$readonlyBox = new VPHP\Compiler\ModuleProbeReadOnlyBox();

$method = new ReflectionMethod($box, 'test_sumtype_echo');
$fn = new ReflectionFunction('v_compiler_probe_named_sum');
$explicit = new ReflectionFunction('v_compiler_probe_explicit_union');
foreach ([$method, $fn, $explicit] as $callable) {
    foreach ([$callable->getParameters()[0]->getType(), $callable->getReturnType()] as $type) {
        $members = array_map(static fn($member) => $member->getName(), $type->getTypes());
        sort($members);
        echo implode('|', $members), PHP_EOL;
    }
}
var_dump($box->test_sumtype(12));
var_dump($box->test_sumtype('codex'));
echo $box->test_sumtype_echo($readonlyBox)->title . "\n";
echo $box->test_sumtype_echo(VPHP\Compiler\ModuleProbeKind::beta)->name . "\n";
echo $box->test_sumtype_echo(VPHP\Compiler\OtherProbeKind::other)->name . "\n";
var_dump($box->test_sumtype_echo(11));
var_dump(v_compiler_probe_named_sum(), v_compiler_probe_named_sum(value: null));
echo v_compiler_probe_named_sum(value: VPHP\Compiler\OtherProbeKind::other)->name, PHP_EOL;
echo v_compiler_probe_explicit_union(VPHP\Compiler\ModuleProbeKind::beta)->name, PHP_EOL;

enum UnrelatedKind: int { case unrelated = 11; }
foreach ([new stdClass(), UnrelatedKind::unrelated, []] as $value) {
    try {
        $box->test_sumtype_echo($value);
    } catch (TypeError $e) {
        echo "rejected ", get_debug_type($value), PHP_EOL;
    }
}

echo "--- Testing Variadic ---\n";
echo $box->test_variadic(', ', 'a', 'b', 'c') . "\n";
?>
--EXPECT--
VPHP\Compiler\ModuleProbeKind|VPHP\Compiler\ModuleProbeReadOnlyBox|VPHP\Compiler\OtherProbeKind|int
VPHP\Compiler\ModuleProbeKind|VPHP\Compiler\ModuleProbeReadOnlyBox|VPHP\Compiler\OtherProbeKind|int
VPHP\Compiler\ModuleProbeKind|VPHP\Compiler\ModuleProbeReadOnlyBox|VPHP\Compiler\OtherProbeKind|int|null
VPHP\Compiler\ModuleProbeKind|VPHP\Compiler\ModuleProbeReadOnlyBox|VPHP\Compiler\OtherProbeKind|int|null
VPHP\Compiler\ModuleProbeKind|VPHP\Compiler\OtherProbeKind
VPHP\Compiler\ModuleProbeKind|VPHP\Compiler\OtherProbeKind
int(112)
string(11) "hello:codex"
readonly-box
beta
other
int(11)
NULL
NULL
other
beta
rejected stdClass
rejected UnrelatedKind
rejected array
--- Testing Variadic ---
a, b, c
