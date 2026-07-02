import rt

struct Class_WC_Payment_Token_Data_Store {
	rt.PhpObjectBase
pub mut:
	meta_type        rt.PhpVal = rt.new_string('payment_token')
	extra_data_saved rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WC_Payment_Token_Data_Store) create(var_token rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_token, 'validate',
		[]rt.PhpVal{})))
	{
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Invalid or missing payment token fields.'),
			rt.new_string('woocommerce'),
		]))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_token, 'is_default', []rt.PhpVal{})))))
		&& rt.is_true(rt.greater(rt.call_method(var_token, 'get_user_id', []rt.PhpVal{}), rt.new_int(0))) {
		mut iife_temp_0 := Class_WC_Payment_Tokens{}
		mut iife_result_0 := iife_temp_0.get_customer_default_token(rt.call_method(var_token,
			'get_user_id', []rt.PhpVal{}))
		mut var_default_token := iife_result_0
		if rt.is_true(rt.new_bool(var_default_token.clone().is_null())) {
			rt.call_method(var_token, 'set_default', [rt.new_bool(true)])
		}
	}
	mut var_payment_token_data := rt.create_array([
		rt.ArrayItem{ key: 'gateway_id', val: rt.call_method(var_token, 'get_gateway_id', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'token', val: rt.call_method(var_token, 'get_token', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'user_id', val: rt.call_method(var_token, 'get_user_id', [
			rt.new_string('edit'),
		]) },
		rt.ArrayItem{ key: 'type', val: rt.call_method(var_token, 'get_type', [
			rt.new_string('edit'),
		]) },
	])
	rt.call_method(var_wpdb, 'insert', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_payment_tokens'),
		var_payment_token_data.clone(),
	])
	mut var_token_id := rt.get_property(var_wpdb, 'insert_id')
	rt.call_method(var_token, 'set_id', [var_token_id.clone()])
	this.save_extra_data(var_token.clone(), true)
	rt.call_method(var_token, 'save_meta_data', []rt.PhpVal{})
	rt.call_method(var_token, 'apply_changes', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_token, 'is_default', []rt.PhpVal{}))
		&& rt.is_true(rt.greater(rt.call_method(var_token, 'get_user_id', []rt.PhpVal{}), rt.new_int(0))) {
		mut iife_temp_1 := Class_WC_Payment_Tokens{}
		mut iife_result_1 := iife_temp_1.set_users_default(rt.call_method(var_token, 'get_user_id',
			[]rt.PhpVal{}), var_token_id.clone())
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_new_payment_token'),
		var_token_id.clone(), var_token.clone()])
}

fn (mut this Class_WC_Payment_Token_Data_Store) update(var_token rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_payment_token_data := rt.new_null()
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_token, 'validate',
		[]rt.PhpVal{})))
	{
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Invalid or missing payment token fields.'),
			rt.new_string('woocommerce'),
		]))))
	}
	mut var_updated_props := rt.new_array()
	mut var_core_props := ['gateway_id', 'token', 'user_id', 'type']
	mut var_changed_props := rt.func_array_keys(rt.call_method(var_token, 'get_changes',
		[]rt.PhpVal{}))
	mut iter_1 := var_changed_props.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_prop := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_prop.clone(), rt.create_array_from_list(var_core_props),
			rt.new_bool(true)])))))
		{
			continue
		}
		var_updated_props.array_push(var_prop.clone())
		var_payment_token_data.array_set(var_prop, rt.call_method(var_token,
			'get_' + var_prop.str(), [rt.new_string('edit')]))
	}
	if !(!rt.is_true(var_payment_token_data)) {
		rt.call_method(var_wpdb, 'update', [
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_payment_tokens'),
			var_payment_token_data.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'token_id', val: rt.call_method(var_token, 'get_id',
					[]rt.PhpVal{}) },
			]),
		])
	}
	mut var_updated_extra_props := this.save_extra_data(var_token.clone(), false)
	var_updated_props = rt.call_function('array_merge', [var_updated_props.clone(),
		var_updated_extra_props.clone()])
	rt.call_method(var_token, 'save_meta_data', []rt.PhpVal{})
	rt.call_method(var_token, 'apply_changes', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_token, 'is_default', []rt.PhpVal{}))
		&& rt.is_true(rt.greater(rt.call_method(var_token, 'get_user_id', []rt.PhpVal{}), rt.new_int(0))) {
		mut iife_temp_2 := Class_WC_Payment_Tokens{}
		mut iife_result_2 := iife_temp_2.set_users_default(rt.call_method(var_token, 'get_user_id',
			[]rt.PhpVal{}), rt.call_method(var_token, 'get_id', []rt.PhpVal{}))
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_payment_token_object_updated_props'),
		var_token.clone(),
		var_updated_props.clone(),
	])
	rt.call_function('do_action', [rt.new_string('woocommerce_payment_token_updated'),
		rt.call_method(var_token, 'get_id', []rt.PhpVal{})])
}

