import rt

fn wp_cache_init() {
	mut var_GLOBALS := rt.new_null()
	mut var_client := rt.new_null()
	mut var_socket := rt.call_function('getenv', [rt.new_string('VHTTPD_CACHE_SOCKET')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_socket.dup().is_string()))))) || rt.is_true(rt.identical(var_socket, rt.new_string(''))))) {
		var_socket = if !(rt.get_superglobal('_SERVER').array_get('VHTTPD_CACHE_SOCKET')).is_null() { rt.get_superglobal('_SERVER').array_get('VHTTPD_CACHE_SOCKET') } else { rt.new_string('') }
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [Class_VHttpd_Cache_Client.class()])) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(fn () rt.PhpVal { mut temp := Class_VHttpd_WordPress_ProfilerEnv{}; return temp.isfullmode() }()))) {
		var_client = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_VHttpd_Cache_Client{}; return temp.fromenv(arg_0) }(rt.new_string('wordpress'))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [Class_VHttpd_WordPress_ObjectCache.class()]))))) || rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_VHttpd_WordPress_ProfilerEnv{}; return temp.isfullmode() }())))))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) && rt.is_true(rt.call_function('defined', [rt.new_string('WPINC')])))) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-object-cache.php', '4')
			var_GLOBALS.array_set('wp_object_cache', create_wp_object_cache())
		} else {
			// unsupported expression: Expr_Exit
		}
	} else {
		var_GLOBALS.array_set('wp_object_cache', create_vhttpd_wordpress_objectcache(var_client.dup()))
	}
}

fn wp_cache_add(var_key rt.PhpVal, var_data rt.PhpVal, group string, expire i64) bool {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return (rt.call_method(var_wp_object_cache, 'add', [var_key.dup(), var_data.dup(), rt.new_string(group), // unsupported expression: Expr_Cast_Int])).to_bool()
}

fn wp_cache_add_multiple(var_data rt.PhpVal, group string, expire i64) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'add_multiple', [var_data.dup(), rt.new_string(group), // unsupported expression: Expr_Cast_Int])
}

fn wp_cache_replace(var_key rt.PhpVal, var_data rt.PhpVal, group string, expire i64) bool {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return (rt.call_method(var_wp_object_cache, 'replace', [var_key.dup(), var_data.dup(), rt.new_string(group), // unsupported expression: Expr_Cast_Int])).to_bool()
}

fn wp_cache_set(var_key rt.PhpVal, var_data rt.PhpVal, group string, expire i64) bool {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return (rt.call_method(var_wp_object_cache, 'set', [var_key.dup(), var_data.dup(), rt.new_string(group), // unsupported expression: Expr_Cast_Int])).to_bool()
}

fn wp_cache_set_multiple(var_data rt.PhpVal, group string, expire i64) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'set_multiple', [var_data.dup(), rt.new_string(group), // unsupported expression: Expr_Cast_Int])
}

fn wp_cache_get(var_key rt.PhpVal, group string, force bool, var_found rt.PhpVal) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'get', [var_key.dup(), rt.new_string(group), // unsupported expression: Expr_Cast_Bool, var_found.dup()])
}

fn wp_cache_get_multiple(var_keys rt.PhpVal, group string, force bool) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'get_multiple', [var_keys.dup(), rt.new_string(group), // unsupported expression: Expr_Cast_Bool])
}

fn wp_cache_delete(var_key rt.PhpVal, group string) bool {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return (rt.call_method(var_wp_object_cache, 'delete', [var_key.dup(), rt.new_string(group)])).to_bool()
}

fn wp_cache_delete_multiple(var_keys rt.PhpVal, group string) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'delete_multiple', [var_keys.dup(), rt.new_string(group)])
}

fn wp_cache_incr(var_key rt.PhpVal, offset i64, group string) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'incr', [var_key.dup(), // unsupported expression: Expr_Cast_Int, rt.new_string(group)])
}

fn wp_cache_decr(var_key rt.PhpVal, offset i64, group string) rt.PhpVal {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_method(var_wp_object_cache, 'decr', [var_key.dup(), // unsupported expression: Expr_Cast_Int, rt.new_string(group)])
}

fn wp_cache_flush() bool {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return (rt.call_method(var_wp_object_cache, 'flush', []rt.PhpVal{})).to_bool()
}

fn wp_cache_flush_runtime() bool {
	return wp_cache_flush()
}

fn wp_cache_flush_group(var_group rt.PhpVal) bool {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	return (rt.call_method(var_wp_object_cache, 'flush_group', [var_group.dup()])).to_bool()
}

fn wp_cache_supports(var_feature rt.PhpVal) bool {
	return (rt.call_function('in_array', [var_feature.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'add_multiple' }, rt.ArrayItem{ key: none, val: 'set_multiple' }, rt.ArrayItem{ key: none, val: 'get_multiple' }, rt.ArrayItem{ key: none, val: 'delete_multiple' }, rt.ArrayItem{ key: none, val: 'flush_runtime' }, rt.ArrayItem{ key: none, val: 'flush_group' }]), rt.new_bool(true)])).to_bool()
}

fn wp_cache_close() bool {
	return true
}

fn wp_cache_add_global_groups(var_groups rt.PhpVal) {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_wp_object_cache.dup().is_object())) && rt.is_true(rt.call_function('method_exists', [var_wp_object_cache.dup(), rt.new_string('add_global_groups')])))) {
		rt.call_method(var_wp_object_cache, 'add_global_groups', [var_groups.dup()])
	}
}

fn wp_cache_add_non_persistent_groups(var_groups rt.PhpVal) {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_wp_object_cache.dup().is_object())) && rt.is_true(rt.call_function('method_exists', [var_wp_object_cache.dup(), rt.new_string('add_non_persistent_groups')])))) {
		rt.call_method(var_wp_object_cache, 'add_non_persistent_groups', [var_groups.dup()])
	}
}

