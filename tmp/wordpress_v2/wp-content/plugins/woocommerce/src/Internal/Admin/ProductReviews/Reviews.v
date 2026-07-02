import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews.menu_slug() string {
	return 'product-reviews'
}

struct Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews {
	rt.PhpObjectBase
pub mut:
	reviews_page_hook  rt.PhpVal = rt.new_null()
	reviews_list_table rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) construct() {
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_reviews_page' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'load_javascript' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_edit-comment'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_edit_review' },
		]),
		rt.new_int(-1)])
	rt.call_function('add_action', [rt.new_string('wp_ajax_replyto-comment'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_reply_to_review' },
		]),
		rt.new_int(-1)])
	rt.call_function('add_filter', [rt.new_string('parent_file'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'edit_review_parent_file' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'display_notices' },
		])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews.get_capability(context string) string {
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_reviews_page_capability'),
		rt.new_string((if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) {
			'moderate_comments'
		} else {
			'edit_products'
		}).str()),
		rt.new_string(context),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) add_reviews_page() {
	this.reviews_page_hook = rt.call_function('add_submenu_page', [
		rt.new_string('edit.php?post_type=product'),
		rt.call_function('__', [rt.new_string('Reviews'), rt.new_string('woocommerce')]),
		rt.new_string(
			(rt.call_function('__', [rt.new_string('Reviews'), rt.new_string('woocommerce')])).str() +
			this.get_pending_count_bubble()),
		Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews.get_capability(),
		Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_static.menu_slug(),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews',
			[]string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_reviews_list_table' }]),
	])
	rt.call_function('add_action', [
		rt.concat(rt.new_string('load-'), this.reviews_page_hook),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'load_reviews_screen' },
		]),
	])
}

