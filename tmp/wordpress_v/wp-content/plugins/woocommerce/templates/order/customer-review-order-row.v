import rt

struct Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orderreviews_starrating() &Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_templates_order_customer_review_order_row_php() {
	mut var_item := rt.new_null()
	mut var_product := rt.new_null()
	mut var_order := rt.new_null()
	mut var_row_index := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_item, 'WC_Order_Item_Product')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))))) {
		return rt.new_null()
	}
	mut var_existing_rating := if !(var_existing_rating).is_null() { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	mut var_existing_text := if !(var_existing_text).is_null() { // unsupported expression: Expr_Cast_String } else { rt.new_string('') }
	mut var_item_id := rt.call_method(var_item, 'get_id', []rt.PhpVal{})
	mut var_product_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	mut var_product_link := if rt.is_true(rt.call_method(var_product, 'is_visible', []rt.PhpVal{})) { rt.call_function('get_permalink', [var_product_id.dup()]) } else { rt.new_string('') }
	mut var_product_name := rt.call_method(var_item, 'get_name', []rt.PhpVal{})
	mut var_image_html := rt.call_method(var_product, 'get_image', [rt.new_string('woocommerce_thumbnail')])
	mut var_rating_label_id := rt.new_string('woocommerce-review-rating-label-' + (var_item_id).str())
	mut var_review_label_id := rt.new_string('woocommerce-review-text-label-' + (var_item_id).str())
	mut var_review_input_id := rt.new_string('woocommerce-review-text-' + (var_item_id).str())
	mut var_rating_control := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating{}; return temp.render(arg_0) }(rt.create_array([rt.ArrayItem{ key: 'name', val: 'reviews[' + (var_row_index).str() + '][rating]' }, rt.ArrayItem{ key: 'id_prefix', val: 'woocommerce-review-rating-' + (var_item_id).str() }, rt.ArrayItem{ key: 'label_id', val: var_rating_label_id }, rt.ArrayItem{ key: 'selected', val: var_existing_rating }]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [// unsupported expression: Expr_Cast_String]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [// unsupported expression: Expr_Cast_String]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_existing_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_product_link) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_product_link.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_product_name.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('(opens in a new tab)'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_product_name.dup()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_image_html)
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [// unsupported expression: Expr_Cast_String]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [// unsupported expression: Expr_Cast_String]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [// unsupported expression: Expr_Cast_String]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [// unsupported expression: Expr_Cast_String]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_rating_label_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('%1$s <span class="required" aria-hidden="true">*</span><span class="screen-reader-text"> %2$s</span>'), rt.call_function('esc_html__', [rt.new_string('Your rating'), rt.new_string('woocommerce')]), rt.call_function('esc_html__', [rt.new_string('Required'), rt.new_string('woocommerce')])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_rating_control)
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_review_label_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_review_input_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Your review'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_review_input_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [// unsupported expression: Expr_Cast_String]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Share your experience with this product...'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [var_existing_text.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_review_order_form_fields'), var_item.dup(), var_product.dup(), var_order.dup(), var_row_index.dup()])
	// unsupported statement: Stmt_InlineHTML
}
