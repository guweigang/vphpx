import rt

pub fn Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions.disallowed_options() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'siteurl' }, rt.ArrayItem{ key: none, val: 'home' }, rt.ArrayItem{ key: none, val: 'admin_email' }, rt.ArrayItem{ key: none, val: 'wp_user_roles' }, rt.ArrayItem{ key: none, val: 'active_plugins' }, rt.ArrayItem{ key: none, val: 'template' }, rt.ArrayItem{ key: none, val: 'stylesheet' }, rt.ArrayItem{ key: none, val: 'default_role' }, rt.ArrayItem{ key: none, val: 'ftp_hostname' }, rt.ArrayItem{ key: none, val: 'ftp_username' }, rt.ArrayItem{ key: none, val: 'ftp_password' }, rt.ArrayItem{ key: none, val: 'ftp_port' }, rt.ArrayItem{ key: none, val: 'ftp_ssl' }, rt.ArrayItem{ key: none, val: 'ftp_pasv' }, rt.ArrayItem{ key: none, val: 'rewrite_rules' }, rt.ArrayItem{ key: none, val: 'permalink_structure' }, rt.ArrayItem{ key: none, val: 'cron' }, rt.ArrayItem{ key: none, val: 'upload_path' }, rt.ArrayItem{ key: none, val: 'upload_url_path' }, rt.ArrayItem{ key: none, val: 'mailserver_url' }, rt.ArrayItem{ key: none, val: 'mailserver_login' }, rt.ArrayItem{ key: none, val: 'mailserver_pass' }, rt.ArrayItem{ key: none, val: 'mailserver_port' }])
}
struct Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions {
	rt.PhpObjectBase
pub mut:
		plugins rt.PhpVal = rt.new_null()
		slug string
		logger rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions) construct(mut var_plugins Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_array, slug string, mut var_logger Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_?WC_Logger_Interface)  {
	this.plugins = var_plugins.dup()
	this.slug = slug
	this.logger = if !(var_logger).is_null() { var_logger } else { rt.call_function('wc_get_logger', []rt.PhpVal{}) }
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions) get_install_options(plugin_slug string) rt.PhpVal {
	{
		mut iter_1 := this.plugins.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_plugin := item_1.val
			if this.matches_plugin_slug(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_object](var_plugin), plugin_slug) {
				return if !(rt.get_property(var_plugin, 'install_options')).is_null() { rt.get_property(var_plugin, 'install_options') } else { rt.new_null() }
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions) process_install_options()  {
	mut var_install_options := this.get_install_options(this.slug)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_install_options)))) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_install_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_install_option := item_1.val
			this.add_install_option(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_object](var_install_option))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions) add_install_option(mut var_install_option Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_object)  {
	mut var_install_option_mutated := var_install_option
	mut var_default_options := rt.create_array([rt.ArrayItem{ key: 'force_array', val: false }, rt.ArrayItem{ key: 'autoload', val: false }])
	mut var_options := if !(rt.get_property(var_install_option_mutated, 'options')).is_null() { // unsupported expression: Expr_Cast_Object } else { create_automattic_woocommerce_internal_admin_remotefreeextensions_stdclass() }
	{
		mut iter_1 := var_default_options.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if !(!(rt.get_property(var_options, '{"nodeType":"Expr_Variable","line":118,"name":"key"}')).is_null()) {
				rt.set_property(var_options, '{"nodeType":"Expr_Variable","line":119,"name":"key"}', var_value.dup())
			}
		}
	}
	if rt.is_true(rt.get_property(var_options, 'force_array')) {
		rt.set_property(var_install_option_mutated, 'value', rt.call_function('json_decode', [rt.call_function('wp_json_encode', [rt.get_property(var_install_option_mutated, 'value')]), rt.new_bool(true)]))
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.new_bool(rt.is_true(this.logger) && rt.is_true(rt.call_method(this.logger, 'error', ['Failed to decode JSON for install option value for ' + (rt.get_property(var_install_option_mutated, 'name')).str() + ': ' + (rt.call_function('json_last_error_msg', []rt.PhpVal{})).str()])))
			return rt.new_null()
		}
	}
	mut var_autoload := rt.new_null()
	if !(rt.get_property(var_options, 'autoload')).is_null() {
		if rt.is_true(rt.identical(rt.new_string('yes'), rt.get_property(var_options, 'autoload'))) {
			var_autoload = rt.new_bool(rt.new_bool(true))
		} else if rt.is_true(rt.identical(rt.new_string('no'), rt.get_property(var_options, 'autoload'))) {
			var_autoload = rt.new_bool(rt.new_bool(false))
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_options, 'autoload'))) || rt.is_true(rt.identical(rt.new_bool(false), rt.get_property(var_options, 'autoload'))))) {
			var_autoload = rt.get_property(var_options, 'autoload')
		}
	}
	this.add_option((rt.get_property(var_install_option_mutated, 'name')).str(), rt.get_property(var_install_option_mutated, 'value'), var_autoload.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions) add_option(name string, var_value rt.PhpVal, var_autoload rt.PhpVal)  {
	mut var_autoload_mutated := var_autoload
	if rt.is_true(rt.call_function('in_array', [rt.new_string(name), Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions.disallowed_options(), rt.new_bool(true)])) {
		rt.new_bool(rt.is_true(this.logger) && rt.is_true(rt.call_method(this.logger, 'error', ['Disallowed option: ' + name])))
		return rt.new_null()
	}
	rt.call_function('add_option', [rt.new_string(name), var_value.dup(), rt.new_string(''), var_autoload_mutated.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions) matches_plugin_slug(mut var_plugin Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_object, plugin_slug string) bool {
	return (rt.identical(rt.call_function('explode', [rt.new_string(':'), rt.get_property(var_plugin, 'key')]).array_get(0), rt.new_string(plugin_slug))).to_bool()
}

struct Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_stdClass {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_processcoreprofilerplugininstalloptions(arg_0 rt.PhpVal, slug string, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions{
		PhpObjectBase: rt.PhpObjectBase{}
		plugins: rt.new_null()
		slug: ''
		logger: rt.new_null()
	}
	obj.construct(arg_0, slug, arg_2)
	return obj
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_stdclass() &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_stdClass {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_?WC_Logger_Interface](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'get_install_options' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_install_options(dispatch_arg_0)
		}
		'process_install_options' {
			this.process_install_options()
			return rt.new_null()
		}
		'add_install_option' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_object](if args.len > 0 { args[0] } else { rt.new_null() })
			this.add_install_option(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_option' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.add_option(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'matches_plugin_slug' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_object](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.matches_plugin_slug(mut dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'plugins' { return this.plugins }
		'slug' { return rt.new_string(this.slug) }
		'logger' { return this.logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_ProcessCoreProfilerPluginInstallOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'plugins' { this.plugins = val; return true }
		'slug' { this.slug = (val).str(); return true }
		'logger' { this.logger = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_remotefreeextensions_processcoreprofilerplugininstalloptions_php() {
	// unsupported statement: Stmt_Declare
}
