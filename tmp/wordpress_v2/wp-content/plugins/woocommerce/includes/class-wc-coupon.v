import rt

pub fn Class_WC_Coupon.e_wc_coupon_invalid_filtered() i64 {
	return 100
}

pub fn Class_WC_Coupon.e_wc_coupon_invalid_removed() i64 {
	return 101
}

pub fn Class_WC_Coupon.e_wc_coupon_not_yours_removed() i64 {
	return 102
}

pub fn Class_WC_Coupon.e_wc_coupon_already_applied() i64 {
	return 103
}

pub fn Class_WC_Coupon.e_wc_coupon_already_applied_indiv_use_only() i64 {
	return 104
}

pub fn Class_WC_Coupon.e_wc_coupon_not_exist() i64 {
	return 105
}

pub fn Class_WC_Coupon.e_wc_coupon_usage_limit_reached() i64 {
	return 106
}

pub fn Class_WC_Coupon.e_wc_coupon_expired() i64 {
	return 107
}

pub fn Class_WC_Coupon.e_wc_coupon_min_spend_limit_not_met() i64 {
	return 108
}

pub fn Class_WC_Coupon.e_wc_coupon_not_applicable() i64 {
	return 109
}

pub fn Class_WC_Coupon.e_wc_coupon_not_valid_sale_items() i64 {
	return 110
}

pub fn Class_WC_Coupon.e_wc_coupon_please_enter() i64 {
	return 111
}

pub fn Class_WC_Coupon.e_wc_coupon_max_spend_limit_met() i64 {
	return 112
}

pub fn Class_WC_Coupon.e_wc_coupon_excluded_products() i64 {
	return 113
}

pub fn Class_WC_Coupon.e_wc_coupon_excluded_categories() i64 {
	return 114
}

pub fn Class_WC_Coupon.e_wc_coupon_usage_limit_coupon_stuck() i64 {
	return 115
}

pub fn Class_WC_Coupon.e_wc_coupon_usage_limit_coupon_stuck_guest() i64 {
	return 116
}

pub fn Class_WC_Coupon.wc_coupon_success() i64 {
	return 200
}

pub fn Class_WC_Coupon.wc_coupon_removed() i64 {
	return 201
}

struct Class_WC_Coupon {
	rt.PhpObjectBase
pub mut:
	data          rt.PhpVal = rt.new_array()
	cache_group   rt.PhpVal = rt.new_string('coupons')
	error_message rt.PhpVal = rt.new_null()
	sort          rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WC_Coupon) construct(data string) {
	mut data_mutated := data
	this.Class_WC_Legacy_Coupon.construct(rt.new_string(data_mutated))
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_string(data_mutated), 'WC_Coupon'))) {
		this.set_id(rt.call_function('absint', [
			rt.call_method(rt.new_string(data_mutated), 'get_id', []rt.PhpVal{}),
		]))
		this.read_object_from_database()
		return
	}
	mut var_coupon := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_get_shop_coupon_data'),
		rt.new_bool(false),
		rt.new_string(data_mutated).clone(),
		rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this),
	])
	if rt.is_true(var_coupon) {
		this.read_manual_coupon(rt.new_string(data_mutated), var_coupon.clone())
		return
	}
	if rt.new_string(data_mutated).clone().is_long()
		&& rt.is_true(rt.identical(rt.new_string('shop_coupon'), rt.call_function('get_post_type', [rt.new_string(data_mutated).clone()]))) {
		this.set_id(rt.new_string(data_mutated))
		mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
		mut iife_result_0 := iife_temp_0.is_null_or_whitespace(rt.new_string(data_mutated))
	} else if rt.new_string(data_mutated).clone().is_string()
		&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		mut var_id := rt.call_function('wc_get_coupon_id_by_code', [
			rt.new_string(data_mutated).clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_id))))
			&& rt.is_true(rt.identical(rt.new_string('shop_coupon'), rt.call_function('get_post_type', [rt.new_string(data_mutated).clone()]))) {
			this.set_id(rt.new_string(data_mutated))
		} else {
			this.set_id(var_id.clone())
			this.set_code(rt.new_string(data_mutated))
		}
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	this.read_object_from_database()
}

fn (mut this Class_WC_Coupon) get_data() rt.PhpVal {
	this.get_used_by('edit')
	mut var_data := this.Class_WC_Legacy_Coupon.get_data()
	if rt.is_true(rt.identical(rt.new_string(''),
		var_data.array_get(rt.new_string('minimum_amount'))))
	{
		var_data.array_set('minimum_amount', '0')
	}
	if rt.is_true(rt.identical(rt.new_string(''),
		var_data.array_get(rt.new_string('maximum_amount'))))
	{
		var_data.array_set('maximum_amount', '0')
	}
	return var_data.clone()
}

fn (mut this Class_WC_Coupon) read_object_from_database() {
	mut iife_temp_1 := Class_WC_Data_Store{}
	mut iife_result_1 := iife_temp_1.load(rt.new_string('coupon'))
	this.dispatch_set_prop('data_store', iife_result_1)
	if rt.is_true(rt.greater(this.get_id(), rt.new_int(0))) {
		rt.call_method(rt.get_property(rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this),
			'data_store'), 'read', [
			rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this),
		])
	}
}

fn (mut this Class_WC_Coupon) is_type(var_type rt.PhpVal) bool {
	mut var_type_mutated := var_type
	return rt.is_true(rt.identical(this.get_discount_type(''), var_type_mutated))
		|| var_type_mutated.clone().is_array()
		&& rt.is_true(rt.call_function('in_array', [this.get_discount_type(''), var_type_mutated.clone(), rt.new_bool(true)]))
}

fn (mut this Class_WC_Coupon) get_hook_prefix() string {
	return 'woocommerce_coupon_get_'
}

