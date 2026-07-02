import rt

struct Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore {
	rt.PhpObjectBase
pub mut:
	enabled             bool
	dispatcher          rt.PhpVal = rt.new_null()
	pending             rt.PhpVal = rt.new_array()
	shutdown_registered bool
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore) init(mut var_dispatcher Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_InternalNotificationDispatcher) {
	this.dispatcher = var_dispatcher
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore) register() {
	this.enabled = true
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore) add(mut var_notification Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) {
	if !(this.enabled) {
		return
	}
	mut var_key := var_notification.get_identifier()
	if this.pending.array_isset(var_key) {
		return
	}
	this.pending.array_set(var_key, var_notification)
	this.schedule_safety_net(mut var_notification)
	if !(this.shutdown_registered) {
		rt.call_function('add_action', [rt.new_string('shutdown'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'dispatch_all' },
			])])
		this.shutdown_registered = true
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore) schedule_safety_net(mut var_notification Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification) {
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'type', val: var_notification.get_type() },
		rt.ArrayItem{ key: 'resource_id', val: var_notification.get_resource_id() },
	])
	if rt.is_true(rt.call_function('as_has_scheduled_action', [
		Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.safety_net_hook(),
		var_args.clone(),
		Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.action_scheduler_group(),
	]))
	{
		return
	}
	rt.call_function('as_schedule_single_action', [
		rt.add(rt.call_function('time', []rt.PhpVal{}),
			Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.safety_net_delay()),
		Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.safety_net_hook(),
		var_args.clone(),
		Class_Automattic_WooCommerce_Internal_PushNotifications_Services_NotificationProcessor.action_scheduler_group(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore) dispatch_all() {
	if !rt.is_true(this.pending) {
		return
	}
	rt.call_method(this.dispatcher, 'dispatch', [
		rt.call_function('array_values', [this.pending]),
	])
	this.enabled = false
	this.pending = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore) count() i64 {
	return this.pending.array_count()
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore) get_all() rt.PhpVal {
	return rt.call_function('array_values', [this.pending])
}

fn create_automattic_woocommerce_internal_pushnotifications_services_pendingnotificationstore(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore {
	mut obj := &Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore{
		PhpObjectBase:       rt.PhpObjectBase{}
		enabled:             false
		dispatcher:          rt.new_null()
		pending:             rt.new_array()
		shutdown_registered: false
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Dispatchers_InternalNotificationDispatcher](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'register' {
			this.register()
			return rt.new_null()
		}
		'add' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.add(mut dispatch_arg_0)
			return rt.new_null()
		}
		'schedule_safety_net' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_PushNotifications_Notifications_Notification](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.schedule_safety_net(mut dispatch_arg_0)
			return rt.new_null()
		}
		'dispatch_all' {
			this.dispatch_all()
			return rt.new_null()
		}
		'count' {
			return rt.new_int(this.count())
		}
		'get_all' {
			return this.get_all()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'enabled' { return rt.new_bool(this.enabled) }
		'dispatcher' { return this.dispatcher }
		'pending' { return this.pending }
		'shutdown_registered' { return rt.new_bool(this.shutdown_registered) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_PushNotifications_Services_PendingNotificationStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'enabled' {
			this.enabled = val.to_bool()
			return true
		}
		'dispatcher' {
			this.dispatcher = val
			return true
		}
		'pending' {
			this.pending = val
			return true
		}
		'shutdown_registered' {
			this.shutdown_registered = val.to_bool()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