fn wp_cache_switch_to_blog(var_blog_id rt.PhpVal) {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_wp_object_cache.dup().is_object())) && rt.is_true(rt.call_function('method_exists', [var_wp_object_cache.dup(), rt.new_string('switch_to_blog')])))) {
		rt.call_method(var_wp_object_cache, 'switch_to_blog', [var_blog_id.dup()])
	}
}

fn wp_cache_reset() {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_wp_object_cache.dup().is_object())) && rt.is_true(rt.call_function('method_exists', [var_wp_object_cache.dup(), rt.new_string('reset')])))) {
		rt.call_method(var_wp_object_cache, 'reset', []rt.PhpVal{})
	}
}

fn wp_cache_clear_local() {
	mut var_wp_object_cache := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_wp_object_cache.dup().is_object())) && rt.is_true(rt.call_function('method_exists', [var_wp_object_cache.dup(), rt.new_string('clearLocalCache')])))) {
		rt.call_method(var_wp_object_cache, 'clearLocalCache', []rt.PhpVal{})
	}
}

struct Class_VHttpd_WordPress_ProfilerEnv {
	rt.PhpObjectBase
}

struct Class_VHttpd_Cache_Client {
	rt.PhpObjectBase
}

struct Class_WP_Object_Cache {
	rt.PhpObjectBase
}

struct Class_VHttpd_WordPress_ObjectCache {
	rt.PhpObjectBase
}

fn create_vhttpd_wordpress_profilerenv() &Class_VHttpd_WordPress_ProfilerEnv {
	mut obj := &Class_VHttpd_WordPress_ProfilerEnv{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_cache_client() &Class_VHttpd_Cache_Client {
	mut obj := &Class_VHttpd_Cache_Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_object_cache() &Class_WP_Object_Cache {
	mut obj := &Class_WP_Object_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_wordpress_objectcache() &Class_VHttpd_WordPress_ObjectCache {
	mut obj := &Class_VHttpd_WordPress_ObjectCache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_VHttpd_WordPress_ProfilerEnv) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_WordPress_ProfilerEnv) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_ProfilerEnv) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_VHttpd_Cache_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_Cache_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_Cache_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_VHttpd_WordPress_ObjectCache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_WordPress_ObjectCache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_ObjectCache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_object_cache_php() {
	// unsupported statement: Stmt_Declare
	mut var_vhttpdPackageRoot := rt.call_function('dirname', [rt.new_string(@DIR), rt.new_int(2)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [Class_VHttpd_WordPress_ObjectCache.class()]))))) {
		mut var_autoload := rt.call_function('getenv', [rt.new_string('VHTTPD_PHP_PACKAGE_AUTOLOAD')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_autoload.dup().is_string()))))) || rt.is_true(rt.identical(var_autoload, rt.new_string(''))))) && rt.is_true(rt.call_function('defined', [rt.new_string('VHTTPD_PHP_PACKAGE_AUTOLOAD')])))) {
			var_autoload = // unsupported expression: Expr_Cast_String
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_autoload.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.call_function('is_file', [var_autoload.dup()])))) {
			rt.include_file((var_autoload).to_string(), '4')
		} else if rt.is_true(rt.call_function('is_file', [(var_vhttpdPackageRoot).str() + '/vendor/autoload.php'])) {
			rt.include_file((var_vhttpdPackageRoot).str() + '/vendor/autoload.php', '4')
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [Class_VHttpd_WordPress_ObjectCache.class()]))))) {
		closure_2_fn := fn [var_vhttpdPackageRoot] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_vhttpdPackageRoot] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_class := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_prefix := rt.new_string(rt.new_string('VHttpd\\'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_class.dup(), var_prefix.dup()]))))) {
		return rt.new_null()
	}
	mut var_relative := rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), rt.call_function('substr', [var_class.dup(), rt.new_int(var_prefix.dup().to_string().len)])])
	mut var_file := rt.new_string((var_vhttpdPackageRoot).str() + '/src/VHttpd/' + (var_relative).str() + '.php')
	if rt.is_true(rt.call_function('is_file', [var_file.dup()])) {
		rt.include_file((var_file).to_string(), '4')
	}
	return rt.new_null()
	}
	mut var_class := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_prefix := rt.new_string(rt.new_string('VHttpd\\'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [var_class.dup(), var_prefix.dup()]))))) {
		return rt.new_null()
	}
	mut var_relative := rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), rt.call_function('substr', [var_class.dup(), rt.new_int(var_prefix.dup().to_string().len)])])
	mut var_file := rt.new_string((var_vhttpdPackageRoot).str() + '/src/VHttpd/' + (var_relative).str() + '.php')
	if rt.is_true(rt.call_function('is_file', [var_file.dup()])) {
		rt.include_file((var_file).to_string(), '4')
	}
	return rt.new_null()
	}
		rt.call_function('spl_autoload_register', [rt.new_closure(closure_1_fn)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_init')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_add')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_add_multiple')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_replace')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_set')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_set_multiple')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_get')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_get_multiple')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_delete')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_delete_multiple')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_incr')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_decr')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_flush')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_flush_runtime')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_flush_group')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_supports')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_close')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_add_global_groups')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_add_non_persistent_groups')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_switch_to_blog')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_reset')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_cache_clear_local')]))))) {
	}
}