fn (mut this Class_WC_Coupon) get_code(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('code'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_description(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('description'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_status(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('status'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_discount_type(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('discount_type'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_amount(context string) rt.PhpVal {
	return rt.call_function('wc_format_decimal', [
		this.get_prop(rt.new_string('amount'), rt.new_string(context)),
	])
}

fn (mut this Class_WC_Coupon) get_date_expires(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_expires'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_date_created(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_created'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_date_modified(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_modified'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_usage_count(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('usage_count'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_individual_use(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('individual_use'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_product_ids(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('product_ids'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_excluded_product_ids(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('excluded_product_ids'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_usage_limit(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('usage_limit'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_usage_limit_per_user(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('usage_limit_per_user'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_limit_usage_to_x_items(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('limit_usage_to_x_items'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_free_shipping(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('free_shipping'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_product_categories(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('product_categories'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_excluded_product_categories(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('excluded_product_categories'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_exclude_sale_items(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('exclude_sale_items'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_minimum_amount(context string) rt.PhpVal {
	if rt.is_true(rt.new_bool('edit' != context))
		&& rt.is_true(rt.identical(this.get_prop(rt.new_string('minimum_amount'), rt.new_string(context)), rt.new_string(''))) {
		return rt.call_function('wc_format_decimal', [rt.new_int(0)])
	}
	return rt.call_function('wc_format_decimal', [
		this.get_prop(rt.new_string('minimum_amount'), rt.new_string(context)),
	])
}

fn (mut this Class_WC_Coupon) get_maximum_amount(context string) rt.PhpVal {
	if rt.is_true(rt.new_bool('edit' != context))
		&& rt.is_true(rt.identical(this.get_prop(rt.new_string('maximum_amount'), rt.new_string(context)), rt.new_string(''))) {
		return rt.call_function('wc_format_decimal', [rt.new_int(0)])
	}
	return rt.call_function('wc_format_decimal', [
		this.get_prop(rt.new_string('maximum_amount'), rt.new_string(context)),
	])
}

fn (mut this Class_WC_Coupon) get_email_restrictions(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('email_restrictions'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_used_by(context string) rt.PhpVal {
	if rt.is_true(rt.new_bool(this.data.array_get(rt.new_string('used_by')).is_null())) {
		this.data.array_set('used_by', if rt.is_true(this.get_id()) { rt.call_function('array_filter', [
				rt.cast_array(rt.call_function('get_post_meta', [
					this.get_id(), rt.new_string('_used_by'),
					rt.new_bool(false)])),
			]) } else { rt.new_array() })
	}
	return this.get_prop(rt.new_string('used_by'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_virtual(context string) bool {
	return (this.get_prop(rt.new_string('virtual'), rt.new_string(context))).to_bool()
}

fn (mut this Class_WC_Coupon) get_discount_amount(var_discounting_amount rt.PhpVal, var_cart_item rt.PhpVal, single bool) rt.PhpVal {
	mut var_discount := rt.new_int(0)
	mut var_cart_item_qty := if var_cart_item.clone().is_null() {
		rt.new_int(1)
	} else {
		var_cart_item.array_get(rt.new_string('quantity'))
	}
	if this.is_type(rt.create_array([rt.ArrayItem{ key: none, val: 'percent' }])) {
		var_discount = rt.new_float((this.get_amount('')).to_f64()) * var_discounting_amount / 100
	} else if this.is_type(rt.new_string('fixed_cart')) && !(var_cart_item.clone().is_null())
		&& rt.is_true(rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'subtotal_ex_tax')) {
		if rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{})) {
			mut var_discount_percent := rt.div(rt.mul(rt.call_function('wc_get_price_including_tax', [
				var_cart_item.array_get(rt.new_string('data')),
			]), var_cart_item_qty), rt.get_property(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'cart'), 'subtotal'))
		} else {
			var_discount_percent = rt.div(rt.mul(rt.call_function('wc_get_price_excluding_tax', [
				var_cart_item.array_get(rt.new_string('data')),
			]), var_cart_item_qty), rt.get_property(rt.get_property(rt.call_function('WC',
				[]rt.PhpVal{}), 'cart'), 'subtotal_ex_tax'))
		}
		var_discount = rt.new_float((this.get_amount('')).to_f64()) * var_discount_percent / var_cart_item_qty
	} else if this.is_type(rt.new_string('fixed_product')) {
		var_discount = rt.call_function('min', [this.get_amount(''),
			var_discounting_amount.clone()])
		var_discount = if var_single {
			var_discount
		} else {
			rt.mul(var_discount, var_cart_item_qty)
		}
	}
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_NumberUtil{}
	mut iife_result_2 := iife_temp_2.round(rt.call_function('min', [
		var_discount.clone(), var_discounting_amount.clone()]), rt.call_function('wc_get_rounding_precision',
		[]rt.PhpVal{}))
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_coupon_get_discount_amount'),
		iife_result_2,
		var_discounting_amount.clone(),
		var_cart_item.clone(),
		rt.new_bool(single),
		rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this),
	])
}

fn (mut this Class_WC_Coupon) set_code(var_code rt.PhpVal) {
	this.set_prop(rt.new_string('code'), rt.call_function('wc_format_coupon_code', [
		var_code.clone(),
	]))
}

fn (mut this Class_WC_Coupon) set_description(var_description rt.PhpVal) {
	this.set_prop(rt.new_string('description'), var_description.clone())
}

fn (mut this Class_WC_Coupon) set_status(var_status rt.PhpVal) {
	this.set_prop(rt.new_string('status'), var_status.clone())
}

fn (mut this Class_WC_Coupon) set_discount_type(var_discount_type rt.PhpVal) {
	mut var_discount_type_mutated := var_discount_type
	this.set_discount_type_core(var_discount_type_mutated.clone(), true)
}

fn (mut this Class_WC_Coupon) set_discount_type_core(var_discount_type rt.PhpVal, verify_discount_type bool) {
	mut var_discount_type_mutated := var_discount_type
	if rt.is_true(rt.identical(rt.new_string('percent_product'), var_discount_type_mutated)) {
		var_discount_type_mutated = rt.new_string('percent')
	}
	if var_verify_discount_type
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_discount_type_mutated.clone(), rt.func_array_keys(rt.call_function('wc_get_coupon_types', []rt.PhpVal{})), rt.new_bool(true)]))))) {
		this.error(rt.new_string('coupon_invalid_discount_type'), rt.call_function('__', [
			rt.new_string('Invalid discount type.'),
			rt.new_string('woocommerce'),
		]))
	}
	this.set_prop(rt.new_string('discount_type'), var_discount_type_mutated.clone())
}

fn (mut this Class_WC_Coupon) set_amount(var_amount rt.PhpVal) {
	mut var_amount_mutated := var_amount
	var_amount_mutated = rt.call_function('wc_format_decimal', [
		var_amount_mutated.clone()])
	if !(var_amount_mutated.clone().is_long() || var_amount_mutated.clone().is_double()) {
		var_amount_mutated = rt.new_int(0)
	}
	if rt.new_float(var_amount_mutated.to_f64()) < 0 {
		this.error(rt.new_string('coupon_invalid_amount'), rt.call_function('__', [
			rt.new_string('Invalid discount amount.'),
			rt.new_string('woocommerce'),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('percent'), this.get_discount_type('')))
		&& rt.new_float(var_amount_mutated.to_f64()) > 100 {
		this.error(rt.new_string('coupon_invalid_amount'), rt.call_function('__', [
			rt.new_string('Invalid discount amount.'),
			rt.new_string('woocommerce'),
		]))
	}
	this.set_prop(rt.new_string('amount'), var_amount_mutated.clone())
}

fn (mut this Class_WC_Coupon) set_date_expires(var_date rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_expires'), var_date.clone())
}

fn (mut this Class_WC_Coupon) set_date_created(var_date rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_created'), var_date.clone())
}

fn (mut this Class_WC_Coupon) set_date_modified(var_date rt.PhpVal) {
	this.set_date_prop(rt.new_string('date_modified'), var_date.clone())
}

fn (mut this Class_WC_Coupon) set_usage_count(var_usage_count rt.PhpVal) {
	this.set_prop(rt.new_string('usage_count'), rt.call_function('absint', [
		var_usage_count.clone()]))
}

fn (mut this Class_WC_Coupon) set_individual_use(var_is_individual_use rt.PhpVal) {
	this.set_prop(rt.new_string('individual_use'), rt.new_bool(var_is_individual_use.to_bool()))
}

fn (mut this Class_WC_Coupon) set_product_ids(var_product_ids rt.PhpVal) {
	mut var_product_ids_mutated := var_product_ids
	this.set_prop(rt.new_string('product_ids'), rt.call_function('array_filter', [
		rt.call_function('wp_parse_id_list', [rt.cast_array(var_product_ids_mutated)]),
	]))
}

fn (mut this Class_WC_Coupon) set_excluded_product_ids(var_excluded_product_ids rt.PhpVal) {
	this.set_prop(rt.new_string('excluded_product_ids'), rt.call_function('array_filter', [
		rt.call_function('wp_parse_id_list', [rt.cast_array(var_excluded_product_ids)]),
	]))
}

fn (mut this Class_WC_Coupon) set_usage_limit(var_usage_limit rt.PhpVal) {
	this.set_prop(rt.new_string('usage_limit'), rt.call_function('absint', [
		var_usage_limit.clone()]))
}

fn (mut this Class_WC_Coupon) set_usage_limit_per_user(var_usage_limit rt.PhpVal) {
	this.set_prop(rt.new_string('usage_limit_per_user'), rt.call_function('absint', [
		var_usage_limit.clone(),
	]))
}

fn (mut this Class_WC_Coupon) set_limit_usage_to_x_items(var_limit_usage_to_x_items rt.PhpVal) {
	this.set_prop(rt.new_string('limit_usage_to_x_items'), if var_limit_usage_to_x_items.clone().is_null() { rt.new_null() } else { rt.call_function('absint', [
			var_limit_usage_to_x_items.clone(),
		]) })
}

fn (mut this Class_WC_Coupon) set_free_shipping(var_free_shipping rt.PhpVal) {
	this.set_prop(rt.new_string('free_shipping'), rt.new_bool(var_free_shipping.to_bool()))
}

fn (mut this Class_WC_Coupon) set_product_categories(var_product_categories rt.PhpVal) {
	this.set_prop(rt.new_string('product_categories'), rt.call_function('array_filter', [
		rt.call_function('wp_parse_id_list', [rt.cast_array(var_product_categories)]),
	]))
}

fn (mut this Class_WC_Coupon) set_excluded_product_categories(var_excluded_product_categories rt.PhpVal) {
	this.set_prop(rt.new_string('excluded_product_categories'), rt.call_function('array_filter', [
		rt.call_function('wp_parse_id_list', [
			rt.cast_array(var_excluded_product_categories),
		]),
	]))
}

fn (mut this Class_WC_Coupon) set_exclude_sale_items(var_exclude_sale_items rt.PhpVal) {
	this.set_prop(rt.new_string('exclude_sale_items'),
		rt.new_bool(var_exclude_sale_items.to_bool()))
}

fn (mut this Class_WC_Coupon) set_minimum_amount(var_amount rt.PhpVal) {
	mut var_amount_mutated := var_amount
	this.set_prop(rt.new_string('minimum_amount'), rt.call_function('wc_format_decimal', [
		var_amount_mutated.clone(),
	]))
}

fn (mut this Class_WC_Coupon) set_maximum_amount(var_amount rt.PhpVal) {
	mut var_amount_mutated := var_amount
	if rt.is_true(rt.new_float(var_amount_mutated.to_f64()))
		&& rt.new_float((this.get_minimum_amount('')).to_f64()) > rt.new_float(var_amount_mutated.to_f64()) {
		this.error(rt.new_string('coupon_invalid_maximum_amount'), rt.call_function('__', [
			rt.new_string('Invalid maximum spend value.'),
			rt.new_string('woocommerce'),
		]))
	}
	this.set_prop(rt.new_string('maximum_amount'), rt.call_function('wc_format_decimal', [
		var_amount_mutated.clone(),
	]))
}

fn (mut this Class_WC_Coupon) set_email_restrictions(var_emails rt.PhpVal) {
	mut var_emails_mutated := var_emails
	var_emails_mutated = rt.call_function('array_filter', [
		rt.call_function('array_map', [rt.new_string('sanitize_email'),
			rt.call_function('array_map', [rt.new_string('strtolower'),
				rt.cast_array(var_emails_mutated)])]),
	])
	mut iter_1 := var_emails_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_email := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [
			var_email.clone()])))))
		{
			this.error(rt.new_string('coupon_invalid_email_address'), rt.call_function('__', [
				rt.new_string('Invalid email address restriction.'),
				rt.new_string('woocommerce'),
			]))
		}
	}
	this.set_prop(rt.new_string('email_restrictions'), var_emails_mutated.clone())
}

