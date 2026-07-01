import rt

pub fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller.id() string {
	return 'remote_inbox_notifications'
}
pub fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller.data_sources() rt.PhpVal {
	return rt.new_array()
}
struct Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller {
	rt.PhpObjectBase
pub mut:
		instance rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller) validate_spec(var_spec rt.PhpVal, var_url rt.PhpVal) bool {
	mut var_logger := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller{}; return temp.get_logger() }()
	mut var_logger_context := rt.create_array([rt.ArrayItem{ key: 'source', val: var_url }])
	if !(!(rt.get_property(var_spec, 'slug')).is_null()) {
		rt.call_method(var_logger, 'error', [rt.new_string('Spec is invalid because the slug is missing in feed'), var_logger_context.dup()])
		rt.call_method(var_logger, 'error', [println(var_spec.dup().to_string()), var_logger_context.dup()])
		return false
	}
	if !(!(rt.get_property(var_spec, 'status')).is_null()) {
		rt.call_method(var_logger, 'error', [rt.new_string('Spec is invalid because the status is missing in feed'), var_logger_context.dup()])
		rt.call_method(var_logger, 'error', [println(var_spec.dup().to_string()), var_logger_context.dup()])
		return false
	}
	if rt.is_true(rt.new_bool(!(!(rt.get_property(var_spec, 'locales')).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_spec, 'locales').is_array()))))))) {
		rt.call_method(var_logger, 'error', [rt.new_string('Spec is invalid because the status is missing or empty in feed'), var_logger_context.dup()])
		rt.call_method(var_logger, 'error', [println(var_spec.dup().to_string()), var_logger_context.dup()])
		return false
	}
	if rt.is_true(rt.identical(rt.new_null(), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner{}; return temp.get_locale(arg_0) }(rt.get_property(var_spec, 'locales')))) {
		rt.call_method(var_logger, 'error', [rt.new_string('Spec is invalid because the locale could not be retrieved in feed'), var_logger_context.dup()])
		rt.call_method(var_logger, 'error', [println(var_spec.dup().to_string()), var_logger_context.dup()])
		return false
	}
	if !(!(rt.get_property(var_spec, 'type')).is_null()) {
		rt.call_method(var_logger, 'error', [rt.new_string('Spec is invalid because the type is missing in feed'), var_logger_context.dup()])
		rt.call_method(var_logger, 'error', [println(var_spec.dup().to_string()), var_logger_context.dup()])
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.get_property(var_spec, 'actions')).is_null() && rt.is_true(rt.new_bool(rt.get_property(var_spec, 'actions').is_array())))) {
		{
			mut iter_1 := rt.get_property(var_spec, 'actions').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_action := item_1.val
				if !(this.validate_action(var_action.dup(), var_url.dup())) {
					rt.call_method(var_logger, 'error', [rt.new_string('Spec is invalid because an action is invalid in feed'), var_logger_context.dup()])
					rt.call_method(var_logger, 'error', [println(var_spec.dup().to_string()), var_logger_context.dup()])
					return false
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.get_property(var_spec, 'rules')).is_null() && rt.is_true(rt.new_bool(rt.get_property(var_spec, 'rules').is_array())))) {
		{
			mut iter_1 := rt.get_property(var_spec, 'rules').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_rule := item_1.val
				if !(!(rt.get_property(var_rule, 'type')).is_null()) {
					rt.call_method(var_logger, 'error', [rt.new_string('Spec is invalid because a rule type is empty in feed'), var_logger_context.dup()])
					rt.call_method(var_logger, 'error', [println(var_rule.dup().to_string()), var_logger_context.dup()])
					rt.call_method(var_logger, 'error', [println(var_spec.dup().to_string()), var_logger_context.dup()])
					return false
				}
				mut var_processor := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor{}; return temp.get_processor(arg_0) }(rt.get_property(var_rule, 'type'))
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_processor, 'validate', [var_rule.dup()]))))) {
					rt.call_method(var_logger, 'error', [rt.new_string('Spec is invalid because a rule is invalid in feed'), var_logger_context.dup()])
					rt.call_method(var_logger, 'error', [println(var_rule.dup().to_string()), var_logger_context.dup()])
					rt.call_method(var_logger, 'error', [println(var_spec.dup().to_string()), var_logger_context.dup()])
					return false
				}
			}
		}
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller) validate_action(var_action rt.PhpVal, var_url rt.PhpVal) bool {
	mut var_logger := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller{}; return temp.get_logger() }()
	mut var_logger_context := rt.create_array([rt.ArrayItem{ key: 'source', val: var_url }])
	if rt.is_true(rt.new_bool(!(!(rt.get_property(var_action, 'locales')).is_null()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_action, 'locales').is_array()))))))) {
		rt.call_method(var_logger, 'error', [rt.new_string('Action is invalid because it has empty or missing locales in feed'), var_logger_context.dup()])
		rt.call_method(var_logger, 'error', [println(var_action.dup().to_string()), var_logger_context.dup()])
		return false
	}
	if rt.is_true(rt.identical(rt.new_null(), fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner{}; return temp.get_action_locale(arg_0) }(rt.get_property(var_action, 'locales')))) {
		rt.call_method(var_logger, 'error', [rt.new_string('Action is invalid because the locale could not be retrieved in feed'), var_logger_context.dup()])
		rt.call_method(var_logger, 'error', [println(var_action.dup().to_string()), var_logger_context.dup()])
		return false
	}
	if !(!(rt.get_property(var_action, 'name')).is_null()) {
		rt.call_method(var_logger, 'error', [rt.new_string('Action is invalid because the name is missing in feed'), var_logger_context.dup()])
		rt.call_method(var_logger, 'error', [println(var_action.dup().to_string()), var_logger_context.dup()])
		return false
	}
	if !(!(rt.get_property(var_action, 'status')).is_null()) {
		rt.call_method(var_logger, 'error', [rt.new_string('Action is invalid because the status is missing in feed'), var_logger_context.dup()])
		rt.call_method(var_logger, 'error', [println(var_action.dup().to_string()), var_logger_context.dup()])
		return false
	}
	return true
}

fn Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller.get_data_sources() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: (fn () rt.PhpVal { mut temp := Class_WC_Helper{}; return temp.get_woocommerce_com_base_url() }()).str() + 'wp-json/wccom/inbox-notifications/2.0/notifications.json' }])
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_remoteinboxnotifications_remoteinboxnotificationsdatasourcepoller() &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_datasourcepoller() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remoteinboxnotifications_specrunner() &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_ruleprocessors_getruleprocessor() &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper() &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller.get_instance()
		}
		'validate_spec' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.validate_spec(dispatch_arg_0, dispatch_arg_1))
		}
		'validate_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.validate_action(dispatch_arg_0, dispatch_arg_1))
		}
		'get_data_sources' {
			return Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller.get_data_sources()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_RemoteInboxNotificationsDataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteInboxNotifications_SpecRunner) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_RuleProcessors_GetRuleProcessor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_remoteinboxnotifications_remoteinboxnotificationsdatasourcepoller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
