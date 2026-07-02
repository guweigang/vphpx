import rt

pub fn Class_WC_Brands_Coupons.e_wc_coupon_excluded_brands() i64 {
	return 301
}

struct Class_WC_Brands_Coupons {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Brands_Coupons) construct() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_coupon_is_valid'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Coupons', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'is_coupon_valid' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_coupon_is_valid_for_product'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Coupons', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'is_valid_for_product' },
		]),
		rt.new_int(10),
		rt.new_int(3),
	])
	rt.call_function('add_filter', [rt.new_string('woocommerce_coupon_error'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Brands_Coupons', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'brand_exclusion_error' },
		]),
		rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_WC_Brands_Coupons) is_coupon_valid(var_valid rt.PhpVal, var_coupon rt.PhpVal, var_discounts rt.PhpVal) rt.PhpVal {
	this.set_brand_settings_on_coupon(var_coupon.clone())
	mut iife_temp_0 := Class_WC_Brands_Brand_Settings_Manager{}
	mut iife_result_0 := iife_temp_0.get_brand_settings_on_coupon(var_coupon.clone())
	mut var_brand_coupon_settings := iife_result_0
	mut var_brand_restrictions := rt.new_bool(
		!(!rt.is_true(var_brand_coupon_settings.array_get(rt.new_string('included_brands'))))
		|| !(!rt.is_true(var_brand_coupon_settings.array_get(rt.new_string('excluded_brands')))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_brand_restrictions)))) {
		return var_valid.clone()
	}
	mut var_included_brands_match := rt.new_bool(false)
	mut var_excluded_brands_matches := rt.new_int(0)
	mut var_items := rt.call_method(var_discounts, 'get_items', []rt.PhpVal{})
	mut iter_1 := var_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		mut var_product_brands := this.get_product_brands(this.get_product_id(rt.get_property(var_item,
			'product')))
		if !(!rt.is_true(rt.call_function('array_intersect', [
			var_product_brands.clone(), var_brand_coupon_settings.array_get(rt.new_string('included_brands'))]))) {
			var_included_brands_match = rt.new_bool(true)
		}
		if !(!rt.is_true(rt.call_function('array_intersect', [
			var_product_brands.clone(), var_brand_coupon_settings.array_get(rt.new_string('excluded_brands'))]))) {
			rt.pre_inc(var_excluded_brands_matches)
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_included_brands_match))))
		&& !(!rt.is_true(var_brand_coupon_settings.array_get(rt.new_string('included_brands')))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_method(var_coupon,
			'get_coupon_error', [Class_WC_Coupon.e_wc_coupon_not_applicable()]),
			Class_WC_Coupon.e_wc_coupon_not_applicable())))
	}
	if rt.is_true(rt.identical(rt.new_int(var_items.clone().array_count()),
		var_excluded_brands_matches))
	{
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Sorry, this coupon is not applicable to the brands of selected products.'),
			rt.new_string('woocommerce'),
		]), Class_WC_Brands_Coupons.e_wc_coupon_excluded_brands())))
	}
	if rt.is_true(rt.call_method(var_coupon, 'is_type', [rt.new_string('fixed_cart')]))
		&& rt.is_true(rt.greater(var_excluded_brands_matches, rt.new_int(0))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('__', [
			rt.new_string('Sorry, this coupon is not applicable to the brands of selected products.'),
			rt.new_string('woocommerce'),
		]), Class_WC_Brands_Coupons.e_wc_coupon_excluded_brands())))
	}
	return var_valid.clone()
}

