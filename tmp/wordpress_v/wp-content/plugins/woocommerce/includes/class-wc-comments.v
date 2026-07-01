import rt

pub fn Class_WC_Comments.comment_count_cache_group() string {
	return 'wc_comment_counts'
}
pub fn Class_WC_Comments.product_reviews_pending_count_cache_key() string {
	return 'woocommerce_product_reviews_pending_count'
}
struct Class_WC_Comments {
	rt.PhpObjectBase
}

fn Class_WC_Comments.init()  {
	rt.call_function('add_filter', [rt.new_string('comments_open'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'comments_open' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('preprocess_comment'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'check_comment_rating' }]), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('comment_post'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_comment_rating' }]), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('comment_moderation_recipients'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'comment_moderation_recipients' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_update_comment_count'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'clear_transients' }])])
	rt.call_function('add_filter', [rt.new_string('comments_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'exclude_order_comments' }])])
	rt.call_function('add_filter', [rt.new_string('comment_feed_where'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'exclude_order_comments_from_feed_where' }])])
	rt.call_function('add_filter', [rt.new_string('akismet_excluded_comment_types'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'akismet_excluded_comment_types' }])])
	rt.call_function('add_filter', [rt.new_string('comments_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'exclude_webhook_comments' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('comment_feed_where'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'exclude_webhook_comments_from_feed_where' }])])
	rt.call_function('add_filter', [rt.new_string('comments_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'exclude_action_log_comments' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('comment_feed_where'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'exclude_action_log_comments_from_feed_where' }])])
	rt.call_function('add_filter', [rt.new_string('comments_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsUtil.class() }, rt.ArrayItem{ key: none, val: 'comments_clauses_without_product_reviews' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('comment_moderation_text'), rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsUtil.class() }, rt.ArrayItem{ key: none, val: 'modify_product_review_moderation_urls' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('wp_count_comments'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'wp_count_comments' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wp_insert_comment'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'increment_comments_count_cache_on_wp_insert_comment' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('transition_comment_status'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'update_comments_count_cache_on_comment_status_change' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('wp_insert_comment'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_bump_products_reviews_pending_moderation_counter' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('transition_comment_status'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'maybe_adjust_products_reviews_pending_moderation_counter' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('get_avatar_comment_types'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_avatar_for_review_comment_type' }])])
	rt.call_function('add_filter', [rt.new_string('admin_comment_types_dropdown'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_review_comment_filter' }])])
	rt.call_function('add_action', [rt.new_string('comment_post'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'add_comment_purchase_verification' }])])
	rt.call_function('add_action', [rt.new_string('preprocess_comment'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'update_comment_type' }]), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('pre_comment_on_post'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'validate_product_review_verified_owners' }])])
}

fn Class_WC_Comments.comments_open(var_open rt.PhpVal, var_post_id rt.PhpVal) rt.PhpVal {
	mut var_open_mutated := var_open
	mut var_post_id_mutated := var_post_id
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [var_post_id_mutated.dup()]))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [rt.new_string('product'), rt.new_string('comments')]))))))) {
		var_open_mutated = rt.new_bool(rt.new_bool(false))
	}
	return var_open_mutated.dup()
}

fn Class_WC_Comments.exclude_order_comments(var_clauses rt.PhpVal) rt.PhpVal {
	// unsupported expression: Expr_AssignOp_Concat
	return var_clauses.dup()
}

fn Class_WC_Comments.akismet_excluded_comment_types(var_comment_types rt.PhpVal) rt.PhpVal {
	mut var_comment_types_mutated := var_comment_types
	var_comment_types_mutated.array_push('order_note')
	return var_comment_types_mutated.dup()
}

fn Class_WC_Comments.exclude_order_comments_from_feed_join(var_join rt.PhpVal)  {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Comments::exclude_order_comments_from_feed_join'), rt.new_string('3.1')])
}

fn Class_WC_Comments.exclude_order_comments_from_feed_where(var_where rt.PhpVal) string {
	return (var_where).str() + if rt.is_true(rt.new_string(var_where.dup().to_string().trim_space())) { ' AND ' } else { '' } + ' comment_type != \'order_note\' '
}

fn Class_WC_Comments.exclude_webhook_comments(var_clauses rt.PhpVal) rt.PhpVal {
	// unsupported expression: Expr_AssignOp_Concat
	return var_clauses.dup()
}

fn Class_WC_Comments.exclude_webhook_comments_from_feed_join(var_join rt.PhpVal)  {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC_Comments::exclude_webhook_comments_from_feed_join'), rt.new_string('3.1')])
}

