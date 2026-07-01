import rt

struct Class_VHttpd_WordPress_ProfilerEnv {
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


fn (mut this Class_VHttpd_WordPress_Wpdb) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_WordPress_Wpdb) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_Wpdb) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_v_profiler_v_profiler_vhttpd_db_php() {
	// unsupported statement: Stmt_Declare
	mut var_vhttpdPackageRoot := rt.call_function('dirname', [rt.new_string(@DIR), rt.new_int(2)])
	mut var_vhttpdWordPressRoot := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := rt.call_function('get_included_files', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_includedFile := item_1.val
			if rt.is_true(rt.identical(rt.call_function('basename', [var_includedFile.dup()]), rt.new_string('wp-config.php'))) {
				var_vhttpdWordPressRoot = rt.call_function('dirname', [var_includedFile.dup()])
				break
			}
		}
	}
	if rt.is_true(rt.identical(var_vhttpdWordPressRoot, rt.new_string(''))) {
		mut var_envRoot := rt.call_function('getenv', [rt.new_string('VPHP_WP_ROOT')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_envRoot.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_vhttpdWordPressRoot = rt.new_string(rt.new_string(var_envRoot.dup().to_string().trim_right(' \t\n\r')))
		}
	}
	if rt.is_true(rt.identical(var_vhttpdWordPressRoot, rt.new_string(''))) {
		mut var_script := if !(rt.get_superglobal('_SERVER').array_get('SCRIPT_FILENAME')).is_null() { rt.get_superglobal('_SERVER').array_get('SCRIPT_FILENAME') } else { rt.new_string('') }
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_script.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_vhttpdWordPressRoot = rt.call_function('dirname', [var_script.dup()])
			if rt.is_true(rt.identical(rt.call_function('basename', [var_vhttpdWordPressRoot.dup()]), rt.new_string('wp-admin'))) {
				var_vhttpdWordPressRoot = rt.call_function('dirname', [var_vhttpdWordPressRoot.dup()])
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('VHTTPD_DB_SOCKET')]))))) {
		rt.call_function('define', [rt.new_string('VHTTPD_DB_SOCKET'), if rt.is_true(rt.call_function('getenv', [rt.new_string('VHTTPD_DB_SOCKET')])) { rt.call_function('getenv', [rt.new_string('VHTTPD_DB_SOCKET')]) } else { rt.new_string('/tmp/vhttpd_wp_db.sock') }])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('VHTTPD_DB_POOL')]))))) {
		rt.call_function('define', [rt.new_string('VHTTPD_DB_POOL'), if rt.is_true(rt.call_function('getenv', [rt.new_string('VHTTPD_DB_POOL')])) { rt.call_function('getenv', [rt.new_string('VHTTPD_DB_POOL')]) } else { rt.new_string('wordpress') }])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('VHTTPD_DB_TIMEOUT_MS')]))))) {
		rt.call_function('define', [rt.new_string('VHTTPD_DB_TIMEOUT_MS'), // unsupported expression: Expr_Cast_Int])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('VHTTPD_PHP_PACKAGE_AUTOLOAD')]))))) {
		mut var_autoload := rt.new_string((var_vhttpdPackageRoot).str() + '/vendor/autoload.php')
		if rt.is_true(rt.call_function('is_file', [var_autoload.dup()])) {
			rt.call_function('define', [rt.new_string('VHTTPD_PHP_PACKAGE_AUTOLOAD'), var_autoload.dup()])
		}
	}
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
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(fn () rt.PhpVal { mut temp := Class_VHttpd_WordPress_ProfilerEnv{}; return temp.isfullmode() }()) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.call_function('defined', [rt.new_string('DB_USER')])))) && rt.is_true(rt.call_function('defined', [rt.new_string('DB_PASSWORD')])))) && rt.is_true(rt.call_function('defined', [rt.new_string('DB_NAME')])))) && rt.is_true(rt.call_function('defined', [rt.new_string('DB_HOST')])))) {
		mut var_wpdbClass := rt.new_string((var_vhttpdWordPressRoot).str() + '/wp-includes/class-wpdb.php')
		if rt.is_true(rt.call_function('is_file', [var_wpdbClass.dup()])) {
			rt.include_file((var_wpdbClass).to_string(), '4')
		}
		if rt.is_true(rt.call_function('class_exists', [Class_VHttpd_WordPress_Wpdb.class()])) {
			// unsupported statement: Stmt_Global
			if !(!(var_wpdb).is_null()) {
				mut var_wpdb := create_vhttpd_wordpress_wpdb(rt.get_constant('DB_USER'), rt.get_constant('DB_PASSWORD'), rt.get_constant('DB_NAME'), rt.get_constant('DB_HOST'), // unsupported expression: Expr_Cast_String, // unsupported expression: Expr_Cast_String, // unsupported expression: Expr_Cast_Int)
			}
		}
	}
}
