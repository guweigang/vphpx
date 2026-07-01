import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor {
	rt.PhpObjectBase
pub mut:
		plugins_provider rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor) construct(var_plugins_provider rt.PhpVal)  {
	this.plugins_provider = if rt.is_true(rt.identical(rt.new_null(), var_plugins_provider)) { create_automattic_woocommerce_admin_pluginsprovider_pluginsprovider() } else { var_plugins_provider }
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor) process(var_rule rt.PhpVal, var_stored_state rt.PhpVal) bool {
	mut var_active_plugin_slugs := rt.call_method(this.plugins_provider, 'get_active_plugin_slugs', []rt.PhpVal{})
	mut var_plugin_name := rt.call_function('apply_filters', [rt.new_string('wp_plugin_dependencies_slug'), rt.get_property(var_rule, 'plugin')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_plugin_name.dup(), var_active_plugin_slugs.dup(), rt.new_bool(true)]))))) {
		return false
	}
	mut var_plugin_data := rt.call_method(this.plugins_provider, 'get_plugin_data', [var_plugin_name.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_plugin_data.dup().is_array()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_plugin_data.dup().array_isset(rt.new_string('Version'))))))))) {
		return false
	}
	mut var_plugin_version := var_plugin_data.array_get('Version')
	return (rt.call_function('version_compare', [var_plugin_version.dup(), rt.get_property(var_rule, 'version'), rt.get_property(var_rule, 'operator')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor) validate(var_rule rt.PhpVal) bool {
	if !(!(rt.get_property(var_rule, 'plugin')).is_null()) {
		return false
	}
	if !(!(rt.get_property(var_rule, 'version')).is_null()) {
		return false
	}
	if !(!(rt.get_property(var_rule, 'operator')).is_null()) {
		return false
	}
	return true
}

struct Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_pluginversionruleprocessor(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
		plugins_provider: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_pluginsprovider_pluginsprovider() &Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'process' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.process(dispatch_arg_0, dispatch_arg_1))
		}
		'validate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'plugins_provider' { return this.plugins_provider }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginVersionRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'plugins_provider' { this.plugins_provider = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_remotespecs_ruleprocessors_pluginversionruleprocessor_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
