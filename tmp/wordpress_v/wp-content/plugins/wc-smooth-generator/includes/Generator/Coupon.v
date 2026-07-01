import rt

struct Class_WC_SmoothGenerator_Generator_Coupon {
	rt.PhpObjectBase
}

fn Class_WC_SmoothGenerator_Generator_Coupon.generate(save bool, var_assoc_args rt.PhpVal) rt.PhpVal {
	mut var_min := rt.new_null()
	mut var_max := rt.new_null()
	this.Class_WC_SmoothGenerator_Generator_Generator.maybe_initialize_generators()
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'min', val: 5 }, rt.ArrayItem{ key: 'max', val: 100 }, rt.ArrayItem{ key: 'discount_type', val: 'fixed_cart' }])
	mut var_args := rt.call_function('wp_parse_args', [var_assoc_args.dup(), var_defaults.dup()])
	// unsupported assign target: Expr_List
	if rt.is_true(rt.identical(rt.new_bool(false), var_min)) {
		return create_wc_smoothgenerator_generator_wp_error(rt.new_string('smoothgenerator_coupon_invalid_min_max'), rt.new_string('The minimum coupon amount must be a valid positive integer.'))
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_max)) {
		return create_wc_smoothgenerator_generator_wp_error(rt.new_string('smoothgenerator_coupon_invalid_min_max'), rt.new_string('The maximum coupon amount must be a valid positive integer.'))
	}
	if rt.is_true(rt.greater(var_min, var_max)) {
		return create_wc_smoothgenerator_generator_wp_error(rt.new_string('smoothgenerator_coupon_invalid_min_max'), rt.new_string('The maximum coupon amount must be an integer that is greater than or equal to the minimum amount.'))
	}
	mut var_discount_type := if !(!rt.is_true(var_args.array_get('discount_type'))) { var_args.array_get('discount_type') } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_discount_type)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_discount_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'fixed_cart' }, rt.ArrayItem{ key: none, val: 'percent' }]), rt.new_bool(true)]))))))) {
		return create_wc_smoothgenerator_generator_wp_error(rt.new_string('smoothgenerator_coupon_invalid_discount_type'), rt.new_string('The discount_type must be either "fixed_cart" or "percent".'))
	}
	mut var_code := rt.call_function('substr', [rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'promotionCode', [rt.new_int(1)]), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])
	mut var_amount := rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'numberBetween', [var_min.dup(), var_max.dup()])
	mut var_coupon_code := rt.call_function('sprintf', [rt.new_string('%s%d'), var_code.dup(), var_amount.dup()])
	mut var_props := rt.create_array([rt.ArrayItem{ key: 'code', val: var_coupon_code }, rt.ArrayItem{ key: 'amount', val: var_amount }])
	if !(!rt.is_true(var_discount_type)) {
		var_props.array_set('discount_type', var_discount_type.dup())
	}
	mut var_coupon := create_wc_smoothgenerator_generator_wc_coupon(var_coupon_code.dup())
	rt.call_method(var_coupon, 'set_props', [var_props.dup()])
	if var_save {
		mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('coupon'))
		rt.call_method(var_data_store, 'create', [var_coupon.dup()])
	}
	rt.call_function('do_action', [rt.new_string('smoothgenerator_coupon_generated'), var_coupon.dup()])
	return var_coupon.dup()
}

fn Class_WC_SmoothGenerator_Generator_Coupon.batch(var_amount rt.PhpVal, mut var_args Class_WC_SmoothGenerator_Generator_array) rt.PhpVal {
	mut var_amount_mutated := var_amount
	mut var_args_mutated := var_args
	var_amount_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_SmoothGenerator_Generator_Coupon{}; return temp.validate_batch_amount(arg_0) }(var_amount_mutated.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_amount_mutated.dup()])) {
		return var_amount_mutated.dup()
	}
	mut var_coupon_ids := rt.new_array()
	{
		mut var_i := rt.new_int(rt.new_int(1))
		for {
			if !(rt.is_true(rt.less_equal(var_i, var_amount_mutated))) { break }
			mut var_coupon := Class_WC_SmoothGenerator_Generator_Coupon.generate(true, rt.new_object('WC_SmoothGenerator_Generator_array', []string{}, var_args_mutated))
			if rt.is_true(rt.call_function('is_wp_error', [var_coupon.dup()])) {
				return var_coupon.dup()
			}
			var_coupon_ids.array_push(rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}))
			rt.post_inc(var_i)
		}
	}
	return var_coupon_ids.dup()
}

fn Class_WC_SmoothGenerator_Generator_Coupon.get_random() bool {
	mut var_coupon_ids := rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'shop_coupon' }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'posts_per_page', val: // unsupported expression: Expr_UnaryMinus }, rt.ArrayItem{ key: 'fields', val: 'ids' }])])
	if !rt.is_true(var_coupon_ids) {
		return false
	}
	mut var_random_coupon_id := var_coupon_ids.array_get(rt.call_function('array_rand', [var_coupon_ids.dup()]))
	return (create_wc_smoothgenerator_generator_wc_coupon(var_random_coupon_id.dup())).to_bool()
}

struct Class_WC_SmoothGenerator_Generator_Generator {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_Generator_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_generator_coupon() &Class_WC_SmoothGenerator_Generator_Coupon {
	mut obj := &Class_WC_SmoothGenerator_Generator_Coupon{
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

fn create_wc_smoothgenerator_generator_wp_error() &Class_WC_SmoothGenerator_Generator_WP_Error {
	mut obj := &Class_WC_SmoothGenerator_Generator_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_generator_wc_coupon() &Class_WC_SmoothGenerator_Generator_WC_Coupon {
	mut obj := &Class_WC_SmoothGenerator_Generator_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Generator_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'generate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_SmoothGenerator_Generator_Coupon.generate(dispatch_arg_0, dispatch_arg_1)
		}
		'batch' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_SmoothGenerator_Generator_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_WC_SmoothGenerator_Generator_Coupon.batch(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_random' {
			return rt.new_bool(Class_WC_SmoothGenerator_Generator_Coupon.get_random())
		}
		else { return none }
	}
}

fn (this &Class_WC_SmoothGenerator_Generator_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_SmoothGenerator_Generator_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_SmoothGenerator_Generator_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Generator_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Generator_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_wc_smooth_generator_includes_generator_coupon_php() {
}
