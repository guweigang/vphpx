import rt
import crypto.sha1

struct Class_WC_Order_Item_Product {
	rt.PhpObjectBase
pub mut:
		legacy_values rt.PhpVal = rt.new_null()
		legacy_cart_item_key rt.PhpVal = rt.new_null()
		extra_data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Order_Item_Product) set_quantity(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('quantity'), rt.call_function('wc_stock_amount', [var_value_mutated.dup()]))
}

fn (mut this Class_WC_Order_Item_Product) set_tax_class(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(rt.is_true(var_value_mutated) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value_mutated.dup(), fn () rt.PhpVal { mut temp := Class_WC_Tax{}; return temp.get_tax_class_slugs() }(), rt.new_bool(true)]))))))) {
		this.error(rt.new_string('order_item_product_invalid_tax_class'), rt.call_function('__', [rt.new_string('Invalid tax class'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('tax_class'), var_value_mutated.dup())
}

fn (mut this Class_WC_Order_Item_Product) set_product_id(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_value_mutated, rt.new_int(0))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.error(rt.new_string('order_item_product_invalid_product_id'), rt.call_function('__', [rt.new_string('Invalid product ID'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('product_id'), rt.call_function('absint', [var_value_mutated.dup()]))
}

fn (mut this Class_WC_Order_Item_Product) set_variation_id(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_value_mutated, rt.new_int(0))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		this.error(rt.new_string('order_item_product_invalid_variation_id'), rt.call_function('__', [rt.new_string('Invalid variation ID'), rt.new_string('woocommerce')]), rt.new_int(400), rt.create_array([rt.ArrayItem{ key: 'variation_id', val: var_value_mutated }]))
	}
	this.set_prop(rt.new_string('variation_id'), rt.call_function('absint', [var_value_mutated.dup()]))
}

fn (mut this Class_WC_Order_Item_Product) set_subtotal(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	var_value_mutated = rt.call_function('wc_format_decimal', [var_value_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_long() || var_value_mutated.dup().is_double()))))) {
		var_value_mutated = rt.new_int(rt.new_int(0))
	}
	this.set_prop(rt.new_string('subtotal'), var_value_mutated.dup())
}

fn (mut this Class_WC_Order_Item_Product) set_total(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	var_value_mutated = rt.call_function('wc_format_decimal', [var_value_mutated.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_long() || var_value_mutated.dup().is_double()))))) {
		var_value_mutated = rt.new_int(rt.new_int(0))
	}
	this.set_prop(rt.new_string('total'), var_value_mutated.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), this.get_subtotal(''))) || rt.is_true(rt.less(this.get_subtotal(''), this.get_total(''))))) {
		this.set_subtotal(var_value_mutated.dup())
	}
}

fn (mut this Class_WC_Order_Item_Product) set_subtotal_tax(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('subtotal_tax'), rt.call_function('wc_format_decimal', [var_value_mutated.dup()]))
}

fn (mut this Class_WC_Order_Item_Product) set_total_tax(var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.set_prop(rt.new_string('total_tax'), rt.call_function('wc_format_decimal', [var_value_mutated.dup()]))
}

