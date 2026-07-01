import rt

struct Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init) construct()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_updated'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_specs_transient' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init.get_extensions(var_allowed_bundles rt.PhpVal) rt.PhpVal {
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	mut var_specs := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init.get_specs()
	mut var_results := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension{}; return temp.evaluate_bundles(arg_0, arg_1) }(var_specs.dup(), var_allowed_bundles.dup())
	mut var_specs_to_return := var_results.array_get('bundles')
	mut var_specs_to_save := rt.new_null()
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_bundle := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(rt.new_bool(var_bundle.array_get('plugins').array_count() > 0))
	}
	mut var_plugins := rt.call_function('array_filter', [var_results.array_get('bundles'), rt.new_closure(closure_1_fn)])
	if !rt.is_true(var_plugins) {
		var_specs_to_save = fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_DefaultFreeExtensions{}; return temp.get_all() }()
		var_specs_to_return = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension{}; return temp.evaluate_bundles(arg_0, arg_1) }(var_specs_to_save.dup(), var_allowed_bundles.dup()).array_get('bundles')
	} else if var_results.array_get('errors').array_count() > 0 {
		var_specs_to_save = var_specs.dup()
	}
	if var_results.array_get('errors').array_count() > 0 {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init{}; return temp.log_errors(arg_0) }(var_results.array_get('errors'))
	}
	if rt.is_true(var_specs_to_save) {
		rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller{}; return temp.get_instance() }(), 'set_specs_transient', [rt.create_array([rt.ArrayItem{ key: var_locale, val: var_specs_to_save }]), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	}
	return var_specs_to_return.dup()
}

fn Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init.delete_specs_transient()  {
	rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller{}; return temp.get_instance() }(), 'delete_specs_transient', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init.get_specs() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [rt.new_string('woocommerce_show_marketplace_suggestions'), rt.new_string('yes')]))) {
		return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_DefaultFreeExtensions{}; return temp.get_all() }()
	}
	mut var_specs := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller{}; return temp.get_instance() }(), 'get_specs_from_data_sources', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_specs)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_specs.dup().is_array()))))))) || 0 == var_specs.dup().array_count())) {
		return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_DefaultFreeExtensions{}; return temp.get_all() }()
	}
	return var_specs.dup()
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_DefaultFreeExtensions {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_init() &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_remotespecsengine() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_evaluateextension() &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_defaultfreeextensions() &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_DefaultFreeExtensions {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_DefaultFreeExtensions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_remotefreeextensionsdatasourcepoller() &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_extensions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init.get_extensions(dispatch_arg_0)
		}
		'delete_specs_transient' {
			Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init.delete_specs_transient()
			return rt.new_null()
		}
		'get_specs' {
			return Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init.get_specs()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_DefaultFreeExtensions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_DefaultFreeExtensions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_DefaultFreeExtensions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_remotefreeextensions_init_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
