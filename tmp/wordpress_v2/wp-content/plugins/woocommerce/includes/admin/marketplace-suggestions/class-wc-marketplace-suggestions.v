import rt

struct Class_WC_Marketplace_Suggestions {
	rt.PhpObjectBase
}

fn Class_WC_Marketplace_Suggestions.init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Marketplace_Suggestions.allow_suggestions())))) {
		return
	}
	rt.call_function('add_action', [rt.new_string('woocommerce_product_data_tabs'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'product_data_tabs' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_product_data_panels'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'product_data_panels' }])])
	rt.call_function('add_action', [
		rt.new_string('wp_ajax_woocommerce_add_dismissed_marketplace_suggestion'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'post_add_dismissed_suggestion_handler' }]),
	])
	rt.call_function('add_action', [
		rt.new_string('wc_marketplace_suggestions_orders_empty_state'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'render_orders_list_empty_state' }]),
	])
	rt.call_function('add_action', [rt.new_string('current_screen'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'maybe_trigger_suggestions_fetch' }])])
}

fn Class_WC_Marketplace_Suggestions.product_data_tabs(var_tabs rt.PhpVal) rt.PhpVal {
	mut var_tabs_mutated := var_tabs
	var_tabs_mutated.array_set('marketplace-suggestions', rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [
			rt.new_string('Get more options'),
			rt.new_string('Marketplace suggestions'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'target', val: 'marketplace_suggestions' },
		rt.ArrayItem{ key: 'class', val: rt.new_array() },
		rt.ArrayItem{ key: 'priority', val: 1000 },
	]))
	return var_tabs_mutated.clone()
}

fn Class_WC_Marketplace_Suggestions.product_data_panels() {
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/templates/html-product-data-extensions.php', '1')
}

fn Class_WC_Marketplace_Suggestions.get_dismissed_suggestions() rt.PhpVal {
	mut var_dismissed_suggestions := rt.new_array()
	mut var_dismissed_suggestions_data := rt.call_function('get_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('wc_marketplace_suggestions_dismissed_suggestions'),
		rt.new_bool(true),
	])
	if rt.is_true(var_dismissed_suggestions_data) {
		var_dismissed_suggestions = var_dismissed_suggestions_data.clone()
		if !(var_dismissed_suggestions.clone().is_array()) {
			var_dismissed_suggestions = rt.new_array()
		}
	}
	return var_dismissed_suggestions.clone()
}

fn Class_WC_Marketplace_Suggestions.post_add_dismissed_suggestion_handler() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('check_ajax_referer', [
		rt.new_string('add_dismissed_marketplace_suggestion'),
	])))))
	{
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_post_data := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').clone()])
	mut var_suggestion_slug := rt.call_function('sanitize_text_field', [
		var_post_data.array_get(rt.new_string('slug')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_suggestion_slug)))) {
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	mut var_dismissed_suggestions := Class_WC_Marketplace_Suggestions.get_dismissed_suggestions()
	if rt.is_true(rt.call_function('in_array', [var_suggestion_slug.clone(),
		var_dismissed_suggestions.clone(), rt.new_bool(true)]))
	{
		rt.call_function('wp_die', []rt.PhpVal{})
	}
	var_dismissed_suggestions.array_push(var_suggestion_slug.clone())
	rt.call_function('update_user_meta', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('wc_marketplace_suggestions_dismissed_suggestions'),
		var_dismissed_suggestions.clone(),
	])
	rt.call_function('wp_die', []rt.PhpVal{})
}

fn Class_WC_Marketplace_Suggestions.render_orders_list_empty_state() {
	Class_WC_Marketplace_Suggestions.render_suggestions_container(rt.new_string('orders-list-empty-header'))
	Class_WC_Marketplace_Suggestions.render_suggestions_container(rt.new_string('orders-list-empty-body'))
	Class_WC_Marketplace_Suggestions.render_suggestions_container(rt.new_string('orders-list-empty-footer'))
}

fn Class_WC_Marketplace_Suggestions.render_suggestions_container(var_context rt.PhpVal) {
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/views/container.php', '1')
}

fn Class_WC_Marketplace_Suggestions.show_suggestions_for_screen(var_screen_id rt.PhpVal) bool {
	mut var_screen_id_mutated := var_screen_id
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_screen_id_mutated.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'edit-product' },
			rt.ArrayItem{ key: none, val: 'edit-shop_order' },
			rt.ArrayItem{ key: none, val: 'product' },
			rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_screen_id', [
				rt.new_string('shop-order'),
			]) },
		]),
		rt.new_bool(true)])))))
	{
		return false
	}
	return (Class_WC_Marketplace_Suggestions.allow_suggestions()).to_bool()
}

