import rt

struct Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating.render(mut var_args Class_Automattic_WooCommerce_Internal_OrderReviews_array) string {
	mut var_name := // unsupported expression: Expr_Cast_String
	mut var_id_prefix := // unsupported expression: Expr_Cast_String
	mut var_label_id := // unsupported expression: Expr_Cast_String
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_name)) || rt.is_true(rt.identical(rt.new_string(''), var_id_prefix)))) || rt.is_true(rt.identical(rt.new_string(''), var_label_id)))) {
		return ''
	}
	mut var_selected := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_selected, rt.new_int(0))) || rt.is_true(rt.greater(var_selected, rt.new_int(5))))) {
		var_selected = rt.new_int(rt.new_int(0))
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wc_get_template', [rt.new_string('order/star-rating.php'), rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'id_prefix', val: var_id_prefix }, rt.ArrayItem{ key: 'label_id', val: var_label_id }, rt.ArrayItem{ key: 'selected', val: var_selected }, rt.ArrayItem{ key: 'labels', val: Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating.get_labels() }])])
	return (// unsupported expression: Expr_Cast_String).str()
}

fn Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating.get_labels() rt.PhpVal {
	mut var_labels := rt.create_array([rt.ArrayItem{ key: 1, val: rt.call_function('__', [rt.new_string('Very poor'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 2, val: rt.call_function('__', [rt.new_string('Not that bad'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 3, val: rt.call_function('__', [rt.new_string('Average'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 4, val: rt.call_function('__', [rt.new_string('Good'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 5, val: rt.call_function('__', [rt.new_string('Perfect'), rt.new_string('woocommerce')]) }])
	mut var_filtered := rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_review_order_rating_labels'), var_labels.dup()]))
	return rt.call_function('array_replace', [var_labels.dup(), rt.call_function('array_intersect_key', [var_filtered.dup(), var_labels.dup()])])
}

fn create_automattic_woocommerce_internal_orderreviews_starrating() &Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_OrderReviews_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating.render(mut dispatch_arg_0))
		}
		'get_labels' {
			return Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating.get_labels()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_StarRating) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_orderreviews_starrating_php() {
	// unsupported statement: Stmt_Declare
}
