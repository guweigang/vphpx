import rt

struct Class_WP_User {
	rt.PhpObjectBase
pub mut:
	data    rt.PhpVal = rt.new_null()
	ID      rt.PhpVal = rt.new_int(0)
	caps    rt.PhpVal = rt.new_array()
	cap_key rt.PhpVal = rt.new_null()
	roles   rt.PhpVal = rt.new_array()
	allcaps rt.PhpVal = rt.new_array()
	filter  rt.PhpVal = rt.new_null()
	site_id rt.PhpVal = rt.new_int(0)
}

fn init_static_wp_user() {
	rt.init_static_prop('WP_User', 'back_compat_keys', rt.new_null())
}

fn (mut this Class_WP_User) construct(id i64, name string, site_id i64) {
	mut var_wpdb := rt.new_null()
	mut id_mutated := id
	mut name_mutated := name
	if !(!(rt.get_static_prop('WP_User', 'back_compat_keys')).is_null()) {
		mut var_prefix := rt.get_property(var_wpdb, 'prefix')
		rt.set_static_prop('WP_User', 'back_compat_keys', rt.create_array([
			rt.ArrayItem{ key: 'user_firstname', val: 'first_name' },
			rt.ArrayItem{ key: 'user_lastname', val: 'last_name' },
			rt.ArrayItem{ key: 'user_description', val: 'description' },
			rt.ArrayItem{ key: 'user_level', val: var_prefix.str() + 'user_level' },
			rt.ArrayItem{ key: var_prefix.str() + 'usersettings', val: var_prefix.str() +
				'user-settings' },
			rt.ArrayItem{ key: var_prefix.str() + 'usersettingstime', val: var_prefix.str() +
				'user-settings-time' },
		]))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(id_mutated), 'WP_User'))) {
		this.init(rt.get_property(rt.new_int(id_mutated), 'data'), site_id)
		return
	} else if rt.is_true(rt.new_bool(rt.new_int(id_mutated).clone().is_object())) {
		this.init(rt.new_int(id_mutated), site_id)
		return
	}
	if !(id_mutated == 0) && !(rt.new_int(id_mutated).clone().is_long()
		|| rt.new_int(id_mutated).clone().is_double()) {
		name_mutated = id_mutated
		id_mutated = 0
	}
	if rt.is_true(rt.new_int(id_mutated)) {
		mut var_data := Class_WP_User.get_data_by(rt.new_string('id'), rt.new_int(id_mutated))
	} else {
		var_data = Class_WP_User.get_data_by(rt.new_string('login'), rt.new_string(name_mutated))
	}
	if rt.is_true(var_data) {
		this.init(var_data.clone(), site_id)
	} else {
		this.data = create_stdclass()
	}
}

fn (mut this Class_WP_User) init(var_data rt.PhpVal, site_id i64) {
	mut var_data_mutated := var_data
	if !(!(rt.get_property(var_data_mutated, 'ID')).is_null()) {
		rt.set_property(var_data_mutated, 'ID', rt.new_int(0))
	}
	this.data = var_data_mutated.clone()
	this.ID = rt.new_int((rt.get_property(var_data_mutated, 'ID')).to_i64())
	this.for_site(site_id)
}

fn Class_WP_User.get_data_by(var_field rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_field_mutated := var_field
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string('ID'), var_field_mutated)) {
		var_field_mutated = rt.new_string('id')
	}
	if rt.is_true(rt.identical(rt.new_string('id'), var_field_mutated)) {
		if !(var_value_mutated.clone().is_long() || var_value_mutated.clone().is_double()) {
			return false
		}
		var_value_mutated = rt.new_int(var_value_mutated.to_i64())
		if rt.is_true(rt.less(var_value_mutated, rt.new_int(1))) {
			return false
		}
	} else {
		var_value_mutated = rt.new_string(var_value_mutated.clone().to_string().trim_space())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_value_mutated)))) {
		return false
	}
	mut switch_val_1 := var_field_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('id'))) {
		mut var_user_id := var_value_mutated.clone()
		mut var_db_field := rt.new_string('ID')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('slug'))) {
		var_user_id = rt.call_function('wp_cache_get', [var_value_mutated.clone(),
			rt.new_string('userslugs')])
		var_db_field = rt.new_string('user_nicename')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('email'))) {
		var_user_id = rt.call_function('wp_cache_get', [var_value_mutated.clone(),
			rt.new_string('useremail')])
		var_db_field = rt.new_string('user_email')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('login'))) {
		var_value_mutated = rt.call_function('sanitize_user', [
			var_value_mutated.clone()])
		var_user_id = rt.call_function('wp_cache_get', [var_value_mutated.clone(),
			rt.new_string('userlogins')])
		var_db_field = rt.new_string('user_login')
	} else {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_user_id)))) {
		mut var_user := rt.call_function('wp_cache_get', [var_user_id.clone(),
			rt.new_string('users')])
		if rt.is_true(var_user) {
			return var_user.to_bool()
		}
	}
	var_user = rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
				'users')), rt.new_string(' WHERE ')), var_db_field), rt.new_string(' = %s LIMIT 1')),
			var_value_mutated.clone(),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		return false
	}
	rt.call_function('update_user_caches', [var_user.clone()])
	return var_user.to_bool()
}

