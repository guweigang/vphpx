module main

import vphp

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpDeclaredProperty(name: 'slot', php_type: 'mixed')]
struct VTypedMixedTrait {}

@[vphp.PhpExportTrait(name: '')]
@[php_prop: 'slot']
struct VUntypedPropertyTrait {}

@[vphp.PhpExportTrait(name: '')]
struct VConflictingMixedComposition {}

const conflicting_mixed_composition = vphp.PhpTraitRules[VConflictingMixedComposition]{
	uses: [vphp.PhpNativeTraitSource(VTypedMixedTrait{}), VUntypedPropertyTrait{}]
}
