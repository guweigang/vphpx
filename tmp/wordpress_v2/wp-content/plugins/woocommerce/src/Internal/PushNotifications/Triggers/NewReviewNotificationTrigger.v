import rt

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger) register() {
	rt.call_function('add_action', [rt.new_string('comment_post'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'on_comment_post' },
		]),
		rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger) on_comment_post(comment_id i64, var_comment_approved rt.PhpVal, mut var_commentdata Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_array) {
	if rt.is_true(rt.identical(rt.new_string('spam'), var_comment_approved))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('review'), if !(var_commentdata.array_get(rt.new_string('comment_type'))).is_null() { var_commentdata.array_get(rt.new_string('comment_type')) } else { rt.new_string('') })))) {
		return
	}
	mut var_commented_on := rt.call_function('get_post_type', [
		rt.new_int((if !(var_commentdata.array_get(rt.new_string('comment_post_ID'))).is_null() {
			var_commentdata.array_get(rt.new_string('comment_post_ID'))
		} else {
			rt.new_int(0)
		}).to_i64()),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('product'), var_commented_on)))) {
		return
	}
	rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore.class(),
	]), 'add', [
		create_automattic_woocommerce_internal_pushnotifications_notifications_newreviewnotification(rt.new_int(comment_id)),
	])
}

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_triggers_newreviewnotificationtrigger(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_pushnotifications_notifications_newreviewnotification(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'on_comment_post' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.on_comment_post(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Triggers_NewReviewNotificationTrigger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
