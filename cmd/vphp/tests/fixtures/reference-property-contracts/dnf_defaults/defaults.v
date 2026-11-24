module dnf_defaults

import vphp

@[vphp.PhpExternalInterface(name: 'VPHP\\ReferenceExternal\\Contract')]
pub interface VExternalContract {}

pub type ExternalContract = vphp.PhpInterface[VExternalContract]

const string_case_discriminant = 29
const unit_case_discriminant = 7
const dnf_default_base = 0x20

@[vphp.PhpExportEnum(name: 'VPHP\\ReferenceDefaults\\ExportedDnfDefault')]
@[vphp.PhpEnumImplements(names: 'Countable, ArrayAccess')]
pub enum VDnfDefault {
	default_value  = dnf_default_base + 5
	next_value
	other_value    = 0b11_0011
	negative_value = -0x10
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\convertDnfDiscriminant')]
pub fn convert_dnf_discriminant(discriminant i64) !vphp.PhpValue {
	return vphp.PhpValue.from_v(unsafe { VDnfDefault(discriminant) })
}

@[vphp.PhpExportMethod(name: 'count')]
pub fn (case_ VDnfDefault) count() i64 {
	return i64(case_)
}

@[vphp.PhpExportMethod(name: 'offsetExists')]
pub fn (case_ VDnfDefault) offset_exists(offset vphp.PhpValue) bool {
	value := offset.as_int() or { return false }
	return value.value() == i64(case_)
}

@[vphp.PhpExportMethod(name: 'offsetGet')]
pub fn (case_ VDnfDefault) offset_get(offset vphp.PhpValue) vphp.PhpValue {
	_ = case_
	return offset
}

@[vphp.PhpExportMethod(name: 'offsetSet')]
pub fn (case_ VDnfDefault) offset_set(offset vphp.PhpValue, value vphp.PhpValue) {
	_ = case_
	_ = offset
	_ = value
}

@[vphp.PhpExportMethod(name: 'offsetUnset')]
pub fn (case_ VDnfDefault) offset_unset(offset vphp.PhpValue) {
	_ = case_
	_ = offset
}

@[vphp.PhpExportEnum(name: 'VPHP\\ReferenceDefaults\\StringBacked')]
pub enum VStringBacked {
	empty   = 13                        @[vphp.PhpEnumCaseValue(value: '')]
	escaped = string_case_discriminant  @[vphp.PhpEnumCaseValue(value: "雪\\'\"\x00")]
}

@[vphp.PhpExportMethod(name: 'discriminant')]
pub fn (case_ VStringBacked) discriminant() i64 {
	return i64(case_)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\roundTripStringEnum')]
pub fn round_trip_string_enum(value VStringBacked) VStringBacked {
	return value
}

@[vphp.PhpExportEnum(name: 'VPHP\\ReferenceDefaults\\UnitKind')]
@[vphp.PhpUnitEnum]
@[vphp.PhpEnumImplements(names: 'Countable')]
pub enum VUnitKind {
	first  = 3
	second = unit_case_discriminant  @[vphp.PhpEnumCaseName(name: 'Second')]
}

@[params]
pub struct EnumDefaultOptions {
pub:
	selected ?VUnitKind = VUnitKind.second
	label    string     = 'external'
}

@[params]
pub struct ComputedInterfaceOptions {
pub:
	value string = vphp.PhpFunction.named('vphp_contract_computed_value').result_string()
	label string = 'tail'
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceDefaults\\localOptions')]
pub fn local_options(options EnumDefaultOptions) vphp.PhpArray {
	mut result := vphp.PhpArray.new()
	if selected := options.selected {
		result.set('selected', vphp.PhpValue.from_v(selected) or { return result })
	} else {
		result.set('selected', vphp.PhpNull.value())
	}
	result.string('label', options.label)
	return result
}

struct UnitKindConstants {
	alias         VUnitKind
	legacy_second VUnitKind @[vphp.PhpClassConstantName(name: 'second')]
}

const unit_kind_constants = vphp.PhpConstantTable[VUnitKind, UnitKindConstants]{
	values: UnitKindConstants{ alias: .first, legacy_second: .second }
}

@[vphp.PhpExportMethod(name: 'count')]
pub fn (case_ VUnitKind) count() i64 {
	return i64(case_)
}

@[vphp.PhpExportMethod(name: 'from')]
pub fn VUnitKind.from_case(other VUnitKind) VUnitKind {
	return other
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\roundTripUnitEnum')]
@[vphp.PhpArgDefaults(defaults: "value=VPHP\\ReferenceDefaults\\UnitKind::first,label='default'")]
pub fn round_trip_unit_enum(value VUnitKind, label string) VUnitKind {
	return value
}

@[vphp.PhpExportInterface(name: 'VPHP\\ReferenceProbe\\EnumSelector')]
pub interface VEnumSelector {
	select(x VUnitKind, alternatives ...VUnitKind) VUnitKind
	pick(x VUnitKind, label string) VUnitKind
}

const enum_selector_defaults = vphp.PhpInterfaceDefaults[VEnumSelector]{
	defaults: [
		vphp.PhpInterfaceDefault{ method: 'pick', parameter: 'x', default_value: 'VPHP\\ReferenceDefaults\\UnitKind::Second' },
		vphp.PhpInterfaceDefault{ method: 'pick', parameter: 'label', default_value: "'default'" },
	]
}

@[vphp.PhpExportClass(name: 'VPHP\\ReferenceProbe\\EnumSelectorImpl')]
@[vphp.PhpImplements(names: 'VPHP\\ReferenceProbe\\EnumSelector')]
pub struct VEnumSelectorImpl {}

@[vphp.PhpExportMethod(name: 'select')]
pub fn (selector &VEnumSelectorImpl) select(x VUnitKind, alternatives ...VUnitKind) VUnitKind {
	return if alternatives.len == 0 { x } else { alternatives.last() }
}

@[vphp.PhpExportMethod(name: 'pick')]
@[vphp.PhpArgDefaults(defaults: "x=VPHP\\ReferenceDefaults\\UnitKind::Second,label='default'")]
pub fn (selector &VEnumSelectorImpl) pick(x VUnitKind, label string) VUnitKind {
	return x
}

@[vphp.PhpExportInterface(name: 'VPHP\\ReferenceProbe\\UnnamedEnumArgs')]
pub interface VUnnamedEnumArgs {
	pair(VUnitKind, arg1 VUnitKind) VUnitKind
}

@[vphp.PhpExportInterface(name: 'VPHP\\ReferenceProbe\\EnumSelectorFactory')]
@[vphp.PhpInterfaceStaticMethods(names: 'choose')]
pub interface VEnumSelectorFactory {
	choose(x VUnitKind) VUnitKind
	keep(x VUnitKind) VUnitKind
}

const enum_selector_factory_defaults = vphp.PhpInterfaceDefaults[VEnumSelectorFactory]{
	defaults: [
		vphp.PhpInterfaceDefault{
			method:        'choose'
			parameter:     'x'
			default_value: 'VPHP\\ReferenceDefaults\\UnitKind::Second'
		},
	]
}

@[vphp.PhpExportInterface(name: 'VPHP\\ReferenceProbe\\InheritedEnumSelectorFactory')]
@[vphp.PhpExtendsInterfaces('VPHP\\ReferenceProbe\\EnumSelectorFactory')]
pub interface VInheritedEnumSelectorFactory {}

@[vphp.PhpExportClass(name: 'VPHP\\ReferenceProbe\\EnumSelectorFactoryImpl')]
@[vphp.PhpImplements(names: 'VPHP\\ReferenceProbe\\InheritedEnumSelectorFactory')]
pub struct VEnumSelectorFactoryImpl {}

@[vphp.PhpExportMethod(name: 'choose')]
@[vphp.PhpArgDefault('x', 'VPHP\\ReferenceDefaults\\UnitKind::Second')]
pub fn VEnumSelectorFactoryImpl.choose(x VUnitKind) VUnitKind {
	return x
}

@[vphp.PhpExportMethod(name: 'keep')]
pub fn (selector &VEnumSelectorFactoryImpl) keep(x VUnitKind) VUnitKind {
	return x
}

@[vphp.PhpExportClass(name: 'VPHP\\ReferenceDefaults\\Payload')]
@[heap]
pub struct VReferencePayload {
	release_count &PayloadReleaseCount = unsafe { nil }
pub:
	marker i64
}

struct PayloadReleaseCount {
mut:
	value i64
}

pub fn (payload &VReferencePayload) cleanup() {
	if payload.release_count != unsafe { nil } {
		mut count := payload.release_count
		count.value++
	}
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut payload VReferencePayload) construct(marker i64) &VReferencePayload {
	payload = VReferencePayload{ marker: marker }
	return &payload
}

@[vphp.PhpExportMethod(name: 'contextSelf')]
@[vphp.PhpBorrowedReturn]
pub fn (payload &VReferencePayload) context_self(ctx vphp.Context) &VReferencePayload {
	_ = ctx
	return payload
}

@[vphp.PhpExportMethod(name: 'borrowedSelf')]
@[vphp.PhpBorrowedReturn]
pub fn VReferencePayload.borrowed_self(payload &VReferencePayload) &VReferencePayload {
	return payload
}

@[vphp.PhpExportClass(name: 'VPHP\\ReferenceDefaults\\PayloadOwner')]
@[heap]
pub struct VPayloadOwner {
mut:
	payload       &VReferencePayload   = unsafe { nil }
	release_count &PayloadReleaseCount = unsafe { nil }
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut owner VPayloadOwner) construct() &VPayloadOwner {
	owner.release_count = &PayloadReleaseCount{}
	owner.payload = &VReferencePayload{
		marker:        47
		release_count: owner.release_count
	}
	return &owner
}

@[vphp.PhpExportMethod(name: 'releaseCount')]
pub fn (owner &VPayloadOwner) read_release_count() i64 {
	return owner.release_count.value
}

@[vphp.PhpExportMethod(name: 'borrowFromOwner')]
@[vphp.PhpBorrowedReturn]
pub fn VReferencePayload.borrow_from_owner(owner &VPayloadOwner) &VReferencePayload {
	return owner.payload
}

@[vphp.PhpExportInterface(name: 'VPHP\\ReferenceProbe\\TypedValueContract')]
pub interface VTypedValueContract {
	typed_value(value vphp.PhpValue) vphp.PhpValue
}

const typed_value_contract_methods = vphp.PhpInterfaceMethods[VTypedValueContract]{
	methods: [
		vphp.PhpInterfaceMethod{
			v_name:          'typed_value'
			php_name:        'typedValue'
			php_return_type: '(Countable&ArrayAccess)|int|null'
			parameters:      [vphp.PhpInterfaceParameter{ v_name: 'value', php_type: '(Countable&ArrayAccess)|int|null' }]
			attributes:      [
				vphp.PhpAttributeSpec{ name: 'VphpInterfaceProbeTag', args: '"method", metadata: ["types" => ["int", "null"]]' }
				vphp.PhpAttributeSpec{ name: 'NoDiscard', args: 'message: "Use the contract result"' },
			]
		},
	]
}
