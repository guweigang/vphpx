module main

import vphp

@[php_interface: 'VPHP\\Compiler\\ModuleProbeContract']
pub interface VphpModuleProbeContract {
	label() string
}

@[php_enum: 'VPHP\\Compiler\\ModuleProbeKind']
pub enum VphpModuleProbeKind {
	alpha = 7
	beta  = 11
}

@[params]
pub struct VphpModuleProbeOptions {
pub:
	prefix string = 'default'
	count  int    = 3
}

@[php_const]
const compiler_probe_constant = 'module-constant-ok'

pub type VphpModuleProbeSum = int | string
pub type VphpModuleProbeSumType = int | VphpModuleProbeReadOnlyBox | VphpModuleProbeKind

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

@[php_method: 'staticLabel']
pub fn VphpModuleProbeBox.static_label() string {
	return 'box-static-label'
}

@[php_function]
pub fn v_compiler_probe() string {
	return 'module-probe-ok'
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
	max_limit: 100
	const_version: '1.0.0'
	is_active: true
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