fn (mut this Class_WC_Order_Item_Product) set_taxes(var_raw_tax_data rt.PhpVal)  {
	mut var_raw_tax_data_mutated := var_raw_tax_data
	var_raw_tax_data_mutated = rt.call_function('maybe_unserialize', [var_raw_tax_data_mutated.dup()])
	mut var_tax_data := { 'total': map[string]rt.PhpVal{}, 'subtotal': map[string]rt.PhpVal{} }
	if !(!rt.is_true(var_raw_tax_data_mutated.array_get('total'))) && !(!rt.is_true(var_raw_tax_data_mutated.array_get('subtotal'))) {
		mut var_subtotal := var_raw_tax_data_mutated.array_get('subtotal')
		mut var_total := var_raw_tax_data_mutated.array_get('total')
		mut var_has_legacy_data := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_subtotal.dup().is_array()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_total.dup().is_array())))))))
		if rt.is_true(var_has_legacy_data) {
			mut var_order := this.get_order()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_subtotal.dup().is_array()))))) {
				var_subtotal = this.convert_legacy_tax_value_to_array(var_subtotal.dup(), var_order.dup())
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_total.dup().is_array()))))) {
				var_total = this.convert_legacy_tax_value_to_array(var_total.dup(), var_order.dup())
			}
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Order item #%d contains legacy tax data format. Tax rate ID information is unavailable.'), rt.new_string('woocommerce')]), this.get_id()]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'woocommerce-order-item-product' }, rt.ArrayItem{ key: 'order_item_id', val: this.get_id() }, rt.ArrayItem{ key: 'order_id', val: if rt.is_true(var_order) { rt.call_method(var_order, 'get_id', []rt.PhpVal{}) } else { rt.new_int(0) } }])])
		}
		var_tax_data['subtotal'] = rt.call_function('array_map', [rt.new_string('wc_format_decimal'), var_subtotal.dup()])
		var_tax_data['total'] = rt.call_function('array_map', [rt.new_string('wc_format_decimal'), var_total.dup()])
		if rt.is_true(rt.less(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.array_sum(arg_0) }(var_tax_data.array_get('subtotal')), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.array_sum(arg_0) }(var_tax_data.array_get('total')))) {
			var_tax_data['subtotal'] = var_tax_data.array_get('total')
		}
	}
	this.set_prop(rt.new_string('taxes'), var_tax_data.dup())
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('woocommerce_tax_round_at_subtotal')]))) {
		this.set_total_tax(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.array_sum(arg_0) }(var_tax_data.array_get('total')))
		this.set_subtotal_tax(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.array_sum(arg_0) }(var_tax_data.array_get('subtotal')))
	} else {
		this.set_total_tax(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.array_sum(arg_0) }(rt.call_function('array_map', [rt.new_string('wc_round_tax_total'), var_tax_data.array_get('total')])))
		this.set_subtotal_tax(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Utilities_NumberUtil{}; return temp.array_sum(arg_0) }(rt.call_function('array_map', [rt.new_string('wc_round_tax_total'), var_tax_data.array_get('subtotal')])))
	}
}

fn (mut this Class_WC_Order_Item_Product) set_variation(var_data rt.PhpVal)  {
	if rt.is_true(rt.new_bool(var_data.dup().is_array())) {
		{
			mut iter_1 := var_data.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				this.add_meta_data(rt.call_function('str_replace', [rt.new_string('attribute_'), rt.new_string(''), var_key.dup()]), var_value.dup(), rt.new_bool(true))
			}
		}
	}
}

fn (mut this Class_WC_Order_Item_Product) set_product(var_product rt.PhpVal)  {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_product_mutated.dup(), rt.new_string('WC_Product')]))))) {
		this.error(rt.new_string('order_item_product_invalid_product'), rt.call_function('__', [rt.new_string('Invalid product'), rt.new_string('woocommerce')]))
	}
	if rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) {
		this.set_product_id(rt.call_method(var_product_mutated, 'get_parent_id', []rt.PhpVal{}))
		this.set_variation_id(rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}))
		this.set_variation(if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: var_product_mutated }, rt.ArrayItem{ key: none, val: 'get_variation_attributes' }])])) { rt.call_method(var_product_mutated, 'get_variation_attributes', []rt.PhpVal{}) } else { map[string]rt.PhpVal{} })
	} else {
		this.set_product_id(rt.call_method(var_product_mutated, 'get_id', []rt.PhpVal{}))
	}
	this.set_name(rt.call_method(var_product_mutated, 'get_name', []rt.PhpVal{}))
	this.set_tax_class(rt.call_method(var_product_mutated, 'get_tax_class', []rt.PhpVal{}))
}