fn Class_WC_Comments.exclude_webhook_comments_from_feed_where(var_where rt.PhpVal) string {
	return (var_where).str() + if rt.is_true(rt.new_string(var_where.dup().to_string().trim_space())) { ' AND ' } else { '' } + ' comment_type != \'webhook_delivery\' '
}

fn Class_WC_Comments.exclude_action_log_comments_from_feed_where(var_where rt.PhpVal) string {
	return (var_where).str() + if rt.is_true(rt.new_string(var_where.dup().to_string().trim_space())) { ' AND ' } else { '' } + ' comment_type != \'action_log\' '
}

fn Class_WC_Comments.exclude_action_log_comments(var_clauses rt.PhpVal, var_comment_query rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	return var_clauses.dup()
}

fn Class_WC_Comments.check_comment_rating(var_comment_data rt.PhpVal) rt.PhpVal {
	mut var_comment_data_mutated := var_comment_data
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) && rt.get_superglobal('_POST').array_isset(rt.new_string('comment_post_ID')) && rt.get_superglobal('_POST').array_isset(rt.new_string('rating')) && var_comment_data_mutated.array_isset(rt.new_string('comment_type')))) && rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [rt.call_function('absint', [rt.get_superglobal('_POST').array_get('comment_post_ID')])]))))) && !rt.is_true(rt.get_superglobal('_POST').array_get('rating')))) && rt.is_true(Class_WC_Comments.is_default_comment_type(var_comment_data_mutated.array_get('comment_type'))))) && rt.is_true(rt.call_function('wc_review_ratings_enabled', []rt.PhpVal{})))) && rt.is_true(rt.call_function('wc_review_ratings_required', []rt.PhpVal{})))) {
		rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('Please rate the product.'), rt.new_string('woocommerce')])])
		// unsupported expression: Expr_Exit
	}
	return var_comment_data_mutated.dup()
}

fn Class_WC_Comments.add_comment_rating(var_comment_id rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('rating')) && rt.get_superglobal('_POST').array_isset(rt.new_string('comment_post_ID')) && rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [rt.call_function('absint', [rt.get_superglobal('_POST').array_get('comment_post_ID')])]))))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.get_superglobal('_POST').array_get('rating'))))) || rt.is_true(rt.greater(rt.get_superglobal('_POST').array_get('rating'), rt.new_int(5))))) || rt.is_true(rt.less(rt.get_superglobal('_POST').array_get('rating'), rt.new_int(0))))) {
			return rt.new_null()
		}
		rt.call_function('add_comment_meta', [var_comment_id.dup(), rt.new_string('rating'), rt.new_int(rt.get_superglobal('_POST').array_get('rating').to_i64()), rt.new_bool(true)])
		mut var_post_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('comment_post_ID')) { rt.call_function('absint', [rt.get_superglobal('_POST').array_get('comment_post_ID')]) } else { rt.new_int(0) }
		if rt.is_true(var_post_id) {
			Class_WC_Comments.clear_transients(var_post_id.dup())
		}
	}
}

fn Class_WC_Comments.comment_moderation_recipients(var_emails rt.PhpVal, var_comment_id rt.PhpVal) rt.PhpVal {
	mut var_emails_mutated := var_emails
	mut var_comment := rt.call_function('get_comment', [var_comment_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(var_comment) && rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [rt.get_property(var_comment, 'comment_post_ID')]))))) {
		var_emails_mutated = rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('get_option', [rt.new_string('admin_email')]) }])
	}
	return var_emails_mutated.dup()
}

fn Class_WC_Comments.clear_transients(var_post_id rt.PhpVal)  {
	mut var_post_id_mutated := var_post_id
	var_post_id_mutated = rt.call_function('absint', [var_post_id_mutated.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), var_post_id_mutated)) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_product := rt.call_function('wc_get_product', [var_post_id_mutated.dup()])
	if rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product'))) {
		rt.call_method(var_product, 'set_rating_counts', [Class_WC_Comments.get_rating_counts_for_product(var_product.dup())])
		rt.call_method(var_product, 'set_average_rating', [Class_WC_Comments.get_average_rating_for_product(var_product.dup())])
		rt.call_method(var_product, 'set_review_count', [Class_WC_Comments.get_review_count_for_product(var_product.dup())])
		rt.call_method(var_product, 'save', []rt.PhpVal{})
	}
}