fn (mut this Class_WC_Coupon) set_used_by(var_used_by rt.PhpVal) {
	this.set_prop(rt.new_string('used_by'), rt.call_function('array_filter', [
		var_used_by.clone()]))
}

fn (mut this Class_WC_Coupon) set_virtual(var_virtual rt.PhpVal) {
	this.set_prop(rt.new_string('virtual'), rt.new_bool(var_virtual.to_bool()))
}

fn (mut this Class_WC_Coupon) read_manual_coupon(var_code rt.PhpVal, var_coupon rt.PhpVal) {
	mut var_coupon_mutated := var_coupon
	mut iter_2 := var_coupon_mutated.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_key := item_2.key
		mut switch_val_1 := var_key
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('excluded_product_ids')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('exclude_product_ids'))) {
			if !(var_coupon_mutated.array_get(var_key).is_array()) {
				rt.call_function('wc_doing_it_wrong', [var_key.clone(),
					rt.new_string(var_key.str() + ' should be an array instead of a string.'),
					rt.new_string('3.0')])
				var_coupon_mutated.array_set('excluded_product_ids', rt.call_function('wc_string_to_array', [
					var_value.clone(),
				]))
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('exclude_product_categories')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('excluded_product_categories'))) {
			if !(var_coupon_mutated.array_get(var_key).is_array()) {
				rt.call_function('wc_doing_it_wrong', [var_key.clone(),
					rt.new_string(var_key.str() + ' should be an array instead of a string.'),
					rt.new_string('3.0')])
				var_coupon_mutated.array_set('excluded_product_categories', rt.call_function('wc_string_to_array', [
					var_value.clone(),
				]))
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('product_ids'))) {
			if !(var_coupon_mutated.array_get(var_key).is_array()) {
				rt.call_function('wc_doing_it_wrong', [var_key.clone(),
					rt.new_string(var_key.str() + ' should be an array instead of a string.'),
					rt.new_string('3.0')])
				var_coupon_mutated.array_set(var_key, rt.call_function('wc_string_to_array', [
					var_value.clone(),
				]))
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('individual_use')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('free_shipping')))
			|| rt.is_true(rt.equal(switch_val_1, rt.new_string('exclude_sale_items'))) {
			if !(var_coupon_mutated.array_get(var_key).is_bool()) {
				rt.call_function('wc_doing_it_wrong', [var_key.clone(),
					rt.new_string(var_key.str() + ' should be true or false instead of yes or no.'),
					rt.new_string('3.0')])
				var_coupon_mutated.array_set(var_key, rt.call_function('wc_string_to_bool', [
					var_value.clone(),
				]))
			}
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('expiry_date'))) {
			var_coupon_mutated.array_set('date_expires', var_value.clone())
		}
	}
	this.set_props(var_coupon_mutated.clone())
	this.set_code(var_code.clone())
	this.set_id(rt.new_int(0))
	this.set_virtual(rt.new_bool(true))
}

