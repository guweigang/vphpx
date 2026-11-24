module main

import vphp
import dnf_defaults as defaults

const ext_config = vphp.ExtensionConfig{ name: 'reference_property_contracts' }

@[vphp.PhpExportInterface(name: 'RefPropertyContract')]
pub interface RefPropertyContract {}

const ref_contract = vphp.PhpInterfaceProperties[RefPropertyContract]{
	properties: [vphp.PhpInterfaceProperty{ name: 'score', php_type: 'int', access: .get_ref_set }]
}

@[vphp.PhpExportInterface(name: 'InheritedRefPropertyContract')]
@[vphp.PhpExtendsInterfaces(names: 'RefPropertyContract')]
pub interface InheritedRefPropertyContract {
	RefPropertyContract
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpImplements(names: 'InheritedRefPropertyContract')]
@[vphp.PhpDeclaredProperty('score', 'int')]
@[vphp.PhpDeclaredPropertyWithDefault('storage', 'int', '3')]
@[vphp.PhpDeclaredPropertyVisibility('storage', .private)]
pub struct VRefContractImplementation {}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &VRefContractImplementation) get_score() vphp.PhpReference {
	return vphp.PhpReference.hook_storage('storage')
}

@[vphp.PhpPropertySet(property: 'score')]
pub fn (target &VRefContractImplementation) set_score(value int) {
	mut updated := vphp.PhpValue.int(i64(value) * 10)
	defer {
		updated.release()
	}
	vphp.PhpReference.hook_storage('storage').set_value(updated)
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpAbstractClass]
@[vphp.PhpZendPropertyCopy]
pub struct AbstractRefProperty {}

const abstract_ref = vphp.PhpAbstractProperties[AbstractRefProperty]{
	properties: [vphp.PhpAbstractProperty{ name: 'score', php_type: 'int', access: .get_ref }]
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('AbstractRefProperty')]
@[vphp.PhpDeclaredPropertyWithDefault('score', 'int', '6')]
pub struct VRefAbstractImplementation {}

@[vphp.PhpPropertyGet(property: 'score')]
pub fn (target &VRefAbstractImplementation) get_score() vphp.PhpReference {
	return vphp.PhpReference.hook_backing()
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpImplements(names: 'InheritedRefPropertyContract')]
@[vphp.PhpDeclaredPropertyWithDefault('score', 'int', '8')]
pub struct VBackedInterfaceImplementation {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('AbstractRefProperty')]
@[vphp.PhpDeclaredPropertyWithDefault('score', 'int', '9')]
pub struct VBackedAbstractImplementation {}

@[vphp.PhpExportInterface(name: 'RefGetContract')]
pub interface RefGetContract {}

const ref_get_contract = vphp.PhpInterfaceProperties[RefGetContract]{
	properties: [vphp.PhpInterfaceProperty{ name: 'score', php_type: 'int', access: .get_ref }]
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpAbstractClass]
pub struct AbstractRefReadWrite {}

const ref_read_write = vphp.PhpAbstractProperties[AbstractRefReadWrite]{
	properties: [vphp.PhpAbstractProperty{ name: 'score', php_type: 'int', access: .get_ref_set }]
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpImplements(names: 'RefGetContract')]
@[vphp.PhpDeclaredReadonlyProperty('score', 'int', .public)]
pub struct VReadonlyRefInterface {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('AbstractRefProperty')]
@[vphp.PhpDeclaredReadonlyProperty('score', 'int', .public)]
pub struct VReadonlyRefAbstract {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpImplements(names: 'RefGetContract')]
@[vphp.PhpDeclaredPropertyWithSetVisibilityAndDefault('score', 'int', .protected, '12')]
pub struct VProtectedRefInterface {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('AbstractRefProperty')]
@[vphp.PhpDeclaredPropertyWithSetVisibilityAndDefault('score', 'int', .protected, '12')]
pub struct VProtectedRefAbstract {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpImplements(names: 'RefGetContract')]
@[vphp.PhpDeclaredPropertyWithSetVisibilityAndDefault('score', 'int', .private, '13')]
@[vphp.PhpZendPropertyCopy]
pub struct VPrivateRefInterface {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('AbstractRefProperty')]
@[vphp.PhpDeclaredPropertyWithSetVisibilityAndDefault('score', 'int', .private, '13')]
pub struct VPrivateRefAbstract {}

fn C.zend_eval_string(&char, voidptr, &char) int

// Evaluate a fixed PHP expression from a method in the native declaring scope.
fn check_private_score_scope() {
	C.zend_eval_string(c'$alias =& $this->score; $alias = 19; if ($this->score !== 19) { throw new RuntimeException("Reference write did not reach the property"); } $this->score = 7; if ($alias !== 7) { throw new RuntimeException("Property write did not reach the reference"); }', unsafe { nil },
		c'private(set) declaring scope probe')
}

@[vphp.PhpExportMethod(name: 'checkPrivateScope')]
pub fn (target &VPrivateRefInterface) check_private_scope() {
	check_private_score_scope()
}