fn (mut this Class_WP_User) magic_isset(var_key rt.PhpVal) bool {
	mut var_key_mutated := var_key
	if rt.is_true(rt.identical(rt.new_string('id'), var_key_mutated)) {
		rt.call_function('_deprecated_argument', [rt.new_string('WP_User->id'),
			rt.new_string('2.1.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Use %s instead.')]),
				rt.new_string('<code>WP_User->ID</code>'),
			])])
		var_key_mutated = rt.new_string('ID')
	}
	if !(rt.get_property(this.data, '{"nodeType":"Expr_Variable","line":291,"name":"key"}')).is_null() {
		return true
	}
	if rt.get_static_prop('WP_User', 'back_compat_keys').array_isset(var_key_mutated) {
		var_key_mutated =
			rt.get_static_prop('WP_User', 'back_compat_keys').array_get(var_key_mutated)
	}
	return (rt.call_function('metadata_exists',
		[rt.new_string('user'), this.ID, var_key_mutated.clone()])).to_bool()
}

fn (mut this Class_WP_User) magic_get(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	if rt.is_true(rt.identical(rt.new_string('id'), var_key_mutated)) {
		rt.call_function('_deprecated_argument', [rt.new_string('WP_User->id'),
			rt.new_string('2.1.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Use %s instead.')]),
				rt.new_string('<code>WP_User->ID</code>'),
			])])
		return this.ID
	}
	if !(rt.get_property(this.data, '{"nodeType":"Expr_Variable","line":324,"name":"key"}')).is_null() {
		mut var_value := rt.get_property(this.data,
			'{"nodeType":"Expr_Variable","line":325,"name":"key"}')
	} else {
		if rt.get_static_prop('WP_User', 'back_compat_keys').array_isset(var_key_mutated) {
			var_key_mutated =
				rt.get_static_prop('WP_User', 'back_compat_keys').array_get(var_key_mutated)
		}
		var_value = rt.call_function('get_user_meta', [this.ID, var_key_mutated.clone(),
			rt.new_bool(true)])
	}
	if rt.is_true(this.filter) {
		var_value = rt.call_function('sanitize_user_field', [
			var_key_mutated.clone(), var_value.clone(), this.ID, this.filter])
	}
	return var_value.clone()
}

fn (mut this Class_WP_User) magic_set(var_key rt.PhpVal, var_value rt.PhpVal) {
	mut var_key_mutated := var_key
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_string('id'), var_key_mutated)) {
		rt.call_function('_deprecated_argument', [rt.new_string('WP_User->id'),
			rt.new_string('2.1.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Use %s instead.')]),
				rt.new_string('<code>WP_User->ID</code>'),
			])])
		this.ID = var_value_mutated.clone()
		return
	}
	rt.set_property(this.data, '{"nodeType":"Expr_Variable","line":366,"name":"key"}',
		var_value_mutated.clone())
}

fn (mut this Class_WP_User) magic_unset(var_key rt.PhpVal) {
	mut var_key_mutated := var_key
	if rt.is_true(rt.identical(rt.new_string('id'), var_key_mutated)) {
		rt.call_function('_deprecated_argument', [rt.new_string('WP_User->id'),
			rt.new_string('2.1.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Use %s instead.')]),
				rt.new_string('<code>WP_User->ID</code>'),
			])])
	}
	if !(rt.get_property(this.data, '{"nodeType":"Expr_Variable","line":389,"name":"key"}')).is_null() {
		rt.get_property(this.data, '{"nodeType":"Expr_Variable","line":390,"name":"key"}') =
			rt.new_null()
	}
	if rt.get_static_prop('WP_User', 'back_compat_keys').array_isset(var_key_mutated) {
		rt.get_static_prop('WP_User', 'back_compat_keys').array_unset(var_key_mutated)
	}
}