fn (mut this Class_WC_Coupon) increase_usage_count(used_by string, var_order rt.PhpVal) {
	if rt.is_true(this.get_id())
		&& rt.is_true(rt.get_property(rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this), 'data_store')) {
		mut var_new_count := rt.call_method(rt.get_property(rt.new_object('WC_Coupon', [
			'WC_Legacy_Coupon',
		], &this), 'data_store'), 'increase_usage_count', [
			rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this),
			rt.new_string(used_by),
			var_order.clone(),
		])
		this.data.array_set('usage_count', var_new_count.clone())
		if rt.get_property(rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this), 'changes').array_isset(rt.new_string('usage_count')) {
			rt.get_property(rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this), 'changes').array_unset(rt.new_string('usage_count'))
		}
	}
}

fn (mut this Class_WC_Coupon) decrease_usage_count(used_by string) {
	if rt.is_true(this.get_id()) && rt.is_true(rt.greater(this.get_usage_count(''), rt.new_int(0)))
		&& rt.is_true(rt.get_property(rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this), 'data_store')) {
		mut var_new_count := rt.call_method(rt.get_property(rt.new_object('WC_Coupon', [
			'WC_Legacy_Coupon',
		], &this), 'data_store'), 'decrease_usage_count', [
			rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this),
			rt.new_string(used_by),
		])
		this.data.array_set('usage_count', var_new_count.clone())
		if rt.get_property(rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this), 'changes').array_isset(rt.new_string('usage_count')) {
			rt.get_property(rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this), 'changes').array_unset(rt.new_string('usage_count'))
		}
	}
}

fn (mut this Class_WC_Coupon) get_error_message() rt.PhpVal {
	return this.error_message
}

fn (mut this Class_WC_Coupon) set_error_message(message string) {
	this.error_message = rt.new_string(message)
}

fn (mut this Class_WC_Coupon) is_valid() bool {
	mut var_discounts := create_wc_discounts(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
		'cart'))
	mut var_valid := var_discounts.is_coupon_valid(rt.new_object('WC_Coupon', []string{}, this))
	if rt.is_true(rt.call_function('is_wp_error', [var_valid.clone()])) {
		this.error_message = rt.call_method(var_valid, 'get_error_message', []rt.PhpVal{})
		return false
	}
	return var_valid.to_bool()
}

fn (mut this Class_WC_Coupon) is_valid_for_cart() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_coupon_is_valid_for_cart'),
		rt.new_bool(this.is_type(rt.call_function('wc_get_cart_coupon_types', []rt.PhpVal{}))),
		rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this),
	])
}