fn (mut this Class_WC_Payment_Token_Data_Store) delete(var_token rt.PhpVal, force_delete bool) {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'delete', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_payment_tokens'),
		rt.create_array([
			rt.ArrayItem{ key: 'token_id', val: rt.call_method(var_token, 'get_id', []rt.PhpVal{}) },
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: '%d' },
		]),
	])
	rt.call_method(var_wpdb, 'delete', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_payment_tokenmeta'),
		rt.create_array([
			rt.ArrayItem{ key: 'payment_token_id', val: rt.call_method(var_token, 'get_id',
				[]rt.PhpVal{}) },
		]),
		rt.create_array([
			rt.ArrayItem{ key: none, val: '%d' },
		]),
	])
	rt.call_function('do_action', [rt.new_string('woocommerce_payment_token_deleted'),
		rt.call_method(var_token, 'get_id', []rt.PhpVal{}), var_token.clone()])
}

fn (mut this Class_WC_Payment_Token_Data_Store) read(var_token rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_data := rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT token, user_id, gateway_id, is_default FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_payment_tokens WHERE token_id = %d LIMIT 1')),
			rt.call_method(var_token, 'get_id', []rt.PhpVal{}),
		]),
	])
	if rt.is_true(var_data) {
		rt.call_method(var_token, 'set_props', [
			rt.create_array([
				rt.ArrayItem{ key: 'token', val: rt.get_property(var_data, 'token') },
				rt.ArrayItem{ key: 'user_id', val: rt.get_property(var_data, 'user_id') },
				rt.ArrayItem{ key: 'gateway_id', val: rt.get_property(var_data, 'gateway_id') },
				rt.ArrayItem{ key: 'default', val: rt.get_property(var_data, 'is_default') },
			]),
		])
		this.read_extra_data(var_token.clone())
		rt.call_method(var_token, 'read_meta_data', []rt.PhpVal{})
		rt.call_method(var_token, 'set_object_read', [rt.new_bool(true)])
		rt.call_function('do_action', [rt.new_string('woocommerce_payment_token_loaded'),
			var_token.clone()])
	} else {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Invalid payment token.'),
			rt.new_string('woocommerce'),
		]))))
	}
}

fn (mut this Class_WC_Payment_Token_Data_Store) read_extra_data(var_token rt.PhpVal) {
	mut iter_2 := rt.call_method(var_token, 'get_extra_data_keys', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_key := item_2.val
		mut var_function := rt.new_string('set_' + var_key.str())
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_token },
				rt.ArrayItem{ key: none, val: var_function }]),
		]))
		{
			rt.call_method(var_token, var_function, [
				rt.call_function('get_metadata', [rt.new_string('payment_token'),
					rt.call_method(var_token, 'get_id', []rt.PhpVal{}),
					var_key.clone(), rt.new_bool(true)]),
			])
		}
	}
}

