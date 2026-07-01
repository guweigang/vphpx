import rt

struct Class_VHttpd_WordPress_ObjectCache {
	rt.PhpObjectBase
pub mut:
		cache rt.PhpVal = rt.new_array()
		globalGroups rt.PhpVal = rt.new_array()
		nonPersistentGroups rt.PhpVal = rt.new_array()
		cache_hits i64
		cache_misses i64
		local_hits rt.PhpVal = rt.new_int(0)
		remote_hits rt.PhpVal = rt.new_int(0)
		blogPrefix rt.PhpVal = rt.new_string('')
		multisite bool
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) construct(mut var_client Class_VHttpd_WordPress_?Client)  {
	this.multisite = rt.is_true(rt.call_function('function_exists', [rt.new_string('is_multisite')])) && rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
	if rt.is_true(rt.new_bool(rt.is_true(this.multisite) && rt.is_true(rt.call_function('function_exists', [rt.new_string('get_current_blog_id')])))) {
		this.blogPrefix = (// unsupported expression: Expr_Cast_String).str() + ':'
	}
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) add(var_key rt.PhpVal, var_data rt.PhpVal, group string, expire i64) bool {
	mut var_id := rt.new_null()
	mut group_mutated := group
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_suspend_cache_addition')])) && rt.is_true(rt.call_function('wp_suspend_cache_addition', []rt.PhpVal{})))) {
		return false
	}
	if !(this.isvalidkey(var_key.dup())) {
		return false
	}
	// unsupported assign target: Expr_List
	if this.existslocal((var_id).str(), group_mutated) {
		return false
	}
	if this.ispersistent(group_mutated) && this.remoteexists(group_mutated, (var_id).str()) {
		return false
	}
	return this.set(var_key.dup(), var_data.dup(), group_mutated, (// unsupported expression: Expr_Cast_Int).to_i64())
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) add_multiple(mut var_data Class_VHttpd_WordPress_array, group string, expire i64) rt.PhpVal {
	mut group_mutated := group
	mut var_values := rt.new_array()
	{
		mut iter_1 := var_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_values.array_set(var_key, this.add(var_key.dup(), var_value.dup(), group_mutated, expire))
		}
	}
	return var_values.dup()
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) replace(var_key rt.PhpVal, var_data rt.PhpVal, group string, expire i64) bool {
	mut var_id := rt.new_null()
	mut group_mutated := group
	if !(this.isvalidkey(var_key.dup())) {
		return false
	}
	// unsupported assign target: Expr_List
	if !(this.existslocal((var_id).str(), group_mutated)) && !(this.ispersistent(group_mutated)) || !(this.remoteexists(group_mutated, (var_id).str())) {
		return false
	}
	return this.set(var_key.dup(), var_data.dup(), group_mutated, (// unsupported expression: Expr_Cast_Int).to_i64())
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) set(var_key rt.PhpVal, var_data rt.PhpVal, group string, expire i64) bool {
	mut var_id := rt.new_null()
	mut group_mutated := group
	if !(this.isvalidkey(var_key.dup())) {
		return false
	}
	// unsupported assign target: Expr_List
	mut var_value := if rt.is_true(rt.new_bool(var_data.dup().is_object())) { // unsupported expression: Expr_Clone } else { var_data }
	this.cache.array_get_mut(group_mutated).array_set(var_id, var_value.dup())
	if this.ispersistent(group_mutated) {
		this.remoteset(group_mutated, (var_id).str(), mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](var_value), (// unsupported expression: Expr_Cast_Int).to_i64())
	}
	return true
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) set_multiple(mut var_data Class_VHttpd_WordPress_array, group string, expire i64) rt.PhpVal {
	mut group_mutated := group
	mut var_values := rt.new_array()
	{
		mut iter_1 := var_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			var_values.array_set(var_key, this.set(var_key.dup(), var_value.dup(), group_mutated, expire))
		}
	}
	return var_values.dup()
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) get(var_key rt.PhpVal, group string, force bool, var_found rt.PhpVal) bool {
	mut var_id := rt.new_null()
	mut group_mutated := group
	mut var_found_mutated := var_found
	if !(this.isvalidkey(var_key.dup())) {
		var_found_mutated = rt.new_bool(rt.new_bool(false))
		return false
	}
	// unsupported assign target: Expr_List
	if !(var_force) && this.existslocal((var_id).str(), group_mutated) {
		var_found_mutated = rt.new_bool(rt.new_bool(true))
		rt.pre_inc(this.cache_hits)
		rt.pre_inc(this.local_hits)
		return (this.cloneifobject(mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](this.cache.array_get(group_mutated).array_get(var_id)))).to_bool()
	}
	if this.ispersistent(group_mutated) {
		mut var_remote := this.remoteget(group_mutated, (var_id).str())
		if rt.is_true(var_remote.array_get('found')) {
			this.cache.array_get_mut(group_mutated).array_set(var_id, var_remote.array_get('value'))
			var_found_mutated = rt.new_bool(rt.new_bool(true))
			rt.pre_inc(this.cache_hits)
			rt.pre_inc(this.remote_hits)
			return (this.cloneifobject(mut rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](var_remote.array_get('value')))).to_bool()
		}
	}
	var_found_mutated = rt.new_bool(rt.new_bool(false))
	rt.pre_inc(this.cache_misses)
	return false
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) get_multiple(var_keys rt.PhpVal, group string, force bool) rt.PhpVal {
	mut group_mutated := group
	mut var_values := rt.new_array()
	{
		mut iter_1 := var_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			var_values.array_set(var_key, this.get(var_key.dup(), group_mutated, force, rt.new_null()))
		}
	}
	return var_values.dup()
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) delete(var_key rt.PhpVal, group string, deprecated bool) bool {
	mut var_id := rt.new_null()
	mut group_mutated := group
	if !(this.isvalidkey(var_key.dup())) {
		return false
	}
	// unsupported assign target: Expr_List
	mut var_existed := rt.new_bool(this.existslocal((var_id).str(), group_mutated))
	this.cache.array_get(group_mutated).array_unset(var_id)
	if this.ispersistent(group_mutated) {
		mut var_remoteDeleted := rt.new_bool(this.remotedelete(group_mutated, (var_id).str()))
		return rt.is_true(var_existed) || rt.is_true(var_remoteDeleted)
	}
	return (var_existed).to_bool()
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) delete_multiple(mut var_keys Class_VHttpd_WordPress_array, group string) rt.PhpVal {
	mut group_mutated := group
	mut var_values := rt.new_array()
	{
		mut iter_1 := var_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			var_values.array_set(var_key, this.delete(var_key.dup(), group_mutated, false))
		}
	}
	return var_values.dup()
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) incr(var_key rt.PhpVal, offset i64, group string) rt.PhpVal {
	mut group_mutated := group
	return rt.new_bool(this.changenumeric(var_key.dup(), (// unsupported expression: Expr_Cast_Int).to_i64(), group_mutated))
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) decr(var_key rt.PhpVal, offset i64, group string) rt.PhpVal {
	mut group_mutated := group
	return rt.new_bool(this.changenumeric(var_key.dup(), (rt.mul(// unsupported expression: Expr_UnaryMinus, // unsupported expression: Expr_Cast_Int)).to_i64(), group_mutated))
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) flush() bool {
	this.cache = rt.new_array()
	if rt.is_true(rt.identical(rt.get_property(rt.new_object('VHttpd_WordPress_ObjectCache', []string{}, &this), 'client'), rt.new_null())) {
		return true
	}
	{
		mut iter_1 := rt.call_method(rt.get_property(rt.new_object('VHttpd_WordPress_ObjectCache', []string{}, &this), 'client'), 'keys', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			rt.call_method(rt.get_property(rt.new_object('VHttpd_WordPress_ObjectCache', []string{}, &this), 'client'), 'delete', [var_key.dup()])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'VHttpd_WordPress_Throwable') {
		return true
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return true
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) flush_group(var_group rt.PhpVal) bool {
	mut var_group_mutated := var_group
	var_group_mutated = rt.new_string(this.normalizegroup((var_group_mutated).str()))
	this.cache.array_unset(var_group_mutated)
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.get_property(rt.new_object('VHttpd_WordPress_ObjectCache', []string{}, &this), 'client'), rt.new_null())) || !(this.ispersistent((var_group_mutated).str())))) {
		return true
	}
	mut var_prefix := rt.new_string((var_group_mutated).str() + ':')
	{
		mut iter_1 := rt.call_method(rt.get_property(rt.new_object('VHttpd_WordPress_ObjectCache', []string{}, &this), 'client'), 'keys', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if rt.is_true(rt.call_function('str_starts_with', [var_key.dup(), var_prefix.dup()])) {
				rt.call_method(rt.get_property(rt.new_object('VHttpd_WordPress_ObjectCache', []string{}, &this), 'client'), 'delete', [var_key.dup()])
				if rt.has_exception() { unsafe { goto catch_label_2 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'VHttpd_WordPress_Throwable') {
		return true
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return true
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) add_global_groups(var_groups rt.PhpVal)  {
	{
		mut iter_1 := rt.cast_array(var_groups).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_group := item_1.val
			var_group = rt.new_string(this.normalizegroup((var_group).str()))
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				this.globalGroups.array_set(var_group, true)
			}
		}
	}
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) add_non_persistent_groups(var_groups rt.PhpVal)  {
	{
		mut iter_1 := rt.cast_array(var_groups).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_group := item_1.val
			var_group = rt.new_string(this.normalizegroup((var_group).str()))
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				this.nonPersistentGroups.array_set(var_group, true)
			}
		}
	}
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) switch_to_blog(var_blog_id rt.PhpVal)  {
	this.blogPrefix = if rt.is_true(this.multisite) { (// unsupported expression: Expr_Cast_Int).str() + ':' } else { rt.new_string('') }
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) reset()  {
	{
		mut iter_1 := rt.func_array_keys(this.cache).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_group := item_1.val
			if !(this.globalGroups.array_isset(var_group)) {
				this.cache.array_unset(var_group)
			}
		}
	}
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) clearlocalcache()  {
	this.cache = rt.new_array()
	this.cache_hits = 0
	this.cache_misses = 0
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) changenumeric(var_key rt.PhpVal, offset i64, group string) bool {
	mut group_mutated := group
	mut var_found := rt.new_bool(rt.new_bool(false))
	mut var_value := rt.new_bool(this.get(var_key.dup(), group_mutated, false, var_found.dup()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_found)))) {
		return false
	}
	mut var_next := if rt.is_true(rt.new_bool(var_value.dup().is_long() || var_value.dup().is_double())) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	// unsupported expression: Expr_AssignOp_Plus
	if rt.is_true(rt.less(var_next, rt.new_int(0))) {
		var_next = rt.new_int(rt.new_int(0))
	}
	this.set(var_key.dup(), var_next.dup(), group_mutated, 0)
	return (var_next).to_bool()
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) isvalidkey(var_key rt.PhpVal) bool {
	return 
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) normalizekey(mut var_key Class_VHttpd_WordPress_{"nodeType":"UnionType","line":300,"types":["int","string"]}, var_group rt.PhpVal) rt.PhpVal {
	mut var_group_mutated := var_group
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) normalizegroup(group string) string {
	mut group_mutated := group
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) existslocal(id string, group string) bool {
	mut id_mutated := id
	mut group_mutated := group
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) ispersistent(group string) bool {
	mut group_mutated := group
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) remotekey(group string, id string) string {
	mut group_mutated := group
	mut id_mutated := id
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) remoteexists(group string, id string) bool {
	mut group_mutated := group
	mut id_mutated := id
	return false
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) remoteget(group string, id string) rt.PhpVal {
	mut group_mutated := group
	mut id_mutated := id
	return rt.new_null()
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) remoteset(group string, id string, mut var_value Class_VHttpd_WordPress_mixed, expire i64) bool {
	mut group_mutated := group
	mut id_mutated := id
	mut var_value_mutated := var_value
	return false
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) remotedelete(group string, id string) bool {
	mut group_mutated := group
	mut id_mutated := id
	return false
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) cloneifobject(mut var_value Class_VHttpd_WordPress_mixed) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn create_vhttpd_wordpress_objectcache(arg_0 rt.PhpVal) &Class_VHttpd_WordPress_ObjectCache {
	mut obj := &Class_VHttpd_WordPress_ObjectCache{
		PhpObjectBase: rt.PhpObjectBase{}
		cache: rt.new_array()
		globalGroups: rt.new_array()
		nonPersistentGroups: rt.new_array()
		cache_hits: i64(0)
		cache_misses: i64(0)
		local_hits: rt.new_int(0)
		remote_hits: rt.new_int(0)
		blogPrefix: rt.new_string('')
		multisite: false
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_?Client](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.add(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'add_multiple' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.add_multiple(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'replace' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.replace(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.set(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'set_multiple' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.set_multiple(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.get(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'get_multiple' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.get_multiple(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.delete(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'delete_multiple' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.delete_multiple(mut dispatch_arg_0, dispatch_arg_1)
		}
		'incr' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.incr(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'decr' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.decr(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'flush' {
			return rt.new_bool(this.flush())
		}
		'flush_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.flush_group(dispatch_arg_0))
		}
		'add_global_groups' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_global_groups(dispatch_arg_0)
			return rt.new_null()
		}
		'add_non_persistent_groups' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_non_persistent_groups(dispatch_arg_0)
			return rt.new_null()
		}
		'switch_to_blog' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.switch_to_blog(dispatch_arg_0)
			return rt.new_null()
		}
		'reset' {
			this.reset()
			return rt.new_null()
		}
		'clearLocalCache' {
			this.clearlocalcache()
			return rt.new_null()
		}
		'changeNumeric' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.changenumeric(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'isValidKey' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.isvalidkey(dispatch_arg_0))
		}
		'normalizeKey' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_{"nodeType":"UnionType","line":300,"types":["int","string"]}](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.normalizekey(mut dispatch_arg_0, dispatch_arg_1)
		}
		'normalizeGroup' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.normalizegroup(dispatch_arg_0))
		}
		'existsLocal' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.existslocal(dispatch_arg_0, dispatch_arg_1))
		}
		'isPersistent' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.ispersistent(dispatch_arg_0))
		}
		'remoteKey' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.remotekey(dispatch_arg_0, dispatch_arg_1))
		}
		'remoteExists' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.remoteexists(dispatch_arg_0, dispatch_arg_1))
		}
		'remoteGet' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.remoteget(dispatch_arg_0, dispatch_arg_1)
		}
		'remoteSet' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](if args.len > 2 { args[2] } else { rt.new_null() })
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.remoteset(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2, dispatch_arg_3))
		}
		'remoteDelete' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.remotedelete(dispatch_arg_0, dispatch_arg_1))
		}
		'cloneIfObject' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_WordPress_mixed](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.cloneifobject(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_VHttpd_WordPress_ObjectCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cache' { return this.cache }
		'globalGroups' { return this.globalGroups }
		'nonPersistentGroups' { return this.nonPersistentGroups }
		'cache_hits' { return rt.new_int(this.cache_hits) }
		'cache_misses' { return rt.new_int(this.cache_misses) }
		'local_hits' { return this.local_hits }
		'remote_hits' { return this.remote_hits }
		'blogPrefix' { return this.blogPrefix }
		'multisite' { return rt.new_bool(this.multisite) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cache' { this.cache = val; return true }
		'globalGroups' { this.globalGroups = val; return true }
		'nonPersistentGroups' { this.nonPersistentGroups = val; return true }
		'cache_hits' { this.cache_hits = (val).to_i64(); return true }
		'cache_misses' { this.cache_misses = (val).to_i64(); return true }
		'local_hits' { this.local_hits = val; return true }
		'remote_hits' { this.remote_hits = val; return true }
		'blogPrefix' { this.blogPrefix = val; return true }
		'multisite' { this.multisite = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_v_profiler_src_vhttpd_wordpress_objectcache_php() {
	// unsupported statement: Stmt_Declare
}