fn (mut this Class_WC_Coupon) is_valid_for_product(var_product rt.PhpVal, var_values rt.PhpVal) rt.PhpVal {
	if !(this.is_type(rt.call_function('wc_get_product_coupon_types', []rt.PhpVal{})))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_product.clone(), Class_WC_Product.class()]))))) {
		return rt.call_function('apply_filters', [
			rt.new_string('woocommerce_coupon_is_valid_for_product'),
			rt.new_bool(false),
			var_product.clone(),
			rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this),
			var_values.clone(),
		])
	}
	mut var_valid := rt.new_bool(false)
	mut var_product_cats := rt.call_function('wc_get_product_cat_ids', [if rt.is_true(rt.call_method(var_product,
		'is_type', [
		Class_Automattic_WooCommerce_Enums_ProductType.variation(),
	]))
	{
		rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})
	} else {
		rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	}])
	mut var_product_ids := [rt.call_method(var_product, 'get_id', []rt.PhpVal{}),
		rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{})]
	if rt.is_true(rt.new_int(this.get_product_ids('').array_count()))
		&& rt.is_true(rt.new_int(rt.call_function('array_intersect', [rt.create_array_from_list(var_product_ids), this.get_product_ids('')]).array_count())) {
		var_valid = rt.new_bool(true)
	}
	if rt.is_true(rt.new_int(this.get_product_categories('').array_count()))
		&& rt.is_true(rt.new_int(rt.call_function('array_intersect', [var_product_cats.clone(), this.get_product_categories('')]).array_count())) {
		var_valid = rt.new_bool(true)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(this.get_product_ids('').array_count())))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(this.get_product_categories('').array_count()))))) {
		var_valid = rt.new_bool(true)
	}
	if rt.is_true(rt.new_int(this.get_excluded_product_ids('').array_count()))
		&& rt.is_true(rt.new_int(rt.call_function('array_intersect', [rt.create_array_from_list(var_product_ids), this.get_excluded_product_ids('')]).array_count())) {
		var_valid = rt.new_bool(false)
	}
	if rt.is_true(rt.new_int(this.get_excluded_product_categories('').array_count()))
		&& rt.is_true(rt.new_int(rt.call_function('array_intersect', [var_product_cats.clone(), this.get_excluded_product_categories('')]).array_count())) {
		var_valid = rt.new_bool(false)
	}
	if rt.is_true(this.get_exclude_sale_items(''))
		&& rt.is_true(rt.call_method(var_product, 'is_on_sale', []rt.PhpVal{})) {
		var_valid = rt.new_bool(false)
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_coupon_is_valid_for_product'),
		var_valid.clone(),
		var_product.clone(),
		rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this),
		var_values.clone(),
	])
}

fn (mut this Class_WC_Coupon) add_coupon_message(var_msg_code rt.PhpVal, notice_type string) {
	mut notice_type_mutated := notice_type
	if rt.is_true(rt.less(var_msg_code, rt.new_int(200))) {
		mut var_msg := this.get_coupon_error(var_msg_code.clone())
		notice_type_mutated = 'error'
	} else {
		var_msg = this.get_coupon_message(var_msg_code.clone())
	}
	if !rt.is_true(var_msg) {
		return
	}
	if rt.is_true(rt.call_function('wc_has_notice', [var_msg.clone(),
		rt.new_string(notice_type_mutated).clone()]))
	{
		return
	}
	rt.call_function('wc_add_notice', [var_msg.clone(), rt.new_string(notice_type_mutated).clone()])
}

fn (mut this Class_WC_Coupon) get_coupon_message(var_msg_code rt.PhpVal) rt.PhpVal {
	mut switch_val_2 := var_msg_code
	if rt.is_true(rt.equal(switch_val_2, Class_WC_Coupon.wc_coupon_success())) {
		mut var_msg := rt.call_function('__', [
			rt.new_string('Coupon code applied successfully.'),
			rt.new_string('woocommerce'),
		])
	} else if rt.is_true(rt.equal(switch_val_2, Class_WC_Coupon.wc_coupon_removed())) {
		var_msg = rt.call_function('__', [
			rt.new_string('Coupon code removed successfully.'),
			rt.new_string('woocommerce'),
		])
	} else {
		var_msg = rt.new_string('')
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_coupon_message'),
		var_msg.clone(),
		var_msg_code.clone(),
		rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this),
	])
}

