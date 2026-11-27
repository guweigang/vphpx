module main

import vphp

@[vphp.PhpExportInterface(name: 'VPHP\\Compiler\\ModuleProbeContract')]
pub interface VphpModuleProbeContract {
	label() string
}

@[vphp.PhpExportEnum('VPHP\\Compiler\\ModuleProbeKind')]
pub enum VphpModuleProbeKind {
	alpha = 7
	beta  = 11
}

@[php_enum: 'VPHP\\Compiler\\OtherProbeKind']
pub enum VphpOtherProbeKind {
	other = 11
}

@[params]
pub struct VphpModuleProbeOptions {
pub:
	prefix string = 'default'
	count  int    = 3
}

@[vphp.PhpExportConstant]
const compiler_probe_constant = 'module-constant-ok'

pub type VphpModuleProbeSum = int | string
pub type VphpModuleProbeSumType = VphpModuleProbeKind
	| int
	| VphpModuleProbeReadOnlyBox
	| VphpOtherProbeKind

@[php_class: 'VPHP\\Compiler\\ModuleProbeReadOnlyBox']
pub struct VphpModuleProbeReadOnlyBox {
pub:
	title string = 'readonly-box'
	value int
}

@[php_implements: 'VPHP\\Compiler\\ModuleProbeContract']
@[php_class: 'VPHP\\Compiler\\ModuleProbeBox']
pub struct VphpModuleProbeBox {
pub mut:
	name  string = 'box'
	count int
}

@[php_method]
pub fn (b &VphpModuleProbeBox) test_sumtype(val VphpModuleProbeSum) VphpModuleProbeSum {
	match val {
		int { return VphpModuleProbeSum(val + 100) }
		string { return VphpModuleProbeSum('hello:${val}') }
	}
}

@[php_method]
pub fn (b &VphpModuleProbeBox) test_enum_echo(kind VphpModuleProbeKind) VphpModuleProbeKind {
	return kind
}

@[php_method]
pub fn (b &VphpModuleProbeBox) test_sumtype_echo(val VphpModuleProbeSumType) VphpModuleProbeSumType {
	return val
}

@[php_method]
pub fn (b &VphpModuleProbeBox) test_variadic(sep string, args ...string) string {
	return args.join(sep)
}

@[php_method]
pub fn (b &VphpModuleProbeBox) test_struct_param(box &VphpModuleProbeReadOnlyBox) string {
	return box.title
}

@[php_method]
pub fn (b &VphpModuleProbeBox) label() string {
	return '${b.name}:${b.count}'
}

@[php_method: 'compoundIdentity']
@[php_arg_type(value: '(Iterator&Countable)|ArrayObject|int|null')]
@[php_return_type: '(Iterator&Countable)|ArrayObject|int|null']
pub fn (b &VphpModuleProbeBox) compound_identity(value vphp.PhpValue) vphp.PhpValue {
	return value
}

@[php_method: 'stepReference']
pub fn (b &VphpModuleProbeBox) step_reference(ctx vphp.Context, cursor vphp.PhpReference) bool {
	cursor.set(vphp.ZVal.new_int(cursor.deref().to_i64() + i64(b.count)))
	return ctx.num_args() == 1 && !vphp.has_exception()
}

@[php_method: 'staticLabel']
pub fn VphpModuleProbeBox.static_label() string {
	return 'box-static-label'
}

@[php_class: 'VPHP\\Compiler\\CopyableBox']
@[vphp.PhpObjectCopy(cloneable: true, serializable: true)]
pub struct VphpCopyableBox {
pub mut:
	count int
mut:
	hidden        int           @[php_ignore]
	clone_pending bool          @[php_ignore]
	held          vphp.PhpValue @[php_ignore]
}

pub fn (b &VphpCopyableBox) clone_into(mut target VphpCopyableBox) {
	target.count = b.count
	target.hidden = b.hidden
	target.clone_pending = true
	target.held = b.held.owned()
}

@[vphp.PhpExportMethod(name: 'hold')]
pub fn (mut b VphpCopyableBox) hold(value vphp.PhpValue) {
	b.held.release()
	b.held = value.owned()
}

pub fn (mut b VphpCopyableBox) init_php_state() {
	if b.clone_pending {
		if state := vphp.owned_object_php_state(b) {
			state.bool('clone_initialized', true)
			b.clone_pending = false
		}
	}
}

@[php_method: 'cloneInitialized']
pub fn (b &VphpCopyableBox) clone_initialized() bool {
	state := vphp.owned_object_php_state(b) or { return false }
	return state.bool_at('clone_initialized', false)
}

@[php_method]
pub fn (mut b VphpCopyableBox) bump(delta int) {
	b.count += delta
	b.hidden += delta * 2
}

@[php_method]
pub fn (b &VphpCopyableBox) state() string {
	return '${b.count}:${b.hidden}'
}

@[php_method: '__serialize']
pub fn (b &VphpCopyableBox) serialize_state() vphp.PhpArray {
	data := vphp.PhpArray.new()
	data.int('count', b.count)
	data.int('hidden', b.hidden)
	return data
}

