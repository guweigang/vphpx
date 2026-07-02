import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask {
	rt.PhpObjectBase
pub mut:
	id              rt.PhpVal = rt.new_string('')
	additional_info rt.PhpVal = rt.new_string('')
	content         rt.PhpVal = rt.new_string('')
	is_complete     rt.PhpVal = rt.new_bool(false)
	is_snoozeable   rt.PhpVal = rt.new_bool(false)
	is_dismissable  rt.PhpVal = rt.new_bool(false)
	can_view        rt.PhpVal = rt.new_bool(true)
	level           rt.PhpVal = rt.new_int(3)
	time            rt.PhpVal = rt.new_null()
	title           rt.PhpVal = rt.new_string('')
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) construct(var_task_list rt.PhpVal, var_args rt.PhpVal) {
	this.Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.construct(var_task_list.clone())
	mut var_task_args := rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array([rt.ArrayItem{ key: 'id', val: rt.new_null() },
			rt.ArrayItem{ key: 'is_dismissable', val: false },
			rt.ArrayItem{ key: 'is_snoozeable', val: false },
			rt.ArrayItem{ key: 'can_view', val: true }, rt.ArrayItem{ key: 'level', val: 3 },
			rt.ArrayItem{ key: 'additional_info', val: rt.new_null() },
			rt.ArrayItem{ key: 'content', val: '' }, rt.ArrayItem{ key: 'title', val: '' },
			rt.ArrayItem{ key: 'is_complete', val: false }, rt.ArrayItem{
				key: 'time'
				val: rt.new_null()
			}])])
	this.id = var_task_args.array_get(rt.new_string('id'))
	this.additional_info = var_task_args.array_get(rt.new_string('additional_info'))
	this.content = var_task_args.array_get(rt.new_string('content'))
	this.is_complete = var_task_args.array_get(rt.new_string('is_complete'))
	this.is_dismissable = var_task_args.array_get(rt.new_string('is_dismissable'))
	this.is_snoozeable = var_task_args.array_get(rt.new_string('is_snoozeable'))
	this.can_view = var_task_args.array_get(rt.new_string('can_view'))
	this.level = var_task_args.array_get(rt.new_string('level'))
	this.time = var_task_args.array_get(rt.new_string('time'))
	this.title = var_task_args.array_get(rt.new_string('title'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) get_id() rt.PhpVal {
	return this.id
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) get_additional_info() rt.PhpVal {
	return this.additional_info
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) get_content() rt.PhpVal {
	return this.content
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) get_level() rt.PhpVal {
	return this.level
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) get_title() rt.PhpVal {
	return this.title
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) get_time() rt.PhpVal {
	return this.time
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) is_snoozeable() rt.PhpVal {
	return this.is_snoozeable
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) is_dismissable() rt.PhpVal {
	return this.is_dismissable
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) is_complete() rt.PhpVal {
	return this.is_complete
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) can_view() rt.PhpVal {
	return this.can_view
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_deprecatedextendedtask(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask{
		PhpObjectBase:   rt.PhpObjectBase{}
		id:              rt.new_string('')
		additional_info: rt.new_string('')
		content:         rt.new_string('')
		is_complete:     rt.new_bool(false)
		is_snoozeable:   rt.new_bool(false)
		is_dismissable:  rt.new_bool(false)
		can_view:        rt.new_bool(true)
		level:           rt.new_int(3)
		time:            rt.new_null()
		title:           rt.new_string('')
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_task(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_id' {
			return this.get_id()
		}
		'get_additional_info' {
			return this.get_additional_info()
		}
		'get_content' {
			return this.get_content()
		}
		'get_level' {
			return this.get_level()
		}
		'get_title' {
			return this.get_title()
		}
		'get_time' {
			return this.get_time()
		}
		'is_snoozeable' {
			return this.is_snoozeable()
		}
		'is_dismissable' {
			return this.is_dismissable()
		}
		'is_complete' {
			return this.is_complete()
		}
		'can_view' {
			return this.can_view()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'additional_info' { return this.additional_info }
		'content' { return this.content }
		'is_complete' { return this.is_complete }
		'is_snoozeable' { return this.is_snoozeable }
		'is_dismissable' { return this.is_dismissable }
		'can_view' { return this.can_view }
		'level' { return this.level }
		'time' { return this.time }
		'title' { return this.title }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		'additional_info' {
			this.additional_info = val
			return true
		}
		'content' {
			this.content = val
			return true
		}
		'is_complete' {
			this.is_complete = val
			return true
		}
		'is_snoozeable' {
			this.is_snoozeable = val
			return true
		}
		'is_dismissable' {
			this.is_dismissable = val
			return true
		}
		'can_view' {
			this.can_view = val
			return true
		}
		'level' {
			this.level = val
			return true
		}
		'time' {
			this.time = val
			return true
		}
		'title' {
			this.title = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
