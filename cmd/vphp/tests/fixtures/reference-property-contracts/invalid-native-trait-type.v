module main

import vphp

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpDeclaredStaticPropertyWithDefault('trait_choice', 'int|float', '7')]
struct VConflictingNativeStaticTypeTrait {}

@[vphp.PhpExportTrait(name: '')]
struct VConflictingTypeComposition {}

const conflicting_type_composition = vphp.PhpTraitRules[VConflictingTypeComposition]{
	uses: [vphp.PhpNativeTraitSource(VNativeUnionStaticStorageTrait{}),
		VConflictingNativeStaticTypeTrait{}]
}