fn (mut this Class_WC_Payment_Token_Data_Store) save_extra_data(var_token rt.PhpVal, force bool) rt.PhpVal {
	if rt.is_true(this.extra_data_saved) {
		return rt.new_array()
	}
	mut var_updated_props := rt.new_array()
	mut var_extra_data_keys := rt.call_method(var_token, 'get_extra_data_keys', []rt.PhpVal{})
	mut var_meta_key_to_props := if !(!rt.is_true(var_extra_data_keys)) { rt.call_function('array_combine', [
			var_extra_data_keys.clone(),
			var_extra_data_keys.clone(),
		]) } else { rt.new_array() }
	mut var_props_to_update := if var_force {
		var_meta_key_to_props
	} else {
		this.get_props_to_update(var_token.clone(), var_meta_key_to_props.clone())
	}
	mut iter_3 := var_extra_data_keys.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_key := item_3.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_props_to_update.clone().array_isset(var_key.clone())))))) {
			continue
		}
		mut var_function := rt.new_string('get_' + var_key.str())
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_token },
				rt.ArrayItem{ key: none, val: var_function }]),
		]))
		{
			if rt.is_true(rt.call_function('update_metadata', [
				rt.new_string('payment_token'),
				rt.call_method(var_token, 'get_id', []rt.PhpVal{}),
				var_key.clone(),
				rt.call_method(var_token, var_function, [rt.new_string('edit')]),
			]))
			{
				var_updated_props.array_push(var_key.clone())
			}
		}
	}
	return var_updated_props.clone()
}

fn (mut this Class_WC_Payment_Token_Data_Store) get_tokens(var_args rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'token_id', val: '' },
			rt.ArrayItem{ key: 'user_id', val: '' }, rt.ArrayItem{ key: 'gateway_id', val: '' },
			rt.ArrayItem{ key: 'type', val: '' }])])
	mut var_sql := rt.new_string((rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
		'prefix')), rt.new_string('woocommerce_payment_tokens'))).str())
	mut var_where := [rt.new_string('1=1')]
	if rt.is_true(var_args_mutated.array_get(rt.new_string('token_id'))) {
		mut var_token_ids := rt.call_function('array_map', [rt.new_string('absint'), if var_args_mutated.array_get(rt.new_string('token_id')).is_array() { var_args_mutated.array_get(rt.new_string('token_id')) } else { rt.create_array([
				rt.ArrayItem{ key: none, val: var_args_mutated.array_get(rt.new_string('token_id')) },
			]) }])
		var_where <<
			"token_id IN ('" + (rt.call_function('implode', [rt.new_string("','"), rt.call_function('array_map', [rt.new_string('esc_sql'), var_token_ids.clone()])])).str() +
			"')"
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('user_id'))) {
		var_where << rt.call_method(var_wpdb, 'prepare', [rt.new_string('user_id = %d'),
			rt.call_function('absint', [var_args_mutated.array_get(rt.new_string('user_id'))])])
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('gateway_id'))) {
		mut var_gateway_ids := rt.create_array([
			rt.ArrayItem{ key: none, val: var_args_mutated.array_get(rt.new_string('gateway_id')) },
		])
	} else {
		mut iife_temp_3 := Class_WC_Payment_Gateways{}
		mut iife_result_3 := iife_temp_3.instance()
		mut var_gateways := iife_result_3
		var_gateway_ids = rt.call_method(var_gateways, 'get_payment_gateway_ids', []rt.PhpVal{})
	}
	mut var_page := if var_args_mutated.array_isset(rt.new_string('page')) { rt.call_function('absint', [
			var_args_mutated.array_get(rt.new_string('page')),
		]) } else { rt.new_int(1) }
	mut var_posts_per_page := rt.call_function('absint', [if var_args_mutated.array_isset(rt.new_string('limit')) { var_args_mutated.array_get(rt.new_string('limit')) } else { rt.call_function('get_option', [
			rt.new_string('posts_per_page'),
		]) }])
	mut var_pgstrt := rt.new_string(
		(rt.call_function('absint', [rt.mul(rt.sub(var_page, rt.new_int(1)), var_posts_per_page)])).str() +
		', ')
	mut var_limits := rt.new_string('LIMIT ' + var_pgstrt.str() + var_posts_per_page.str())
	var_gateway_ids.array_push('')
	var_where <<
		"gateway_id IN ('" + (rt.call_function('implode', [rt.new_string("','"), rt.call_function('array_map', [rt.new_string('esc_sql'), var_gateway_ids.clone()])])).str() +
		"')"
	if rt.is_true(var_args_mutated.array_get(rt.new_string('type'))) {
		var_where << rt.call_method(var_wpdb, 'prepare', [rt.new_string('type = %s'),
			var_args_mutated.array_get(rt.new_string('type'))])
	}
	mut var_token_results := rt.call_method(var_wpdb, 'get_results', [
		rt.new_string(var_sql.str() + ' WHERE ' +
			(rt.call_function('implode', [rt.new_string(' AND '), rt.create_array_from_list(var_where)])).str() +
			' ' + var_limits.str()),
	])
	return var_token_results.clone()
}

