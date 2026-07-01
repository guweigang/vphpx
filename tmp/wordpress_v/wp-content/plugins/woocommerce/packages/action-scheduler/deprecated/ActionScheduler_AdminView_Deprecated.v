import rt

struct Class_ActionScheduler_AdminView_Deprecated {
	rt.PhpObjectBase
}

fn (mut this Class_ActionScheduler_AdminView_Deprecated) action_scheduler_post_type_args(var_args rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('2.0.0')])
	return var_args.dup()
}

fn (mut this Class_ActionScheduler_AdminView_Deprecated) list_table_views(var_views rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('2.0.0')])
	return var_views.dup()
}

fn (mut this Class_ActionScheduler_AdminView_Deprecated) bulk_actions(var_actions rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('2.0.0')])
	return var_actions.dup()
}

fn (mut this Class_ActionScheduler_AdminView_Deprecated) list_table_columns(var_columns rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('2.0.0')])
	return var_columns.dup()
}

fn Class_ActionScheduler_AdminView_Deprecated.list_table_sortable_columns(var_columns rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('2.0.0')])
	return var_columns.dup()
}

fn Class_ActionScheduler_AdminView_Deprecated.list_table_column_content(var_column_name rt.PhpVal, var_post_id rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('2.0.0')])
}

fn Class_ActionScheduler_AdminView_Deprecated.row_actions(var_actions rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('2.0.0')])
	return var_actions.dup()
}

fn Class_ActionScheduler_AdminView_Deprecated.maybe_execute_action() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('2.0.0')])
}

fn Class_ActionScheduler_AdminView_Deprecated.admin_notices() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('2.0.0')])
}

fn (mut this Class_ActionScheduler_AdminView_Deprecated) custom_orderby(var_orderby rt.PhpVal, var_query rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('2.0.0')])
}

fn (mut this Class_ActionScheduler_AdminView_Deprecated) search_post_password(var_search rt.PhpVal, var_query rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('2.0.0')])
}

fn (mut this Class_ActionScheduler_AdminView_Deprecated) post_updated_messages(var_messages rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('2.0.0')])
	return var_messages.dup()
}

fn create_actionscheduler_adminview_deprecated() &Class_ActionScheduler_AdminView_Deprecated {
	mut obj := &Class_ActionScheduler_AdminView_Deprecated{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_AdminView_Deprecated) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'action_scheduler_post_type_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.action_scheduler_post_type_args(dispatch_arg_0)
		}
		'list_table_views' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.list_table_views(dispatch_arg_0)
		}
		'bulk_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.bulk_actions(dispatch_arg_0)
		}
		'list_table_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.list_table_columns(dispatch_arg_0)
		}
		'list_table_sortable_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ActionScheduler_AdminView_Deprecated.list_table_sortable_columns(dispatch_arg_0)
		}
		'list_table_column_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_ActionScheduler_AdminView_Deprecated.list_table_column_content(dispatch_arg_0,
				dispatch_arg_1)
			return rt.new_null()
		}
		'row_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ActionScheduler_AdminView_Deprecated.row_actions(dispatch_arg_0,
				dispatch_arg_1)
		}
		'maybe_execute_action' {
			Class_ActionScheduler_AdminView_Deprecated.maybe_execute_action()
			return rt.new_null()
		}
		'admin_notices' {
			Class_ActionScheduler_AdminView_Deprecated.admin_notices()
			return rt.new_null()
		}
		'custom_orderby' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.custom_orderby(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'search_post_password' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.search_post_password(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'post_updated_messages' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.post_updated_messages(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_AdminView_Deprecated) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ActionScheduler_AdminView_Deprecated) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_deprecated_actionscheduler_adminview_deprecated_php() {
}
