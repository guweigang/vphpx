import rt

struct Class_WP_Roles {
	rt.PhpObjectBase
pub mut:
	roles        rt.PhpVal = rt.new_null()
	role_objects rt.PhpVal = rt.new_array()
	role_names   rt.PhpVal = rt.new_array()
	role_key     rt.PhpVal = rt.new_null()
	use_db       rt.PhpVal = rt.new_bool(true)
	site_id      rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_WP_Roles) construct(var_site_id rt.PhpVal) {
	mut var_wp_user_roles := rt.new_null()
	this.use_db = rt.new_bool(!rt.is_true(var_wp_user_roles))
	this.for_site(var_site_id.clone())
}

fn (mut this Class_WP_Roles) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string('_init'), var_name)) {
		this._init(var_arguments.clone())
		return rt.new_null()
	}
	return false
}

fn (mut this Class_WP_Roles) _init() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('4.9.0'), rt.new_string('WP_Roles::for_site()')])
	this.for_site(rt.new_null())
}

fn (mut this Class_WP_Roles) reinit() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('4.7.0'), rt.new_string('WP_Roles::for_site()')])
	this.for_site(rt.new_null())
}

fn (mut this Class_WP_Roles) add_role(var_role rt.PhpVal, var_display_name rt.PhpVal, var_capabilities rt.PhpVal) rt.PhpVal {
	mut var_capabilities_mutated := var_capabilities
	if !rt.is_true(var_role) || this.roles.array_isset(var_role) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('wp_is_numeric_array', [var_capabilities_mutated.clone()])) {
		var_capabilities_mutated = rt.call_function('array_fill_keys', [
			var_capabilities_mutated.clone(), rt.new_bool(true)])
	}
	this.roles.array_set(var_role, rt.create_array([
		rt.ArrayItem{ key: 'name', val: var_display_name },
		rt.ArrayItem{ key: 'capabilities', val: var_capabilities_mutated },
	]))
	if rt.is_true(this.use_db) {
		rt.call_function('update_option', [this.role_key, this.roles, rt.new_bool(true)])
	}
	this.role_objects.array_set(var_role, create_wp_role(var_role.clone(),
		var_capabilities_mutated.clone()))
	this.role_names.array_set(var_role, var_display_name.clone())
	return this.role_objects.array_get(var_role)
}

fn (mut this Class_WP_Roles) remove_role(var_role rt.PhpVal) {
	if !(this.role_objects.array_isset(var_role)) {
		return
	}
	this.role_objects.array_unset(var_role)
	this.role_names.array_unset(var_role)
	this.roles.array_unset(var_role)
	if rt.is_true(this.use_db) {
		rt.call_function('update_option', [this.role_key, this.roles])
	}
	if rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('default_role'),
	]), var_role))
	{
		rt.call_function('update_option', [rt.new_string('default_role'),
			rt.new_string('subscriber')])
	}
}

fn (mut this Class_WP_Roles) add_cap(var_role rt.PhpVal, var_cap rt.PhpVal, grant bool) {
	if !(this.roles.array_isset(var_role)) {
		return
	}
	this.roles.array_get_mut(var_role).array_get_mut('capabilities').array_set(var_cap, grant)
	if rt.is_true(this.use_db) {
		rt.call_function('update_option', [this.role_key, this.roles])
	}
}

fn (mut this Class_WP_Roles) remove_cap(var_role rt.PhpVal, var_cap rt.PhpVal) {
	if !(this.roles.array_isset(var_role)) {
		return
	}
	this.roles.array_get(var_role).array_get(rt.new_string('capabilities')).array_unset(var_cap)
	if rt.is_true(this.use_db) {
		rt.call_function('update_option', [this.role_key, this.roles])
	}
}

fn (mut this Class_WP_Roles) get_role(var_role rt.PhpVal) rt.PhpVal {
	return if !(this.role_objects.array_get(var_role)).is_null() {
		this.role_objects.array_get(var_role)
	} else {
		rt.new_null()
	}
}

fn (mut this Class_WP_Roles) get_names() rt.PhpVal {
	return this.role_names
}

fn (mut this Class_WP_Roles) is_role(var_role rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.role_names.array_isset(var_role))
}