fn (mut this Class_WC_Coupon) get_coupon_error(var_err_code rt.PhpVal) rt.PhpVal {
	mut switch_val_3 := var_err_code
	if rt.is_true(rt.equal(switch_val_3, Class_WC_Coupon.e_wc_coupon_invalid_filtered())) {
		mut var_err := rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Coupon "%s" cannot be applied because it is not valid.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				this.get_code(''),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_3, Class_WC_Coupon.e_wc_coupon_not_exist())) {
		var_err = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Coupon "%s" cannot be applied because it does not exist.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				this.get_code(''),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_3, Class_WC_Coupon.e_wc_coupon_invalid_removed())) {
		var_err = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Sorry, it seems the coupon "%s" is invalid - it has now been removed from your order.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				this.get_code(''),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_3, Class_WC_Coupon.e_wc_coupon_not_yours_removed())) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}
		mut iife_result_3 := iife_temp_3.get_value_or_default(rt.get_superglobal('_POST').clone(),
			rt.new_string('billing_email'))
		mut var_billing_email := iife_result_3
		if !(var_billing_email.clone().is_null()) {
			var_err = rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('Please enter a valid email to use coupon code "%s".'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					this.get_code(''),
				]),
			])
		} else {
			var_err = rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('Please enter a valid email at checkout to use coupon code "%s".'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					this.get_code(''),
				]),
			])
		}
	} else if rt.is_true(rt.equal(switch_val_3, Class_WC_Coupon.e_wc_coupon_already_applied())) {
		var_err = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Coupon code "%s" already applied!'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				this.get_code(''),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_3,
		Class_WC_Coupon.e_wc_coupon_already_applied_indiv_use_only()))
	{
		var_err = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Sorry, coupon "%s" has already been applied and cannot be used in conjunction with other coupons.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				this.get_code(''),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_3, Class_WC_Coupon.e_wc_coupon_usage_limit_reached())) {
		var_err = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Usage limit for coupon "%s" has been reached.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				this.get_code(''),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_3, Class_WC_Coupon.e_wc_coupon_expired())) {
		var_err = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [rt.new_string('Coupon "%s" has expired.'),
				rt.new_string('woocommerce')]),
			rt.call_function('esc_html', [this.get_code('')]),
		])
	} else if rt.is_true(rt.equal(switch_val_3,
		Class_WC_Coupon.e_wc_coupon_min_spend_limit_not_met()))
	{
		mut var_allowed_tags := rt.create_array([
			rt.ArrayItem{ key: 'span', val: rt.create_array([
				rt.ArrayItem{ key: 'class', val: true },
			]) },
			rt.ArrayItem{ key: 'bdi', val: true },
			rt.ArrayItem{ key: 'small', val: true },
		])
		var_err = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('The minimum spend for coupon "%1$s" is %2$s.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				this.get_code(''),
			]),
			rt.call_function('wp_kses', [
				rt.call_function('wc_price', [this.get_minimum_amount('')]),
				var_allowed_tags.clone(),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_3, Class_WC_Coupon.e_wc_coupon_max_spend_limit_met())) {
		var_allowed_tags = rt.create_array([
			rt.ArrayItem{ key: 'span', val: rt.create_array([
				rt.ArrayItem{ key: 'class', val: true },
			]) },
			rt.ArrayItem{ key: 'bdi', val: true },
			rt.ArrayItem{ key: 'small', val: true },
		])
		var_err = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('The maximum spend for coupon "%1$s" is %2$s.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				this.get_code(''),
			]),
			rt.call_function('wp_kses', [
				rt.call_function('wc_price', [this.get_maximum_amount('')]),
				var_allowed_tags.clone(),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_3, Class_WC_Coupon.e_wc_coupon_not_applicable())) {
		var_err = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Sorry, coupon "%s" is not applicable to your cart contents.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				this.get_code(''),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_3,
		Class_WC_Coupon.e_wc_coupon_usage_limit_coupon_stuck()))
	{
		if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
			&& rt.is_true(rt.greater(rt.call_function('wc_get_page_id', [rt.new_string('myaccount')]), rt.new_int(0)))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_store_api_request', []rt.PhpVal{}))))) {
			var_err = rt.call_function('sprintf', [
				rt.call_function('wp_kses_data', [
					rt.call_function('__', [
						rt.new_string('Usage limit for coupon "%1$s" has been reached. If you were using this coupon just now but your order was not complete, you can retry or cancel the order by going to the <a href="%2$s">my account page</a>.'),
						rt.new_string('woocommerce'),
					]),
				]),
				rt.call_function('esc_html', [
					this.get_code(''),
				]),
				rt.call_function('esc_attr', [
					rt.call_function('wc_get_endpoint_url', [
						rt.new_string('orders'),
						rt.new_string(''),
						rt.call_function('wc_get_page_permalink', [
							rt.new_string('myaccount'),
						]),
					]),
				]),
			])
		} else {
			var_err =
				this.get_coupon_error(rt.new_int(Class_WC_Coupon.e_wc_coupon_usage_limit_reached()))
		}
	} else if rt.is_true(rt.equal(switch_val_3,
		Class_WC_Coupon.e_wc_coupon_usage_limit_coupon_stuck_guest()))
	{
		var_err = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Usage limit for coupon "%s" has been reached. Please try again after some time, or contact us for help.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				this.get_code(''),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_3, Class_WC_Coupon.e_wc_coupon_excluded_products())) {
		mut var_products := rt.new_array()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'cart'), 'is_empty', []rt.PhpVal{})))))
		{
			mut iter_3 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
				'cart'), 'get_cart', []rt.PhpVal{}).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_cart_item := item_3.val
				mut var_cart_item_key := item_3.key
				if rt.is_true(rt.call_function('in_array', [rt.new_int(var_cart_item.array_get(rt.new_string('product_id')).to_i64()), this.get_excluded_product_ids(''), rt.new_bool(true)]))
					|| rt.is_true(rt.call_function('in_array', [rt.new_int(var_cart_item.array_get(rt.new_string('variation_id')).to_i64()), this.get_excluded_product_ids(''), rt.new_bool(true)]))
					|| rt.is_true(rt.call_function('in_array', [rt.new_int(rt.call_method(var_cart_item.array_get(rt.new_string('data')), 'get_parent_id', []rt.PhpVal{}).to_i64()), this.get_excluded_product_ids(''), rt.new_bool(true)])) {
					var_products.array_push(rt.call_method(var_cart_item.array_get(rt.new_string('data')),
						'get_name', []rt.PhpVal{}))
				}
			}
		}
		var_err = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Sorry, coupon "%1$s" is not applicable to the products: %2$s.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				this.get_code(''),
			]),
			rt.call_function('esc_html', [
				rt.call_function('implode', [rt.new_string(', '),
					var_products.clone()]),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_3, Class_WC_Coupon.e_wc_coupon_excluded_categories())) {
		mut var_categories := rt.new_array()
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.get_property(rt.call_function('WC',
			[]rt.PhpVal{}), 'cart'), 'is_empty', []rt.PhpVal{})))))
		{
			mut iter_4 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
				'cart'), 'get_cart', []rt.PhpVal{}).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_cart_item := item_4.val
				mut var_cart_item_key := item_4.key
				mut var_product_cats := rt.call_function('wc_get_product_cat_ids', [
					var_cart_item.array_get(rt.new_string('product_id')),
				])
				mut var_intersect := rt.call_function('array_intersect', [
					var_product_cats.clone(), this.get_excluded_product_categories('')])
				if var_intersect.clone().array_count() > 0 {
					mut iter_5 := var_intersect.iterator()
					for {
						item_5 := iter_5.next() or { break }
						mut var_cat_id := item_5.val
						mut var_cat := rt.call_function('get_term', [
							var_cat_id.clone(), rt.new_string('product_cat')])
						var_categories.array_push(rt.get_property(var_cat, 'name'))
					}
				}
			}
		}
		var_err = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Sorry, coupon "%1$s" is not applicable to the categories: %2$s.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				this.get_code(''),
			]),
			rt.call_function('esc_html', [
				rt.call_function('implode', [rt.new_string(', '),
					rt.call_function('array_unique', [var_categories.clone()])]),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_3, Class_WC_Coupon.e_wc_coupon_not_valid_sale_items())) {
		var_err = rt.call_function('sprintf', [
			rt.call_function('esc_html__', [
				rt.new_string('Sorry, coupon "%s" is not valid for sale items.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('esc_html', [
				this.get_code(''),
			]),
		])
	} else {
		var_err = rt.new_string('')
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_error'),
		var_err.clone(), var_err_code.clone(), rt.new_object('WC_Coupon', [
			'WC_Legacy_Coupon',
		], &this)])
}

fn Class_WC_Coupon.get_generic_coupon_error(var_err_code rt.PhpVal) rt.PhpVal {
	mut switch_val_4 := var_err_code
	if rt.is_true(rt.equal(switch_val_4, Class_WC_Coupon.e_wc_coupon_not_exist())) {
		mut var_err := rt.call_function('__', [rt.new_string('Coupon does not exist.'),
			rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_4, Class_WC_Coupon.e_wc_coupon_please_enter())) {
		var_err = rt.call_function('__', [rt.new_string('Please enter a coupon code.'),
			rt.new_string('woocommerce')])
	} else {
		var_err = rt.new_string('')
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_error'),
		var_err.clone(), var_err_code.clone(), rt.new_null()])
}

