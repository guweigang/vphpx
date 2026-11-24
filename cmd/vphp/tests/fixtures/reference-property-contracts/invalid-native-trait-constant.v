module main

import vphp

struct ConflictingTraitConstantValues {
	limit f64
}

const conflicting_trait_constants = ConflictingTraitConstantValues{
	limit: 16.0
}

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpClassConstants('conflicting_trait_constants')]
struct VConflictingConstantTrait {}

@[vphp.PhpExportTrait(name: '')]
struct VConflictingConstantComposition {}

const conflicting_constant_composition = vphp.PhpTraitRules[VConflictingConstantComposition]{
	uses: [vphp.PhpNativeTraitSource(VConstantTraitA{}), VConflictingConstantTrait{}]
}
