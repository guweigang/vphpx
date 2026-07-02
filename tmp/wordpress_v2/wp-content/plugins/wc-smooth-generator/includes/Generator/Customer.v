import rt

struct Class_WC_SmoothGenerator_Generator_Customer {
	rt.PhpObjectBase
}

fn Class_WC_SmoothGenerator_Generator_Customer.generate(save bool, mut var_assoc_args Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_line := rt.new_null()
	this.Class_WC_SmoothGenerator_Generator_Generator.maybe_initialize_generators()
	mut var_args := rt.call_function('filter_var_array', [var_assoc_args,
		rt.create_array([
			rt.ArrayItem{ key: 'country', val: rt.create_array([
				rt.ArrayItem{ key: 'filter', val: rt.get_constant('FILTER_VALIDATE_REGEXP') },
				rt.ArrayItem{ key: 'options', val: rt.create_array([
					rt.ArrayItem{ key: 'regexp', val: '/^[A-Za-z]{2}$/' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'type', val: rt.create_array([
				rt.ArrayItem{ key: 'filter', val: rt.get_constant('FILTER_VALIDATE_REGEXP') },
				rt.ArrayItem{ key: 'options', val: rt.create_array([
					rt.ArrayItem{ key: 'regexp', val: '/^(company|person)$/' },
				]) },
			]) },
		])])
	mut list_tmp_1 := var_args
	mut var_country := list_tmp_1.array_get(0)
	mut var_type := list_tmp_1.array_get(1)
	mut iife_temp_0 := Class_WC_SmoothGenerator_Generator_CustomerInfo{}
	mut iife_result_0 := iife_temp_0.get_valid_country_code(var_country.clone())
	var_country = iife_result_0
	if rt.is_true(rt.call_function('is_wp_error', [var_country.clone()])) {
		return var_country.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_type)))) {
		var_type = rt.new_string((if rt.is_true(rt.less(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Customer',
			'faker'), 'randomDigit', []rt.PhpVal{}), rt.new_int(7)))
		{
			'person'
		} else {
			'company'
		}).str())
	}
	mut var_keys_for_address := rt.create_array([rt.ArrayItem{ key: none, val: 'email' }])
	mut var_customer_data := rt.create_array([
		rt.ArrayItem{ key: 'role', val: 'customer' },
	])
	mut switch_val_1 := var_type
	if true {
		mut iife_temp_1 := Class_WC_SmoothGenerator_Generator_CustomerInfo{}
		mut iife_result_1 := iife_temp_1.generate_person(var_country.clone())
		var_customer_data = rt.call_function('array_merge', [
			var_customer_data.clone(), iife_result_1])
		mut iife_temp_2 := Class_WC_SmoothGenerator_Generator_CustomerInfo{}
		mut iife_result_2 := iife_temp_2.generate_person(var_country.clone())
		mut var_other_customer_data := iife_result_2
		var_keys_for_address.array_push('first_name')
		var_keys_for_address.array_push('last_name')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('company'))) {
		mut iife_temp_3 := Class_WC_SmoothGenerator_Generator_CustomerInfo{}
		mut iife_result_3 := iife_temp_3.generate_company(var_country.clone())
		var_customer_data = rt.call_function('array_merge', [
			var_customer_data.clone(), iife_result_3])
		mut iife_temp_4 := Class_WC_SmoothGenerator_Generator_CustomerInfo{}
		mut iife_result_4 := iife_temp_4.generate_company(var_country.clone())
		var_other_customer_data = iife_result_4
		var_keys_for_address.array_push('company')
	}
	mut iife_temp_5 := Class_WC_SmoothGenerator_Generator_CustomerInfo{}
	mut iife_result_5 := iife_temp_5.generate_address(var_country.clone())
	mut iife_temp_6 := Class_WC_SmoothGenerator_Generator_CustomerInfo{}
	mut iife_result_6 := iife_temp_6.generate_address(var_country.clone())
	var_customer_data.array_set('billing', rt.call_function('array_merge', [
		iife_result_5,
		rt.call_function('array_intersect_key', [var_customer_data.clone(),
			rt.call_function('array_fill_keys', [var_keys_for_address.clone(),
				rt.new_string('')])]),
	]))
	mut var_has_shipping := rt.less(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Customer',
		'faker'), 'randomDigit', []rt.PhpVal{}), rt.new_int(5))
	if rt.is_true(var_has_shipping) {
		mut var_same_shipping := rt.less(rt.call_method(rt.get_static_prop('WC_SmoothGenerator_Generator_Customer',
			'faker'), 'randomDigit', []rt.PhpVal{}), rt.new_int(5))
		if rt.is_true(var_same_shipping) {
			var_customer_data.array_set('shipping',
				var_customer_data.array_get(rt.new_string('billing')))
		} else {
			mut iife_temp_7 := Class_WC_SmoothGenerator_Generator_CustomerInfo{}
			mut iife_result_7 := iife_temp_7.generate_address(var_country.clone())
			mut iife_temp_8 := Class_WC_SmoothGenerator_Generator_CustomerInfo{}
			mut iife_result_8 := iife_temp_8.generate_address(var_country.clone())
			var_customer_data.array_set('shipping', rt.call_function('array_merge', [
				iife_result_7,
				rt.call_function('array_intersect_key', [var_other_customer_data.clone(),
					rt.call_function('array_fill_keys', [var_keys_for_address.clone(),
						rt.new_string('')])]),
			]))
		}
	}
	var_customer_data.array_unset(rt.new_string('company'))
	var_customer_data.array_get(rt.new_string('shipping')).array_unset(rt.new_string('email'))
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'billing' },
		rt.ArrayItem{ key: none, val: 'shipping' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_address_type := item_1.val
		if var_customer_data.array_isset(var_address_type) {
			closure_10_fn := fn [var_address_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_line := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return var_address_type.str() + '_' + var_line.str()
			}
			closure_11_fn := fn [var_address_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_line := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return var_address_type.str() + '_' + var_line.str()
			}
			closure_12_fn := fn [var_address_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_line := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return var_address_type.str() + '_' + var_line.str()
			}
			closure_13_fn := fn [var_address_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_line := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				return var_address_type.str() + '_' + var_line.str()
			}
			mut var_address_data := rt.call_function('array_combine', [
				rt.call_function('array_map', [rt.new_closure(closure_10_fn),
					rt.func_array_keys(var_customer_data.array_get(var_address_type))]),
				rt.call_function('array_values', [var_customer_data.array_get(var_address_type)]),
			])
			var_customer_data = rt.call_function('array_merge', [
				var_customer_data.clone(), var_address_data.clone()])
			var_customer_data.array_unset(var_address_type)
		}
	}
	mut var_customer := create_wc_smoothgenerator_generator_wc_customer()
	rt.call_method(var_customer, 'set_props', [var_customer_data.clone()])
	if var_save {
		rt.call_method(var_customer, 'save', []rt.PhpVal{})
	}
	rt.call_function('do_action', [rt.new_string('smoothgenerator_customer_generated'),
		var_customer.clone()])
	return var_customer.clone()
}

