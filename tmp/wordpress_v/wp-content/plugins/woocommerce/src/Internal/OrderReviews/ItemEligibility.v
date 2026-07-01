import rt

pub fn Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.status_form() string {
	return 'form'
}
pub fn Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.status_skip() string {
	return 'skip'
}
pub fn Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.order_meta_key() string {
	return '_review_order_id'
}
struct Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility {
	rt.PhpObjectBase
pub mut:
		review_cache rt.PhpVal = rt.new_array()
		preloaded rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility) init()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_review_order_eligible_items'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.class() }, rt.ArrayItem{ key: none, val: 'exclude_fully_refunded_items' }]), rt.new_int(10), rt.new_int(2)])
}

fn Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.preload_for_items(mut var_items Class_Automattic_WooCommerce_Internal_OrderReviews_iterable, mut var_order Class_WC_Order)  {
	mut var_email := var_order.get_billing_email()
	mut var_order_id := var_order.get_id()
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_email)) || rt.is_true(rt.less_equal(var_order_id, rt.new_int(0))))) {
		return rt.new_null()
	}
	mut var_preload_key := rt.new_string((var_order_id).str() + '|' + (var_email).str())
	if // unsupported expression: Expr_StaticPropertyFetch.array_isset(var_preload_key) {
		return rt.new_null()
	}
	mut var_product_ids := rt.new_array()
	{
		mut iter_1 := var_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_item, 'WC_Order_Item_Product'))) {
				mut var_pid := // unsupported expression: Expr_Cast_Int
				if rt.is_true(rt.greater(var_pid, rt.new_int(0))) {
					var_product_ids.array_set(var_pid, var_pid.dup())
				}
			}
		}
	}
	if !rt.is_true(var_product_ids) {
		return rt.new_null()
	}
	// unsupported expression: Expr_StaticPropertyFetch.array_set(var_preload_key, true)
	mut var_comments := rt.call_function('get_comments', [rt.create_array([rt.ArrayItem{ key: 'post__in', val: rt.call_function('array_values', [var_product_ids.dup()]) }, rt.ArrayItem{ key: 'author_email', val: var_email }, rt.ArrayItem{ key: 'type', val: 'review' }, rt.ArrayItem{ key: 'status', val: 'approve' }, rt.ArrayItem{ key: 'include_unapproved', val: rt.create_array([rt.ArrayItem{ key: none, val: var_email }]) }, rt.ArrayItem{ key: 'orderby', val: 'comment_date_gmt' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'meta_query', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.order_meta_key() }, rt.ArrayItem{ key: 'value', val: // unsupported expression: Expr_Cast_String }]) }]) }])])
	{
		mut iter_1 := var_product_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_pid := item_1.val
			// unsupported expression: Expr_StaticPropertyFetch.array_set(Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.cache_key((var_order_id).to_i64(), (var_pid).to_i64(), (var_email).str()), rt.new_null())
		}
	}
	if rt.is_true(rt.new_bool(var_comments.dup().is_array())) {
		{
			mut iter_1 := var_comments.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_comment := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_comment, 'WP_Comment')))))) {
					continue
				}
				mut var_key := Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.cache_key((var_order_id).to_i64(), (// unsupported expression: Expr_Cast_Int).to_i64(), (var_email).str())
				if rt.is_true(rt.identical(rt.new_null(), if !(// unsupported expression: Expr_StaticPropertyFetch.array_get(var_key)).is_null() { // unsupported expression: Expr_StaticPropertyFetch.array_get(var_key) } else { rt.new_null() })) {
					// unsupported expression: Expr_StaticPropertyFetch.array_set(var_key, var_comment.dup())
				}
			}
		}
	}
}

fn Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.reset_cache()  {
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.decide(mut var_item Class_WC_Order_Item_Product, mut var_order Class_WC_Order) rt.PhpVal {
	mut var_product_id := // unsupported expression: Expr_Cast_Int
	mut var_result := rt.create_array([rt.ArrayItem{ key: 'status', val: Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.status_form() }, rt.ArrayItem{ key: 'comment', val: rt.new_null() }, rt.ArrayItem{ key: 'product_id', val: var_product_id }])
	if rt.is_true(rt.new_bool(rt.is_true(rt.less_equal(var_product_id, rt.new_int(0))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('comments_open', [var_product_id.dup()]))))))) {
		var_result.array_set('status', Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.status_skip())
		return var_result.dup()
	}
	var_result.array_set('comment', Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.find_existing_review((var_product_id).to_i64(), mut var_order))
	return var_result.dup()
}

