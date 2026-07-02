import rt

struct Class_WC_Payment_Tokens {
	rt.PhpObjectBase
}

fn Class_WC_Payment_Tokens.get_tokens(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'token_id', val: '' },
			rt.ArrayItem{ key: 'user_id', val: '' }, rt.ArrayItem{ key: 'gateway_id', val: '' },
			rt.ArrayItem{ key: 'type', val: '' }])])
	mut iife_temp_0 := Class_WC_Data_Store{}
	mut iife_result_0 := iife_temp_0.load(rt.new_string('payment-token'))
	mut var_data_store := iife_result_0
	mut var_token_results := rt.call_method(var_data_store, 'get_tokens', [
		var_args_mutated.clone()])
	mut var_tokens := rt.new_array()
	if !(!rt.is_true(var_token_results)) {
		mut iter_1 := var_token_results.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_token_result := item_1.val
			mut var__token := Class_WC_Payment_Tokens.get(rt.get_property(var_token_result,
				'token_id'), var_token_result.clone())
			if !(!rt.is_true(var__token)) {
				var_tokens.array_set(rt.get_property(var_token_result, 'token_id'),
					var__token.clone())
			}
		}
	}
	return var_tokens.clone()
}

fn Class_WC_Payment_Tokens.get_customer_tokens(var_customer_id rt.PhpVal, gateway_id string) rt.PhpVal {
	if rt.is_true(rt.less(var_customer_id, rt.new_int(1))) {
		return rt.new_array()
	}
	mut var_tokens := Class_WC_Payment_Tokens.get_tokens(rt.create_array([
		rt.ArrayItem{ key: 'user_id', val: var_customer_id },
		rt.ArrayItem{ key: 'gateway_id', val: gateway_id },
		rt.ArrayItem{ key: 'limit', val: rt.call_function('apply_filters', [
			rt.new_string('woocommerce_get_customer_payment_tokens_limit'),
			rt.call_function('get_option', [rt.new_string('posts_per_page')]),
		]) },
	]))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_customer_payment_tokens'),
		var_tokens.clone(),
		var_customer_id.clone(),
		rt.new_string(gateway_id),
	])
}

fn Class_WC_Payment_Tokens.get_customer_default_token(var_customer_id rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.less(var_customer_id, rt.new_int(1))) {
		return rt.new_null()
	}
	mut iife_temp_1 := Class_WC_Data_Store{}
	mut iife_result_1 := iife_temp_1.load(rt.new_string('payment-token'))
	mut var_data_store := iife_result_1
	mut var_token := rt.call_method(var_data_store, 'get_users_default_token', [
		var_customer_id.clone(),
	])
	if rt.is_true(var_token) {
		return Class_WC_Payment_Tokens.get(rt.get_property(var_token, 'token_id'),
			var_token.clone())
	} else {
		return rt.new_null()
	}
	return rt.new_null()
}

fn Class_WC_Payment_Tokens.get_order_tokens(var_order_id rt.PhpVal) rt.PhpVal {
	mut var_order := rt.call_function('wc_get_order', [var_order_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return rt.new_array()
	}
	mut var_token_ids := rt.call_method(var_order, 'get_payment_tokens', []rt.PhpVal{})
	if !rt.is_true(var_token_ids) {
		return rt.new_array()
	}
	mut var_tokens := Class_WC_Payment_Tokens.get_tokens(rt.create_array([
		rt.ArrayItem{ key: 'token_id', val: var_token_ids },
	]))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_order_payment_tokens'),
		var_tokens.clone(),
		var_order_id.clone(),
	])
}

fn Class_WC_Payment_Tokens.get(var_token_id rt.PhpVal, var_token_result rt.PhpVal) rt.PhpVal {
	mut var_token_result_mutated := var_token_result
	mut iife_temp_2 := Class_WC_Data_Store{}
	mut iife_result_2 := iife_temp_2.load(rt.new_string('payment-token'))
	mut var_data_store := iife_result_2
	if rt.is_true(rt.new_bool(var_token_result_mutated.clone().is_null())) {
		var_token_result_mutated = rt.call_method(var_data_store, 'get_token_by_id', [
			var_token_id.clone(),
		])
		if !rt.is_true(var_token_result_mutated) {
			return rt.new_null()
		}
	}
	mut var_token_class := Class_WC_Payment_Tokens.get_token_classname(rt.get_property(var_token_result_mutated,
		'type'))
	if rt.is_true(rt.call_function('class_exists', [var_token_class.clone()])) {
		mut var_meta := rt.call_method(var_data_store, 'get_metadata', [
			var_token_id.clone()])
		mut var_passed_meta := rt.new_array()
		if !(!rt.is_true(var_meta)) {
			mut iter_2 := var_meta.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_meta_value := item_2.val
				mut var_meta_key := item_2.key
				var_passed_meta.array_set(var_meta_key, var_meta_value.array_get(rt.new_int(0)))
			}
		}
		return rt.create_object_dynamically(var_token_class, [
			var_token_id.clone(), rt.cast_array(var_token_result_mutated),
			var_passed_meta.clone()])
	}
	return rt.new_null()
}

