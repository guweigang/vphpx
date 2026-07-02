import rt

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor {
	rt.PhpObjectBase
pub mut:
	plugins_provider rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor) construct(var_plugins_provider rt.PhpVal) {
	this.plugins_provider = if rt.is_true(rt.identical(rt.new_null(), var_plugins_provider)) {
		create_automattic_woocommerce_admin_pluginsprovider_pluginsprovider()
	} else {
		var_plugins_provider
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor) process(var_rule rt.PhpVal, var_stored_state rt.PhpVal) bool {
	if !(rt.call_function('is_countable', [rt.get_property(var_rule, 'plugins')]))
		|| 0 == rt.get_property(var_rule, 'plugins').array_count() {
		return false
	}
	mut var_active_plugin_slugs := rt.call_method(this.plugins_provider, 'get_active_plugin_slugs',
		[]rt.PhpVal{})
	mut iter_1 := rt.get_property(var_rule, 'plugins').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_plugin_slug := item_1.val
		if !(var_plugin_slug.clone().is_string()) {
			mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
			rt.call_method(var_logger, 'warning', [
				rt.call_function('__', [
					rt.new_string('Invalid plugin slug provided in the plugins activated rule.'),
					rt.new_string('woocommerce'),
				]),
			])
			return false
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_plugin_slug.clone(), var_active_plugin_slugs.clone(),
			rt.new_bool(true)])))))
		{
			return false
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor) validate(var_rule rt.PhpVal) bool {
	if !(!(rt.get_property(var_rule, 'plugins')).is_null())
		|| !(rt.get_property(var_rule, 'plugins').is_array()) {
		return false
	}
	return true
}

struct Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_pluginsactivatedruleprocessor(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor{
		PhpObjectBase:    rt.PhpObjectBase{}
		plugins_provider: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_pluginsprovider_pluginsprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider {
	mut obj := &Class_Automattic_WooCommerce_Admin_PluginsProvider_PluginsProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'plugins_provider' { return this.plugins_provider }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_PluginsActivatedRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'plugins_provider' {
			this.plugins_provider = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
