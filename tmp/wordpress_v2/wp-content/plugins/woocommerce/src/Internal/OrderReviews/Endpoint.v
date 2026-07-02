import rt

pub fn Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.query_var() string {
	return 'review-order'
}

pub fn Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.page_key() string {
	return 'review_order'
}

pub fn Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.shortcode() string {
	return 'woocommerce_review_order'
}

struct Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) init() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_create_host_page' },
		]),
		rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_rewrite_rule' },
		])])
	rt.call_function('add_filter', [rt.new_string('query_vars'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_query_var' },
		]),
		rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'gate_request' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_loaded'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_flush_pending_rewrite' },
		])])
	rt.call_function('add_action', [rt.new_string('transition_post_status'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'skip_auto_menu_for_self' },
		]),
		rt.new_int(9), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('get_pages'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'exclude_self_from_page_list' },
		])])
	rt.call_function('add_filter', [rt.new_string('display_post_states'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_post_state_label' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_create_pages'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'inject_review_order_page' },
		])])
	rt.call_function('add_shortcode', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.shortcode(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'render_shortcode' },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) maybe_create_host_page() {
	mut var_option_id := rt.new_int((rt.call_function('wc_get_page_id', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.page_key(),
	])).to_i64())
	mut var_option_page := if rt.is_true(rt.greater(var_option_id, rt.new_int(0))) { rt.call_function('get_post', [
			var_option_id.clone(),
		]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.instance_of(var_option_page, 'WP_Post')))
		&& rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_option_page, 'post_type')))
		&& rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_option_page, 'post_status')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [rt.new_string((rt.get_property(var_option_page, 'post_content')).str()), rt.new_string('[' + (Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.shortcode()).str() + ']')]))))) {
		return
	}
	mut var_canonical := this.find_canonical_host_page()
	if rt.is_true(rt.new_bool(rt.instance_of(var_canonical, 'WP_Post'))) {
		mut var_needs_save := rt.new_bool(false)
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_option_id, rt.new_int((rt.get_property(var_canonical,
			'ID')).to_i64())))))
		{
			rt.call_function('update_option', [
				rt.new_string('woocommerce_review_order_page_id'),
				rt.new_int((rt.get_property(var_canonical, 'ID')).to_i64()),
			])
			var_needs_save = rt.new_bool(true)
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_canonical,
			'post_status')))))
		{
			rt.call_function('wp_update_post', [
				rt.create_array([
					rt.ArrayItem{
						key: 'ID'
						val: rt.new_int((rt.get_property(var_canonical, 'ID')).to_i64())
					},
					rt.ArrayItem{ key: 'post_status', val: 'publish' },
				]),
			])
			var_needs_save = rt.new_bool(true)
		}
		if rt.is_true(var_needs_save) {
			rt.call_function('update_option', [
				rt.new_string('woocommerce_review_order_flush_rewrite_pending'),
				rt.new_string('yes'),
			])
		}
		return
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_option_page, 'WP_Post')))
		&& rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_option_page, 'post_type')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_option_page, 'post_status'))))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_option_page,
			'post_status')))))
		{
			rt.call_function('wp_update_post', [
				rt.create_array([
					rt.ArrayItem{
						key: 'ID'
						val: rt.new_int((rt.get_property(var_option_page, 'ID')).to_i64())
					},
					rt.ArrayItem{ key: 'post_status', val: 'publish' },
				]),
			])
			rt.call_function('update_option', [
				rt.new_string('woocommerce_review_order_flush_rewrite_pending'),
				rt.new_string('yes'),
			])
		}
		return
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_OrderReviews_WC_Install{}
	mut iife_result_0 := iife_temp_0.create_pages()
	rt.call_function('update_option', [
		rt.new_string('woocommerce_review_order_flush_rewrite_pending'),
		rt.new_string('yes'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) inject_review_order_page(var_pages rt.PhpVal) rt.PhpVal {
	mut var_pages_mutated := var_pages
	if !(var_pages_mutated.clone().is_array()) {
		return var_pages_mutated.clone()
	}
	var_pages_mutated.array_set(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.page_key(), rt.create_array([
		rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [
			rt.new_string('review-order'),
			rt.new_string('Page slug'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [
			rt.new_string('Review your order'),
			rt.new_string('Page title'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{
			key: 'content'
			val: '<!-- wp:shortcode -->[' +
				(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.shortcode()).str() + ']<!-- /wp:shortcode -->'
		},
	]))
	return var_pages_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) find_canonical_host_page() rt.PhpVal {
	mut var_page := rt.call_function('get_page_by_path', [
		rt.call_function('_x', [rt.new_string('review-order'),
			rt.new_string('Page slug'), rt.new_string('woocommerce')]),
		rt.get_constant('OBJECT'),
		rt.new_string('page'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_page, 'WP_Post'))))))
		|| rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_page, 'post_status'))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		rt.new_string((rt.get_property(var_page, 'post_content')).str()),
		rt.new_string('[' +
			(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.shortcode()).str() + ']'),
	])))
	{
		return rt.new_null()
	}
	return var_page.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) add_post_state_label(var_post_states rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_post_states_mutated := var_post_states
	if !(var_post_states_mutated.clone().is_array())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))))) {
		return var_post_states_mutated.clone()
	}
	mut var_page_id := rt.new_int((rt.call_function('wc_get_page_id', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.page_key(),
	])).to_i64())
	if rt.is_true(rt.greater(var_page_id, rt.new_int(0)))
		&& rt.is_true(rt.identical(var_page_id, rt.new_int((rt.get_property(var_post, 'ID')).to_i64()))) {
		var_post_states_mutated.array_set('wc_page_for_review_order', rt.call_function('__', [
			rt.new_string('Review Order Page'),
			rt.new_string('woocommerce'),
		]))
	}
	return var_post_states_mutated.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) exclude_self_from_page_list(var_pages rt.PhpVal) rt.PhpVal {
	mut var_pages_mutated := var_pages
	if !(var_pages_mutated.clone().is_array()) || !rt.is_true(var_pages_mutated) {
		return var_pages_mutated.clone()
	}
	mut var_page_id := rt.new_int((rt.call_function('wc_get_page_id', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.page_key(),
	])).to_i64())
	if rt.is_true(rt.less_equal(var_page_id, rt.new_int(0))) {
		return var_pages_mutated.clone()
	}
	closure_2_fn := fn [var_page_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_page := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(
			rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_page, 'WP_Post'))))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.get_property(var_page, 'ID')).to_i64()), var_page_id)))))
	}
	closure_3_fn := fn [var_page_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_page := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(
			rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_page, 'WP_Post'))))))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.get_property(var_page, 'ID')).to_i64()), var_page_id)))))
	}
	return rt.call_function('array_values', [
		rt.call_function('array_filter', [var_pages_mutated.clone(),
			rt.new_closure(closure_2_fn)]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) maybe_hide_page_title(var_title rt.PhpVal, post_id i64) string {
	mut var_page_id := rt.new_int((rt.call_function('wc_get_page_id', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.page_key(),
	])).to_i64())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(post_id, var_page_id)))) {
		return var_title.str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_query', []rt.PhpVal{}))))) {
		return var_title.str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) maybe_hide_post_title_block(var_block_content rt.PhpVal, var_block rt.PhpVal, var_instance rt.PhpVal) string {
	mut var_block_mutated := var_block
	var_block_mutated = rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_instance,
		'Automattic_WooCommerce_Internal_OrderReviews_WP_Block'))))))
	{
		return var_block_content.str()
	}
	mut var_page_id := rt.new_int((rt.call_function('wc_get_page_id', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.page_key(),
	])).to_i64())
	mut var_block_postid := rt.new_int(if rt.get_property(var_instance, 'context').array_isset(rt.new_string('postId')) {
		rt.new_int((rt.get_property(var_instance, 'context').array_get(rt.new_string('postId'))).to_i64())
	} else {
		0
	})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_block_postid, var_page_id)))) {
		return var_block_content.str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) skip_auto_menu_for_self(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal) {
	mut var_new_status_mutated := var_new_status
	mut var_old_status_mutated := var_old_status
	var_new_status_mutated = rt.new_null()
	var_old_status_mutated = rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post'))))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_post, 'post_type'))))) {
		return
	}
	mut var_stored_id := rt.new_int((rt.call_function('get_option', [
		rt.new_string('woocommerce_review_order_page_id'),
	])).to_i64())
	mut var_is_by_id := rt.new_bool(rt.is_true(rt.greater(var_stored_id, rt.new_int(0)))
		&& rt.is_true(rt.identical(var_stored_id, rt.new_int((rt.get_property(var_post, 'ID')).to_i64()))))
	mut var_is_by_slug := rt.new_bool(if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_post,
		'post_name')))
	{
		false
	} else {
		rt.is_true(rt.identical(rt.new_string('review-order'), rt.get_property(var_post, 'post_name')))
			|| rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [rt.get_property(var_post, 'post_name'), rt.new_string('review-order-')])))
	})
	mut var_is_by_body := rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		rt.new_string((rt.get_property(var_post, 'post_content')).str()),
		rt.new_string('[' +
			(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.shortcode()).str() + ']'),
	]))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_by_id))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_by_slug))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_by_body)))) {
		return
	}
	rt.call_function('remove_action', [rt.new_string('transition_post_status'),
		rt.new_string('_wp_auto_add_pages_to_menu'), rt.new_int(10)])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_function('add_action', [rt.new_string('transition_post_status'),
			rt.new_string('_wp_auto_add_pages_to_menu'), rt.new_int(10),
			rt.new_int(3)])
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('transition_post_status'),
		rt.new_closure(closure_4_fn), rt.new_int(11)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) maybe_flush_pending_rewrite() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_review_order_flush_rewrite_pending'),
	])))))
	{
		return
	}
	rt.call_function('flush_rewrite_rules', [rt.new_bool(false)])
	rt.call_function('delete_option', [
		rt.new_string('woocommerce_review_order_flush_rewrite_pending'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) add_rewrite_rule() {
	mut var_page_id := rt.new_int((rt.call_function('wc_get_page_id', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.page_key(),
	])).to_i64())
	if rt.is_true(rt.less_equal(var_page_id, rt.new_int(0))) {
		return
	}
	mut var_page := rt.call_function('get_post', [var_page_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_page, 'WP_Post'))))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_page, 'post_status'))))) {
		return
	}
	mut var_permalink := rt.call_function('get_permalink', [var_page_id.clone()])
	if !(var_permalink.clone().is_string())
		|| rt.is_true(rt.identical(rt.new_string(''), var_permalink)) {
		return
	}
	mut var_path := rt.new_string((rt.call_function('wp_make_link_relative', [
		var_permalink.clone()])).str().trim_space())
	if rt.is_true(rt.identical(rt.new_string(''), var_path)) {
		return
	}
	rt.call_function('add_rewrite_rule', [
		rt.new_string('^' +
			(rt.call_function('preg_quote', [var_path.clone(), rt.new_string('/')])).str() +
			'/([0-9]+)/?$'),
		rt.new_string('index.php?page_id=' + var_page_id.str() + '&' +
			(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.query_var()).str() + '=$matches[1]'),
		rt.new_string('top'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) add_query_var(mut var_vars Class_Automattic_WooCommerce_Internal_OrderReviews_array) rt.PhpVal {
	mut var_vars_mutated := var_vars
	var_vars_mutated.array_push(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.query_var())
	return rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_array', []string{},
		var_vars_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) gate_request() {
	mut var_wp := rt.new_null()
	mut var_page_id := rt.new_int((rt.call_function('wc_get_page_id', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.page_key(),
	])).to_i64())
	if rt.is_true(rt.less_equal(var_page_id, rt.new_int(0)))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_page', [var_page_id.clone()]))))) {
		return
	}
	if !(rt.get_property(var_wp, 'query_vars').array_isset(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.query_var())) {
		rt.call_function('wp_safe_redirect', [
			rt.call_function('home_url', [rt.new_string('/')]),
		])
		exit(0)
	}
	mut var_order_id := rt.call_function('absint', [
		rt.get_property(var_wp, 'query_vars').array_get(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.query_var()),
	])
	mut var_order_key := rt.new_string(this.read_order_key())
	mut var_order := if rt.is_true(var_order_id) { rt.call_function('wc_get_order', [
			var_order_id.clone(),
		]) } else { rt.new_bool(false) }
	if !(this.is_authorised(var_order.clone(), var_order_key.str())) {
		this.render_404()
		exit(0)
	}
	rt.call_function('add_filter', [rt.new_string('the_title'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_hide_page_title' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('render_block_core/post-title'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'maybe_hide_post_title_block' },
		]),
		rt.new_int(10), rt.new_int(3)])
	if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) {
		this.maybe_mark_no_actionable_rows(mut rt.cast_object_ptr[Class_WC_Order](var_order))
	}
	this.enqueue_assets()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) render_shortcode() string {
	mut var_wp := rt.new_null()
	if !(rt.get_property(var_wp, 'query_vars').array_isset(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.query_var())) {
		return ''
	}
	mut var_order_id := rt.call_function('absint', [
		rt.get_property(var_wp, 'query_vars').array_get(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.query_var()),
	])
	mut var_order := if rt.is_true(var_order_id) { rt.call_function('wc_get_order', [
			var_order_id.clone(),
		]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))))) {
		return ''
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('wc_get_template', [
		rt.new_string('order/customer-review-order.php'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: var_order }]),
	])
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) render(order_id i64) {
	mut order_id_mutated := order_id
	mut var_order_key := rt.new_string(this.read_order_key())
	mut var_order := if rt.is_true(rt.new_int(order_id_mutated)) { rt.call_function('wc_get_order', [
			rt.new_int(order_id_mutated).clone(),
		]) } else { rt.new_bool(false) }
	if !(this.is_authorised(var_order.clone(), var_order_key.str())) {
		this.render_404()
		return
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) {
		this.maybe_mark_no_actionable_rows(mut rt.cast_object_ptr[Class_WC_Order](var_order))
	}
	rt.call_function('wc_get_template', [
		rt.new_string('order/customer-review-order.php'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: var_order }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) maybe_mark_no_actionable_rows(mut var_order Class_WC_Order) {
	mut var_order_mutated := var_order
	mut var_completed_meta_key :=
		Class_Automattic_WooCommerce_Internal_OrderReviews_SubmissionHandler.completed_meta_key()
	if rt.is_true(rt.call_method(var_order_mutated, 'get_meta', [
		var_completed_meta_key.clone()]))
	{
		return
	}
	mut var_items := rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_review_order_eligible_items'),
		rt.call_method(var_order_mutated, 'get_items', []rt.PhpVal{}),
		var_order_mutated,
	]))
	mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility{}
	mut iife_result_4 := iife_temp_4.preload_for_items(var_items.clone(), rt.new_object('WC_Order',
		[]string{}, var_order_mutated))
	mut iter_1 := var_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_item,
			'Automattic_WooCommerce_Internal_OrderReviews_WC_Order_Item_Product'))))))
		{
			continue
		}
		mut iife_temp_5 := Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility{}
		mut iife_result_5 := iife_temp_5.decide(var_item.clone(), rt.new_object('WC_Order',
			[]string{}, var_order_mutated))
		mut var_decision := iife_result_5
		if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility.status_skip(),
			var_decision.array_get(rt.new_string('status'))))
		{
			continue
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_decision.array_get(rt.new_string('comment')),
			'Automattic_WooCommerce_Internal_OrderReviews_WP_Comment'))))))
		{
			return
		}
	}
	rt.call_method(var_order_mutated, 'update_meta_data', [var_completed_meta_key.clone(),
		rt.new_string((rt.call_function('time', []rt.PhpVal{})).str())])
	rt.call_method(var_order_mutated, 'save', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_OrderReviews_Exception') {
		mut var_e := var_e_1.clone()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Could not stamp Review Order completion meta on order %1$d: %2$s.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{}),
				rt.call_method(var_e, 'getMessage', []rt.PhpVal{}),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'source', val: 'order-reviews' },
			]),
		])
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
}

