import rt

pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification.type() string {
	return 'store_review'
}
struct Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification) get_type() string {
	return (Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification.type()).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification) to_payload() rt.PhpVal {
	mut var_comment := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('get_comment'), this.get_resource_id()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_comment)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_comment, 'WP_Comment')))))))) {
		return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: 'type', val: this.get_type() }, rt.ArrayItem{ key: 'timestamp', val: rt.call_function('gmdate', [rt.new_string('c')]) }, rt.ArrayItem{ key: 'resource_id', val: this.get_resource_id() }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'format', val: '%1$s left a review on %2$s' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('wp_strip_all_tags', [rt.get_property(var_comment, 'comment_author')]) }, rt.ArrayItem{ key: none, val: rt.call_function('wp_strip_all_tags', [rt.call_function('get_the_title', [// unsupported expression: Expr_Cast_Int])]) }]) }]) }, rt.ArrayItem{ key: 'message', val: rt.create_array([rt.ArrayItem{ key: 'format', val: '%1$s' }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('wp_strip_all_tags', [rt.get_property(var_comment, 'comment_content')]) }]) }]) }, rt.ArrayItem{ key: 'icon', val: rt.call_function('get_avatar_url', [rt.get_property(var_comment, 'comment_author_email')]) }, rt.ArrayItem{ key: 'meta', val: rt.create_array([rt.ArrayItem{ key: 'comment_id', val: this.get_resource_id() }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification) has_meta(key string) bool {
	return (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('metadata_exists'), rt.new_string('comment'), this.get_resource_id(), rt.new_string(key)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification) write_meta(key string)  {
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('update_comment_meta'), this.get_resource_id(), rt.new_string(key), // unsupported expression: Expr_Cast_String])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification) delete_meta(key string)  {
	rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('delete_comment_meta'), this.get_resource_id(), rt.new_string(key)])
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_notifications_newreviewnotification() &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_notifications_notification() &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_type' {
			return rt.new_string(this.get_type())
		}
		'to_payload' {
			return this.to_payload()
		}
		'has_meta' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.has_meta(dispatch_arg_0))
		}
		'write_meta' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.write_meta(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_meta' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.delete_meta(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_pushnotifications_notifications_newreviewnotification_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
