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
		data rt.PhpVal = rt.new_array()
		cache_group rt.PhpVal = rt.new_string('coupons')
		error_message rt.PhpVal = rt.new_null()
		sort rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WC_Coupon) construct(data string)  {
	mut data_mutated := data
	this.Class_WC_Legacy_Coupon.construct(rt.new_string(data_mutated))
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_string(data_mutated), 'WC_Coupon'))) {
		this.set_id(rt.call_function('absint', [rt.call_method(rt.new_string(data_mutated), 'get_id', []rt.PhpVal{})]))
		this.read_object_from_database()
		return
	}
	mut var_coupon := rt.call_function('apply_filters', [rt.new_string('woocommerce_get_shop_coupon_data'), rt.new_bool(false), rt.new_string(data_mutated).dup(), rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this)])
	if rt.is_true(var_coupon) {
		this.read_manual_coupon(rt.new_string(data_mutated), var_coupon.dup())
		return
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.new_string(data_mutated).dup().is_long())) && rt.is_true(rt.identical(rt.new_string('shop_coupon'), rt.call_function('get_post_type', [rt.new_string(data_mutated).dup()]))))) {
		this.set_id(rt.new_string(data_mutated))
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.new_string(data_mutated).dup().is_string())) && rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_StringUtil{}; return temp.is_null_or_whitespace(arg_0) }(rt.new_string(data_mutated)))))))) {
		mut var_id := rt.call_function('wc_get_coupon_id_by_code', [rt.new_string(data_mutated).dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) && rt.is_true(rt.identical(rt.new_string('shop_coupon'), rt.call_function('get_post_type', [rt.new_string(data_mutated).dup()]))))) {
			this.set_id(rt.new_string(data_mutated))
		} else {
			this.set_id(var_id.dup())
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
	if rt.is_true(rt.identical(rt.new_string(''), var_data.array_get('minimum_amount'))) {
		var_data.array_set('minimum_amount', '0')
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_data.array_get('maximum_amount'))) {
		var_data.array_set('maximum_amount', '0')
	}
	return var_data.dup()
}

fn (mut this Class_WC_Coupon) read_object_from_database()  {
	this.dispatch_set_prop('data_store', fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('coupon')))
	if rt.is_true(rt.greater(this.get_id(), rt.new_int(0))) {
		rt.call_method(rt.get_property(rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this), 'data_store'), 'read', [rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this)])
	}
}

fn (mut this Class_WC_Coupon) is_type(var_type rt.PhpVal) bool {
	mut var_type_mutated := var_type
	return rt.is_true(rt.identical(this.get_discount_type(''), var_type_mutated)) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_type_mutated.dup().is_array())) && rt.is_true(rt.call_function('in_array', [this.get_discount_type(''), var_type_mutated.dup(), rt.new_bool(true)]))))
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
	return rt.call_function('wc_format_decimal', [this.get_prop(rt.new_string('amount'), rt.new_string(context))])
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
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.identical(this.get_prop(rt.new_string('minimum_amount'), rt.new_string(context)), rt.new_string(''))))) {
		return rt.call_function('wc_format_decimal', [rt.new_int(0)])
	}
	return rt.call_function('wc_format_decimal', [this.get_prop(rt.new_string('minimum_amount'), rt.new_string(context))])
}

fn (mut this Class_WC_Coupon) get_maximum_amount(context string) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.identical(this.get_prop(rt.new_string('maximum_amount'), rt.new_string(context)), rt.new_string(''))))) {
		return rt.call_function('wc_format_decimal', [rt.new_int(0)])
	}
	return rt.call_function('wc_format_decimal', [this.get_prop(rt.new_string('maximum_amount'), rt.new_string(context))])
}

