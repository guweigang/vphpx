import rt

pub fn Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification.notification_classes() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'store_order', val: Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewOrderNotification.class() }, rt.ArrayItem{ key: 'store_review', val: Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_NewReviewNotification.class() }])
}
struct Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification {
	rt.PhpObjectBase
pub mut:
		resource_id i64
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) construct(resource_id i64)  {
	mut resource_id_mutated := resource_id
	if resource_id_mutated <= 0 {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Notification resource_id must be positive.'))))
	}
	this.resource_id = (rt.new_int(resource_id_mutated)).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) get_type() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) to_payload()  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) has_meta(key string) bool {
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) write_meta(key string)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) delete_meta(key string)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) to_array() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: this.get_type() }, rt.ArrayItem{ key: 'resource_id', val: this.resource_id }])
}

fn Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification.from_array(mut var_data Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_array) rt.PhpVal {
	mut var_type := if !(var_data.array_get('type')).is_null() { var_data.array_get('type') } else { rt.new_string('') }
	mut var_resource_id := // unsupported expression: Expr_Cast_Int
	mut var_class := if !(Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification.notification_classes().array_get(var_type)).is_null() { Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification.notification_classes().array_get(var_type) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_class)))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.call_function('sprintf', [rt.new_string('Unknown notification type: %s'), var_type.dup()]))))
	}
	return rt.create_object_dynamically(var_class, [var_resource_id.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) get_identifier() string {
	return (rt.call_function('sprintf', [rt.new_string('%s_%s_%s'), rt.call_function('get_current_blog_id', []rt.PhpVal{}), this.get_type(), this.resource_id])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) get_resource_id() i64 {
	return this.resource_id
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_pushnotifications_notifications_notification(resource_id i64) &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification{
		PhpObjectBase: rt.PhpObjectBase{}
		resource_id: i64(0)
	}
	obj.construct(resource_id)
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_type' {
			return rt.new_string(this.get_type())
		}
		'to_payload' {
			this.to_payload()
			return rt.new_null()
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
		'to_array' {
			return this.to_array()
		}
		'from_array' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification.from_array(mut dispatch_arg_0)
		}
		'get_identifier' {
			return rt.new_string(this.get_identifier())
		}
		'get_resource_id' {
			return rt.new_int(this.get_resource_id())
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'resource_id' { return rt.new_int(this.resource_id) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'resource_id' { this.resource_id = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
		obj := create_automattic_woocommerce_internal_pushnotifications_notifications_notification(c_arg_0)
		return rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification', []string{}, obj)
	})
	rt.register_class_factory('InvalidArgumentException', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_invalidargumentexception()
		return rt.new_object('InvalidArgumentException', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_internal_pushnotifications_notifications_notification_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
