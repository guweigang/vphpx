module module_probex

import vphp
@[php_interface: 'VSlim\\Compiler\\ModuleProbeContract']
pub interface VSlimModuleProbeContract {
	label() string
}

@[php_enum: 'VSlim\\Compiler\\ModuleProbeKind']
pub enum VSlimModuleProbeKind {
	alpha = 7
	beta  = 11
}

@[params]
pub struct VSlimModuleProbeOptions {
pub:
	prefix string = 'default'
	count  int    = 3
}

@[php_const]
const module_probe_constant = 'module-constant-ok'

pub type VSlimModuleProbeSum = int | string
pub type VSlimModuleProbeSumType = int | VSlimModuleProbeReadOnlyBox | VSlimModuleProbeKind

@[php_class: 'VSlim\\Compiler\\ModuleProbeReadOnlyBox']
pub struct VSlimModuleProbeReadOnlyBox {
pub:
	title string = 'readonly-box'
	value int
}

@[php_implements: 'VSlim\\Compiler\\ModuleProbeContract']
@[php_class: 'VSlim\\Compiler\\ModuleProbeBox']
pub struct VSlimModuleProbeBox {
pub mut:
	name  string = 'box'
	count int
}

@[php_method]
pub fn (b &VSlimModuleProbeBox) test_sumtype(val VSlimModuleProbeSum) VSlimModuleProbeSum {
	match val {
		int {
			return VSlimModuleProbeSum(val + 100)
		}
		string {
			return VSlimModuleProbeSum('hello:${val}')
		}
	}
}

@[php_method]
pub fn (b &VSlimModuleProbeBox) test_enum_echo(kind VSlimModuleProbeKind) VSlimModuleProbeKind {
	return kind
}

@[php_method]
pub fn (b &VSlimModuleProbeBox) test_sumtype_echo(val VSlimModuleProbeSumType) VSlimModuleProbeSumType {
	return val
}

@[php_method]
pub fn (b &VSlimModuleProbeBox) label() string {
	return '${b.name}:${b.count}'
}

@[php_method: 'staticLabel']
pub fn VSlimModuleProbeBox.static_label() string {
	return 'box-static-label'
}

@[php_function: 'vslim_module_probe']
pub fn module_probe_value() string {
	return 'module-probe-ok'
}

@[php_function: 'vslim_module_probe_options']
pub fn module_probe_options(options VSlimModuleProbeOptions) string {
	return '${options.prefix}:${options.count}'
}

struct VSlimModuleProbeConsts {
	max_limit     int    = 100
	const_version string = '1.0.0'
	is_active     bool   = true
}

const vslim_module_probe_consts = VSlimModuleProbeConsts{
	max_limit: 100
	const_version: '1.0.0'
	is_active: true
}

@[php_class: 'VSlim\\Compiler\\ModuleProbeTypedConsts']
@[php_const: 'vslim_module_probe_consts']
pub struct VSlimModuleProbeTypedConsts {}

@[php_class: 'VSlim\\Compiler\\ModuleProbeWrapperBox']
pub struct VSlimModuleProbeWrapperBox {
pub mut:
	val vphp.PhpValue
	obj vphp.PhpObject
	str vphp.PhpString
	num vphp.PhpInt
	b   vphp.PhpBool
	arr vphp.PhpArray
}

@[php_method]
pub fn (mut b VSlimModuleProbeWrapperBox) change_props(new_val vphp.PhpValue, new_obj vphp.PhpObject, new_str vphp.PhpString, new_num vphp.PhpInt, new_b vphp.PhpBool, new_arr vphp.PhpArray) {
	b.val = new_val.retain()
	b.obj = new_obj.retain()
	b.str = new_str.retain()
	b.num = new_num.retain()
	b.b = new_b.retain()
	b.arr = new_arr.retain()
}