fn (mut this Class_WC_Payment_Token_Data_Store) get_users_default_token(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM '),
				rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_payment_tokens WHERE user_id = %d AND is_default = 1')),
			var_user_id.clone(),
		]),
	])
}

fn (mut this Class_WC_Payment_Token_Data_Store) get_token_by_id(var_token_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_token_id_mutated := var_token_id
	return rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM '),
				rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_payment_tokens WHERE token_id = %d')),
			var_token_id_mutated.clone(),
		]),
	])
}

fn (mut this Class_WC_Payment_Token_Data_Store) get_metadata(var_token_id rt.PhpVal) rt.PhpVal {
	mut var_token_id_mutated := var_token_id
	return rt.call_function('get_metadata', [rt.new_string('payment_token'),
		var_token_id_mutated.clone()])
}

fn (mut this Class_WC_Payment_Token_Data_Store) get_token_type_by_id(var_token_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_token_id_mutated := var_token_id
	return rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT type FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_payment_tokens WHERE token_id = %d')),
			var_token_id_mutated.clone(),
		]),
	])
}

fn (mut this Class_WC_Payment_Token_Data_Store) set_default_status(var_token_id rt.PhpVal, status bool) {
	mut var_wpdb := rt.new_null()
	mut var_token_id_mutated := var_token_id
	rt.call_method(var_wpdb, 'update', [
		rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_payment_tokens'),
		rt.create_array([rt.ArrayItem{ key: 'is_default', val: i64(status) }]),
		rt.create_array([rt.ArrayItem{ key: 'token_id', val: var_token_id_mutated }]),
	])
}

struct Class_WC_Data_Store_WP {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WC_Payment_Tokens {
	rt.PhpObjectBase
}

struct Class_WC_Payment_Gateways {
	rt.PhpObjectBase
}

fn create_wc_payment_token_data_store(_args ...rt.PhpVal) &Class_WC_Payment_Token_Data_Store {
	mut obj := &Class_WC_Payment_Token_Data_Store{
		PhpObjectBase:    rt.PhpObjectBase{}
		meta_type:        rt.new_string('payment_token')
		extra_data_saved: rt.new_bool(false)
	}
	return obj
}

fn create_wc_data_store_wp(_args ...rt.PhpVal) &Class_WC_Data_Store_WP {
	mut obj := &Class_WC_Data_Store_WP{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_payment_tokens(_args ...rt.PhpVal) &Class_WC_Payment_Tokens {
	mut obj := &Class_WC_Payment_Tokens{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_payment_gateways(_args ...rt.PhpVal) &Class_WC_Payment_Gateways {
	mut obj := &Class_WC_Payment_Gateways{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Payment_Token_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create(dispatch_arg_0)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update(dispatch_arg_0)
			return rt.new_null()
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'read_extra_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read_extra_data(dispatch_arg_0)
			return rt.new_null()
		}
		'save_extra_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.save_extra_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_tokens' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_tokens(dispatch_arg_0)
		}
		'get_users_default_token' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_users_default_token(dispatch_arg_0)
		}
		'get_token_by_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_token_by_id(dispatch_arg_0)
		}
		'get_metadata' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_metadata(dispatch_arg_0)
		}
		'get_token_type_by_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_token_type_by_id(dispatch_arg_0)
		}
		'set_default_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.set_default_status(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Payment_Token_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'meta_type' { return this.meta_type }
		'extra_data_saved' { return this.extra_data_saved }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Payment_Token_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'meta_type' {
			this.meta_type = val
			return true
		}
		'extra_data_saved' {
			this.extra_data_saved = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Data_Store_WP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store_WP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store_WP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Payment_Tokens) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Payment_Tokens) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Tokens) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Payment_Gateways) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Payment_Gateways) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Gateways) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
