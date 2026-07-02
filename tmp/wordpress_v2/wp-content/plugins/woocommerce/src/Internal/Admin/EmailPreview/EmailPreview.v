import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.default_email_type() string {
	return 'WC_Email_Customer_Processing_Order'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.default_email_id() string {
	return 'customer_processing_order'
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.user_object_emails() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Email_Customer_New_Account' }, rt.ArrayItem{ key: none, val: 'WC_Email_Customer_Reset_Password' }])
}
pub fn Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.transient_preview_email_improvements() string {
	return 'woocommerce_preview_email_improvements'
}
struct Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview {
	rt.PhpObjectBase
pub mut:
		email_type rt.PhpVal = rt.new_null()
		email rt.PhpVal = rt.new_null()
		locale_switched bool
}

fn init_static_automattic_woocommerce_internal_admin_emailpreview_emailpreview() {
		rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'email_style_setting_ids', rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_email_background_color' }, rt.ArrayItem{ key: none, val: 'woocommerce_email_base_color' }, rt.ArrayItem{ key: none, val: 'woocommerce_email_body_background_color' }, rt.ArrayItem{ key: none, val: 'woocommerce_email_font_family' }, rt.ArrayItem{ key: none, val: 'woocommerce_email_footer_text' }, rt.ArrayItem{ key: none, val: 'woocommerce_email_footer_text_color' }, rt.ArrayItem{ key: none, val: 'woocommerce_email_header_alignment' }, rt.ArrayItem{ key: none, val: 'woocommerce_email_header_image' }, rt.ArrayItem{ key: none, val: 'woocommerce_email_header_image_width' }, rt.ArrayItem{ key: none, val: 'woocommerce_email_text_color' }]))
		rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'email_content_setting_ids', rt.new_array())
		rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'email_setting_ids_initialized', rt.new_bool(false))
		rt.init_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'instance', rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'instance'))) {
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'instance', rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_static', []string{}, create_automattic_woocommerce_internal_admin_emailpreview_static()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'instance')
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.get_all_email_setting_ids() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'email_setting_ids_initialized'))))) {
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'email_setting_ids_initialized', rt.new_bool(true))
		mut var_emails := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{}), 'get_emails', []rt.PhpVal{})
		mut iter_1 := var_emails.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_email := item_1.val
			rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'email_content_setting_ids', rt.call_function('array_merge', [rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'email_content_setting_ids'), Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.get_email_content_setting_ids(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_?string](rt.get_property(var_email, 'id')))]))
		}
		rt.set_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'email_content_setting_ids', rt.call_function('array_unique', [rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'email_content_setting_ids')]))
	}
	return rt.call_function('array_merge', [rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'email_style_setting_ids'), rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'email_content_setting_ids')])
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.get_email_style_setting_ids() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_email_preview_email_style_setting_ids'), rt.get_static_prop('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', 'email_style_setting_ids')])
}

