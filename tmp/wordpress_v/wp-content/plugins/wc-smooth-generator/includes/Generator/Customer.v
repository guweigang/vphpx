import rt

struct Class_WC_SmoothGenerator_Generator_Customer {
	rt.PhpObjectBase
}

fn Class_WC_SmoothGenerator_Generator_Customer.generate(save bool, mut var_assoc_args Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_line := rt.new_null()
	this.Class_WC_SmoothGenerator_Generator_Generator.maybe_initialize_generators()
	mut var_args := rt.call_function('filter_var_array', [var_assoc_args, rt.create_array([rt.ArrayItem{ key: 'country', val: rt.create_array([rt.ArrayItem{ key: 'filter', val: rt.get_constant('FILTER_VALIDATE_REGEXP') }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'regexp', val: '/^[A-Za-z]{2}$/' }, rt.ArrayItem{ key: 'default', val: '' }]) }]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'filter', val: rt.get_constant('FILTER_VALIDATE_REGEXP') }, rt.ArrayItem{ key: 'options', val: rt.create_array([rt.ArrayItem{ key: 'regexp', val: '/^(company|person)$/' }]) }]) }])])
	// unsupported assign target: Expr_List
	mut var_country := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_CustomerInfo{}; return temp.get_valid_country_code(arg_0) }(var_country.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_country.dup()])) {
		return var_country.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_type)))) {
		mut var_type := rt.new_string(if rt.is_true(rt.less(rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'randomDigit', []rt.PhpVal{}), rt.new_int(7))) { rt.new_string('person') } else { rt.new_string('company') })
		// unsupported statement: Stmt_Nop
	}
	mut var_keys_for_address := rt.create_array([rt.ArrayItem{ key: none, val: 'email' }])
	mut var_customer_data := rt.create_array([rt.ArrayItem{ key: 'role', val: 'customer' }])
	mut switch_val_1 := var_type
	if true {
		var_customer_data = rt.call_function('array_merge', [var_customer_data.dup(), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_CustomerInfo{}; return temp.generate_person(arg_0) }(var_country.dup())])
		mut var_other_customer_data := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_CustomerInfo{}; return temp.generate_person(arg_0) }(var_country.dup())
		var_keys_for_address.array_push('first_name')
		var_keys_for_address.array_push('last_name')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('company'))) {
		var_customer_data = rt.call_function('array_merge', [var_customer_data.dup(), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_CustomerInfo{}; return temp.generate_company(arg_0) }(var_country.dup())])
		var_other_customer_data = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_CustomerInfo{}; return temp.generate_company(arg_0) }(var_country.dup())
		var_keys_for_address.array_push('company')
	}
	var_customer_data.array_set('billing', rt.call_function('array_merge', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_CustomerInfo{}; return temp.generate_address(arg_0) }(var_country.dup()), rt.call_function('array_intersect_key', [var_customer_data.dup(), rt.call_function('array_fill_keys', [var_keys_for_address.dup(), rt.new_string('')])])]))
	mut var_has_shipping := rt.less(rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'randomDigit', []rt.PhpVal{}), rt.new_int(5))
	if rt.is_true(var_has_shipping) {
		mut var_same_shipping := rt.less(rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'randomDigit', []rt.PhpVal{}), rt.new_int(5))
		if rt.is_true(var_same_shipping) {
			var_customer_data.array_set('shipping', var_customer_data.array_get('billing'))
		} else {
			var_customer_data.array_set('shipping', rt.call_function('array_merge', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_CustomerInfo{}; return temp.generate_address(arg_0) }(var_country.dup()), rt.call_function('array_intersect_key', [var_other_customer_data.dup(), rt.call_function('array_fill_keys', [var_keys_for_address.dup(), rt.new_string('')])])]))
		}
	}
	var_customer_data.array_unset(rt.new_string('company'))
	var_customer_data.array_get('shipping').array_unset(rt.new_string('email'))
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'billing' }, rt.ArrayItem{ key: none, val: 'shipping' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_address_type := item_1.val
			if var_customer_data.array_isset(var_address_type) {
				closure_4_fn := fn [var_address_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn [var_address_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_address_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_address_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_line := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (var_address_type).str() + '_' + (var_line).str()
	}
	mut var_line := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (var_address_type).str() + '_' + (var_line).str()
	}
	mut var_line := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (var_address_type).str() + '_' + (var_line).str()
	}
	mut var_line := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return (var_address_type).str() + '_' + (var_line).str()
	}
				mut var_address_data := rt.call_function('array_combine', [rt.call_function('array_map', [rt.new_closure(closure_1_fn), rt.func_array_keys(var_customer_data.array_get(var_address_type))]), rt.call_function('array_values', [var_customer_data.array_get(var_address_type)])])
				var_customer_data = rt.call_function('array_merge', [var_customer_data.dup(), var_address_data.dup()])
				var_customer_data.array_unset(var_address_type)
			}
		}
	}
	mut var_customer := create_wc_smoothgenerator_generator_wc_customer()
	rt.call_method(var_customer, 'set_props', [var_customer_data.dup()])
	if var_save {
		rt.call_method(var_customer, 'save', []rt.PhpVal{})
	}
	rt.call_function('do_action', [rt.new_string('smoothgenerator_customer_generated'), var_customer.dup()])
	return var_customer.dup()
}

fn Class_WC_SmoothGenerator_Generator_Customer.batch(var_amount rt.PhpVal, mut var_args Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_amount_mutated := var_amount
	mut var_args_mutated := var_args
	var_amount_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Customer{}; return temp.validate_batch_amount(arg_0) }(var_amount_mutated.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_amount_mutated.dup()])) {
		return var_amount_mutated.dup()
	}
	mut var_customer_ids := rt.new_array()
	{
		mut var_i := rt.new_int(rt.new_int(1))
		for {
			if !(rt.is_true(rt.less_equal(var_i, var_amount_mutated))) { break }
			mut var_customer := Class_WC_SmoothGenerator_Generator_Customer.generate(true, mut var_args_mutated)
			if rt.is_true(rt.call_function('is_wp_error', [var_customer.dup()])) {
				return var_customer.dup()
			}
			var_customer_ids.array_push(rt.call_method(var_customer, 'get_id', []rt.PhpVal{}))
			rt.post_inc(var_i)
		}
	}
	return var_customer_ids.dup()
}

struct Class_WC_SmoothGenerator_Generator_Generator {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_CustomerInfo {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WC_Customer {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_generator_customer() &Class_WC_SmoothGenerator_Generator_Customer {
	mut obj := &Class_WC_SmoothGenerator_Generator_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_generator() &Class_WC_SmoothGenerator_Generator_Generator {
	mut obj := &Class_WC_SmoothGenerator_Generator_Generator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_customerinfo() &Class_WC_SmoothGenerator_Generator_CustomerInfo {
	mut obj := &Class_WC_SmoothGenerator_Generator_CustomerInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_customer() &Class_WC_SmoothGenerator_Generator_WC_Customer {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Generator_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_WC_SmoothGenerator_Generator_Customer.generate(dispatch_arg_0, mut dispatch_arg_1)
		}
		'batch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_WC_SmoothGenerator_Generator_Customer.batch(dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_SmoothGenerator_Generator_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_Generator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_Generator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Generator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_CustomerInfo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_CustomerInfo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_CustomerInfo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_wc_smooth_generator_includes_generator_customer_php() {
}
