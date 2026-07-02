import rt

struct Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme) process(var_schema rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme{}
	mut iife_result_0 := iife_temp_0.get_step_name()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{}
	mut iife_result_1 := iife_temp_1.success(iife_result_0)
	mut var_result := iife_result_1
	mut var_name := rt.get_property(var_schema, 'themeName')
	this.wp_switch_theme(var_name.clone())
	mut var_current_theme := rt.call_method(this.wp_get_theme(), 'get_stylesheet', []rt.PhpVal{})
	if rt.is_true(rt.identical(var_current_theme, var_name)) {
		rt.call_method(var_result, 'add_debug', [
			rt.new_string("Switched theme to '${var_name.to_string()}'."),
		])
	}
	return var_result.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme) get_step_class() string {
	return (Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme.class()).str()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme) check_step_capabilities(var_schema rt.PhpVal) bool {
	return (rt.call_function('current_user_can', [rt.new_string('switch_themes')])).to_bool()
}

struct Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_importers_importactivatetheme(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_stepprocessorresult(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_activatetheme(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'process' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.process(dispatch_arg_0)
		}
		'get_step_class' {
			return rt.new_string(this.get_step_class())
		}
		'check_step_capabilities' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_step_capabilities(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivateTheme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_StepProcessorResult) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
