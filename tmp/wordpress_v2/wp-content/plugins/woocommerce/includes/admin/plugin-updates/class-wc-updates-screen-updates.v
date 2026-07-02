import rt

struct Class_WC_Updates_Screen_Updates {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Updates_Screen_Updates) construct() {
	rt.call_function('add_action', [rt.new_string('admin_print_footer_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Updates_Screen_Updates', [
				'WC_Plugin_Updates',
			], &this) },
			rt.ArrayItem{ key: none, val: 'update_screen_modal' },
		])])
}

fn (mut this Class_WC_Updates_Screen_Updates) update_screen_modal() {
	mut var_updateable_plugins := rt.call_function('get_plugin_updates', []rt.PhpVal{})
	if !rt.is_true(var_updateable_plugins.array_get(rt.new_string('woocommerce/woocommerce.php')))
		|| !rt.is_true(rt.get_property(var_updateable_plugins.array_get(rt.new_string('woocommerce/woocommerce.php')), 'update'))
		|| !rt.is_true(rt.get_property(rt.get_property(var_updateable_plugins.array_get(rt.new_string('woocommerce/woocommerce.php')), 'update'), 'new_version')) {
		return
	}
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 :=
		iife_temp_0.get_constant(rt.new_string('WC_SSR_PLUGIN_UPDATE_RELEASE_VERSION_TYPE'))
	mut var_version_type := iife_result_0
	if !(var_version_type.clone().is_string()) {
		var_version_type = rt.new_string('none')
	}
	this.dispatch_set_prop('new_version', rt.call_function('wc_clean', [
		rt.get_property(rt.get_property(var_updateable_plugins.array_get(rt.new_string('woocommerce/woocommerce.php')),
			'update'), 'new_version'),
	]))
	this.dispatch_set_prop('major_untested_plugins', this.get_untested_plugins(rt.get_property(rt.new_object('WC_Updates_Screen_Updates', [
		'WC_Plugin_Updates',
	], &this), 'new_version'), var_version_type.clone()))
	if !(!rt.is_true(rt.get_property(rt.new_object('WC_Updates_Screen_Updates', [
		'WC_Plugin_Updates',
	], &this), 'major_untested_plugins'))) {
		rt.echo_val(this.get_extensions_modal_warning())
		this.update_screen_modal_js()
	}
}

fn (mut this Class_WC_Updates_Screen_Updates) update_screen_modal_js() {
	// unsupported statement: Stmt_InlineHTML
	this.generic_modal_js()
}

struct Class_WC_Plugin_Updates {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_wc_updates_screen_updates() &Class_WC_Updates_Screen_Updates {
	mut obj := &Class_WC_Updates_Screen_Updates{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_plugin_updates(_args ...rt.PhpVal) &Class_WC_Plugin_Updates {
	mut obj := &Class_WC_Plugin_Updates{
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

fn (mut this Class_WC_Updates_Screen_Updates) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'update_screen_modal' {
			this.update_screen_modal()
			return rt.new_null()
		}
		'update_screen_modal_js' {
			this.update_screen_modal_js()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Updates_Screen_Updates) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Updates_Screen_Updates) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Plugin_Updates) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Plugin_Updates) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Plugin_Updates) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Plugin_Updates'),
	])))))
	{
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/class-wc-plugin-updates.php', '2')
	}
	create_wc_updates_screen_updates()
}
