import rt

struct Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge) init() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'init_hooks' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge) init_hooks() {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])))))))
	{
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_bar_menu'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'site_visibility_badge' },
		]),
		rt.new_int(31)])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_css' },
		])])
	rt.call_function('add_action', [rt.new_string('admin_head'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'output_css' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge) site_visibility_badge(var_wp_admin_bar rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		return temp.feature_is_enabled(arg_0)
	}(rt.new_string('site_visibility_badge'))))))
	{
		return rt.new_null()
	}
	mut var_labels := rt.create_array([
		rt.ArrayItem{ key: 'coming-soon', val: rt.call_function('__', [
			rt.new_string('Coming soon'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'store-coming-soon', val: rt.call_function('__', [
			rt.new_string('Store coming soon'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'live', val: rt.call_function('__', [
			rt.new_string('Live'),
			rt.new_string('woocommerce'),
		]) },
	])
	if rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_coming_soon'),
	]), rt.new_string('yes')))
	{
		if rt.is_true(rt.identical(rt.call_function('get_option', [
			rt.new_string('woocommerce_store_pages_only'),
		]), rt.new_string('yes')))
		{
			mut var_key := rt.new_string(rt.new_string('store-coming-soon'))
		} else {
			var_key = rt.new_string(rt.new_string('coming-soon'))
		}
	} else {
		var_key = rt.new_string(rt.new_string('live'))
	}
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'id', val: 'woocommerce-site-visibility-badge' },
		rt.ArrayItem{ key: 'title', val: var_labels.array_get(var_key) },
		rt.ArrayItem{ key: 'href', val: rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-settings&tab=site-visibility'),
		]) },
		rt.ArrayItem{ key: 'meta', val: rt.create_array([
			rt.ArrayItem{ key: 'class', val: 'woocommerce-site-status-badge-' + var_key.str() },
		]) },
	])
	rt.call_method(var_wp_admin_bar, 'add_node', [var_args.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge) output_css() {
	if rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
		return temp.feature_is_enabled(arg_0)
	}(rt.new_string('site_visibility_badge'))))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_admin_bar_showing', []rt.PhpVal{})) {
		print('<style>\n\t\t\t\t#wpadminbar .quicklinks #wp-admin-bar-woocommerce-site-visibility-badge {\n\t\t\t\t\tpadding: 7px 0;\n\t\t\t\t}\n\n\t\t\t\t#wpadminbar .quicklinks #wp-admin-bar-woocommerce-site-visibility-badge a.ab-item {\n\t\t\t\t\t/* Layout  */\n\t\t\t\t\tbackground-color: #F6F7F7;\n\t\t\t\t\tborder-radius: 2px;\n\t\t\t\t\tdisplay: flex;\n\t\t\t\t\theight: 18px;\n\t\t\t\t\tpadding: 0px 6px;\n\t\t\t\t\talign-items: center;\n\t\t\t\t\tgap: 8px;\n\n\t\t\t\t\t/* Typography  */\n\t\t\t\t\tcolor: #3C434A;\n\t\t\t\t\tfont-size: 12px;\n\t\t\t\t\tfont-style: normal;\n\t\t\t\t\tfont-weight: 500;\n\t\t\t\t\tline-height: 16px;\n\t\t\t\t}\n\n\t\t\t\t#wpadminbar .quicklinks #wp-admin-bar-woocommerce-site-visibility-badge a.ab-item:hover,\n\t\t\t\t#wpadminbar .quicklinks #wp-admin-bar-woocommerce-site-visibility-badge a.ab-item:focus {\n\t\t\t\t\tbackground-color: #DCDCDE;\n\t\t\t\t}\n\n\t\t\t\t#wpadminbar .quicklinks #wp-admin-bar-woocommerce-site-visibility-badge a.ab-item:focus {\n\t\t\t\t\toutline: var(--wp-admin-border-width-focus) solid var(--wp-admin-theme-color-darker-20);\n\t\t\t\t}\n\n\t\t\t\t#wpadminbar .quicklinks #wp-admin-bar-woocommerce-site-visibility-badge.woocommerce-site-status-badge-live a.ab-item {\n\t\t\t\t\tbackground-color: #E6F2E8;\n\t\t\t\t\tcolor: #00450C;\n\t\t\t\t}\n\n\t\t\t\t#wpadminbar .quicklinks #wp-admin-bar-woocommerce-site-visibility-badge.woocommerce-site-status-badge-live a.ab-item:hover,\n\t\t\t\t#wpadminbar .quicklinks #wp-admin-bar-woocommerce-site-visibility-badge.woocommerce-site-status-badge-live a.ab-item:focus {\n\t\t\t\t\tbackground-color: #B8E6BF;\n\t\t\t\t}\n\t\t\t</style>')
	}
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_comingsoon_comingsoonadminbarbadge() &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge {
	mut obj := &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil() &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'init_hooks' {
			this.init_hooks()
			return rt.new_null()
		}
		'site_visibility_badge' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.site_visibility_badge(dispatch_arg_0)
			return rt.new_null()
		}
		'output_css' {
			this.output_css()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ComingSoon_ComingSoonAdminBarBadge) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_comingsoon_comingsoonadminbarbadge_php() {
	// unsupported statement: Stmt_Declare
}