fn (mut this Class_WC_Coupon) get_short_info() string {
	mut var_type := this.get_discount_type('')
	mut var_info := [this.get_id(), this.get_code(''), if rt.is_true(rt.identical(rt.new_string('fixed_cart'),
		var_type))
	{
		rt.new_null()
	} else {
		var_type
	}, rt.new_float((this.get_prop(rt.new_string('amount'))).to_f64())]
	if rt.is_true(this.get_free_shipping('')) {
		var_info << rt.new_bool(true)
	}
	return (rt.call_function('wp_json_encode', [rt.create_array_from_list(var_info)])).str()
}

fn Class_WC_Coupon.parse_short_info(info string) rt.PhpVal {
	mut info_mutated := info
	mut var_data := rt.call_function('json_decode', [rt.new_string(info_mutated).clone(),
		rt.new_bool(true)])
	if !(var_data.clone().is_array()) {
		var_data = rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{
			key: 'id'
			val: if !(var_data.array_get(rt.new_int(0))).is_null() {
				var_data.array_get(rt.new_int(0))
			} else {
				rt.new_int(0)
			}
		},
		rt.ArrayItem{
			key: 'code'
			val: if !(var_data.array_get(rt.new_int(1))).is_null() {
				var_data.array_get(rt.new_int(1))
			} else {
				rt.new_string('')
			}
		},
		rt.ArrayItem{
			key: 'discount_type'
			val: if !(var_data.array_get(rt.new_int(2))).is_null() {
				var_data.array_get(rt.new_int(2))
			} else {
				rt.new_string('fixed_cart')
			}
		},
		rt.ArrayItem{ key: 'amount', val: rt.new_float((if !(var_data.array_get(rt.new_int(3))).is_null() {
			var_data.array_get(rt.new_int(3))
		} else {
			rt.new_int(0)
		}).to_f64()) },
		rt.ArrayItem{ key: 'free_shipping', val: (if !(var_data.array_get(rt.new_int(4))).is_null() {
			var_data.array_get(rt.new_int(4))
		} else {
			rt.new_bool(false)
		}).to_bool() },
	])
}

fn (mut this Class_WC_Coupon) set_short_info(info string) {
	mut info_mutated := info
	mut var_data := Class_WC_Coupon.parse_short_info(info_mutated)
	this.set_id(var_data.array_get(rt.new_string('id')))
	this.set_code(var_data.array_get(rt.new_string('code')))
	this.set_discount_type_core(var_data.array_get(rt.new_string('discount_type')), false)
	this.set_amount(var_data.array_get(rt.new_string('amount')))
	this.set_free_shipping(var_data.array_get(rt.new_string('free_shipping')))
}

fn Class_WC_Coupon.from_order_item(mut var_order_item Class_WC_Order_Item_Coupon) rt.PhpVal {
	mut var_coupon_info := var_order_item.get_meta(rt.new_string('coupon_info'), rt.new_bool(true))
	if var_coupon_info.clone().is_string()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_coupon_info)))) {
		mut var_data := Class_WC_Coupon.parse_short_info(var_coupon_info.str())
	} else {
		mut var_coupon_meta := var_order_item.get_meta(rt.new_string('coupon_data'),
			rt.new_bool(true))
		if var_coupon_meta.clone().is_object() || var_coupon_meta.clone().is_array() {
			var_coupon_meta = rt.cast_array(var_coupon_meta)
			var_data = rt.create_array([rt.ArrayItem{ key: 'id', val: 0 },
				rt.ArrayItem{ key: 'code', val: '' }, rt.ArrayItem{
					key: 'discount_type'
					val: if !(var_coupon_meta.array_get(rt.new_string('discount_type'))).is_null() {
						var_coupon_meta.array_get(rt.new_string('discount_type'))
					} else {
						rt.new_string('fixed_cart')
					}
				}, rt.ArrayItem{ key: 'amount', val: rt.new_float((if !(var_coupon_meta.array_get(rt.new_string('amount'))).is_null() {
					var_coupon_meta.array_get(rt.new_string('amount'))
				} else {
					rt.new_int(0)
				}).to_f64()) }, rt.ArrayItem{ key: 'free_shipping', val: (if !(var_coupon_meta.array_get(rt.new_string('free_shipping'))).is_null() {
					var_coupon_meta.array_get(rt.new_string('free_shipping'))
				} else {
					rt.new_bool(false)
				}).to_bool() }])
		} else {
			return rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], create_wc_coupon(''))
		}
	}
	mut var_coupon := create_wc_coupon('')
	rt.call_method(var_coupon, 'set_id', [var_data.array_get(rt.new_string('id'))])
	rt.call_method(var_coupon, 'set_code', [var_data.array_get(rt.new_string('code'))])
	rt.call_method(var_coupon, 'set_discount_type_core', [
		var_data.array_get(rt.new_string('discount_type')),
		rt.new_bool(false),
	])
	rt.call_method(var_coupon, 'set_prop', [rt.new_string('amount'),
		var_data.array_get(rt.new_string('amount'))])
	rt.call_method(var_coupon, 'set_free_shipping', [
		var_data.array_get(rt.new_string('free_shipping')),
	])
	return var_coupon.clone()
}

fn (mut this Class_WC_Coupon) get_context_based_coupon_errors(var_err_code rt.PhpVal) rt.PhpVal {
	mut switch_val_5 := var_err_code
	if rt.is_true(rt.equal(switch_val_5, Class_WC_Coupon.e_wc_coupon_not_yours_removed())) {
		return rt.create_array([
			rt.ArrayItem{ key: 'cart', val: rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('Please enter a valid email at checkout to use coupon code "%s".'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					this.get_code(''),
				]),
			]) },
			rt.ArrayItem{ key: 'checkout', val: rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('Please enter a valid email to use coupon code "%s".'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_html', [
					this.get_code(''),
				]),
			]) },
		])
	} else {
		return rt.new_array()
	}
	return rt.new_null()
}

struct Class_WC_Legacy_Coupon {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WC_Discounts {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

fn create_wc_coupon(data string) &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
		data:          rt.new_array()
		cache_group:   rt.new_string('coupons')
		error_message: rt.new_null()
		sort:          rt.new_int(0)
	}
	obj.construct(data)
	return obj
}

