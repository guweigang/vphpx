import rt

struct Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable {
	rt.PhpObjectBase
pub mut:
		current_user_can_edit_review rt.PhpVal = rt.new_bool(false)
		current_user_can_moderate_reviews rt.PhpVal = rt.new_null()
		current_reviews_rating rt.PhpVal = rt.new_int(0)
		current_product_for_reviews rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	this.Class_WP_List_Table.construct(rt.call_function('wp_parse_args', [var_args_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'plural', val: 'product-reviews' }, rt.ArrayItem{ key: 'singular', val: 'product-review' }])]))
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews{}
	mut iife_result_0 := iife_temp_0.get_capability(rt.new_string('moderate'))
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews{}
	mut iife_result_1 := iife_temp_1.get_capability(rt.new_string('moderate'))
	this.current_user_can_moderate_reviews = rt.call_function('current_user_can', [iife_result_0])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) prepare_items() {
	this.set_review_status()
	this.set_review_type()
	this.current_reviews_rating = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('review_rating')) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('review_rating'))]) } else { rt.new_int(0) }
	this.set_review_product()
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'number', val: this.get_per_page() }, rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'update_comment_post_cache', val: true }])
	var_args = rt.call_function('wp_parse_args', [this.get_sort_arguments(), var_args.clone()])
	var_args = rt.call_function('wp_parse_args', [this.get_filter_type_arguments(), var_args.clone()])
	var_args = rt.call_function('wp_parse_args', [this.get_filter_rating_arguments(), var_args.clone()])
	var_args = rt.call_function('wp_parse_args', [this.get_filter_product_arguments(), var_args.clone()])
	var_args = rt.call_function('wp_parse_args', [this.get_status_arguments(), var_args.clone()])
	var_args = rt.call_function('wp_parse_args', [this.get_search_arguments(), var_args.clone()])
	var_args = rt.call_function('wp_parse_args', [this.get_offset_arguments(), var_args.clone()])
	var_args = rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_product_reviews_list_table_prepare_items_args'), var_args.clone()]))
	mut var_comments := rt.call_function('get_comments', [var_args.clone()])
	this.dispatch_set_prop('items', var_comments.clone())
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: rt.call_function('get_comments', [this.get_total_comments_arguments(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_array](var_args))]) }, rt.ArrayItem{ key: 'per_page', val: this.get_per_page() }]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_per_page() i64 {
	return (this.get_items_per_page(rt.new_string('edit_comments_per_page'))).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) set_review_product() {
	mut var_product_id := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('product_id')) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('product_id'))]) } else { rt.new_null() }
	mut var_product := if rt.is_true(var_product_id) { rt.call_function('wc_get_product', [var_product_id.clone()]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product'))) {
		this.current_product_for_reviews = var_product.clone()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) set_review_status() {
	mut var_comment_status := rt.get_superglobal('comment_status')
	var_comment_status = rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('comment_status'))).is_null() { rt.get_superglobal('_REQUEST').array_get(rt.new_string('comment_status')) } else { rt.new_string('all') }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_comment_status.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'moderated' }, rt.ArrayItem{ key: none, val: 'approved' }, rt.ArrayItem{ key: none, val: 'spam' }, rt.ArrayItem{ key: none, val: 'trash' }]), rt.new_bool(true)]))))) {
	var_comment_status = rt.new_string('all')
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) set_review_type() {
	mut var_comment_type := rt.get_superglobal('comment_type')
	mut var_review_type := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('review_type'))).is_null() { rt.get_superglobal('_REQUEST').array_get(rt.new_string('review_type')) } else { rt.new_string('all') }])])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_review_type)))) && !(!rt.is_true(var_review_type)) {
	var_comment_type = var_review_type.clone()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_sort_arguments() rt.PhpVal {
	mut var_orderby := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby'))).is_null() { rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')) } else { rt.new_string('') }])])
	mut var_order := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('order'))).is_null() { rt.get_superglobal('_REQUEST').array_get(rt.new_string('order')) } else { rt.new_string('') }])])
	mut var_args := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_orderby.clone(), this.get_sortable_columns(), rt.new_bool(true)]))))) {
	var_orderby = rt.new_string('comment_date_gmt')
	}
	if rt.is_true(rt.identical(rt.new_string('rating'), var_orderby)) {
		var_orderby = rt.new_string('meta_value_num')
		var_args.array_set('meta_key', 'rating')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(var_order.clone().to_string().to_lower()), rt.create_array([rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'desc' }]), rt.new_bool(true)]))))) {
	var_order = rt.new_string('desc')
	}
	return rt.call_function('wp_parse_args', [rt.create_array([rt.ArrayItem{ key: 'orderby', val: var_orderby }, rt.ArrayItem{ key: 'order', val: var_order.clone().to_string().to_lower() }]), var_args.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_filter_type_arguments() rt.PhpVal {
	mut var_args := rt.new_array()
	mut var_item_type := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('review_type')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('review_type'))])]) } else { rt.new_string('all') }
	if rt.is_true(rt.identical(rt.new_string('all'), var_item_type)) {
		return var_args.clone()
	}
	var_args.array_set('type', var_item_type.clone())
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_filter_rating_arguments() rt.PhpVal {
	mut var_args := rt.new_array()
	if !rt.is_true(this.current_reviews_rating) {
		return var_args.clone()
	}
	var_args.array_set('meta_query', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: 'rating' }, rt.ArrayItem{ key: 'value', val: rt.new_int((this.current_reviews_rating).to_i64()) }, rt.ArrayItem{ key: 'compare', val: '=' }, rt.ArrayItem{ key: 'type', val: 'NUMERIC' }]) }]))
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_filter_product_arguments() rt.PhpVal {
	mut var_args := rt.new_array()
	if rt.is_true(rt.new_bool(rt.instance_of(this.current_product_for_reviews, 'WC_Product'))) {
		var_args.array_set('post_id', rt.call_method(this.current_product_for_reviews, 'get_id', []rt.PhpVal{}))
	}
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_status_arguments() rt.PhpVal {
	mut var_comment_status := rt.new_null()
	mut var_args := rt.new_array()
	if !(!rt.is_true(var_comment_status)) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_comment_status)))) && rt.is_true(rt.new_bool(this.get_status_filters().array_isset(var_comment_status.clone()))) {
		var_args.array_set('status', this.convert_status_to_query_value((var_comment_status).str()))
	}
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_search_arguments() rt.PhpVal {
	mut var_args := rt.new_array()
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')))) {
		var_args.array_set('search', rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))])]))
	}
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_offset_arguments() rt.PhpVal {
	mut var_args := rt.new_array()
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('start')) {
		var_args.array_set('offset', rt.call_function('absint', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('start'))])]))
	} else {
		var_args.array_set('offset', rt.mul(rt.sub(this.get_pagenum(), rt.new_int(1)), this.get_per_page()))
	}
	return var_args.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_total_comments_arguments(mut var_default_query_args Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_array) rt.PhpVal {
	return rt.call_function('wp_parse_args', [rt.create_array([rt.ArrayItem{ key: 'count', val: true }, rt.ArrayItem{ key: 'offset', val: 0 }, rt.ArrayItem{ key: 'number', val: 0 }]), var_default_query_args])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) display() {
	this.display_tablenav(rt.new_string('top'))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable', ['WP_List_Table'], &this), 'screen'), 'render_screen_reader_content', [rt.new_string('heading_list')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), this.get_table_classes()])]))
	// unsupported statement: Stmt_InlineHTML
	this.print_column_headers()
	// unsupported statement: Stmt_InlineHTML
	this.display_rows_or_placeholder()
	// unsupported statement: Stmt_InlineHTML
	this.print_column_headers(rt.new_bool(false))
	// unsupported statement: Stmt_InlineHTML
	this.display_tablenav(rt.new_string('bottom'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) single_row(var_item rt.PhpVal) {
	mut var_post := rt.get_superglobal('post')
	mut var_comment := rt.get_superglobal('comment')
	var_comment = var_item
	mut var_the_comment_class := rt.new_string((rt.call_function('wp_get_comment_status', [rt.get_property(var_comment, 'comment_ID')])).str())
	var_the_comment_class = rt.call_function('implode', [rt.new_string(' '), rt.call_function('get_comment_class', [var_the_comment_class.clone(), rt.get_property(var_comment, 'comment_ID'), rt.get_property(var_comment, 'comment_post_ID')])])
	var_post = rt.call_function('get_post', [rt.get_property(var_comment, 'comment_post_ID')])
	this.current_user_can_edit_review = rt.call_function('current_user_can', [rt.new_string('edit_comment'), rt.get_property(var_comment, 'comment_ID')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_comment, 'comment_ID')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_the_comment_class.clone()]))
	// unsupported statement: Stmt_InlineHTML
	this.single_row_columns(var_comment.clone())
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) handle_row_actions(var_item rt.PhpVal, var_column_name rt.PhpVal, var_primary rt.PhpVal) string {
	mut var_comment_status := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_primary, var_column_name)))) || rt.is_true(rt.new_bool(!(rt.is_true(this.current_user_can_edit_review)))) {
		return ''
	}
	mut var_review_status := rt.call_function('wp_get_comment_status', [var_item.clone()])
	mut var_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'c', val: rt.call_function('urlencode', [rt.get_property(var_item, 'comment_ID')]) }]), rt.call_function('admin_url', [rt.new_string('comment.php')])])
	mut var_approve_url := rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('action'), rt.new_string('approvecomment'), var_url.clone()]), rt.concat(rt.new_string('approve-comment_'), rt.get_property(var_item, 'comment_ID'))])
	mut var_unapprove_url := rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('action'), rt.new_string('unapprovecomment'), var_url.clone()]), rt.concat(rt.new_string('approve-comment_'), rt.get_property(var_item, 'comment_ID'))])
	mut var_spam_url := rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('action'), rt.new_string('spamcomment'), var_url.clone()]), rt.concat(rt.new_string('delete-comment_'), rt.get_property(var_item, 'comment_ID'))])
	mut var_unspam_url := rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('action'), rt.new_string('unspamcomment'), var_url.clone()]), rt.concat(rt.new_string('delete-comment_'), rt.get_property(var_item, 'comment_ID'))])
	mut var_trash_url := rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('action'), rt.new_string('trashcomment'), var_url.clone()]), rt.concat(rt.new_string('delete-comment_'), rt.get_property(var_item, 'comment_ID'))])
	mut var_untrash_url := rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('action'), rt.new_string('untrashcomment'), var_url.clone()]), rt.concat(rt.new_string('delete-comment_'), rt.get_property(var_item, 'comment_ID'))])
	mut var_delete_url := rt.call_function('wp_nonce_url', [rt.call_function('add_query_arg', [rt.new_string('action'), rt.new_string('deletecomment'), var_url.clone()]), rt.concat(rt.new_string('delete-comment_'), rt.get_property(var_item, 'comment_ID'))])
	mut var_actions := rt.create_array([rt.ArrayItem{ key: 'approve', val: '' }, rt.ArrayItem{ key: 'unapprove', val: '' }, rt.ArrayItem{ key: 'reply', val: '' }, rt.ArrayItem{ key: 'quickedit', val: '' }, rt.ArrayItem{ key: 'edit', val: '' }, rt.ArrayItem{ key: 'spam', val: '' }, rt.ArrayItem{ key: 'unspam', val: '' }, rt.ArrayItem{ key: 'trash', val: '' }, rt.ArrayItem{ key: 'untrash', val: '' }, rt.ArrayItem{ key: 'delete', val: '' }])
	if rt.is_true(var_comment_status) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_comment_status)))) {
		if rt.is_true(rt.identical(rt.new_string('approved'), var_review_status)) {
			var_actions.array_set('unapprove', rt.call_function('sprintf', [rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-u vim-destructive aria-button-if-js" aria-label="%s">%s</a>'), rt.call_function('esc_url', [var_unapprove_url.clone()]), rt.call_function('esc_attr', [rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_item, 'comment_ID')), rt.new_string(':e7e7d3:action=dim-comment&amp;new=unapproved'))]), rt.call_function('esc_attr__', [rt.new_string('Unapprove this review'), rt.new_string('woocommerce')]), rt.call_function('esc_html__', [rt.new_string('Unapprove'), rt.new_string('woocommerce')])]))
		} else if rt.is_true(rt.identical(rt.new_string('unapproved'), var_review_status)) {
			var_actions.array_set('approve', rt.call_function('sprintf', [rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-a vim-destructive aria-button-if-js" aria-label="%s">%s</a>'), rt.call_function('esc_url', [var_approve_url.clone()]), rt.call_function('esc_attr', [rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_item, 'comment_ID')), rt.new_string(':e7e7d3:action=dim-comment&amp;new=approved'))]), rt.call_function('esc_attr__', [rt.new_string('Approve this review'), rt.new_string('woocommerce')]), rt.call_function('esc_html__', [rt.new_string('Approve'), rt.new_string('woocommerce')])]))
		}
	} else {
		var_actions.array_set('approve', rt.call_function('sprintf', [rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-a aria-button-if-js" aria-label="%s">%s</a>'), rt.call_function('esc_url', [var_approve_url.clone()]), rt.call_function('esc_attr', [rt.concat(rt.concat(rt.new_string('dim:the-comment-list:comment-'), rt.get_property(var_item, 'comment_ID')), rt.new_string(':unapproved:e7e7d3:e7e7d3:new=approved'))]), rt.call_function('esc_attr__', [rt.new_string('Approve this review'), rt.new_string('woocommerce')]), rt.call_function('esc_html__', [rt.new_string('Approve'), rt.new_string('woocommerce')])]))
		var_actions.array_set('unapprove', rt.call_function('sprintf', [rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-u aria-button-if-js" aria-label="%s">%s</a>'), rt.call_function('esc_url', [var_unapprove_url.clone()]), rt.call_function('esc_attr', [rt.concat(rt.concat(rt.new_string('dim:the-comment-list:comment-'), rt.get_property(var_item, 'comment_ID')), rt.new_string(':unapproved:e7e7d3:e7e7d3:new=unapproved'))]), rt.call_function('esc_attr__', [rt.new_string('Unapprove this review'), rt.new_string('woocommerce')]), rt.call_function('esc_html__', [rt.new_string('Unapprove'), rt.new_string('woocommerce')])]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('spam'), var_review_status)))) {
		var_actions.array_set('spam', rt.call_function('sprintf', [rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-s vim-destructive aria-button-if-js" aria-label="%s">%s</a>'), rt.call_function('esc_url', [var_spam_url.clone()]), rt.call_function('esc_attr', [rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_item, 'comment_ID')), rt.new_string('::spam=1'))]), rt.call_function('esc_attr__', [rt.new_string('Mark this review as spam'), rt.new_string('woocommerce')]), rt.call_function('esc_html_x', [rt.new_string('Spam'), rt.new_string('verb'), rt.new_string('woocommerce')])]))
	} else {
		var_actions.array_set('unspam', rt.call_function('sprintf', [rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-z vim-destructive aria-button-if-js" aria-label="%s">%s</a>'), rt.call_function('esc_url', [var_unspam_url.clone()]), rt.call_function('esc_attr', [rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_item, 'comment_ID')), rt.new_string(':66cc66:unspam=1'))]), rt.call_function('esc_attr__', [rt.new_string('Restore this review from the spam'), rt.new_string('woocommerce')]), rt.call_function('esc_html_x', [rt.new_string('Not Spam'), rt.new_string('review'), rt.new_string('woocommerce')])]))
	}
	if rt.is_true(rt.identical(rt.new_string('trash'), var_review_status)) {
		var_actions.array_set('untrash', rt.call_function('sprintf', [rt.new_string('<a href="%s" data-wp-lists="%s" class="vim-z vim-destructive aria-button-if-js" aria-label="%s">%s</a>'), rt.call_function('esc_url', [var_untrash_url.clone()]), rt.call_function('esc_attr', [rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_item, 'comment_ID')), rt.new_string(':66cc66:untrash=1'))]), rt.call_function('esc_attr__', [rt.new_string('Restore this review from the Trash'), rt.new_string('woocommerce')]), rt.call_function('esc_html__', [rt.new_string('Restore'), rt.new_string('woocommerce')])]))
	}
	if rt.is_true(rt.identical(rt.new_string('spam'), var_review_status)) || rt.is_true(rt.identical(rt.new_string('trash'), var_review_status)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) {
		var_actions.array_set('delete', rt.call_function('sprintf', [rt.new_string('<a href="%s" data-wp-lists="%s" class="delete vim-d vim-destructive aria-button-if-js" aria-label="%s">%s</a>'), rt.call_function('esc_url', [var_delete_url.clone()]), rt.call_function('esc_attr', [rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_item, 'comment_ID')), rt.new_string('::delete=1'))]), rt.call_function('esc_attr__', [rt.new_string('Delete this review permanently'), rt.new_string('woocommerce')]), rt.call_function('esc_html__', [rt.new_string('Delete Permanently'), rt.new_string('woocommerce')])]))
	} else {
		var_actions.array_set('trash', rt.call_function('sprintf', [rt.new_string('<a href="%s" data-wp-lists="%s" class="delete vim-d vim-destructive aria-button-if-js" aria-label="%s">%s</a>'), rt.call_function('esc_url', [var_trash_url.clone()]), rt.call_function('esc_attr', [rt.concat(rt.concat(rt.new_string('delete:the-comment-list:comment-'), rt.get_property(var_item, 'comment_ID')), rt.new_string('::trash=1'))]), rt.call_function('esc_attr__', [rt.new_string('Move this review to the Trash'), rt.new_string('woocommerce')]), rt.call_function('esc_html_x', [rt.new_string('Trash'), rt.new_string('verb'), rt.new_string('woocommerce')])]))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('spam'), var_review_status)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('trash'), var_review_status)))) {
		var_actions.array_set('edit', rt.call_function('sprintf', [rt.new_string('<a href="%s" aria-label="%s">%s</a>'), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'action', val: 'editcomment' }, rt.ArrayItem{ key: 'c', val: rt.call_function('urlencode', [rt.get_property(var_item, 'comment_ID')]) }]), rt.call_function('admin_url', [rt.new_string('comment.php')])])]), rt.call_function('esc_attr__', [rt.new_string('Edit this review'), rt.new_string('woocommerce')]), rt.call_function('esc_html__', [rt.new_string('Edit'), rt.new_string('woocommerce')])]))
		mut var_format := rt.new_string('<button type="button" data-comment-id="%d" data-post-id="%d" data-action="%s" class="%s button-link" aria-expanded="false" aria-label="%s">%s</button>')
		var_actions.array_set('quickedit', rt.call_function('sprintf', [var_format.clone(), rt.call_function('esc_attr', [rt.get_property(var_item, 'comment_ID')]), rt.call_function('esc_attr', [rt.get_property(var_item, 'comment_post_ID')]), rt.new_string('edit'), rt.new_string('vim-q comment-inline'), rt.call_function('esc_attr__', [rt.new_string('Quick edit this review inline'), rt.new_string('woocommerce')]), rt.call_function('esc_html__', [rt.new_string('Quick Edit'), rt.new_string('woocommerce')])]))
		var_actions.array_set('reply', rt.call_function('sprintf', [var_format.clone(), rt.call_function('esc_attr', [rt.get_property(var_item, 'comment_ID')]), rt.call_function('esc_attr', [rt.get_property(var_item, 'comment_post_ID')]), rt.new_string('replyto'), rt.new_string('vim-r comment-inline'), rt.call_function('esc_attr__', [rt.new_string('Reply to this review'), rt.new_string('woocommerce')]), rt.call_function('esc_html__', [rt.new_string('Reply'), rt.new_string('woocommerce')])]))
	}
	var_actions = rt.call_function('apply_filters', [rt.new_string('comment_row_actions'), rt.call_function('array_filter', [var_actions.clone()]), var_item.clone()])
	mut var_always_visible := rt.identical(rt.new_string('excerpt'), rt.call_function('get_user_setting', [rt.new_string('posts_list_mode'), rt.new_string('list')]))
	mut var_output := rt.new_string('<div class="' + if rt.is_true(var_always_visible) { 'row-actions visible' } else { 'row-actions' } + '">')
	mut var_i := rt.new_int(0)
	mut iter_1 := rt.call_function('array_filter', [var_actions.clone()]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_link := item_1.val
		mut var_action := item_1.key
		rt.pre_inc(var_i)
		if (rt.is_true(rt.identical(rt.new_string('approve'), var_action)) || rt.is_true(rt.identical(rt.new_string('unapprove'), var_action)) && rt.is_true(rt.identical(rt.new_int(2), var_i))) || rt.is_true(rt.identical(rt.new_int(1), var_i)) {
		mut var_sep := rt.new_string('')
		} else {
		var_sep = rt.new_string(' | ')
		}
		if rt.is_true(rt.identical(rt.new_string('reply'), var_action)) || rt.is_true(rt.identical(rt.new_string('quickedit'), var_action)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))))) {
			var_action = rt.concat(var_action, rt.new_string(' hide-if-no-js'))
		} else if (rt.is_true(rt.identical(rt.new_string('untrash'), var_action)) && rt.is_true(rt.identical(rt.new_string('trash'), var_review_status))) || (rt.is_true(rt.identical(rt.new_string('unspam'), var_action)) && rt.is_true(rt.identical(rt.new_string('spam'), var_review_status))) {
			if rt.is_true(rt.identical(rt.new_string('1'), rt.call_function('get_comment_meta', [rt.get_property(var_item, 'comment_ID'), rt.new_string('_wp_trash_meta_status'), rt.new_bool(true)]))) {
				var_action = rt.concat(var_action, rt.new_string(' approve'))
			} else {
				var_action = rt.concat(var_action, rt.new_string(' unapprove'))
			}
		}
		var_output = rt.concat(var_output, rt.new_string("<span class='${var_action.to_string()}'>${var_sep.to_string()}${var_link.to_string()}</span>"))
	}
	var_output = rt.concat(var_output, rt.new_string('</div>'))
	var_output = rt.concat(var_output, rt.new_string('<button type="button" class="toggle-row"><span class="screen-reader-text">' + (rt.call_function('esc_html__', [rt.new_string('Show more details'), rt.new_string('woocommerce')])).str() + '</span></button>'))
	return (var_output).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_columns() rt.PhpVal {
	mut var_columns := rt.create_array([rt.ArrayItem{ key: 'cb', val: '<input type="checkbox" />' }, rt.ArrayItem{ key: 'type', val: rt.call_function('_x', [rt.new_string('Type'), rt.new_string('review type'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'author', val: rt.call_function('__', [rt.new_string('Author'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'rating', val: rt.call_function('__', [rt.new_string('Rating'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'comment', val: rt.call_function('_x', [rt.new_string('Review'), rt.new_string('column name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'response', val: rt.call_function('__', [rt.new_string('Product'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'date', val: rt.call_function('_x', [rt.new_string('Submitted on'), rt.new_string('column name'), rt.new_string('woocommerce')]) }])
	return rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_product_reviews_table_columns'), var_columns.clone()]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_primary_column_name() string {
	return 'comment'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_sortable_columns() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'author', val: 'comment_author' }, rt.ArrayItem{ key: 'response', val: 'comment_post_ID' }, rt.ArrayItem{ key: 'date', val: 'comment_date_gmt' }, rt.ArrayItem{ key: 'type', val: 'comment_type' }, rt.ArrayItem{ key: 'rating', val: 'rating' }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_bulk_actions() rt.PhpVal {
	mut var_comment_status := rt.new_null()
	mut var_actions := rt.new_array()
	if rt.is_true(rt.call_function('in_array', [var_comment_status.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'approved' }]), rt.new_bool(true)])) {
		var_actions.array_set('unapprove', rt.call_function('__', [rt.new_string('Unapprove'), rt.new_string('woocommerce')]))
	}
	if rt.is_true(rt.call_function('in_array', [var_comment_status.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'moderated' }]), rt.new_bool(true)])) {
		var_actions.array_set('approve', rt.call_function('__', [rt.new_string('Approve'), rt.new_string('woocommerce')]))
	}
	if rt.is_true(rt.call_function('in_array', [var_comment_status.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'moderated' }, rt.ArrayItem{ key: none, val: 'approved' }, rt.ArrayItem{ key: none, val: 'trash' }]), rt.new_bool(true)])) {
		var_actions.array_set('spam', rt.call_function('_x', [rt.new_string('Mark as spam'), rt.new_string('review'), rt.new_string('woocommerce')]))
	}
	if rt.is_true(rt.identical(rt.new_string('trash'), var_comment_status)) {
		var_actions.array_set('untrash', rt.call_function('__', [rt.new_string('Restore'), rt.new_string('woocommerce')]))
	} else if rt.is_true(rt.identical(rt.new_string('spam'), var_comment_status)) {
		var_actions.array_set('unspam', rt.call_function('_x', [rt.new_string('Not spam'), rt.new_string('review'), rt.new_string('woocommerce')]))
	}
	if rt.is_true(rt.call_function('in_array', [var_comment_status.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'trash' }, rt.ArrayItem{ key: none, val: 'spam' }]), rt.new_bool(true)])) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) {
		var_actions.array_set('delete', rt.call_function('__', [rt.new_string('Delete permanently'), rt.new_string('woocommerce')]))
	} else {
		var_actions.array_set('trash', rt.call_function('__', [rt.new_string('Move to Trash'), rt.new_string('woocommerce')]))
	}
	return var_actions.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) current_action() string {
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('delete_all')) || rt.get_superglobal('_REQUEST').array_isset(rt.new_string('delete_all2')) {
		return 'delete_all'
	}
	return (this.Class_WP_List_Table.current_action()).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) process_bulk_action() {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.current_user_can_moderate_reviews)))) {
		return
	}
	if rt.is_true(this.current_action()) {
		rt.call_function('check_admin_referer', [rt.new_string('bulk-product-reviews')])
		mut var_query_string := rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: '_wpnonce' }]), rt.call_function('wp_unslash', [if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('QUERY_STRING'))).is_null() { rt.get_superglobal('_SERVER').array_get(rt.new_string('QUERY_STRING')) } else { rt.new_string('') }])])
		mut var_comments_nonce := rt.call_function('wp_create_nonce', [rt.new_string('bulk-comments')])
		var_query_string = rt.call_function('add_query_arg', [rt.new_string('_wpnonce'), var_comments_nonce.clone(), var_query_string.clone()])
		rt.call_function('wp_safe_redirect', [rt.call_function('esc_url_raw', [rt.call_function('admin_url', [rt.new_string('edit-comments.php?' + (var_query_string).str())])])])
		exit(0)
	} else if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('_wp_http_referer')))) {
		rt.call_function('wp_safe_redirect', [rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: '_wp_http_referer' }, rt.ArrayItem{ key: none, val: '_wpnonce' }])])])
		exit(0)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_status_filters() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'all', val: rt.call_function('_nx_noop', [rt.new_string('All <span class="count">(%s)</span>'), rt.new_string('All <span class="count">(%s)</span>'), rt.new_string('product reviews'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'moderated', val: rt.call_function('_nx_noop', [rt.new_string('Pending <span class="count">(%s)</span>'), rt.new_string('Pending <span class="count">(%s)</span>'), rt.new_string('product reviews'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'approved', val: rt.call_function('_nx_noop', [rt.new_string('Approved <span class="count">(%s)</span>'), rt.new_string('Approved <span class="count">(%s)</span>'), rt.new_string('product reviews'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'spam', val: rt.call_function('_nx_noop', [rt.new_string('Spam <span class="count">(%s)</span>'), rt.new_string('Spam <span class="count">(%s)</span>'), rt.new_string('product reviews'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'trash', val: rt.call_function('_nx_noop', [rt.new_string('Trash <span class="count">(%s)</span>'), rt.new_string('Trash <span class="count">(%s)</span>'), rt.new_string('product reviews'), rt.new_string('woocommerce')]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_views() rt.PhpVal {
	mut var_post_id := rt.new_null()
	mut var_comment_status := rt.new_null()
	mut var_comment_type := rt.new_null()
	mut var_status_links := rt.new_array()
	mut var_status_labels := this.get_status_filters()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) {
		var_status_labels.array_unset(rt.new_string('trash'))
	}
	mut var_link := rt.new_string(this.get_view_url((var_comment_type).str(), rt.new_int((var_post_id).to_i64())))
	mut iter_2 := var_status_labels.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_label := item_2.val
		mut var_status := item_2.key
		mut var_current_link_attributes := rt.new_string('')
		if rt.is_true(rt.identical(var_status, var_comment_status)) {
		var_current_link_attributes = rt.new_string(' class="current" aria-current="page"')
		}
		var_link = rt.call_function('add_query_arg', [rt.new_string('comment_status'), rt.call_function('urlencode', [var_status.clone()]), var_link.clone()])
		mut var_number_reviews_for_status := rt.new_int(this.get_review_count((var_status).str(), rt.new_int((var_post_id).to_i64())))
		mut var_count_html := rt.call_function('sprintf', [rt.new_string('<span class="%s-count">%s</span>'), if rt.is_true(rt.identical(rt.new_string('moderated'), var_status)) { rt.new_string('pending') } else { var_status }, rt.call_function('number_format_i18n', [var_number_reviews_for_status.clone()])])
		var_status_links.array_set(var_status, '<a href="' + (rt.call_function('esc_url', [var_link.clone()])).str() + '"' + (var_current_link_attributes).str() + '>' + (rt.call_function('sprintf', [rt.call_function('translate_nooped_plural', [var_label.clone(), var_number_reviews_for_status.clone()]), var_count_html.clone()])).str() + '</a>')
	}
	return var_status_links.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_view_url(comment_type string, post_id i64) string {
	mut comment_type_mutated := comment_type
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews{}
	mut iife_result_2 := iife_temp_2.get_reviews_page_url()
	mut var_link := iife_result_2
	if !(comment_type_mutated == '') && rt.is_true(rt.new_bool('all' != comment_type_mutated)) {
	var_link = rt.call_function('add_query_arg', [rt.new_string('comment_type'), rt.call_function('urlencode', [rt.new_string(comment_type_mutated).clone()]), var_link.clone()])
	}
	if !(post_id == 0) {
	var_link = rt.call_function('add_query_arg', [rt.new_string('p'), rt.call_function('absint', [rt.new_int(post_id)]), var_link.clone()])
	}
	return (var_link).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_review_count(status string, product_id i64) i64 {
	mut product_id_mutated := product_id
	return rt.new_int((rt.call_function('get_comments', [rt.create_array([rt.ArrayItem{ key: 'type__in', val: rt.create_array([rt.ArrayItem{ key: none, val: 'review' }, rt.ArrayItem{ key: none, val: 'comment' }]) }, rt.ArrayItem{ key: 'status', val: this.convert_status_to_query_value(status) }, rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'post_id', val: product_id_mutated }, rt.ArrayItem{ key: 'count', val: true }])])).to_i64())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) convert_status_to_query_value(status string) string {
	if rt.is_true(rt.call_function('in_array', [rt.new_string(status), rt.create_array([rt.ArrayItem{ key: none, val: 'spam' }, rt.ArrayItem{ key: none, val: 'trash' }]), rt.new_bool(true)])) {
		return status
	}
	mut switch_val_1 := rt.new_string(status)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('moderated'))) {
		return '0'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('approved'))) {
		return '1'
	} else {
		return 'all'
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) no_items() {
	mut var_comment_status := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('moderated'), var_comment_status)) {
		rt.call_function('esc_html_e', [rt.new_string('No reviews awaiting moderation.'), rt.new_string('woocommerce')])
	} else {
		rt.call_function('esc_html_e', [rt.new_string('No reviews found.'), rt.new_string('woocommerce')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_cb(var_item rt.PhpVal) {
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.is_true(this.current_user_can_edit_review) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_item, 'comment_ID')]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Select review'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_item, 'comment_ID')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_item, 'comment_ID')]))
		// unsupported statement: Stmt_InlineHTML
	}
	print(this.filter_column_output(rt.new_string('cb'), rt.call_function('ob_get_clean', []rt.PhpVal{}), var_item.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_comment(var_item rt.PhpVal) {
	mut var_in_reply_to := rt.new_string(this.get_in_reply_to_review_text(var_item.clone()))
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.is_true(var_in_reply_to) {
		print((var_in_reply_to).str() + '<br><br>')
	}
	print('<div class="comment-text">')
	rt.call_function('comment_text', [rt.get_property(var_item, 'comment_ID')])
	print('</div>')
	if rt.is_true(this.current_user_can_edit_review) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_item, 'comment_ID')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_textarea', [rt.get_property(var_item, 'comment_content')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_item, 'comment_author_email')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_item, 'comment_author')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_item, 'comment_author_url')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_item, 'comment_approved')]))
		// unsupported statement: Stmt_InlineHTML
	}
	print(this.filter_column_output(rt.new_string('comment'), rt.call_function('ob_get_clean', []rt.PhpVal{}), var_item.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_in_reply_to_review_text(var_reply rt.PhpVal) string {
	mut var_review := if rt.is_true(rt.get_property(var_reply, 'comment_parent')) { rt.call_function('get_comment', [rt.get_property(var_reply, 'comment_parent')]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_review)))) {
		return ''
	}
	mut var_parent_review_link := rt.call_function('get_comment_link', [var_review.clone()])
	mut var_review_author_name := rt.call_function('get_comment_author', [var_review.clone()])
	return (rt.call_function('sprintf', [rt.call_function('ent2ncr', [rt.call_function('__', [rt.new_string('In reply to %s.'), rt.new_string('woocommerce')])]), rt.new_string('<a href="' + (rt.call_function('esc_url', [var_parent_review_link.clone()])).str() + '">' + (rt.call_function('esc_html', [var_review_author_name.clone()])).str() + '</a>')])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_author(var_item rt.PhpVal) {
	mut var_comment_status := rt.new_null()
	mut var_author_url := rt.new_string(this.get_item_author_url())
	mut var_author_url_display := rt.new_string(this.get_item_author_url_for_display(var_author_url.clone()))
	if rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')])) {
	mut var_author_avatar := rt.call_function('get_avatar', [var_item.clone(), rt.new_int(32), rt.new_string('mystery')])
	} else {
	var_author_avatar = rt.new_string('')
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	print('<strong>' + (var_author_avatar).str())
	rt.call_function('comment_author', []rt.PhpVal{})
	print('</strong><br>')
	if !(!rt.is_true(var_author_url)) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_author_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_author_url.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_author_url_display.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	if rt.is_true(this.current_user_can_edit_review) {
		if !(!rt.is_true(rt.get_property(var_item, 'comment_author_email'))) && rt.is_true(rt.call_function('is_email', [rt.get_property(var_item, 'comment_author_email')])) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_item, 'comment_author_email')]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_item, 'comment_author_email')]))
			// unsupported statement: Stmt_InlineHTML
		}
		mut var_link := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 's', val: rt.call_function('urlencode', [rt.call_function('get_comment_author_IP', [rt.get_property(var_item, 'comment_ID')])]) }, rt.ArrayItem{ key: 'page', val: Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews.menu_slug() }, rt.ArrayItem{ key: 'mode', val: 'detail' }]), rt.new_string('admin.php')])
		if rt.is_true(rt.identical(rt.new_string('spam'), var_comment_status)) {
		var_link = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'comment_status', val: 'spam' }]), var_link.clone()])
		}
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [var_link.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('comment_author_IP', [rt.get_property(var_item, 'comment_ID')])
		// unsupported statement: Stmt_InlineHTML
	}
	print(this.filter_column_output(rt.new_string('author'), rt.call_function('ob_get_clean', []rt.PhpVal{}), var_item.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_item_author_url() string {
	mut var_author_url := rt.call_function('get_comment_author_url', []rt.PhpVal{})
	mut var_protocols := rt.create_array([rt.ArrayItem{ key: none, val: 'https://' }, rt.ArrayItem{ key: none, val: 'http://' }])
	if rt.is_true(rt.call_function('in_array', [var_author_url.clone(), var_protocols.clone()])) {
	var_author_url = rt.new_string('')
	}
	return (var_author_url).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_item_author_url_for_display(var_author_url rt.PhpVal) string {
	mut var_author_url_mutated := var_author_url
	mut var_author_url_display := rt.call_function('untrailingslashit', [rt.call_function('preg_replace', [rt.new_string('|^http(s)?://(www\\.)?|i'), rt.new_string(''), var_author_url_mutated.clone()])])
	if var_author_url_display.clone().to_string().len > 50 {
	var_author_url_display = rt.call_function('wp_html_excerpt', [var_author_url_display.clone(), rt.new_int(49), rt.new_string('&hellip;')])
	}
	return (var_author_url_display).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_date(var_item rt.PhpVal) {
	mut var_submitted := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s at %2$s'), rt.new_string('woocommerce')]), rt.call_function('get_comment_date', [rt.call_function('__', [rt.new_string('Y/m/d'), rt.new_string('woocommerce')]), var_item.clone()]), rt.call_function('get_comment_date', [rt.call_function('__', [rt.new_string('g:i a'), rt.new_string('woocommerce')]), var_item.clone()])])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('approved'), rt.call_function('wp_get_comment_status', [var_item.clone()]))) && !(!rt.is_true(rt.get_property(var_item, 'comment_post_ID'))) {
		rt.call_function('printf', [rt.new_string('<a href="%1$s">%2$s</a>'), rt.call_function('esc_url', [rt.call_function('get_comment_link', [var_item.clone()])]), rt.call_function('esc_html', [var_submitted.clone()])])
	} else {
		rt.echo_val(rt.call_function('esc_html', [var_submitted.clone()]))
	}
	// unsupported statement: Stmt_InlineHTML
	print(this.filter_column_output(rt.new_string('date'), rt.call_function('ob_get_clean', []rt.PhpVal{}), var_item.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_response(var_item rt.PhpVal) {
	mut var_product_post := rt.call_function('get_post', []rt.PhpVal{})
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.is_true(var_product_post) {
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_product'), rt.get_property(var_product_post, 'ID')])) {
			mut var_post_link := rt.new_string('<a href=\'' + (rt.call_function('esc_url', [rt.call_function('get_edit_post_link', [rt.get_property(var_product_post, 'ID')])])).str() + '\' class=\'comments-edit-item-link\'>')
			var_post_link = rt.concat(var_post_link, rt.new_string((rt.call_function('esc_html', [rt.call_function('get_the_title', [rt.get_property(var_product_post, 'ID')])])).str() + '</a>'))
		} else {
		var_post_link = rt.call_function('esc_html', [rt.call_function('get_the_title', [rt.get_property(var_product_post, 'ID')])])
		}
		rt.echo_val(var_post_link)
		mut var_post_type_object := rt.call_function('get_post_type_object', [rt.get_property(var_product_post, 'post_type')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [rt.call_function('get_permalink', [rt.get_property(var_product_post, 'ID')])]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [rt.get_property(rt.get_property(var_post_type_object, 'labels'), 'view_item')]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_product_post, 'ID')]))
		// unsupported statement: Stmt_InlineHTML
		this.comments_bubble(rt.get_property(var_product_post, 'ID'), rt.call_function('get_pending_comments_num', [rt.get_property(var_product_post, 'ID')]))
		// unsupported statement: Stmt_InlineHTML
	}
	print(this.filter_column_output(rt.new_string('response'), rt.call_function('ob_get_clean', []rt.PhpVal{}), var_item.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_type(var_item rt.PhpVal) {
	mut var_type := if rt.is_true(rt.identical(rt.new_string('review'), rt.get_property(var_item, 'comment_type'))) { '&#9734;&nbsp;' + (rt.call_function('__', [rt.new_string('Review'), rt.new_string('woocommerce')])).str() } else { rt.call_function('__', [rt.new_string('Reply'), rt.new_string('woocommerce')]) }
	print(this.filter_column_output(rt.new_string('type'), rt.call_function('esc_html', [var_type.clone()]), var_item.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_rating(var_item rt.PhpVal) {
	mut var_rating := rt.call_function('get_comment_meta', [rt.get_property(var_item, 'comment_ID'), rt.new_string('rating'), rt.new_bool(true)])
	rt.call_function('ob_start', []rt.PhpVal{})
	if !(!rt.is_true(var_rating)) && var_rating.clone().is_long() || var_rating.clone().is_double() {
		var_rating = rt.new_int((var_rating).to_i64())
		mut var_accessibility_label := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$d out of 5'), rt.new_string('woocommerce')]), var_rating.clone()])
		mut var_stars := rt.call_function('str_repeat', [rt.new_string('&#9733;'), var_rating.clone()])
		var_stars = rt.concat(var_stars, rt.call_function('str_repeat', [rt.new_string('&#9734;'), rt.sub(rt.new_int(5), var_rating)]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_accessibility_label.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_stars.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	print(this.filter_column_output(rt.new_string('rating'), rt.call_function('ob_get_clean', []rt.PhpVal{}), var_item.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal) {
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('woocommerce_product_reviews_table_column_' + (var_column_name).str()), var_item.clone()])
	print(this.filter_column_output(var_column_name.clone(), rt.call_function('ob_get_clean', []rt.PhpVal{}), var_item.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) filter_column_output(var_column_name rt.PhpVal, var_output rt.PhpVal, var_item rt.PhpVal) string {
	mut var_output_mutated := var_output
	return (rt.call_function('apply_filters', [rt.new_string('woocommerce_product_reviews_table_column_' + (var_column_name).str() + '_content'), var_output_mutated.clone(), var_item.clone()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) extra_tablenav(var_which rt.PhpVal) {
	mut var_comment_status := rt.new_null()
	mut var_comment_type := rt.new_null()
	print('<div class="alignleft actions">')
	if rt.is_true(rt.identical(rt.new_string('top'), var_which)) {
		rt.call_function('ob_start', []rt.PhpVal{})
		print('<input type="hidden" name="comment_status" value="' + (rt.call_function('esc_attr', [if !(var_comment_status).is_null() { var_comment_status } else { rt.new_string('all') }])).str() + '" />')
		this.review_type_dropdown(var_comment_type.clone())
		this.review_rating_dropdown(this.current_reviews_rating)
		this.product_search(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_?WC_Product](this.current_product_for_reviews))
		rt.echo_val(rt.call_function('ob_get_clean', []rt.PhpVal{}))
		rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Filter'), rt.new_string('woocommerce')]), rt.new_string(''), rt.new_string('filter_action'), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'id', val: 'post-query-submit' }])])
	}
	if rt.is_true(rt.identical(rt.new_string('spam'), var_comment_status)) || rt.is_true(rt.identical(rt.new_string('trash'), var_comment_status)) && rt.is_true(this.has_items()) && rt.is_true(this.current_user_can_moderate_reviews) {
		rt.call_function('wp_nonce_field', [rt.new_string('bulk-destroy'), rt.new_string('_destroy_nonce')])
		mut var_title := if rt.is_true(rt.identical(rt.new_string('spam'), var_comment_status)) { rt.call_function('esc_attr__', [rt.new_string('Empty Spam'), rt.new_string('woocommerce')]) } else { rt.call_function('esc_attr__', [rt.new_string('Empty Trash'), rt.new_string('woocommerce')]) }
		rt.call_function('submit_button', [var_title.clone(), rt.new_string('apply'), rt.new_string('delete_all'), rt.new_bool(false)])
	}
	print('</div>')
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) review_type_dropdown(var_current_type rt.PhpVal) {
	mut var_item_types := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_reviews_list_table_item_types'), rt.create_array([rt.ArrayItem{ key: 'all', val: rt.call_function('__', [rt.new_string('All types'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'comment', val: rt.call_function('__', [rt.new_string('Replies'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'review', val: rt.call_function('__', [rt.new_string('Reviews'), rt.new_string('woocommerce')]) }])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Filter by review type'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_3 := var_item_types.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_label := item_3.val
		mut var_type := item_3.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_type.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_type.clone(), var_current_type.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_label.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) review_rating_dropdown(var_current_rating rt.PhpVal) {
	mut var_rating_options := rt.create_array([rt.ArrayItem{ key: '0', val: rt.call_function('__', [rt.new_string('All ratings'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: '1', val: '&#9733;' }, rt.ArrayItem{ key: '2', val: '&#9733;&#9733;' }, rt.ArrayItem{ key: '3', val: '&#9733;&#9733;&#9733;' }, rt.ArrayItem{ key: '4', val: '&#9733;&#9733;&#9733;&#9733;' }, rt.ArrayItem{ key: '5', val: '&#9733;&#9733;&#9733;&#9733;&#9733;' }])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Filter by review rating'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_4 := var_rating_options.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_label := item_4.val
		mut var_rating := item_4.key
		// unsupported statement: Stmt_InlineHTML
		mut var_title := if 0 == rt.new_int((var_rating).to_i64()) { var_label } else { rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s-star rating'), rt.new_string('woocommerce')]), var_rating.clone()]) }
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_rating.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [var_rating.clone(), rt.new_string((var_current_rating).str())])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_title.clone()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_label.clone()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) product_search(mut var_current_product Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_?WC_Product) {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Filter by product'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Search for a product&hellip;'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_?WC_Product', []string{}, var_current_product), 'WC_Product'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_current_product.get_id()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [var_current_product.get_formatted_name()]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) comments_bubble(var_post_id rt.PhpVal, var_pending_comments rt.PhpVal) {
	mut var_approved_review_count := rt.call_function('get_comments_number', []rt.PhpVal{})
	mut var_approved_reviews_number := rt.call_function('number_format_i18n', [var_approved_review_count.clone()])
	mut var_pending_reviews_number := rt.call_function('number_format_i18n', [var_pending_comments.clone()])
	mut var_approved_only_phrase := rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s review'), rt.new_string('%s reviews'), var_approved_review_count.clone(), rt.new_string('woocommerce')]), var_approved_reviews_number.clone()])
	mut var_approved_phrase := rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s approved review'), rt.new_string('%s approved reviews'), var_approved_review_count.clone(), rt.new_string('woocommerce')]), var_approved_reviews_number.clone()])
	mut var_pending_phrase := rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s pending review'), rt.new_string('%s pending reviews'), var_pending_comments.clone(), rt.new_string('woocommerce')]), var_pending_reviews_number.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_approved_review_count)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_pending_comments)))) {
		rt.call_function('printf', [rt.new_string('<span aria-hidden="true">&#8212;</span><span class="screen-reader-text">%s</span>'), rt.call_function('esc_html__', [rt.new_string('No reviews'), rt.new_string('woocommerce')])])
	} else if rt.is_true(var_approved_review_count) && rt.is_true(rt.identical(rt.new_string('trash'), rt.call_function('get_post_status', [var_post_id.clone()]))) {
		rt.call_function('printf', [rt.new_string('<span class="post-com-count post-com-count-approved"><span class="comment-count-approved" aria-hidden="true">%s</span><span class="screen-reader-text">%s</span></span>'), rt.call_function('esc_html', [var_approved_reviews_number.clone()]), if rt.is_true(var_pending_comments) { rt.call_function('esc_html', [var_approved_phrase.clone()]) } else { rt.call_function('esc_html', [var_approved_only_phrase.clone()]) }])
	} else if rt.is_true(var_approved_review_count) {
		mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews{}
		mut iife_result_3 := iife_temp_3.get_reviews_page_url()
		mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews{}
		mut iife_result_4 := iife_temp_4.get_reviews_page_url()
		rt.call_function('printf', [rt.new_string('<a href="%s" class="post-com-count post-com-count-approved"><span class="comment-count-approved" aria-hidden="true">%s</span><span class="screen-reader-text">%s</span></a>'), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.call_function('urlencode', [var_post_id.clone()]) }, rt.ArrayItem{ key: 'comment_status', val: 'approved' }]), iife_result_3])]), rt.call_function('esc_html', [var_approved_reviews_number.clone()]), if rt.is_true(var_pending_comments) { rt.call_function('esc_html', [var_approved_phrase.clone()]) } else { rt.call_function('esc_html', [var_approved_only_phrase.clone()]) }])
	} else {
		rt.call_function('printf', [rt.new_string('<span class="post-com-count post-com-count-no-comments"><span class="comment-count comment-count-no-comments" aria-hidden="true">%s</span><span class="screen-reader-text">%s</span></span>'), rt.call_function('esc_html', [var_approved_reviews_number.clone()]), if rt.is_true(var_pending_comments) { rt.call_function('esc_html__', [rt.new_string('No approved reviews'), rt.new_string('woocommerce')]) } else { rt.call_function('esc_html__', [rt.new_string('No reviews'), rt.new_string('woocommerce')]) }])
	}
	if rt.is_true(var_pending_comments) {
		mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews{}
		mut iife_result_5 := iife_temp_5.get_reviews_page_url()
		mut iife_temp_6 := Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews{}
		mut iife_result_6 := iife_temp_6.get_reviews_page_url()
		rt.call_function('printf', [rt.new_string('<a href="%s" class="post-com-count post-com-count-pending"><span class="comment-count-pending" aria-hidden="true">%s</span><span class="screen-reader-text">%s</span></a>'), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'product_id', val: rt.call_function('urlencode', [var_post_id.clone()]) }, rt.ArrayItem{ key: 'comment_status', val: 'moderated' }]), iife_result_5])]), rt.call_function('esc_html', [var_pending_reviews_number.clone()]), rt.call_function('esc_html', [var_pending_phrase.clone()])])
	} else {
		rt.call_function('printf', [rt.new_string('<span class="post-com-count post-com-count-pending post-com-count-no-pending"><span class="comment-count comment-count-no-pending" aria-hidden="true">%s</span><span class="screen-reader-text">%s</span></span>'), rt.call_function('esc_html', [var_pending_reviews_number.clone()]), if rt.is_true(var_approved_review_count) { rt.call_function('esc_html__', [rt.new_string('No pending reviews'), rt.new_string('woocommerce')]) } else { rt.call_function('esc_html__', [rt.new_string('No reviews'), rt.new_string('woocommerce')]) }])
	}
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_productreviews_reviewslisttable(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable{
		PhpObjectBase: rt.PhpObjectBase{}
		current_user_can_edit_review: rt.new_bool(false)
		current_user_can_moderate_reviews: rt.new_null()
		current_reviews_rating: rt.new_int(0)
		current_product_for_reviews: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_list_table(_args ...rt.PhpVal) &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_productreviews_reviews(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'get_per_page' {
			return rt.new_int(this.get_per_page())
		}
		'set_review_product' {
			this.set_review_product()
			return rt.new_null()
		}
		'set_review_status' {
			this.set_review_status()
			return rt.new_null()
		}
		'set_review_type' {
			this.set_review_type()
			return rt.new_null()
		}
		'get_sort_arguments' {
			return this.get_sort_arguments()
		}
		'get_filter_type_arguments' {
			return this.get_filter_type_arguments()
		}
		'get_filter_rating_arguments' {
			return this.get_filter_rating_arguments()
		}
		'get_filter_product_arguments' {
			return this.get_filter_product_arguments()
		}
		'get_status_arguments' {
			return this.get_status_arguments()
		}
		'get_search_arguments' {
			return this.get_search_arguments()
		}
		'get_offset_arguments' {
			return this.get_offset_arguments()
		}
		'get_total_comments_arguments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_total_comments_arguments(mut dispatch_arg_0)
		}
		'display' {
			this.display()
			return rt.new_null()
		}
		'single_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.single_row(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_row_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.handle_row_actions(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_columns' {
			return this.get_columns()
		}
		'get_primary_column_name' {
			return rt.new_string(this.get_primary_column_name())
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'current_action' {
			return rt.new_string(this.current_action())
		}
		'process_bulk_action' {
			this.process_bulk_action()
			return rt.new_null()
		}
		'get_status_filters' {
			return this.get_status_filters()
		}
		'get_views' {
			return this.get_views()
		}
		'get_view_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.get_view_url(dispatch_arg_0, dispatch_arg_1))
		}
		'get_review_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.get_review_count(dispatch_arg_0, dispatch_arg_1))
		}
		'convert_status_to_query_value' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.convert_status_to_query_value(dispatch_arg_0))
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_cb(dispatch_arg_0)
			return rt.new_null()
		}
		'column_comment' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_comment(dispatch_arg_0)
			return rt.new_null()
		}
		'get_in_reply_to_review_text' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_in_reply_to_review_text(dispatch_arg_0))
		}
		'column_author' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_author(dispatch_arg_0)
			return rt.new_null()
		}
		'get_item_author_url' {
			return rt.new_string(this.get_item_author_url())
		}
		'get_item_author_url_for_display' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_item_author_url_for_display(dispatch_arg_0))
		}
		'column_date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_date(dispatch_arg_0)
			return rt.new_null()
		}
		'column_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_response(dispatch_arg_0)
			return rt.new_null()
		}
		'column_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_type(dispatch_arg_0)
			return rt.new_null()
		}
		'column_rating' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_rating(dispatch_arg_0)
			return rt.new_null()
		}
		'column_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.column_default(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'filter_column_output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.filter_column_output(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'extra_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.extra_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'review_type_dropdown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.review_type_dropdown(dispatch_arg_0)
			return rt.new_null()
		}
		'review_rating_dropdown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.review_rating_dropdown(dispatch_arg_0)
			return rt.new_null()
		}
		'product_search' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_?WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			this.product_search(mut dispatch_arg_0)
			return rt.new_null()
		}
		'comments_bubble' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.comments_bubble(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'current_user_can_edit_review' { return this.current_user_can_edit_review }
		'current_user_can_moderate_reviews' { return this.current_user_can_moderate_reviews }
		'current_reviews_rating' { return this.current_reviews_rating }
		'current_product_for_reviews' { return this.current_product_for_reviews }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'current_user_can_edit_review' { this.current_user_can_edit_review = val; return true }
		'current_user_can_moderate_reviews' { this.current_user_can_moderate_reviews = val; return true }
		'current_reviews_rating' { this.current_reviews_rating = val; return true }
		'current_product_for_reviews' { this.current_product_for_reviews = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
