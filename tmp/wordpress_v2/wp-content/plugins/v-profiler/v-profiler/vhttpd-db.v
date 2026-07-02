import rt

struct Class_VHttpd_WordPress_ProfilerEnv {
	rt.PhpObjectBase
}

struct Class_VHttpd_WordPress_Wpdb {
	rt.PhpObjectBase
}

fn create_vhttpd_wordpress_profilerenv(_args ...rt.PhpVal) &Class_VHttpd_WordPress_ProfilerEnv {
	mut obj := &Class_VHttpd_WordPress_ProfilerEnv{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_wordpress_wpdb(_args ...rt.PhpVal) &Class_VHttpd_WordPress_Wpdb {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_vhttpdPackageRoot := rt.call_function('dirname', [
		rt.new_string(@DIR), rt.new_int(2)])
	mut var_vhttpdWordPressRoot := rt.new_string('')
	mut iter_1 := rt.call_function('get_included_files', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_includedFile := item_1.val
		if rt.is_true(rt.identical(rt.call_function('basename', [
			var_includedFile.clone()]), rt.new_string('wp-config.php')))
		{
			var_vhttpdWordPressRoot = rt.call_function('dirname', [
				var_includedFile.clone()])
			break
		}
	}
	if rt.is_true(rt.identical(var_vhttpdWordPressRoot, rt.new_string(''))) {
		mut var_envRoot := rt.call_function('getenv', [rt.new_string('VPHP_WP_ROOT')])
		if var_envRoot.clone().is_string()
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_envRoot, rt.new_string(''))))) {
			var_vhttpdWordPressRoot =
				rt.new_string(var_envRoot.clone().to_string().trim_right(' \t\n\r'))
		}
	}
	if rt.is_true(rt.identical(var_vhttpdWordPressRoot, rt.new_string(''))) {
		mut var_script := if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('SCRIPT_FILENAME'))).is_null() {
			rt.get_superglobal('_SERVER').array_get(rt.new_string('SCRIPT_FILENAME'))
		} else {
			rt.new_string('')
		}
		if var_script.clone().is_string()
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_script, rt.new_string(''))))) {
			var_vhttpdWordPressRoot = rt.call_function('dirname', [
				var_script.clone()])
			if rt.is_true(rt.identical(rt.call_function('basename', [
				var_vhttpdWordPressRoot.clone()]), rt.new_string('wp-admin')))
			{
				var_vhttpdWordPressRoot = rt.call_function('dirname', [
					var_vhttpdWordPressRoot.clone()])
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('VHTTPD_DB_SOCKET'),
	])))))
	{
		rt.call_function('define', [rt.new_string('VHTTPD_DB_SOCKET'), if rt.is_true(rt.call_function('getenv', [
			rt.new_string('VHTTPD_DB_SOCKET'),
		]))
		{ rt.call_function('getenv', [
				rt.new_string('VHTTPD_DB_SOCKET'),
			]) } else { rt.new_string('/tmp/vhttpd_wp_db.sock') }])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('VHTTPD_DB_POOL'),
	])))))
	{
		rt.call_function('define', [rt.new_string('VHTTPD_DB_POOL'), if rt.is_true(rt.call_function('getenv', [
			rt.new_string('VHTTPD_DB_POOL'),
		]))
		{ rt.call_function('getenv', [
				rt.new_string('VHTTPD_DB_POOL'),
			]) } else { rt.new_string('wordpress') }])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('VHTTPD_DB_TIMEOUT_MS'),
	])))))
	{
		rt.call_function('define', [rt.new_string('VHTTPD_DB_TIMEOUT_MS'),
			rt.new_int((if rt.is_true(rt.call_function('getenv', [
				rt.new_string('VHTTPD_DB_TIMEOUT_MS'),
			]))
			{ rt.call_function('getenv', [
					rt.new_string('VHTTPD_DB_TIMEOUT_MS'),
				]) } else { rt.new_int(3000) }).to_i64())])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('VHTTPD_PHP_PACKAGE_AUTOLOAD'),
	])))))
	{
		mut var_autoload := rt.new_string(var_vhttpdPackageRoot.str() + '/vendor/autoload.php')
		if rt.is_true(rt.call_function('is_file', [var_autoload.clone()])) {
			rt.call_function('define', [rt.new_string('VHTTPD_PHP_PACKAGE_AUTOLOAD'),
				var_autoload.clone()])
		}
	}
	closure_1_fn := fn [var_vhttpdPackageRoot] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_class := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_prefix := rt.new_string('VHttpd\\')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
			var_class.clone(),
			var_prefix.clone(),
		])))))
		{
			return rt.new_null()
		}
		mut var_relative := rt.call_function('str_replace', [
			rt.new_string('\\'), rt.new_string('/'),
			rt.call_function('substr', [
				var_class.clone(),
				rt.new_int(var_prefix.clone().to_string().len),
			])])
		mut var_file := rt.new_string(var_vhttpdPackageRoot.str() + '/src/VHttpd/' +
			var_relative.str() + '.php')
		if rt.is_true(rt.call_function('is_file', [var_file.clone()])) {
			rt.include_file(var_file.to_string(), '4')
		}
		return rt.new_null()
	}
	closure_2_fn := fn [var_vhttpdPackageRoot] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_class := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_prefix := rt.new_string('VHttpd\\')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
			var_class.clone(),
			var_prefix.clone(),
		])))))
		{
			return rt.new_null()
		}
		mut var_relative := rt.call_function('str_replace', [
			rt.new_string('\\'), rt.new_string('/'),
			rt.call_function('substr', [
				var_class.clone(),
				rt.new_int(var_prefix.clone().to_string().len),
			])])
		mut var_file := rt.new_string(var_vhttpdPackageRoot.str() + '/src/VHttpd/' +
			var_relative.str() + '.php')
		if rt.is_true(rt.call_function('is_file', [var_file.clone()])) {
			rt.include_file(var_file.to_string(), '4')
		}
		return rt.new_null()
	}
	rt.call_function('spl_autoload_register', [rt.new_closure(closure_1_fn)])
	mut iife_temp_2 := Class_VHttpd_WordPress_ProfilerEnv{}
	mut iife_result_2 := iife_temp_2.isfullmode()
	if rt.is_true(iife_result_2)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_vhttpdWordPressRoot, rt.new_string('')))))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('DB_USER')]))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('DB_PASSWORD')]))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('DB_NAME')]))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('DB_HOST')])) {
		mut var_wpdbClass := rt.new_string(var_vhttpdWordPressRoot.str() +
			'/wp-includes/class-wpdb.php')
		if rt.is_true(rt.call_function('is_file', [var_wpdbClass.clone()])) {
			rt.include_file(var_wpdbClass.to_string(), '4')
		}
		if rt.is_true(rt.call_function('class_exists', [
			Class_VHttpd_WordPress_Wpdb.class(),
		]))
		{
			mut var_wpdb := rt.get_superglobal('wpdb')
			if !(!var_wpdb.is_null()) {
				var_wpdb = create_vhttpd_wordpress_wpdb(rt.get_constant('DB_USER'),
					rt.get_constant('DB_PASSWORD'), rt.get_constant('DB_NAME'),
					rt.get_constant('DB_HOST'), (rt.get_constant('VHTTPD_DB_SOCKET')).str(),
					(rt.get_constant('VHTTPD_DB_POOL')).str(),
					rt.new_int((rt.get_constant('VHTTPD_DB_TIMEOUT_MS')).to_i64()))
			}
		}
	}
}