fn Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews.get_reviews_page_url() string {
	return (rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' },
			rt.ArrayItem{
				key: 'page'
				val: Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_static.menu_slug()
			}]),
		rt.call_function('admin_url', [rt.new_string('edit.php')]),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) is_reviews_page() bool {
	mut var_current_screen := rt.new_null()
	return !(rt.get_property(var_current_screen, 'base')).is_null()
		&& rt.is_true(rt.identical('product_page_' + (Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_static.menu_slug()).str(), rt.get_property(var_current_screen, 'base')))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) load_javascript() {
	if this.is_reviews_page() {
		rt.call_function('wp_enqueue_script', [rt.new_string('admin-comments')])
		rt.call_function('enqueue_comment_hotkeys_js', []rt.PhpVal{})
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) is_review_or_reply(var_object rt.PhpVal) bool {
	mut var_is_review_or_reply := rt.new_bool(
		rt.is_true(rt.new_bool(rt.instance_of(var_object, 'WP_Comment')))
		&& rt.is_true(rt.call_function('in_array', [rt.get_property(var_object, 'comment_type'), rt.create_array([rt.ArrayItem{
		key: none
		val: 'review'
	}, rt.ArrayItem{ key: none, val: 'comment' }]), rt.new_bool(true)]))
		&& rt.is_true(rt.identical(rt.call_function('get_post_type', [rt.get_property(var_object, 'comment_post_ID')]), rt.new_string('product'))))
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_reviews_is_product_review_or_reply'),
		var_is_review_or_reply.clone(),
		var_object.clone(),
	])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) handle_edit_review() {
	if rt.is_true(rt.identical(rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get(rt.new_string('mode'))).is_null() {
			rt.get_superglobal('_POST').array_get(rt.new_string('mode'))
		} else {
			rt.new_string('')
		}]),
	]), rt.new_string('single')))
	{
		return
	}
	rt.call_function('check_ajax_referer', [rt.new_string('replyto-comment'),
		rt.new_string('_ajax_nonce-replyto-comment')])
	mut var_comment_id := rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('comment_ID')) { rt.new_int((rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('comment_ID'))]),
		])).to_i64()) } else { 0 })
	if !rt.is_true(var_comment_id)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_comment'), var_comment_id.clone()]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	mut var_review := rt.call_function('get_comment', [var_comment_id.clone()])
	if !(this.is_review_or_reply(var_review.clone())) {
		return
	}
	if !rt.is_true(rt.get_property(var_review, 'comment_ID')) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('content'))) {
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string('Error: Please type your review text.'),
				rt.new_string('woocommerce'),
			]),
		])
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('status')) {
		rt.get_superglobal('_POST').array_set('comment_status', rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('status'))]),
		]))
	}
	mut var_updated := rt.call_function('edit_comment', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_wp_error', [var_updated.clone()])) {
		rt.call_function('wp_die', [
			rt.call_function('esc_html', [
				rt.call_method(var_updated, 'get_error_message', []rt.PhpVal{}),
			]),
		])
	}
	mut var_position := rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('position')) { rt.new_int((rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('position'))]),
		])).to_i64()) } else { -1 })
	mut var_wp_list_table := this.make_reviews_list_table()
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_method(var_wp_list_table, 'single_row', [var_review.clone()])
	mut var_review_list_item := rt.call_function('ob_get_clean', []rt.PhpVal{})
	mut var_x := create_wp_ajax_response()
	var_x.add(rt.create_array([rt.ArrayItem{ key: 'what', val: 'edit_comment' },
		rt.ArrayItem{ key: 'id', val: rt.get_property(var_review, 'comment_ID') },
		rt.ArrayItem{ key: 'data', val: var_review_list_item },
		rt.ArrayItem{ key: 'position', val: var_position }]))
	var_x.send()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) handle_reply_to_review() {
	if rt.is_true(rt.identical(rt.call_function('sanitize_text_field', [
		rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get(rt.new_string('mode'))).is_null() {
			rt.get_superglobal('_POST').array_get(rt.new_string('mode'))
		} else {
			rt.new_string('')
		}]),
	]), rt.new_string('single')))
	{
		return
	}
	rt.call_function('check_ajax_referer', [rt.new_string('replyto-comment'),
		rt.new_string('_ajax_nonce-replyto-comment')])
	mut var_comment_post_ID := rt.new_int(if rt.get_superglobal('_POST').array_isset(rt.new_string('comment_post_ID')) { rt.new_int((rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('comment_post_ID')),
			]),
		])).to_i64()) } else { 0 })
	mut var_post := rt.call_function('get_post', [var_comment_post_ID.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('mode'))
		&& rt.is_true(rt.identical(rt.new_string('dashboard'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('mode')))) {
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_post_type', [
		var_post.clone(),
	]), rt.new_string('product')))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		var_comment_post_ID.clone(),
	])))))
	{
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if !rt.is_true(rt.get_property(var_post, 'post_status')) {
		rt.call_function('wp_die', [rt.new_int(1)])
	} else if rt.is_true(rt.call_function('in_array', [
		rt.get_property(var_post, 'post_status'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'draft' },
			rt.ArrayItem{ key: none, val: 'pending' }, rt.ArrayItem{ key: none, val: 'trash' }]),
		rt.new_bool(true),
	]))
	{
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string("Error: You can't reply to a review on a draft product."),
				rt.new_string('woocommerce'),
			]),
		])
	}
	mut var_user := rt.call_function('wp_get_current_user', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_user, 'exists', []rt.PhpVal{})) {
		mut var_user_ID := rt.get_property(var_user, 'ID')
		mut var_comment_author := rt.call_function('wp_slash', [
			rt.get_property(var_user, 'display_name'),
		])
		mut var_comment_author_email := rt.call_function('wp_slash', [
			rt.get_property(var_user, 'user_email'),
		])
		mut var_comment_author_url := rt.call_function('wp_slash', [
			rt.get_property(var_user, 'user_url'),
		])
		mut var_comment_content := if rt.get_superglobal('_POST').array_isset(rt.new_string('content')) { rt.call_function('wp_unslash', [
				rt.get_superglobal('_POST').array_get(rt.new_string('content')),
			]) } else { rt.new_string('') }
		mut var_comment_type := if rt.get_superglobal('_POST').array_isset(rt.new_string('comment_type')) { rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('comment_type')),
				]),
			]) } else { rt.new_string('comment') }
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('unfiltered_html'),
		]))
		{
			if !(rt.get_superglobal('_POST').array_isset(rt.new_string('_wp_unfiltered_html_comment'))) {
				rt.get_superglobal('_POST').array_set('_wp_unfiltered_html_comment', '')
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_create_nonce', [
				rt.new_string('unfiltered-html-comment'),
			]), rt.get_superglobal('_POST').array_get(rt.new_string('_wp_unfiltered_html_comment'))))))
			{
				rt.call_function('kses_remove_filters', []rt.PhpVal{})
				rt.call_function('kses_init_filters', []rt.PhpVal{})
				rt.call_function('remove_filter', [rt.new_string('pre_comment_content'),
					rt.new_string('wp_filter_post_kses')])
				rt.call_function('add_filter', [rt.new_string('pre_comment_content'),
					rt.new_string('wp_filter_kses')])
			}
		}
	} else {
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string('Sorry, you must be logged in to reply to a review.'),
				rt.new_string('woocommerce'),
			]),
		])
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_comment_content)) {
		rt.call_function('wp_die', [
			rt.call_function('esc_html__', [
				rt.new_string('Error: Please type your reply text.'),
				rt.new_string('woocommerce'),
			]),
		])
	}
	mut var_comment_parent := rt.new_int(0)
	if rt.get_superglobal('_POST').array_isset(rt.new_string('comment_ID')) {
		var_comment_parent = rt.call_function('absint', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('comment_ID'))]),
		])
	}
	mut var_comment_auto_approved := rt.new_bool(false)
	mut var_commentdata := rt.call_function('compact', [rt.new_string('comment_post_ID'),
		rt.new_string('comment_author'), rt.new_string('comment_author_email'),
		rt.new_string('comment_author_url'), rt.new_string('comment_content'),
		rt.new_string('comment_type'), rt.new_string('comment_parent'),
		rt.new_string('user_ID')])
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('approve_parent')))) {
		mut var_parent := rt.call_function('get_comment', [var_comment_parent.clone()])
		if rt.is_true(var_parent)
			&& rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_parent, 'comment_approved')))
			&& rt.is_true(rt.identical(rt.get_property(var_parent, 'comment_post_ID'), var_comment_post_ID)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.new_string('edit_comment'),
				rt.get_property(var_parent, 'comment_ID'),
			])))))
			{
				rt.call_function('wp_die', [rt.new_int(-1)])
			}
			if rt.is_true(rt.call_function('wp_set_comment_status', [
				var_parent.clone(), rt.new_string('approve')]))
			{
				var_comment_auto_approved = rt.new_bool(true)
			}
		}
	}
	mut var_comment_id := rt.call_function('wp_new_comment', [
		var_commentdata.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_comment_id.clone()])) {
		rt.call_function('wp_die', [
			rt.call_function('esc_html', [
				rt.call_method(var_comment_id, 'get_error_message', []rt.PhpVal{}),
			]),
		])
	}
	mut var_comment := rt.call_function('get_comment', [var_comment_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) {
		rt.call_function('wp_die', [rt.new_int(1)])
	}
	mut var_position := if rt.get_superglobal('_POST').array_isset(rt.new_string('position'))
		&& rt.is_true(rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('position'))).to_i64())) {
		rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('position'))).to_i64())
	} else {
		rt.new_string('-1')
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_wp_list_table := this.make_reviews_list_table()
	rt.call_method(var_wp_list_table, 'single_row', [var_comment.clone()])
	mut var_comment_list_item := rt.call_function('ob_get_clean', []rt.PhpVal{})
	mut var_response := rt.create_array([rt.ArrayItem{ key: 'what', val: 'comment' },
		rt.ArrayItem{ key: 'id', val: rt.get_property(var_comment, 'comment_ID') },
		rt.ArrayItem{ key: 'data', val: var_comment_list_item },
		rt.ArrayItem{ key: 'position', val: var_position }])
	mut var_counts := rt.call_function('wp_count_comments', []rt.PhpVal{})
	var_response.array_set('supplemental', rt.create_array([
		rt.ArrayItem{ key: 'in_moderation', val: rt.get_property(var_counts, 'moderated') },
		rt.ArrayItem{ key: 'i18n_comments_text', val: rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s Review'),
				rt.new_string('%s Reviews'), rt.get_property(var_counts, 'approved'),
				rt.new_string('woocommerce')]),
			rt.call_function('number_format_i18n', [rt.get_property(var_counts, 'approved')]),
		]) },
		rt.ArrayItem{ key: 'i18n_moderation_text', val: rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s Review in moderation'),
				rt.new_string('%s Reviews in moderation'), rt.get_property(var_counts, 'moderated'),
				rt.new_string('woocommerce')]),
			rt.call_function('number_format_i18n', [rt.get_property(var_counts, 'moderated')]),
		]) },
	]))
	if rt.is_true(var_comment_auto_approved) && !var_parent.is_null() {
		var_response.array_get_mut('supplemental').array_set('parent_approved', rt.get_property(var_parent,
			'comment_ID'))
		var_response.array_get_mut('supplemental').array_set('parent_post_id', rt.get_property(var_parent,
			'comment_post_ID'))
	}
	mut var_x := create_wp_ajax_response()
	var_x.add(var_response.clone())
	var_x.send()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) display_notices() {
	if this.is_reviews_page() {
		this.maybe_display_reviews_bulk_action_notice()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) maybe_display_reviews_bulk_action_notice() {
	mut var_messages := this.get_bulk_action_notice_messages()
	print(if !(!rt.is_true(var_messages)) {
		'<div id="moderated" class="updated"><p>' +
			(rt.call_function('implode', [rt.new_string('<br/>\n'), var_messages.clone()])).str() +
			'</p></div>'
	} else {
		''
	})
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) get_bulk_action_notice_messages() rt.PhpVal {
	mut var_approved := rt.new_int(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('approved')) {
		rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('approved'))).to_i64())
	} else {
		0
	})
	mut var_unapproved := rt.new_int(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('unapproved')) {
		rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('unapproved'))).to_i64())
	} else {
		0
	})
	mut var_deleted := rt.new_int(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('deleted')) {
		rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('deleted'))).to_i64())
	} else {
		0
	})
	mut var_trashed := rt.new_int(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('trashed')) {
		rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('trashed'))).to_i64())
	} else {
		0
	})
	mut var_untrashed := rt.new_int(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('untrashed')) {
		rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('untrashed'))).to_i64())
	} else {
		0
	})
	mut var_spammed := rt.new_int(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('spammed')) {
		rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('spammed'))).to_i64())
	} else {
		0
	})
	mut var_unspammed := rt.new_int(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('unspammed')) {
		rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('unspammed'))).to_i64())
	} else {
		0
	})
	mut var_messages := rt.new_array()
	if rt.is_true(rt.greater(var_approved, rt.new_int(0))) {
		var_messages.array_push(rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s review approved'),
				rt.new_string('%s reviews approved'), var_approved.clone(),
				rt.new_string('woocommerce')]),
			var_approved.clone(),
		]))
	}
	if rt.is_true(rt.greater(var_unapproved, rt.new_int(0))) {
		var_messages.array_push(rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s review unapproved'),
				rt.new_string('%s reviews unapproved'), var_unapproved.clone(),
				rt.new_string('woocommerce')]),
			var_unapproved.clone(),
		]))
	}
	if rt.is_true(rt.greater(var_spammed, rt.new_int(0))) {
		mut var_ids := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('ids')) { rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('ids'))]),
			]) } else { rt.new_int(0) }
		var_messages.array_push(
			(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s review marked as spam.'), rt.new_string('%s reviews marked as spam.'), var_spammed.clone(), rt.new_string('woocommerce')]), var_spammed.clone()])).str() +
			' <a href="' +
			(rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.new_string('edit-comments.php?doaction=undo&action=unspam&ids=${var_ids.to_string()}'), rt.new_string('bulk-comments')])])).str() +
			'">' +
			(rt.call_function('__', [rt.new_string('Undo'), rt.new_string('woocommerce')])).str() +
			'</a><br />')
	}
	if rt.is_true(rt.greater(var_unspammed, rt.new_int(0))) {
		var_messages.array_push(rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s review restored from the spam'),
				rt.new_string('%s reviews restored from the spam'),
				var_unspammed.clone(), rt.new_string('woocommerce')]),
			var_unspammed.clone(),
		]))
	}
	if rt.is_true(rt.greater(var_trashed, rt.new_int(0))) {
		var_ids = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('ids')) { rt.call_function('sanitize_text_field', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('ids'))]),
			]) } else { rt.new_int(0) }
		var_messages.array_push(
			(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s review moved to the Trash.'), rt.new_string('%s reviews moved to the Trash.'), var_trashed.clone(), rt.new_string('woocommerce')]), var_trashed.clone()])).str() +
			' <a href="' +
			(rt.call_function('esc_url', [rt.call_function('wp_nonce_url', [rt.new_string('edit-comments.php?doaction=undo&action=untrash&ids=${var_ids.to_string()}'), rt.new_string('bulk-comments')])])).str() +
			'">' +
			(rt.call_function('__', [rt.new_string('Undo'), rt.new_string('woocommerce')])).str() +
			'</a><br />')
	}
	if rt.is_true(rt.greater(var_untrashed, rt.new_int(0))) {
		var_messages.array_push(rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s review restored from the Trash'),
				rt.new_string('%s reviews restored from the Trash'),
				var_untrashed.clone(), rt.new_string('woocommerce')]),
			var_untrashed.clone(),
		]))
	}
	if rt.is_true(rt.greater(var_deleted, rt.new_int(0))) {
		var_messages.array_push(rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s review permanently deleted'),
				rt.new_string('%s reviews permanently deleted'),
				var_deleted.clone(), rt.new_string('woocommerce')]),
			var_deleted.clone(),
		]))
	}
	return var_messages.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) get_pending_count_bubble() string {
	if rt.is_true(rt.call_function('method_exists', [
		Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_WC_Comments.class(),
		rt.new_string('get_products_reviews_pending_moderation_counter'),
	]))
	{
		mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_WC_Comments{}
		mut iife_result_0 := iife_temp_0.get_products_reviews_pending_moderation_counter()
		mut var_count := iife_result_0
	} else {
		var_count = rt.new_int((rt.call_function('get_comments', [
			rt.create_array([
				rt.ArrayItem{ key: 'type__in', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'review' },
					rt.ArrayItem{ key: none, val: 'comment' },
				]) },
				rt.ArrayItem{ key: 'status', val: '0' },
				rt.ArrayItem{ key: 'post_type', val: 'product' },
				rt.ArrayItem{ key: 'count', val: true },
			]),
		])).to_i64())
	}
	var_count = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_reviews_pending_count'),
		var_count.clone(),
	])
	if !rt.is_true(var_count) {
		return ''
	}
	return ' <span class="menu-counter count-' +
		(rt.call_function('esc_attr', [var_count.clone()])).str() +
		'"><span class="pending-count">' +
		(rt.call_function('esc_html', [var_count.clone()])).str() + '</span></span>'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) edit_review_parent_file(var_parent_file rt.PhpVal) rt.PhpVal {
	mut var_current_screen := rt.new_null()
	mut var_parent_file_mutated := var_parent_file
	mut var_submenu_file := rt.get_superglobal('submenu_file')
	if !(rt.get_property(var_current_screen, 'id')).is_null()
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('c'))
		&& rt.is_true(rt.identical(rt.new_string('comment'), rt.get_property(var_current_screen, 'id'))) {
		mut var_comment_id := rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('c')),
		])
		mut var_comment := rt.call_function('get_comment', [var_comment_id.clone()])
		if !(rt.get_property(var_comment, 'comment_parent')).is_null()
			&& rt.is_true(rt.greater(rt.get_property(var_comment, 'comment_parent'), rt.new_int(0))) {
			var_comment = rt.call_function('get_comment', [
				rt.get_property(var_comment, 'comment_parent'),
			])
		}
		if !(rt.get_property(var_comment, 'comment_post_ID')).is_null()
			&& rt.is_true(rt.identical(rt.call_function('get_post_type', [rt.get_property(var_comment, 'comment_post_ID')]), rt.new_string('product'))) {
			var_parent_file_mutated = rt.new_string('edit.php?post_type=product')
			var_submenu_file = rt.new_string('product-reviews')
		}
	}
	return var_parent_file_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) make_reviews_list_table() rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable',
		[]string{}, create_automattic_woocommerce_internal_admin_productreviews_reviewslisttable(rt.create_array([
		rt.ArrayItem{
			key: 'screen'
			val: if rt.is_true(this.reviews_page_hook) {
				this.reviews_page_hook
			} else {
				rt.new_string('product_page_product-reviews')
			}
		},
	])))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) load_reviews_screen() {
	this.reviews_list_table = this.make_reviews_list_table()
	rt.call_method(this.reviews_list_table, 'process_bulk_action', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews) render_reviews_list_table() {
	rt.call_method(this.reviews_list_table, 'prepare_items', []rt.PhpVal{})
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [
		rt.call_function('get_admin_page_title', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(this.reviews_list_table, 'views', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	mut var_page := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('page')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('page'))]),
		]) } else { Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_static.menu_slug() }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_page.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('current_time', [rt.new_string('mysql'),
			rt.new_bool(true)]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(this.reviews_list_table, 'search_box', [
		rt.call_function('__', [rt.new_string('Search Reviews'),
			rt.new_string('woocommerce')]),
		rt.new_string('reviews'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(this.reviews_list_table, 'display', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_comment_reply', [rt.new_string('-1'),
		rt.new_bool(true), rt.new_string('detail')])
	rt.call_function('wp_comment_trashnotice', []rt.PhpVal{})
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_reviews_list_table'),
		rt.call_function('ob_get_clean', []rt.PhpVal{}),
		this.reviews_list_table,
	]))
}

struct Class_WP_Ajax_Response {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_WC_Comments {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_productreviews_reviews() &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_Reviews{
		PhpObjectBase:      rt.PhpObjectBase{}
		reviews_page_hook:  rt.new_null()
		reviews_list_table: rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_ajax_response(_args ...rt.PhpVal) &Class_WP_Ajax_Response {
	mut obj := &Class_WP_Ajax_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_productreviews_wc_comments(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_WC_Comments {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_WC_Comments{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_productreviews_reviewslisttable(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable{
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
		else {
			return none
		}
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
		'reviews_page_hook' {
			this.reviews_page_hook = val
			return true
		}
		'reviews_list_table' {
			this.reviews_list_table = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_WC_Comments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_WC_Comments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_WC_Comments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductReviews_ReviewsListTable) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
