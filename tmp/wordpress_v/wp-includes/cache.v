import rt

fn wp_cache_init() {
	mut var_GLOBALS := rt.new_null()
	var_GLOBALS.array_set('wp_object_cache', create_wp_object_cache())
}

fn wp_cache_add(var_key rt.PhpVal, var_data rt.PhpVal, group string, expire i64) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'add', [var_key.dup(), var_data.dup(), rt.new_string(group), // unsupported expression: Expr_Cast_Int])
}

fn wp_cache_add_multiple(var_data rt.PhpVal, group string, expire i64) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'add_multiple', [var_data.dup(), rt.new_string(group), // unsupported expression: Expr_Cast_Int])
}

fn wp_cache_replace(var_key rt.PhpVal, var_data rt.PhpVal, group string, expire i64) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'replace', [var_key.dup(), var_data.dup(), rt.new_string(group), // unsupported expression: Expr_Cast_Int])
}

fn wp_cache_set(var_key rt.PhpVal, var_data rt.PhpVal, group string, expire i64) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'set', [var_key.dup(), var_data.dup(), rt.new_string(group), // unsupported expression: Expr_Cast_Int])
}

fn wp_cache_set_multiple(var_data rt.PhpVal, group string, expire i64) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'set_multiple', [var_data.dup(), rt.new_string(group), // unsupported expression: Expr_Cast_Int])
}

fn wp_cache_get(var_key rt.PhpVal, group string, force bool, var_found rt.PhpVal) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'get', [var_key.dup(), rt.new_string(group), rt.new_bool(force), var_found.dup()])
}

fn wp_cache_get_multiple(var_keys rt.PhpVal, group string, force bool) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'get_multiple', [var_keys.dup(), rt.new_string(group), rt.new_bool(force)])
}

fn wp_cache_delete(var_key rt.PhpVal, group string) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'delete', [var_key.dup(), rt.new_string(group)])
}

fn wp_cache_delete_multiple(var_keys rt.PhpVal, group string) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'delete_multiple', [var_keys.dup(), rt.new_string(group)])
}

fn wp_cache_incr(var_key rt.PhpVal, offset i64, group string) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'incr', [var_key.dup(), rt.new_int(offset), rt.new_string(group)])
}

fn wp_cache_decr(var_key rt.PhpVal, offset i64, group string) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'decr', [var_key.dup(), rt.new_int(offset), rt.new_string(group)])
}

fn wp_cache_flush() rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'flush', []rt.PhpVal{})
}

fn wp_cache_flush_runtime() rt.PhpVal {
	return wp_cache_flush()
}

fn wp_cache_flush_group(var_group rt.PhpVal) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'flush_group', [var_group.dup()])
}

fn wp_cache_supports(var_feature rt.PhpVal) {
	mut switch_val_1 := var_feature
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('add_multiple'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('set_multiple'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('get_multiple'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_multiple'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('flush_runtime'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('flush_group'))) {
		return rt.new_bool(true)
	} else {
		return rt.new_bool(false)
	}
}

fn wp_cache_close() bool {
	return true
}

fn wp_cache_add_global_groups(var_groups rt.PhpVal) {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wp_object_cache, 'add_global_groups', [var_groups.dup()])
}

fn wp_cache_add_non_persistent_groups(var_groups rt.PhpVal) {
	// unsupported statement: Stmt_Nop
}

fn wp_cache_switch_to_blog(var_blog_id rt.PhpVal) {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wp_object_cache, 'switch_to_blog', [var_blog_id.dup()])
}

fn wp_cache_reset() {
	mut var_wp_object_cache := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.5.0'), rt.new_string('wp_cache_switch_to_blog()')])
	// unsupported statement: Stmt_Global
	rt.call_method(var_wp_object_cache, 'reset', []rt.PhpVal{})
}

struct Class_WP_Object_Cache {
	rt.PhpObjectBase
}

fn create_wp_object_cache() &Class_WP_Object_Cache {
	mut obj := &Class_WP_Object_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Object_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Object_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Object_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_cache_php() {
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-object-cache.php', '4')
}
