import rt

struct Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme {
	rt.PhpObjectBase
pub mut:
	theme_folder_name rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme) construct(var_theme_folder_name rt.PhpVal) {
	this.theme_folder_name = var_theme_folder_name.clone()
}

fn Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme.get_step_name() string {
	return 'activateTheme'
}

fn Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme.get_schema(version i64) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'step', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'enum', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme.get_step_name()
					},
				]) },
			]) },
			rt.ArrayItem{ key: 'themeFolderName', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
			]) },
		]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'step' },
			rt.ArrayItem{ key: none, val: 'themeFolderName' },
		]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme) prepare_json_array() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: 'step'
			val: Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme.get_step_name()
		},
		rt.ArrayItem{ key: 'themeFolderName', val: this.theme_folder_name },
	])
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_Step {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_steps_activatetheme(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme{
		PhpObjectBase:     rt.PhpObjectBase{}
		theme_folder_name: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_step(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Steps_Step {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_Step{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_step_name' {
			return rt.new_string(Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme.get_step_name())
		}
		'get_schema' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme.get_schema(dispatch_arg_0)
		}
		'prepare_json_array' {
			return this.prepare_json_array()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'theme_folder_name' { return this.theme_folder_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_ActivateTheme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'theme_folder_name' {
			this.theme_folder_name = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}