fn (mut this Class_WP_User) exists() bool {
	return !(!rt.is_true(this.ID))
}

fn (mut this Class_WP_User) get(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	return this.magic_get(var_key_mutated.clone())
}

fn (mut this Class_WP_User) has_prop(var_key rt.PhpVal) rt.PhpVal {
	mut var_key_mutated := var_key
	return rt.new_bool(this.magic_isset(var_key_mutated.clone()))
}

fn (mut this Class_WP_User) to_array() rt.PhpVal {
	return rt.call_function('get_object_vars', [this.data])
}

fn (mut this Class_WP_User) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) bool {
	mut var_name_mutated := var_name
	if rt.is_true(rt.identical(rt.new_string('_init_caps'), var_name_mutated)) {
		this._init_caps(var_arguments.str())
		return rt.new_null()
	}
	return false
}

fn (mut this Class_WP_User) _init_caps(cap_key string) {
	mut var_wpdb := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('4.9.0'), rt.new_string('WP_User::for_site()')])
	if cap_key == '' {
		this.cap_key = (rt.call_method(var_wpdb, 'get_blog_prefix', [this.site_id])).str() +
			'capabilities'
	} else {
		this.cap_key = rt.new_string(cap_key)
	}
	this.caps = this.get_caps_data()
	this.get_role_caps()
}

fn (mut this Class_WP_User) get_role_caps() rt.PhpVal {
	mut var_switch_site := rt.new_bool(false)
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), this.site_id)))) {
		var_switch_site = rt.new_bool(true)
		rt.call_function('switch_to_blog', [this.site_id])
	}
	mut var_wp_roles := rt.call_function('wp_roles', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(this.caps.is_array())) {
		this.roles = rt.new_array()
		mut iter_1 := this.caps.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.call_method(var_wp_roles, 'is_role', [
				var_key.clone()]))
			{
				this.roles.array_push(var_key.clone())
			}
		}
	}
	this.allcaps = rt.new_array()
	mut iter_2 := rt.cast_array(this.roles).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_role := item_2.val
		mut var_the_role := rt.call_method(var_wp_roles, 'get_role', [
			var_role.clone()])
		this.allcaps = rt.call_function('array_merge', [rt.cast_array(this.allcaps),
			rt.cast_array(rt.get_property(var_the_role, 'capabilities'))])
	}
	this.allcaps = rt.call_function('array_merge', [rt.cast_array(this.allcaps),
		rt.cast_array(this.caps)])
	if rt.is_true(var_switch_site) {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
	}
	return this.allcaps
}

fn (mut this Class_WP_User) add_role(var_role rt.PhpVal) {
	if !rt.is_true(var_role) {
		return
	}
	if rt.is_true(rt.call_function('in_array', [var_role.clone(), this.roles, rt.new_bool(true)])) {
		return
	}
	this.caps.array_set(var_role, true)
	rt.call_function('update_user_meta', [this.ID, this.cap_key, this.caps])
	this.get_role_caps()
	this.update_user_level_from_caps()
	rt.call_function('do_action', [rt.new_string('add_user_role'), this.ID, var_role.clone()])
}

fn (mut this Class_WP_User) remove_role(var_role rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_role.clone(), this.roles, rt.new_bool(true)])))))
	{
		return
	}
	this.caps.array_unset(var_role)
	rt.call_function('update_user_meta', [this.ID, this.cap_key, this.caps])
	this.get_role_caps()
	this.update_user_level_from_caps()
	rt.call_function('do_action', [rt.new_string('remove_user_role'), this.ID, var_role.clone()])
}

