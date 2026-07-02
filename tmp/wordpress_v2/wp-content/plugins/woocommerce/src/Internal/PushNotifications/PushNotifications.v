import rt

pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.feature_name() string {
	return 'push_notifications'
}

pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.roles_with_push_notifications_enabled() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'administrator' },
		rt.ArrayItem{ key: none, val: 'shop_manager' }])
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications {
	rt.PhpObjectBase
pub mut:
	enabled bool
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications) register() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_PushNotifications',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'on_init' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications) on_init() {
	if !(this.should_be_enabled()) {
		return
	}
	this.register_post_types()
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore.class(),
	]), 'register', []rt.PhpVal{})
	rt.call_method(create_automattic_woocommerce_internal_pushnotifications_controllers_pushtokenrestcontroller(),
		'register', []rt.PhpVal{})
	rt.call_method(create_automattic_woocommerce_internal_pushnotifications_controllers_pushnotificationrestcontroller(),
		'register', []rt.PhpVal{})
	rt.call_method(create_automattic_woocommerce_internal_pushnotifications_triggers_newordernotificationtrigger(),
		'register', []rt.PhpVal{})
	rt.call_method(create_automattic_woocommerce_internal_pushnotifications_triggers_newreviewnotificationtrigger(),
		'register', []rt.PhpVal{})
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.class(),
	]), 'register', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications) register_post_types() {
	rt.call_function('register_post_type', [
		Class_Automattic_WooCommerce_Internal_PushNotifications_Entities_PushToken.post_type(),
		rt.create_array([
			rt.ArrayItem{ key: 'labels', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
					rt.new_string('Push Tokens'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'singular_name', val: rt.call_function('__', [
					rt.new_string('Push Token'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'public', val: false },
			rt.ArrayItem{ key: 'publicly_queryable', val: false },
			rt.ArrayItem{ key: 'show_ui', val: false },
			rt.ArrayItem{ key: 'show_in_menu', val: false },
			rt.ArrayItem{ key: 'query_var', val: false },
			rt.ArrayItem{ key: 'rewrite', val: false },
			rt.ArrayItem{ key: 'capability_type', val: 'post' },
			rt.ArrayItem{ key: 'has_archive', val: false },
			rt.ArrayItem{ key: 'hierarchical', val: false },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'author' },
			]) },
			rt.ArrayItem{ key: 'can_export', val: false },
			rt.ArrayItem{ key: 'delete_with_user', val: true },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications) should_be_enabled() bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.enabled)))) {
		return this.enabled
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_FeaturesUtil{}
	mut iife_result_0 :=
		iife_temp_0.feature_is_enabled(Class_Automattic_WooCommerce_Internal_PushNotifications_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications.feature_name())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		this.enabled = false
		return this.enabled
	}
	mut var_proxy := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Proxies_LegacyProxy.class(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.enabled =
		rt.is_true(rt.call_function('class_exists', [Class_Automattic_Jetpack_Connection_Manager.class()]))
		&& rt.is_true(rt.call_method(rt.call_method(var_proxy, 'get_instance_of', [Class_Automattic_Jetpack_Connection_Manager.class()]), 'is_connected', []rt.PhpVal{}))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		mut var_logger := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Proxies_LegacyProxy.class(),
		]), 'call_function', [rt.new_string('wc_get_logger')])
		if rt.is_true(rt.new_bool(rt.instance_of(var_logger, 'WC_Logger'))) {
			rt.call_method(var_logger, 'error', [
				rt.new_string(
					'Error determining if PushNotifications feature should be enabled: ' +
					(rt.call_method(var_e, 'getMessage', []rt.PhpVal{})).str()),
			])
		}
		this.enabled = false
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return this.enabled
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_pushnotifications(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications{
		PhpObjectBase: rt.PhpObjectBase{}
		enabled:       false
	}
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_controllers_pushtokenrestcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_controllers_pushnotificationrestcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_triggers_newordernotificationtrigger(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_triggers_newreviewnotificationtrigger(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_featuresutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_FeaturesUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_FeaturesUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'on_init' {
			this.on_init()
			return rt.new_null()
		}
		'register_post_types' {
			this.register_post_types()
			return rt.new_null()
		}
		'should_be_enabled' {
			return rt.new_bool(this.should_be_enabled())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'enabled' { return rt.new_bool(this.enabled) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_PushNotifications) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'enabled' {
			this.enabled = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushTokenRestController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Controllers_PushNotificationRestController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewOrderNotificationTrigger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_FeaturesUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
