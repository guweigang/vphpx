import rt

struct Class_WC_Customer_Data_Store_Session {
	rt.PhpObjectBase
pub mut:
	session_keys rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Customer_Data_Store_Session) create(var_customer rt.PhpVal) {
	this.save_to_session(var_customer.clone())
}

fn (mut this Class_WC_Customer_Data_Store_Session) update(var_customer rt.PhpVal) {
	this.save_to_session(var_customer.clone())
}

fn (mut this Class_WC_Customer_Data_Store_Session) save_to_session(var_customer rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'session')))))
	{
		rt.call_function('wc_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('__', [
				rt.new_string('WC_Session is not available, customer data cannot be saved to session.'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('9.8.0')])
		return
	}
	mut var_data := this.get_customer_session_data(var_customer.clone())
	if this.is_default_customer_data(mut rt.cast_object_ptr[Class_array](var_data)) {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
			rt.new_string('customer'),
			rt.new_null(),
		])
	} else {
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
			rt.new_string('customer'),
			var_data.clone(),
		])
	}
}

fn (mut this Class_WC_Customer_Data_Store_Session) read(var_customer rt.PhpVal) {
	mut var_data := rt.cast_array(rt.call_method(rt.get_property(rt.call_function('WC',
		[]rt.PhpVal{}), 'session'), 'get', [rt.new_string('customer')]))
	if var_data.array_isset(rt.new_string('id'))
		&& var_data.array_isset(rt.new_string('date_modified'))
		&& rt.is_true(rt.identical(var_data.array_get(rt.new_string('id')), (rt.call_method(var_customer, 'get_id', []rt.PhpVal{})).str()))
		&& rt.is_true(rt.identical(var_data.array_get(rt.new_string('date_modified')), (rt.call_method(var_customer, 'get_date_modified', [rt.new_string('edit')])).str())) {
		mut iter_1 := this.session_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_session_key := item_1.val
			if rt.is_true(rt.call_function('in_array', [var_session_key.clone(),
				rt.create_array([rt.ArrayItem{ key: none, val: 'id' },
					rt.ArrayItem{ key: none, val: 'date_modified' }]),
				rt.new_bool(true)]))
			{
				continue
			}
			mut var_function_key := var_session_key.clone()
			if rt.is_true(rt.identical(rt.new_string('billing_'), rt.call_function('substr', [
				var_session_key.clone(),
				rt.new_int(0),
				rt.new_int(8),
			])))
			{
				var_session_key = rt.call_function('str_replace', [
					rt.new_string('billing_'),
					rt.new_string(''),
					var_session_key.clone(),
				])
			}
			if !(!rt.is_true(var_data.array_get(var_session_key)))
				&& rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{
				key: none
				val: var_customer
			}, rt.ArrayItem{ key: none, val: 'set_${var_function_key.to_string()}' }])]) {
				if rt.is_true(rt.identical(rt.new_string('meta_data'), var_session_key)) {
					if rt.is_true(rt.new_bool(var_data.array_get(var_session_key).is_array())) {
						mut iter_2 := var_data.array_get(var_session_key).iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_meta_data_value := item_2.val
							if !(var_meta_data_value.array_isset(rt.new_string('key'))
								&& var_meta_data_value.array_isset(rt.new_string('value'))) {
								continue
							}
							rt.call_method(var_customer, 'add_meta_data', [
								var_meta_data_value.array_get(rt.new_string('key')),
								var_meta_data_value.array_get(rt.new_string('value')),
								rt.new_bool(true),
							])
						}
					}
				} else {
					rt.call_method(var_customer, 'set_${var_function_key.to_string()}', [
						rt.call_function('wp_unslash', [var_data.array_get(var_session_key)]),
					])
				}
			}
		}
	}
	this.set_defaults(var_customer.clone())
	rt.call_method(var_customer, 'set_object_read', [rt.new_bool(true)])
}