fn Class_WC_Marketplace_Suggestions.maybe_trigger_suggestions_fetch() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	mut var_screen_id := if rt.is_true(var_screen) {
		rt.get_property(var_screen, 'id')
	} else {
		rt.new_string('')
	}
	if rt.is_true(rt.identical(rt.new_string('woocommerce_page_wc-admin'), var_screen_id))
		&& rt.is_true(Class_WC_Marketplace_Suggestions.allow_suggestions()) {
		Class_WC_Marketplace_Suggestions.get_suggestions_api_data()
	}
}

fn Class_WC_Marketplace_Suggestions.allow_suggestions() bool {
	mut var_locale := rt.call_function('get_locale', []rt.PhpVal{})
	mut var_suggestion_locales := ['en_AU', 'en_CA', 'en_GB', 'en_NZ', 'en_US', 'en_ZA']
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_locale.clone(), rt.create_array_from_list(var_suggestion_locales),
		rt.new_bool(true)])))))
	{
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('install_plugins'),
	])))))
	{
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [
		rt.new_string('woocommerce_show_marketplace_suggestions'),
		rt.new_string('yes'),
	])))
	{
		return false
	}
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_allow_marketplace_suggestions'),
		rt.new_bool(true),
	])).to_bool()
}

fn Class_WC_Marketplace_Suggestions.get_suggestions_api_data() rt.PhpVal {
	mut var_data := rt.call_function('get_option', [
		rt.new_string('woocommerce_marketplace_suggestions'),
		rt.new_array(),
	])
	if !rt.is_true(var_data.array_get(rt.new_string('updated')))
		|| rt.is_true(rt.greater(rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('WEEK_IN_SECONDS')), var_data.array_get(rt.new_string('updated')))) {
		mut var_next := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
			'queue', []rt.PhpVal{}), 'get_next', [
			rt.new_string('woocommerce_update_marketplace_suggestions'),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_next)))) {
			rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue',
				[]rt.PhpVal{}), 'cancel_all', [
				rt.new_string('woocommerce_update_marketplace_suggestions'),
			])
			rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'queue',
				[]rt.PhpVal{}), 'schedule_single', [
				rt.call_function('time', []rt.PhpVal{}),
				rt.new_string('woocommerce_update_marketplace_suggestions'),
			])
		}
	}
	return if !(!rt.is_true(var_data.array_get(rt.new_string('suggestions')))) {
		var_data.array_get(rt.new_string('suggestions'))
	} else {
		rt.new_array()
	}
}

fn create_wc_marketplace_suggestions(_args ...rt.PhpVal) &Class_WC_Marketplace_Suggestions {
	mut obj := &Class_WC_Marketplace_Suggestions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Marketplace_Suggestions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Marketplace_Suggestions.init()
			return rt.new_null()
		}
		'product_data_tabs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Marketplace_Suggestions.product_data_tabs(dispatch_arg_0)
		}
		'product_data_panels' {
			Class_WC_Marketplace_Suggestions.product_data_panels()
			return rt.new_null()
		}
		'get_dismissed_suggestions' {
			return Class_WC_Marketplace_Suggestions.get_dismissed_suggestions()
		}
		'post_add_dismissed_suggestion_handler' {
			Class_WC_Marketplace_Suggestions.post_add_dismissed_suggestion_handler()
			return rt.new_null()
		}
		'render_orders_list_empty_state' {
			Class_WC_Marketplace_Suggestions.render_orders_list_empty_state()
			return rt.new_null()
		}
		'render_suggestions_container' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Marketplace_Suggestions.render_suggestions_container(dispatch_arg_0)
			return rt.new_null()
		}
		'show_suggestions_for_screen' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Marketplace_Suggestions.show_suggestions_for_screen(dispatch_arg_0))
		}
		'maybe_trigger_suggestions_fetch' {
			Class_WC_Marketplace_Suggestions.maybe_trigger_suggestions_fetch()
			return rt.new_null()
		}
		'allow_suggestions' {
			return rt.new_bool(Class_WC_Marketplace_Suggestions.allow_suggestions())
		}
		'get_suggestions_api_data' {
			return Class_WC_Marketplace_Suggestions.get_suggestions_api_data()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Marketplace_Suggestions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Marketplace_Suggestions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	Class_WC_Marketplace_Suggestions.init()
}
