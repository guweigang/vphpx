import rt

struct Class_ActionScheduler_ActionClaim {
	rt.PhpObjectBase
pub mut:
	id         rt.PhpVal = rt.new_string('')
	action_ids rt.PhpVal = rt.new_array()
}

fn (mut this Class_ActionScheduler_ActionClaim) construct(var_id rt.PhpVal, mut var_action_ids Class_array) {
	this.id = var_id.dup()
	this.action_ids = var_action_ids.dup()
}

fn (mut this Class_ActionScheduler_ActionClaim) get_id() rt.PhpVal {
	return this.id
}

fn (mut this Class_ActionScheduler_ActionClaim) get_actions() rt.PhpVal {
	return this.action_ids
}

fn create_actionscheduler_actionclaim(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_ActionScheduler_ActionClaim {
	mut obj := &Class_ActionScheduler_ActionClaim{
		PhpObjectBase: rt.PhpObjectBase{}
		id:            rt.new_string('')
		action_ids:    rt.new_array()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_ActionScheduler_ActionClaim) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_id' {
			return this.get_id()
		}
		'get_actions' {
			return this.get_actions()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_ActionClaim) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'action_ids' { return this.action_ids }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_ActionClaim) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		'action_ids' {
			this.action_ids = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_actionscheduler_actionclaim_php() {
}
