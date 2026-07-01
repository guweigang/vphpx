import rt

struct Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin {
	rt.PhpObjectBase
pub mut:
	plugin_name rt.PhpVal = rt.new_null()
	plugin_path rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin) construct(var_plugin_path rt.PhpVal, plugin_name string) {
	this.plugin_name = rt.new_string(plugin_name).dup()
	this.plugin_path = var_plugin_path.dup()
}

fn Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin.get_step_name() string {
	return 'activatePlugin'
}

fn Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin.get_schema(version i64) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'step', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'enum', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin.get_step_name()
					},
				]) },
			]) },
			rt.ArrayItem{ key: 'pluginName', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
			]) },
			rt.ArrayItem{ key: 'pluginPath', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
			]) },
		]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'step' },
			rt.ArrayItem{ key: none, val: 'pluginPath' },
		]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin) prepare_json_array() rt.PhpVal {
	mut var_data := rt.create_array([
		rt.ArrayItem{
			key: 'step'
			val: Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin.get_step_name()
		},
		rt.ArrayItem{ key: 'pluginPath', val: this.plugin_path },
	])
	if !(!rt.is_true(this.plugin_name)) {
		var_data.array_set('pluginName', this.plugin_name)
	}
	return var_data.dup()
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_Step {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_steps_activateplugin(plugin_name string, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin{
		PhpObjectBase: rt.PhpObjectBase{}
		plugin_name:   rt.new_null()
		plugin_path:   rt.new_null()
	}
	obj.construct(plugin_name, arg_1)
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_step() &Class_Automattic_WooCommerce_Blueprint_Steps_Step {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_Step{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_step_name' {
			return rt.new_string(Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin.get_step_name())
		}
		'get_schema' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin.get_schema(dispatch_arg_0)
		}
		'prepare_json_array' {
			return this.prepare_json_array()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'plugin_name' { return this.plugin_name }
		'plugin_path' { return this.plugin_path }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_ActivatePlugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'plugin_name' {
			this.plugin_name = val
			return true
		}
		'plugin_path' {
			this.plugin_path = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_Step) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_Step) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_Step) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_steps_activateplugin_php() {
}