fn (mut this Class_WC_Order_Item_Product) set_backorder_meta()  {
	mut var_product := this.get_product()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_product) && rt.is_true(rt.call_method(var_product, 'backorders_require_notification', []rt.PhpVal{})))) && rt.is_true(rt.call_method(var_product, 'is_on_backorder', [this.get_quantity('')])))) {
		this.add_meta_data(rt.call_function('apply_filters', [rt.new_string('woocommerce_backordered_item_meta_name'), rt.call_function('__', [rt.new_string('Backordered'), rt.new_string('woocommerce')]), rt.new_object('WC_Order_Item_Product', ['WC_Order_Item'], &this)]), rt.sub(this.get_quantity(''), rt.call_function('max', [rt.new_int(0), rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{})])), rt.new_bool(true))
	}
}

fn (mut this Class_WC_Order_Item_Product) get_type() string {
	return 'line_item'
}

fn (mut this Class_WC_Order_Item_Product) get_product_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('product_id'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Product) get_variation_id(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('variation_id'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Product) get_quantity(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('quantity'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Product) get_tax_class(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('tax_class'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Product) get_subtotal(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('subtotal'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Product) get_subtotal_tax(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('subtotal_tax'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Product) get_total(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('total'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Product) get_total_tax(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('total_tax'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Product) get_taxes(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('taxes'), rt.new_string(context))
}

fn (mut this Class_WC_Order_Item_Product) get_product() rt.PhpVal {
	if rt.is_true(this.get_variation_id('')) {
		mut var_product := rt.call_function('wc_get_product', [this.get_variation_id('')])
	} else {
		var_product = rt.call_function('wc_get_product', [this.get_product_id('')])
	}
	if rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_get_product_from_item')])) {
		var_product = rt.call_function('apply_filters', [rt.new_string('woocommerce_get_product_from_item'), var_product.dup(), rt.new_object('WC_Order_Item_Product', ['WC_Order_Item'], &this), this.get_order()])
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_order_item_product'), var_product.dup(), rt.new_object('WC_Order_Item_Product', ['WC_Order_Item'], &this)])
}

fn (mut this Class_WC_Order_Item_Product) get_item_download_url(var_download_id rt.PhpVal) rt.PhpVal {
	mut var_download_id_mutated := var_download_id
	mut var_order := this.get_order()
	return if rt.is_true(var_order) { rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'download_file', val: if rt.is_true(this.get_variation_id('')) { this.get_variation_id('') } else { this.get_product_id('') } }, rt.ArrayItem{ key: 'order', val: rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'email', val: rt.call_function('rawurlencode', [rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'key', val: var_download_id_mutated }]), rt.call_function('trailingslashit', [rt.call_function('home_url', []rt.PhpVal{})])]) } else { rt.new_string('') }
}

fn (mut this Class_WC_Order_Item_Product) get_item_downloads() rt.PhpVal {
	mut var_files := map[string]rt.PhpVal{}
	mut var_product := this.get_product()
	mut var_order := this.get_order()
	mut var_product_id := if rt.is_true(this.get_variation_id('')) { this.get_variation_id('') } else { this.get_product_id('') }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_order)))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{}))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'is_download_permitted', []rt.PhpVal{}))))))) {
		return map[string]rt.PhpVal{}
	}
	mut var_email_hash := if rt.is_true(rt.call_function('function_exists', [rt.new_string('hash')])) { rt.call_function('hash', [rt.new_string('sha256'), rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{})]) } else { rt.new_string(sha1.hexhash(rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{}).to_string())) }
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('customer-download'))
	mut var_customer_downloads := rt.call_method(var_data_store, 'get_downloads', [rt.create_array([rt.ArrayItem{ key: 'user_email', val: rt.call_method(var_order, 'get_billing_email', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'order_id', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'product_id', val: var_product_id }])])
	{
		mut iter_1 := var_customer_downloads.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_customer_download := item_1.val
			mut var_download_id := rt.call_method(var_customer_download, 'get_download_id', []rt.PhpVal{})
			if rt.is_true(rt.call_method(var_product, 'has_file', [var_download_id.dup()])) {
				mut var_file := rt.call_method(var_product, 'get_file', [var_download_id.dup()])
				var_files.array_set(var_download_id, rt.call_method(var_file, 'get_data', []rt.PhpVal{}))
				var_files.array_get_mut(var_download_id).array_set('downloads_remaining', rt.call_method(var_customer_download, 'get_downloads_remaining', []rt.PhpVal{}))
				var_files.array_get_mut(var_download_id).array_set('access_expires', rt.call_method(var_customer_download, 'get_access_expires', []rt.PhpVal{}))
				var_files.array_get_mut(var_download_id).array_set('download_url', rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'download_file', val: var_product_id }, rt.ArrayItem{ key: 'order', val: rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'uid', val: var_email_hash }, rt.ArrayItem{ key: 'key', val: var_download_id }]), rt.call_function('trailingslashit', [rt.call_function('home_url', []rt.PhpVal{})])]))
			}
		}
	}
	var_files = rt.call_function('apply_filters', [rt.new_string('woocommerce_get_item_downloads'), var_files.dup(), rt.new_object('WC_Order_Item_Product', ['WC_Order_Item'], &this), var_order.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_files.dup().is_array()))))) {
		return map[string]rt.PhpVal{}
	}
	return var_files.dup()
}