fn (mut this Class_WP_User) set_role(var_role rt.PhpVal) {
	if 1 == this.roles.array_count()
		&& rt.is_true(rt.identical(rt.call_function('current', [this.roles]), var_role)) {
		return
	}
	mut iter_3 := rt.cast_array(this.roles).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_oldrole := item_3.val
		this.caps.array_unset(var_oldrole)
	}
	mut var_old_roles := this.roles
	if !(!rt.is_true(var_role)) {
		this.caps.array_set(var_role, true)
		this.roles = rt.create_array([rt.ArrayItem{ key: var_role, val: true }])
	} else {
		this.roles = rt.new_array()
	}
	rt.call_function('update_user_meta', [this.ID, this.cap_key, this.caps])
	this.get_role_caps()
	this.update_user_level_from_caps()
	mut iter_4 := var_old_roles.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_old_role := item_4.val
		if rt.is_true(rt.new_bool(!(rt.is_true(var_old_role))))
			|| rt.is_true(rt.identical(var_old_role, var_role)) {
			continue
		}
		rt.call_function('do_action',
			[rt.new_string('remove_user_role'), this.ID, var_old_role.clone()])
	}
	if rt.is_true(var_role)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_role.clone(), var_old_roles.clone(), rt.new_bool(true)]))))) {
		rt.call_function('do_action', [rt.new_string('add_user_role'), this.ID, var_role.clone()])
	}
	rt.call_function('do_action', [rt.new_string('set_user_role'), this.ID, var_role.clone(),
		var_old_roles.clone()])
}

fn (mut this Class_WP_User) level_reduction(var_max rt.PhpVal, var_item rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^level_(10|[0-9])$/i'),
		var_item.clone(), rt.create_array_from_list(var_matches)]))
	{
		mut var_level := rt.new_int((var_matches.array_get(rt.new_int(1))).to_i64())
		return rt.call_function('max', [var_max.clone(), var_level.clone()])
	} else {
		return var_max.clone()
	}
	return rt.new_null()
}

fn (mut this Class_WP_User) update_user_level_from_caps() {
	mut var_wpdb := rt.new_null()
	this.dispatch_set_prop('user_level', rt.call_function('array_reduce', [
		rt.func_array_keys(this.allcaps),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_User', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'level_reduction' },
		]),
		rt.new_int(0),
	]))
	rt.call_function('update_user_meta', [this.ID,
		rt.new_string((rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() +
			'user_level'),
		rt.get_property(rt.new_object('WP_User', []string{}, &this), 'user_level')])
}

fn (mut this Class_WP_User) add_cap(var_cap rt.PhpVal, grant bool) {
	mut var_cap_mutated := var_cap
	this.caps.array_set(var_cap_mutated, grant)
	rt.call_function('update_user_meta', [this.ID, this.cap_key, this.caps])
	this.get_role_caps()
	this.update_user_level_from_caps()
}

fn (mut this Class_WP_User) remove_cap(var_cap rt.PhpVal) {
	mut var_cap_mutated := var_cap
	if !(this.caps.array_isset(var_cap_mutated)) {
		return
	}
	this.caps.array_unset(var_cap_mutated)
	rt.call_function('update_user_meta', [this.ID, this.cap_key, this.caps])
	this.get_role_caps()
	this.update_user_level_from_caps()
}

fn (mut this Class_WP_User) remove_all_caps() {
	mut var_wpdb := rt.new_null()
	this.caps = rt.new_array()
	rt.call_function('delete_user_meta', [this.ID, this.cap_key])
	rt.call_function('delete_user_meta', [this.ID,
		rt.new_string((rt.call_method(var_wpdb, 'get_blog_prefix', []rt.PhpVal{})).str() +
			'user_level')])
	this.get_role_caps()
}

fn (mut this Class_WP_User) has_cap(var_cap rt.PhpVal, var_args rt.PhpVal) bool {
	mut var_cap_mutated := var_cap
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(var_cap_mutated.clone().is_long()
		|| var_cap_mutated.clone().is_double()))
	{
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('2.0.0'),
			rt.call_function('__', [
				rt.new_string('Usage of user levels is deprecated. Use capabilities instead.'),
			])])
		var_cap_mutated = rt.new_string(this.translate_level_to_cap(var_cap_mutated.clone()))
	}
	mut var_caps := rt.call_function('map_meta_cap', [var_cap_mutated.clone(), this.ID,
		var_args_mutated.clone()])
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_super_admin', [this.ID])) {
		if rt.is_true(rt.call_function('in_array', [rt.new_string('do_not_allow'),
			var_caps.clone(), rt.new_bool(true)]))
		{
			return false
		}
		return true
	}
	var_args_mutated = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_cap_mutated },
			rt.ArrayItem{ key: none, val: this.ID }]),
		var_args_mutated.clone(),
	])
	mut var_capabilities := rt.call_function('apply_filters', [
		rt.new_string('user_has_cap'),
		this.allcaps,
		var_caps.clone(),
		var_args_mutated.clone(),
		rt.new_object('WP_User', []string{}, &this),
	])
	var_capabilities.array_set('exist', true)
	var_capabilities.array_unset(rt.new_string('do_not_allow'))
	mut iter_5 := rt.cast_array(var_caps).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_cap_shadow := item_5.val
		if !rt.is_true(var_capabilities.array_get(var_cap_shadow)) {
			return false
		}
	}
	return true
}