fn create_wc_legacy_coupon(_args ...rt.PhpVal) &Class_WC_Legacy_Coupon {
	mut obj := &Class_WC_Legacy_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
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

fn create_automattic_woocommerce_utilities_numberutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_discounts(_args ...rt.PhpVal) &Class_WC_Discounts {
	mut obj := &Class_WC_Discounts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_data' {
			return this.get_data()
		}
		'read_object_from_database' {
			this.read_object_from_database()
			return rt.new_null()
		}
		'is_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_type(dispatch_arg_0))
		}
		'get_hook_prefix' {
			return rt.new_string(this.get_hook_prefix())
		}
		'get_code' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_code(dispatch_arg_0)
		}
		'get_description' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_description(dispatch_arg_0)
		}
		'get_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_status(dispatch_arg_0)
		}
		'get_discount_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_discount_type(dispatch_arg_0)
		}
		'get_amount' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_amount(dispatch_arg_0)
		}
		'get_date_expires' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_expires(dispatch_arg_0)
		}
		'get_date_created' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_created(dispatch_arg_0)
		}
		'get_date_modified' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_modified(dispatch_arg_0)
		}
		'get_usage_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_usage_count(dispatch_arg_0)
		}
		'get_individual_use' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_individual_use(dispatch_arg_0)
		}
		'get_product_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_product_ids(dispatch_arg_0)
		}
		'get_excluded_product_ids' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_excluded_product_ids(dispatch_arg_0)
		}
		'get_usage_limit' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_usage_limit(dispatch_arg_0)
		}
		'get_usage_limit_per_user' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_usage_limit_per_user(dispatch_arg_0)
		}
		'get_limit_usage_to_x_items' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_limit_usage_to_x_items(dispatch_arg_0)
		}
		'get_free_shipping' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_free_shipping(dispatch_arg_0)
		}
		'get_product_categories' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_product_categories(dispatch_arg_0)
		}
		'get_excluded_product_categories' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_excluded_product_categories(dispatch_arg_0)
		}
		'get_exclude_sale_items' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_exclude_sale_items(dispatch_arg_0)
		}
		'get_minimum_amount' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_minimum_amount(dispatch_arg_0)
		}
		'get_maximum_amount' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_maximum_amount(dispatch_arg_0)
		}
		'get_email_restrictions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_email_restrictions(dispatch_arg_0)
		}
		'get_used_by' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_used_by(dispatch_arg_0)
		}
		'get_virtual' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.get_virtual(dispatch_arg_0))
		}
		'get_discount_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_discount_amount(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'set_code' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_code(dispatch_arg_0)
			return rt.new_null()
		}
		'set_description' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_description(dispatch_arg_0)
			return rt.new_null()
		}
		'set_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_status(dispatch_arg_0)
			return rt.new_null()
		}
		'set_discount_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_discount_type(dispatch_arg_0)
			return rt.new_null()
		}
		'set_discount_type_core' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.set_discount_type_core(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'set_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_amount(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_expires' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_expires(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_created' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_created(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_modified' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_modified(dispatch_arg_0)
			return rt.new_null()
		}
		'set_usage_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_usage_count(dispatch_arg_0)
			return rt.new_null()
		}
		'set_individual_use' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_individual_use(dispatch_arg_0)
			return rt.new_null()
		}
		'set_product_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_product_ids(dispatch_arg_0)
			return rt.new_null()
		}
		'set_excluded_product_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_excluded_product_ids(dispatch_arg_0)
			return rt.new_null()
		}
		'set_usage_limit' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_usage_limit(dispatch_arg_0)
			return rt.new_null()
		}
		'set_usage_limit_per_user' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_usage_limit_per_user(dispatch_arg_0)
			return rt.new_null()
		}
		'set_limit_usage_to_x_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_limit_usage_to_x_items(dispatch_arg_0)
			return rt.new_null()
		}
		'set_free_shipping' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_free_shipping(dispatch_arg_0)
			return rt.new_null()
		}
		'set_product_categories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_product_categories(dispatch_arg_0)
			return rt.new_null()
		}
		'set_excluded_product_categories' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_excluded_product_categories(dispatch_arg_0)
			return rt.new_null()
		}
		'set_exclude_sale_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_exclude_sale_items(dispatch_arg_0)
			return rt.new_null()
		}
		'set_minimum_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_minimum_amount(dispatch_arg_0)
			return rt.new_null()
		}
		'set_maximum_amount' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_maximum_amount(dispatch_arg_0)
			return rt.new_null()
		}
		'set_email_restrictions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_email_restrictions(dispatch_arg_0)
			return rt.new_null()
		}
		'set_used_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_used_by(dispatch_arg_0)
			return rt.new_null()
		}
		'set_virtual' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_virtual(dispatch_arg_0)
			return rt.new_null()
		}
		'read_manual_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.read_manual_coupon(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'increase_usage_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.increase_usage_count(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'decrease_usage_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.decrease_usage_count(dispatch_arg_0)
			return rt.new_null()
		}
		'get_error_message' {
			return this.get_error_message()
		}
		'set_error_message' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_error_message(dispatch_arg_0)
			return rt.new_null()
		}
		'is_valid' {
			return rt.new_bool(this.is_valid())
		}
		'is_valid_for_cart' {
			return this.is_valid_for_cart()
		}
		'is_valid_for_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.is_valid_for_product(dispatch_arg_0, dispatch_arg_1)
		}
		'add_coupon_message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.add_coupon_message(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_coupon_message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_coupon_message(dispatch_arg_0)
		}
		'get_coupon_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_coupon_error(dispatch_arg_0)
		}
		'get_generic_coupon_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Coupon.get_generic_coupon_error(dispatch_arg_0)
		}
		'get_short_info' {
			return rt.new_string(this.get_short_info())
		}
		'parse_short_info' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WC_Coupon.parse_short_info(dispatch_arg_0)
		}
		'set_short_info' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_short_info(dispatch_arg_0)
			return rt.new_null()
		}
		'from_order_item' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order_Item_Coupon](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_WC_Coupon.from_order_item(mut dispatch_arg_0)
		}
		'get_context_based_coupon_errors' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_context_based_coupon_errors(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'cache_group' { return this.cache_group }
		'error_message' { return this.error_message }
		'sort' { return this.sort }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' {
			this.data = val
			return true
		}
		'cache_group' {
			this.cache_group = val
			return true
		}
		'error_message' {
			this.error_message = val
			return true
		}
		'sort' {
			this.sort = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Legacy_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Legacy_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Legacy_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_NumberUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Discounts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Discounts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Discounts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ArrayUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.include_file(@DIR + '/legacy/class-wc-legacy-coupon.php', '4')
}
