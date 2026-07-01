import rt

struct Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions {
	rt.PhpObjectBase
pub mut:
		options rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions) construct(mut var_options Class_Automattic_WooCommerce_Blueprint_Steps_array)  {
	this.options = var_options.dup()
}

fn Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions.get_step_name() string {
	return 'setSiteOptions'
}

fn Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions.get_schema(version i64) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'step', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions.get_step_name() }]) }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: 'step' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions) prepare_json_array() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'step', val: Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions.get_step_name() }, rt.ArrayItem{ key: 'options', val: // unsupported expression: Expr_Cast_Object }])
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_Step {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_steps_setsiteoptions(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions{
		PhpObjectBase: rt.PhpObjectBase{}
		options: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_step() &Class_Automattic_WooCommerce_Blueprint_Steps_Step {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_Step{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_Steps_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_step_name' {
			return rt.new_string(Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions.get_step_name())
		}
		'get_schema' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions.get_schema(dispatch_arg_0)
		}
		'prepare_json_array' {
			return this.prepare_json_array()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'options' { return this.options }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'options' { this.options = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_steps_setsiteoptions_php() {
}
