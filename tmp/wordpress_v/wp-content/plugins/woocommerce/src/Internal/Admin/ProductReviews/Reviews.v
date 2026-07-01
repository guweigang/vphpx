import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews.menu_slug() string {
	return 'product-reviews'
}
struct Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews {
	rt.PhpObjectBase
pub mut:
		reviews_page_hook rt.PhpVal = rt.new_null()
		reviews_list_table rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) construct()  {
	rt.call_function('add_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_reviews_page' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'load_javascript' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_edit-comment'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_edit_review' }]), // unsupported expression: Expr_UnaryMinus])
	rt.call_function('add_action', [rt.new_string('wp_ajax_replyto-comment'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_reply_to_review' }]), // unsupported expression: Expr_UnaryMinus])
	rt.call_function('add_filter', [rt.new_string('parent_file'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'edit_review_parent_file' }])])
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'display_notices' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews.get_capability(context string) string {
	return (// unsupported expression: Expr_Cast_String).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) add_reviews_page()  {
	this.reviews_page_hook = rt.call_function('add_submenu_page', [rt.new_string('edit.php?post_type=product'), rt.call_function('__', [rt.new_string('Reviews'), rt.new_string('woocommerce')]), (rt.call_function('__', [rt.new_string('Reviews'), rt.new_string('woocommerce')])).str() + this.get_pending_count_bubble(), Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews.get_capability(), Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_static.menu_slug(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_reviews_list_table' }])])
	rt.call_function('add_action', [rt.concat(rt.new_string('load-'), this.reviews_page_hook), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'load_reviews_screen' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews.get_reviews_page_url() string {
	return (rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'page', val: Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_static.menu_slug() }]), rt.call_function('admin_url', [rt.new_string('edit.php')])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) is_reviews_page() bool {
	mut var_current_screen := rt.new_null()
	// unsupported statement: Stmt_Global
	return !(rt.get_property(var_current_screen, 'base')).is_null() && rt.is_true(rt.identical('product_page_' + (Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_static.menu_slug()).str(), rt.get_property(var_current_screen, 'base')))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) load_javascript()  {
	if this.is_reviews_page() {
		rt.call_function('wp_enqueue_script', [rt.new_string('admin-comments')])
		rt.call_function('enqueue_comment_hotkeys_js', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) is_review_or_reply(var_object rt.PhpVal) bool {
	mut var_is_review_or_reply := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_object, 'WP_Comment'))) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_object, 'comment_type'), rt.create_array([rt.ArrayItem{ key: none, val: 'review' }, rt.ArrayItem{ key: none, val: 'comment' }]), rt.new_bool(true)])))) && rt.is_true(rt.identical(rt.call_function('get_post_type', [rt.get_property(var_object, 'comment_post_ID')]), rt.new_string('product')))))
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) handle_edit_review()  {
	if rt.is_true(rt.identical(rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get('mode')).is_null() { rt.get_superglobal('_POST').array_get('mode') } else { rt.new_string('') }])]), rt.new_string('single'))) {
		return rt.new_null()
	}
	rt.call_function('check_ajax_referer', [rt.new_string('replyto-comment'), rt.new_string('_ajax_nonce-replyto-comment')])
	mut var_comment_id := if rt.get_superglobal('_POST').array_isset(rt.new_string('comment_ID')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	if rt.is_true(rt.new_bool(!rt.is_true(var_comment_id) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_comment'), var_comment_id.dup()]))))))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	mut var_review := rt.call_function('get_comment', [var_comment_id.dup()])
	if !(this.is_review_or_reply(var_review.dup())) {
		return rt.new_null()
	}
	if !rt.is_true(rt.get_property(var_review, 'comment_ID')) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	if !rt.is_true(rt.get_superglobal('_POST').array_get('content')) {
		rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('Error: Please type your review text.'), rt.new_string('woocommerce')])])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('status')) {
		rt.get_superglobal('_POST').array_set('comment_status', rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('status')])]))
	}
	mut var_updated := rt.call_function('edit_comment', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_wp_error', [var_updated.dup()])) {
		rt.call_function('wp_die', [rt.call_function('esc_html', [rt.call_method(var_updated, 'get_error_message', []rt.PhpVal{})])])
	}
	mut var_position := if rt.get_superglobal('_POST').array_isset(rt.new_string('position')) { // unsupported expression: Expr_Cast_Int } else { // unsupported expression: Expr_UnaryMinus }
	mut var_wp_list_table := this.make_reviews_list_table()
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_method(var_wp_list_table, 'single_row', [var_review.dup()])
	mut var_review_list_item := rt.call_function('ob_get_clean', []rt.PhpVal{})
	mut var_x := create_wp_ajax_response()
	var_x.add(rt.create_array([rt.ArrayItem{ key: 'what', val: 'edit_comment' }, rt.ArrayItem{ key: 'id', val: rt.get_property(var_review, 'comment_ID') }, rt.ArrayItem{ key: 'data', val: var_review_list_item }, rt.ArrayItem{ key: 'position', val: var_position }]))
	var_x.send()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) handle_reply_to_review()  {
	if rt.is_true(rt.identical(rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get('mode')).is_null() { rt.get_superglobal('_POST').array_get('mode') } else { rt.new_string('') }])]), rt.new_string('single'))) {
		return rt.new_null()
	}
	rt.call_function('check_ajax_referer', [rt.new_string('replyto-comment'), rt.new_string('_ajax_nonce-replyto-comment')])
	mut var_comment_post_ID := if rt.get_superglobal('_POST').array_isset(rt.new_string('comment_post_ID')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	mut var_post := rt.call_function('get_post', [var_comment_post_ID.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('mode')) && rt.is_true(rt.identical(rt.new_string('dashboard'), rt.get_superglobal('_REQUEST').array_get('mode'))))) {
		return rt.new_null()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), var_comment_post_ID.dup()]))))) {
		rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
	}
	if !rt.is_true(rt.get_property(var_post, 'post_status')) {
		rt.call_function('wp_die', [rt.new_int(1)])
	} else if rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_status'), rt.create_array([rt.ArrayItem{ key: none, val: 'draft' }, rt.ArrayItem{ key: none, val: 'pending' }, rt.ArrayItem{ key: none, val: 'trash' }]), rt.new_bool(true)])) {
		rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('Error: You can\'t reply to a review on a draft product.'), rt.new_string('woocommerce')])])
	}
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{})) {
		mut var_user_ID := rt.get_property(var_user, 'ID')
		mut var_comment_author := rt.call_function('wp_slash', [rt.get_property(var_user, 'display_name')])
		mut var_comment_author_email := rt.call_function('wp_slash', [rt.get_property(var_user, 'user_email')])
		mut var_comment_author_url := rt.call_function('wp_slash', [rt.get_property(var_user, 'user_url')])
		mut var_comment_content := if rt.get_superglobal('_POST').array_isset(rt.new_string('content')) { rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('content')]) } else { rt.new_string('') }
		mut var_comment_type := if rt.get_superglobal('_POST').array_isset(rt.new_string('comment_type')) { rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('comment_type')])]) } else { rt.new_string('comment') }
		if rt.is_true(rt.call_function('current_user_can', [rt.new_string('unfiltered_html')])) {
			if !(rt.get_superglobal('_POST').array_isset(rt.new_string('_wp_unfiltered_html_comment'))) {
				rt.get_superglobal('_POST').array_set('_wp_unfiltered_html_comment', '')
			}
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				rt.call_function('kses_remove_filters', []rt.PhpVal{})
				rt.call_function('kses_init_filters', []rt.PhpVal{})
				rt.call_function('remove_filter', [rt.new_string('pre_comment_content'), rt.new_string('wp_filter_post_kses')])
				rt.call_function('add_filter', [rt.new_string('pre_comment_content'), rt.new_string('wp_filter_kses')])
			}
		}
	} else {
		rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('Sorry, you must be logged in to reply to a review.'), rt.new_string('woocommerce')])])
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_comment_content)) {
		rt.call_function('wp_die', [rt.call_function('esc_html__', [rt.new_string('Error: Please type your reply text.'), rt.new_string('woocommerce')])])
	}
	mut var_comment_parent := rt.new_int(rt.new_int(0))
	if rt.get_superglobal('_POST').array_isset(rt.new_string('comment_ID')) {
		var_comment_parent = rt.call_function('absint', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('comment_ID')])])
	}
	mut var_comment_auto_approved := rt.new_bool(rt.new_bool(false))
	mut var_commentdata := rt.call_function('compact', [rt.new_string('comment_post_ID'), rt.new_string('comment_author'), rt.new_string('comment_author_email'), rt.new_string('comment_author_url'), rt.new_string('comment_content'), rt.new_string('comment_type'), rt.new_string('comment_parent'), rt.new_string('user_ID')])
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get('approve_parent'))) {
		mut var_parent := rt.call_function('get_comment', [var_comment_parent.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_parent) && rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_parent, 'comment_approved'))))) && rt.is_true(rt.identical(rt.get_property(var_parent, 'comment_post_ID'), var_comment_post_ID)))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_comment'), rt.get_property(var_parent, 'comment_ID')]))))) {
				rt.call_function('wp_die', [// unsupported expression: Expr_UnaryMinus])
			}
			if rt.is_true(rt.call_function('wp_set_comment_status', [var_parent.dup(), rt.new_string('approve')])) {
				var_comment_auto_approved = rt.new_bool(rt.new_bool(true))
			}
		}
	}
	mut var_comment_id := rt.call_function('wp_new_comment', [var_commentdata.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_comment_id.dup()])) {
		rt.call_function('wp_die', [rt.call_function('esc_html', [rt.call_method(var_comment_id, 'get_error_message', []rt.PhpVal{})])])
	}
	mut var_comment := rt.call_function('get_comment', [var_comment_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
		rt.call_function('wp_die', [rt.new_int(1)])
	}
	mut var_position := if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('position')) && rt.is_true(// unsupported expression: Expr_Cast_Int))) { // unsupported expression: Expr_Cast_Int } else { rt.new_string('-1') }
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_wp_list_table := this.make_reviews_list_table()
	rt.call_method(var_wp_list_table, 'single_row', [var_comment.dup()])
	mut var_comment_list_item := rt.call_function('ob_get_clean', []rt.PhpVal{})
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'what', val: 'comment' }, rt.ArrayItem{ key: 'id', val: rt.get_property(var_comment, 'comment_ID') }, rt.ArrayItem{ key: 'data', val: var_comment_list_item }, rt.ArrayItem{ key: 'position', val: var_position }])
	mut var_counts := rt.call_function('wp_count_comments', []rt.PhpVal{})
	var_response.array_set('supplemental', rt.create_array([rt.ArrayItem{ key: 'in_moderation', val: rt.get_property(var_counts, 'moderated') }, rt.ArrayItem{ key: 'i18n_comments_text', val: rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s Review'), rt.new_string('%s Reviews'), rt.get_property(var_counts, 'approved'), rt.new_string('woocommerce')]), rt.call_function('number_format_i18n', [rt.get_property(var_counts, 'approved')])]) }, rt.ArrayItem{ key: 'i18n_moderation_text', val: rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s Review in moderation'), rt.new_string('%s Reviews in moderation'), rt.get_property(var_counts, 'moderated'), rt.new_string('woocommerce')]), rt.call_function('number_format_i18n', [rt.get_property(var_counts, 'moderated')])]) }]))
	if rt.is_true(rt.new_bool(rt.is_true(var_comment_auto_approved) && !(var_parent).is_null())) {
		var_response.array_get_mut('supplemental').array_set('parent_approved', rt.get_property(var_parent, 'comment_ID'))
		var_response.array_get_mut('supplemental').array_set('parent_post_id', rt.get_property(var_parent, 'comment_post_ID'))
	}
	mut var_x := create_wp_ajax_response()
	var_x.add(var_response.dup())
	var_x.send()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) display_notices()  {
	if this.is_reviews_page() {
		this.maybe_display_reviews_bulk_action_notice()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) maybe_display_reviews_bulk_action_notice()  {
	mut var_messages := this.get_bulk_action_notice_messages()
	print(if !(!rt.is_true(var_messages)) { '<div id="moderated" class="updated"><p>' + (rt.call_function('implode', [rt.new_string('<br/>\n'), var_messages.dup()])).str() + '</p></div>' } else { '' })
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) get_bulk_action_notice_messages() rt.PhpVal {
	mut var_approved := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('approved')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	mut var_unapproved := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('unapproved')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	mut var_deleted := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('deleted')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	mut var_trashed := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('trashed')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	mut var_untrashed := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('untrashed')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	mut var_spammed := if .array_isset() {  } else {  }
	mut var_unspammed := 
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) get_pending_count_bubble() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) edit_review_parent_file(var_parent_file rt.PhpVal) rt.PhpVal {
	mut var_current_screen := rt.new_null()
	mut var_parent_file_mutated := var_parent_file
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) make_reviews_list_table() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) load_reviews_screen()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) render_reviews_list_table()  {
}