fn (mut this Class_WC_Order_Item_Product) get_tax_status() rt.PhpVal {
	mut var_product := this.get_product()
	return if rt.is_true(var_product) { rt.call_method(var_product, 'get_tax_status', []rt.PhpVal{}) } else { Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable() }
}

fn (mut this Class_WC_Order_Item_Product) get_formatted_meta_data(hideprefix string, include_all bool) rt.PhpVal {
	mut var_formatted_meta := this.Class_WC_Order_Item.get_formatted_meta_data(rt.new_string(hideprefix), rt.new_bool(include_all))
	mut var_order := this.get_order()
	if rt.is_true(rt.new_bool(rt.is_true(var_order) && rt.is_true(rt.call_method(var_order, 'has_status', [Class_Automattic_WooCommerce_Enums_OrderStatus.completed()])))) {
		mut var_backorder_meta_key := rt.call_function('apply_filters', [rt.new_string('woocommerce_backordered_item_meta_name'), rt.call_function('__', [rt.new_string('Backordered'), rt.new_string('woocommerce')]), rt.new_object('WC_Order_Item_Product', ['WC_Order_Item'], &this)])
		{
			mut iter_1 := var_formatted_meta.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_meta := item_1.val
				mut var_meta_id := item_1.key
				if rt.is_true(rt.new_bool(!(rt.get_property(var_meta, 'key')).is_null() && rt.is_true(rt.identical(rt.get_property(var_meta, 'key'), var_backorder_meta_key)))) {
					var_formatted_meta.array_unset(var_meta_id)
				}
			}
		}
	}
	return var_formatted_meta.dup()
}

