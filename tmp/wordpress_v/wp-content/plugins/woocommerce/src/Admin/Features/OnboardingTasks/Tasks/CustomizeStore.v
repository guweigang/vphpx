import rt

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) construct(var_task_list rt.PhpVal) {
	this.Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task.construct(var_task_list.dup())
	rt.call_function('add_action', [rt.new_string('save_post_wp_global_styles'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore', [
				'Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task',
			], &this) },
			rt.ArrayItem{ key: none, val: 'mark_task_as_complete_block_theme' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('save_post_wp_template'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore', [
				'Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task',
			], &this) },
			rt.ArrayItem{ key: none, val: 'mark_task_as_complete_block_theme' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('save_post_wp_template_part'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore', [
				'Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task',
			], &this) },
			rt.ArrayItem{ key: none, val: 'mark_task_as_complete_block_theme' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('customize_save_after'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore', [
				'Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task',
			], &this) },
			rt.ArrayItem{ key: none, val: 'mark_task_as_complete_classic_theme' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) mark_task_as_complete_block_theme(var_post_id rt.PhpVal, var_post rt.PhpVal, var_update rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post'))) {
		mut var_is_cys_complete := rt.new_bool(rt.new_bool(
			this.has_custom_global_styles(mut rt.cast_object_ptr[Class_WP_Post](var_post))
			|| rt.is_true(this.has_custom_template(mut rt.cast_object_ptr[Class_WP_Post](var_post)))))
		if rt.is_true(var_is_cys_complete) {
			rt.call_function('update_option', [
				rt.new_string('woocommerce_admin_customize_store_completed'),
				rt.new_string('yes'),
			])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) mark_task_as_complete_classic_theme() {
	rt.call_function('update_option', [
		rt.new_string('woocommerce_admin_customize_store_completed'),
		rt.new_string('yes'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) get_id() string {
	return 'customize-store'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) get_title() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Customize your store '),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) get_content() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) get_time() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) is_complete() rt.PhpVal {
	return rt.identical(rt.call_function('get_option', [
		rt.new_string('woocommerce_admin_customize_store_completed'),
	]), rt.new_string('yes'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) can_view() bool {
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) get_action_url() rt.PhpVal {
	return rt.call_function('admin_url', [
		rt.new_string('admin.php?page=wc-admin&path=%2Fcustomize-store'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) has_custom_global_styles(mut var_post Class_WP_Post) bool {
	mut var_required_keys := rt.create_array([rt.ArrayItem{ key: none, val: 'version' },
		rt.ArrayItem{ key: none, val: 'isGlobalStylesUserThemeJSON' }])
	mut var_json_post_content := rt.call_function('json_decode', [
		rt.get_property(var_post, 'post_content'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(var_json_post_content.dup().is_null())) {
		return false
	}
	mut var_post_content_keys := rt.func_array_keys(var_json_post_content.dup())
	return
		!(!rt.is_true(rt.call_function('array_diff', [var_post_content_keys.dup(), var_required_keys.dup()])))
		|| !(!rt.is_true(rt.call_function('array_diff', [var_required_keys.dup(), var_post_content_keys.dup()])))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) has_custom_template(mut var_post Class_WP_Post) rt.PhpVal {
	return rt.call_function('in_array', [rt.get_property(var_post, 'post_type'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wp_template' },
			rt.ArrayItem{ key: none, val: 'wp_template_part' }]),
		rt.new_bool(true)])
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasks_customizestore(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_task() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Task{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'mark_task_as_complete_block_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.mark_task_as_complete_block_theme(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'mark_task_as_complete_classic_theme' {
			this.mark_task_as_complete_classic_theme()
			return rt.new_null()
		}
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_title' {
			return this.get_title()
		}
		'get_content' {
			return rt.new_string(this.get_content())
		}
		'get_time' {
			return rt.new_string(this.get_time())
		}
		'is_complete' {
			return this.is_complete()
		}
		'can_view' {
			return rt.new_bool(this.can_view())
		}
		'get_action_url' {
			return this.get_action_url()
		}
		'has_custom_global_styles' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Post](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.has_custom_global_styles(mut dispatch_arg_0))
		}
		'has_custom_template' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Post](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.has_custom_template(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_Tasks_CustomizeStore) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

pub fn init_wp_content_plugins_woocommerce_src_admin_features_onboardingtasks_tasks_customizestore_php() {
}