struct Class_WP_Ajax_Response {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_productreviews_reviews() &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews{
		PhpObjectBase: rt.PhpObjectBase{}
		reviews_page_hook: rt.new_null()
		reviews_list_table: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_ajax_response() &Class_WP_Ajax_Response {
	mut obj := &Class_WP_Ajax_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_capability' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews.get_capability(dispatch_arg_0))
		}
		'add_reviews_page' {
			this.add_reviews_page()
			return rt.new_null()
		}
		'get_reviews_page_url' {
			return rt.new_string(Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews.get_reviews_page_url())
		}
		'is_reviews_page' {
			return rt.new_bool(this.is_reviews_page())
		}
		'load_javascript' {
			this.load_javascript()
			return rt.new_null()
		}
		'is_review_or_reply' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_review_or_reply(dispatch_arg_0))
		}
		'handle_edit_review' {
			this.handle_edit_review()
			return rt.new_null()
		}
		'handle_reply_to_review' {
			this.handle_reply_to_review()
			return rt.new_null()
		}
		'display_notices' {
			this.display_notices()
			return rt.new_null()
		}
		'maybe_display_reviews_bulk_action_notice' {
			this.maybe_display_reviews_bulk_action_notice()
			return rt.new_null()
		}
		'get_bulk_action_notice_messages' {
			return this.get_bulk_action_notice_messages()
		}
		'get_pending_count_bubble' {
			return rt.new_string(this.get_pending_count_bubble())
		}
		'edit_review_parent_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.edit_review_parent_file(dispatch_arg_0)
		}
		'make_reviews_list_table' {
			return this.make_reviews_list_table()
		}
		'load_reviews_screen' {
			this.load_reviews_screen()
			return rt.new_null()
		}
		'render_reviews_list_table' {
			this.render_reviews_list_table()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'reviews_page_hook' { return this.reviews_page_hook }
		'reviews_list_table' { return this.reviews_list_table }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'reviews_page_hook' { this.reviews_page_hook = val; return true }
		'reviews_list_table' { this.reviews_list_table = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Ajax_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Ajax_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Ajax_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_productreviews_reviews_php() {
}
