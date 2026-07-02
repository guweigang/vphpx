import rt

struct Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader) install(var_package rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_defaults := rt.create_array([
		rt.ArrayItem{ key: 'clear_update_cache', val: true },
	])
	mut var_parsed_args := rt.call_function('wp_parse_args', [
		var_args.clone(), var_defaults.clone()])
	this.init()
	this.install_strings()
	rt.call_function('add_filter', [rt.new_string('upgrader_source_selection'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader', [
				'Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'check_package' },
		])])
	rt.call_function('add_filter', [rt.new_string('upgrader_post_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader', [
				'Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'check_parent_theme_filter' },
		]),
		rt.new_int(10), rt.new_int(3)])
	if rt.is_true(var_parsed_args.array_get(rt.new_string('clear_update_cache'))) {
		rt.call_function('add_action', [rt.new_string('upgrader_process_complete'),
			rt.new_string('wp_clean_themes_cache'), rt.new_int(9),
			rt.new_int(0)])
	}
	mut var_result := this.run(rt.create_array([
		rt.ArrayItem{ key: 'package', val: var_package },
		rt.ArrayItem{ key: 'destination', val: rt.call_function('get_theme_root', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'clear_destination', val: false },
		rt.ArrayItem{ key: 'clear_working', val: true },
		rt.ArrayItem{ key: 'hook_extra', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'theme' },
			rt.ArrayItem{ key: 'action', val: 'install' },
		]) },
	]))
	rt.call_function('remove_action', [rt.new_string('upgrader_process_complete'),
		rt.new_string('wp_clean_themes_cache'), rt.new_int(9)])
	rt.call_function('remove_filter', [rt.new_string('upgrader_source_selection'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader', [
				'Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'check_package' },
		])])
	rt.call_function('remove_filter', [rt.new_string('upgrader_post_install'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader', [
				'Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader',
			], &this) },
			rt.ArrayItem{ key: none, val: 'check_parent_theme_filter' },
		])])
	if rt.is_true(var_result)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.clone()]))))) {
		rt.call_function('wp_clean_themes_cache', [
			var_parsed_args.array_get(rt.new_string('clear_update_cache')),
		])
	}
	return var_result.clone()
}

struct Class_Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_overrides_themeupgrader(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader {
	mut obj := &Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_overrides_theme_upgrader(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader {
	mut obj := &Class_Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'install' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.install(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