fn Class_WC_Comments.increment_comments_count_cache_on_wp_insert_comment(var_comment_id rt.PhpVal, var_comment rt.PhpVal)  {
	mut var_comment_mutated := var_comment
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Comments.is_comment_excluded_from_wp_comment_counts(var_comment_mutated.dup()))))) {
		mut var_comment_status := rt.call_function('wp_get_comment_status', [var_comment_mutated.dup()])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_function('wp_cache_incr', ['wc_count_comments_' + (var_comment_status).str(), rt.new_int(1), Class_WC_Comments.comment_count_cache_group()])
		}
	}
}

fn Class_WC_Comments.update_comments_count_cache_on_comment_status_change(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_comment rt.PhpVal)  {
	mut var_comment_mutated := var_comment
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Comments.is_comment_excluded_from_wp_comment_counts(var_comment_mutated.dup()))))) {
		rt.call_function('wp_cache_incr', ['wc_count_comments_' + (var_new_status).str(), rt.new_int(1), Class_WC_Comments.comment_count_cache_group()])
		rt.call_function('wp_cache_decr', ['wc_count_comments_' + (var_old_status).str(), rt.new_int(1), Class_WC_Comments.comment_count_cache_group()])
	}
}

fn Class_WC_Comments.is_comment_excluded_from_wp_comment_counts(var_comment rt.PhpVal) bool {
	mut var_comment_mutated := var_comment
	return rt.is_true(rt.call_function('in_array', [rt.get_property(var_comment_mutated, 'comment_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'action_log' }, rt.ArrayItem{ key: none, val: 'order_note' }, rt.ArrayItem{ key: none, val: 'webhook_delivery' }]), rt.new_bool(true)])) || rt.is_true(rt.identical(rt.call_function('get_post_type', [rt.get_property(var_comment_mutated, 'comment_post_ID')]), rt.new_string('product')))
}

fn Class_WC_Comments.delete_comments_count_cache()  {
	mut var_comment_status_keys := ['wc_count_comments_approved', 'wc_count_comments_unapproved', 'wc_count_comments_spam', 'wc_count_comments_trash', 'wc_count_comments_post-trashed']
	rt.call_function('wp_cache_delete_multiple', [var_comment_status_keys.dup(), Class_WC_Comments.comment_count_cache_group()])
}

fn Class_WC_Comments.get_products_reviews_pending_moderation_counter() i64 {
	mut var_count := rt.call_function('wp_cache_get', [Class_WC_Comments.product_reviews_pending_count_cache_key(), Class_WC_Comments.comment_count_cache_group()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_count)) {
		var_count = // unsupported expression: Expr_Cast_Int
		rt.call_function('wp_cache_set', [Class_WC_Comments.product_reviews_pending_count_cache_key(), var_count.dup(), Class_WC_Comments.comment_count_cache_group(), rt.get_constant('DAY_IN_SECONDS')])
	}
	return (var_count).to_i64()
}

fn Class_WC_Comments.maybe_bump_products_reviews_pending_moderation_counter(var_comment_id rt.PhpVal, var_comment rt.PhpVal)  {
	mut var_comment_mutated := var_comment
	mut var_needs_bump := rt.identical(rt.new_string('0'), rt.get_property(var_comment_mutated, 'comment_approved'))
	if rt.is_true(rt.new_bool(rt.is_true(var_needs_bump) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_comment_mutated, 'comment_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'review' }, rt.ArrayItem{ key: none, val: 'comment' }, rt.ArrayItem{ key: none, val: '' }]), rt.new_bool(true)])))) {
		mut var_is_product := rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [rt.get_property(var_comment_mutated, 'comment_post_ID')]))
		if rt.is_true(var_is_product) {
			rt.call_function('wp_cache_incr', [Class_WC_Comments.product_reviews_pending_count_cache_key(), rt.new_int(1), Class_WC_Comments.comment_count_cache_group()])
		}
	}
}

fn Class_WC_Comments.maybe_adjust_products_reviews_pending_moderation_counter(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_comment rt.PhpVal)  {
	mut var_comment_mutated := var_comment
	mut var_needs_adjustments := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.new_string('unapproved'), var_new_status)) || rt.is_true(rt.identical(rt.new_string('unapproved'), var_old_status))))
	if rt.is_true(rt.new_bool(rt.is_true(var_needs_adjustments) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_comment_mutated, 'comment_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'review' }, rt.ArrayItem{ key: none, val: 'comment' }, rt.ArrayItem{ key: none, val: '' }]), rt.new_bool(true)])))) {
		mut var_is_product := rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [rt.get_property(var_comment_mutated, 'comment_post_ID')]))
		if rt.is_true(var_is_product) {
			if rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_comment_mutated, 'comment_approved'))) {
				rt.call_function('wp_cache_incr', [Class_WC_Comments.product_reviews_pending_count_cache_key(), rt.new_int(1), Class_WC_Comments.comment_count_cache_group()])
			} else {
				rt.call_function('wp_cache_decr', [Class_WC_Comments.product_reviews_pending_count_cache_key(), rt.new_int(1), Class_WC_Comments.comment_count_cache_group()])
			}
		}
	}
}

