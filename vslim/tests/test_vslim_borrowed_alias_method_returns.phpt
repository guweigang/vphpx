--TEST--
VSlim compiler infers borrowed returns through local aliases and if/match-expression branches of borrowed method calls
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
namespace Psr\EventDispatcher {
    if (!interface_exists(ListenerProviderInterface::class, false)) {
        interface ListenerProviderInterface
        {
            public function getListenersForEvent(object $event): iterable;
        }
    }
}

namespace {
    $provider = new VSlim\Psr14\ListenerProvider();
    $probe = (new VSlim\Dev\PhpSignatureProbe())->setProvider($provider);

    $direct = $probe->borrowedProvider();
    $alias1 = $probe->borrowedProviderAlias();
    $alias2 = $probe->borrowedProviderAlias();
    $guard1 = $probe->borrowedProviderFromGuard();
    $guard2 = $probe->borrowedProviderFromGuard();
    $ifExpr1 = $probe->borrowedProviderFromIfExpr(true);
    $ifExpr2 = $probe->borrowedProviderFromIfExpr(true);
    $ifExpr3 = $probe->borrowedProviderFromIfExpr(false);
    $ifAlias1 = $probe->borrowedProviderFromIfExprAlias(true);
    $ifAlias2 = $probe->borrowedProviderFromIfExprAlias(false);
    $matchExpr1 = $probe->borrowedProviderFromMatchExpr(true);
    $matchExpr2 = $probe->borrowedProviderFromMatchExpr(false);
    $matchAlias1 = $probe->borrowedProviderFromMatchExprAlias(true);
    $matchAlias2 = $probe->borrowedProviderFromMatchExprAlias(false);
    $orBlock1 = $probe->borrowedProviderFromOrBlock();
    $orBlock2 = $probe->borrowedProviderFromOrBlock();
    $orAlias1 = $probe->borrowedProviderFromOrBlockAlias();
    $orAlias2 = $probe->borrowedProviderFromOrBlockAlias();

    echo (spl_object_id($provider) === spl_object_id($direct) ? 'direct-same' : 'direct-diff') . PHP_EOL;
    echo (spl_object_id($provider) === spl_object_id($alias1) ? 'alias-same' : 'alias-diff') . PHP_EOL;
    echo (spl_object_id($alias1) === spl_object_id($alias2) ? 'alias-stable' : 'alias-unstable') . PHP_EOL;
    echo (spl_object_id($provider) === spl_object_id($guard1) ? 'guard-same' : 'guard-diff') . PHP_EOL;
    echo (spl_object_id($guard1) === spl_object_id($guard2) ? 'guard-stable' : 'guard-unstable') . PHP_EOL;
    echo (spl_object_id($provider) === spl_object_id($ifExpr1) ? 'ifexpr-true-same' : 'ifexpr-true-diff') . PHP_EOL;
    echo (spl_object_id($ifExpr1) === spl_object_id($ifExpr2) ? 'ifexpr-true-stable' : 'ifexpr-true-unstable') . PHP_EOL;
    echo (spl_object_id($provider) === spl_object_id($ifExpr3) ? 'ifexpr-false-same' : 'ifexpr-false-diff') . PHP_EOL;
    echo (spl_object_id($provider) === spl_object_id($ifAlias1) ? 'ifalias-true-same' : 'ifalias-true-diff') . PHP_EOL;
    echo (spl_object_id($provider) === spl_object_id($ifAlias2) ? 'ifalias-false-same' : 'ifalias-false-diff') . PHP_EOL;
    echo (spl_object_id($provider) === spl_object_id($matchExpr1) ? 'matchexpr-true-same' : 'matchexpr-true-diff') . PHP_EOL;
    echo (spl_object_id($provider) === spl_object_id($matchExpr2) ? 'matchexpr-false-same' : 'matchexpr-false-diff') . PHP_EOL;
    echo (spl_object_id($provider) === spl_object_id($matchAlias1) ? 'matchalias-true-same' : 'matchalias-true-diff') . PHP_EOL;
    echo (spl_object_id($provider) === spl_object_id($matchAlias2) ? 'matchalias-false-same' : 'matchalias-false-diff') . PHP_EOL;
    echo (spl_object_id($provider) === spl_object_id($orBlock1) ? 'orblock-same' : 'orblock-diff') . PHP_EOL;
    echo (spl_object_id($orBlock1) === spl_object_id($orBlock2) ? 'orblock-stable' : 'orblock-unstable') . PHP_EOL;
    echo (spl_object_id($provider) === spl_object_id($orAlias1) ? 'oralias-same' : 'oralias-diff') . PHP_EOL;
    echo (spl_object_id($orAlias1) === spl_object_id($orAlias2) ? 'oralias-stable' : 'oralias-unstable') . PHP_EOL;
}
?>
--EXPECT--
direct-same
alias-same
alias-stable
guard-same
guard-stable
ifexpr-true-same
ifexpr-true-stable
ifexpr-false-same
ifalias-true-same
ifalias-false-same
matchexpr-true-same
matchexpr-false-same
matchalias-true-same
matchalias-false-same
orblock-same
orblock-stable
oralias-same
oralias-stable
