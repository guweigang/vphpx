import rt

struct Class_Automattic_WooCommerce_Internal_OrderReviews_Meta {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orderreviews_meta(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_OrderReviews_Meta {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_Meta{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_orderreviews_itemeligibility(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Meta) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_OrderReviews_Meta) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Meta) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_order := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return rt.new_null()
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_OrderReviews_Meta{}
	mut iife_result_0 := iife_temp_0.parts_for_order(var_order.clone())
	mut var_meta_parts := iife_result_0
	mut var_items := rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_review_order_eligible_items'),
		rt.call_method(var_order, 'get_items', []rt.PhpVal{}),
		var_order.clone(),
	]))
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility{}
	mut iife_result_1 := iife_temp_1.preload_for_items(var_items.clone(), var_order.clone())
	mut var_decisions := []rt.PhpVal{}
	mut var_has_unreviewed_row := false
	mut var_skipped_count := 0
	mut iter_1 := var_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_item,
			'WC_Order_Item_Product'))))))
		{
			continue
		}
		mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) {
			continue
		}
		mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility{}
		mut iife_result_2 := iife_temp_2.decide(var_item.clone(), var_order.clone())
		mut var_decision := iife_result_2
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.status_skip(),
			var_decision.array_get(rt.new_string('status'))))
		{
			var_skipped_count += 1
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_decision.array_get(rt.new_string('comment')),
			'WP_Comment'))))))
		{
			var_has_unreviewed_row = true
		}
		var_decisions << rt.create_array([rt.ArrayItem{ key: 'item', val: var_item },
			rt.ArrayItem{ key: 'product', val: var_product },
			rt.ArrayItem{ key: 'decision', val: var_decision }])
	}
	if !var_has_unreviewed_row {
		mut var_reviewed_count := 0
		for var_entry in var_decisions {
			if rt.is_true(rt.new_bool(rt.instance_of(var_entry.array_get(rt.new_string('decision')).array_get(rt.new_string('comment')),
				'WP_Comment')))
			{
				var_reviewed_count += 1
			}
		}
		rt.call_function('wc_get_template', [
			rt.new_string('order/customer-review-order-empty.php'),
			rt.create_array([rt.ArrayItem{ key: 'order', val: var_order },
				rt.ArrayItem{ key: 'reviewed_count', val: var_reviewed_count }]),
		])
		return rt.new_null()
	}
	mut var_order_key :=
		rt.new_string((rt.call_method(var_order, 'get_order_key', []rt.PhpVal{})).str())
	mut var_wp_button_class := rt.new_string((if rt.is_true(rt.call_function('wc_wp_theme_get_element_class_name', [
		rt.new_string('button'),
	]))
	{
		' ' +(rt.call_function('wc_wp_theme_get_element_class_name', [rt.new_string('button')])).str()
	} else {
		''
	}).str())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('implode', [rt.new_string(' · '), var_meta_parts.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Review your order'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Loved something? Not so much? Share a quick review for what you bought. Feel free to skip any product.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('* Mandatory fields'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if var_skipped_count > 0 {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string("Don't see all your products?"),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [
			rt.new_string('Some products may not be available for review because the store has disabled reviews for them.'),
			rt.new_string('woocommerce'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_attr_e', [rt.new_string('Dismiss this notice'),
			rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('admin-ajax.php')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [rt.new_string('admin-ajax.php')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.new_string('woocommerce_submit_order_reviews'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.new_string((rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str()),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_order_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [
		rt.new_string('woocommerce_submit_order_reviews'),
		rt.new_string('_wcnonce'),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_row_index := 0
	for var_entry in var_decisions {
		mut var_item := var_entry.array_get(rt.new_string('item'))
		mut var_product := var_entry.array_get(rt.new_string('product'))
		mut var_decision := var_entry.array_get(rt.new_string('decision'))
		mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility{}
		mut iife_result_3 := iife_temp_3.prefill_for_item(var_item.clone(), var_order.clone())
		mut var_prefill := iife_result_3
		rt.call_function('wc_get_template', [
			rt.new_string('order/customer-review-order-row.php'),
			rt.create_array([rt.ArrayItem{ key: 'item', val: var_item },
				rt.ArrayItem{ key: 'product', val: var_product },
				rt.ArrayItem{ key: 'order', val: var_order },
				rt.ArrayItem{ key: 'row_index', val: var_row_index },
				rt.ArrayItem{
					key: 'existing_rating'
					val: var_prefill.array_get(rt.new_string('rating'))
				}, rt.ArrayItem{
					key: 'existing_text'
					val: var_prefill.array_get(rt.new_string('text'))
				}]),
		])
		var_row_index += 1
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_wp_button_class.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Submit reviews'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Thank you for your reviews'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Your feedback helps other customers make better purchasing decisions.'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
}