fn Class_WC_Payment_Tokens.delete(var_token_id rt.PhpVal) {
	mut var_type := Class_WC_Payment_Tokens.get_token_type_by_id(var_token_id.clone())
	if !(!rt.is_true(var_type)) {
		mut var_class := Class_WC_Payment_Tokens.get_token_classname(var_type.clone())
		mut var_token := rt.create_object_dynamically(var_class, [
			var_token_id.clone()])
		rt.call_method(var_token, 'delete', []rt.PhpVal{})
	}
}

fn Class_WC_Payment_Tokens.set_users_default(var_user_id rt.PhpVal, var_token_id rt.PhpVal) {
	mut iife_temp_3 := Class_WC_Data_Store{}
	mut iife_result_3 := iife_temp_3.load(rt.new_string('payment-token'))
	mut var_data_store := iife_result_3
	mut var_users_tokens := Class_WC_Payment_Tokens.get_customer_tokens(var_user_id.str())
	mut iter_3 := var_users_tokens.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_token := item_3.val
		if rt.is_true(rt.identical(var_token_id, rt.call_method(var_token, 'get_id', []rt.PhpVal{}))) {
			rt.call_method(var_data_store, 'set_default_status', [
				rt.call_method(var_token, 'get_id', []rt.PhpVal{}),
				rt.new_bool(true),
			])
			rt.call_function('do_action', [
				rt.new_string('woocommerce_payment_token_set_default'),
				var_token_id.clone(),
				var_token.clone(),
			])
		} else {
			rt.call_method(var_data_store, 'set_default_status', [
				rt.call_method(var_token, 'get_id', []rt.PhpVal{}),
				rt.new_bool(false),
			])
		}
	}
}

fn Class_WC_Payment_Tokens.get_token_type_by_id(var_token_id rt.PhpVal) rt.PhpVal {
	mut iife_temp_4 := Class_WC_Data_Store{}
	mut iife_result_4 := iife_temp_4.load(rt.new_string('payment-token'))
	mut var_data_store := iife_result_4
	return rt.call_method(var_data_store, 'get_token_type_by_id', [
		var_token_id.clone()])
}

fn Class_WC_Payment_Tokens.get_token_classname(var_type rt.PhpVal) rt.PhpVal {
	mut var_type_mutated := var_type
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_payment_token_class'),
		rt.new_string('WC_Payment_Token_' + var_type_mutated.str()),
		var_type_mutated.clone(),
	])
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_payment_tokens(_args ...rt.PhpVal) &Class_WC_Payment_Tokens {
	mut obj := &Class_WC_Payment_Tokens{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store(_args ...rt.PhpVal) &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Payment_Tokens) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_tokens' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Payment_Tokens.get_tokens(dispatch_arg_0)
		}
		'get_customer_tokens' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_WC_Payment_Tokens.get_customer_tokens(dispatch_arg_0, dispatch_arg_1)
		}
		'get_customer_default_token' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Payment_Tokens.get_customer_default_token(dispatch_arg_0)
		}
		'get_order_tokens' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Payment_Tokens.get_order_tokens(dispatch_arg_0)
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Payment_Tokens.get(dispatch_arg_0, dispatch_arg_1)
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Payment_Tokens.delete(dispatch_arg_0)
			return rt.new_null()
		}
		'set_users_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Payment_Tokens.set_users_default(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_token_type_by_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Payment_Tokens.get_token_type_by_id(dispatch_arg_0)
		}
		'get_token_classname' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Payment_Tokens.get_token_classname(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Payment_Tokens) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Payment_Tokens) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WC_Payment_Tokens', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_payment_tokens()
		return rt.new_object('WC_Payment_Tokens', []string{}, obj)
	})
	rt.register_class_factory('WC_Data_Store', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_data_store()
		return rt.new_object('WC_Data_Store', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