fn Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.get_email_content_setting_ids(mut var_email_id Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_?string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_email_id)))) {
		return rt.new_array()
	}
	mut var_setting_ids := rt.create_array([rt.ArrayItem{ key: none, val: "woocommerce_${var_email_id.to_string()}_subject" }, rt.ArrayItem{ key: none, val: "woocommerce_${var_email_id.to_string()}_heading" }, rt.ArrayItem{ key: none, val: "woocommerce_${var_email_id.to_string()}_additional_content" }, rt.ArrayItem{ key: none, val: "woocommerce_${var_email_id.to_string()}_email_type" }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_email_preview_email_content_setting_ids'), var_setting_ids.clone(), var_email_id])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) set_email_type(email_type string) {
	this.switch_to_site_locale()
	mut var_wc_emails := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{}), 'get_emails', []rt.PhpVal{})
	mut var_emails := rt.call_function('array_combine', [rt.call_function('array_map', [rt.new_string('get_class'), var_wc_emails.clone()]), var_wc_emails.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(email_type), rt.func_array_keys(var_emails.clone()), rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_InvalidArgumentException', []string{}, create_automattic_woocommerce_internal_admin_emailpreview_invalidargumentexception(rt.new_string('Invalid email type'))))
	}
	this.email_type = rt.new_string(email_type)
	this.email = var_emails.array_get(rt.new_string(email_type))
	mut var_object := rt.new_null()
	if rt.is_true(rt.call_function('in_array', [rt.new_string(email_type), Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.user_object_emails(), rt.new_bool(true)])) {
		var_object = create_wp_user(rt.new_int(0))
		rt.set_property(var_object, 'user_email', rt.new_string('user_preview@example.com'))
		rt.set_property(var_object, 'user_login', rt.new_string('user_preview'))
		rt.set_property(var_object, 'first_name', rt.new_string('John'))
		rt.set_property(var_object, 'last_name', rt.new_string('Doe'))
		rt.set_property(this.email, 'user_email', rt.get_property(var_object, 'user_email'))
		rt.set_property(this.email, 'user_login', rt.get_property(var_object, 'user_login'))
		if rt.is_true(rt.call_function('property_exists', [this.email, rt.new_string('reset_key')])) {
			rt.set_property(this.email, 'reset_key', rt.new_string('reset_key'))
		}
		if rt.is_true(rt.call_function('property_exists', [this.email, rt.new_string('set_password_url')])) {
			rt.set_property(this.email, 'set_password_url', rt.new_string('https://example.com/set-password'))
		}
		if rt.is_true(rt.call_function('property_exists', [this.email, rt.new_string('user_id')])) {
			rt.set_property(this.email, 'user_id', rt.new_int(0))
		}
		rt.call_method(this.email, 'set_object', [var_object.clone()])
	} else {
		var_object = this.get_dummy_order()
		if rt.is_true(rt.identical(rt.new_string('WC_Email_Customer_Note'), rt.new_string(email_type))) {
			rt.set_property(this.email, 'customer_note', rt.call_function('__', [rt.new_string('This is an order note sent from the Admin to the customer during fulfillment when you add a new Order Note and choose to send it to the customer.\n\nIt can be multiple lines.'), rt.new_string('woocommerce')]))
		}
		if rt.is_true(rt.identical(rt.new_string('WC_Email_Customer_Refunded_Order'), rt.new_string(email_type))) {
			rt.set_property(this.email, 'partial_refund', rt.new_bool(false))
		}
		rt.call_method(this.email, 'set_object', [var_object.clone()])
	}
	rt.set_property(this.email, 'placeholders', rt.call_function('array_merge', [rt.get_property(this.email, 'placeholders'), this.get_placeholders(var_object.clone())]))
	this.email = rt.call_function('apply_filters', [rt.new_string('woocommerce_prepare_email_for_preview'), this.email])
	this.restore_locale()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) get_email() rt.PhpVal {
	return this.email
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) render() rt.PhpVal {
	return this.render_preview_email()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) ensure_links_open_in_new_tab(content string) rt.PhpVal {
	mut content_mutated := content
	if content_mutated == '' || rt.is_true(rt.identical(rt.call_function('strpos', [rt.new_string(content_mutated).clone(), rt.new_string('<a')]), rt.new_bool(false))) {
		return rt.new_string(content_mutated)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('DOMDocument')]))))) {
		return rt.new_string(content_mutated)
	}
	mut var_previous_use_internal_errors := rt.call_function('libxml_use_internal_errors', [rt.new_bool(true)])
	mut var_dom := create_automattic_woocommerce_internal_admin_emailpreview_domdocument()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_html_with_encoding := rt.new_string('<?xml encoding="UTF-8">' + content_mutated)
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_dom.loadhtml(var_html_with_encoding.clone(), rt.new_int(rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('LIBXML_HTML_NOIMPLIED'), rt.get_constant('LIBXML_HTML_NODEFDTD')), rt.get_constant('LIBXML_NOWARNING')), rt.get_constant('LIBXML_NOERROR'))))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_links := var_dom.getelementsbytagname(rt.new_string('a'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut iter_2 := var_links.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_link := item_2.val
		rt.call_method(var_link, 'setAttribute', [rt.new_string('target'), rt.new_string('_blank')])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_method(var_link, 'setAttribute', [rt.new_string('rel'), rt.new_string('noopener')])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_result := var_dom.savehtml()
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	var_result = rt.call_function('preg_replace', [rt.new_string('/<\\?xml[^>]*>\\s*/i'), rt.new_string(''), var_result.clone()])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	return var_result.clone()
	unsafe { goto finally_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Admin_EmailPreview_Exception') {
		mut var_e := var_e_1.clone()
		return rt.new_string(content_mutated)
		unsafe { goto finally_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto finally_label_1 }
	}

finally_label_1:
	rt.call_function('libxml_use_internal_errors', [var_previous_use_internal_errors.clone()])
	rt.call_function('libxml_clear_errors', []rt.PhpVal{})
	if rt.has_exception() { return rt.new_null() }

end_label_1:
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) get_subject() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.email)))) {
		return ''
	}
	this.set_up_filters()
	mut var_subject := rt.call_method(this.email, 'get_subject', []rt.PhpVal{})
	this.clean_up_filters()
	return (var_subject).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) get_dummy_product_when_not_set(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
	if rt.is_true(var_product_mutated) {
		return var_product_mutated.clone()
	}
	return this.get_dummy_product()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) render_preview_email() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.email_type)))) {
		this.set_email_type((Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.default_email_type()).str())
	}
	this.set_up_filters()
	if rt.is_true(rt.identical(rt.new_string('plain'), rt.call_method(this.email, 'get_email_type', []rt.PhpVal{}))) {
		mut var_content := rt.new_string('<pre style="word-wrap: break-word; white-space: pre-wrap; text-align: ' + if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { 'right' } else { 'left' } + ';">')
		var_content = rt.concat(var_content, rt.call_method(this.email, 'get_content_plain', []rt.PhpVal{}))
		var_content = rt.concat(var_content, rt.new_string('</pre>'))
	} else {
	var_content = rt.call_method(this.email, 'get_content_html', []rt.PhpVal{})
	}
	mut var_inlined := rt.call_method(this.email, 'style_inline', [var_content.clone()])
	this.clean_up_filters()
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_mail_content'), var_inlined.clone()])
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) get_dummy_order() rt.PhpVal {
	mut var_product := this.get_dummy_product()
	mut var_variation := this.get_dummy_product_variation()
	mut var_downloadable_product := this.get_dummy_downloadable_product()
	mut var_order := create_wc_order()
	rt.call_method(var_order, 'set_id', [rt.new_int(12345)])
	if rt.is_true(var_product) {
		mut var_item := create_wc_order_item_product()
		var_item.set_props(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_method(var_product, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'tax_class', val: rt.call_method(var_product, 'get_tax_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'product_id', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'variation_id', val: 0 }, rt.ArrayItem{ key: 'quantity', val: 2 }, rt.ArrayItem{ key: 'subtotal', val: rt.mul(rt.call_method(var_product, 'get_price', []rt.PhpVal{}), rt.new_int(2)) }, rt.ArrayItem{ key: 'total', val: rt.mul(rt.call_method(var_product, 'get_price', []rt.PhpVal{}), rt.new_int(2)) }]))
		rt.call_method(var_order, 'add_item', [var_item])
	}
	if rt.is_true(var_variation) {
		var_item = create_wc_order_item_product()
		var_item.set_props(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_method(var_variation, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'tax_class', val: rt.call_method(var_variation, 'get_tax_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'product_id', val: rt.call_method(var_variation, 'get_parent_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'variation_id', val: rt.call_method(var_variation, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'variation', val: rt.call_method(var_variation, 'get_attributes', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'quantity', val: 1 }, rt.ArrayItem{ key: 'subtotal', val: rt.call_method(var_variation, 'get_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'total', val: rt.call_method(var_variation, 'get_price', []rt.PhpVal{}) }]))
		rt.call_method(var_order, 'add_item', [var_item])
	}
	if rt.is_true(var_downloadable_product) {
		var_item = create_wc_order_item_product()
		var_item.set_props(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_method(var_downloadable_product, 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'tax_class', val: rt.call_method(var_downloadable_product, 'get_tax_class', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'product_id', val: rt.call_method(var_downloadable_product, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'variation_id', val: 0 }, rt.ArrayItem{ key: 'quantity', val: 1 }, rt.ArrayItem{ key: 'subtotal', val: rt.call_method(var_downloadable_product, 'get_price', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'total', val: rt.call_method(var_downloadable_product, 'get_price', []rt.PhpVal{}) }]))
		rt.call_method(var_order, 'add_item', [var_item])
	}
	rt.call_method(var_order, 'set_date_created', [rt.call_function('time', []rt.PhpVal{})])
	rt.call_method(var_order, 'set_currency', [rt.new_string('USD')])
	rt.call_method(var_order, 'set_discount_total', [rt.new_int(10)])
	rt.call_method(var_order, 'set_shipping_total', [rt.new_int(5)])
	rt.call_method(var_order, 'set_total', [rt.new_int(80)])
	rt.call_method(var_order, 'set_payment_method_title', [rt.call_function('__', [rt.new_string('Direct bank transfer'), rt.new_string('woocommerce')])])
	rt.call_method(var_order, 'set_transaction_id', [rt.new_string('999999999')])
	rt.call_method(var_order, 'set_customer_note', [rt.call_function('__', [rt.new_string('This is a customer note. Customers can add a note to their order on checkout.\n\nIt can be multiple lines. If there\'s no note, this section is hidden.'), rt.new_string('woocommerce')])])
	var_order = this.apply_dummy_order_status(mut rt.cast_object_ptr[Class_WC_Order](var_order))
	mut var_shipping_item := create_wc_order_item_shipping()
	var_shipping_item.set_props(rt.create_array([rt.ArrayItem{ key: 'method_title', val: rt.call_function('__', [rt.new_string('Flat rate'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'method_id', val: 'flat_rate' }, rt.ArrayItem{ key: 'total', val: '5.00' }]))
	rt.call_method(var_order, 'add_item', [var_shipping_item])
	mut var_address := this.get_dummy_address()
	rt.call_method(var_order, 'set_billing_address', [var_address.clone()])
	rt.call_method(var_order, 'set_shipping_address', [var_address.clone()])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_email_preview_dummy_order'), var_order.clone(), this.email_type])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) apply_dummy_order_status(mut var_order Class_WC_Order) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_email_type_status_map := rt.create_array([rt.ArrayItem{ key: 'WC_Email_Customer_Completed_Order', val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }, rt.ArrayItem{ key: 'WC_Email_Customer_Processing_Order', val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing() }, rt.ArrayItem{ key: 'WC_Email_Customer_On_Hold_Order', val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() }, rt.ArrayItem{ key: 'WC_Email_Customer_Failed_Order', val: Class_Automattic_WooCommerce_Enums_OrderStatus.failed() }, rt.ArrayItem{ key: 'WC_Email_Customer_Cancelled_Order', val: Class_Automattic_WooCommerce_Enums_OrderStatus.cancelled() }, rt.ArrayItem{ key: 'WC_Email_Customer_Refunded_Order', val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() }, rt.ArrayItem{ key: 'WC_Email_New_Order', val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing() }, rt.ArrayItem{ key: 'WC_Email_Cancelled_Order', val: Class_Automattic_WooCommerce_Enums_OrderStatus.cancelled() }, rt.ArrayItem{ key: 'WC_Email_Failed_Order', val: Class_Automattic_WooCommerce_Enums_OrderStatus.failed() }])
	mut var_status := if !(var_email_type_status_map.array_get(this.email_type)).is_null() { var_email_type_status_map.array_get(this.email_type) } else { Class_Automattic_WooCommerce_Enums_OrderStatus.processing() }
	rt.call_method(var_order_mutated, 'set_status', [var_status.clone()])
	return rt.new_object('WC_Order', []string{}, var_order_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) get_dummy_product() rt.PhpVal {
	mut var_product := create_wc_product()
	rt.call_method(var_product, 'set_name', [rt.call_function('__', [rt.new_string('Dummy Product'), rt.new_string('woocommerce')])])
	rt.call_method(var_product, 'set_price', [rt.new_int(25)])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_email_preview_dummy_product'), var_product.clone(), this.email_type])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) get_dummy_product_variation() rt.PhpVal {
	mut var_variation := create_wc_product_variation()
	rt.call_method(var_variation, 'set_name', [rt.call_function('__', [rt.new_string('Dummy Product Variation'), rt.new_string('woocommerce')])])
	rt.call_method(var_variation, 'set_price', [rt.new_int(20)])
	rt.call_method(var_variation, 'set_attributes', [rt.create_array([rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Color'), rt.new_string('woocommerce')]), val: rt.call_function('__', [rt.new_string('Red'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Size'), rt.new_string('woocommerce')]), val: rt.call_function('__', [rt.new_string('Small'), rt.new_string('woocommerce')]) }])])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_email_preview_dummy_product_variation'), var_variation.clone(), this.email_type])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) get_dummy_downloadable_product() rt.PhpVal {
	mut var_product := create_wc_product()
	rt.call_method(var_product, 'set_name', [rt.call_function('__', [rt.new_string('Dummy Downloadable Product'), rt.new_string('woocommerce')])])
	rt.call_method(var_product, 'set_price', [rt.new_int(15)])
	rt.call_method(var_product, 'set_virtual', [rt.new_bool(true)])
	rt.call_method(var_product, 'set_downloadable', [rt.new_bool(true)])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_email_preview_dummy_downloadable_product'), var_product.clone(), this.email_type])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) get_dummy_address() rt.PhpVal {
	mut var_address := rt.create_array([rt.ArrayItem{ key: 'first_name', val: 'John' }, rt.ArrayItem{ key: 'last_name', val: 'Doe' }, rt.ArrayItem{ key: 'company', val: 'Company' }, rt.ArrayItem{ key: 'email', val: 'john@company.com' }, rt.ArrayItem{ key: 'phone', val: '555-555-5555' }, rt.ArrayItem{ key: 'address_1', val: '123 Fake Street' }, rt.ArrayItem{ key: 'city', val: 'Faketown' }, rt.ArrayItem{ key: 'postcode', val: '12345' }, rt.ArrayItem{ key: 'country', val: 'US' }, rt.ArrayItem{ key: 'state', val: 'CA' }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_email_preview_dummy_address'), var_address.clone(), this.email_type])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) get_placeholders(var_email_object rt.PhpVal) rt.PhpVal {
	mut var_placeholders := rt.new_array()
	if rt.is_true(rt.call_function('is_a', [var_email_object.clone(), rt.new_string('WC_Order')])) {
		var_placeholders.array_set('{order_date}', rt.call_function('wc_format_datetime', [rt.call_method(var_email_object, 'get_date_created', []rt.PhpVal{})]))
		var_placeholders.array_set('{order_number}', rt.call_method(var_email_object, 'get_order_number', []rt.PhpVal{}))
		var_placeholders.array_set('{order_billing_full_name}', rt.call_method(var_email_object, 'get_formatted_billing_full_name', []rt.PhpVal{}))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_email_preview_placeholders'), var_placeholders.clone(), this.email_type, var_email_object.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) set_up_filters() {
	this.switch_to_site_locale()
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_needs_shipping_address'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enable_shipping_address' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_item_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_dummy_product_when_not_set' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_is_email_preview'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enable_preview_mode' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_item_thumbnail'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_placeholder_image' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_is_downloadable'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'force_product_downloadable' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_product_file'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'provide_dummy_product_file' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_order_get_downloadable_items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_dummy_downloadable_items' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) clean_up_filters() {
	rt.call_function('remove_filter', [rt.new_string('woocommerce_order_needs_shipping_address'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enable_shipping_address' }])])
	rt.call_function('remove_filter', [rt.new_string('woocommerce_order_item_product'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_dummy_product_when_not_set' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('woocommerce_is_email_preview'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enable_preview_mode' }])])
	rt.call_function('remove_filter', [rt.new_string('woocommerce_order_item_thumbnail'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_placeholder_image' }])])
	rt.call_function('remove_filter', [rt.new_string('woocommerce_is_downloadable'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'force_product_downloadable' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('woocommerce_product_file'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'provide_dummy_product_file' }]), rt.new_int(10)])
	rt.call_function('remove_filter', [rt.new_string('woocommerce_order_get_downloadable_items'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_dummy_downloadable_items' }]), rt.new_int(10)])
	this.restore_locale()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) enable_shipping_address() bool {
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) enable_preview_mode() bool {
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) get_placeholder_image() string {
	return '<img src="' + (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_url', []rt.PhpVal{})).str() + '/assets/images/placeholder.webp" width="48" height="48" alt="" />'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) force_product_downloadable(var_is_downloadable rt.PhpVal) bool {
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_is_email_preview'), rt.new_bool(false)])) {
		return true
	}
	return (var_is_downloadable).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) provide_dummy_product_file(var_file rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_is_email_preview'), rt.new_bool(false)])) {
		return rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Sample Download File.pdf'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'file', val: 'sample-download.pdf' }])
	}
	return var_file.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) get_dummy_downloadable_items(var_downloads rt.PhpVal) rt.PhpVal {
	mut var_dummy_downloads := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'product_name', val: rt.call_method(this.get_dummy_downloadable_product(), 'get_name', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'product_id', val: rt.call_method(this.get_dummy_downloadable_product(), 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'download_url', val: 'https://example.com/download' }, rt.ArrayItem{ key: 'download_name', val: rt.call_function('__', [rt.new_string('Sample Download File.pdf'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'access_expires', val: rt.add(rt.call_function('time', []rt.PhpVal{}), rt.mul(rt.new_int(30), rt.get_constant('DAY_IN_SECONDS'))) }]) }])
	return rt.call_function('array_merge', [var_downloads.clone(), var_dummy_downloads.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) generate_placeholder_content(email_type_class_name string) string {
	this.set_email_type(email_type_class_name)
	mut var_woo_content_processor := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_EmailEditor_WooContentProcessor.class()])
	closure_1_fn := fn [var_woo_content_processor] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_function('add_filter', [rt.new_string('woocommerce_email_styles'), rt.create_array([rt.ArrayItem{ key: none, val: var_woo_content_processor }, rt.ArrayItem{ key: none, val: 'prepare_css' }]), rt.new_int(10), rt.new_int(2)])
		mut var_content := rt.call_method(var_woo_content_processor, 'get_woo_content', [this.get_email()])
		var_content = rt.call_method(this.get_email(), 'style_inline', [var_content.clone()])
		var_content = this.ensure_links_open_in_new_tab((var_content).str())
		return (var_content).str()
		}
	mut var_generate_content_closure := rt.new_closure(closure_1_fn)
	this.set_up_filters()
	mut var_message := rt.new_string('')
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG')])) && rt.is_true(rt.get_constant('WP_DEBUG')) {
		var_message = rt.call_callable(var_generate_content_closure, []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	} else {
		rt.call_function('ob_start', []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_2 } }
		var_message = rt.call_callable(var_generate_content_closure, []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		unsafe { goto end_label_3 }

catch_label_3:
		mut var_e_3 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_3, 'Throwable') {
			mut var_e := var_e_3.clone()
			rt.call_function('ob_end_clean', []rt.PhpVal{})
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Admin_EmailPreview_RuntimeException', []string{}, create_automattic_woocommerce_internal_admin_emailpreview_runtimeexception(rt.call_function('esc_html__', [rt.new_string('There was an error rendering the email editor placeholder content.'), rt.new_string('woocommerce')]), rt.new_int(0), var_e.clone())))
			if rt.has_exception() { unsafe { goto catch_label_2 } }
			unsafe { goto end_label_3 }
		}
		else {
			rt.throw_exception(var_e_3)
			unsafe { goto end_label_3 }
		}

end_label_3:
		rt.call_function('ob_end_clean', []rt.PhpVal{})
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto finally_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()

finally_label_2:
	this.clean_up_filters()
	if rt.has_exception() { return rt.new_null() }

end_label_2:
	return (var_message).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) switch_to_site_locale() {
	if !(this.locale_switched) {
		rt.call_function('wc_switch_to_site_locale', []rt.PhpVal{})
		this.locale_switched = true
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) restore_locale() {
	if this.locale_switched {
		rt.call_function('wc_restore_locale', []rt.PhpVal{})
		this.locale_switched = false
	}
}

struct Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_static {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WP_User {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_DOMDocument {
	rt.PhpObjectBase
}

struct Class_WC_Order {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Product {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item_Shipping {
	rt.PhpObjectBase
}

struct Class_WC_Product {
	rt.PhpObjectBase
}

struct Class_WC_Product_Variation {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_RuntimeException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_emailpreview_emailpreview(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview{
		PhpObjectBase: rt.PhpObjectBase{}
		email_type: rt.new_null()
		email: rt.new_null()
		locale_switched: false
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_emailpreview_static(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_static {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_static{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_emailpreview_invalidargumentexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_user(_args ...rt.PhpVal) &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_emailpreview_domdocument(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_DOMDocument {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_DOMDocument{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order(_args ...rt.PhpVal) &Class_WC_Order {
	mut obj := &Class_WC_Order{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_product(_args ...rt.PhpVal) &Class_WC_Order_Item_Product {
	mut obj := &Class_WC_Order_Item_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item_shipping(_args ...rt.PhpVal) &Class_WC_Order_Item_Shipping {
	mut obj := &Class_WC_Order_Item_Shipping{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product(_args ...rt.PhpVal) &Class_WC_Product {
	mut obj := &Class_WC_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_product_variation(_args ...rt.PhpVal) &Class_WC_Product_Variation {
	mut obj := &Class_WC_Product_Variation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_emailpreview_runtimeexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_RuntimeException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'instance' {
			return Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.instance()
		}
		'get_all_email_setting_ids' {
			return Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.get_all_email_setting_ids()
		}
		'get_email_style_setting_ids' {
			return Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.get_email_style_setting_ids()
		}
		'get_email_content_setting_ids' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview.get_email_content_setting_ids(mut dispatch_arg_0)
		}
		'set_email_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_email_type(dispatch_arg_0)
			return rt.new_null()
		}
		'get_email' {
			return this.get_email()
		}
		'render' {
			return this.render()
		}
		'ensure_links_open_in_new_tab' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.ensure_links_open_in_new_tab(dispatch_arg_0)
		}
		'get_subject' {
			return rt.new_string(this.get_subject())
		}
		'get_dummy_product_when_not_set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_dummy_product_when_not_set(dispatch_arg_0)
		}
		'render_preview_email' {
			return this.render_preview_email()
		}
		'get_dummy_order' {
			return this.get_dummy_order()
		}
		'apply_dummy_order_status' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.apply_dummy_order_status(mut dispatch_arg_0)
		}
		'get_dummy_product' {
			return this.get_dummy_product()
		}
		'get_dummy_product_variation' {
			return this.get_dummy_product_variation()
		}
		'get_dummy_downloadable_product' {
			return this.get_dummy_downloadable_product()
		}
		'get_dummy_address' {
			return this.get_dummy_address()
		}
		'get_placeholders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_placeholders(dispatch_arg_0)
		}
		'set_up_filters' {
			this.set_up_filters()
			return rt.new_null()
		}
		'clean_up_filters' {
			this.clean_up_filters()
			return rt.new_null()
		}
		'enable_shipping_address' {
			return rt.new_bool(this.enable_shipping_address())
		}
		'enable_preview_mode' {
			return rt.new_bool(this.enable_preview_mode())
		}
		'get_placeholder_image' {
			return rt.new_string(this.get_placeholder_image())
		}
		'force_product_downloadable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.force_product_downloadable(dispatch_arg_0))
		}
		'provide_dummy_product_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.provide_dummy_product_file(dispatch_arg_0)
		}
		'get_dummy_downloadable_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_dummy_downloadable_items(dispatch_arg_0)
		}
		'generate_placeholder_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.generate_placeholder_content(dispatch_arg_0))
		}
		'switch_to_site_locale' {
			this.switch_to_site_locale()
			return rt.new_null()
		}
		'restore_locale' {
			this.restore_locale()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'email_type' { return this.email_type }
		'email' { return this.email }
		'locale_switched' { return rt.new_bool(this.locale_switched) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_EmailPreview) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'email_type' { this.email_type = val; return true }
		'email' { this.email = val; return true }
		'locale_switched' { this.locale_switched = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_static) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_static) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_static) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_DOMDocument) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_DOMDocument) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_DOMDocument) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Item_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Order_Item_Shipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item_Shipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item_Shipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Product_Variation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Product_Variation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Product_Variation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_EmailPreview_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