fn (mut this Class_WC_Coupon) get_email_restrictions(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('email_restrictions'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_used_by(context string) rt.PhpVal {
	if rt.is_true(rt.new_bool(this.data.array_get('used_by').is_null())) {
		this.data.array_set('used_by', if rt.is_true(this.get_id()) { rt.call_function('array_filter', [rt.cast_array(rt.call_function('get_post_meta', [this.get_id(), rt.new_string('_used_by'), rt.new_bool(false)]))]) } else { rt.new_array() })
	}
	return this.get_prop(rt.new_string('used_by'), rt.new_string(context))
}

fn (mut this Class_WC_Coupon) get_virtual(context string) rt.PhpVal {
	return // unsupported expression: Expr_Cast_Bool
}

fn (mut this Class_WC_Coupon) get_discount_amount(var_discounting_amount rt.PhpVal, var_cart_item rt.PhpVal, single bool) rt.PhpVal {
	mut var_discount := rt.new_int(rt.new_int(0))
	mut var_cart_item_qty := if rt.is_true(rt.new_bool(var_cart_item.dup().is_null())) { rt.new_int(1) } else { var_cart_item.array_get('quantity') }
	if this.is_type(rt.create_array([rt.ArrayItem{ key: none, val: 'percent' }])) {
		var_discount = rt.mul(// unsupported expression: Expr_Cast_Double, rt.div(var_discounting_amount, rt.new_int(100)))
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(this.is_type(rt.new_string('fixed_cart')) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cart_item.dup().is_null()))))))) && rt.is_true(rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'subtotal_ex_tax')))) {
		if rt.is_true(rt.call_function('wc_prices_include_tax', []rt.PhpVal{})) {
			mut var_discount_percent := rt.div(rt.mul(rt.call_function('wc_get_price_including_tax', [var_cart_item.array_get('data')]), var_cart_item_qty), rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'subtotal'))
		} else {
			var_discount_percent = rt.div(rt.mul(rt.call_function('wc_get_price_excluding_tax', [var_cart_item.array_get('data')]), var_cart_item_qty), rt.get_property(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart'), 'subtotal_ex_tax'))
		}
		var_discount = rt.div(rt.mul(// unsupported expression: Expr_Cast_Double, var_discount_percent), var_cart_item_qty)
	} else if this.is_type(rt.new_string('fixed_product')) {
		var_discount = rt.call_function('min', [this.get_amount(''), var_discounting_amount.dup()])
		var_discount = if var_single { var_discount } else { rt.mul(var_discount, var_cart_item_qty) }
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_get_discount_amount'), fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.round(arg_0, arg_1) }(rt.call_function('min', [var_discount.dup(), var_discounting_amount.dup()]), rt.call_function('wc_get_rounding_precision', []rt.PhpVal{})), var_discounting_amount.dup(), var_cart_item.dup(), rt.new_bool(single), rt.new_object('WC_Coupon', ['WC_Legacy_Coupon'], &this)])
}

fn (mut this Class_WC_Coupon) set_code(var_code rt.PhpVal)  {
	this.set_prop(rt.new_string('code'), rt.call_function('wc_format_coupon_code', [var_code.dup()]))
}

fn (mut this Class_WC_Coupon) set_description(var_description rt.PhpVal)  {
	this.set_prop(rt.new_string('description'), var_description.dup())
}

fn (mut this Class_WC_Coupon) set_status(var_status rt.PhpVal)  {
	this.set_prop(rt.new_string('status'), var_status.dup())
}

fn (mut this Class_WC_Coupon) set_discount_type(var_discount_type rt.PhpVal)  {
	mut var_discount_type_mutated := var_discount_type
	this.set_discount_type_core(var_discount_type_mutated.dup(), true)
}

fn (mut this Class_WC_Coupon) set_discount_type_core(var_discount_type rt.PhpVal, verify_discount_type bool)  {
	mut var_discount_type_mutated := var_discount_type
	if rt.is_true(rt.identical(rt.new_string('percent_product'), var_discount_type_mutated)) {
		var_discount_type_mutated = rt.new_string(rt.new_string('percent'))
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(var_verify_discount_type && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_discount_type_mutated.dup(), rt.func_array_keys(rt.call_function('wc_get_coupon_types', []rt.PhpVal{})), rt.new_bool(true)]))))))) {
		this.error(rt.new_string('coupon_invalid_discount_type'), rt.call_function('__', [rt.new_string('Invalid discount type.'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('discount_type'), var_discount_type_mutated.dup())
}

fn (mut this Class_WC_Coupon) set_amount(var_amount rt.PhpVal)  {
	mut var_amount_mutated := var_amount
	var_amount_mutated = rt.call_function('wc_format_decimal', [var_amount_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_amount_mutated.dup().is_long() || var_amount_mutated.dup().is_double()))))) {
		var_amount_mutated = rt.new_int(rt.new_int(0))
	}
	if rt.is_true(rt.less(// unsupported expression: Expr_Cast_Double, rt.new_int(0))) {
		this.error(rt.new_string('coupon_invalid_amount'), rt.call_function('__', [rt.new_string('Invalid discount amount.'), rt.new_string('woocommerce')]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('percent'), this.get_discount_type(''))) && rt.is_true(rt.greater(// unsupported expression: Expr_Cast_Double, rt.new_int(100))))) {
		this.error(rt.new_string('coupon_invalid_amount'), rt.call_function('__', [rt.new_string('Invalid discount amount.'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('amount'), var_amount_mutated.dup())
}

fn (mut this Class_WC_Coupon) set_date_expires(var_date rt.PhpVal)  {
	this.set_date_prop(rt.new_string('date_expires'), var_date.dup())
}

fn (mut this Class_WC_Coupon) set_date_created(var_date rt.PhpVal)  {
	this.set_date_prop(rt.new_string('date_created'), var_date.dup())
}

fn (mut this Class_WC_Coupon) set_date_modified(var_date rt.PhpVal)  {
	this.set_date_prop(rt.new_string('date_modified'), var_date.dup())
}

fn (mut this Class_WC_Coupon) set_usage_count(var_usage_count rt.PhpVal)  {
	this.set_prop(rt.new_string('usage_count'), rt.call_function('absint', [var_usage_count.dup()]))
}

fn (mut this Class_WC_Coupon) set_individual_use(var_is_individual_use rt.PhpVal)  {
	this.set_prop(rt.new_string('individual_use'), // unsupported expression: Expr_Cast_Bool)
}

fn (mut this Class_WC_Coupon) set_product_ids(var_product_ids rt.PhpVal)  {
	mut var_product_ids_mutated := var_product_ids
	this.set_prop(rt.new_string('product_ids'), rt.call_function('array_filter', [rt.call_function('wp_parse_id_list', [rt.cast_array(var_product_ids_mutated)])]))
}

fn (mut this Class_WC_Coupon) set_excluded_product_ids(var_excluded_product_ids rt.PhpVal)  {
	this.set_prop(rt.new_string('excluded_product_ids'), rt.call_function('array_filter', [rt.call_function('wp_parse_id_list', [rt.cast_array(var_excluded_product_ids)])]))
}

fn (mut this Class_WC_Coupon) set_usage_limit(var_usage_limit rt.PhpVal)  {
	this.set_prop(rt.new_string('usage_limit'), rt.call_function('absint', [var_usage_limit.dup()]))
}

fn (mut this Class_WC_Coupon) set_usage_limit_per_user(var_usage_limit rt.PhpVal)  {
	this.set_prop(rt.new_string('usage_limit_per_user'), rt.call_function('absint', [var_usage_limit.dup()]))
}

fn (mut this Class_WC_Coupon) set_limit_usage_to_x_items(var_limit_usage_to_x_items rt.PhpVal)  {
	this.set_prop(rt.new_string('limit_usage_to_x_items'), if rt.is_true(rt.new_bool(var_limit_usage_to_x_items.dup().is_null())) { rt.new_null() } else { rt.call_function('absint', [var_limit_usage_to_x_items.dup()]) })
}

fn (mut this Class_WC_Coupon) set_free_shipping(var_free_shipping rt.PhpVal)  {
	this.set_prop(rt.new_string('free_shipping'), // unsupported expression: Expr_Cast_Bool)
}

fn (mut this Class_WC_Coupon) set_product_categories(var_product_categories rt.PhpVal)  {
	this.set_prop(rt.new_string('product_categories'), rt.call_function('array_filter', [rt.call_function('wp_parse_id_list', [rt.cast_array(var_product_categories)])]))
}

fn (mut this Class_WC_Coupon) set_excluded_product_categories(var_excluded_product_categories rt.PhpVal)  {
	this.set_prop(rt.new_string('excluded_product_categories'), rt.call_function('array_filter', [rt.call_function('wp_parse_id_list', [rt.cast_array(var_excluded_product_categories)])]))
}

fn (mut this Class_WC_Coupon) set_exclude_sale_items(var_exclude_sale_items rt.PhpVal)  {
	this.set_prop(rt.new_string('exclude_sale_items'), // unsupported expression: Expr_Cast_Bool)
}

fn (mut this Class_WC_Coupon) set_minimum_amount(var_amount rt.PhpVal)  {
	mut var_amount_mutated := var_amount
	this.set_prop(rt.new_string('minimum_amount'), rt.call_function('wc_format_decimal', [var_amount_mutated.dup()]))
}

fn (mut this Class_WC_Coupon) set_maximum_amount(var_amount rt.PhpVal)  {
	mut var_amount_mutated := var_amount
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_Cast_Double) && rt.is_true(rt.greater(// unsupported expression: Expr_Cast_Double, // unsupported expression: Expr_Cast_Double)))) {
		this.error(rt.new_string('coupon_invalid_maximum_amount'), rt.call_function('__', [rt.new_string('Invalid maximum spend value.'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('maximum_amount'), rt.call_function('wc_format_decimal', [var_amount_mutated.dup()]))
}

fn (mut this Class_WC_Coupon) set_email_restrictions(var_emails rt.PhpVal)  {
	mut var_emails_mutated := var_emails
	var_emails_mutated = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('sanitize_email'), rt.call_function('array_map', [, ])])])
	{
		mut iter_1 := var_emails_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_email := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_email', [.dup()]))))) {
				this.error(rt.new_string(), )
			}
		}
	}
	this.set_prop(rt.new_string(), .dup())
}

fn (mut this Class_WC_Coupon) set_used_by(var_used_by rt.PhpVal)  {
	
}

fn (mut this Class_WC_Coupon) set_virtual(var_virtual rt.PhpVal)  {
}

fn (mut this Class_WC_Coupon) read_manual_coupon(var_code rt.PhpVal, var_coupon rt.PhpVal)  {
	mut var_coupon_mutated := var_coupon
}

fn (mut this Class_WC_Coupon) increase_usage_count(used_by string, var_order rt.PhpVal)  {
}

fn (mut this Class_WC_Coupon) decrease_usage_count(used_by string)  {
}

fn (mut this Class_WC_Coupon) get_error_message() rt.PhpVal {
}

fn (mut this Class_WC_Coupon) set_error_message(message string)  {
}

fn (mut this Class_WC_Coupon) is_valid() bool {
}

fn (mut this Class_WC_Coupon) is_valid_for_cart() rt.PhpVal {
}

fn (mut this Class_WC_Coupon) is_valid_for_product(var_product rt.PhpVal, var_values rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Coupon) add_coupon_message(var_msg_code rt.PhpVal, notice_type string)  {
	mut notice_type_mutated := notice_type
}

fn (mut this Class_WC_Coupon) get_coupon_message(var_msg_code rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Coupon) get_coupon_error(var_err_code rt.PhpVal) rt.PhpVal {
}

fn Class_WC_Coupon.get_generic_coupon_error(var_err_code rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Coupon) get_short_info() string {
}

fn Class_WC_Coupon.parse_short_info(info string) rt.PhpVal {
	mut info_mutated := info
}

fn (mut this Class_WC_Coupon) set_short_info(info string)  {
	mut info_mutated := info
}

fn Class_WC_Coupon.from_order_item(mut var_order_item Class_WC_Order_Item_Coupon) rt.PhpVal {
}

fn (mut this Class_WC_Coupon) get_context_based_coupon_errors(var_err_code rt.PhpVal)  {
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

fn create_wc_coupon(data string) &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
		data: rt.new_array()
		cache_group: rt.new_string('coupons')
		error_message: rt.new_null()
		sort: rt.new_int(0)
	}
	obj.construct(data)
	return obj
}

fn create_wc_legacy_coupon() &Class_WC_Legacy_Coupon {
	mut obj := &Class_WC_Legacy_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil() &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
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

fn create_automattic_woocommerce_utilities_numberutil() &Class_Automattic_WooCommerce_Utilities_NumberUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_NumberUtil{
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
			return this.get_virtual(dispatch_arg_0)
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order_Item_Coupon](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WC_Coupon.from_order_item(mut dispatch_arg_0)
		}
		'get_context_based_coupon_errors' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.get_context_based_coupon_errors(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
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
		'data' { this.data = val; return true }
		'cache_group' { this.cache_group = val; return true }
		'error_message' { this.error_message = val; return true }
		'sort' { this.sort = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_coupon_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	rt.include_file(@DIR + '/legacy/class-wc-legacy-coupon.php', '4')
}