fn Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.prefill_for_item(mut var_item Class_WC_Order_Item_Product, mut var_order Class_WC_Order) rt.PhpVal {
	mut var_existing := Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.find_existing_review((// unsupported expression: Expr_Cast_Int).to_i64(), mut var_order)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_existing, 'WP_Comment')))))) {
		return rt.create_array([rt.ArrayItem{ key: 'rating', val: 0 }, rt.ArrayItem{ key: 'text', val: '' }, rt.ArrayItem{ key: 'comment_id', val: 0 }])
	}
	mut var_rating := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_rating, rt.new_int(0))) || rt.is_true(rt.greater(var_rating, rt.new_int(5))))) {
		var_rating = rt.new_int(rt.new_int(0))
	}
	return rt.create_array([rt.ArrayItem{ key: 'rating', val: var_rating }, rt.ArrayItem{ key: 'text', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'comment_id', val: // unsupported expression: Expr_Cast_Int }])
}

fn Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.exclude_fully_refunded_items(mut var_items Class_Automattic_WooCommerce_Internal_OrderReviews_array, mut var_order Class_WC_Order) rt.PhpVal {
	mut var_filtered := rt.new_array()
	{
		mut iter_1 := var_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_item, 'WC_Order_Item_Product')))))) {
				var_filtered.array_set(var_key, var_item.dup())
				continue
			}
			mut var_refunded_qty := // unsupported expression: Expr_Cast_Double
			mut var_ordered_qty := // unsupported expression: Expr_Cast_Double
			if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_ordered_qty, rt.new_int(0))) && rt.is_true(rt.greater_equal(var_refunded_qty, var_ordered_qty)))) {
				continue
			}
			var_filtered.array_set(var_key, var_item.dup())
		}
	}
	return var_filtered.dup()
}

fn Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.find_existing_review(product_id i64, mut var_order Class_WC_Order) rt.PhpVal {
	mut product_id_mutated := product_id
	mut var_email := var_order.get_billing_email()
	mut var_order_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_email)) || rt.is_true(rt.less_equal(var_order_id, rt.new_int(0))))) || product_id_mutated <= 0)) {
		return rt.new_null()
	}
	mut var_key := Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.cache_key((var_order_id).to_i64(), product_id_mutated, (var_email).str())
	if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_key.dup()))) {
		return // unsupported expression: Expr_StaticPropertyFetch.array_get(var_key)
	}
	mut var_comments := rt.call_function('get_comments', [rt.create_array([rt.ArrayItem{ key: 'post_id', val: product_id_mutated }, rt.ArrayItem{ key: 'author_email', val: var_email }, rt.ArrayItem{ key: 'type', val: 'review' }, rt.ArrayItem{ key: 'status', val: 'approve' }, rt.ArrayItem{ key: 'include_unapproved', val: rt.create_array([rt.ArrayItem{ key: none, val: var_email }]) }, rt.ArrayItem{ key: 'number', val: 1 }, rt.ArrayItem{ key: 'orderby', val: 'comment_date_gmt' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'meta_query', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.order_meta_key() }, rt.ArrayItem{ key: 'value', val: // unsupported expression: Expr_Cast_String }]) }]) }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_comments.dup().is_array()))))) || !rt.is_true(var_comments))) {
		// unsupported expression: Expr_StaticPropertyFetch.array_set(var_key, rt.new_null())
		return rt.new_null()
	}
	mut var_first := rt.call_function('reset', [var_comments.dup()])
	mut var_found := if rt.is_true(rt.new_bool(rt.instance_of(var_first, 'WP_Comment'))) { var_first } else { rt.new_null() }
	// unsupported expression: Expr_StaticPropertyFetch.array_set(var_key, var_found.dup())
	return var_found.dup()
}

fn Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.cache_key(order_id i64, product_id i64, email string) string {
	mut order_id_mutated := order_id
	mut product_id_mutated := product_id
	mut email_mutated := email
	return order_id_mutated.str() + '|' + product_id_mutated.str() + '|' + email_mutated
}

fn create_automattic_woocommerce_internal_orderreviews_itemeligibility() &Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility{
		PhpObjectBase: rt.PhpObjectBase{}
		review_cache: rt.new_array()
		preloaded: rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'preload_for_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_OrderReviews_iterable](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.preload_for_items(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'reset_cache' {
			Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.reset_cache()
			return rt.new_null()
		}
		'decide' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order_Item_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.decide(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'prefill_for_item' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order_Item_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.prefill_for_item(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'exclude_fully_refunded_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_OrderReviews_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.exclude_fully_refunded_items(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'find_existing_review' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WC_Order](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.find_existing_review(dispatch_arg_0, mut dispatch_arg_1)
		}
		'cache_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.cache_key(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'review_cache' { return this.review_cache }
		'preloaded' { return this.preloaded }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'review_cache' { this.review_cache = val; return true }
		'preloaded' { this.preloaded = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_woocommerce_src_internal_orderreviews_itemeligibility_php() {
	// unsupported statement: Stmt_Declare
}
