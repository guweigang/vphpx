import rt

struct Class_VHttpd_WordPress_ProfilerEnv {
	rt.PhpObjectBase
}

struct Class_wpdb {
	rt.PhpObjectBase
}

struct Class_VHttpd_WordPress_Wpdb {
	rt.PhpObjectBase
}

fn create_vhttpd_wordpress_profilerenv() &Class_VHttpd_WordPress_ProfilerEnv {
	mut obj := &Class_VHttpd_WordPress_ProfilerEnv{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wpdb() &Class_wpdb {
	mut obj := &Class_wpdb{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_wordpress_wpdb() &Class_VHttpd_WordPress_Wpdb {
	mut obj := &Class_VHttpd_WordPress_Wpdb{
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


fn (mut this Class_wpdb) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_wpdb) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_wpdb) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_VHttpd_WordPress_Wpdb) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_WordPress_Wpdb) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_Wpdb) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_db_php() {
	// unsupported statement: Stmt_Declare
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [Class_VHttpd_WordPress_Wpdb.class()]))))) {
		mut var_vProfilerDir := rt.new_null()
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WPMU_PLUGIN_DIR')])) && rt.is_true(rt.call_function('is_dir', [(rt.get_constant('WPMU_PLUGIN_DIR')).str() + '/v-profiler'])))) {
			var_vProfilerDir = rt.new_string((rt.get_constant('WPMU_PLUGIN_DIR')).str() + '/v-profiler')
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_PLUGIN_DIR')])) && rt.is_true(rt.call_function('is_dir', [(rt.get_constant('WP_PLUGIN_DIR')).str() + '/v-profiler'])))) {
			var_vProfilerDir = rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/v-profiler')
		} else if rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) {
			if rt.is_true(rt.call_function('is_dir', [(rt.get_constant('ABSPATH')).str() + 'wp-content/mu-plugins/v-profiler'])) {
				var_vProfilerDir = rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-content/mu-plugins/v-profiler')
			} else if rt.is_true(rt.call_function('is_dir', [(rt.get_constant('ABSPATH')).str() + 'wp-content/plugins/v-profiler'])) {
				var_vProfilerDir = rt.new_string((rt.get_constant('ABSPATH')).str() + 'wp-content/plugins/v-profiler')
			}
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			closure_2_fn := fn [var_vProfilerDir] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [var_vProfilerDir] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_class := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_prefix := rt.new_string(rt.new_string('VHttpd\\'))
	if rt.is_true(rt.call_function('str_starts_with', [var_class.dup(), var_prefix.dup()])) {
		mut var_relative := rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), rt.call_function('substr', [var_class.dup(), rt.new_int(var_prefix.dup().to_string().len)])])
		mut var_file := rt.new_string((var_vProfilerDir).str() + '/src/VHttpd/' + (var_relative).str() + '.php')
		if rt.is_true(rt.call_function('is_file', [var_file.dup()])) {
			rt.include_file((var_file).to_string(), '4')
		}
	}
	return rt.new_null()
	}
	mut var_class := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_prefix := rt.new_string(rt.new_string('VHttpd\\'))
	if rt.is_true(rt.call_function('str_starts_with', [var_class.dup(), var_prefix.dup()])) {
		mut var_relative := rt.call_function('str_replace', [rt.new_string('\\'), rt.new_string('/'), rt.call_function('substr', [var_class.dup(), rt.new_int(var_prefix.dup().to_string().len)])])
		mut var_file := rt.new_string((var_vProfilerDir).str() + '/src/VHttpd/' + (var_relative).str() + '.php')
		if rt.is_true(rt.call_function('is_file', [var_file.dup()])) {
			rt.include_file((var_file).to_string(), '4')
		}
	}
	return rt.new_null()
	}
			rt.call_function('spl_autoload_register', [rt.new_closure(closure_1_fn)])
		}
	}
	mut var_socket := rt.call_function('getenv', [rt.new_string('VHTTPD_DB_SOCKET')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_socket.dup().is_string()))))) || rt.is_true(rt.identical(var_socket, rt.new_string(''))))) {
		var_socket = if rt.is_true(rt.call_function('defined', [rt.new_string('VHTTPD_DB_SOCKET')])) { // unsupported expression: Expr_Cast_String } else { rt.new_string('/tmp/vhttpd_db.sock') }
	}
	mut var_pool := rt.call_function('getenv', [rt.new_string('VHTTPD_DB_POOL')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_pool.dup().is_string()))))) || rt.is_true(rt.identical(var_pool, rt.new_string(''))))) {
		var_pool = if rt.is_true(rt.call_function('defined', [rt.new_string('VHTTPD_DB_POOL')])) { // unsupported expression: Expr_Cast_String } else { rt.new_string('default') }
	}
	mut var_timeout := rt.call_function('getenv', [rt.new_string('VHTTPD_DB_TIMEOUT_MS')])
	mut var_timeoutMs := if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_timeout.dup().is_string())) && rt.is_true(rt.call_function('ctype_digit', [var_timeout.dup()])))) { // unsupported expression: Expr_Cast_Int } else { rt.new_int(1000) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [Class_VHttpd_WordPress_Wpdb.class()]))))) || rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_VHttpd_WordPress_ProfilerEnv{}; return temp.isfullmode() }())))))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) && rt.is_true(rt.call_function('defined', [rt.new_string('WPINC')])))) {
			rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wpdb.php', '4')
			mut var_wpdb := create_wpdb(rt.get_constant('DB_USER'), rt.get_constant('DB_PASSWORD'), rt.get_constant('DB_NAME'), rt.get_constant('DB_HOST'))
		} else {
			// unsupported expression: Expr_Exit
		}
	} else {
		var_wpdb = create_vhttpd_wordpress_wpdb(rt.get_constant('DB_USER'), rt.get_constant('DB_PASSWORD'), rt.get_constant('DB_NAME'), rt.get_constant('DB_HOST'), var_socket.dup(), var_pool.dup(), var_timeoutMs.dup())
	}
}
