--TEST--
VSlim compiler keeps fresh object returns fresh through aliases and if/match-expression branches
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
    $probe = (new VSlim\Dev\PhpSignatureProbe())->setProvider(new VSlim\Psr14\ListenerProvider());

    $fresh1 = $probe->freshProvider();
    $fresh2 = $probe->freshProvider();
    $alias1 = $probe->freshProviderAlias();
    $alias2 = $probe->freshProviderAlias();
    $ifExpr1 = $probe->freshProviderFromIfExpr(true);
    $ifExpr2 = $probe->freshProviderFromIfExpr(true);
    $ifExpr3 = $probe->freshProviderFromIfExpr(false);
    $ifAlias1 = $probe->freshProviderFromIfExprAlias(true);
    $ifAlias2 = $probe->freshProviderFromIfExprAlias(false);
    $matchExpr1 = $probe->freshProviderFromMatchExpr(true);
    $matchExpr2 = $probe->freshProviderFromMatchExpr(false);
    $matchAlias1 = $probe->freshProviderFromMatchExprAlias(true);
    $matchAlias2 = $probe->freshProviderFromMatchExprAlias(false);
    $orBlock1 = $probe->freshProviderFromOrBlock();
    $orBlock2 = $probe->freshProviderFromOrBlock();
    $orAlias1 = $probe->freshProviderFromOrBlockAlias();
    $orAlias2 = $probe->freshProviderFromOrBlockAlias();

    echo (spl_object_id($fresh1) === spl_object_id($fresh2) ? 'fresh-stable' : 'fresh-distinct') . PHP_EOL;
    echo ($fresh1 instanceof VSlim\Psr14\ListenerProvider ? 'fresh-type' : 'fresh-type-miss') . PHP_EOL;
    echo (spl_object_id($alias1) === spl_object_id($alias2) ? 'alias-stable' : 'alias-distinct') . PHP_EOL;
    echo (spl_object_id($ifExpr1) === spl_object_id($ifExpr2) ? 'ifexpr-true-stable' : 'ifexpr-true-distinct') . PHP_EOL;
    echo (spl_object_id($ifExpr1) === spl_object_id($ifExpr3) ? 'ifexpr-branch-stable' : 'ifexpr-branch-distinct') . PHP_EOL;
    echo (spl_object_id($ifAlias1) === spl_object_id($ifAlias2) ? 'ifalias-stable' : 'ifalias-distinct') . PHP_EOL;
    echo (spl_object_id($matchExpr1) === spl_object_id($matchExpr2) ? 'matchexpr-stable' : 'matchexpr-distinct') . PHP_EOL;
    echo (spl_object_id($matchAlias1) === spl_object_id($matchAlias2) ? 'matchalias-stable' : 'matchalias-distinct') . PHP_EOL;
    echo (spl_object_id($orBlock1) === spl_object_id($orBlock2) ? 'orblock-stable' : 'orblock-distinct') . PHP_EOL;
    echo (spl_object_id($orAlias1) === spl_object_id($orAlias2) ? 'oralias-stable' : 'oralias-distinct') . PHP_EOL;
}
?>
--EXPECT--
fresh-distinct
fresh-type
alias-distinct
ifexpr-true-distinct
ifexpr-branch-distinct
ifalias-distinct
matchexpr-distinct
matchalias-distinct
orblock-distinct
oralias-distinct
