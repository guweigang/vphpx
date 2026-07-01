import rt

struct Class_Akismet_Connector {
	rt.PhpObjectBase
}

fn Class_Akismet_Connector.init()  {
	rt.call_function('add_action', [rt.new_string('wp_connectors_init'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Connector' }, rt.ArrayItem{ key: none, val: 'register_connector' }])])
	rt.call_function('add_filter', [rt.new_string('rest_post_dispatch'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Connector' }, rt.ArrayItem{ key: none, val: 'validate_api_key' }]), rt.new_int(9), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('script_module_data_options-connectors-wp-admin'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Connector' }, rt.ArrayItem{ key: none, val: 'set_connected_status' }]), rt.new_int(11)])
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'add' }, rt.ArrayItem{ key: none, val: 'update' }, rt.ArrayItem{ key: none, val: 'delete' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action := item_1.val
			rt.call_function('add_action', [rt.new_string("${var_action.to_string()}_option_wordpress_api_key"), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Connector' }, rt.ArrayItem{ key: none, val: 'invalidate_key_status_cache' }])])
		}
	}
}

fn Class_Akismet_Connector.validate_api_key(var_response rt.PhpVal, var_server rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_response.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return var_response.dup()
	}
	mut var_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.dup().is_array()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.dup().array_isset(rt.new_string('wordpress_api_key'))))))))) {
		return var_response.dup()
	}
	mut var_key := var_data.array_get('wordpress_api_key')
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_key.dup().is_string()))))) || rt.is_true(rt.identical(rt.new_string(''), var_key)))) {
		return var_response.dup()
	}
	if rt.is_true(rt.identical(Class_Akismet.key_status_invalid(), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.verify_key(arg_0) }(var_key.dup()))) {
		rt.call_function('update_option', [rt.new_string('wordpress_api_key'), rt.new_string('')])
		var_data.array_set('wordpress_api_key', '')
		rt.call_method(var_response, 'set_data', [var_data.dup()])
	}
	return var_response.dup()
}

fn Class_Akismet_Connector.set_connected_status(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if !(var_data_mutated.array_get('connectors').array_get('akismet').array_isset(rt.new_string('authentication'))) {
		return var_data_mutated.dup()
	}
	mut var_key := fn () rt.PhpVal { mut temp := Class_Akismet{}; return temp.get_api_key() }()
	if !rt.is_true(var_key) {
		var_data_mutated.array_get_mut('connectors').array_get_mut('akismet').array_get_mut('authentication').array_set('isConnected', false)
		return var_data_mutated.dup()
	}
	mut var_is_connected := rt.call_function('get_transient', [rt.new_string('akismet_connector_key_status')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_is_connected)) {
		var_is_connected = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.verify_key(arg_0) }(var_key.dup())
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_function('set_transient', [rt.new_string('akismet_connector_key_status'), var_is_connected.dup(), rt.get_constant('DAY_IN_SECONDS')])
		}
	}
	var_data_mutated.array_get_mut('connectors').array_get_mut('akismet').array_get_mut('authentication').array_set('isConnected', rt.identical(Class_Akismet.key_status_valid(), var_is_connected))
	return var_data_mutated.dup()
}

fn Class_Akismet_Connector.invalidate_key_status_cache()  {
	rt.call_function('delete_transient', [rt.new_string('akismet_connector_key_status')])
}

fn Class_Akismet_Connector.register_connector(var_registry rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('method_exists', [var_registry.dup(), rt.new_string('is_registered')])) && rt.is_true(rt.call_method(var_registry, 'is_registered', [rt.new_string('akismet')])))) {
		rt.call_method(var_registry, 'unregister', [rt.new_string('akismet')])
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	return rt.call_function('defined', [rt.new_string('AKISMET_VERSION')])
	}
	rt.call_method(var_registry, 'register', [rt.new_string('akismet'), rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Akismet Anti-spam'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Protect your site from spam.'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'type', val: 'spam_filtering' }, rt.ArrayItem{ key: 'plugin', val: rt.create_array([rt.ArrayItem{ key: 'file', val: 'akismet/akismet.php' }, rt.ArrayItem{ key: 'is_active', val: rt.new_closure(closure_1_fn) }]) }, rt.ArrayItem{ key: 'authentication', val: rt.create_array([rt.ArrayItem{ key: 'method', val: 'api_key' }, rt.ArrayItem{ key: 'credentials_url', val: 'https://akismet.com/get/' }, rt.ArrayItem{ key: 'setting_name', val: 'wordpress_api_key' }, rt.ArrayItem{ key: 'constant_name', val: 'WPCOM_API_KEY' }]) }])])
}

struct Class_Akismet {
	rt.PhpObjectBase
}

fn create_akismet_connector() &Class_Akismet_Connector {
	mut obj := &Class_Akismet_Connector{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet() &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet_Connector) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Akismet_Connector.init()
			return rt.new_null()
		}
		'validate_api_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Akismet_Connector.validate_api_key(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'set_connected_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_Connector.set_connected_status(dispatch_arg_0)
		}
		'invalidate_key_status_cache' {
			Class_Akismet_Connector.invalidate_key_status_cache()
			return rt.new_null()
		}
		'register_connector' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Akismet_Connector.register_connector(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Akismet_Connector) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Connector) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Akismet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_akismet_class_akismet_connector_php() {
	// unsupported statement: Stmt_Declare
}
