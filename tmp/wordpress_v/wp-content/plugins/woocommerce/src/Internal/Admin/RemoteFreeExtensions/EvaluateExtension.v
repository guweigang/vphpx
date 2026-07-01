import rt

struct Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension.evaluate(var_extension rt.PhpVal) rt.PhpVal {
	mut var_wp_version := rt.new_null()
	mut var_extension_mutated := var_extension
	// unsupported statement: Stmt_Global
	mut var_rule_evaluator := create_automattic_woocommerce_admin_remotespecs_ruleprocessors_ruleevaluator()
	if !(rt.get_property(var_extension_mutated, 'is_visible')).is_null() {
		mut var_is_visible := var_rule_evaluator.evaluate(rt.get_property(var_extension_mutated, 'is_visible'))
		rt.set_property(var_extension_mutated, 'is_visible', var_is_visible.dup())
	} else {
		rt.set_property(var_extension_mutated, 'is_visible', rt.new_bool(true))
	}
	if rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_extension_mutated, 'is_visible'))) {
		if rt.is_true(rt.new_bool(!(rt.get_property(var_extension_mutated, 'min_php_version')).is_null() && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'), rt.get_property(var_extension_mutated, 'min_php_version'), rt.new_string('>=')]))))))) {
			rt.set_property(var_extension_mutated, 'is_visible', rt.new_bool(false))
		}
		if rt.is_true(rt.new_bool(!(rt.get_property(var_extension_mutated, 'min_wp_version')).is_null() && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('version_compare', [var_wp_version.dup(), rt.get_property(var_extension_mutated, 'min_wp_version'), rt.new_string('>=')]))))))) {
			rt.set_property(var_extension_mutated, 'is_visible', rt.new_bool(false))
		}
	}
	mut var_installed_plugins := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_installed_plugin_slugs() }()
	mut var_activated_plugins := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_PluginsHelper{}; return temp.get_active_plugin_slugs() }()
	rt.set_property(var_extension_mutated, 'is_installed', rt.call_function('in_array', [rt.call_function('explode', [rt.new_string(':'), rt.get_property(var_extension_mutated, 'key')]).array_get(0), var_installed_plugins.dup(), rt.new_bool(true)]))
	rt.set_property(var_extension_mutated, 'is_activated', rt.call_function('in_array', [rt.call_function('explode', [rt.new_string(':'), rt.get_property(var_extension_mutated, 'key')]).array_get(0), var_activated_plugins.dup(), rt.new_bool(true)]))
	return var_extension_mutated.dup()
}

fn Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension.evaluate_bundles(var_specs rt.PhpVal, var_allowed_bundles rt.PhpVal) rt.PhpVal {
	mut var_bundles := rt.new_array()
	mut var_evaluate_order := create_automattic_woocommerce_admin_remotespecs_ruleprocessors_evaluateoverrides()
	mut var_context := rt.new_array()
	{
		mut iter_1 := var_specs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_spec := item_1.val
			var_spec = // unsupported expression: Expr_Cast_Object
			mut var_bundle := rt.cast_array(var_spec)
			var_bundle.array_set('plugins', rt.new_array())
			if rt.is_true(rt.new_bool(!(!rt.is_true(var_allowed_bundles)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_spec, 'key'), var_allowed_bundles.dup(), rt.new_bool(true)]))))))) {
				continue
			}
			mut var_errors := rt.new_array()
			{
				mut iter_2 := rt.get_property(var_spec, 'plugins').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_plugin := item_2.val
					mut var_extension := Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension.evaluate(// unsupported expression: Expr_Cast_Object)
					if rt.has_exception() { unsafe { goto catch_label_1 } }
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('property_exists', [var_extension.dup(), rt.new_string('is_visible')]))))) || rt.is_true(rt.get_property(var_extension, 'is_visible')))) {
						var_bundle.array_get_mut('plugins').array_push(var_extension.dup())
						if rt.has_exception() { unsafe { goto catch_label_1 } }
					}
					if rt.has_exception() { unsafe { goto catch_label_1 } }
					unsafe { goto end_label_1 }

catch_label_1:
					mut var_e_1 := rt.get_and_clear_exception()
					if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_Throwable') {
						mut var_e := var_e_1.dup()
						var_errors.array_push(var_e.dup())
						unsafe { goto end_label_1 }
					}
					else {
						rt.throw_exception(var_e_1)
						unsafe { goto end_label_1 }
					}

end_label_1:
				}
			}
			var_context.array_set('plugins', var_bundle.array_get('plugins'))
			var_bundle.array_set('plugins', var_evaluate_order.evaluate(var_bundle.array_get('plugins'), var_context.dup()))
			var_bundles.array_push(var_bundle.dup())
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'bundles', val: var_bundles }, rt.ArrayItem{ key: 'errors', val: var_errors }])
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_PluginsHelper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateOverrides {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_remotefreeextensions_evaluateextension() &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_ruleevaluator() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator{
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

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_evaluateoverrides() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateOverrides {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateOverrides{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'evaluate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension.evaluate(dispatch_arg_0)
		}
		'evaluate_bundles' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension.evaluate_bundles(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_RemoteFreeExtensions_EvaluateExtension) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_RuleEvaluator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateOverrides) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateOverrides) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_EvaluateOverrides) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_remotefreeextensions_evaluateextension_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