fn (mut this Class_WP_Roles) init_roles() {
	if !rt.is_true(this.roles) {
		return
	}
	this.role_objects = rt.new_array()
	this.role_names = rt.new_array()
	mut iter_1 := rt.func_array_keys(this.roles).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_role := item_1.val
		this.role_objects.array_set(var_role, create_wp_role(var_role.clone(),
			this.roles.array_get(var_role).array_get(rt.new_string('capabilities'))))
		this.role_names.array_set(var_role,
			this.roles.array_get(var_role).array_get(rt.new_string('name')))
	}
	rt.call_function('do_action', [rt.new_string('wp_roles_init'),
		rt.new_object('WP_Roles', []string{}, &this)])
}

fn (mut this Class_WP_Roles) for_site(var_site_id rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if !(!rt.is_true(var_site_id)) {
		this.site_id = rt.call_function('absint', [var_site_id.clone()])
	} else {
		this.site_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	this.role_key = (rt.call_method(var_wpdb, 'get_blog_prefix', [this.site_id])).str() +
		'user_roles'
	if !(!rt.is_true(this.roles)) && rt.is_true(rt.new_bool(!(rt.is_true(this.use_db)))) {
		return
	}
	this.roles = this.get_roles_data()
	this.init_roles()
}

fn (mut this Class_WP_Roles) get_site_id() rt.PhpVal {
	return this.site_id
}

fn (mut this Class_WP_Roles) get_roles_data() rt.PhpVal {
	mut var_wp_user_roles := rt.new_null()
	if !(!rt.is_true(var_wp_user_roles)) {
		return var_wp_user_roles.clone()
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), this.site_id)))) {
		rt.call_function('remove_action', [rt.new_string('switch_blog'),
			rt.new_string('wp_switch_roles_and_user'), rt.new_int(1)])
		mut var_roles := rt.call_function('get_blog_option', [this.site_id, this.role_key,
			rt.new_array()])
		rt.call_function('add_action', [rt.new_string('switch_blog'),
			rt.new_string('wp_switch_roles_and_user'), rt.new_int(1),
			rt.new_int(2)])
		return var_roles.clone()
	}
	return rt.call_function('get_option', [this.role_key, rt.new_array()])
}

struct Class_WP_Role {
	rt.PhpObjectBase
}

fn create_wp_roles(arg_0 rt.PhpVal) &Class_WP_Roles {
	mut obj := &Class_WP_Roles{
		PhpObjectBase: rt.PhpObjectBase{}
		roles:         rt.new_null()
		role_objects:  rt.new_array()
		role_names:    rt.new_array()
		role_key:      rt.new_null()
		use_db:        rt.new_bool(true)
		site_id:       rt.new_int(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_role(_args ...rt.PhpVal) &Class_WP_Role {
	mut obj := &Class_WP_Role{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Roles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'__call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.magic_call(dispatch_arg_0, dispatch_arg_1))
		}
		'_init' {
			this._init()
			return rt.new_null()
		}
		'reinit' {
			this.reinit()
			return rt.new_null()
		}
		'add_role' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.add_role(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'remove_role' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_role(dispatch_arg_0)
			return rt.new_null()
		}
		'add_cap' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			this.add_cap(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'remove_cap' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.remove_cap(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_role' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_role(dispatch_arg_0)
		}
		'get_names' {
			return this.get_names()
		}
		'is_role' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_role(dispatch_arg_0)
		}
		'init_roles' {
			this.init_roles()
			return rt.new_null()
		}
		'for_site' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.for_site(dispatch_arg_0)
			return rt.new_null()
		}
		'get_site_id' {
			return this.get_site_id()
		}
		'get_roles_data' {
			return this.get_roles_data()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Roles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'roles' { return this.roles }
		'role_objects' { return this.role_objects }
		'role_names' { return this.role_names }
		'role_key' { return this.role_key }
		'use_db' { return this.use_db }
		'site_id' { return this.site_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Roles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'roles' {
			this.roles = val
			return true
		}
		'role_objects' {
			this.role_objects = val
			return true
		}
		'role_names' {
			this.role_names = val
			return true
		}
		'role_key' {
			this.role_key = val
			return true
		}
		'use_db' {
			this.use_db = val
			return true
		}
		'site_id' {
			this.site_id = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Role) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Role) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Role) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
