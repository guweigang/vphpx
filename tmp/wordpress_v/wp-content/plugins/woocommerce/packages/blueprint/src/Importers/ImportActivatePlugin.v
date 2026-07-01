import rt

struct Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin) process(var_schema rt.PhpVal) rt.PhpVal {
	mut var_result := fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{}
		return temp.success(arg_0)
	}(fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin{}
		return temp.get_step_name()
	}())
	mut var_plugin_path := rt.get_property(var_schema, 'pluginPath')
	mut var_activate := this.wp_activate_plugin(var_plugin_path.dup())
	if rt.is_true(this.is_wp_error(var_activate.dup())) {
		rt.call_method(var_result, 'add_error', [
			rt.new_string('Unable to activate ${var_plugin_path.to_string()}.'),
		])
	} else {
		rt.call_method(var_result, 'add_info', [
			rt.new_string('Activated ${var_plugin_path.to_string()}.'),
		])
	}
	return var_result.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin) get_step_class() string {
	return (Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin.class()).str()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin) check_step_capabilities(var_schema rt.PhpVal) bool {
	return (rt.call_function('current_user_can', [rt.new_string('activate_plugins')])).to_bool()
}

struct Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_importers_importactivateplugin() &Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_stepprocessorresult() &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_StepProcessorResult{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_activateplugin() &Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Importers_ImportActivatePlugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_importers_importactivateplugin_php() {
}
