module module_probex

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
