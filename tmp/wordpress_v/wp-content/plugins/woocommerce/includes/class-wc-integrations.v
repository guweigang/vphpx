import rt

struct Class_WC_Integrations {
	rt.PhpObjectBase
pub mut:
		integrations rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Integrations) construct()  {
	rt.call_function('do_action', [rt.new_string('woocommerce_integrations_init')])
	mut var_load_integrations := rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Integration_MaxMind_Geolocation' }])
	var_load_integrations = rt.call_function('apply_filters', [rt.new_string('woocommerce_integrations'), var_load_integrations.dup()])
	{
		mut iter_1 := var_load_integrations.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_integration := item_1.val
			mut var_load_integration := rt.create_object_dynamically(var_integration, []rt.PhpVal{})
			this.integrations.array_set(rt.get_property(var_load_integration, 'id'), var_load_integration.dup())
		}
	}
}

fn (mut this Class_WC_Integrations) get_integrations() rt.PhpVal {
	return this.integrations
}

fn (mut this Class_WC_Integrations) get_integration(var_id rt.PhpVal) rt.PhpVal {
	if this.integrations.array_isset(var_id) {
		return this.integrations.array_get(var_id)
	}
	return rt.new_null()
}

fn create_wc_integrations() &Class_WC_Integrations {
	mut obj := &Class_WC_Integrations{
		PhpObjectBase: rt.PhpObjectBase{}
		integrations: rt.new_array()
	}
	obj.construct()
	return obj
}

fn (mut this Class_WC_Integrations) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_integrations' {
			return this.get_integrations()
		}
		'get_integration' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_integration(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Integrations) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'integrations' { return this.integrations }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Integrations) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'integrations' { this.integrations = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
	rt.register_class_factory('WC_Integrations', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_integrations()
		return rt.new_object('WC_Integrations', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_class_wc_integrations_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
