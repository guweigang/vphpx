module main

import vphp

@[vphp.PhpExportTrait(name: '')]
struct VReferenceSignatureRequirement {}

@[vphp.PhpExportMethod(name: 'selectValue')]
@[vphp.PhpAbstractMethod]
@[vphp.PhpArgType('value', 'string|int')]
@[vphp.PhpReturnType(php_type: 'int|(Countable&ArrayAccess)')]
pub fn (trait VReferenceSignatureRequirement) select_value(value vphp.PhpReference) vphp.ZVal {
	return value.to_zval()
}

@[vphp.PhpExportTrait(name: '')]
struct VConflictingSignatureRequirements {}

const conflicting_signature_requirements = vphp.PhpTraitRules[VConflictingSignatureRequirements]{
	uses: [vphp.PhpNativeTraitSource(VSignatureRequirementA{}), VReferenceSignatureRequirement{}]
}
