import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive.prefix() string {
	return 'woocommerce_admin_pes_incentive_'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive {
	rt.PhpObjectBase
pub mut:
		dismissed_meta_name rt.PhpVal = rt.new_null()
		suggestion_id string
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) construct(suggestion_id string) {
	this.suggestion_id = suggestion_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) get_all(country_code string, incentive_type string) rt.PhpVal {
	mut var_incentive := rt.new_null()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_incentive := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return this.validate_incentive(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_array](var_incentive))
		}
	mut var_incentives := rt.call_function('array_filter', [this.get_incentives(country_code), rt.new_closure(closure_1_fn)])
	if !(incentive_type == '') {
	closure_2_fn := fn [var_incentive_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_incentive := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(var_incentive.array_get(rt.new_string('type')), rt.new_string(incentive_type))
		}
	var_incentives = rt.call_function('array_filter', [var_incentives.clone(), rt.new_closure(closure_2_fn)])
	}
	return rt.call_function('array_values', [var_incentives.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) get_by_promo_id(promo_id string, country_code string, incentive_type string) rt.PhpVal {
	closure_3_fn := fn [var_promo_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_incentive := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(var_incentive.array_get(rt.new_string('promo_id')), rt.new_string(promo_id))
		}
	mut var_incentives := rt.call_function('array_filter', [this.get_all(country_code, incentive_type), rt.new_closure(closure_3_fn)])
	if !rt.is_true(var_incentives) {
		return rt.new_null()
	}
	return rt.call_function('reset', [var_incentives.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) get_by_id(incentive_id string, country_code string) rt.PhpVal {
	closure_4_fn := fn [var_incentive_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_incentive := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(var_incentive.array_get(rt.new_string('id')), rt.new_string(incentive_id))
		}
	mut var_incentives := rt.call_function('array_filter', [this.get_all(country_code, ''), rt.new_closure(closure_4_fn)])
	if !rt.is_true(var_incentives) {
		return rt.new_null()
	}
	return rt.call_function('reset', [var_incentives.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) is_visible(id string, country_code string, skip_extension_active_check bool) bool {
	if !(var_skip_extension_active_check) && this.is_extension_active() {
		return false
	}
	if !(this.user_has_caps()) {
		return false
	}
	if !rt.is_true(this.get_by_id(id, country_code)) {
		return false
	}
	if this.is_dismissed(id, 'all') {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) dismiss(id string, context string, mut var_timestamp Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_?int) bool {
	if this.is_dismissed(id, context) {
		return false
	}
	mut var_all_dismissed_incentives := this.get_all_dismissed_incentives()
	if !rt.is_true(var_all_dismissed_incentives.array_get(rt.new_string(this.suggestion_id))) {
		var_all_dismissed_incentives.array_set(this.suggestion_id, rt.new_array())
		rt.call_function('ksort', [var_all_dismissed_incentives.clone()])
	}
	var_all_dismissed_incentives.array_get_mut(this.suggestion_id).array_push(rt.create_array([rt.ArrayItem{ key: 'id', val: id }, rt.ArrayItem{ key: 'context', val: context }, rt.ArrayItem{ key: 'timestamp', val: if !(var_timestamp).is_null() { var_timestamp } else { rt.call_function('time', []rt.PhpVal{}) } }]))
	rt.call_function('do_action', [rt.new_string('woocommerce_admin_payments_extension_suggestion_incentive_dismissed'), rt.new_string(id), rt.new_string(this.suggestion_id), rt.new_string(context)])
	return this.save_all_dismissed_incentives(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_array](var_all_dismissed_incentives))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) is_dismissed(id string, context string) bool {
	mut var_dismissed_incentive := rt.new_null()
	if id == '' {
		return false
	}
	mut var_all_dismissed_incentives := this.get_all_dismissed_incentives()
	mut var_dismissed_incentives := if !(var_all_dismissed_incentives.array_get(rt.new_string(this.suggestion_id))).is_null() { var_all_dismissed_incentives.array_get(rt.new_string(this.suggestion_id)) } else { rt.new_array() }
	if !rt.is_true(var_dismissed_incentives) {
		return false
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_dismissed_incentive := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(rt.is_true(rt.identical(rt.new_string('all'), var_dismissed_incentive.array_get(rt.new_string('context')))) || rt.is_true(rt.identical(rt.new_string(context), var_dismissed_incentive.array_get(rt.new_string('context')))))
		}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_dismissed_incentive := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(rt.is_true(rt.identical(rt.new_string('all'), var_dismissed_incentive.array_get(rt.new_string('context')))) || rt.is_true(rt.identical(rt.new_string(context), var_dismissed_incentive.array_get(rt.new_string('context')))))
		}
	if rt.is_true(rt.call_function('in_array', [rt.new_string(id), rt.call_function('array_column', [rt.call_function('array_filter', [var_dismissed_incentives.clone(), rt.new_closure(closure_5_fn)]), rt.new_string('id')]), rt.new_bool(true)])) {
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) get_dismissals(id string) rt.PhpVal {
	mut var_dismissed_incentive := rt.new_null()
	mut var_all_dismissed_incentives := this.get_all_dismissed_incentives()
	mut var_dismissed_incentives := if !(var_all_dismissed_incentives.array_get(rt.new_string(this.suggestion_id))).is_null() { var_all_dismissed_incentives.array_get(rt.new_string(this.suggestion_id)) } else { rt.new_array() }
	if !rt.is_true(var_dismissed_incentives) {
		return rt.new_array()
	}
	closure_7_fn := fn [var_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_dismissed_incentive := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.new_string(id), var_dismissed_incentive.array_get(rt.new_string('id')))
		}
	closure_8_fn := fn [var_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_dismissed_incentive := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.identical(rt.new_string(id), var_dismissed_incentive.array_get(rt.new_string('id')))
		}
	mut var_dismissals := rt.call_function('array_values', [rt.call_function('array_filter', [var_dismissed_incentives.clone(), rt.new_closure(closure_7_fn)])])
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_dismissed_incentive := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([rt.ArrayItem{ key: 'timestamp', val: var_dismissed_incentive.array_get(rt.new_string('timestamp')) }, rt.ArrayItem{ key: 'context', val: var_dismissed_incentive.array_get(rt.new_string('context')) }])
		}
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_dismissed_incentive := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.create_array([rt.ArrayItem{ key: 'timestamp', val: var_dismissed_incentive.array_get(rt.new_string('timestamp')) }, rt.ArrayItem{ key: 'context', val: var_dismissed_incentive.array_get(rt.new_string('context')) }])
		}
	return rt.call_function('array_map', [rt.new_closure(closure_9_fn), var_dismissals.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) get_all_dismissed_incentives() rt.PhpVal {
	mut var_all_dismissed_incentives := rt.call_function('get_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), this.dismissed_meta_name, rt.new_bool(true)])
	if !rt.is_true(var_all_dismissed_incentives) {
	var_all_dismissed_incentives = rt.new_array()
	}
	return var_all_dismissed_incentives.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) save_all_dismissed_incentives(mut var_dismissed_incentives Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_array) bool {
	mut var_dismissed_incentives_mutated := var_dismissed_incentives
	return (rt.call_function('update_user_meta', [rt.call_function('get_current_user_id', []rt.PhpVal{}), this.dismissed_meta_name, var_dismissed_incentives_mutated])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) user_has_caps() bool {
	return (rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) validate_incentive(mut var_incentive Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_array) bool {
	mut var_required_keys := rt.create_array([rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: 'promo_id' }, rt.ArrayItem{ key: none, val: 'type' }])
	mut iter_1 := var_required_keys.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		if !rt.is_true(var_incentive.array_get(var_key)) {
			return false
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) is_extension_active() bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) get_incentives(country_code string) {
}

fn create_automattic_woocommerce_internal_admin_suggestions_incentives_incentive(suggestion_id string) &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive{
		PhpObjectBase: rt.PhpObjectBase{}
		dismissed_meta_name: rt.new_null()
		suggestion_id: ''
	}
	obj.construct(suggestion_id)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_all' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_all(dispatch_arg_0, dispatch_arg_1)
		}
		'get_by_promo_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_by_promo_id(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_by_id(dispatch_arg_0, dispatch_arg_1)
		}
		'is_visible' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.is_visible(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'dismiss' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_?int](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(this.dismiss(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2))
		}
		'is_dismissed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_dismissed(dispatch_arg_0, dispatch_arg_1))
		}
		'get_dismissals' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_dismissals(dispatch_arg_0)
		}
		'get_all_dismissed_incentives' {
			return this.get_all_dismissed_incentives()
		}
		'save_all_dismissed_incentives' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.save_all_dismissed_incentives(mut dispatch_arg_0))
		}
		'user_has_caps' {
			return rt.new_bool(this.user_has_caps())
		}
		'validate_incentive' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.validate_incentive(mut dispatch_arg_0))
		}
		'is_extension_active' {
			return rt.new_bool(this.is_extension_active())
		}
		'get_incentives' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.get_incentives(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'dismissed_meta_name' { return this.dismissed_meta_name }
		'suggestion_id' { return rt.new_string(this.suggestion_id) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Suggestions_Incentives_Incentive) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'dismissed_meta_name' { this.dismissed_meta_name = val; return true }
		'suggestion_id' { this.suggestion_id = (val).str(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

}
