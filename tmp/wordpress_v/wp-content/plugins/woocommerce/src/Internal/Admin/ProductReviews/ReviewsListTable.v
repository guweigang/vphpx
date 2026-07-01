import rt

struct Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable {
	rt.PhpObjectBase
pub mut:
		current_user_can_edit_review rt.PhpVal = rt.new_bool(false)
		current_user_can_moderate_reviews rt.PhpVal = rt.new_null()
		current_reviews_rating rt.PhpVal = rt.new_int(0)
		current_product_for_reviews rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) construct(var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	this.Class_WP_List_Table.construct(rt.call_function('wp_parse_args', [var_args_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'plural', val: 'product-reviews' }, rt.ArrayItem{ key: 'singular', val: 'product-review' }])]))
	this.current_user_can_moderate_reviews = rt.call_function('current_user_can', [fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews{}; return temp.get_capability(arg_0) }(rt.new_string('moderate'))])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) prepare_items()  {
	this.set_review_status()
	this.set_review_type()
	this.current_reviews_rating = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('review_rating')) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('review_rating')]) } else { rt.new_int(0) }
	this.set_review_product()
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'number', val: this.get_per_page() }, rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'update_comment_post_cache', val: true }])
	var_args = rt.call_function('wp_parse_args', [this.get_sort_arguments(), var_args.dup()])
	var_args = rt.call_function('wp_parse_args', [this.get_filter_type_arguments(), var_args.dup()])
	var_args = rt.call_function('wp_parse_args', [this.get_filter_rating_arguments(), var_args.dup()])
	var_args = rt.call_function('wp_parse_args', [this.get_filter_product_arguments(), var_args.dup()])
	var_args = rt.call_function('wp_parse_args', [this.get_status_arguments(), var_args.dup()])
	var_args = rt.call_function('wp_parse_args', [this.get_search_arguments(), var_args.dup()])
	var_args = rt.call_function('wp_parse_args', [this.get_offset_arguments(), var_args.dup()])
	var_args = rt.cast_array(rt.call_function('apply_filters', [rt.new_string('woocommerce_product_reviews_list_table_prepare_items_args'), var_args.dup()]))
	mut var_comments := rt.call_function('get_comments', [var_args.dup()])
	this.dispatch_set_prop('items', var_comments.dup())
	this.set_pagination_args(rt.create_array([rt.ArrayItem{ key: 'total_items', val: rt.call_function('get_comments', [this.get_total_comments_arguments(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_array](var_args))]) }, rt.ArrayItem{ key: 'per_page', val: this.get_per_page() }]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_per_page() i64 {
	return (this.get_items_per_page(rt.new_string('edit_comments_per_page'))).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) set_review_product()  {
	mut var_product_id := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('product_id')) { rt.call_function('absint', [rt.get_superglobal('_REQUEST').array_get('product_id')]) } else { rt.new_null() }
	mut var_product := if rt.is_true(var_product_id) { rt.call_function('wc_get_product', [var_product_id.dup()]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.instance_of(var_product, 'WC_Product'))) {
		this.current_product_for_reviews = var_product.dup()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) set_review_status()  {
	// unsupported statement: Stmt_Global
	mut var_comment_status := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get('comment_status')).is_null() { rt.get_superglobal('_REQUEST').array_get('comment_status') } else { rt.new_string('all') }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_comment_status.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'moderated' }, rt.ArrayItem{ key: none, val: 'approved' }, rt.ArrayItem{ key: none, val: 'spam' }, rt.ArrayItem{ key: none, val: 'trash' }]), rt.new_bool(true)]))))) {
		var_comment_status = rt.new_string(rt.new_string('all'))
		// unsupported statement: Stmt_Nop
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) set_review_type()  {
	// unsupported statement: Stmt_Global
	mut var_review_type := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get('review_type')).is_null() { rt.get_superglobal('_REQUEST').array_get('review_type') } else { rt.new_string('all') }])])
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && !(!rt.is_true(var_review_type)))) {
		mut var_comment_type := var_review_type.dup()
		// unsupported statement: Stmt_Nop
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_sort_arguments() rt.PhpVal {
	mut var_orderby := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get('orderby')).is_null() { rt.get_superglobal('_REQUEST').array_get('orderby') } else { rt.new_string('') }])])
	mut var_order := rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_REQUEST').array_get('order')).is_null() { rt.get_superglobal('_REQUEST').array_get('order') } else { rt.new_string('') }])])
	mut var_args := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_orderby.dup(), this.get_sortable_columns(), rt.new_bool(true)]))))) {
		var_orderby = rt.new_string(rt.new_string('comment_date_gmt'))
	}
	if rt.is_true(rt.identical(rt.new_string('rating'), var_orderby)) {
		var_orderby = rt.new_string(rt.new_string('meta_value_num'))
		var_args.array_set('meta_key', 'rating')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(var_order.dup().to_string().to_lower()), rt.create_array([rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'desc' }]), rt.new_bool(true)]))))) {
		var_order = rt.new_string(rt.new_string('desc'))
	}
	return rt.call_function('wp_parse_args', [rt.create_array([rt.ArrayItem{ key: 'orderby', val: var_orderby }, rt.ArrayItem{ key: 'order', val: var_order.dup().to_string().to_lower() }]), var_args.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_filter_type_arguments() rt.PhpVal {
	mut var_args := rt.new_array()
	mut var_item_type := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('review_type')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('review_type')])]) } else { rt.new_string('all') }
	if rt.is_true(rt.identical(rt.new_string('all'), var_item_type)) {
		return var_args.dup()
	}
	var_args.array_set('type', var_item_type.dup())
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_filter_rating_arguments() rt.PhpVal {
	mut var_args := rt.new_array()
	if !rt.is_true(this.current_reviews_rating) {
		return var_args.dup()
	}
	var_args.array_set('meta_query', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: 'rating' }, rt.ArrayItem{ key: 'value', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'compare', val: '=' }, rt.ArrayItem{ key: 'type', val: 'NUMERIC' }]) }]))
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_filter_product_arguments() rt.PhpVal {
	mut var_args := rt.new_array()
	if rt.is_true(rt.new_bool(rt.instance_of(this.current_product_for_reviews, 'WC_Product'))) {
		var_args.array_set('post_id', rt.call_method(this.current_product_for_reviews, 'get_id', []rt.PhpVal{}))
	}
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_status_arguments() rt.PhpVal {
	mut var_comment_status := rt.new_null()
	mut var_args := rt.new_array()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_comment_status)) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(this.get_status_filters().array_isset(var_comment_status.dup()))))) {
		var_args.array_set('status', this.convert_status_to_query_value((var_comment_status).str()))
	}
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_search_arguments() rt.PhpVal {
	mut var_args := rt.new_array()
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('s'))) {
		var_args.array_set('search', rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('s')])]))
	}
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_offset_arguments() rt.PhpVal {
	mut var_args := rt.new_array()
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('start')) {
		var_args.array_set('offset', rt.call_function('absint', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('start')])]))
	} else {
		var_args.array_set('offset', rt.mul(rt.sub(this.get_pagenum(), rt.new_int(1)), this.get_per_page()))
	}
	return var_args.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_total_comments_arguments(mut var_default_query_args Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_array) rt.PhpVal {
	return rt.call_function('wp_parse_args', [rt.create_array([rt.ArrayItem{ key: 'count', val: true }, rt.ArrayItem{ key: 'offset', val: 0 }, rt.ArrayItem{ key: 'number', val: 0 }]), var_default_query_args])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) display()  {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) single_row(var_item rt.PhpVal)  {
	// unsupported statement: Stmt_Global
	mut var_comment := var_item
	mut var_the_comment_class := // unsupported expression: Expr_Cast_String
	var_the_comment_class = rt.call_function('implode', [rt.new_string(' '), rt.call_function('get_comment_class', [var_the_comment_class.dup(), rt.get_property(var_comment, 'comment_ID'), rt.get_property(var_comment, 'comment_post_ID')])])
	mut var_post := rt.call_function('get_post', [rt.get_property(var_comment, 'comment_post_ID')])
	this.current_user_can_edit_review = rt.call_function('current_user_can', [rt.new_string('edit_comment'), rt.get_property(var_comment, 'comment_ID')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.get_property(var_comment, 'comment_ID')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_the_comment_class.dup()]))
	// unsupported statement: Stmt_InlineHTML
	this.single_row_columns(var_comment.dup())
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) handle_row_actions(var_item rt.PhpVal, var_column_name rt.PhpVal, var_primary rt.PhpVal) string {
	mut var_comment_status := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.new_bool(!(rt.is_true(this.current_user_can_edit_review)))))) {
		return ''
	}
	mut var_review_status := rt.call_function('wp_get_comment_status', [var_item.dup()])
	mut var_url := rt.call_function('add_query_arg', [, ])
	mut var_approve_url := 
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_columns() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_primary_column_name() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_sortable_columns() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_bulk_actions() rt.PhpVal {
	mut var_comment_status := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) current_action() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) process_bulk_action()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_status_filters() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_views() rt.PhpVal {
	mut var_post_id := rt.new_null()
	mut var_comment_status := rt.new_null()
	mut var_comment_type := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_view_url(comment_type string, post_id i64) string {
	mut comment_type_mutated := comment_type
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_review_count(status string, product_id i64) i64 {
	mut product_id_mutated := product_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) convert_status_to_query_value(status string) string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) no_items()  {
	mut var_comment_status := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_cb(var_item rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_comment(var_item rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_in_reply_to_review_text(var_reply rt.PhpVal) string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_author(var_item rt.PhpVal)  {
	mut var_comment_status := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_item_author_url() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) get_item_author_url_for_display(var_author_url rt.PhpVal) string {
	mut var_author_url_mutated := var_author_url
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_date(var_item rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_response(var_item rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_type(var_item rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_rating(var_item rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) filter_column_output(var_column_name rt.PhpVal, var_output rt.PhpVal, var_item rt.PhpVal) string {
	mut var_output_mutated := var_output
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) extra_tablenav(var_which rt.PhpVal)  {
	mut var_comment_status := rt.new_null()
	mut var_comment_type := rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) review_type_dropdown(var_current_type rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) review_rating_dropdown(var_current_rating rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) product_search(mut var_current_product Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_?WC_Product)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) comments_bubble(var_post_id rt.PhpVal, var_pending_comments rt.PhpVal)  {
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

fn create_wp_list_table() &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_productreviews_reviews() &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_productreviews_reviewslisttable_php() {
}