fn Class_WC_Comments.wp_count_comments(var_stats rt.PhpVal, var_post_id rt.PhpVal) rt.PhpVal {
	mut var_post_id_mutated := var_post_id
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || !(!rt.is_true(var_stats)))) {
		return var_stats.dup()
	}
	mut var_comment_counts := rt.new_array()
	mut var_stat_key_to_comment_query_status_mapping := { 'approved': 'approve', 'moderated': 'hold', 'spam': 'spam', 'trash': 'trash', 'post-trashed': 'post-trashed' }
	mut var_comment_query_status_to_comment_status_mapping := rt.create_array([rt.ArrayItem{ key: 'approve', val: 'approved' }, rt.ArrayItem{ key: 'hold', val: 'unapproved' }, rt.ArrayItem{ key: 'spam', val: 'spam' }, rt.ArrayItem{ key: 'trash', val: 'trash' }, rt.ArrayItem{ key: 'post-trashed', val: 'post-trashed' }])
	mut var_args := { 'count': rt.new_bool(true), 'update_comment_meta_cache': rt.new_bool(false), 'orderby': rt.new_string('none') }
	for var_stat_key, var_query_status in var_stat_key_to_comment_query_status_mapping {
		mut var_cache_key := rt.new_string('wc_count_comments_' + (var_comment_query_status_to_comment_status_mapping.array_get(query_status)).str())
		mut var_count := rt.call_function('wp_cache_get', [var_cache_key.dup(), Class_WC_Comments.comment_count_cache_group()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_count)) {
			var_count = // unsupported expression: Expr_Cast_Int
			rt.call_function('wp_cache_set', [var_cache_key.dup(), var_count.dup(), Class_WC_Comments.comment_count_cache_group(), rt.mul(rt.new_int(3), rt.get_constant('DAY_IN_SECONDS'))])
		}
		var_comment_counts.array_set(stat_key, // unsupported expression: Expr_Cast_Int)
	}
	var_comment_counts.array_set('all', rt.add(var_comment_counts.array_get('approved'), var_comment_counts.array_get('moderated')))
	var_comment_counts.array_set('total_comments', rt.add(var_comment_counts.array_get('all'), var_comment_counts.array_get('spam')))
	return // unsupported expression: Expr_Cast_Object
}

fn Class_WC_Comments.add_avatar_for_review_comment_type(var_comment_types rt.PhpVal) rt.PhpVal {
	mut var_comment_types_mutated := var_comment_types
	return rt.call_function('array_merge', [var_comment_types_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'review' }])])
}

fn Class_WC_Comments.add_review_comment_filter(mut var_comment_types Class_array) rt.PhpVal {
	mut var_comment_types_mutated := var_comment_types
	var_comment_types_mutated.array_set('review', rt.call_function('__', [rt.new_string('Product Reviews'), rt.new_string('woocommerce')]))
	return rt.new_object('array', []string{}, var_comment_types_mutated)
}

fn Class_WC_Comments.add_comment_purchase_verification(var_comment_id rt.PhpVal) rt.PhpVal {
	mut var_comment := rt.call_function('get_comment', [var_comment_id.dup()])
	mut var_verified := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.identical(rt.new_string('product'), rt.call_function('get_post_type', [rt.get_property(, 'comment_post_ID')]))) {
		mut var_email := if rt.is_true() {  } else {  }
		var_verified = 
		
	}
	return .dup()
}

fn Class_WC_Comments.get_average_rating_for_product(var_product rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_product_mutated := var_product
}