@[php_method: '__unserialize']
pub fn (mut b VphpCopyableBox) unserialize_state(data vphp.PhpArray) {
	count := data.get('count') or { vphp.ZVal.new_null() }
	hidden := data.get('hidden') or { vphp.ZVal.new_null() }
	if !count.is_long() || !hidden.is_long() {
		vphp.throw_exception('Invalid CopyableBox state', 0)
		return
	}
	b.count = count.to_int()
	b.hidden = hidden.to_int()
}

@[vphp.PhpExportClass(name: 'VPHP\\Compiler\\TaggedBox')]
@[vphp.PhpObjectCopy(cloneable: true, serializable: true)]
@[heap]
pub struct VphpTaggedBox {
	VphpCopyableBox
pub mut:
	tag string
}

pub fn (box &VphpTaggedBox) clone_into(mut target VphpTaggedBox) {
	box.VphpCopyableBox.clone_into(mut target.VphpCopyableBox)
	target.tag = box.tag.clone()
}

@[vphp.PhpExportMethod(name: '__serialize')]
pub fn (box &VphpTaggedBox) serialize_tagged_state() vphp.PhpArray {
	data := box.VphpCopyableBox.serialize_state()
	data.string('tag', box.tag)
	return data
}

@[vphp.PhpExportMethod(name: '__unserialize')]
pub fn (mut box VphpTaggedBox) unserialize_tagged_state(data vphp.PhpArray) {
	tag := data.string_value('tag') or {
		vphp.PhpException.raise_class('UnexpectedValueException', 'Invalid TaggedBox tag', 0)
		return
	}
	box.VphpCopyableBox.unserialize_state(data)
	if !vphp.PhpException.has_current() {
		box.tag = tag.value()
	}
}

@[vphp.PhpExportClass(name: 'VPHP\\Compiler\\NumberedBox')]
@[vphp.PhpObjectCopy(cloneable: true, serializable: false)]
@[heap]
pub struct VphpNumberedBox {
	VphpTaggedBox
pub mut:
	number int
}

pub fn (box &VphpNumberedBox) clone_into(mut target VphpNumberedBox) {
	box.VphpTaggedBox.clone_into(mut target.VphpTaggedBox)
	target.number = box.number
}

@[php_function]
pub fn v_compiler_probe() string {
	return 'module-probe-ok'
}

@[php_function]
pub fn v_compiler_probe_named_sum(value ?VphpModuleProbeSumType) ?VphpModuleProbeSumType {
	return value
}

@[php_arg_type: 'value=VPHP\\Compiler\\ModuleProbeKind|VPHP\\Compiler\\OtherProbeKind']
@[php_return_type: 'VPHP\\Compiler\\ModuleProbeKind|VPHP\\Compiler\\OtherProbeKind']
@[php_function]
pub fn v_compiler_probe_explicit_union(value vphp.PhpValue) vphp.PhpValue {
	return value
}

@[php_arg_type(value: 'Iterator&Countable')]
@[php_return_type: 'Iterator&Countable']
@[php_function]
pub fn v_compiler_probe_intersection(value vphp.PhpValue) vphp.PhpValue {
	return value
}

@[php_return_type: '(Iterator&Countable)|ArrayObject']
@[php_function]
pub fn v_compiler_probe_wrong_dnf_return() vphp.PhpValue {
	return vphp.PhpValue.from_zval(vphp.ZVal.new_int(10))
}

@[php_function]
pub fn v_compiler_probe_variadic(args ...int) int {
	mut sum := 0
	for val in args { sum += val }
	return sum
}

@[php_function]
pub fn v_compiler_probe_options(options VphpModuleProbeOptions) string {
	return '${options.prefix}:${options.count}'
}

struct VphpModuleProbeConsts {
	max_limit     int    = 100
	const_version string = '1.0.0'
	is_active     bool   = true
}

const compiler_probe_consts = VphpModuleProbeConsts{
	max_limit:     100
	const_version: '1.0.0'
	is_active:     true
}

@[php_class: 'VPHP\\Compiler\\ModuleProbeTypedConsts']
@[php_const: 'compiler_probe_consts']
pub struct VphpModuleProbeTypedConsts {}

@[php_class: 'VPHP\\Compiler\\ModuleProbeWrapperBox']
pub struct VphpModuleProbeWrapperBox {
pub mut:
	val vphp.PhpValue
	obj vphp.PhpObject
	str vphp.PhpString
	num vphp.PhpInt
	b   vphp.PhpBool
	arr vphp.PhpArray
}

@[php_method]
pub fn (mut b VphpModuleProbeWrapperBox) change_props(new_val vphp.PhpValue, new_obj vphp.PhpObject, new_str vphp.PhpString, new_num vphp.PhpInt, new_b vphp.PhpBool, new_arr vphp.PhpArray) {
	b.val = new_val.retain()
	b.obj = new_obj.retain()
	b.str = new_str.retain()
	b.num = new_num.retain()
	b.b = new_b.retain()
	b.arr = new_arr.retain()
}

@[vphp.PhpStringParam('value', php_name: 'defaultValue', default_value: 'line\n"\\\${token}雪\x00', optional: true)]
@[php_arg_default(suffix: '""')]
@[php_function]
pub fn v_typed_string_param(prefix string, value string, suffix string) string {
	return prefix + value + suffix
}

@[vphp.PhpStringParam('value', php_name: 'text', default_value: '', optional: false)]
@[php_function]
pub fn v_typed_required_string_param(value string) string {
	return value
}
