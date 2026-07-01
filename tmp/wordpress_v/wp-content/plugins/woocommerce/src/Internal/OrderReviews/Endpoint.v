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

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) init()  {
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_create_host_page' }]), rt.new_int(4)])
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_rewrite_rule' }])])
	rt.call_function('add_filter', [rt.new_string('query_vars'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_query_var' }]), rt.new_int(0)])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'gate_request' }])])
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_flush_pending_rewrite' }])])
	rt.call_function('add_action', [rt.new_string('transition_post_status'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'skip_auto_menu_for_self' }]), rt.new_int(9), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('get_pages'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'exclude_self_from_page_list' }])])
	rt.call_function('add_filter', [rt.new_string('display_post_states'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_post_state_label' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_create_pages'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'inject_review_order_page' }])])
	rt.call_function('add_shortcode', [Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.shortcode(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_shortcode' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) maybe_create_host_page()  {
	mut var_option_id := // unsupported expression: Expr_Cast_Int
	mut var_option_page := if rt.is_true(rt.greater(var_option_id, rt.new_int(0))) { rt.call_function('get_post', [var_option_id.dup()]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_option_page, 'WP_Post'))) && rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_option_page, 'post_type'))))) && rt.is_true(rt.identical(rt.new_string('publish'), rt.get_property(var_option_page, 'post_status'))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_canonical := this.find_canonical_host_page()
	if rt.is_true(rt.new_bool(rt.instance_of(var_canonical, 'WP_Post'))) {
		mut var_needs_save := rt.new_bool(rt.new_bool(false))
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_function('update_option', [rt.new_string('woocommerce_review_order_page_id'), // unsupported expression: Expr_Cast_Int])
			var_needs_save = rt.new_bool(rt.new_bool(true))
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'post_status', val: 'publish' }])])
			var_needs_save = rt.new_bool(rt.new_bool(true))
		}
		if rt.is_true(var_needs_save) {
			rt.call_function('update_option', [rt.new_string('woocommerce_review_order_flush_rewrite_pending'), rt.new_string('yes')])
		}
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_option_page, 'WP_Post'))) && rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_option_page, 'post_type'))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'post_status', val: 'publish' }])])
			rt.call_function('update_option', [rt.new_string('woocommerce_review_order_flush_rewrite_pending'), rt.new_string('yes')])
		}
		return rt.new_null()
	}
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_OrderReviews_WC_Install{}; return temp.create_pages() }()
	rt.call_function('update_option', [rt.new_string('woocommerce_review_order_flush_rewrite_pending'), rt.new_string('yes')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) inject_review_order_page(var_pages rt.PhpVal) rt.PhpVal {
	mut var_pages_mutated := var_pages
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_pages_mutated.dup().is_array()))))) {
		return var_pages_mutated.dup()
	}
	var_pages_mutated.array_set(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.page_key(), rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('_x', [rt.new_string('review-order'), rt.new_string('Page slug'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'title', val: rt.call_function('_x', [rt.new_string('Review your order'), rt.new_string('Page title'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'content', val: '<!-- wp:shortcode -->[' + (Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.shortcode()).str() + ']<!-- /wp:shortcode -->' }]))
	return var_pages_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) find_canonical_host_page() rt.PhpVal {
	mut var_page := rt.call_function('get_page_by_path', [rt.call_function('_x', [rt.new_string('review-order'), rt.new_string('Page slug'), rt.new_string('woocommerce')]), rt.get_constant('OBJECT'), rt.new_string('page')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_page, 'WP_Post')))))) || rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_page, 'post_status'))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [// unsupported expression: Expr_Cast_String, '[' + (Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.shortcode()).str() + ']']))) {
		return rt.new_null()
	}
	return var_page.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) add_post_state_label(var_post_states rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_post_states_mutated := var_post_states
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_post_states_mutated.dup().is_array()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))))))) {
		return var_post_states_mutated.dup()
	}
	mut var_page_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_page_id, rt.new_int(0))) && rt.is_true(rt.identical(var_page_id, // unsupported expression: Expr_Cast_Int)))) {
		var_post_states_mutated.array_set('wc_page_for_review_order', rt.call_function('__', [rt.new_string('Review Order Page'), rt.new_string('woocommerce')]))
	}
	return var_post_states_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) exclude_self_from_page_list(var_pages rt.PhpVal) rt.PhpVal {
	mut var_pages_mutated := var_pages
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_pages_mutated.dup().is_array()))))) || !rt.is_true(var_pages_mutated))) {
		return var_pages_mutated.dup()
	}
	mut var_page_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.less_equal(var_page_id, rt.new_int(0))) {
		return var_pages_mutated.dup()
	}
	closure_2_fn := fn [var_page_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_page_id] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_page := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_page, 'WP_Post')))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))
	}
	mut var_page := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_page, 'WP_Post')))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))
	}
	return rt.call_function('array_values', [rt.call_function('array_filter', [var_pages_mutated.dup(), rt.new_closure(closure_1_fn)])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) maybe_hide_page_title(var_title rt.PhpVal, post_id i64) string {
	mut var_page_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (var_title).str()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{}))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_query', []rt.PhpVal{}))))))) {
		return (var_title).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) maybe_hide_post_title_block(var_block_content rt.PhpVal, var_block rt.PhpVal, var_instance rt.PhpVal) string {
	mut var_block_mutated := var_block
	var_block_mutated = rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_instance, 'Automattic_WooCommerce_Internal_OrderReviews_WP_Block')))))) {
		return (var_block_content).str()
	}
	mut var_page_id := // unsupported expression: Expr_Cast_Int
	mut var_block_postid := if rt.get_property(var_instance, 'context').array_isset(rt.new_string('postId')) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (var_block_content).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) skip_auto_menu_for_self(var_new_status rt.PhpVal, var_old_status rt.PhpVal, var_post rt.PhpVal)  {
	mut var_new_status_mutated := var_new_status
	mut var_old_status_mutated := var_old_status
	var_new_status_mutated = rt.new_null()
	var_old_status_mutated = rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_stored_id := // unsupported expression: Expr_Cast_Int
	mut var_is_by_id := rt.new_bool(rt.new_bool(rt.is_true(rt.greater(var_stored_id, rt.new_int(0))) && rt.is_true(rt.identical(var_stored_id, // unsupported expression: Expr_Cast_Int))))
	mut var_is_by_slug := rt.new_bool(if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_post, 'post_name'))) { rt.new_bool(false) } else { rt.new_bool(rt.is_true(rt.identical(rt.new_string('review-order'), rt.get_property(var_post, 'post_name'))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [rt.get_property(var_post, 'post_name'), rt.new_string('review-order-')])))) })
	mut var_is_by_body := // unsupported expression: Expr_BinaryOp_NotIdentical
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_by_id)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_by_slug)))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_by_body)))))) {
		return rt.new_null()
	}
	rt.call_function('remove_action', [rt.new_string('transition_post_status'), rt.new_string('_wp_auto_add_pages_to_menu'), rt.new_int(10)])
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	rt.call_function('add_action', [rt.new_string('transition_post_status'), rt.new_string('_wp_auto_add_pages_to_menu'), rt.new_int(10), rt.new_int(3)])
	return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('transition_post_status'), rt.new_closure(closure_3_fn), rt.new_int(11)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) maybe_flush_pending_rewrite()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	rt.call_function('flush_rewrite_rules', [rt.new_bool(false)])
	rt.call_function('delete_option', [rt.new_string('woocommerce_review_order_flush_rewrite_pending')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) add_rewrite_rule()  {
	mut var_page_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.less_equal(var_page_id, rt.new_int(0))) {
		return rt.new_null()
	}
	mut var_page := rt.call_function('get_post', [var_page_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_page, 'WP_Post')))))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	mut var_permalink := rt.call_function('get_permalink', [var_page_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_permalink.dup().is_string()))))) || rt.is_true(rt.identical(rt.new_string(''), var_permalink)))) {
		return rt.new_null()
	}
	mut var_path := rt.new_string(rt.new_string(// unsupported expression: Expr_Cast_String.to_string().trim_space()))
	if rt.is_true(rt.identical(rt.new_string(''), var_path)) {
		return rt.new_null()
	}
	rt.call_function('add_rewrite_rule', ['^' + (rt.call_function('preg_quote', [var_path.dup(), rt.new_string('/')])).str() + '/([0-9]+)/?$', 'index.php?page_id=' + (var_page_id).str() + '&' + (Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.query_var()).str() + '=$matches[1]', rt.new_string('top')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) add_query_var(mut var_vars Class_Automattic_WooCommerce_Internal_OrderReviews_array) rt.PhpVal {
	mut var_vars_mutated := var_vars
	var_vars_mutated.array_push(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.query_var())
	return rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_array', []string{}, var_vars_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) gate_request()  {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_page_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(rt.is_true(rt.less_equal(var_page_id, rt.new_int(0))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_page', [var_page_id.dup()]))))))) {
		return rt.new_null()
	}
	if !(rt.get_property(var_wp, 'query_vars').array_isset(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.query_var())) {
		rt.call_function('wp_safe_redirect', [rt.call_function('home_url', [rt.new_string('/')])])
		// unsupported expression: Expr_Exit
	}
	mut var_order_id := rt.call_function('absint', [rt.get_property(var_wp, 'query_vars').array_get(Class_Automattic_WooCommerce_Internal_OrderReviews_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.query_var())])
	mut var_order_key := rt.new_string(this.read_order_key())
	mut var_order := if rt.is_true(var_order_id) { rt.call_function('wc_get_order', [var_order_id.dup()]) } else { rt.new_bool(false) }
	if !(this.is_authorised(var_order.dup(), (var_order_key).str())) {
		this.render_404()
		// unsupported expression: Expr_Exit
	}
	rt.call_function('add_filter', [rt.new_string('the_title'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_hide_page_title' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('render_block_core/post-title'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_OrderReviews_Endpoint', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'maybe_hide_post_title_block' }]), rt.new_int(10), rt.new_int(3)])
	if rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order'))) {
		this.maybe_mark_no_actionable_rows(mut rt.cast_object_ptr[Class_WC_Order](var_order))
	}
	this.enqueue_assets()
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) render_shortcode() string {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(.array_isset()) {
	}
	
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) render(order_id i64)  {
	mut order_id_mutated := order_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) maybe_mark_no_actionable_rows(mut var_order Class_WC_Order)  {
	mut var_order_mutated := var_order
}

fn Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint.get_url(mut var_order Class_WC_Order) string {
	mut var_order_mutated := var_order
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) read_order_key() string {
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) is_authorised(var_order rt.PhpVal, order_key string) bool {
	mut var_order_mutated := var_order
	mut order_key_mutated := order_key
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) enqueue_assets()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint) render_404()  {
	mut var_wp_query := rt.new_null()
}

struct Class_Automattic_WooCommerce_Internal_OrderReviews_WC_Install {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_orderreviews_endpoint() &Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_Endpoint{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_orderreviews_wc_install() &Class_Automattic_WooCommerce_Internal_OrderReviews_WC_Install {
	mut obj := &Class_Automattic_WooCommerce_Internal_OrderReviews_WC_Install{
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
			return rt.new_string(this.maybe_hide_post_title_block(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_OrderReviews_array](if args.len > 0 { args[0] } else { rt.new_null() })
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
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.maybe_mark_no_actionable_rows(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_url' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
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
		else { return none }
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_internal_orderreviews_endpoint_php() {
	// unsupported statement: Stmt_Declare
}
