import rt

struct Class_WC_Legacy_Coupon {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Legacy_Coupon) magic_isset(var_key rt.PhpVal) bool {
	mut var_legacy_keys := ['id', 'exists', 'coupon_custom_fields', 'type', 'discount_type', 'amount',
		'coupon_amount', 'code', 'individual_use', 'product_ids', 'exclude_product_ids',
		'usage_limit', 'usage_limit_per_user', 'limit_usage_to_x_items', 'usage_count', 'expiry_date',
		'product_categories', 'exclude_product_categories', 'minimum_amount', 'maximum_amount',
		'customer_email']
	if rt.is_true(rt.call_function('in_array', [var_key.clone(),
		rt.create_array_from_list(var_legacy_keys)]))
	{
		return true
	}
	return false
}

fn (mut this Class_WC_Legacy_Coupon) magic_get(var_key rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_doing_it_wrong', [var_key.clone(),
		rt.new_string('Coupon properties should not be accessed directly.'),
		rt.new_string('3.0')])
	mut switch_val_1 := var_key
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('id'))) {
		mut var_value := this.get_id()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('exists'))) {
		var_value = rt.greater(this.get_id(), rt.new_int(0))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('coupon_custom_fields'))) {
		mut var_legacy_custom_fields := rt.new_array()
		mut var_custom_fields := if rt.is_true(this.get_id()) {
			this.get_meta_data()
		} else {
			rt.new_array()
		}
		if !(!rt.is_true(var_custom_fields)) {
			mut iter_1 := var_custom_fields.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_cf_value := item_1.val
				var_legacy_custom_fields.array_get_mut(rt.get_property(var_cf_value, 'key')).array_set(0, rt.get_property(var_cf_value,
					'value'))
			}
		}
		var_value = var_legacy_custom_fields.clone()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('type')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('discount_type'))) {
		var_value = this.get_discount_type()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('amount')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('coupon_amount'))) {
		var_value = this.get_amount()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('code'))) {
		var_value = this.get_code()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('individual_use'))) {
		var_value = rt.new_string((if rt.is_true(rt.identical(rt.new_bool(true),
			this.get_individual_use()))
		{
			'yes'
		} else {
			'no'
		}).str())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('product_ids'))) {
		var_value = this.get_product_ids()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('exclude_product_ids'))) {
		var_value = this.get_excluded_product_ids()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('usage_limit'))) {
		var_value = this.get_usage_limit()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('usage_limit_per_user'))) {
		var_value = this.get_usage_limit_per_user()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('limit_usage_to_x_items'))) {
		var_value = this.get_limit_usage_to_x_items()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('usage_count'))) {
		var_value = this.get_usage_count()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('expiry_date'))) {
		var_value = if rt.is_true(this.get_date_expires()) { rt.call_method(this.get_date_expires(), 'date', [
				rt.new_string('Y-m-d'),
			]) } else { rt.new_string('') }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('product_categories'))) {
		var_value = this.get_product_categories()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('exclude_product_categories'))) {
		var_value = this.get_excluded_product_categories()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('minimum_amount'))) {
		var_value = this.get_minimum_amount()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('maximum_amount'))) {
		var_value = this.get_maximum_amount()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('customer_email'))) {
		var_value = this.get_email_restrictions()
	} else {
		var_value = rt.new_string('')
	}
	return var_value.clone()
}

fn (mut this Class_WC_Legacy_Coupon) format_array(var_array rt.PhpVal) rt.PhpVal {
	mut var_array_mutated := var_array
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Coupon::format_array'),
		rt.new_string('3.0')])
	if !(var_array_mutated.clone().is_array()) {
		if rt.is_true(rt.call_function('is_serialized', [var_array_mutated.clone()])) {
			var_array_mutated = rt.call_function('maybe_unserialize', [
				var_array_mutated.clone()])
		} else {
			var_array_mutated = rt.call_function('explode', [
				rt.new_string(','), var_array_mutated.clone()])
		}
	}
	return rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_string('trim'),
			rt.call_function('array_map', [rt.new_string('strtolower'),
				var_array_mutated.clone()])]),
	])
}

fn (mut this Class_WC_Legacy_Coupon) apply_before_tax() bool {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Coupon::apply_before_tax'),
		rt.new_string('3.0'),
	])
	return true
}

fn (mut this Class_WC_Legacy_Coupon) enable_free_shipping() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Coupon::enable_free_shipping'),
		rt.new_string('3.0'),
		rt.new_string('WC_Coupon::get_free_shipping'),
	])
	return this.get_free_shipping()
}

fn (mut this Class_WC_Legacy_Coupon) exclude_sale_items() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Coupon::exclude_sale_items'),
		rt.new_string('3.0'),
		rt.new_string('WC_Coupon::get_exclude_sale_items'),
	])
	return this.get_exclude_sale_items()
}

fn (mut this Class_WC_Legacy_Coupon) inc_usage_count(used_by string) {
	this.increase_usage_count(rt.new_string(used_by))
}

fn (mut this Class_WC_Legacy_Coupon) dcr_usage_count(used_by string) {
	this.decrease_usage_count(rt.new_string(used_by))
}

struct Class_WC_Data {
	rt.PhpObjectBase
}

fn create_wc_legacy_coupon(_args ...rt.PhpVal) &Class_WC_Legacy_Coupon {
	mut obj := &Class_WC_Legacy_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data(_args ...rt.PhpVal) &Class_WC_Data {
	mut obj := &Class_WC_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Legacy_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.magic_isset(dispatch_arg_0))
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'format_array' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_array(dispatch_arg_0)
		}
		'apply_before_tax' {
			return rt.new_bool(this.apply_before_tax())
		}
		'enable_free_shipping' {
			return this.enable_free_shipping()
		}
		'exclude_sale_items' {
			return this.exclude_sale_items()
		}
		'inc_usage_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.inc_usage_count(dispatch_arg_0)
			return rt.new_null()
		}
		'dcr_usage_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.dcr_usage_count(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Legacy_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Legacy_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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
