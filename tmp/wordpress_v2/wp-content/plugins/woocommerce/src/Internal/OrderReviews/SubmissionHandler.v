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

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler) init() {
	rt.call_function('add_action', [
		rt.new_string('wp_ajax_' +(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler.action()).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle' },
		]),
	])
	rt.call_function('add_action', [
		rt.new_string('wp_ajax_nopriv_' +(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler.action()).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle' },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler) handle() {
	mut var_order_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('order_id')) { rt.call_function('absint', [
			rt.get_superglobal('_POST').array_get(rt.new_string('order_id')),
		]) } else { rt.new_int(0) }
	mut var_key := if rt.get_superglobal('_POST').array_isset(rt.new_string('key')) && rt.get_superglobal('_POST').array_get(rt.new_string('key')).is_string() { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('key'))]),
		]) } else { rt.new_string('') }
	mut var_nonce := if rt.get_superglobal('_POST').array_isset(rt.new_string('_wcnonce')) && rt.get_superglobal('_POST').array_get(rt.new_string('_wcnonce')).is_string() { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('_wcnonce'))]),
		]) } else { rt.new_string('') }
	mut var_rows_in := if rt.get_superglobal('_POST').array_isset(rt.new_string('reviews')) && rt.get_superglobal('_POST').array_get(rt.new_string('reviews')).is_array() { rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('reviews')),
		]) } else { rt.new_array() }
	if !(var_nonce.clone().is_string())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [var_nonce.clone(), Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler.action()]))))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Security check failed.'),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(403),
		])
	}
	mut var_order := if rt.is_true(var_order_id) { rt.call_function('wc_get_order', [
			var_order_id.clone(),
		]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Order not found.'),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(404),
		])
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_key))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [rt.call_method(var_order, 'get_order_key', []rt.PhpVal{}), var_key.clone()]))))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Order not found.'),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(404),
		])
	}
	if rt.is_true(rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.call_method(var_order, 'get_customer_id', []rt.PhpVal{}))))) {
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Order not found.'),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(404),
		])
	}
	mut var_eligible_statuses := rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_review_order_eligible_statuses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
		]),
		var_order.clone(),
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.call_method(var_order, 'get_status', []rt.PhpVal{}),
		var_eligible_statuses.clone(),
		rt.new_bool(true),
	])))))
	{
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
					rt.new_string('Order not found.'),
					rt.new_string('woocommerce'),
				]) },
			]),
			rt.new_int(404),
		])
	}
	mut var_results := this.process_rows(mut rt.cast_object_ptr[Class_WC_Order](var_order), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_OrderReviews_array](var_rows_in))
	this.maybe_mark_order_complete(mut rt.cast_object_ptr[Class_WC_Order](var_order))
	rt.call_function('do_action', [rt.new_string('woocommerce_review_order_submitted'),
		var_order.clone(), var_results.clone()])
	rt.call_function('wp_send_json_success', [
		rt.create_array([rt.ArrayItem{ key: 'results', val: var_results }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler) process_rows(mut var_order Class_WC_Order, mut var_rows_in Class_Automattic_WooCommerce_Internal_OrderReviews_array) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_rows_in_mutated := var_rows_in
	mut var_results := rt.new_array()
	mut var_item_index := this.index_eligible_order_items(mut var_order_mutated)
	mut var_author_name := rt.new_string(
		(rt.call_method(var_order_mutated, 'get_billing_first_name', []rt.PhpVal{})).str() + ' ' +(rt.call_method(var_order_mutated, 'get_billing_last_name', []rt.PhpVal{})).str().trim_space())
	mut var_author_email := rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{})
	mut var_author_ip := rt.call_method(var_order_mutated, 'get_customer_ip_address', []rt.PhpVal{})
	mut var_author_agent := rt.call_method(var_order_mutated, 'get_customer_user_agent',
		[]rt.PhpVal{})
	mut var_require_mod := rt.new_bool((rt.call_function('get_option', [
		rt.new_string('comment_moderation'),
	])).to_bool())
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility{}
	mut iife_result_0 := iife_temp_0.reset_cache()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility{}
	mut iife_result_1 := iife_temp_1.preload_for_items(var_item_index.clone(), rt.new_object('WC_Order',
		[]string{}, var_order_mutated))
	mut iter_1 := var_rows_in_mutated.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_row := item_1.val
		mut var_row_index := item_1.key
		var_row_index = rt.new_int(var_row_index.to_i64())
		var_row = if var_row.clone().is_array() { var_row } else { rt.new_array() }
		mut var_rating := rt.new_int(if var_row.array_isset(rt.new_string('rating')) {
			rt.new_int((var_row.array_get(rt.new_string('rating'))).to_i64())
		} else {
			0
		})
		if rt.is_true(rt.identical(rt.new_int(0), var_rating)) {
			continue
		}
		mut var_product_id := if var_row.array_isset(rt.new_string('product_id')) { rt.call_function('absint', [
				var_row.array_get(rt.new_string('product_id')),
			]) } else { rt.new_int(0) }
		mut var_order_item_id := if var_row.array_isset(rt.new_string('order_item_id')) { rt.call_function('absint', [
				var_row.array_get(rt.new_string('order_item_id')),
			]) } else { rt.new_int(0) }
		mut var_text := rt.new_string((if var_row.array_isset(rt.new_string('text')) && var_row.array_get(rt.new_string('text')).is_string() { rt.call_function('wp_kses_post', [
				var_row.array_get(rt.new_string('text')),
			]).to_string().trim_space() } else { '' }).str())
		mut var_result := rt.create_array([
			rt.ArrayItem{ key: 'product_id', val: var_product_id },
			rt.ArrayItem{ key: 'status', val: 'error' },
		])
		if rt.is_true(rt.less(var_rating, rt.new_int(1)))
			|| rt.is_true(rt.greater(var_rating, rt.new_int(5))) {
			var_result.array_set('error', 'invalid_rating')
			var_results.array_set(var_row_index, var_result.clone())
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_product_id))))
			|| rt.is_true(rt.new_bool(!(rt.is_true(var_order_item_id))))
			|| !(var_item_index.array_isset(var_order_item_id)) {
			var_result.array_set('error', 'invalid_row')
			var_results.array_set(var_row_index, var_result.clone())
			continue
		}
		mut var_item := var_item_index.array_get(var_order_item_id)
		mut var_line_product_id := rt.new_int((rt.call_method(var_item, 'get_product_id',
			[]rt.PhpVal{})).to_i64())
		mut var_line_variation_id := rt.new_int((rt.call_method(var_item, 'get_variation_id',
			[]rt.PhpVal{})).to_i64())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_product_id, var_line_product_id))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_product_id, var_line_variation_id)))) {
			var_result.array_set('error', 'product_mismatch')
			var_results.array_set(var_row_index, var_result.clone())
			continue
		}
		mut var_review_post_id := var_line_product_id.clone()
		mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility{}
		mut iife_result_2 := iife_temp_2.decide(var_item.clone(), rt.new_object('WC_Order',
			[]string{}, var_order_mutated))
		mut var_decision := iife_result_2
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.status_skip(),
			var_decision.array_get(rt.new_string('status'))))
		{
			var_result.array_set('error', 'reviews_not_open')
			var_results.array_set(var_row_index, var_result.clone())
			continue
		}
		mut var_customer_id := rt.new_int((rt.call_method(var_order_mutated, 'get_customer_id',
			[]rt.PhpVal{})).to_i64())
		mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
		mut var_comment_user_id := if rt.is_true(rt.greater(var_current_user_id, rt.new_int(0)))
			&& rt.is_true(rt.identical(var_current_user_id, var_customer_id)) {
			var_current_user_id
		} else {
			rt.new_int(0)
		}
		mut var_existing := if rt.is_true(rt.new_bool(rt.instance_of(var_decision.array_get(rt.new_string('comment')),
			'Automattic_WooCommerce_Internal_OrderReviews_WP_Comment')))
		{
			var_decision.array_get(rt.new_string('comment'))
		} else {
			rt.new_null()
		}
		if rt.is_true(rt.new_bool(rt.instance_of(var_existing,
			'Automattic_WooCommerce_Internal_OrderReviews_WP_Comment')))
		{
			mut var_update_ok := rt.call_function('wp_update_comment', [
				rt.call_function('wp_slash', [
					rt.create_array([
						rt.ArrayItem{ key: 'comment_ID', val: rt.new_int((rt.get_property(var_existing,
							'comment_ID')).to_i64()) },
						rt.ArrayItem{ key: 'comment_content', val: var_text },
						rt.ArrayItem{
							key: 'comment_approved'
							val: if rt.is_true(var_require_mod) { 0 } else { 1 }
						},
					]),
				]),
			])
			if rt.is_true(rt.identical(rt.new_bool(false), var_update_ok))
				|| rt.is_true(rt.call_function('is_wp_error', [var_update_ok.clone()])) {
				var_result.array_set('error', 'update_failed')
				var_results.array_set(var_row_index, var_result.clone())
				continue
			}
			rt.call_function('update_comment_meta', [
				rt.new_int((rt.get_property(var_existing, 'comment_ID')).to_i64()),
				rt.new_string('rating'),
				var_rating.clone(),
			])
			var_result.array_set('comment_id', rt.new_int((rt.get_property(var_existing,
				'comment_ID')).to_i64()))
			var_result.array_set('status', if rt.is_true(var_require_mod) {
				'pending_moderation'
			} else {
				'ok'
			})
			var_results.array_set(var_row_index, var_result.clone())
			continue
		}
		mut var_comment_data := rt.create_array([
			rt.ArrayItem{ key: 'comment_post_ID', val: var_review_post_id },
			rt.ArrayItem{
				key: 'comment_author'
				val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_author_name)))) { var_author_name } else { rt.call_function('__', [
						rt.new_string('Anonymous'),
						rt.new_string('woocommerce'),
					]) }
			},
			rt.ArrayItem{ key: 'comment_author_email', val: var_author_email },
			rt.ArrayItem{ key: 'comment_author_IP', val: var_author_ip },
			rt.ArrayItem{ key: 'comment_agent', val: var_author_agent },
			rt.ArrayItem{ key: 'comment_content', val: var_text },
			rt.ArrayItem{ key: 'comment_type', val: 'review' },
			rt.ArrayItem{
				key: 'comment_approved'
				val: if rt.is_true(var_require_mod) { 0 } else { 1 }
			},
			rt.ArrayItem{ key: 'user_id', val: var_comment_user_id },
		])
		mut var_comment_id := rt.call_function('wp_insert_comment', [
			rt.call_function('wp_slash', [var_comment_data.clone()]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_comment_id)))) {
			var_result.array_set('error', 'insert_failed')
			var_results.array_set(var_row_index, var_result.clone())
			continue
		}
		rt.call_function('add_comment_meta', [var_comment_id.clone(),
			rt.new_string('rating'), var_rating.clone(), rt.new_bool(true)])
		rt.call_function('add_comment_meta', [var_comment_id.clone(),
			rt.new_string('verified'), rt.new_int(1), rt.new_bool(true)])
		rt.call_function('add_comment_meta', [var_comment_id.clone(),
			Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.order_meta_key(),
			rt.new_int((rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).to_i64()),
			rt.new_bool(true)])
		var_result.array_set('comment_id', rt.new_int(var_comment_id.to_i64()))
		var_result.array_set('status', if rt.is_true(var_require_mod) {
			'pending_moderation'
		} else {
			'ok'
		})
		var_results.array_set(var_row_index, var_result.clone())
	}
	return var_results.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler) maybe_mark_order_complete(mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	if rt.is_true(rt.call_method(var_order_mutated, 'get_meta', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler.completed_meta_key(),
	]))
	{
		return
	}
	mut var_customer_email := rt.call_method(var_order_mutated, 'get_billing_email', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_string(''), var_customer_email)) {
		return
	}
	mut var_eligible_items := rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_review_order_eligible_items'),
		rt.call_method(var_order_mutated, 'get_items', []rt.PhpVal{}),
		var_order_mutated,
	]))
	mut var_required_reviews := rt.new_array()
	mut iter_2 := var_eligible_items.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_item := item_2.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_item,
			'Automattic_WooCommerce_Internal_OrderReviews_WC_Order_Item_Product'))))))
		{
			continue
		}
		mut var_product_id :=
			rt.new_int((rt.call_method(var_item, 'get_product_id', []rt.PhpVal{})).to_i64())
		if rt.is_true(rt.greater(var_product_id, rt.new_int(0))) {
			var_required_reviews.array_set(var_product_id, rt.add(if !(var_required_reviews.array_get(var_product_id)).is_null() {
				var_required_reviews.array_get(var_product_id)
			} else {
				rt.new_int(0)
			}, rt.new_int(1)))
		}
	}
	if !rt.is_true(var_required_reviews) {
		return
	}
	mut var_comments := rt.call_function('get_comments', [
		rt.create_array([
			rt.ArrayItem{ key: 'post__in', val: rt.func_array_keys(var_required_reviews.clone()) },
			rt.ArrayItem{ key: 'author_email', val: var_customer_email },
			rt.ArrayItem{ key: 'type', val: 'review' },
			rt.ArrayItem{ key: 'status', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'approve' },
				rt.ArrayItem{ key: none, val: 'hold' },
			]) },
			rt.ArrayItem{ key: 'number', val: 0 },
		]),
	])
	if !(var_comments.clone().is_array()) || !rt.is_true(var_comments) {
		return
	}
	mut var_review_counts := rt.new_array()
	mut iter_3 := var_comments.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_comment := item_3.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_comment,
			'Automattic_WooCommerce_Internal_OrderReviews_WP_Comment')))
		{
			mut var_post_id :=
				rt.new_int((rt.get_property(var_comment, 'comment_post_ID')).to_i64())
			var_review_counts.array_set(var_post_id, rt.add(if !(var_review_counts.array_get(var_post_id)).is_null() {
				var_review_counts.array_get(var_post_id)
			} else {
				rt.new_int(0)
			}, rt.new_int(1)))
		}
	}
	mut iter_4 := var_required_reviews.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_required := item_4.val
		mut var_product_id := item_4.key
		if rt.is_true(rt.less(if !(var_review_counts.array_get(var_product_id)).is_null() {
			var_review_counts.array_get(var_product_id)
		} else {
			rt.new_int(0)
		}, var_required))
		{
			return
		}
	}
	rt.call_method(var_order_mutated, 'update_meta_data', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler.completed_meta_key(),
		rt.new_string((rt.call_function('time', []rt.PhpVal{})).str()),
	])
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler) index_eligible_order_items(mut var_order Class_WC_Order) rt.PhpVal {
	mut var_order_mutated := var_order
	mut var_items := rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_review_order_eligible_items'),
		rt.call_method(var_order_mutated, 'get_items', []rt.PhpVal{}),
		var_order_mutated,
	]))
	mut var_index := rt.new_array()
	mut iter_5 := var_items.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_item := item_5.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_item,
			'Automattic_WooCommerce_Internal_OrderReviews_WC_Order_Item_Product')))
		{
			var_index.array_set(rt.call_method(var_item, 'get_id', []rt.PhpVal{}), var_item.clone())
		}
	}
	return var_index.clone()
}

struct Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orderreviews_submissionhandler(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler{
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_OrderReviews_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.process_rows(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'maybe_mark_order_complete' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.maybe_mark_order_complete(mut dispatch_arg_0)
			return rt.new_null()
		}
		'index_eligible_order_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.index_eligible_order_items(mut dispatch_arg_0)
		}
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}
