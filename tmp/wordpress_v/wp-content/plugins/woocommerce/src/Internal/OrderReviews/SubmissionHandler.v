import rt

pub fn Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler.action() string {
	return 'woocommerce_submit_order_reviews'
}
pub fn Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler.completed_meta_key() string {
	return '_wc_review_request_completed_at'
}
struct Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler) init()  {
	rt.call_function('add_action', ['wp_ajax_' + (Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler.action()).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle' }])])
	rt.call_function('add_action', ['wp_ajax_nopriv_' + (Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler.action()).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler) handle()  {
	mut var_order_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('order_id')) { rt.call_function('absint', [rt.get_superglobal('_POST').array_get('order_id')]) } else { rt.new_int(0) }
	mut var_key := if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('key')) && rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_get('key').is_string())))) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('key')])]) } else { rt.new_string('') }
	mut var_nonce := if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('_wcnonce')) && rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_get('_wcnonce').is_string())))) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('_wcnonce')])]) } else { rt.new_string('') }
	mut var_rows_in := if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('reviews')) && rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_get('reviews').is_array())))) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('reviews')]) } else { rt.new_array() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_nonce.dup().is_string()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce.dup(), Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler.action()]))))))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Security check failed.'), rt.new_string('woocommerce')]) }]), rt.new_int(403)])
	}
	mut var_order := if rt.is_true(var_order_id) { rt.call_function('wc_get_order', [var_order_id.dup()]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Order not found.'), rt.new_string('woocommerce')]) }]), rt.new_int(404)])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_key)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}), var_key.dup()]))))))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Order not found.'), rt.new_string('woocommerce')]) }]), rt.new_int(404)])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{})) && rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Order not found.'), rt.new_string('woocommerce')]) }]), rt.new_int(404)])
	}
	mut var_eligible_statuses := rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_review_order_eligible_statuses'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() }]), var_order.dup()]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_method(var_order, 'get_status', []rt.PhpVal{}), var_eligible_statuses.dup(), rt.new_bool(true)]))))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Order not found.'), rt.new_string('woocommerce')]) }]), rt.new_int(404)])
	}
	mut var_results := this.process_rows(mut rt.cast_object_ptr[Class_WC_Order](var_order), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_OrderReviews_array](var_rows_in))
	this.maybe_mark_order_complete(mut rt.cast_object_ptr[Class_WC_Order](var_order))
	rt.call_function('do_action', [rt.new_string('woocommerce_review_order_submitted'), var_order.dup(), var_results.dup()])
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'results', val: var_results }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler) process_rows(mut var_order Class_WC_Order, mut var_rows_in Class_Automattic_WooCommerce_Internal_OrderReviews_array) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_rows_in_mutated := var_rows_in
	mut var_results := rt.new_array()
	mut var_item_index := this.index_eligible_order_items(mut var_order_mutated)
	mut var_author_name := rt.new_string(rt.new_string((rt.call_method(var_order_mutated, 'get_billing_first_name', []rt.PhpVal{})).str() + ' ' + (rt.call_method(var_order_mutated, 'get_billing_last_name', []rt.PhpVal{})).str().trim_space()))
	mut var_author_email := rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{})
	mut var_author_ip := rt.call_method(var_order_mutated, 'get_customer_ip_address', []rt.PhpVal{})
	mut var_author_agent := rt.call_method(var_order_mutated, 'get_customer_user_agent', []rt.PhpVal{})
	mut var_require_mod := // unsupported expression: Expr_Cast_Bool
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility{}; return temp.reset_cache() }()
	fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility{}; return temp.preload_for_items(arg_0, arg_1) }(var_item_index.dup(), rt.new_object('WC_Order', []string{}, var_order_mutated))
	{
		mut iter_1 := var_rows_in_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_row := item_1.val
			mut var_row_index := item_1.key
			var_row_index = // unsupported expression: Expr_Cast_Int
			var_row = if rt.is_true(rt.new_bool(var_row.dup().is_array())) { var_row } else { rt.new_array() }
			mut var_rating := if var_row.array_isset(rt.new_string('rating')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
			if rt.is_true(rt.identical(rt.new_int(0), var_rating)) {
				continue
			}
			mut var_product_id := if var_row.array_isset(rt.new_string('product_id')) { rt.call_function('absint', [var_row.array_get('product_id')]) } else { rt.new_int(0) }
			mut var_order_item_id := if var_row.array_isset(rt.new_string('order_item_id')) { rt.call_function('absint', [var_row.array_get('order_item_id')]) } else { rt.new_int(0) }
			mut var_text := rt.new_string(if rt.is_true(rt.new_bool(var_row.array_isset(rt.new_string('text')) && rt.is_true(rt.new_bool(var_row.array_get('text').is_string())))) { rt.new_string(rt.call_function('wp_kses_post', [var_row.array_get('text')]).to_string().trim_space()) } else { rt.new_string('') })
			mut var_result := rt.create_array([rt.ArrayItem{ key: 'product_id', val: var_product_id }, rt.ArrayItem{ key: 'status', val: 'error' }])
			if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_rating, rt.new_int(1))) || rt.is_true(rt.greater(var_rating, rt.new_int(5))))) {
				var_result.array_set('error', 'invalid_rating')
				var_results.array_set(var_row_index, var_result.dup())
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_product_id)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_order_item_id)))))) || !(var_item_index.array_isset(var_order_item_id)))) {
				var_result.array_set('error', 'invalid_row')
				var_results.array_set(var_row_index, var_result.dup())
				continue
			}
			mut var_item := var_item_index.array_get(var_order_item_id)
			mut var_line_product_id := // unsupported expression: Expr_Cast_Int
			mut var_line_variation_id := // unsupported expression: Expr_Cast_Int
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_result.array_set('error', 'product_mismatch')
				var_results.array_set(var_row_index, var_result.dup())
				continue
			}
			mut var_review_post_id := var_line_product_id.dup()
			mut var_decision := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility{}; return temp.decide(arg_0, arg_1) }(var_item.dup(), rt.new_object('WC_Order', []string{}, var_order_mutated))
			if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.status_skip(), var_decision.array_get('status'))) {
				var_result.array_set('error', 'reviews_not_open')
				var_results.array_set(var_row_index, var_result.dup())
				continue
			}
			mut var_customer_id := // unsupported expression: Expr_Cast_Int
			mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
			mut var_comment_user_id := if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_current_user_id, rt.new_int(0))) && rt.is_true(rt.identical(var_current_user_id, var_customer_id)))) { var_current_user_id } else { rt.new_int(0) }
			mut var_existing := if rt.is_true(rt.new_bool(rt.instance_of(var_decision.array_get('comment'), 'Automattic_WooCommerce_Internal_OrderReviews_WP_Comment'))) { var_decision.array_get('comment') } else { rt.new_null() }
			if rt.is_true(rt.new_bool(rt.instance_of(var_existing, 'Automattic_WooCommerce_Internal_OrderReviews_WP_Comment'))) {
				mut var_update_ok := rt.call_function('wp_update_comment', [rt.call_function('wp_slash', [rt.create_array([rt.ArrayItem{ key: 'comment_ID', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'comment_content', val: var_text }, rt.ArrayItem{ key: 'comment_approved', val: if rt.is_true(var_require_mod) { 0 } else { 1 } }])])])
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_update_ok)) || rt.is_true(rt.call_function('is_wp_error', [var_update_ok.dup()])))) {
					var_result.array_set('error', 'update_failed')
					var_results.array_set(var_row_index, var_result.dup())
					continue
				}
				rt.call_function('update_comment_meta', [// unsupported expression: Expr_Cast_Int, rt.new_string('rating'), var_rating.dup()])
				var_result.array_set('comment_id', // unsupported expression: Expr_Cast_Int)
				var_result.array_set('status', if rt.is_true(var_require_mod) { 'pending_moderation' } else { 'ok' })
				var_results.array_set(var_row_index, var_result.dup())
				continue
			}
			mut var_comment_data := rt.create_array([rt.ArrayItem{ key: 'comment_post_ID', val: var_review_post_id }, rt.ArrayItem{ key: 'comment_author', val: if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_author_name } else { rt.call_function('__', [rt.new_string('Anonymous'), rt.new_string('woocommerce')]) } }, rt.ArrayItem{ key: 'comment_author_email', val: var_author_email }, rt.ArrayItem{ key: 'comment_author_IP', val: var_author_ip }, rt.ArrayItem{ key: 'comment_agent', val: var_author_agent }, rt.ArrayItem{ key: 'comment_content', val: var_text }, rt.ArrayItem{ key: 'comment_type', val: 'review' }, rt.ArrayItem{ key: 'comment_approved', val: if rt.is_true(var_require_mod) { 0 } else { 1 } }, rt.ArrayItem{ key: 'user_id', val: var_comment_user_id }])
			mut var_comment_id := rt.call_function('wp_insert_comment', [rt.call_function('wp_slash', [var_comment_data.dup()])])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_comment_id)))) {
				var_result.array_set('error', 'insert_failed')
				var_results.array_set(var_row_index, var_result.dup())
				continue
			}
			rt.call_function('add_comment_meta', [var_comment_id.dup(), rt.new_string('rating'), var_rating.dup(), rt.new_bool(true)])
			rt.call_function('add_comment_meta', [var_comment_id.dup(), rt.new_string('verified'), rt.new_int(1), rt.new_bool(true)])
			rt.call_function('add_comment_meta', [var_comment_id.dup(), Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.order_meta_key(), // unsupported expression: Expr_Cast_Int, rt.new_bool(true)])
			var_result.array_set('comment_id', // unsupported expression: Expr_Cast_Int)
			var_result.array_set('status', if rt.is_true(var_require_mod) { 'pending_moderation' } else { 'ok' })
			var_results.array_set(var_row_index, var_result.dup())
		}
	}
	return var_results.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler) maybe_mark_order_complete(mut var_order Class_WC_Order)  {
	mut var_order_mutated := var_order
	if rt.is_true(rt.call_method(var_order_mutated, 'get_meta', [Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler.completed_meta_key()])) {
		return rt.new_null()
	}
	mut var_customer_email := rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string(''), var_customer_email)) {
		return rt.new_null()
	}
	mut var_eligible_items := rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_review_order_eligible_items'), rt.call_method(var_order_mutated, 'get_items', []rt.PhpVal{}), var_order_mutated.dup()]))
	mut var_required_reviews := rt.new_array()
	{
		mut iter_1 := var_eligible_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_item, 'Automattic_WooCommerce_Internal_OrderReviews_WC_Order_Item_Product')))))) {
				continue
			}
			mut var_product_id := // unsupported expression: Expr_Cast_Int
			if rt.is_true(rt.greater(var_product_id, rt.new_int(0))) {
				var_required_reviews.array_set(var_product_id, rt.add(if !(var_required_reviews.array_get(var_product_id)).is_null() { var_required_reviews.array_get(var_product_id) } else { rt.new_int(0) }, rt.new_int(1)))
			}
		}
	}
	if !rt.is_true(var_required_reviews) {
		return rt.new_null()
	}
	mut var_comments := rt.call_function('get_comments', [rt.create_array([rt.ArrayItem{ key: 'post__in', val: rt.func_array_keys(var_required_reviews.dup()) }, rt.ArrayItem{ key: 'author_email', val: var_customer_email }, rt.ArrayItem{ key: 'type', val: 'review' }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: none, val: 'approve' }, rt.ArrayItem{ key: none, val: 'hold' }]) }, rt.ArrayItem{ key: 'number', val: 0 }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_comments.dup().is_array()))))) || !rt.is_true(var_comments))) {
		return rt.new_null()
	}
	mut var_review_counts := rt.new_array()
	{
		mut iter_1 := var_comments.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_comment := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_comment, 'Automattic_WooCommerce_Internal_OrderReviews_WP_Comment'))) {
				mut var_post_id := // unsupported expression: Expr_Cast_Int
				.array_set(, )
			}
		}
	}
	{
		mut iter_1 := var_required_reviews.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_required := item_1.val
			mut var_product_id := item_1.key
			if rt.is_true() {
			}
		}
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler) index_eligible_order_items(mut var_order Class_WC_Order) rt.PhpVal {
	mut var_order_mutated := var_order
}

struct Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orderreviews_submissionhandler() &Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_orderreviews_itemeligibility() &Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'handle' {
			this.handle()
			return rt.new_null()
		}
		'process_rows' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_OrderReviews_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.process_rows(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'maybe_mark_order_complete' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.maybe_mark_order_complete(mut dispatch_arg_0)
			return rt.new_null()
		}
		'index_eligible_order_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.index_eligible_order_items(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_orderreviews_submissionhandler_php() {
	// unsupported statement: Stmt_Declare
}