fn (mut this Class_WC_Customer_Data_Store_Session) set_defaults(var_customer rt.PhpVal) {
	mut var_default := rt.call_function('wc_get_customer_default_location', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_has_shipping_address := rt.call_method(var_customer, 'has_shipping_address',
		[]rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_billing_country',
		[]rt.PhpVal{})))))
	{
		rt.call_method(var_customer, 'set_billing_country', [
			var_default.array_get(rt.new_string('country')),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_shipping_country', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_has_shipping_address)))) {
		rt.call_method(var_customer, 'set_shipping_country', [
			rt.call_method(var_customer, 'get_billing_country', []rt.PhpVal{}),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_billing_state',
		[]rt.PhpVal{})))))
	{
		rt.call_method(var_customer, 'set_billing_state', [
			var_default.array_get(rt.new_string('state')),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_shipping_state', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_has_shipping_address)))) {
		rt.call_method(var_customer, 'set_shipping_state', [
			rt.call_method(var_customer, 'get_billing_state', []rt.PhpVal{}),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_customer, 'get_billing_email', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		mut var_current_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
		rt.call_method(var_customer, 'set_billing_email', [
			rt.get_property(var_current_user, 'user_email'),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WC_Data_Exception') {
		mut var_e := var_e_1.clone()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
}

fn (mut this Class_WC_Customer_Data_Store_Session) delete(var_customer rt.PhpVal, var_args rt.PhpVal) {
	rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'session'), 'set', [
		rt.new_string('customer'),
		rt.new_null(),
	])
}

fn (mut this Class_WC_Customer_Data_Store_Session) get_last_order(var_customer rt.PhpVal) bool {
	return false
}

fn (mut this Class_WC_Customer_Data_Store_Session) get_order_count(var_customer rt.PhpVal) i64 {
	return 0
}

fn (mut this Class_WC_Customer_Data_Store_Session) get_total_spent(var_customer rt.PhpVal) i64 {
	return 0
}

fn (mut this Class_WC_Customer_Data_Store_Session) get_customer_session_data(var_customer rt.PhpVal) rt.PhpVal {
	mut var_data := rt.new_array()
	mut iter_3 := this.session_keys.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_session_key := item_3.val
		mut var_function_key := var_session_key.clone()
		if rt.is_true(rt.identical(rt.new_string('billing_'), rt.call_function('substr', [
			var_session_key.clone(),
			rt.new_int(0),
			rt.new_int(8),
		])))
		{
			var_session_key = rt.call_function('str_replace', [
				rt.new_string('billing_'), rt.new_string(''),
				var_session_key.clone()])
		}
		if rt.is_true(rt.identical(rt.new_string('meta_data'), var_session_key)) {
			mut var_allowed_keys := rt.call_function('apply_filters', [
				rt.new_string('woocommerce_customer_allowed_session_meta_keys'),
				rt.new_array(),
				var_customer.clone(),
			])
			mut var_session_value := rt.new_array()
			mut iter_4 := rt.call_method(var_customer, 'get_meta_data', []rt.PhpVal{}).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_meta_data := item_4.val
				if rt.is_true(rt.call_function('in_array', [
					rt.get_property(var_meta_data, 'key'),
					var_allowed_keys.clone(),
					rt.new_bool(true),
				]))
				{
					var_session_value.array_push(rt.create_array([
						rt.ArrayItem{ key: 'key', val: rt.get_property(var_meta_data, 'key') },
						rt.ArrayItem{ key: 'value', val: rt.get_property(var_meta_data, 'value') },
					]))
				}
			}
			var_data.array_set('meta_data', var_session_value.clone())
		} else {
			var_session_value = rt.call_method(var_customer, 'get_${var_function_key.to_string()}', [
				rt.new_string('edit'),
			])
			var_data.array_set(var_session_key, var_session_value.str())
		}
	}
	return var_data.clone()
}

fn (mut this Class_WC_Customer_Data_Store_Session) is_default_customer_data(mut var_customer_data Class_array) bool {
	mut var_default_customer := create_wc_customer()
	this.set_defaults(rt.new_object('WC_Customer', []string{}, var_default_customer))
	return (rt.identical(var_customer_data, this.get_customer_session_data(rt.new_object('WC_Customer',
		[]string{}, var_default_customer)))).to_bool()
}

struct Class_WC_Data_Store_WP {
	rt.PhpObjectBase
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

fn create_wc_customer_data_store_session(_args ...rt.PhpVal) &Class_WC_Customer_Data_Store_Session {
	mut obj := &Class_WC_Customer_Data_Store_Session{
		PhpObjectBase: rt.PhpObjectBase{}
		session_keys:  rt.new_array()
	}
	return obj
}

fn create_wc_data_store_wp(_args ...rt.PhpVal) &Class_WC_Data_Store_WP {
	mut obj := &Class_WC_Data_Store_WP{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_customer(_args ...rt.PhpVal) &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Customer_Data_Store_Session) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'save_to_session' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.save_to_session(dispatch_arg_0)
			return rt.new_null()
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'set_defaults' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_defaults(dispatch_arg_0)
			return rt.new_null()
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_last_order' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_last_order(dispatch_arg_0))
		}
		'get_order_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get_order_count(dispatch_arg_0))
		}
		'get_total_spent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get_total_spent(dispatch_arg_0))
		}
		'get_customer_session_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_customer_session_data(dispatch_arg_0)
		}
		'is_default_customer_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.is_default_customer_data(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Customer_Data_Store_Session) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'session_keys' { return this.session_keys }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Customer_Data_Store_Session) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'session_keys' {
			this.session_keys = val
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

fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
