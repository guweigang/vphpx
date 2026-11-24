module main

import vphp

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpDeclaredStaticPropertyWithDefault('trait_rate', 'float', '2.0')]
struct VConflictingNativeStaticStorageTrait {}

@[vphp.PhpExportTrait(name: '')]
struct VConflictingStaticComposition {}

const conflicting_static_composition = vphp.PhpTraitRules[VConflictingStaticComposition]{
	uses: [vphp.PhpNativeTraitSource(VNumericNativeStaticStorageTrait{}),
		VConflictingNativeStaticStorageTrait{}]
}