fn Class_WC_SmoothGenerator_Generator_Customer.batch(var_amount rt.PhpVal, mut var_args Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_amount_mutated := var_amount
	mut var_args_mutated := var_args
	mut iife_temp_13 := Class_WC_SmoothGenerator_Generator_Customer{}
	mut iife_result_13 := iife_temp_13.validate_batch_amount(var_amount_mutated.clone())
	var_amount_mutated = iife_result_13
	if rt.is_true(rt.call_function('is_wp_error', [var_amount_mutated.clone()])) {
		return var_amount_mutated.clone()
	}
	mut var_customer_ids := rt.new_array()
	mut var_i := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less_equal(var_i, var_amount_mutated))) { break
		 }
		mut var_customer := Class_WC_SmoothGenerator_Generator_Customer.generate(true, mut
			var_args_mutated)
		if rt.is_true(rt.call_function('is_wp_error', [var_customer.clone()])) {
			return var_customer.clone()
		}
		var_customer_ids.array_push(rt.call_method(var_customer, 'get_id', []rt.PhpVal{}))
		rt.post_inc(var_i)
	}
	return var_customer_ids.clone()
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

fn create_wc_smoothgenerator_generator_customer(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Customer {
	mut obj := &Class_WC_SmoothGenerator_Generator_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_generator(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_Generator {
	mut obj := &Class_WC_SmoothGenerator_Generator_Generator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_customerinfo(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_CustomerInfo {
	mut obj := &Class_WC_SmoothGenerator_Generator_CustomerInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_customer(_args ...rt.PhpVal) &Class_WC_SmoothGenerator_Generator_WC_Customer {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Generator_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return Class_WC_SmoothGenerator_Generator_Customer.generate(dispatch_arg_0, mut
				dispatch_arg_1)
		}
		'batch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return Class_WC_SmoothGenerator_Generator_Customer.batch(dispatch_arg_0, mut
				dispatch_arg_1)
		}
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
