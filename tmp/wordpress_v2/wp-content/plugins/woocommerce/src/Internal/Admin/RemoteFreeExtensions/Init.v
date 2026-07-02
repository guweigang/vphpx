import rt

struct Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init) construct() {
	rt.call_function('add_action', [rt.new_string('woocommerce_updated'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'delete_specs_transient' }])])
}

fn Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init.get_extensions(var_allowed_bundles rt.PhpVal) rt.PhpVal {
	mut var_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	mut var_specs :=
		Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init.get_specs()
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension{}
	mut iife_result_0 := iife_temp_0.evaluate_bundles(var_specs.clone(),
		var_allowed_bundles.clone())
	mut var_results := iife_result_0
	mut var_specs_to_return := var_results.array_get(rt.new_string('bundles'))
	mut var_specs_to_save := rt.new_null()
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_bundle := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(var_bundle.array_get(rt.new_string('plugins')).array_count() > 0)
	}
	mut var_plugins := rt.call_function('array_filter', [
		var_results.array_get(rt.new_string('bundles')),
		rt.new_closure(closure_2_fn),
	])
	if !rt.is_true(var_plugins) {
		mut iife_temp_2 :=
			Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_DefaultFreeExtensions{}
		mut iife_result_2 := iife_temp_2.get_all()
		var_specs_to_save = iife_result_2
		mut iife_temp_3 :=
			Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension{}
		mut iife_result_3 := iife_temp_3.evaluate_bundles(var_specs_to_save.clone(),
			var_allowed_bundles.clone())
		var_specs_to_return = iife_result_3.array_get(rt.new_string('bundles'))
	} else if var_results.array_get(rt.new_string('errors')).array_count() > 0 {
		var_specs_to_save = var_specs.clone()
	}
	if var_results.array_get(rt.new_string('errors')).array_count() > 0 {
		mut iife_temp_4 := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init{}
		mut iife_result_4 := iife_temp_4.log_errors(var_results.array_get(rt.new_string('errors')))
	}
	if rt.is_true(var_specs_to_save) {
		mut iife_temp_5 :=
			Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller{}
		mut iife_result_5 := iife_temp_5.get_instance()
		rt.call_method(iife_result_5, 'set_specs_transient', [
			rt.create_array([rt.ArrayItem{ key: var_locale, val: var_specs_to_save }]),
			rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS')),
		])
	}
	return var_specs_to_return.clone()
}

fn Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init.delete_specs_transient() {
	mut iife_temp_6 :=
		Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller{}
	mut iife_result_6 := iife_temp_6.get_instance()
	rt.call_method(iife_result_6, 'delete_specs_transient', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Init.get_specs() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('no'), rt.call_function('get_option', [
		rt.new_string('woocommerce_show_marketplace_suggestions'),
		rt.new_string('yes'),
	])))
	{
		mut iife_temp_7 :=
			Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_DefaultFreeExtensions{}
		mut iife_result_7 := iife_temp_7.get_all()
		return iife_result_7
	}
	mut iife_temp_8 :=
		Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller{}
	mut iife_result_8 := iife_temp_8.get_instance()
	mut var_specs := rt.call_method(iife_result_8, 'get_specs_from_data_sources', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_bool(false), var_specs)) || !(var_specs.clone().is_array())
		|| 0 == var_specs.clone().array_count() {
		mut iife_temp_9 :=
			Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_DefaultFreeExtensions{}
		mut iife_result_9 := iife_temp_9.get_all()
		return iife_result_9
	}
	return var_specs.clone()
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

fn create_automattic_woocommerce_admin_remotespecs_remotespecsengine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RemoteSpecsEngine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_evaluateextension(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_defaultfreeextensions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_DefaultFreeExtensions {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_DefaultFreeExtensions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_remotefreeextensionsdatasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_RemoteFreeExtensionsDataSourcePoller {
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
		else {
			return none
		}
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