fn Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.get_url(mut var_order Class_WC_Order) string {
	mut var_order_mutated := var_order
	mut var_page_id := rt.new_int((rt.call_function('wc_get_page_id', [
		Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.page_key(),
	])).to_i64())
	mut var_permalink := rt.new_string((if rt.is_true(rt.greater(var_page_id, rt.new_int(0))) { rt.call_function('get_permalink', [
			var_page_id.clone(),
		]) } else { rt.new_string('') }).str())
	if rt.is_true(rt.identical(rt.new_string(''), var_permalink)) {
		mut var_url := rt.new_string('')
	} else if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [
		var_permalink.clone(),
		rt.new_string('?'),
	])))
	{
		var_url = rt.new_string(
			(rt.call_function('trailingslashit', [var_permalink.clone()])).str() +
			(rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).str() + '/')
		var_url = rt.call_function('add_query_arg', [rt.new_string('key'),
			rt.call_method(var_order_mutated, 'get_order_key', []rt.PhpVal{}),
			var_url.clone()])
	} else {
		var_url = rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{
					key: Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.query_var()
					val: (rt.call_method(var_order_mutated, 'get_id', []rt.PhpVal{})).str()
				},
				rt.ArrayItem{ key: 'key', val: rt.call_method(var_order_mutated, 'get_order_key',
					[]rt.PhpVal{}) },
			]),
			var_permalink.clone(),
		])
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_review_order_url'),
		var_url.clone(),
		var_order_mutated,
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) read_order_key() string {
	mut var_raw := if rt.get_superglobal('_GET').array_isset(rt.new_string('key')) && rt.get_superglobal('_GET').array_get(rt.new_string('key')).is_string() { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('key'))]),
		]) } else { rt.new_string('') }
	return (if var_raw.clone().is_string() {
		var_raw
	} else {
		rt.new_string('')
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) is_authorised(var_order rt.PhpVal, order_key string) bool {
	mut var_order_mutated := var_order
	mut order_key_mutated := order_key
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated, 'WC_Order')))))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(order_key_mutated)))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [rt.call_method(var_order_mutated, 'get_order_key', []rt.PhpVal{}), rt.new_string(order_key_mutated).clone()]))))) {
		return false
	}
	mut var_eligible_statuses := rt.cast_array(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_review_order_eligible_statuses'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
		]),
		var_order_mutated.clone(),
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.call_method(var_order_mutated, 'get_status', []rt.PhpVal{}),
		var_eligible_statuses.clone(),
		rt.new_bool(true),
	])))))
	{
		return false
	}
	if rt.is_true(rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.call_method(var_order_mutated, 'get_customer_id', []rt.PhpVal{}))))) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) enqueue_assets() {
	mut var_plugin_url := rt.call_function('untrailingslashit', [
		rt.call_function('plugins_url', [rt.new_string(''), rt.get_constant('WC_PLUGIN_FILE')]),
	])
	mut var_suffix := rt.new_string((if
		rt.is_true(rt.call_function('defined', [rt.new_string('SCRIPT_DEBUG')]))
		&& rt.is_true(rt.get_constant('SCRIPT_DEBUG')) {
		''
	} else {
		'.min'
	}).str())
	mut iife_temp_6 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_6 := iife_temp_6.get_constant(rt.new_string('WC_VERSION'))
	mut var_version := iife_result_6
	closure_8_fn := fn [var_plugin_url] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_path := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut var_asset_url := rt.new_closure(closure_8_fn)
	rt.call_function('wp_enqueue_style', [rt.new_string('wc-order-review'),
		rt.call_callable(var_asset_url, [rt.new_string('/assets/css/order-review.css')]),
		rt.new_array(), var_version.clone()])
	rt.call_function('wp_style_add_data', [rt.new_string('wc-order-review'),
		rt.new_string('rtl'), rt.new_string('replace')])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-order-review'),
		rt.call_callable(var_asset_url, [
			rt.new_string('/assets/js/frontend/order-review' + var_suffix.str() + '.js'),
		]),
		rt.new_array(), var_version.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'strategy', val: 'defer' },
			rt.ArrayItem{ key: 'in_footer', val: true },
		])])
	rt.call_function('wp_localize_script', [rt.new_string('wc-order-review'),
		rt.new_string('wcOrderReview'),
		rt.create_array([
			rt.ArrayItem{ key: 'i18n', val: rt.create_array([
				rt.ArrayItem{ key: 'ok', val: rt.call_function('__', [
					rt.new_string('Thanks, your review is live.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'pending_moderation', val: rt.call_function('__', [
					rt.new_string('Thanks, your review is pending approval.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'error', val: rt.call_function('__', [
					rt.new_string('Something went wrong, please try again.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'rating_required', val: rt.call_function('__', [
					rt.new_string('Please rate this product before submitting your review.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) render_404() {
	mut var_wp_query := rt.new_null()
	rt.call_method(var_wp_query, 'set_404', []rt.PhpVal{})
	rt.call_function('status_header', [rt.new_int(404)])
	rt.call_function('nocache_headers', []rt.PhpVal{})
	mut var_template := rt.call_function('get_query_template', [
		rt.new_string('404')])
	if !(!rt.is_true(var_template))
		&& rt.is_true(rt.call_function('file_exists', [var_template.clone()])) {
		rt.include_file(var_template.to_string(), '1')
		return
	}
	rt.call_function('printf', [
		rt.new_string('<!doctype html><html><head><meta charset="utf-8"><title>%1$s</title></head><body><h1>%1$s</h1></body></html>'),
		rt.call_function('esc_html__', [rt.new_string('Page not found'),
			rt.new_string('woocommerce')]),
	])
}

struct Class_Automattic_WooCommerce_Internal_OrderReviews_WC_Install {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_OrderReviews_ItemEligibility {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orderreviews_endpoint(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_orderreviews_wc_install(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_OrderReviews_WC_Install {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_WC_Install{
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

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'maybe_create_host_page' {
			this.maybe_create_host_page()
			return rt.new_null()
		}
		'inject_review_order_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.inject_review_order_page(dispatch_arg_0)
		}
		'find_canonical_host_page' {
			return this.find_canonical_host_page()
		}
		'add_post_state_label' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_post_state_label(dispatch_arg_0, dispatch_arg_1)
		}
		'exclude_self_from_page_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.exclude_self_from_page_list(dispatch_arg_0)
		}
		'maybe_hide_page_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.maybe_hide_page_title(dispatch_arg_0, dispatch_arg_1))
		}
		'maybe_hide_post_title_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.maybe_hide_post_title_block(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'skip_auto_menu_for_self' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.skip_auto_menu_for_self(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'maybe_flush_pending_rewrite' {
			this.maybe_flush_pending_rewrite()
			return rt.new_null()
		}
		'add_rewrite_rule' {
			this.add_rewrite_rule()
			return rt.new_null()
		}
		'add_query_var' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_OrderReviews_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.add_query_var(mut dispatch_arg_0)
		}
		'gate_request' {
			this.gate_request()
			return rt.new_null()
		}
		'render_shortcode' {
			return rt.new_string(this.render_shortcode())
		}
		'render' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.render(dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_mark_no_actionable_rows' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.maybe_mark_no_actionable_rows(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.get_url(mut dispatch_arg_0))
		}
		'read_order_key' {
			return rt.new_string(this.read_order_key())
		}
		'is_authorised' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_authorised(dispatch_arg_0, dispatch_arg_1))
		}
		'enqueue_assets' {
			this.enqueue_assets()
			return rt.new_null()
		}
		'render_404' {
			this.render_404()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_WC_Install) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_OrderReviews_WC_Install) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_WC_Install) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
