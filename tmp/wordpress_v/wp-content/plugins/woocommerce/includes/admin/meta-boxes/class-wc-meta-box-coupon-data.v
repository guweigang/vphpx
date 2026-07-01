import rt

struct Class_WC_Meta_Box_Coupon_Data {
	rt.PhpObjectBase
}

fn Class_WC_Meta_Box_Coupon_Data.output(var_post rt.PhpVal)  {
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce_save_data'), rt.new_string('woocommerce_meta_nonce')])
	mut var_coupon_id := rt.call_function('absint', [rt.get_property(var_post, 'ID')])
	mut var_coupon := create_wc_coupon(var_coupon_id.dup())
	// unsupported statement: Stmt_InlineHTML
	mut var_coupon_data_tabs := rt.call_function('apply_filters', [rt.new_string('woocommerce_coupon_data_tabs'), rt.create_array([rt.ArrayItem{ key: 'general', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('General'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'target', val: 'general_coupon_data' }, rt.ArrayItem{ key: 'class', val: 'general_coupon_data' }]) }, rt.ArrayItem{ key: 'usage_restriction', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Usage restriction'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'target', val: 'usage_restriction_coupon_data' }, rt.ArrayItem{ key: 'class', val: '' }]) }, rt.ArrayItem{ key: 'usage_limit', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Usage limits'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'target', val: 'usage_limit_coupon_data' }, rt.ArrayItem{ key: 'class', val: '' }]) }])])
	{
		mut iter_1 := var_coupon_data_tabs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tab := item_1.val
			mut var_key := item_1.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_key)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_key)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('implode', [rt.new_string(' '), rt.cast_array(var_tab.array_get('class'))]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_tab.array_get('target'))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_tab.array_get('label')]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('woocommerce_wp_select', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'discount_type' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Discount type'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'options', val: rt.call_function('wc_get_coupon_types', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'value', val: var_coupon.get_discount_type(rt.new_string('edit')) }])])
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'coupon_amount' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Coupon amount'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('wc_format_localized_price', [rt.new_int(0)]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Value of the coupon.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'data_type', val: if rt.is_true(rt.identical(rt.new_string('percent'), var_coupon.get_discount_type(rt.new_string('edit')))) { 'decimal' } else { 'price' } }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'value', val: var_coupon.get_amount(rt.new_string('edit')) }])])
	if rt.is_true(rt.call_function('wc_shipping_enabled', []rt.PhpVal{})) {
		rt.call_function('woocommerce_wp_checkbox', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'free_shipping' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Allow free shipping'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Check this box if the coupon grants free shipping. A <a href="%s" target="_blank">free shipping method</a> must be enabled in your shipping zone and be set to require "a valid free shipping coupon" (see the "Free Shipping Requires" setting).'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/document/free-shipping/')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_bool_to_string', [var_coupon.get_free_shipping(rt.new_string('edit'))]) }])])
	}
	mut var_expiry_date := if rt.is_true(var_coupon.get_date_expires(rt.new_string('edit'))) { rt.call_method(var_coupon.get_date_expires(rt.new_string('edit')), 'date', [rt.new_string('Y-m-d')]) } else { rt.new_string('') }
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'expiry_date' }, rt.ArrayItem{ key: 'value', val: rt.call_function('esc_attr', [var_expiry_date.dup()]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Coupon expiry date'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('_x', [rt.new_string('YYYY-MM-DD'), rt.new_string('coupon expiry date placeholder'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The coupon will expire at 00:00:00 of this date.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'class', val: 'date-picker' }, rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([rt.ArrayItem{ key: 'pattern', val: rt.call_function('apply_filters', [rt.new_string('woocommerce_date_input_html_pattern'), rt.new_string('[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])')]) }]) }])])
	rt.call_function('do_action', [rt.new_string('woocommerce_coupon_options'), var_coupon.get_id(), var_coupon])
	// unsupported statement: Stmt_InlineHTML
	print('<div class="options_group">')
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'minimum_amount' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Minimum spend'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [rt.new_string('No minimum'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('This field allows you to set the minimum spend (subtotal) allowed to use the coupon.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'data_type', val: 'price' }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'value', val: var_coupon.get_minimum_amount(rt.new_string('edit')) }])])
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'maximum_amount' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Maximum spend'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [rt.new_string('No maximum'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('This field allows you to set the maximum spend (subtotal) allowed when using the coupon.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'data_type', val: 'price' }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'value', val: var_coupon.get_maximum_amount(rt.new_string('edit')) }])])
	rt.call_function('woocommerce_wp_checkbox', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'individual_use' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Individual use only'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Check this box if the coupon cannot be used in conjunction with other coupons.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_bool_to_string', [var_coupon.get_individual_use(rt.new_string('edit'))]) }])])
	rt.call_function('woocommerce_wp_checkbox', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'exclude_sale_items' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Exclude sale items'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Check this box if the coupon should not apply to items on sale. Per-item coupons will only work if the item is not on sale. Per-cart coupons will only work if there are items in the cart that are not on sale.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('wc_bool_to_string', [var_coupon.get_exclude_sale_items(rt.new_string('edit'))]) }])])
	print('</div><div class="options_group"><div class="hr-section hr-section-coupon_restrictions">' + (rt.call_function('esc_html__', [rt.new_string('And'), rt.new_string('woocommerce')])).str() + '</div>')
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Products'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Search for a product&hellip;'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_product_ids := var_coupon.get_product_ids(rt.new_string('edit'))
	{
		mut iter_1 := var_product_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_product_id := item_1.val
			mut var_product := rt.call_function('wc_get_product', [var_product_id.dup()])
			if rt.is_true(rt.new_bool(var_product.dup().is_object())) {
				print('<option value="' + (rt.call_function('esc_attr', [var_product_id.dup()])).str() + '"' + (rt.call_function('selected', [rt.new_bool(true), rt.new_bool(true), rt.new_bool(false)])).str() + '>' + (rt.call_function('esc_html', [rt.call_function('wp_strip_all_tags', [rt.call_method(var_product, 'get_formatted_name', []rt.PhpVal{})])])).str() + '</option>')
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('Products that the coupon will be applied to, or that need to be in the cart in order for the "Fixed cart discount" to be applied.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Exclude products'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Search for a product&hellip;'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	var_product_ids = var_coupon.get_excluded_product_ids(rt.new_string('edit'))
	{
		mut iter_1 := var_product_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_product_id := item_1.val
			mut var_product := rt.call_function('wc_get_product', [var_product_id.dup()])
			if rt.is_true(rt.new_bool(var_product.dup().is_object())) {
				print('<option value="' + (rt.call_function('esc_attr', [var_product_id.dup()])).str() + '"' + (rt.call_function('selected', [rt.new_bool(true), rt.new_bool(true), rt.new_bool(false)])).str() + '>' + (rt.call_function('esc_html', [rt.call_function('wp_strip_all_tags', [rt.call_method(var_product, 'get_formatted_name', []rt.PhpVal{})])])).str() + '</option>')
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('Products that the coupon will not be applied to, or that cannot be in the cart in order for the "Fixed cart discount" to be applied.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	print('</div><div class="options_group"><div class="hr-section hr-section-coupon_restrictions">' + (rt.call_function('esc_html__', [rt.new_string('And'), rt.new_string('woocommerce')])).str() + '</div>')
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Product categories'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Any category'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut var_category_ids := var_coupon.get_product_categories(rt.new_string('edit'))
	mut var_categories := rt.call_function('get_terms', [rt.new_string('product_cat'), rt.new_string('orderby=name&hide_empty=0')])
	if rt.is_true(var_categories) {
		{
			mut iter_1 := var_categories.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_cat := item_1.val
				print('<option value="' + (rt.call_function('esc_attr', [rt.get_property(var_cat, 'term_id')])).str() + '"' + (rt.call_function('wc_selected', [rt.get_property(var_cat, 'term_id'), var_category_ids.dup()])).str() + '>' + (rt.call_function('esc_html', [rt.get_property(var_cat, 'name')])).str() + '</option>')
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('Product categories that the coupon will be applied to, or that need to be in the cart in order for the "Fixed cart discount" to be applied.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Exclude categories'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('No categories'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	var_category_ids = var_coupon.get_excluded_product_categories(rt.new_string('edit'))
	var_categories = rt.call_function('get_terms', [rt.new_string('product_cat'), rt.new_string('orderby=name&hide_empty=0')])
	if rt.is_true(var_categories) {
		{
			mut iter_1 := var_categories.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_cat := item_1.val
				print('<option value="' + (rt.call_function('esc_attr', [rt.get_property(var_cat, 'term_id')])).str() + '"' + (rt.call_function('wc_selected', [rt.get_property(var_cat, 'term_id'), var_category_ids.dup()])).str() + '>' + (rt.call_function('esc_html', [rt.get_property(var_cat, 'name')])).str() + '</option>')
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [rt.call_function('__', [rt.new_string('Product categories that the coupon will not be applied to, or that cannot be in the cart in order for the "Fixed cart discount" to be applied.'), rt.new_string('woocommerce')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html__', [rt.new_string('And'), rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'customer_email' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Allowed emails'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [rt.new_string('No restrictions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of allowed billing emails to check against when an order is placed. Separate email addresses with commas. You can also use an asterisk (*) to match parts of an email. For example "*@gmail.com" would match all gmail addresses.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'value', val: rt.call_function('implode', [rt.new_string(', '), rt.cast_array(var_coupon.get_email_restrictions(rt.new_string('edit')))]) }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'type', val: 'email' }, rt.ArrayItem{ key: 'class', val: '' }, rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([rt.ArrayItem{ key: 'multiple', val: 'multiple' }]) }])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_coupon_options_usage_restriction'), var_coupon.get_id(), var_coupon])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'usage_limit' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Usage limit per coupon'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('esc_attr__', [rt.new_string('Unlimited usage'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('How many times this coupon can be used before it is void.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'class', val: 'short' }, rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([rt.ArrayItem{ key: 'step', val: 1 }, rt.ArrayItem{ key: 'min', val: 0 }]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(var_coupon.get_usage_limit(rt.new_string('edit'))) { var_coupon.get_usage_limit(rt.new_string('edit')) } else { rt.new_string('') } }])])
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'limit_usage_to_x_items' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Limit usage to X items'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('esc_attr__', [rt.new_string('Apply to all qualifying items in cart'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The maximum number of individual items this coupon can apply to when using product discounts. Leave blank to apply to all qualifying items in cart.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'class', val: 'short' }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([rt.ArrayItem{ key: 'step', val: 1 }, rt.ArrayItem{ key: 'min', val: 0 }]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(var_coupon.get_limit_usage_to_x_items(rt.new_string('edit'))) { var_coupon.get_limit_usage_to_x_items(rt.new_string('edit')) } else { rt.new_string('') } }])])
	rt.call_function('woocommerce_wp_text_input', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'usage_limit_per_user' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Usage limit per user'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('esc_attr__', [rt.new_string('Unlimited usage'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('How many times this coupon can be used by an individual user. Uses billing email for guests, and user ID for logged in users.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc_tip', val: true }, rt.ArrayItem{ key: 'class', val: 'short' }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([rt.ArrayItem{ key: 'step', val: 1 }, rt.ArrayItem{ key: 'min', val: 0 }]) }, rt.ArrayItem{ key: 'value', val: if rt.is_true(.get_usage_limit_per_user(rt.new_string())) { .get_usage_limit_per_user(rt.new_string()) } else { rt.new_string('') } }])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_coupon_options_usage_limit'), .get_id(), var_coupon])
	// unsupported statement: Stmt_InlineHTML
	
}

fn Class_WC_Meta_Box_Coupon_Data.save(var_post_id rt.PhpVal, var_post rt.PhpVal)  {
}

struct Class_WC_Coupon {
	rt.PhpObjectBase
}

fn create_wc_meta_box_coupon_data() &Class_WC_Meta_Box_Coupon_Data {
	mut obj := &Class_WC_Meta_Box_Coupon_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_coupon() &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Meta_Box_Coupon_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Meta_Box_Coupon_Data.output(dispatch_arg_0)
			return rt.new_null()
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Meta_Box_Coupon_Data.save(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Meta_Box_Coupon_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Box_Coupon_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_meta_boxes_class_wc_meta_box_coupon_data_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
}