fn (mut this Class_WC_Order_Item_Product) offsetget(var_offset rt.PhpVal) rt.PhpVal {
	mut var_offset_mutated := var_offset
	if rt.is_true(rt.identical(rt.new_string('line_subtotal'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string(rt.new_string('subtotal'))
	} else if rt.is_true(rt.identical(rt.new_string('line_subtotal_tax'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string(rt.new_string('subtotal_tax'))
	} else if rt.is_true(rt.identical(rt.new_string('line_total'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string(rt.new_string('total'))
	} else if rt.is_true(rt.identical(rt.new_string('line_tax'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string(rt.new_string('total_tax'))
	} else if rt.is_true(rt.identical(rt.new_string('line_tax_data'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string(rt.new_string('taxes'))
	} else if rt.is_true(rt.identical(rt.new_string('qty'), var_offset_mutated)) {
		var_offset_mutated = rt.new_string()
	}
	return this.Class_WC_Order_Item.offsetget(.dup())
}

fn (mut this Class_WC_Order_Item_Product) offsetset(var_offset rt.PhpVal, var_value rt.PhpVal)  {
	mut var_offset_mutated := var_offset
	mut var_value_mutated := var_value
	
}

fn (mut this Class_WC_Order_Item_Product) offsetexists(var_offset rt.PhpVal) bool {
	mut var_offset_mutated := var_offset
}

fn (mut this Class_WC_Order_Item_Product) has_cogs() bool {
}

fn (mut this Class_WC_Order_Item_Product) calculate_cogs_value_core() f64 {
}

struct Class_WC_Order_Item {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_NumberUtil {
	rt.PhpObjectBase
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_order_item_product() &Class_WC_Order_Item_Product {
	mut obj := &Class_WC_Order_Item_Product{
		PhpObjectBase: rt.PhpObjectBase{}
		legacy_values: rt.new_null()
		legacy_cart_item_key: rt.new_null()
		extra_data: rt.new_array()
	}
	return obj
}

fn create_wc_order_item() &Class_WC_Order_Item {
	mut obj := &Class_WC_Order_Item{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax() &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
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

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order_Item_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'set_quantity' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_quantity(dispatch_arg_0)
			return rt.new_null()
		}
		'set_tax_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_tax_class(dispatch_arg_0)
			return rt.new_null()
		}
		'set_product_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_product_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_variation_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_variation_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_subtotal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_subtotal(dispatch_arg_0)
			return rt.new_null()
		}
		'set_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_total(dispatch_arg_0)
			return rt.new_null()
		}
		'set_subtotal_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_subtotal_tax(dispatch_arg_0)
			return rt.new_null()
		}
		'set_total_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_total_tax(dispatch_arg_0)
			return rt.new_null()
		}
		'set_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_taxes(dispatch_arg_0)
			return rt.new_null()
		}
		'set_variation' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_variation(dispatch_arg_0)
			return rt.new_null()
		}
		'set_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_product(dispatch_arg_0)
			return rt.new_null()
		}
		'set_backorder_meta' {
			this.set_backorder_meta()
			return rt.new_null()
		}
		'get_type' {
			return rt.new_string(this.get_type())
		}
		'get_product_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_product_id(dispatch_arg_0)
		}
		'get_variation_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_variation_id(dispatch_arg_0)
		}
		'get_quantity' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_quantity(dispatch_arg_0)
		}
		'get_tax_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_tax_class(dispatch_arg_0)
		}
		'get_subtotal' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_subtotal(dispatch_arg_0)
		}
		'get_subtotal_tax' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_subtotal_tax(dispatch_arg_0)
		}
		'get_total' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_total(dispatch_arg_0)
		}
		'get_total_tax' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_total_tax(dispatch_arg_0)
		}
		'get_taxes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_taxes(dispatch_arg_0)
		}
		'get_product' {
			return this.get_product()
		}
		'get_item_download_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_download_url(dispatch_arg_0)
		}
		'get_item_downloads' {
			return this.get_item_downloads()
		}
		'get_tax_status' {
			return this.get_tax_status()
		}
		'get_formatted_meta_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_formatted_meta_data(dispatch_arg_0, dispatch_arg_1)
		}
		'offsetGet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.offsetget(dispatch_arg_0)
		}
		'offsetSet' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.offsetset(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'offsetExists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.offsetexists(dispatch_arg_0))
		}
		'has_cogs' {
			return rt.new_bool(this.has_cogs())
		}
		'calculate_cogs_value_core' {
			return rt.new_float(this.calculate_cogs_value_core())
		}
		else { return none }
	}
}

fn (this &Class_WC_Order_Item_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'legacy_values' { return this.legacy_values }
		'legacy_cart_item_key' { return this.legacy_cart_item_key }
		'extra_data' { return this.extra_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Order_Item_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'legacy_values' { this.legacy_values = val; return true }
		'legacy_cart_item_key' { this.legacy_cart_item_key = val; return true }
		'extra_data' { this.extra_data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Order_Item) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_order_item_product_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
