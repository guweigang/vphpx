import rt

struct Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orderreviews_starrating(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating {
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



fn main() {
	defer {
		rt.shutdown()
	}

	mut var_item := rt.new_null()
	mut var_product := rt.new_null()
	mut var_order := rt.new_null()
	mut var_row_index := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_item, 'WC_Order_Item_Product')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return rt.new_null()
	}
	mut var_existing_rating := rt.new_int(if !(var_existing_rating).is_null() { rt.new_int((var_existing_rating).to_i64()) } else { 0 })
	mut var_existing_text := rt.new_string((if !(var_existing_text).is_null() { (var_existing_text).str() } else { '' }).str())
	mut var_item_id := rt.call_method(var_item, 'get_id', []rt.PhpVal{})
	mut var_product_id := rt.call_method(var_product, 'get_id', []rt.PhpVal{})
	mut var_product_link := if rt.is_true(rt.call_method(var_product, 'is_visible', []rt.PhpVal{})) { rt.call_function('get_permalink', [var_product_id.clone()]) } else { rt.new_string('') }
	mut var_product_name := rt.call_method(var_item, 'get_name', []rt.PhpVal{})
	mut var_image_html := rt.call_method(var_product, 'get_image', [rt.new_string('woocommerce_thumbnail')])
	mut var_rating_label_id := rt.new_string('woocommerce-review-rating-label-' + (var_item_id).str())
	mut var_review_label_id := rt.new_string('woocommerce-review-text-label-' + (var_item_id).str())
	mut var_review_input_id := rt.new_string('woocommerce-review-text-' + (var_item_id).str())
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating{}
	mut iife_result_0 := iife_temp_0.render(rt.create_array([rt.ArrayItem{ key: 'name', val: 'reviews[' + (var_row_index).str() + '][rating]' }, rt.ArrayItem{ key: 'id_prefix', val: 'woocommerce-review-rating-' + (var_item_id).str() }, rt.ArrayItem{ key: 'label_id', val: var_rating_label_id }, rt.ArrayItem{ key: 'selected', val: var_existing_rating }]))
	mut var_rating_control := iife_result_0
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string((var_row_index).str())]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string((var_existing_rating).str())]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_existing_text.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_product_link) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_product_link.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_product_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('(opens in a new tab)'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_product_name.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_image_html)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string((var_row_index).str())]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string((var_product_id).str())]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string((var_row_index).str())]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string((var_item_id).str())]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_rating_label_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.new_string('%1$s <span class="required" aria-hidden="true">*</span><span class="screen-reader-text"> %2$s</span>'), rt.call_function('esc_html__', [rt.new_string('Your rating'), rt.new_string('woocommerce')]), rt.call_function('esc_html__', [rt.new_string('Required'), rt.new_string('woocommerce')])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_rating_control)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_review_label_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_review_input_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Your review'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_review_input_id.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string((var_row_index).str())]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Share your experience with this product...'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [var_existing_text.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('woocommerce_review_order_form_fields'), var_item.clone(), var_product.clone(), var_order.clone(), var_row_index.clone()])
	// unsupported statement: Stmt_InlineHTML
}
