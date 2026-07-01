import rt

pub fn Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.font_size() i64 {
	return 12
}
pub fn Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.line_height() f64 {
	return Class_Automattic_WooCommerce_Internal_ReceiptRendering_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.font_size() * 1.5
}
pub fn Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.icon_height() rt.PhpVal {
	return Class_Automattic_WooCommerce_Internal_ReceiptRendering_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.line_height()
}
pub fn Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.icon_width() rt.PhpVal {
	return Class_Automattic_WooCommerce_Internal_ReceiptRendering_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.icon_height() * 4 / 3
}
pub fn Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.margin() i64 {
	return 16
}
pub fn Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.title_font_size() i64 {
	return 24
}
pub fn Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.footer_font_size() i64 {
	return 10
}
pub fn Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.known_card_types() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'amex' }, rt.ArrayItem{ key: none, val: 'diners' }, rt.ArrayItem{ key: none, val: 'discover' }, rt.ArrayItem{ key: none, val: 'interac' }, rt.ArrayItem{ key: none, val: 'jcb' }, rt.ArrayItem{ key: none, val: 'mastercard' }, rt.ArrayItem{ key: none, val: 'visa' }])
}
pub fn Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.receipt_file_name_meta_key() string {
	return '_receipt_file_name'
}
struct Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine {
	rt.PhpObjectBase
pub mut:
		transient_files_engine rt.PhpVal = rt.new_null()
		legacy_proxy rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine) init(mut var_transient_files_engine Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine, mut var_legacy_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy)  {
	this.transient_files_engine = var_transient_files_engine.dup()
	this.legacy_proxy = var_legacy_proxy.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine) generate_receipt(var_order rt.PhpVal, var_expiration_date rt.PhpVal, force_new bool) string {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated, 'WC_Abstract_Order')))))) {
		var_order_mutated = rt.call_function('wc_get_order', [var_order_mutated.dup()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_order_mutated)) {
			return (rt.new_null()).str()
		}
	}
	if !(var_force_new) {
		mut var_existing_receipt_filename := rt.new_string(this.get_existing_receipt(var_order_mutated.dup()))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_existing_receipt_filename.dup().is_null()))))) {
			return (var_existing_receipt_filename).str()
		}
	}
	// unsupported expression: Expr_AssignOp_Coalesce
	mut var_data := rt.call_function('apply_filters', [rt.new_string('woocommerce_printable_order_receipt_data'), this.get_order_data(mut rt.cast_object_ptr[Class_WC_Abstract_Order](var_order_mutated)), var_order_mutated.dup()])
	mut var_formatted_line_items := rt.new_array()
	mut var_row_index := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := var_data.array_get('line_items').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_line_item_data := item_1.val
			mut var_quantity_data := rt.new_string(if var_line_item_data.array_isset(rt.new_string('quantity')) { rt.concat(rt.new_string(' × '), var_line_item_data.array_get('quantity')) } else { rt.new_string('') })
			mut var_line_item_display_data := rt.create_array([rt.ArrayItem{ key: 'inner_html', val: rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('<td>'), var_line_item_data.array_get('title')), var_quantity_data), rt.new_string('</td><td>')), var_line_item_data.array_get('amount')), rt.new_string('</td>')) }, rt.ArrayItem{ key: 'tr_attributes', val: rt.new_array() }, rt.ArrayItem{ key: 'row_index', val: rt.post_inc(var_row_index) }])
			var_line_item_display_data = rt.call_function('apply_filters', [rt.new_string('woocommerce_printable_order_receipt_line_item_display_data'), var_line_item_display_data.dup(), var_line_item_data.dup(), var_order_mutated.dup()])
			mut var_attributes := rt.new_string(rt.new_string(''))
			{
				mut iter_2 := var_line_item_display_data.array_get('tr_attributes').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_attribute_value := item_2.val
					mut var_attribute_name := item_2.key
					var_attribute_value = rt.call_function('esc_attr', [var_attribute_value.dup()])
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
			var_formatted_line_items.array_push(rt.call_function('wp_kses_post', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('<tr'), var_attributes), rt.new_string('>')), var_line_item_display_data.array_get('inner_html')), rt.new_string('</tr>'))]))
		}
	}
	var_data.array_set('formatted_line_items', var_formatted_line_items.dup())
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_css := rt.include_file(@DIR + '/Templates/order-receipt-css.php', '1')
	var_css = rt.call_function('ob_get_contents', []rt.PhpVal{})
	rt.call_function('ob_end_clean', []rt.PhpVal{})
	var_data.array_set('css', rt.call_function('apply_filters', [rt.new_string('woocommerce_printable_order_receipt_css'), var_css.dup(), var_order_mutated.dup()]))
	mut var_default_template_path := rt.new_string(@DIR + '/Templates/order-receipt.php')
	mut var_template_path := rt.call_function('apply_filters', [rt.new_string('wc_get_template'), var_default_template_path.dup(), rt.new_string('ReceiptRendering/order-receipt.php'), var_data.dup(), var_default_template_path.dup(), var_default_template_path.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_template_path.dup()]))))) {
		var_template_path = var_default_template_path.dup()
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.include_file((var_template_path).to_string(), '1')
	mut var_rendered_template := rt.call_function('ob_get_contents', []rt.PhpVal{})
	rt.call_function('ob_end_clean', []rt.PhpVal{})
	mut var_file_name := rt.call_method(this.transient_files_engine, 'create_transient_file', [var_rendered_template.dup(), var_expiration_date.dup()])
	rt.call_method(var_order_mutated, 'update_meta_data', [Class_Automattic_WooCommerce_Internal_ReceiptRendering_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.receipt_file_name_meta_key(), var_file_name.dup()])
	rt.call_method(var_order_mutated, 'save_meta_data', []rt.PhpVal{})
	return (var_file_name).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine) get_existing_receipt(var_order rt.PhpVal) string {
	mut var_order_mutated := var_order
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated, 'WC_Abstract_Order')))))) {
		var_order_mutated = rt.call_function('wc_get_order', [var_order_mutated.dup()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_order_mutated)) {
			return (rt.new_null()).str()
		}
	}
	mut var_existing_receipt_filename := rt.call_method(var_order_mutated, 'get_meta', [Class_Automattic_WooCommerce_Internal_ReceiptRendering_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.receipt_file_name_meta_key(), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_string(''), var_existing_receipt_filename)) {
		return (rt.new_null()).str()
	}
	mut var_file_path := rt.call_method(this.transient_files_engine, 'get_transient_file_path', [var_existing_receipt_filename.dup()])
	if rt.is_true(rt.new_bool(var_file_path.dup().is_null())) {
		return (rt.new_null()).str()
	}
	return (if rt.is_true(rt.call_method(this.transient_files_engine, 'file_has_expired', [var_file_path.dup()])) { rt.new_null() } else { var_existing_receipt_filename }).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine) get_order_data(mut var_order Class_WC_Abstract_Order) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_store_name := rt.call_function('get_bloginfo', [rt.new_string('name')])
	if rt.is_true(var_store_name) {
		mut var_receipt_title := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Receipt from %s'), rt.new_string('woocommerce')]), var_store_name.dup()])
	} else {
		var_receipt_title = rt.call_function('__', [rt.new_string('Receipt'), rt.new_string('woocommerce')])
	}
	mut var_order_id := rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})
	if rt.is_true(var_order_id) {
		mut var_summary_title := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Summary: Order #%d'), rt.new_string('woocommerce')]), rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})])
	} else {
		var_summary_title = rt.call_function('__', [rt.new_string('Summary'), rt.new_string('woocommerce')])
	}
	mut var_get_price_args := rt.create_array([rt.ArrayItem{ key: 'currency', val: rt.call_method(var_order_mutated, 'get_currency', []rt.PhpVal{}) }])
	mut var_line_items_info := rt.new_array()
	mut var_line_items := rt.call_method(var_order_mutated, 'get_items', [Class_Automattic_WooCommerce_Enums_OrderItemType.line_item()])
	{
		mut iter_1 := var_line_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_line_item := item_1.val
			mut var_line_item_product := rt.call_method(var_line_item, 'get_product', []rt.PhpVal{})
			if rt.is_true(rt.identical(rt.new_bool(false), var_line_item_product)) {
				mut var_line_item_title := rt.call_method(var_line_item, 'get_name', []rt.PhpVal{})
			} else {
				var_line_item_title = if rt.is_true(rt.new_bool(rt.instance_of(var_line_item_product, 'Automattic_WooCommerce_Internal_ReceiptRendering_WC_Product_Variation'))) { (rt.call_method(rt.call_function('wc_get_product', [rt.call_method(var_line_item_product, 'get_parent_id', []rt.PhpVal{})]), 'get_name', []rt.PhpVal{})).str() + '. ' + (rt.call_method(var_line_item_product, 'get_attribute_summary', []rt.PhpVal{})).str() } else { rt.call_method(var_line_item_product, 'get_name', []rt.PhpVal{}) }
			}
			var_line_items_info.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'product' }, rt.ArrayItem{ key: 'item', val: var_line_item }, rt.ArrayItem{ key: 'title', val: rt.call_function('wp_kses', [var_line_item_title.dup(), rt.new_array()]) }, rt.ArrayItem{ key: 'quantity', val: rt.call_method(var_line_item, 'get_quantity', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'amount', val: rt.call_function('wc_price', [rt.call_method(var_line_item, 'get_subtotal', []rt.PhpVal{}), var_get_price_args.dup()]) }]))
		}
	}
	var_line_items_info.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'subtotal' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Subtotal'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'amount', val: rt.call_function('wc_price', [rt.call_method(var_order_mutated, 'get_subtotal', []rt.PhpVal{}), var_get_price_args.dup()]) }]))
	mut var_coupon_names := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_ArrayUtil{}; return temp.select(arg_0, arg_1, arg_2) }(rt.call_method(var_order_mutated, 'get_coupons', []rt.PhpVal{}), rt.new_string('get_name'), Class_Automattic_WooCommerce_Utilities_ArrayUtil.select_by_object_method())
	if !(!rt.is_true(var_coupon_names)) {
		var_line_items_info.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'discount' }, rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Discount (%s)'), rt.new_string('woocommerce')]), rt.call_function('join', [rt.new_string(', '), var_coupon_names.dup()])]) }, rt.ArrayItem{ key: 'amount', val: rt.call_function('wc_price', [// unsupported expression: Expr_UnaryMinus, var_get_price_args.dup()]) }]))
	}
	{
		mut iter_1 := rt.call_method(var_order_mutated, 'get_fees', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_fee := item_1.val
			mut var_name := rt.call_method(var_fee, 'get_name', []rt.PhpVal{})
			var_line_items_info.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Enums_OrderItemType.fee() }, rt.ArrayItem{ key: 'title', val: if rt.is_true(rt.identical(rt.new_string(''), var_name)) { rt.call_function('__', [rt.new_string('Fee'), rt.new_string('woocommerce')]) } else { var_name } }, rt.ArrayItem{ key: 'amount', val: rt.call_function('wc_price', [rt.call_method(var_fee, 'get_total', []rt.PhpVal{}), var_get_price_args.dup()]) }]))
		}
	}
	mut var_shipping_total := // unsupported expression: Expr_Cast_Double
	if rt.is_true(var_shipping_total) {
		var_line_items_info.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'shipping_total' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Shipping'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'amount', val: rt.call_function('wc_price', [rt.call_method(var_order_mutated, 'get_shipping_total', []rt.PhpVal{}), var_get_price_args.dup()]) }]))
	}
	mut var_total_taxes := rt.new_int(rt.new_int(0))
	{
		mut iter_1 := rt.call_method(var_order_mutated, 'get_taxes', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax := item_1.val
			// unsupported expression: Expr_AssignOp_Plus
		}
	}
	if rt.is_true(var_total_taxes) {
		var_line_items_info.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'taxes_total' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Taxes'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'amount', val: rt.call_function('wc_price', [var_total_taxes.dup(), var_get_price_args.dup()]) }]))
	}
	mut var_is_order_failed := rt.call_method(var_order_mutated, 'has_status', [rt.new_string('failed')])
	var_line_items_info.array_push(rt.create_array([rt.ArrayItem{ key: 'type', val: 'amount_paid' }, rt.ArrayItem{ key: 'title', val: if rt.is_true(var_is_order_failed) { rt.call_function('__', [rt.new_string('Amount'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [rt.new_string('Amount Paid'), rt.new_string('woocommerce')]) } }, rt.ArrayItem{ key: 'amount', val: rt.call_function('wc_price', [rt.call_method(var_order_mutated, 'get_total', []rt.PhpVal{}), var_get_price_args.dup()]) }]))
	mut var_payment_info := this.get_woo_pay_data(mut var_order_mutated)
	return rt.create_array([rt.ArrayItem{ key: 'order', val: var_order_mutated }, rt.ArrayItem{ key: 'constants', val: rt.create_array([rt.ArrayItem{ key: 'font_size', val: Class_Automattic_WooCommerce_Internal_ReceiptRendering_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.font_size() }, rt.ArrayItem{ key: 'margin', val: Class_Automattic_WooCommerce_Internal_ReceiptRendering_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.margin() }, rt.ArrayItem{ key: 'title_font_size', val: Class_Automattic_WooCommerce_Internal_ReceiptRendering_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.title_font_size() }, rt.ArrayItem{ key: 'footer_font_size', val: Class_Automattic_WooCommerce_Internal_ReceiptRendering_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.footer_font_size() }, rt.ArrayItem{ key: 'line_height', val: Class_Automattic_WooCommerce_Internal_ReceiptRendering_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.line_height() }, rt.ArrayItem{ key: 'icon_height', val: Class_Automattic_WooCommerce_Internal_ReceiptRendering_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.icon_height() }, rt.ArrayItem{ key: 'icon_width', val: Class_Automattic_WooCommerce_Internal_ReceiptRendering_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine.icon_width() }]) }, rt.ArrayItem{ key: 'texts', val: rt.create_array([rt.ArrayItem{ key: 'receipt_title', val: var_receipt_title }, rt.ArrayItem{ key: 'amount_paid_section_title', val: if rt.is_true(var_is_order_failed) { rt.call_function('__', [rt.new_string('Order Total'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [rt.new_string('Amount Paid'), rt.new_string('woocommerce')]) } }, rt.ArrayItem{ key: 'date_paid_section_title', val: if rt.is_true(var_is_order_failed) { rt.call_function('__', [rt.new_string('Order Date'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [rt.new_string('Date Paid'), rt.new_string('woocommerce')]) } }, rt.ArrayItem{ key: 'payment_method_section_title', val: rt.call_function('__', [rt.new_string('Payment method'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'payment_status_section_title', val: rt.call_function('__', [rt.new_string('Payment status'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'payment_status', val: if rt.is_true(var_is_order_failed) { rt.call_function('__', [rt.new_string('Failed'), rt.new_string('woocommerce')]) } else { rt.call_function('__', [rt.new_string('Success'), rt.new_string('woocommerce')]) } }, rt.ArrayItem{ key: 'summary_section_title', val: var_summary_title }, rt.ArrayItem{ key: 'order_notes_section_title', val: rt.call_function('__', [rt.new_string('Notes'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'app_name', val: rt.call_function('__', [rt.new_string('Application Name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'aid', val: rt.call_function('__', [rt.new_string('AID'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'account_type', val: rt.call_function('__', [rt.new_string('Account Type'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'formatted_amount', val: rt.call_function('wc_price', [rt.call_method(var_order_mutated, 'get_total', []rt.PhpVal{}), var_get_price_args.dup()]) }, rt.ArrayItem{ key: 'formatted_date', val: rt.call_function('wc_format_datetime', [if !(rt.call_method(var_order_mutated, 'get_date_paid', []rt.PhpVal{})).is_null() { rt.call_method(var_order_mutated, 'get_date_paid', []rt.PhpVal{}) } else { rt.call_method(var_order_mutated, 'get_date_created', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'line_items', val: var_line_items_info }, rt.ArrayItem{ key: 'payment_method', val: rt.call_method(var_order_mutated, 'get_payment_method_title', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'show_payment_method_title', val: !rt.is_true(var_payment_info.array_get('card_last4')) && !rt.is_true(var_payment_info.array_get('brand')) }, rt.ArrayItem{ key: 'notes', val: rt.call_function('array_map', [rt.new_string('get_comment_text'), rt.call_method(var_order_mutated, 'get_customer_order_notes', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'payment_info', val: var_payment_info }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine) get_woo_pay_data(mut var_order Class_WC_Abstract_Order) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_card_info := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo{}; return temp.get_card_info(arg_0) }(rt.new_object('WC_Abstract_Order', []string{}, var_order_mutated))
	if !rt.is_true(var_card_info) {
		return rt.new_null()
	}
	var_card_info.array_set('card_icon', var_card_info.array_get('icon'))
	var_card_info.array_set('card_last4', var_card_info.array_get('last4'))
	return var_card_info.dup()
}

struct Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_receiptrendering_receiptrenderingengine() &Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine {
	mut obj := &Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine{
		PhpObjectBase: rt.PhpObjectBase{}
		transient_files_engine: rt.new_null()
		legacy_proxy: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_utilities_arrayutil() &Class_Automattic_WooCommerce_Utilities_ArrayUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ArrayUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_orders_paymentinfo() &Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_TransientFiles_TransientFilesEngine](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Proxies_LegacyProxy](if args.len > 1 { args[1] } else { rt.new_null() })
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'generate_receipt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.generate_receipt(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_existing_receipt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_existing_receipt(dispatch_arg_0))
		}
		'get_order_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_order_data(mut dispatch_arg_0)
		}
		'get_woo_pay_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Abstract_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_woo_pay_data(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'transient_files_engine' { return this.transient_files_engine }
		'legacy_proxy' { return this.legacy_proxy }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ReceiptRendering_ReceiptRenderingEngine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'transient_files_engine' { this.transient_files_engine = val; return true }
		'legacy_proxy' { this.legacy_proxy = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PaymentInfo) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_receiptrendering_receiptrenderingengine_php() {
}