fn Class_WC_Comments.get_review_counts_for_product_ids(var_product_ids rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn Class_WC_Comments.get_review_count_for_product(var_product rt.PhpVal) rt.PhpVal {
	mut var_product_mutated := var_product
}

fn Class_WC_Comments.get_rating_counts_for_product(var_product rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_product_mutated := var_product
}

fn Class_WC_Comments.update_comment_type(var_comment_data rt.PhpVal) rt.PhpVal {
	mut var_comment_data_mutated := var_comment_data
}

fn Class_WC_Comments.validate_product_review_verified_owners(var_comment_post_id rt.PhpVal)  {
}

fn Class_WC_Comments.is_default_comment_type(var_comment_type rt.PhpVal) bool {
}

fn create_wc_comments() &Class_WC_Comments {
	mut obj := &Class_WC_Comments{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Comments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Comments.init()
			return rt.new_null()
		}
		'comments_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Comments.comments_open(dispatch_arg_0, dispatch_arg_1)
		}
		'exclude_order_comments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Comments.exclude_order_comments(dispatch_arg_0)
		}
		'akismet_excluded_comment_types' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Comments.akismet_excluded_comment_types(dispatch_arg_0)
		}
		'exclude_order_comments_from_feed_join' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Comments.exclude_order_comments_from_feed_join(dispatch_arg_0)
			return rt.new_null()
		}
		'exclude_order_comments_from_feed_where' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Comments.exclude_order_comments_from_feed_where(dispatch_arg_0))
		}
		'exclude_webhook_comments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Comments.exclude_webhook_comments(dispatch_arg_0)
		}
		'exclude_webhook_comments_from_feed_join' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Comments.exclude_webhook_comments_from_feed_join(dispatch_arg_0)
			return rt.new_null()
		}
		'exclude_webhook_comments_from_feed_where' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Comments.exclude_webhook_comments_from_feed_where(dispatch_arg_0))
		}
		'exclude_action_log_comments_from_feed_where' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Comments.exclude_action_log_comments_from_feed_where(dispatch_arg_0))
		}
		'exclude_action_log_comments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Comments.exclude_action_log_comments(dispatch_arg_0, dispatch_arg_1)
		}
		'check_comment_rating' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Comments.check_comment_rating(dispatch_arg_0)
		}
		'add_comment_rating' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Comments.add_comment_rating(dispatch_arg_0)
			return rt.new_null()
		}
		'comment_moderation_recipients' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Comments.comment_moderation_recipients(dispatch_arg_0, dispatch_arg_1)
		}
		'clear_transients' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Comments.clear_transients(dispatch_arg_0)
			return rt.new_null()
		}
		'increment_comments_count_cache_on_wp_insert_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Comments.increment_comments_count_cache_on_wp_insert_comment(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_comments_count_cache_on_comment_status_change' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WC_Comments.update_comments_count_cache_on_comment_status_change(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'is_comment_excluded_from_wp_comment_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Comments.is_comment_excluded_from_wp_comment_counts(dispatch_arg_0))
		}
		'delete_comments_count_cache' {
			Class_WC_Comments.delete_comments_count_cache()
			return rt.new_null()
		}
		'get_products_reviews_pending_moderation_counter' {
			return rt.new_int(Class_WC_Comments.get_products_reviews_pending_moderation_counter())
		}
		'maybe_bump_products_reviews_pending_moderation_counter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Comments.maybe_bump_products_reviews_pending_moderation_counter(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'maybe_adjust_products_reviews_pending_moderation_counter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_WC_Comments.maybe_adjust_products_reviews_pending_moderation_counter(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'wp_count_comments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Comments.wp_count_comments(dispatch_arg_0, dispatch_arg_1)
		}
		'add_avatar_for_review_comment_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Comments.add_avatar_for_review_comment_type(dispatch_arg_0)
		}
		'add_review_comment_filter' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_WC_Comments.add_review_comment_filter(mut dispatch_arg_0)
		}
		'add_comment_purchase_verification' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Comments.add_comment_purchase_verification(dispatch_arg_0)
		}
		'get_average_rating_for_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Comments.get_average_rating_for_product(dispatch_arg_0)
		}
		'get_review_counts_for_product_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Comments.get_review_counts_for_product_ids(dispatch_arg_0)
		}
		'get_review_count_for_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Comments.get_review_count_for_product(dispatch_arg_0)
		}
		'get_rating_counts_for_product' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Comments.get_rating_counts_for_product(dispatch_arg_0)
		}
		'update_comment_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Comments.update_comment_type(dispatch_arg_0)
		}
		'validate_product_review_verified_owners' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Comments.validate_product_review_verified_owners(dispatch_arg_0)
			return rt.new_null()
		}
		'is_default_comment_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Comments.is_default_comment_type(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WC_Comments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Comments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_comments_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
