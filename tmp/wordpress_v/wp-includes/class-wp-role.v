import rt

struct Class_WP_Role {
	rt.PhpObjectBase
pub mut:
	name         rt.PhpVal = rt.new_null()
	capabilities rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Role) construct(var_role rt.PhpVal, var_capabilities rt.PhpVal) {
	mut var_capabilities_mutated := var_capabilities
	this.name = var_role.dup()
	this.capabilities = var_capabilities_mutated.dup()
}

fn (mut this Class_WP_Role) add_cap(var_cap rt.PhpVal, grant bool) {
	this.capabilities.array_set(var_cap, grant)
	rt.call_method(rt.call_function('wp_roles', []rt.PhpVal{}), 'add_cap', [this.name,
		var_cap.dup(), rt.new_bool(grant)])
}

fn (mut this Class_WP_Role) remove_cap(var_cap rt.PhpVal) {
	this.capabilities.array_unset(var_cap)
	rt.call_method(rt.call_function('wp_roles', []rt.PhpVal{}), 'remove_cap', [this.name,
		var_cap.dup()])
}

fn (mut this Class_WP_Role) has_cap(var_cap rt.PhpVal) bool {
	mut var_capabilities := rt.call_function('apply_filters', [
		rt.new_string('role_has_cap'),
		this.capabilities,
		var_cap.dup(),
		this.name,
	])
	if !(!rt.is_true(var_capabilities.array_get(var_cap))) {
		return (var_capabilities.array_get(var_cap)).to_bool()
	} else {
		return false
	}
	return false
}

fn create_wp_role(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WP_Role {
	mut obj := &Class_WP_Role{
		PhpObjectBase: rt.PhpObjectBase{}
		name:          rt.new_null()
		capabilities:  rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_WP_Role) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_cap' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.add_cap(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'remove_cap' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_cap(dispatch_arg_0)
			return rt.new_null()
		}
		'has_cap' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_cap(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Role) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'capabilities' { return this.capabilities }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Role) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'capabilities' {
			this.capabilities = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_includes_class_wp_role_php() {
}
