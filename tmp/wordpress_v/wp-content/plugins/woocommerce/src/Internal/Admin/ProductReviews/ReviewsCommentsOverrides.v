import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides.reviews_moved_notice_id() string {
	return 'product_reviews_moved'
}
struct Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides) construct()  {
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'display_notices' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_dismiss_admin_notice_capability'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_dismiss_capability' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('comments_list_table_query_args'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'exclude_reviews_from_comments' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides) display_notices()  {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(var_screen) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	this.maybe_display_reviews_moved_notice()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides) maybe_display_reviews_moved_notice()  {
	if this.should_display_reviews_moved_notice() {
		this.display_reviews_moved_notice()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides) should_display_reviews_moved_notice() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('current_user_can'), fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews{}; return temp.get_capability() }()]))))) {
		return false
	}
	if rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('get_user_meta'), rt.call_function('get_current_user_id', []rt.PhpVal{}), 'dismissed_' + (Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_static.reviews_moved_notice_id()).str() + '_notice', rt.new_bool(true)])) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides) display_reviews_moved_notice()  {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Product reviews have moved!'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Product reviews can now be managed from Products > Reviews.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('edit.php?post_type=product&page=product-reviews')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Visit new location'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('edit-comments.php')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_static.reviews_moved_notice_id()]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('comment_status'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_superglobal('_GET').array_get('comment_status')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get('paged'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.get_superglobal('_GET').array_get('paged')]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce_hide_notices_nonce'), rt.new_string('_wc_notice_nonce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Dismiss this notice.'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides) get_dismiss_capability(var_default_capability rt.PhpVal, var_notice_name rt.PhpVal) rt.PhpVal {
	return if rt.is_true(rt.identical(var_notice_name, Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides.reviews_moved_notice_id())) { fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews{}; return temp.get_capability() }() } else { var_default_capability }
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides) exclude_reviews_from_comments(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_screen, 'WP_Screen')))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return var_args_mutated.dup()
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_args_mutated.array_get('post_type'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_post_types := rt.cast_array(var_args_mutated.array_get('post_type'))
	} else {
		var_post_types = rt.call_function('get_post_types', []rt.PhpVal{})
	}
	mut var_index := rt.call_function('array_search', [rt.new_string('product'), var_post_types.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_post_types.array_unset(var_index)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_args_mutated.dup().is_array()))))) {
		var_args_mutated = rt.new_array()
	}
	var_args_mutated.array_set('post_type', var_post_types.dup())
	return var_args_mutated.dup()
}

struct Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_productreviews_reviewscommentsoverrides() &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_admin_productreviews_reviews() &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'display_notices' {
			this.display_notices()
			return rt.new_null()
		}
		'maybe_display_reviews_moved_notice' {
			this.maybe_display_reviews_moved_notice()
			return rt.new_null()
		}
		'should_display_reviews_moved_notice' {
			return rt.new_bool(this.should_display_reviews_moved_notice())
		}
		'display_reviews_moved_notice' {
			this.display_reviews_moved_notice()
			return rt.new_null()
		}
		'get_dismiss_capability' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_dismiss_capability(dispatch_arg_0, dispatch_arg_1)
		}
		'exclude_reviews_from_comments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.exclude_reviews_from_comments(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsCommentsOverrides) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_productreviews_reviewscommentsoverrides_php() {
}
