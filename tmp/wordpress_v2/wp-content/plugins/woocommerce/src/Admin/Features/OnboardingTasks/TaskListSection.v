import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskListSection {
	rt.PhpObjectBase
pub mut:
	id          rt.PhpVal = rt.new_string('')
	title       rt.PhpVal = rt.new_string('')
	description rt.PhpVal = rt.new_string('')
	image       rt.PhpVal = rt.new_string('')
	task_names  rt.PhpVal = rt.new_array()
	task_list   rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskListSection) construct(var_data rt.PhpVal, var_task_list rt.PhpVal) {
	mut var_data_mutated := var_data
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'id', val: '' },
		rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'description', val: '' },
		rt.ArrayItem{ key: 'image', val: '' }, rt.ArrayItem{ key: 'tasks', val: rt.new_array() }])
	var_data_mutated = rt.call_function('wp_parse_args', [var_data_mutated.clone(),
		var_defaults.clone()])
	this.task_list = var_task_list.clone()
	this.id = var_data_mutated.array_get(rt.new_string('id'))
	this.title = var_data_mutated.array_get(rt.new_string('title'))
	this.description = var_data_mutated.array_get(rt.new_string('description'))
	this.image = var_data_mutated.array_get(rt.new_string('image'))
	this.task_names = var_data_mutated.array_get(rt.new_string('task_names'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskListSection) is_complete() rt.PhpVal {
	mut var_complete := rt.new_bool(true)
	mut iter_1 := this.task_names.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_task_name := item_1.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.task_list))))
			&& rt.get_property(this.task_list, 'task_class_id_map').array_isset(var_task_name) {
			mut var_task := rt.call_method(this.task_list, 'get_task', [
				rt.get_property(this.task_list, 'task_class_id_map').array_get(var_task_name),
			])
			if rt.is_true(rt.call_method(var_task, 'can_view', []rt.PhpVal{}))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_task, 'is_complete', []rt.PhpVal{}))))) {
				var_complete = rt.new_bool(false)
				break
			}
		}
	}
	return var_complete.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskListSection) get_json() rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_task_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.task_list))))
			&& rt.get_property(this.task_list, 'task_class_id_map').array_isset(var_task_name) {
			return rt.get_property(this.task_list, 'task_class_id_map').array_get(var_task_name)
		}
		return rt.new_string('')
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_task_name := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.task_list))))
			&& rt.get_property(this.task_list, 'task_class_id_map').array_isset(var_task_name) {
			return rt.get_property(this.task_list, 'task_class_id_map').array_get(var_task_name)
		}
		return rt.new_string('')
	}
	return rt.create_array([rt.ArrayItem{ key: 'id', val: this.id },
		rt.ArrayItem{ key: 'title', val: this.title }, rt.ArrayItem{
			key: 'description'
			val: this.description
		}, rt.ArrayItem{ key: 'image', val: this.image }, rt.ArrayItem{ key: 'tasks', val: rt.call_function('array_map', [
			rt.new_closure(closure_1_fn),
			this.task_names,
		]) }, rt.ArrayItem{ key: 'isComplete', val: this.is_complete() }])
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasklistsection(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskListSection {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskListSection{
		PhpObjectBase: rt.PhpObjectBase{}
		id:            rt.new_string('')
		title:         rt.new_string('')
		description:   rt.new_string('')
		image:         rt.new_string('')
		task_names:    rt.new_array()
		task_list:     rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskListSection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'is_complete' {
			return this.is_complete()
		}
		'get_json' {
			return this.get_json()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskListSection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'title' { return this.title }
		'description' { return this.description }
		'image' { return this.image }
		'task_names' { return this.task_names }
		'task_list' { return this.task_list }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskListSection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		'title' {
			this.title = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'image' {
			this.image = val
			return true
		}
		'task_names' {
			this.task_names = val
			return true
		}
		'task_list' {
			this.task_list = val
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
}