fn (mut this Class_WP_User) translate_level_to_cap(var_level rt.PhpVal) string {
	mut var_level_mutated := var_level
	return 'level_' + var_level_mutated.str()
}

fn (mut this Class_WP_User) for_blog(blog_id i64) {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('4.9.0'), rt.new_string('WP_User::for_site()')])
	this.for_site(blog_id)
}

fn (mut this Class_WP_User) for_site(site_id i64) {
	mut var_wpdb := rt.new_null()
	if !(site_id == 0) {
		this.site_id = rt.call_function('absint', [rt.new_int(site_id)])
	} else {
		this.site_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	this.cap_key = (rt.call_method(var_wpdb, 'get_blog_prefix', [this.site_id])).str() +
		'capabilities'
	this.caps = this.get_caps_data()
	this.get_role_caps()
}

fn (mut this Class_WP_User) get_site_id() rt.PhpVal {
	return this.site_id
}

fn (mut this Class_WP_User) get_caps_data() rt.PhpVal {
	mut var_caps := rt.call_function('get_user_meta', [this.ID, this.cap_key, rt.new_bool(true)])
	if !(var_caps.clone().is_array()) {
		return rt.new_array()
	}
	return var_caps.clone()
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_user(id i64, name string, site_id i64) &Class_WP_User {
	mut obj := &Class_WP_User{
		PhpObjectBase: rt.PhpObjectBase{}
		data:          rt.new_null()
		ID:            rt.new_int(0)
		caps:          rt.new_array()
		cap_key:       rt.new_null()
		roles:         rt.new_array()
		allcaps:       rt.new_array()
		filter:        rt.new_null()
		site_id:       rt.new_int(0)
	}
	obj.construct(id, name, site_id)
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_User) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'init' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.init(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_data_by' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_WP_User.get_data_by(dispatch_arg_0, dispatch_arg_1))
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.magic_isset(dispatch_arg_0))
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__unset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.magic_unset(dispatch_arg_0)
			return rt.new_null()
		}
		'exists' {
			return rt.new_bool(this.exists())
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get(dispatch_arg_0)
		}
		'has_prop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.has_prop(dispatch_arg_0)
		}
		'to_array' {
			return this.to_array()
		}
		'__call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.magic_call(dispatch_arg_0, dispatch_arg_1))
		}
		'_init_caps' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this._init_caps(dispatch_arg_0)
			return rt.new_null()
		}
		'get_role_caps' {
			return this.get_role_caps()
		}
		'add_role' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_role(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_role' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_role(dispatch_arg_0)
			return rt.new_null()
		}
		'set_role' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_role(dispatch_arg_0)
			return rt.new_null()
		}
		'level_reduction' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.level_reduction(dispatch_arg_0, dispatch_arg_1)
		}
		'update_user_level_from_caps' {
			this.update_user_level_from_caps()
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
		'remove_all_caps' {
			this.remove_all_caps()
			return rt.new_null()
		}
		'has_cap' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.has_cap(dispatch_arg_0, dispatch_arg_1))
		}
		'translate_level_to_cap' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.translate_level_to_cap(dispatch_arg_0))
		}
		'for_blog' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.for_blog(dispatch_arg_0)
			return rt.new_null()
		}
		'for_site' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.for_site(dispatch_arg_0)
			return rt.new_null()
		}
		'get_site_id' {
			return this.get_site_id()
		}
		'get_caps_data' {
			return this.get_caps_data()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_User) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return this.data }
		'ID' { return this.ID }
		'caps' { return this.caps }
		'cap_key' { return this.cap_key }
		'roles' { return this.roles }
		'allcaps' { return this.allcaps }
		'filter' { return this.filter }
		'site_id' { return this.site_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_User) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' {
			this.data = val
			return true
		}
		'ID' {
			this.ID = val
			return true
		}
		'caps' {
			this.caps = val
			return true
		}
		'cap_key' {
			this.cap_key = val
			return true
		}
		'roles' {
			this.roles = val
			return true
		}
		'allcaps' {
			this.allcaps = val
			return true
		}
		'filter' {
			this.filter = val
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

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