@[vphp.PhpExportMethod(name: 'checkPrivateScope')]
pub fn (target &VPrivateRefAbstract) check_private_scope() {
	check_private_score_scope()
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VPrivateRefInterface')]
pub struct VPrivateRefInterfaceChild {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VPrivateRefAbstract')]
pub struct VPrivateRefAbstractChild {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VPrivateRefInterface')]
pub struct VPrivateRefStatefulChild {
mut:
	state int
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VPrivateRefStatefulChild')]
pub struct VPrivateRefStatefulGrandchild {}

@[vphp.PhpExportMethod(name: 'bindPrivateScore')]
pub fn (target &VPrivateRefInterfaceChild) bind_private_score() {
	bind_private_score_probe()
}

@[vphp.PhpExportMethod(name: 'writePrivateScore')]
pub fn (target &VPrivateRefInterfaceChild) write_private_score() {
	write_private_score_probe()
}

@[vphp.PhpExportMethod(name: 'bindPrivateScore')]
pub fn (target &VPrivateRefAbstractChild) bind_private_score() {
	bind_private_score_probe()
}

@[vphp.PhpExportMethod(name: 'writePrivateScore')]
pub fn (target &VPrivateRefAbstractChild) write_private_score() {
	write_private_score_probe()
}

fn bind_private_score_probe() {
	C.zend_eval_string(c'$alias =& $this->score;', unsafe { nil }, c'private(set) child binding probe')
}

fn write_private_score_probe() {
	C.zend_eval_string(c'$this->score = 3;', unsafe { nil }, c'private(set) child assignment probe')
}

@[vphp.PhpExportMethod(name: 'sharePrivateScore')]
pub fn (target &VPrivateRefInterface) share_private_score() !vphp.PhpArray {
	return share_private_score_probe()
}

@[vphp.PhpExportMethod(name: 'sharePrivateScore')]
pub fn (target &VPrivateRefAbstract) share_private_score() !vphp.PhpArray {
	return share_private_score_probe()
}

fn share_private_score_probe() !vphp.PhpArray {
	mut result := vphp.ZVal.new_null()
	if C.zend_eval_string(c"['score' => &\$this->score]", result.raw_ptr(), c'private(set) returned reference probe') != 0 {
		result.release()
		return error('could not return a reference to score')
	}
	return vphp.PhpArray.adopt_zval(result) or { error('expected an array containing the score reference') }
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\alias')]
pub fn return_caller_reference(value vphp.PhpReference) vphp.PhpReference {
	return value
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\checkedAlias')]
@[vphp.PhpReturnType(php_type: 'int')]
pub fn return_checked_reference(value vphp.PhpReference, fail bool) !vphp.PhpReference {
	if fail {
		return error('reference callback failed')
	}
	return value
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\compoundAlias')]
@[vphp.PhpReturnType(php_type: '(Iterator&Countable)|int')]
pub fn return_compound_reference(value vphp.PhpReference) vphp.PhpReference {
	return value
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\invalidAlias')]
pub fn return_invalid_reference() vphp.PhpReference {
	return vphp.PhpReference{}
}

@[vphp.PhpExportClass(name: '')]
pub struct RefReturnBox {}

@[vphp.PhpExportMethod(name: 'staticAlias')]
pub fn RefReturnBox.static_alias(value vphp.PhpReference) vphp.PhpReference {
	return value
}

@[vphp.PhpExportMethod(name: 'compoundMethod')]
@[vphp.PhpArgType('value', '(Iterator&Countable)|int')]
@[vphp.PhpReturnType(php_type: '(Iterator&Countable)|int')]
pub fn (target &RefReturnBox) compound_method(value vphp.PhpReference) vphp.PhpReference {
	return value
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('RefReturnBox')]
pub struct RefReturnChild {}

@[vphp.PhpExportMethod(name: 'compoundMethod')]
@[vphp.PhpArgType('value', '(Iterator&Countable)|int')]
@[vphp.PhpReturnType(php_type: '(Iterator&Countable)|int')]
pub fn (target &RefReturnChild) compound_method(value vphp.PhpReference) vphp.PhpReference {
	return value
}

@[vphp.PhpExportMethod(name: 'scoreReference')]
@[vphp.PhpReturnType(php_type: 'int')]
pub fn (target &VPrivateRefInterface) score_reference(ctx vphp.Context) !vphp.PhpReference {
	if ctx.num_args() != 0 {
		return error('scoreReference takes no PHP arguments')
	}
	return private_score_reference()
}

@[vphp.PhpExportMethod(name: 'scoreReference')]
@[vphp.PhpReturnType(php_type: 'int')]
pub fn (target &VPrivateRefAbstract) score_reference() !vphp.PhpReference {
	return private_score_reference()
}

fn private_score_reference() !vphp.PhpReference {
	return vphp.PhpReference.this_property('score')
}

@[vphp.PhpExportInterface(name: 'RefMethodContract')]
pub interface RefMethodContract {
	slot(value vphp.PhpReference) vphp.PhpReference
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpAbstractClass]
pub struct RefMethodBase {}

@[vphp.PhpExportMethod(name: 'slot')]
@[vphp.PhpAbstractMethod]
pub fn (target &RefMethodBase) slot(value vphp.PhpReference) vphp.PhpReference {
	return value
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('RefMethodBase')]
@[vphp.PhpImplements(names: 'RefMethodContract')]
pub struct RefMethodImplementation {}

@[vphp.PhpExportMethod(name: 'slot')]
pub fn (target &RefMethodImplementation) slot(value vphp.PhpReference) vphp.PhpReference {
	return value
}

@[vphp.PhpExportTrait(name: 'RefMethodTrait')]
struct RefMethodTrait {}

@[vphp.PhpExportMethod(name: 'slot')]
pub fn (target &RefMethodTrait) slot(value vphp.PhpReference) vphp.PhpReference {
	return value
}

@[vphp.PhpExportTrait(name: 'ComposedRefMethodTrait')]
struct ComposedRefMethodTrait {}

const ref_method_trait_rules = vphp.PhpTraitRules[ComposedRefMethodTrait]{
	uses:        [RefMethodTrait{}]
	adaptations: [vphp.PhpTraitAdaptation{
		source: RefMethodTrait{}
		method: 'slot'
		alias:  'trait_slot'
	}]
}

@[params]
struct RefClosureParams {
	bag  vphp.PhpArray
	fail bool = false
}

fn reference_from_bag(bag vphp.ZVal) !vphp.PhpReference {
	return vphp.PhpReference.must_from_zval(bag.get('score')!)
}

fn reference_struct_closure(params RefClosureParams) vphp.PhpReference {
	return reference_from_bag(params.bag.to_zval()) or { vphp.PhpReference{} }
}

fn checked_reference_struct_closure(params RefClosureParams) !vphp.PhpReference {
	if params.fail {
		return error('struct reference callback failed')
	}
	return reference_from_bag(params.bag.to_zval())
}

fn reference_variadic_closure(values ...vphp.ZVal) vphp.PhpReference {
	if values.len == 0 {
		return vphp.PhpReference{}
	}
	return reference_from_bag(values[0]) or { vphp.PhpReference{} }
}

fn checked_reference_variadic_closure(values ...vphp.ZVal) !vphp.PhpReference {
	if values.len == 0 {
		return error('variadic reference callback requires a bag')
	}
	return reference_from_bag(values[0])
}

@[vphp.PhpExportFunction(name: 'referenceStructClosure')]
pub fn make_reference_struct_closure() fn (RefClosureParams) vphp.PhpReference {
	return reference_struct_closure
}

@[vphp.PhpExportFunction(name: 'checkedReferenceStructClosure')]
pub fn make_checked_reference_struct_closure() fn (RefClosureParams) !vphp.PhpReference {
	return checked_reference_struct_closure
}

@[vphp.PhpExportFunction(name: 'referenceVariadicClosure')]
pub fn make_reference_variadic_closure() fn (...vphp.ZVal) vphp.PhpReference {
	return reference_variadic_closure
}

@[vphp.PhpExportFunction(name: 'checkedReferenceVariadicClosure')]
pub fn make_checked_reference_variadic_closure() fn (...vphp.ZVal) !vphp.PhpReference {
	return checked_reference_variadic_closure
}

@[params]
struct DirectRefClosureParams {
	value vphp.PhpReference
	other ?vphp.PhpReference = none
	step  int                = 3
}

fn direct_struct_reference(params DirectRefClosureParams) vphp.PhpReference {
	params.value.set(vphp.ZVal.new_int(params.value.deref().to_i64() + params.step))
	if other := params.other {
		other.set(vphp.ZVal.new_int(100))
	}
	return params.value
}

fn direct_variadic_reference(values ...vphp.PhpReference) !vphp.PhpReference {
	if values.len == 0 {
		return error('reference closure needs a variable')
	}
	increment_closure_references(...values)
	return values[0]
}

fn increment_closure_references(values ...vphp.PhpReference) {
	for value in values {
		value.set(vphp.ZVal.new_int(value.deref().to_i64() + 1))
	}
}

@[vphp.PhpExportFunction(name: 'directStructReferenceClosure')]
pub fn make_direct_struct_reference_closure() fn (DirectRefClosureParams) vphp.PhpReference {
	return direct_struct_reference
}

@[vphp.PhpExportFunction(name: 'directVariadicReferenceClosure')]
pub fn make_direct_variadic_reference_closure() fn (...vphp.PhpReference) !vphp.PhpReference {
	return direct_variadic_reference
}

@[vphp.PhpExportFunction(name: 'updateVariadicReferenceClosure')]
pub fn make_update_variadic_reference_closure() fn (...vphp.PhpReference) {
	return increment_closure_references
}

@[vphp.PhpExportFunction(name: 'referenceFromPhpCallable')]
pub fn reference_from_php_callable(callback vphp.PhpCallable) !vphp.PhpReference {
	return callback.call_reference()
}

@[vphp.PhpExportFunction(name: 'referenceFromPhpClosure')]
pub fn reference_from_php_closure(callback vphp.PhpCallable, value vphp.PhpReference) !vphp.PhpReference {
	return callback.to_closure().call_reference(value)
}

@[vphp.PhpExportFunction(name: 'referenceFromNamedPhpFunction')]
pub fn reference_from_named_php_function(name string, value vphp.PhpReference) !vphp.PhpReference {
	return vphp.PhpFunction.named(name).call_reference(value)
}

@[vphp.PhpExportFunction(name: 'writePhpCallbackReference')]
pub fn write_php_callback_reference(callback vphp.PhpCallable, value vphp.PhpValue) ! {
	mut reference := callback.call_reference()!
	defer {
		reference.release()
	}
	if !reference.is_owned() {
		return error('expected a request-owned callback reference')
	}
	reference.set_value(value)
}

@[vphp.PhpExportFunction(name: 'referenceFromPhpMethod')]
pub fn reference_from_php_method(target vphp.PhpObject, name string, values ...vphp.PhpReference) !vphp.PhpReference {
	args := values.map(vphp.PhpArgInput(it))
	return target.method_reference(name, ...args)
}

@[vphp.PhpExportFunction(name: 'referenceFromPhpStaticMethod')]
pub fn reference_from_php_static_method(class_name string, name string, values ...vphp.PhpReference) !vphp.PhpReference {
	args := values.map(vphp.PhpArgInput(it))
	return vphp.PhpClass.named(class_name).static_method_reference(name, ...args)
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpDeclaredPropertyWithDefault('stored', 'int', '11')]
@[vphp.PhpDeclaredProperty('hidden', 'int')]
@[vphp.PhpDeclaredPropertyVisibility('hidden', .private)]
@[vphp.PhpDeclaredReadonlyProperty('locked', 'int', .public)]
pub struct ZendReferenceStorage {
pub mut:
	mirrored int
}

@[vphp.PhpExportMethod(name: 'storageReference')]
pub fn (target &ZendReferenceStorage) storage_reference(name string) !vphp.PhpReference {
	return vphp.PhpReference.this_property(name)
}

@[vphp.PhpExportFunction(name: 'referenceWithoutReceiver')]
pub fn reference_without_receiver() !vphp.PhpReference {
	return vphp.PhpReference.this_property('stored')
}

@[vphp.PhpExportMethod(name: 'borrowPrivateScore')]
pub fn (target &VPrivateRefInterfaceChild) borrow_private_score() !vphp.PhpReference {
	return vphp.PhpReference.this_property('score')
}

@[vphp.PhpExportMethod(name: 'borrowPrivateScore')]
pub fn (target &VPrivateRefAbstractChild) borrow_private_score() !vphp.PhpReference {
	return vphp.PhpReference.this_property('score')
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpDeclaredStaticPropertyWithSetVisibilityAndDefault('restricted', 'int', .private, '19')]
pub struct VStaticReferenceStorage {
pub mut:
	counter int       @[vphp.PhpStaticProperty]
	payload vphp.ZVal @[vphp.PhpStaticProperty]
}

@[vphp.PhpExportMethod(name: 'staticStorageReference')]
pub fn VStaticReferenceStorage.static_storage_reference(name string) !vphp.PhpReference {
	return vphp.PhpReference.static_property(name)
}

@[vphp.PhpExportMethod(name: 'lateStaticReference')]
pub fn (target &VStaticReferenceStorage) late_static_reference(name string) !vphp.PhpReference {
	return vphp.PhpReference.static_property(name)
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VStaticReferenceStorage')]
pub struct VStaticReferenceStorageChild {}

@[vphp.PhpExportMethod(name: 'borrowRestrictedStatic')]
pub fn VStaticReferenceStorageChild.borrow_restricted_static() !vphp.PhpReference {
	return vphp.PhpReference.static_property('restricted')
}

@[vphp.PhpExportClass(name: '')]
pub struct VStaticReferenceShadow {}

struct VStaticReferenceShadowFields {
mut:
	mirrored int = 17
}

const reference_shadow_table = vphp.PhpStaticTable[VStaticReferenceShadow, VStaticReferenceShadowFields]{
	values: VStaticReferenceShadowFields{}
}

@[vphp.PhpExportMethod(name: 'shadowReference')]
pub fn VStaticReferenceShadow.shadow_reference() !vphp.PhpReference {
	return vphp.PhpReference.static_property('mirrored')
}

@[vphp.PhpExportFunction(name: 'staticReferenceWithoutScope')]
pub fn static_reference_without_scope() !vphp.PhpReference {
	return vphp.PhpReference.static_property('counter')
}

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpDeclaredStaticPropertyWithDefault('trait_count', 'int', '0')]
@[vphp.PhpDeclaredStaticProperty(name: 'trait_required', php_type: 'int')]
pub struct VNativeStaticStorageTrait {}

@[vphp.PhpExportMethod(name: 'traitCounterReference')]
pub fn VNativeStaticStorageTrait.trait_counter_reference() !vphp.PhpReference {
	return vphp.PhpReference.static_property('trait_count')
}

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpDeclaredStaticPropertyWithDefault('trait_rate', 'float', '1')]
pub struct VNumericNativeStaticStorageTrait {}

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpDeclaredStaticPropertyWithDefault('trait_rate', 'float', '1.0')]
pub struct VAdditionalNativeStaticStorageTrait {}

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpDeclaredStaticPropertyWithDefault('trait_choice', 'int|string', '7')]
@[vphp.PhpDeclaredStaticProperty('trait_nullable', '?int')]
pub struct VNativeUnionStaticStorageTrait {}

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpDeclaredStaticPropertyWithDefault('trait_choice', 'string|int', '7')]
@[vphp.PhpDeclaredStaticProperty('trait_nullable', 'int|null')]
pub struct VReorderedUnionStaticStorageTrait {}

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpDeclaredStaticPropertyWithDefault('trait_dnf', '(ArrayAccess&Countable)|int', '11')]
pub struct VNativeDnfStaticStorageTrait {}

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpDeclaredStaticPropertyWithDefault('trait_dnf', 'int|(Countable&ArrayAccess)', '11')]
pub struct VReorderedDnfStaticStorageTrait {}

@[vphp.PhpExportTrait(name: '')]
pub struct VCombinedNativeStaticStorageTrait {}

const native_static_composition = vphp.PhpTraitRules[VCombinedNativeStaticStorageTrait]{
	uses:        [vphp.PhpNativeTraitSource(VNativeStaticStorageTrait{}),
		VNumericNativeStaticStorageTrait{}, VAdditionalNativeStaticStorageTrait{},
		VNativeUnionStaticStorageTrait{}, VReorderedUnionStaticStorageTrait{},
		VNativeDnfStaticStorageTrait{}, VReorderedDnfStaticStorageTrait{}]
	adaptations: [
		vphp.PhpTraitAdaptation{
			source: VNativeStaticStorageTrait{}
			method: 'traitCounterReference'
			alias:  'combinedCounterReference'
		},
	]
}

@[vphp.PhpExportTrait(name: '')]
pub struct VSignatureRequirementA {}

@[vphp.PhpExportMethod(name: 'selectValue')]
@[vphp.PhpAbstractMethod]
@[vphp.PhpArgType('value', 'int|string')]
@[vphp.PhpReturnType(php_type: '(ArrayAccess&Countable)|int')]
pub fn (trait VSignatureRequirementA) select_value(value vphp.ZVal) vphp.ZVal {
	return value
}

@[vphp.PhpExportMethod(name: 'numericValue')]
@[vphp.PhpAbstractMethod]
pub fn (trait VSignatureRequirementA) numeric_value(value int) int {
	return value
}

@[vphp.PhpExportTrait(name: '')]
pub struct VSignatureRequirementB {}

@[vphp.PhpExportMethod(name: 'selectValue')]
@[vphp.PhpAbstractMethod]
@[vphp.PhpArgType('value', 'string|int')]
@[vphp.PhpReturnType(php_type: 'int|(Countable&ArrayAccess)')]
pub fn (trait VSignatureRequirementB) select_value(value vphp.PhpValue) vphp.PhpValue {
	return value
}

@[vphp.PhpExportMethod(name: 'numericValue')]
@[vphp.PhpAbstractMethod]
pub fn (trait VSignatureRequirementB) numeric_value(value i64) i64 {
	return value
}

@[vphp.PhpExportTrait(name: '')]
pub struct VCombinedSignatureRequirements {}

const combined_signature_requirements = vphp.PhpTraitRules[VCombinedSignatureRequirements]{
	uses: [vphp.PhpNativeTraitSource(VSignatureRequirementA{}), VSignatureRequirementB{}]
}

@[vphp.PhpExportEnum(name: '')]
pub enum VTraitConstantCase {
	ready
}

struct TraitConstantValues {
	ratio f64
	limit int
	mode  VTraitConstantCase
}

const trait_constant_values_a = TraitConstantValues{
	ratio: 1.25
	limit: 16
	mode:  .ready
}

const trait_constant_values_b = TraitConstantValues{
	ratio: 1.250
	limit: 0x10
	mode:  VTraitConstantCase.ready
}

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpClassConstants('trait_constant_values_a')]
pub struct VConstantTraitA {}

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpClassConstants('trait_constant_values_b')]
pub struct VConstantTraitB {}

@[vphp.PhpExportTrait(name: '')]
pub struct VCombinedConstantTraits {}

const combined_constant_traits = vphp.PhpTraitRules[VCombinedConstantTraits]{
	uses: [vphp.PhpNativeTraitSource(VConstantTraitA{}), VConstantTraitB{}]
}

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpDeclaredProperty(name: 'typed_slot', php_type: 'mixed')]
@[php_prop: 'untyped_slot']
pub struct VPropertyTypeTraitA {}

