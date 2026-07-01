import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins.note_name() string {
	return 'wc-admin-install-jp-and-wcs-plugins'
}
struct Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins) construct()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_note_action_install-jp-and-wcs-plugins'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'install_jp_and_wcs_plugins' }])])
	rt.call_function('add_action', [rt.new_string('activated_plugin'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'action_note' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_plugins_install_api_error'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'on_install_error' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_plugins_install_error'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'on_install_error' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_plugins_activate_error'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'on_install_error' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins.get_note() rt.PhpVal {
	mut var_content := rt.call_function('__', [rt.new_string('We noticed that there was a problem during the Jetpack and WooCommerce Shipping & Tax install. Please try again and enjoy all the advantages of having the plugins connected to your store! Sorry for the inconvenience. The "Jetpack" and "WooCommerce Shipping & Tax" plugins will be installed & activated for free.'), rt.new_string('woocommerce')])
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	rt.call_method(var_note, 'set_title', [rt.call_function('__', [rt.new_string('Uh oh... There was a problem during the Jetpack and WooCommerce Shipping & Tax install. Please try again.'), rt.new_string('woocommerce')])])
	rt.call_method(var_note, 'set_content', [var_content.dup()])
	rt.call_method(var_note, 'set_content_data', [// unsupported expression: Expr_Cast_Object])
	rt.call_method(var_note, 'set_type', [Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational()])
	rt.call_method(var_note, 'set_name', [Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins.note_name()])
	rt.call_method(var_note, 'set_source', [rt.new_string('woocommerce-admin')])
	rt.call_method(var_note, 'add_action', [rt.new_string('install-jp-and-wcs-plugins'), rt.call_function('__', [rt.new_string('Install plugins'), rt.new_string('woocommerce')]), rt.new_bool(false), Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned()])
	return var_note.dup()
}

fn Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins.action_note()  {
	mut var_active_plugin_slugs := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_active_plugin_slugs() }()
	mut var_jp_active := rt.call_function('in_array', [rt.new_string('jetpack'), var_active_plugin_slugs.dup(), rt.new_bool(true)])
	mut var_wcs_active := rt.call_function('in_array', [rt.new_string('woocommerce-services'), var_active_plugin_slugs.dup(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_jp_active)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_wcs_active)))))) {
		return rt.new_null()
	}
	mut var_data_store := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.load_data_store() }()
	mut var_note_ids := rt.call_method(var_data_store, 'get_notes_with_name', [Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins.note_name()])
	{
		mut iter_1 := var_note_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_note_id := item_1.val
			mut var_note := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.get_note(arg_0) }(var_note_id.dup())
			if rt.is_true(var_note) {
				rt.call_method(var_note, 'set_status', [Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned()])
				rt.call_method(var_note, 'save', []rt.PhpVal{})
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins) install_jp_and_wcs_plugins(var_note rt.PhpVal)  {
	mut var_note_mutated := var_note
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	this.install_and_activate_plugin(rt.new_string('jetpack'))
	this.install_and_activate_plugin(rt.new_string('woocommerce-services'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins) install_and_activate_plugin(var_plugin rt.PhpVal)  {
	mut var_install_request := rt.create_array([rt.ArrayItem{ key: 'plugin', val: var_plugin }])
	mut var_installer := create_automattic_woocommerce_internal_admin_notes_automattic_woocommerce_admin_api_onboardingplugins()
	mut var_result := var_installer.install_plugin(var_install_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		return rt.new_null()
	}
	mut var_activate_request := rt.create_array([rt.ArrayItem{ key: 'plugins', val: var_plugin }])
	var_installer.activate_plugins(var_activate_request.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins) on_install_error(var_slug rt.PhpVal)  {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return rt.new_null()
	}
	fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins{}; return temp.possibly_add_note() }()
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Admin_API_OnboardingPlugins {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_notes_installjpandwcsplugins() &Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_notes_note() &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_pluginshelper() &Class_Automattic_WooCommerce_Admin_PluginsHelper {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsHelper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes() &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_notes_automattic_woocommerce_admin_api_onboardingplugins() &Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Admin_API_OnboardingPlugins {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Admin_API_OnboardingPlugins{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_note' {
			return Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins.get_note()
		}
		'action_note' {
			Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins.action_note()
			return rt.new_null()
		}
		'install_jp_and_wcs_plugins' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.install_jp_and_wcs_plugins(dispatch_arg_0)
			return rt.new_null()
		}
		'install_and_activate_plugin' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.install_and_activate_plugin(dispatch_arg_0)
			return rt.new_null()
		}
		'on_install_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.on_install_error(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_InstallJPAndWCSPlugins) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Admin_API_OnboardingPlugins) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Admin_API_OnboardingPlugins) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Notes_Automattic_WooCommerce_Admin_API_OnboardingPlugins) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_notes_installjpandwcsplugins_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