fn (mut this Class_WC_Brands_Coupons) is_valid_for_product(var_valid rt.PhpVal, var_product rt.PhpVal, var_coupon rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [
		var_product.clone(), rt.new_string('WC_Product')])))))
	{
		return var_valid.to_bool()
	}
	this.set_brand_settings_on_coupon(var_coupon.clone())
	mut var_product_id := this.get_product_id(var_product.clone())
	mut var_product_brands := this.get_product_brands(var_product_id.clone())
	mut iife_temp_1 := Class_WC_Brands_Brand_Settings_Manager{}
	mut iife_result_1 := iife_temp_1.get_brand_settings_on_coupon(var_coupon.clone())
	mut var_brand_coupon_settings := iife_result_1
	if !(!rt.is_true(var_brand_coupon_settings.array_get(rt.new_string('included_brands'))))
		&& !rt.is_true(rt.call_function('array_intersect', [var_product_brands.clone(), var_brand_coupon_settings.array_get(rt.new_string('included_brands'))])) {
		return false
	}
	if !(!rt.is_true(var_brand_coupon_settings.array_get(rt.new_string('excluded_brands'))))
		&& !(!rt.is_true(rt.call_function('array_intersect', [var_product_brands.clone(), var_brand_coupon_settings.array_get(rt.new_string('excluded_brands'))]))) {
		return false
	}
	return var_valid.to_bool()
}

fn (mut this Class_WC_Brands_Coupons) brand_exclusion_error(var_err rt.PhpVal, var_err_code rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WC_Brands_Coupons.e_wc_coupon_excluded_brands(),
		var_err_code))))
	{
		return var_err.clone()
	}
	return rt.call_function('__', [
		rt.new_string('Sorry, this coupon is not applicable to the brands of selected products.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_WC_Brands_Coupons) get_product_brands(var_product_id rt.PhpVal) rt.PhpVal {
	mut var_product_id_mutated := var_product_id
	return rt.call_function('wp_get_post_terms', [var_product_id_mutated.clone(),
		rt.new_string('product_brand'), rt.create_array([
			rt.ArrayItem{ key: 'fields', val: 'ids' },
		])])
}

fn (mut this Class_WC_Brands_Coupons) set_brand_settings_on_coupon(var_coupon rt.PhpVal) {
	mut iife_temp_2 := Class_WC_Brands_Brand_Settings_Manager{}
	mut iife_result_2 := iife_temp_2.get_brand_settings_on_coupon(var_coupon.clone())
	mut var_brand_coupon_settings := iife_result_2
	if !(!rt.is_true(var_brand_coupon_settings.array_get(rt.new_string('included_brands'))))
		&& !(!rt.is_true(var_brand_coupon_settings.array_get(rt.new_string('excluded_brands')))) {
		return
	}
	mut var_included_brands := rt.call_function('get_post_meta', [
		rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}),
		rt.new_string('product_brands'),
		rt.new_bool(true),
	])
	if !rt.is_true(var_included_brands) {
		var_included_brands = rt.new_array()
	}
	mut var_excluded_brands := rt.call_function('get_post_meta', [
		rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}),
		rt.new_string('exclude_product_brands'),
		rt.new_bool(true),
	])
	if !rt.is_true(var_excluded_brands) {
		var_excluded_brands = rt.new_array()
	}
	mut iife_temp_3 := Class_WC_Brands_Brand_Settings_Manager{}
	mut iife_result_3 := iife_temp_3.set_brand_settings_on_coupon(var_coupon.clone())
}

fn (mut this Class_WC_Brands_Coupons) get_product_id(var_product rt.PhpVal) rt.PhpVal {
	return if rt.is_true(rt.call_method(var_product, 'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.variation(),
	]))
	{
		rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})
	} else {
		rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	}
}

struct Class_WC_Brands_Brand_Settings_Manager {
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

fn create_wc_brands_coupons() &Class_WC_Brands_Coupons {
	mut obj := &Class_WC_Brands_Coupons{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_brands_brand_settings_manager(_args ...rt.PhpVal) &Class_WC_Brands_Brand_Settings_Manager {
	mut obj := &Class_WC_Brands_Brand_Settings_Manager{
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

fn (mut this Class_WC_Brands_Coupons) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'is_coupon_valid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.is_coupon_valid(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'is_valid_for_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_for_product(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'brand_exclusion_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.brand_exclusion_error(dispatch_arg_0, dispatch_arg_1)
		}
		'get_product_brands' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_brands(dispatch_arg_0)
		}
		'set_brand_settings_on_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_brand_settings_on_coupon(dispatch_arg_0)
			return rt.new_null()
		}
		'get_product_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_product_id(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Brands_Coupons) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Brands_Coupons) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Brands_Brand_Settings_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Brands_Brand_Settings_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Brands_Brand_Settings_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	create_wc_brands_coupons()
}