@[vphp.PhpExportTrait(name: '')]
@[vphp.PhpDeclaredProperty(name: 'typed_slot', php_type: 'mixed')]
@[php_prop: 'untyped_slot:mixed']
pub struct VPropertyTypeTraitB {}

@[vphp.PhpExportTrait(name: '')]
pub struct VCombinedPropertyTypeTraits {}

const combined_property_type_traits = vphp.PhpTraitRules[VCombinedPropertyTypeTraits]{
	uses: [vphp.PhpNativeTraitSource(VPropertyTypeTraitA{}), VPropertyTypeTraitB{}]
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpDeclaredProperty('slot', 'mixed')]
@[vphp.PhpDeclaredPropertyWithDefault('nullable_slot', 'mixed', 'null')]
pub struct VClassMixedBase {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VClassMixedBase')]
pub struct VClassMixedInherited {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VClassMixedInherited')]
@[vphp.PhpDeclaredPropertyWithDefault('slot', 'mixed', '7')]
pub struct VClassMixedRedeclared {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpDeclaredProperty(name: 'slot', php_type: '')]
pub struct VClassUntypedBase {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VClassUntypedBase')]
@[php_prop: 'slot']
pub struct VClassUntypedRedeclared {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpDeclaredPropertyWithDefault('choice', 'int|string', '7')]
@[vphp.PhpDeclaredProperty('optional', '?int')]
pub struct VClassTypedBase {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VClassTypedBase')]
pub struct VClassTypedInherited {}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VClassTypedInherited')]
@[vphp.PhpDeclaredPropertyWithDefault('choice', 'string|int', '9')]
@[vphp.PhpDeclaredProperty('optional', 'int|null')]
pub struct VClassTypedRedeclared {}

fn scalar_union_result(value vphp.PhpValue, failure string) vphp.PhpValue {
	return match failure {
		'array' { vphp.PhpValue.empty_array() }
		'null' { vphp.PhpValue.null() }
		'float' { vphp.PhpValue.double(19.0) }
		else { value }
	}
}

@[vphp.PhpExportFunction(name: 'vphpFixtureScalarUnion')]
@[vphp.PhpArgType('value', 'int|string')]
@[vphp.PhpReturnType(php_type: 'int|string')]
pub fn fixture_scalar_union(value vphp.PhpValue, failure string) vphp.PhpValue {
	return scalar_union_result(value, failure)
}

@[vphp.PhpExportClass(name: '')]
pub struct VPhpValueScalarUnion {}

struct PhpValueScalarUnionConstants {
	default_value int
}

const php_value_scalar_union_constants = vphp.PhpConstantTable[VPhpValueScalarUnion, PhpValueScalarUnionConstants]{
	values: PhpValueScalarUnionConstants{ default_value: 53 }
}

@[vphp.PhpExportMethod(name: 'scalarUnion')]
@[vphp.PhpArgType('value', 'int|string')]
@[vphp.PhpReturnType(php_type: 'int|string')]
pub fn (receiver &VPhpValueScalarUnion) scalar_union(value vphp.PhpValue, failure string) vphp.PhpValue {
	return scalar_union_result(value, failure)
}

@[vphp.PhpExportMethod(name: 'staticScalarUnion')]
@[vphp.PhpArgType('value', 'int|string')]
@[vphp.PhpReturnType(php_type: 'int|string')]
pub fn VPhpValueScalarUnion.static_scalar_union(value vphp.PhpValue, failure string) vphp.PhpValue {
	return scalar_union_result(value, failure)
}

fn dnf_result(value vphp.PhpValue, replacement vphp.PhpValue) vphp.PhpValue {
	// A bool selects a null return independently of the DNF input.
	if replacement.is_bool() {
		return vphp.PhpValue.null()
	}
	return if replacement.is_null() { value } else { replacement }
}

@[vphp.PhpExportFunction(name: 'vphpFixtureDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int')]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int')]
pub fn fixture_dnf(value vphp.PhpValue, replacement vphp.PhpValue) vphp.PhpValue {
	return dnf_result(value, replacement)
}

@[vphp.PhpExportMethod(name: 'dnfValue')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int')]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int')]
pub fn (receiver &VPhpValueScalarUnion) dnf_value(value vphp.PhpValue, replacement vphp.PhpValue) vphp.PhpValue {
	return dnf_result(value, replacement)
}

@[vphp.PhpExportMethod(name: 'staticDnfValue')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int')]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int')]
pub fn VPhpValueScalarUnion.static_dnf_value(value vphp.PhpValue, replacement vphp.PhpValue) vphp.PhpValue {
	return dnf_result(value, replacement)
}

@[vphp.PhpExportFunction(name: 'vphpFixtureNullableDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int|null')]
pub fn fixture_nullable_dnf(value vphp.PhpValue, replacement vphp.PhpValue) vphp.PhpValue {
	return dnf_result(value, replacement)
}

@[vphp.PhpExportMethod(name: 'nullableDnfValue')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int|null')]
pub fn (receiver &VPhpValueScalarUnion) nullable_dnf_value(value vphp.PhpValue, replacement vphp.PhpValue) vphp.PhpValue {
	return dnf_result(value, replacement)
}

@[vphp.PhpExportMethod(name: 'staticNullableDnfValue')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int|null')]
pub fn VPhpValueScalarUnion.static_nullable_dnf_value(value vphp.PhpValue, replacement vphp.PhpValue) vphp.PhpValue {
	return dnf_result(value, replacement)
}

fn defaulted_nullable_dnf_result(value vphp.PhpValue, label string) string {
	kind := if value.is_null() {
		'null'
	} else if integer := value.as_int() {
		'int:${integer.value()}'
	} else {
		'object'
	}
	return '${kind}:${label}'
}

@[vphp.PhpExportFunction(name: 'vphpFixtureDefaultedNullableDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=null,label='default'")]
pub fn fixture_defaulted_nullable_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportMethod(name: 'defaultedNullableDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=null,label='default'")]
pub fn (receiver &VPhpValueScalarUnion) defaulted_nullable_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportMethod(name: 'staticDefaultedNullableDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=null,label='default'")]
pub fn VPhpValueScalarUnion.static_defaulted_nullable_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportFunction(name: 'vphpFixtureIntegerDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=37,label='default'")]
pub fn fixture_integer_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportMethod(name: 'integerDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=37,label='default'")]
pub fn (receiver &VPhpValueScalarUnion) integer_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportMethod(name: 'staticIntegerDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=37,label='default'")]
pub fn VPhpValueScalarUnion.static_integer_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportFunction(name: 'vphpFixtureConstantDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=PHP_INT_SIZE,label='default'")]
pub fn fixture_constant_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportMethod(name: 'constantDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=PHP_INT_SIZE,label='default'")]
pub fn (receiver &VPhpValueScalarUnion) constant_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportMethod(name: 'staticConstantDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=PHP_INT_SIZE,label='default'")]
pub fn VPhpValueScalarUnion.static_constant_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportMethod(name: 'selfConstantDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=self::DEFAULT_VALUE,label='default'")]
pub fn (receiver &VPhpValueScalarUnion) self_constant_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportMethod(name: 'staticSelfConstantDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=self::DEFAULT_VALUE,label='default'")]
pub fn VPhpValueScalarUnion.static_self_constant_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportClass(name: '')]
@[vphp.PhpExtends('VPhpValueScalarUnion')]
pub struct VPhpParentDnfDefaults {}

const php_value_parent_dnf_constants = vphp.PhpConstantTable[VPhpParentDnfDefaults, PhpValueScalarUnionConstants]{
	values: PhpValueScalarUnionConstants{ default_value: 71 }
}

@[vphp.PhpExportMethod(name: 'parentConstantDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=parent::DEFAULT_VALUE,label='default'")]
pub fn (receiver &VPhpParentDnfDefaults) parent_constant_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportMethod(name: 'staticParentConstantDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=parent::DEFAULT_VALUE,label='default'")]
pub fn VPhpParentDnfDefaults.static_parent_constant_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportClass(name: 'VPHP\\ReferenceDefaults\\Limits')]
pub struct VPhpNamespacedDnfLimits {}

const php_value_namespaced_dnf_constants = vphp.PhpConstantTable[VPhpNamespacedDnfLimits, PhpValueScalarUnionConstants]{
	values: PhpValueScalarUnionConstants{ default_value: 127 }
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\namespacedConstantDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=VPHP\\ReferenceDefaults\\Limits::DEFAULT_VALUE,label='default'")]
pub fn fixture_namespaced_constant_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportInterface(name: 'VPHP\\ReferenceProbe\\OptionsContract')]
pub interface VOptionsContract {
	external_options(options defaults.EnumDefaultOptions) vphp.PhpArray
	computed_options(options defaults.ComputedInterfaceOptions) string
	renamed_options(request_id int, options defaults.EnumDefaultOptions) string
}

@[vphp.PhpExportInterface(name: 'VPHP\\ReferenceProbe\\InheritedTypedValueContract')]
pub interface VInheritedTypedValueContract {
	defaults.VTypedValueContract
}

@[vphp.PhpExportInterface(name: 'VPHP\\ReferenceProbe\\ContractBroker')]
pub interface VContractBroker {
	forward(source defaults.VTypedValueContract, fallback ?defaults.VTypedValueContract, rest ...defaults.VTypedValueContract) defaults.VTypedValueContract
}

@[vphp.PhpExportClass(name: 'VPHP\\ReferenceProbe\\ContractBrokerImpl')]
@[vphp.PhpImplements(names: 'VPHP\\ReferenceProbe\\ContractBroker')]
pub struct VContractBrokerImpl {}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\tryValueContract')]
pub fn try_value_contract(value vphp.PhpObject) ?vphp.PhpInterface[defaults.VTypedValueContract] {
	return vphp.PhpInterface.from_object[defaults.VTypedValueContract](value) or { return none }
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\echoExternalContract')]
pub fn echo_external_contract(value vphp.PhpInterface[defaults.VExternalContract]) vphp.PhpInterface[defaults.VExternalContract] {
	return value
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\tryExternalContract')]
pub fn try_external_contract(value vphp.PhpObject) ?vphp.PhpInterface[defaults.VExternalContract] {
	return vphp.PhpInterface.from_object[defaults.VExternalContract](value) or { return none }
}

type ExternalContract = defaults.ExternalContract

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\echoExternalAlias')]
pub fn echo_external_alias(value ExternalContract) ExternalContract {
	return value
}

@[params]
pub struct ExternalContractOptions {
pub:
	value ?ExternalContract = none
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\externalContractOption')]
pub fn external_contract_option(options ExternalContractOptions) ?ExternalContract {
	return options.value
}

@[vphp.PhpExportMethod(name: 'externalContractTail')]
pub fn (receiver &VContractBrokerImpl) external_contract_tail(values ...?ExternalContract) ?ExternalContract {
	if values.len == 0 {
		return none
	}
	value := values.last() or { return none }
	return value
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeExternalAliasTail')]
pub fn make_external_alias_tail() fn (values ...?ExternalContract) ?ExternalContract {
	return fn (values ...?ExternalContract) ?ExternalContract {
		return if values.len == 0 { none } else { values.last() }
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeContractIdentity')]
pub fn make_contract_identity() fn (value vphp.PhpInterface[defaults.VTypedValueContract]) vphp.PhpInterface[defaults.VTypedValueContract] {
	return fn (value vphp.PhpInterface[defaults.VTypedValueContract]) vphp.PhpInterface[defaults.VTypedValueContract] {
		return value
	}
}

@[params]
pub struct ContractClosureOptions {
pub:
	value ?vphp.PhpInterface[defaults.VTypedValueContract] = none
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeContractOptions')]
pub fn make_contract_options() fn (ContractClosureOptions) ?vphp.PhpInterface[defaults.VTypedValueContract] {
	return fn (options ContractClosureOptions) ?vphp.PhpInterface[defaults.VTypedValueContract] {
		return options.value
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeContractTail')]
pub fn make_contract_tail() fn (values ...?vphp.PhpInterface[defaults.VTypedValueContract]) ?vphp.PhpInterface[defaults.VTypedValueContract] {
	return fn (values ...?vphp.PhpInterface[defaults.VTypedValueContract]) ?vphp.PhpInterface[defaults.VTypedValueContract] {
		return if values.len > 0 { values.last() } else { none }
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeContractChoice')]
pub fn make_contract_choice() fn (first vphp.PhpInterface[defaults.VTypedValueContract], rest ...vphp.PhpInterface[defaults.VTypedValueContract]) vphp.PhpInterface[defaults.VTypedValueContract] {
	return fn (first vphp.PhpInterface[defaults.VTypedValueContract], rest ...vphp.PhpInterface[defaults.VTypedValueContract]) vphp.PhpInterface[defaults.VTypedValueContract] {
		return if rest.len > 0 { rest.last() } else { first }
	}
}

@[vphp.PhpExportMethod(name: '')]
pub fn (receiver &VContractBrokerImpl) forward(source vphp.PhpInterface[defaults.VTypedValueContract], fallback ?vphp.PhpInterface[defaults.VTypedValueContract], rest ...vphp.PhpInterface[defaults.VTypedValueContract]) vphp.PhpInterface[defaults.VTypedValueContract] {
	if rest.len > 0 {
		return rest.last()
	}
	return fallback or { source }
}

const options_contract_methods = vphp.PhpInterfaceMethods[VOptionsContract]{
	methods: [
		vphp.PhpInterfaceMethod{
			v_name:     'renamed_options'
			php_name:   'renamedOptions'
			static_:    true
			parameters: [
				vphp.PhpInterfaceParameter{ v_name: 'request_id', php_name: 'request' }
				vphp.PhpInterfaceParameter{
					v_name:     'label'
					php_name:   'message'
					attributes: [vphp.PhpAttributeSpec{ name: 'VphpInterfaceProbeTag', args: '"parameter"' }]
				},
			]
		},
	]
}

const options_contract_defaults = vphp.PhpInterfaceDefaults[VOptionsContract]{
	defaults: [
		vphp.PhpInterfaceDefault{
			method:        'computed_options'
			parameter:     'label'
			default_value: "'contract'"
		},
		vphp.PhpInterfaceDefault{
			method:        'renamed_options'
			parameter:     'label'
			default_value: "'external'"
		},
	]
}

@[vphp.PhpExportClass(name: 'VPHP\\ReferenceProbe\\DnfDefaults')]
pub struct VPhpNamespacedDnfDefaults {}

@[vphp.PhpExportMethod(name: 'namespacedConstantDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=VPHP\\ReferenceDefaults\\Limits::DEFAULT_VALUE,label='default'")]
pub fn (receiver &VPhpNamespacedDnfDefaults) namespaced_constant_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportMethod(name: 'staticNamespacedConstantDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=VPHP\\ReferenceDefaults\\Limits::DEFAULT_VALUE,label='default'")]
pub fn VPhpNamespacedDnfDefaults.static_namespaced_constant_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportConstant(name: 'VPHP\\ReferenceDefaults\\DNF_DEFAULT')]
const php_namespaced_global_dnf_default = 149

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\namespacedGlobalDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=VPHP\\ReferenceDefaults\\DNF_DEFAULT,label='default'")]
pub fn fixture_namespaced_global_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportMethod(name: 'namespacedGlobalDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=VPHP\\ReferenceDefaults\\DNF_DEFAULT,label='default'")]
pub fn (receiver &VPhpNamespacedDnfDefaults) namespaced_global_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportMethod(name: 'staticNamespacedGlobalDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=VPHP\\ReferenceDefaults\\DNF_DEFAULT,label='default'")]
pub fn VPhpNamespacedDnfDefaults.static_namespaced_global_default_dnf(value vphp.PhpValue, label string) string {
	return defaulted_nullable_dnf_result(value, label)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\enumCaseDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=VPHP\\ReferenceDefaults\\DnfDefault::DefaultValue,label='default'")]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int|null')]
pub fn fixture_enum_case_default_dnf(value vphp.PhpValue, label string) vphp.PhpValue {
	return value
}

@[vphp.PhpExportMethod(name: 'enumCaseDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=VPHP\\ReferenceDefaults\\DnfDefault::DefaultValue,label='default'")]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int|null')]
pub fn (receiver &VPhpNamespacedDnfDefaults) enum_case_default_dnf(value vphp.PhpValue, label string) vphp.PhpValue {
	return value
}

@[vphp.PhpExportMethod(name: 'staticEnumCaseDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=VPHP\\ReferenceDefaults\\DnfDefault::DefaultValue,label='default'")]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int|null')]
pub fn VPhpNamespacedDnfDefaults.static_enum_case_default_dnf(value vphp.PhpValue, label string) vphp.PhpValue {
	return value
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\exportedEnumCaseDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=VPHP\\ReferenceDefaults\\ExportedDnfDefault::default_value,label='default'")]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int|null')]
pub fn fixture_exported_enum_case_default_dnf(value vphp.PhpValue, label string) vphp.PhpValue {
	return value
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\lastDnfArgument')]
@[vphp.PhpArgType('values', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int|null')]
pub fn fixture_last_dnf_argument(values ...vphp.PhpValue) vphp.PhpValue {
	return if values.len == 0 { vphp.PhpNull.value().to_value() } else { values.last() }
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\captureNamedDnf')]
@[vphp.PhpArgType('values', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefault('prefix', "'default'")]
pub fn fixture_capture_named_dnf(prefix string, values ...vphp.PhpArg) vphp.PhpArray {
	mut arguments := vphp.PhpArray.new()
	for arg in values {
		if key := arg.variadic_name() {
			arguments.set_value(key, arg.value)
		} else {
			arguments.next(arg.value)
		}
	}
	mut result := vphp.PhpArray.new()
	result.string('prefix', prefix)
	result.set('values', arguments)
	return result
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeNamedTail')]
pub fn fixture_make_named_tail() fn (values ...vphp.PhpArg) vphp.PhpArray {
	return fn (values ...vphp.PhpArg) vphp.PhpArray {
		return fixture_capture_named_dnf('default', ...values)
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeNamedTailWithPrefix')]
pub fn fixture_make_named_tail_with_prefix() fn (prefix ?string, values ...vphp.PhpArg) vphp.PhpArray {
	return fn (prefix ?string, values ...vphp.PhpArg) vphp.PhpArray {
		return fixture_capture_named_dnf(prefix or { 'default' }, ...values)
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\callWithArgumentArray')]
pub fn fixture_call_with_argument_array(callback vphp.PhpCallable, arguments vphp.PhpArray) vphp.PhpValue {
	return callback.to_closure().invoke_args(arguments)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\recoverCallback')]
pub fn fixture_recover_callback(callback vphp.PhpCallable, recover vphp.PhpCallable, rethrow bool) vphp.PhpValue {
	mut result := callback.invoke()
	if mut exception := vphp.PhpException.take_current() {
		result.release()
		defer {
			exception.release()
		}
		result = recover.invoke(exception)
		if rethrow && !vphp.has_exception() {
			result.release()
			exception.throw()
			return vphp.PhpValue.null()
		}
	}
	return result
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\appendException')]
pub fn fixture_append_exception(primary vphp.PhpThrowable, secondary vphp.PhpThrowable) {
	primary.append_previous(secondary)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\echoThrowable')]
pub fn fixture_echo_throwable(value vphp.PhpThrowable) vphp.PhpThrowable {
	return value
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeThrowableIdentity')]
pub fn fixture_make_throwable_identity() fn (value ?vphp.PhpThrowable) ?vphp.PhpThrowable {
	return fn (value ?vphp.PhpThrowable) ?vphp.PhpThrowable {
		return value
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeThrowableSelector')]
pub fn fixture_make_throwable_selector() fn (items ...vphp.PhpThrowable) ?vphp.PhpThrowable {
	return fn (items ...vphp.PhpThrowable) ?vphp.PhpThrowable {
		return if items.len == 0 { none } else { ?vphp.PhpThrowable(items.last()) }
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\forwardCallbackArguments')]
pub fn fixture_forward_callback_arguments(callback vphp.PhpCallable, arguments ...vphp.PhpArg) vphp.PhpValue {
	return callback.invoke_forwarded(arguments)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\callReferenceWithArgumentArray')]
pub fn fixture_call_reference_with_argument_array(callback vphp.PhpCallable, arguments vphp.PhpArray) !vphp.PhpReference {
	return callback.call_reference_args(arguments)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\closureReferenceArgs')]
@[vphp.PhpArgType('callback', 'Closure')]
pub fn fixture_closure_reference_args(callback vphp.PhpCallable, arguments vphp.PhpArray) !vphp.PhpReference {
	return callback.to_closure().call_reference_args(arguments)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\callArgsByValue')]
pub fn fixture_call_args_by_value(callback vphp.PhpCallable, arguments vphp.PhpArray) vphp.PhpValue {
	mut result := callback.invoke_args_by_value(arguments)
	return result.move_to_request_scope()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\callPositionalByValue')]
pub fn fixture_call_positional_by_value(callback vphp.PhpCallable, value vphp.PhpValue) vphp.PhpValue {
	mut result := callback.invoke_by_value(value)
	return result.move_to_request_scope()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\storeRetainedCallable')]
pub fn fixture_store_retained_callable(callback vphp.PhpCallable) vphp.PhpValue {
	mut retained := callback.retain()
	defer {
		retained.release()
	}
	mut array := vphp.PhpArray.new()
	array.set_callable('callback', retained)
	mut result := array.take_value()
	return result.move_to_request_scope()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\withReferencedObjectResult')]
pub fn fixture_with_referenced_object_result(callback vphp.PhpCallable, rebind vphp.PhpCallable) !vphp.PhpValue {
	return callback.with_result[vphp.PhpObject, vphp.PhpValue](fn [rebind] (object vphp.PhpObject) vphp.PhpValue {
		mut replaced := rebind.invoke()
		replaced.release()
		return object.to_value().to_request_scoped()
	})
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\callFunctionArgs')]
pub fn fixture_call_function_args(name string, arguments vphp.PhpArray) vphp.PhpValue {
	return vphp.PhpFunction.named(name).invoke_args(arguments)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\callMethodArgs')]
pub fn fixture_call_method_args(receiver vphp.PhpObject, method string, arguments vphp.PhpArray) vphp.PhpValue {
	return receiver.call_method_args(method, arguments)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\readMethodByValue')]
pub fn fixture_read_method_by_value(receiver vphp.PhpObject, method string, rebind vphp.PhpCallable) vphp.PhpValue {
	mut result := receiver.call_method_by_value(method)
	if !vphp.PhpException.has_current() {
		mut updated := rebind.invoke()
		updated.release()
	}
	return result.move_to_request_scope()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\callStaticArgs')]
pub fn fixture_call_static_args(class_name string, method string, arguments vphp.PhpArray) vphp.PhpValue {
	return vphp.PhpClass.named(class_name).call_static_args(method, arguments)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\callFunctionPositional')]
pub fn fixture_call_function_positional(name string, value vphp.PhpValue) vphp.PhpValue {
	return vphp.PhpFunction.named(name).invoke(value)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\callMethodPositional')]
pub fn fixture_call_method_positional(receiver vphp.PhpObject, method string, value vphp.PhpValue) vphp.PhpValue {
	return receiver.call_method(method, value)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\inspectValueReceiver')]
pub fn fixture_inspect_value_receiver(input vphp.PhpValue, persistent bool) vphp.PhpValue {
	mut receiver := if persistent { input.retain() } else { input.owned() }
	defer {
		receiver.release()
	}
	if !receiver.property_exists('value') {
		return vphp.PhpValue.null()
	}
	mut value := receiver.prop_value('value')
	defer {
		value.release()
	}
	return receiver.call_method('readValue', value)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\callStaticPositional')]
pub fn fixture_call_static_positional(class_name string, method string, value vphp.PhpValue) vphp.PhpValue {
	return vphp.PhpClass.named(class_name).call_static(method, value)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\inspectCallbackOutcome')]
pub fn fixture_inspect_callback_outcome(callback vphp.PhpCallable, named bool) vphp.PhpArray {
	mut args := vphp.PhpArray.new()
	defer { args.release() }
	args.set('value', vphp.PhpInt.of(7))
	mut result := if named {
		callback.invoke_args(args)
	} else {
		callback.invoke(vphp.PhpInt.of(7))
	}
	defer { result.release() }
	mut outcome := vphp.PhpArray.new()
	outcome.bool('valid', result.is_valid())
	if mut exception := vphp.PhpException.take_current() {
		outcome.set('exception', exception)
		exception.release()
	} else {
		outcome.set_value('value', result)
	}
	return outcome
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\constructArgs')]
pub fn fixture_construct_args(class_name string, arguments vphp.PhpArray) !vphp.PhpObject {
	return vphp.PhpClass.named(class_name).construct_args(arguments)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\constructPositional')]
pub fn fixture_construct_positional(class_name string, label vphp.PhpValue, value vphp.PhpValue) !vphp.PhpObject {
	return vphp.PhpClass.named(class_name).construct(label, value)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\functionReferenceArgs')]
pub fn fixture_function_reference_args(name string, arguments vphp.PhpArray) !vphp.PhpReference {
	return vphp.PhpFunction.named(name).call_reference_args(arguments)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\methodReferenceArgs')]
pub fn fixture_method_reference_args(receiver vphp.PhpObject, method string, arguments vphp.PhpArray) !vphp.PhpReference {
	return receiver.method_reference_args(method, arguments)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\staticReferenceArgs')]
pub fn fixture_static_reference_args(class_name string, method string, arguments vphp.PhpArray) !vphp.PhpReference {
	return vphp.PhpClass.named(class_name).static_method_reference_args(method, arguments)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\countArrayArguments')]
pub fn fixture_count_array_arguments(values ...vphp.PhpArray) int {
	mut count := 0
	for value in values {
		count += value.count()
	}
	return count
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\countEnumArguments')]
pub fn fixture_count_enum_arguments(values ...?vphp.PhpEnumCase) int {
	mut count := 0
	for value in values {
		if _ := value {
			count++
		}
	}
	return count
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\echoEnumCase')]
@[vphp.PhpArgDefault('value', 'VPHP\\ReferenceDefaults\\UnitKind::first')]
pub fn fixture_echo_enum_case(value vphp.PhpEnumCase) vphp.PhpEnumCase {
	return value
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeEnumCaseIdentity')]
pub fn fixture_make_enum_case_identity() fn (value ?vphp.PhpEnumCase) ?vphp.PhpEnumCase {
	return fn (value ?vphp.PhpEnumCase) ?vphp.PhpEnumCase {
		return value
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeEnumCaseSelector')]
pub fn fixture_make_enum_case_selector() fn (items ...vphp.PhpEnumCase) ?vphp.PhpEnumCase {
	return fn (items ...vphp.PhpEnumCase) ?vphp.PhpEnumCase {
		return if items.len == 0 { none } else { ?vphp.PhpEnumCase(items.last()) }
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\echoIterable')]
pub fn fixture_echo_iterable(value vphp.PhpIterable) vphp.PhpIterable {
	return value
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\echoIterator')]
pub fn fixture_echo_iterator(value vphp.PhpIterator) vphp.PhpIterator {
	return value
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeIterableIdentity')]
pub fn fixture_make_iterable_identity() fn (value ?vphp.PhpIterable) ?vphp.PhpIterable {
	return fn (value ?vphp.PhpIterable) ?vphp.PhpIterable {
		return value
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeIteratorSelector')]
pub fn fixture_make_iterator_selector() fn (items ...vphp.PhpIterator) ?vphp.PhpIterator {
	return fn (items ...vphp.PhpIterator) ?vphp.PhpIterator {
		return if items.len == 0 { none } else { ?vphp.PhpIterator(items.last()) }
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\materializeIterable')]
pub fn fixture_materialize_iterable(value vphp.PhpIterable, recover vphp.PhpCallable) vphp.PhpValue {
	mut result := value.to_array() or {
		if mut failure := vphp.PhpException.take_current() {
			defer {
				failure.release()
			}
			return recover.invoke(failure)
		}
		return vphp.PhpValue.null()
	}
	return result.take_value()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\materializeIteratorList')]
pub fn fixture_materialize_iterator_list(value vphp.PhpIterator) !vphp.PhpArray {
	mut owned := value.owned()
	defer {
		owned.release()
	}
	return owned.to_list()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\findArrayKey')]
pub fn fixture_find_array_key(value vphp.PhpArray, key vphp.PhpValue) vphp.PhpArray {
	mut result := vphp.PhpArray.new()
	found := value.get_key(key.to_zval()) or { return result }
	result.push_zval(found)
	return result
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\findArrayStringKey')]
pub fn fixture_find_array_string_key(value vphp.PhpArray, key string) vphp.PhpArray {
	result := vphp.PhpArray.new()
	if found := value.find(key) {
		result.push(found)
	}
	return result
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\iterableEntries')]
pub fn fixture_iterable_entries(value vphp.PhpIterable) !vphp.PhpArray {
	return value.to_entries()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\iterableList')]
pub fn fixture_iterable_list(value vphp.PhpIterable) !vphp.PhpArray {
	return value.to_list()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\visitIterableValues')]
pub fn fixture_visit_iterable_values(value vphp.PhpIterable, visit vphp.PhpCallable) !vphp.PhpArray {
	mut items := vphp.PhpArray.new()
	completed := value.each_value_by_value_while(fn [visit, mut items] (item vphp.PhpValue) bool {
		mut decision := visit.invoke_by_value(item)
		defer {
			decision.release()
		}
		if vphp.has_exception() {
			return false
		}
		items.next(item)
		return decision.to_bool()
	}) or {
		items.release()
		return err
	}
	items.bool('completed', completed)
	return items
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\countIterable')]
pub fn fixture_count_iterable(value vphp.PhpIterable) int {
	return value.count()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\castValueToString')]
pub fn fixture_cast_value_to_string(value vphp.PhpValue) string {
	return value.to_string()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\roundTripIntegerStorage')]
pub fn fixture_round_trip_integer_storage(value vphp.PhpInt) vphp.PhpArray {
	mut scalar := vphp.PhpInt.of(value.value())
	defer {
		scalar.release()
	}
	result := vphp.PhpArray.new()
	result.push(scalar)
	result.to_zval().push_long(value.value())
	result.int('assoc', value.to_zval().get_int())
	scalar.to_zval().set_int(value.value())
	result.assoc('updated', scalar)
	return result
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\writeScalarArrayFields')]
pub fn fixture_write_scalar_array_fields(prefix string, value string) vphp.PhpArray {
	result := vphp.PhpArray.new()
	result.string(prefix, 'base')
	result.string(prefix + '\x00s', value)
	result.int(prefix + '\x00i', 23)
	result.bool(prefix + '\x00b', true)
	result.double(prefix + '\x00d', 1.25)
	return result
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\changeSharedArray')]
pub fn fixture_change_shared_array(value vphp.PhpArray, operation string) vphp.PhpArray {
	match operation {
		'string' { value.string('name', 'changed') }
		'int' { value.int('name', 17) }
		'double' { value.double('name', 1.25) }
		'bool' { value.bool('name', true) }
		'index' { value.index_zval(0, value.get_index(1)) }
		'append' { value.push_zval(value.get_index(1)) }
		'append-string' { value.push_string('changed') }
		'append-int' { value.to_zval().push_long(17) }
		'append-double' { value.to_zval().push_double(1.25) }
		'self' { value.set('self', value) }
		else { value.set_zval('name', value.get_index(1)) }
	}
	return value
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\removeArrayEntry')]
pub fn fixture_remove_array_entry(value vphp.PhpArray, key vphp.PhpValue) vphp.PhpArray {
	removed := if key.is_long() {
		value.remove_index(key.to_i64())
	} else {
		value.remove(key.to_string())
	}
	result := vphp.PhpArray.new()
	result.bool('removed', removed)
	result.set('array', value)
	value.push_string('tail')
	result.set('appended', value)
	return result
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\storeArrayObject')]
pub fn fixture_store_array_object(make vphp.PhpCallable, operation string) vphp.PhpArray {
	mut value := make.invoke()
	mut result := vphp.PhpArray.new()
	if operation == 'set' {
		result.set_value('entry', value)
	} else {
		result.push_value(value)
	}
	value.release()
	if operation == 'values' {
		snapshot := result.value_array()
		result.release()
		return snapshot
	}
	return result
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\roundTripRetainedArray')]
pub fn fixture_round_trip_retained_array(value vphp.PhpArray) vphp.PhpArray {
	mut retained := value.retain()
	defer {
		retained.release()
	}
	return retained.owned()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\snapshotArray')]
pub fn fixture_snapshot_array(value vphp.PhpArray) vphp.PhpArray {
	return value.snapshot()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\countIterator')]
pub fn fixture_count_iterator(value vphp.PhpIterator) int {
	return value.count()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\writeArrayIndex')]
pub fn fixture_write_array_index(index i64, value vphp.PhpValue) vphp.PhpArray {
	mut result := vphp.PhpArray.new()
	result.index_zval(index, value.to_zval())
	return result
}

@[vphp.PhpExportMethod(name: 'exportedEnumCaseDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=VPHP\\ReferenceDefaults\\ExportedDnfDefault::default_value,label='default'")]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int|null')]
pub fn (receiver &VPhpNamespacedDnfDefaults) exported_enum_case_default_dnf(value vphp.PhpValue, label string) vphp.PhpValue {
	return value
}

@[vphp.PhpExportMethod(name: 'staticExportedEnumCaseDefaultDnf')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpArgDefaults(defaults: "value=VPHP\\ReferenceDefaults\\ExportedDnfDefault::default_value,label='default'")]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int|null')]
pub fn VPhpNamespacedDnfDefaults.static_exported_enum_case_default_dnf(value vphp.PhpValue, label string) vphp.PhpValue {
	return value
}

@[params]
pub struct EnumDefaultOptions {
pub:
	mode       defaults.VUnitKind  = .second
	maybe_mode ?defaults.VUnitKind = defaults.VUnitKind.second
	label      string              = 'default'
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\enumOptions')]
pub fn enum_options(options EnumDefaultOptions) vphp.PhpArray {
	mut result := vphp.PhpArray.new()
	result.set('mode', vphp.PhpValue.from_v(options.mode) or { return result })
	if maybe_mode := options.maybe_mode {
		result.set('maybe', vphp.PhpValue.from_v(maybe_mode) or { return result })
	} else {
		result.set('maybe', vphp.PhpNull.value())
	}
	result.string('label', options.label)
	return result
}

@[vphp.PhpExportMethod(name: 'enumOptions')]
@[vphp.PhpArgDefault('mode', 'VPHP\\ReferenceDefaults\\UnitKind::first')]
pub fn (receiver &VPhpNamespacedDnfDefaults) enum_options(options EnumDefaultOptions) vphp.PhpArray {
	return enum_options(options)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeEnumOptions')]
pub fn make_enum_options() fn (EnumDefaultOptions) vphp.PhpArray {
	return enum_options
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\externalOptions')]
pub fn external_options(options defaults.EnumDefaultOptions) vphp.PhpArray {
	return defaults.local_options(options)
}

@[vphp.PhpExportMethod(name: 'externalOptions')]
pub fn (receiver &VPhpNamespacedDnfDefaults) external_options(options defaults.EnumDefaultOptions) vphp.PhpArray {
	return defaults.local_options(options)
}

@[vphp.PhpExportClass(name: 'VPHP\\ReferenceProbe\\OptionsContractImpl')]
@[vphp.PhpImplements(names: 'VPHP\\ReferenceProbe\\OptionsContract, VPHP\\ReferenceProbe\\InheritedTypedValueContract')]
pub struct VOptionsContractImpl {}

@[vphp.PhpExportMethod(name: 'typedValue')]
@[vphp.PhpArgType('value', '(Countable&ArrayAccess)|int|null')]
@[vphp.PhpReturnType(php_type: '(Countable&ArrayAccess)|int|null')]
pub fn (receiver &VOptionsContractImpl) typed_value(value vphp.PhpValue) vphp.PhpValue {
	return value
}

@[vphp.PhpExportMethod(name: 'external_options')]
pub fn (receiver &VOptionsContractImpl) external_options(options defaults.EnumDefaultOptions) vphp.PhpArray {
	return defaults.local_options(options)
}

@[vphp.PhpExportMethod(name: 'computed_options')]
pub fn (receiver &VOptionsContractImpl) computed_options(options defaults.ComputedInterfaceOptions) string {
	return '${options.value}:${options.label}'
}

@[vphp.PhpExportMethod(name: 'renamedOptions')]
@[vphp.PhpArgNames(names: 'request_id=request,label=message')]
pub fn VOptionsContractImpl.renamed_options(request_id int, options defaults.EnumDefaultOptions) string {
	return '${request_id}:${options.label}'
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeExternalOptions')]
pub fn make_external_options() fn (defaults.EnumDefaultOptions) vphp.PhpArray {
	return defaults.local_options
}

@[vphp.PhpExportInterface(name: 'VPHP\\ReferenceProbe\\PayloadReader')]
pub interface VPayloadReader {
	read(payload &defaults.VReferencePayload) i64
}

@[vphp.PhpExportClass(name: 'VPHP\\ReferenceProbe\\PayloadReaderImpl')]
@[vphp.PhpImplements(names: 'VPHP\\ReferenceProbe\\PayloadReader')]
pub struct VPayloadReaderImpl {}

@[params]
pub struct ObjectClosureOptions {
pub:
	marker i64 = 23
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeMarkerListCallback')]
pub fn make_marker_list_callback() fn (ObjectClosureOptions) []i64 {
	return fn (options ObjectClosureOptions) []i64 {
		return [options.marker]
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeCheckedMarkerCallback')]
pub fn make_checked_marker_callback() fn (...vphp.VScalarValue) !i64 {
	return fn (markers ...vphp.VScalarValue) !i64 {
		if markers.len == 0 {
			return error('marker required')
		}
		return markers.last().to_i64()
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeVoidCallback')]
pub fn make_void_callback() fn (ObjectClosureOptions) {
	return fn (options ObjectClosureOptions) {
		if options.marker < 0 {
			vphp.PhpException.raise_class('DomainException', 'invalid void callback marker', 0)
		}
	}
}

@[params]
pub struct BoundClosureOptions {
pub:
	payload  &defaults.VReferencePayload
	override ?&defaults.VReferencePayload = none
	prefer   bool                         = true
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeFixedPayloadCallback')]
pub fn make_fixed_payload_callback() fn (payload &defaults.VReferencePayload, prefix string, offset ?i64) !string {
	return fn (payload &defaults.VReferencePayload, prefix string, offset ?i64) !string {
		if prefix == '' {
			return error('prefix required')
		}
		return prefix + ':' + (payload.marker + (offset or { i64(0) })).str()
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeUnnamedCallback')]
pub fn make_unnamed_callback() fn (int, bool) string {
	return fn (count int, enabled bool) string {
		return count.str() + ':' + enabled.str()
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeMixedNameCallback')]
pub fn make_mixed_name_callback() fn (int, arg1 i64) i64 {
	return fn (first int, second i64) i64 {
		return i64(first) + second
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeZeroArgumentCallback')]
pub fn make_zero_argument_callback() fn () int {
	return fn () int {
		return 13
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeMixedSumCallback')]
pub fn make_mixed_sum_callback() fn (base i64, offsets ...i64) i64 {
	return fn (base i64, offsets ...i64) i64 {
		mut total := base
		for offset in offsets {
			total += offset
		}
		return total
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeMixedPayloadCallback')]
@[vphp.PhpBorrowedReturn]
pub fn make_mixed_payload_callback() fn (fallback ?&defaults.VReferencePayload, payloads ...?&defaults.VReferencePayload) ?&defaults.VReferencePayload {
	return fn (fallback ?&defaults.VReferencePayload, payloads ...?&defaults.VReferencePayload) ?&defaults.VReferencePayload {
		if payloads.len == 0 {
			return fallback
		}
		return payloads.last()
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makePayloadSumCallback')]
pub fn make_payload_sum_callback() fn (...&defaults.VReferencePayload) i64 {
	return fn (payloads ...&defaults.VReferencePayload) i64 {
		mut sum := i64(0)
		for payload in payloads {
			sum += payload.marker
		}
		return sum
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeLastPayloadCallback')]
@[vphp.PhpBorrowedReturn]
pub fn make_last_payload_callback() fn (...?&defaults.VReferencePayload) ?&defaults.VReferencePayload {
	return fn (payloads ...?&defaults.VReferencePayload) ?&defaults.VReferencePayload {
		if payloads.len == 0 {
			return none
		}
		return payloads.last()
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeBoundPayloadCallback')]
@[vphp.PhpBorrowedReturn]
pub fn make_bound_payload_callback() fn (BoundClosureOptions) &defaults.VReferencePayload {
	return fn (options BoundClosureOptions) &defaults.VReferencePayload {
		if options.prefer {
			return options.override or { options.payload }
		}
		return options.payload
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeBorrowedPayloadCallback')]
@[vphp.PhpBorrowedReturn]
pub fn make_borrowed_payload_callback(owner &defaults.VPayloadOwner) fn (ObjectClosureOptions) &defaults.VReferencePayload {
	return fn [owner] (options ObjectClosureOptions) &defaults.VReferencePayload {
		if options.marker == 0 {
			return unsafe { nil }
		}
		return defaults.VReferencePayload.borrow_from_owner(owner)
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeOptionalPayloadCallback')]
pub fn make_optional_payload_callback() fn (ObjectClosureOptions) ?&defaults.VReferencePayload {
	return fn (options ObjectClosureOptions) ?&defaults.VReferencePayload {
		if options.marker < 0 {
			return none
		}
		return direct_payload(options.marker)
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeVariadicPayloadCallback')]
pub fn make_variadic_payload_callback() fn (...vphp.VScalarValue) !&defaults.VReferencePayload {
	return fn (markers ...vphp.VScalarValue) !&defaults.VReferencePayload {
		mut total := i64(0)
		for marker in markers {
			total += marker.to_i64()
		}
		if total == -2 {
			vphp.PhpException.raise_class('DomainException', 'PHP rejected the callback payload', 0)
		}
		return build_payload(total)
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\directPayload')]
pub fn direct_payload(marker i64) &defaults.VReferencePayload {
	return &defaults.VReferencePayload{ marker: marker }
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\borrowPayload')]
@[vphp.PhpBorrowedReturn]
pub fn borrow_payload(payload &defaults.VReferencePayload) &defaults.VReferencePayload {
	return payload
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\contextFunctionPayload')]
pub fn context_function_payload(ctx vphp.Context) &defaults.VReferencePayload {
	return direct_payload(i64(ctx.num_args()))
}

@[vphp.PhpExportMethod(name: 'contextPayload')]
pub fn VPayloadReaderImpl.context_payload(ctx vphp.Context) &defaults.VReferencePayload {
	_ = ctx
	return direct_payload(31)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\buildPayload')]
pub fn build_payload(marker i64) !&defaults.VReferencePayload {
	if marker < 0 {
		return error('negative payload marker')
	}
	return &defaults.VReferencePayload{ marker: marker }
}

@[vphp.PhpExportMethod(name: 'maybePayload')]
@[vphp.PhpBorrowedReturn]
pub fn (reader &VPayloadReaderImpl) maybe_payload(payload ?&defaults.VReferencePayload) ?&defaults.VReferencePayload {
	return payload
}

@[vphp.PhpExportMethod(name: 'checkedPayload')]
pub fn VPayloadReaderImpl.checked_payload(marker i64) !&defaults.VReferencePayload {
	if marker < 0 {
		vphp.PhpException.raise_class('DomainException', 'PHP rejected the payload', 0)
		return error('V rejected the payload')
	}
	return build_payload(marker)
}

@[vphp.PhpExportMethod(name: 'read')]
pub fn (reader &VPayloadReaderImpl) read(payload &defaults.VReferencePayload) i64 {
	return payload.marker
}

@[vphp.PhpExportMethod(name: 'readOptional')]
pub fn (reader &VPayloadReaderImpl) read_optional(payload ?&defaults.VReferencePayload) i64 {
	if value := payload {
		return value.marker
	}
	return -1
}

@[vphp.PhpExportMethod(name: 'readObject')]
@[vphp.PhpArgType('payload', 'object')]
pub fn (reader &VPayloadReaderImpl) read_object(payload &defaults.VReferencePayload) i64 {
	return payload.marker
}

@[vphp.PhpExportMethod(name: 'readMany')]
pub fn (reader &VPayloadReaderImpl) read_many(payloads ...&defaults.VReferencePayload) i64 {
	mut sum := i64(0)
	for item in payloads {
		sum += item.marker
	}
	return sum
}

@[params]
pub struct VPayloadReadOptions {
	payload  ?&defaults.VReferencePayload
	fallback i64 = 5
}

@[vphp.PhpExportMethod(name: 'readOptions')]
pub fn (reader &VPayloadReaderImpl) read_options(options VPayloadReadOptions) i64 {
	if payload := options.payload {
		return payload.marker
	}
	return options.fallback
}

@[vphp.PhpExportMethod(name: 'readManyNullable')]
pub fn (reader &VPayloadReaderImpl) read_many_nullable(payloads ...?&defaults.VReferencePayload) i64 {
	mut sum := i64(0)
	for item in payloads {
		if payload := item {
			sum += payload.marker
		}
	}
	return sum
}

struct GeneratorProducerProbe {
mut:
	phase int
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeGenerator')]
pub fn make_generator(record vphp.PhpCallable, recover_exception bool) !vphp.PhpGenerator {
	mut state := &GeneratorProducerProbe{}
	return vphp.PhpGenerator.from_producer(vphp.PhpGeneratorProducer{
		capture:            record.borrowed().to_value()
		resume:             fn [mut state, recover_exception] (input vphp.PhpGeneratorInput) !vphp.PhpGeneratorStep {
			state.phase++
			recorder := vphp.PhpCallable.must_from_zval(input.capture.to_zval())!
			recorder.with_result[vphp.PhpValue, bool](fn (_ vphp.PhpValue) bool { return true },
				vphp.PhpInt.of(state.phase)) or { return err }
			if raised := input.exception {
				if recover_exception {
					return vphp.PhpGeneratorStep.finish(raised.to_object().to_value())
				}
				return vphp.PhpGeneratorStep.throw_exception(raised)
			}
			return match state.phase {
				1 {
					vphp.PhpGeneratorStep.yield_keyed(vphp.PhpValue.string('first'), vphp.PhpValue.null())
				}
				2 { vphp.PhpGeneratorStep.yield_value(input.sent) }
				else { vphp.PhpGeneratorStep.finish(input.sent) }
			}
		}
		close_with_capture: fn (capture vphp.PhpValue) {
			recorder := vphp.PhpCallable.from_zval(capture.to_zval()) or { return }
			recorder.with_result[vphp.PhpValue, bool](fn (_ vphp.PhpValue) bool { return true },
				vphp.PhpInt.of(0)) or { false }
		}
	})
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\echoGenerator')]
pub fn echo_generator(value vphp.PhpGenerator) vphp.PhpGenerator {
	return value
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\consumeGeneratorInputs')]
pub fn consume_generator_inputs() !vphp.PhpGenerator {
	mut state := &GeneratorProducerProbe{}
	return vphp.PhpGenerator.from_producer(vphp.PhpGeneratorProducer{
		resume: fn [mut state] (_ vphp.PhpGeneratorInput) !vphp.PhpGeneratorStep {
			state.phase++
			if state.phase == 4 {
				return vphp.PhpGeneratorStep.finish(vphp.PhpValue.null())
			}
			return vphp.PhpGeneratorStep.yield_value(vphp.PhpValue.int(state.phase))
		}
	})
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeReferenceGenerator')]
pub fn make_reference_generator(value vphp.PhpReference, by_reference bool, yield_reference bool) !vphp.PhpGenerator {
	mut state := &GeneratorProducerProbe{}
	return vphp.PhpGenerator.from_producer(vphp.PhpGeneratorProducer{
		by_reference: by_reference
		capture:      value.borrowed().to_value()
		resume:       fn [mut state, yield_reference] (input vphp.PhpGeneratorInput) !vphp.PhpGeneratorStep {
			if raised := input.exception {
				raised.throw()
				return error('injected exception')
			}
			shared := vphp.PhpReference.must_from_zval(input.capture.to_zval())!
			state.phase++
			if !yield_reference {
				return vphp.PhpGeneratorStep.yield_value(shared.deref())
			}
			return match state.phase {
				1 {
					vphp.PhpGeneratorStep.yield_keyed_reference(vphp.PhpValue.string('ref'), shared)
				}
				2 { vphp.PhpGeneratorStep.yield_reference(shared) }
				else { vphp.PhpGeneratorStep.finish(shared.deref()) }
			}
		}
	})
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\delegateGenerator')]
pub fn delegate_generator(source vphp.PhpIterable, recover_exception bool, by_reference bool) !vphp.PhpGenerator {
	return vphp.PhpGenerator.from_producer(vphp.PhpGeneratorProducer{
		by_reference: by_reference
		capture:      source.borrowed().to_value()
		resume:       fn [recover_exception] (input vphp.PhpGeneratorInput) !vphp.PhpGeneratorStep {
			match input.kind {
				.start {
					source := vphp.PhpIterable.must_from_zval(input.capture.to_zval())!
					return vphp.PhpGeneratorStep.yield_from(source)
				}
				.delegate_resume {
					if raised := input.exception {
						if recover_exception {
							return vphp.PhpGeneratorStep.finish(raised.to_object().to_value())
						}
						return vphp.PhpGeneratorStep.throw_exception(raised)
					}
					value := input.delegated_return or { return error('missing delegated return value') }
					return vphp.PhpGeneratorStep.finish(value)
				}
				else { return error('unexpected direct yield in delegating producer') }
			}
		}
	})
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\delegateGeneratorFrom')]
pub fn delegate_generator_from(create vphp.PhpCallable, resumed vphp.PhpCallable) !vphp.PhpGenerator {
	mut capture := vphp.PhpArray.new()
	defer {
		capture.release()
	}
	capture.push(create)
	capture.push(resumed)
	return vphp.PhpGenerator.from_producer(vphp.PhpGeneratorProducer{
		capture: capture.borrowed().to_value()
		resume:  fn (input vphp.PhpGeneratorInput) !vphp.PhpGeneratorStep {
			callbacks := input.capture.as_array() or { return error('missing delegation callbacks') }
			if input.kind == .start {
				factory := vphp.PhpCallable.must_from_zval(callbacks.index_value(0).to_zval())!
				mut result := factory.invoke()
				source := vphp.PhpIterable.must_from_zval(result.move_to_request_scope().to_zval())!
				return vphp.PhpGeneratorStep.yield_from(source)
			}
			resumed := vphp.PhpCallable.must_from_zval(callbacks.index_value(1).to_zval())!
			mut result := resumed.invoke()
			result.release()
			if raised := input.exception {
				return vphp.PhpGeneratorStep.throw_exception(raised)
			}
			result_value := input.delegated_return or { return error('missing delegated return') }
			return vphp.PhpGeneratorStep.finish(result_value)
		}
	})
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\deferredGenerator')]
pub fn deferred_generator(factory vphp.PhpCallable) !vphp.PhpGenerator {
	return vphp.PhpGenerator.from_iterable_factory(factory)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\deferredGeneratorWithArgs')]
@[vphp.PhpArgDefault(v_name: 'args', default_value: '[]')]
pub fn deferred_generator_with_args(factory vphp.PhpCallable, args vphp.PhpArray) !vphp.PhpGenerator {
	return vphp.PhpGenerator.from_iterable_factory_args(factory, args)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\streamGenerator')]
@[vphp.PhpArgName(v_name: 'chunk_size', php_name: 'chunkSize')]
@[vphp.PhpArgDefault(v_name: 'chunk_size', default_value: '8192')]
pub fn stream_generator(stream vphp.PhpResource, chunk_size i64) !vphp.PhpGenerator {
	return vphp.PhpGenerator.from_stream_resource(stream, chunk_size: chunk_size)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\streamGeneratorFrom')]
@[vphp.PhpArgName(v_name: 'chunk_size', php_name: 'chunkSize')]
@[vphp.PhpArgDefaults(defaults: 'args=[],chunk_size=8192')]
pub fn stream_generator_from(factory vphp.PhpCallable, args vphp.PhpArray, chunk_size i64) !vphp.PhpGenerator {
	return vphp.PhpGenerator.from_iterable_factory_args(factory, args,
		stream: vphp.PhpStreamGeneratorOptions{ chunk_size: chunk_size }
	)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\driveGenerator')]
pub fn drive_generator(value vphp.PhpValue, input vphp.PhpValue) !vphp.PhpArray {
	mut converted := value.as_generator() or { return error('expected PHP Generator') }
	mut generator := converted.retain()
	converted.release()
	defer {
		generator.release()
	}
	generator.rewind()!
	mut key := generator.key()!
	defer {
		key.release()
	}
	mut first := generator.current()!
	defer {
		first.release()
	}
	mut sent := generator.send(input)!
	defer {
		sent.release()
	}
	generator.next()!
	still_valid := generator.valid()!
	mut returned := generator.get_return()!
	defer {
		returned.release()
	}
	out := vphp.PhpArray.new()
	out.set_value('key', key)
	out.set_value('first', first)
	out.set_value('sent', sent)
	out.bool('valid', still_valid)
	out.set_value('returned', returned)
	return out
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\injectGeneratorException')]
pub fn inject_generator_exception(generator vphp.PhpGenerator, exception vphp.PhpThrowable) !vphp.PhpArray {
	generator.rewind()!
	mut result := generator.throw_into(exception)!
	defer {
		result.release()
	}
	out := vphp.PhpArray.new()
	out.push_value(result)
	return out
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\generatorReturnValue')]
pub fn generator_return_value(generator vphp.PhpGenerator) !vphp.PhpValue {
	return generator.get_return()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\scopedGeneratorValue')]
pub fn scoped_generator_value(value vphp.PhpValue) vphp.PhpValue {
	return value.to_request_scoped()
}

@[vphp.PhpExportClass(name: 'VPHP\\ReferenceProbe\\PhpStateOwner')]
@[heap]
pub struct PhpStateOwner {
mut:
	pending_state vphp.PhpValue @[vphp.PhpIgnoreField]
	state_initializations int @[vphp.PhpIgnoreField]
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makePhpStateOwner')]
pub fn make_php_state_owner(value vphp.PhpValue) &PhpStateOwner {
	return &PhpStateOwner{pending_state: value.owned()}
}

pub fn (mut owner PhpStateOwner) init_php_state() {
	owner.state_initializations++
	if state := vphp.owned_object_php_state(&owner) {
		state.set_value('prepared', owner.pending_state)
		owner.pending_state.release()
	}
}

@[vphp.PhpExportMethod(name: 'preparedState')]
pub fn (owner &PhpStateOwner) prepared_state() vphp.PhpValue {
	state := vphp.owned_object_php_state(owner) or { return vphp.PhpValue.null() }
	value := state.find('prepared') or { return vphp.PhpValue.null() }
	return value.to_request_scoped()
}

@[vphp.PhpExportMethod(name: 'stateInitializations')]
pub fn (owner &PhpStateOwner) state_initialization_count() int {
	return owner.state_initializations
}

@[vphp.PhpExportMethod(name: 'sameOwner')]
pub fn (owner &PhpStateOwner) same_owner() &PhpStateOwner {
	return owner
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut owner PhpStateOwner) remember(value vphp.PhpValue) ! {
	state := vphp.owned_object_php_state(&owner) or { return error('missing PHP state') }
	state.push_value(value)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\scopedFiberValue')]
pub fn scoped_fiber_value(create vphp.PhpCallable, suspend vphp.PhpCallable) !vphp.PhpValue {
	mut value := create.invoke()
	scoped := value.move_to_request_scope()
	suspend.with_result[vphp.PhpValue, bool](fn (_ vphp.PhpValue) bool {
		return true
	})!
	return scoped
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeFiber')]
pub fn make_fiber(callback vphp.PhpCallable) !vphp.PhpFiber {
	return vphp.PhpFiber.new(callback)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\newPhpStreamContext')]
pub fn new_php_stream_context(options vphp.PhpArray) !vphp.PhpValue {
	mut context := vphp.PhpResource.new_stream_context(options)!
	mut value := vphp.PhpValue.adopt_zval(context.take_zval())
	return value.move_to_request_scope()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\openPhpStream')]
pub fn open_php_stream(path string, mode string, context ?vphp.PhpResource, report_errors bool) !vphp.PhpValue {
	mut stream := vphp.PhpResource.open_stream(path, mode,
		context:       context
		report_errors: report_errors
	)!
	mut value := vphp.PhpValue.adopt_zval(stream.take_zval())
	return value.move_to_request_scope()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\phpStreamWrapperData')]
pub fn php_stream_wrapper_data(stream vphp.PhpResource) ?vphp.PhpValue {
	mut data := stream.stream_wrapper_data()?
	return data.move_to_request_scope()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\readPhpStreamToEnd')]
pub fn read_php_stream_to_end(stream vphp.PhpResource) !string {
	return stream.read_to_end()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\readPhpStreamExactly')]
pub fn read_php_stream_exactly(stream vphp.PhpResource, length i64) !string {
	return stream.read_exactly(length)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\readCompletePhpStreamLine')]
pub fn read_complete_php_stream_line(stream vphp.PhpResource, max_bytes int) !string {
	return stream.read_complete_line(max_bytes)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\currentFiber')]
pub fn current_fiber() ?vphp.PhpFiber {
	return vphp.PhpFiber.current()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\fiberContextId')]
pub fn fiber_context_id() i64 {
	return i64(vphp.PhpFiber.current_id())
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\fiberIdentityClosure')]
pub fn fiber_identity_closure() fn (vphp.PhpFiber) vphp.PhpFiber {
	return fn (fiber vphp.PhpFiber) vphp.PhpFiber {
		return fiber
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\startFiber')]
pub fn start_fiber(fiber vphp.PhpFiber, args vphp.PhpArray) !vphp.PhpValue {
	mut result := fiber.start_args(args)!
	return result.move_to_request_scope()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\startFiberWithValue')]
pub fn start_fiber_with_value(fiber vphp.PhpFiber, value vphp.PhpValue) !vphp.PhpValue {
	mut result := fiber.start(value)!
	return result.move_to_request_scope()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\resumeFiber')]
pub fn resume_fiber(fiber vphp.PhpFiber, value vphp.PhpValue) !vphp.PhpValue {
	mut result := fiber.resume(value)!
	return result.move_to_request_scope()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\suspendFiber')]
pub fn suspend_fiber(value vphp.PhpValue) !vphp.PhpValue {
	mut result := vphp.PhpFiber.suspend(value)!
	return result.move_to_request_scope()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\throwIntoFiber')]
pub fn throw_into_fiber(fiber vphp.PhpFiber, failure vphp.PhpThrowable) !vphp.PhpValue {
	mut result := fiber.throw_into(failure)!
	return result.move_to_request_scope()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\fiberReturn')]
pub fn fiber_return(fiber vphp.PhpFiber) !vphp.PhpValue {
	mut result := fiber.get_return()!
	return result.move_to_request_scope()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\fiberState')]
pub fn fiber_state(fiber vphp.PhpFiber) !vphp.PhpValue {
	states := [fiber.is_started()!, fiber.is_running()!, fiber.is_suspended()!, fiber.is_terminated()!]
	mut result := vphp.PhpArray.new()
	for state in states {
		result.push(vphp.PhpBool.of(state))
	}
	mut value := result.take_value()
	return value.move_to_request_scope()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\fiberAcrossCollection')]
pub fn fiber_across_collection(value string) !string {
	payload := value.repeat(800)
	gc_collect()
	mut resumed := vphp.PhpFiber.suspend(vphp.PhpValue.null())!
	resumed.release()
	return payload.trim_space()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\collectVFiberHeap')]
pub fn collect_v_fiber_heap() bool {
	gc_collect()
	return gc_is_enabled()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeWeakReference')]
pub fn make_weak_reference(target vphp.PhpObject) !vphp.PhpWeakReference {
	return vphp.PhpWeakReference.create(target)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\readWeakReference')]
pub fn read_weak_reference(reference vphp.PhpWeakReference) ?vphp.PhpObject {
	mut target := reference.get()?
	mut value := target.take_value()
	return value.move_to_request_scope().as_object()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\weakReferenceIdentityClosure')]
pub fn weak_reference_identity_closure() fn (vphp.PhpWeakReference) vphp.PhpWeakReference {
	return fn (reference vphp.PhpWeakReference) vphp.PhpWeakReference {
		return reference
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\encodeSerializable')]
@[vphp.PhpReturnType(php_type: 'string')]
pub fn encode_serializable(value vphp.PhpJsonSerializable) !string {
	return value.encode()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\callJsonSerialize')]
pub fn call_json_serialize(value vphp.PhpJsonSerializable) !vphp.PhpValue {
	return value.serialize()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\jsonSerializableIdentity')]
pub fn json_serializable_identity() fn (vphp.PhpJsonSerializable) vphp.PhpJsonSerializable {
	return fn (value vphp.PhpJsonSerializable) vphp.PhpJsonSerializable {
		return value
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\stringableText')]
@[vphp.PhpReturnType(php_type: 'string')]
pub fn stringable_text(value vphp.PhpStringable) !string {
	return value.stringify()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\stringableIdentity')]
pub fn stringable_identity() fn (vphp.PhpStringable) vphp.PhpStringable {
	return fn (value vphp.PhpStringable) vphp.PhpStringable {
		return value
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\countableSize')]
@[vphp.PhpReturnType(php_type: 'int')]
pub fn countable_size(value vphp.PhpCountable) !i64 {
	return value.count()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\countedOffsetSet')]
@[vphp.PhpArgType('entries', 'Countable&ArrayAccess')]
@[vphp.PhpReturnType(php_type: 'int')]
pub fn counted_offset_set(entries vphp.PhpCountable, key vphp.PhpValue, value vphp.PhpValue) !i64 {
	mut object_value := entries.to_value()
	defer {
		object_value.release()
	}
	mut offsets := object_value.as_array_access() or { return error('expected ArrayAccess') }
	defer {
		offsets.release()
	}
	offsets.set(key, value)!
	return entries.count()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\countableIdentity')]
pub fn countable_identity() fn (vphp.PhpCountable) vphp.PhpCountable {
	return fn (value vphp.PhpCountable) vphp.PhpCountable {
		return value
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\arrayAccessLookup')]
pub fn array_access_lookup(entries vphp.PhpArrayAccess, key vphp.PhpValue) !vphp.PhpArray {
	mut result := vphp.PhpArray.new()
	exists := entries.has(key) or {
		result.release()
		return err
	}
	if exists {
		mut value := entries.get(key) or {
			result.release()
			return err
		}
		result.set('value', value)
		value.release()
	}
	return result
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\arrayAccessReference')]
pub fn array_access_reference(entries vphp.PhpArrayAccess, key vphp.PhpValue) !vphp.PhpReference {
	return entries.get_reference(key)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\arrayAccessEdit')]
pub fn array_access_edit(entries vphp.PhpArrayAccess, key vphp.PhpValue, value vphp.PhpValue) !vphp.PhpArrayAccess {
	entries.remove(key)!
	entries.set(key, value)!
	entries.append(value)!
	return entries
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\arrayAccessIdentity')]
pub fn array_access_identity() fn (vphp.PhpArrayAccess) vphp.PhpArrayAccess {
	return fn (entries vphp.PhpArrayAccess) vphp.PhpArrayAccess {
		return entries
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\makeWeakMap')]
pub fn make_weak_map() !vphp.PhpWeakMap {
	return vphp.PhpWeakMap.new()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\writeWeakMap')]
@[vphp.PhpArgName(v_name: 'entries', php_name: 'map')]
pub fn write_weak_map(entries vphp.PhpWeakMap, key vphp.PhpObject, value vphp.PhpValue) ! {
	entries.set(key, value)!
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\bindWeakMapReference')]
@[vphp.PhpReturnType(php_type: 'void')]
pub fn bind_weak_map_reference(entries vphp.PhpWeakMap, key vphp.PhpObject, value vphp.PhpReference) ! {
	entries.bind_reference(key, value)!
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\updateWeakMapReference')]
pub fn update_weak_map_reference(entries vphp.PhpWeakMap, key vphp.PhpObject, value i64) bool {
	mut reference := entries.find_reference(key) or { return false }
	reference.set_value(vphp.PhpValue.int(value))
	reference.release()
	return true
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\lookupWeakMap')]
@[vphp.PhpArgName(v_name: 'entries', php_name: 'map')]
pub fn lookup_weak_map(entries vphp.PhpWeakMap, key vphp.PhpObject) !vphp.PhpArray {
	result := vphp.PhpArray.new()
	result.set('count', vphp.PhpValue.int(entries.count()!))
	if value := entries.find(key) {
		mut found := value
		result.set('value', found)
		found.release()
	}
	return result
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\removeWeakMapKey')]
pub fn remove_weak_map_key(entries vphp.PhpWeakMap, key vphp.PhpObject) ! {
	entries.remove(key)!
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\weakMapEntries')]
pub fn weak_map_entries(entries vphp.PhpWeakMap) !vphp.PhpArray {
	return entries.to_iterable().to_entries()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\weakMapIdentityClosure')]
pub fn weak_map_identity_closure() fn (vphp.PhpWeakMap) vphp.PhpWeakMap {
	return fn (entries vphp.PhpWeakMap) vphp.PhpWeakMap {
		return entries
	}
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\weakMapThroughCallback')]
pub fn weak_map_through_callback(entries vphp.PhpWeakMap, callback vphp.PhpCallable) !vphp.PhpWeakMap {
	result := callback.with_result[vphp.PhpWeakMap, vphp.ZVal](fn (response vphp.PhpWeakMap) vphp.ZVal {
		return response.to_value().to_request_scoped().to_zval()
	}, entries)!
	return vphp.PhpWeakMap.must_from_zval(result)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\readPhpStream')]
pub fn read_php_stream(stream vphp.PhpResource, length i64) ?string {
	return stream.read(length)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\writePhpStream')]
pub fn write_php_stream(stream vphp.PhpResource, text string) ?i64 {
	return stream.write(text)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\inspectPhpStream')]
pub fn inspect_php_stream(stream vphp.PhpResource, distance i64) bool {
	metadata := stream.stream_metadata_value() or { return false }
	mut owned := metadata
	defer {
		owned.release()
	}
	if !metadata.bool_at('seekable', false) || !stream.seek(distance, .end) {
		return false
	}
	size := stream.size() or { return false }
	position := stream.tell() or { return false }
	return position == size + distance
}

@[vphp.PhpExportClass(name: 'VPHP\\ReferenceProbe\\PropertyReadProbe')]
@[vphp.PhpObjectCopy(cloneable: true, serializable: false)]
@[heap]
pub struct PropertyReadProbe {
pub mut:
	score int = 7
	label string = 'v'
	other int = 2
	data vphp.PhpValue
}

struct PropertyReadStatics {
mut:
	count int = 5
}

const property_read_statics = vphp.PhpStaticTable[PropertyReadProbe, PropertyReadStatics]{
	values: PropertyReadStatics{}
}

@[vphp.PhpExportMethod(name: 'advance')]
pub fn (mut probe PropertyReadProbe) advance(by int) {
	probe.score += by
}

@[vphp.PhpExportMethod(name: 'advanceThroughAlias')]
pub fn (mut probe PropertyReadProbe) advance_through_alias(callback vphp.PhpCallable) int {
	probe.score += 2
	mut ignored := callback.invoke()
	ignored.release()
	if !vphp.has_exception() {
		probe.score += 3
	}
	return probe.score
}

@[vphp.PhpExportMethod(name: 'dataValue')]
pub fn (probe &PropertyReadProbe) data_value() vphp.PhpValue {
	return probe.data.to_request_scoped()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\advanceAliasedObjects')]
pub fn advance_aliased_objects(first vphp.PhpObject, second vphp.PhpObject, callback vphp.PhpCallable) int {
	mut receiver := first.to_v_object[PropertyReadProbe]() or { return -1 }
	receiver.score += 2
	updated := receiver.score
	same := first.to_v_object[PropertyReadProbe]() or { return -2 }
	if same.score != updated {
		return -3
	}
	mut peer := second.to_v_object[PropertyReadProbe]() or { return -4 }
	mut result := callback.invoke()
	result.release()
	if !vphp.has_exception() {
		peer.score += 3
	}
	return peer.score
}

@[vphp.PhpExportMethod(name: 'advanceAliasedDuringStatic')]
pub fn PropertyReadProbe.advance_aliased_during_static(object vphp.PhpObject) int {
	mut state := PropertyReadProbe.statics()
	mut receiver := object.to_v_object[PropertyReadProbe]() or { return -1 }
	state.count += receiver.score
	receiver.score++
	return state.count
}

@[vphp.PhpExportMethod(name: 'writeSharedStatic')]
pub fn PropertyReadProbe.write_shared_static(object vphp.PhpObject, value int, callback vphp.PhpCallable, run_callback bool) int {
	mut state := PropertyReadProbe.statics()
	receiver := object.to_v_object[PropertyReadProbe]() or { return -1 }
	state.count = value
	if run_callback {
		mut result := callback.invoke()
		result.release()
	}
	return receiver.score
}

@[vphp.PhpExportMethod(name: 'applySharedReference')]
pub fn PropertyReadProbe.apply_shared_reference(object vphp.PhpObject, reference vphp.PhpReference, value vphp.PhpValue) string {
	state := PropertyReadProbe.statics()
	mut receiver := object.to_v_object[PropertyReadProbe]() or { return '' }
	receiver.score += 3
	observed := reference.deref().to_int()
	reference.set_value(value)
	return [observed.str(), state.count.str(), receiver.score.str()].join(':')
}

@[vphp.PhpExportMethod(name: 'copyStaticReference')]
pub fn PropertyReadProbe.copy_static_reference(source vphp.PhpReference, destination vphp.PhpReference, value int) int {
	mut state := PropertyReadProbe.statics()
	state.count = value
	destination.set(source.to_zval())
	return destination.deref().to_int()
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\writeAliasedData')]
pub fn write_aliased_data(first vphp.PhpObject, second vphp.PhpObject, value vphp.PhpValue) {
	if first.to_v_object[PropertyReadProbe]() == none {
		return
	}
	mut target := second.to_v_object[PropertyReadProbe]() or { return }
	mut previous := target.data
	target.data = value.retain()
	previous.release()
}

pub fn (probe &PropertyReadProbe) clone_into(mut target PropertyReadProbe) {
	target.score = probe.score
	target.label = probe.label
	target.other = probe.other
	target.data = probe.data.retain()
}

@[vphp.PhpExportMethod(name: 'advanceStatic')]
pub fn PropertyReadProbe.advance_static(by int) int {
	mut state := PropertyReadProbe.statics()
	state.count += by
	return state.count
}

@[vphp.PhpExportMethod(name: 'readDuringStatic')]
pub fn PropertyReadProbe.read_during_static(object vphp.PhpObject) int {
	mut state := PropertyReadProbe.statics()
	state.count++
	mut value := object.prop_value('computed')
	defer {
		value.release()
	}
	return state.count
}

@[vphp.PhpExportMethod(name: 'writeDuringStatic')]
pub fn PropertyReadProbe.write_during_static(object vphp.PhpObject, value vphp.PhpValue) int {
	mut state := PropertyReadProbe.statics()
	state.count++
	object.set_prop('computed', value.to_zval())
	return state.count
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\writeObjectProperty')]
pub fn write_object_property(object vphp.PhpObject, name string, value vphp.PhpValue) {
	object.set_prop(name, value.to_zval())
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\unsetObjectProperty')]
pub fn unset_object_property(object vphp.PhpObject, name string) {
	object.unset_prop(name)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\issetObjectProperty')]
pub fn isset_object_property(object vphp.PhpObject, name string) bool {
	return object.isset_prop(name)
}

@[vphp.PhpExportFunction(name: 'VPHP\\ReferenceProbe\\readObjectProperty')]
pub fn read_object_property(object vphp.PhpObject, name string, mode string) vphp.PhpValue {
	if mode == 'scalar' {
		return vphp.PhpValue.int(vphp.ZendObject.from_zval(object.to_zval()).prop_i64_or(name, -1))
	}
	mut value := match mode {
		'borrowed' { vphp.PhpValue.from_zval(object.prop_borrowed(name)) }
		'persistent' { vphp.PhpValue.adopt_zval(object.prop_owned_persistent(name)) }
		else { object.prop_value(name) }
	}
	defer {
		value.release()
	}
	return value.to_request_scoped()
}
