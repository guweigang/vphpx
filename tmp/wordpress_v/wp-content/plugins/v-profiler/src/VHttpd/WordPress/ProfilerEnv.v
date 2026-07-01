import rt

struct Class_VHttpd_WordPress_ProfilerEnv {
	rt.PhpObjectBase
pub mut:
		isVHttpd rt.PhpVal = rt.new_null()
		cachedMode rt.PhpVal = rt.new_null()
}

fn Class_VHttpd_WordPress_ProfilerEnv.isvhttpd() bool {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (// unsupported expression: Expr_StaticPropertyFetch).to_bool()
	}
	mut var_serverSoftware := if !(rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE')).is_null() { rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE') } else { rt.new_string('') }
	// unsupported assign target: Expr_StaticPropertyFetch
	return (// unsupported expression: Expr_StaticPropertyFetch).to_bool()
}

fn Class_VHttpd_WordPress_ProfilerEnv.getmode() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_VHttpd_WordPress_ProfilerEnv.isvhttpd())))) {
		return 'restricted'
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (// unsupported expression: Expr_StaticPropertyFetch).str()
	}
	mut var_wpContentDir := Class_VHttpd_WordPress_ProfilerEnv.getwpcontentdir()
	mut var_loaderFile := rt.new_string((var_wpContentDir).str() + '/mu-plugins/v-profiler-loader.php')
	mut var_dbFile := rt.new_string((var_wpContentDir).str() + '/db.php')
	if rt.is_true(rt.call_function('is_file', [var_loaderFile.dup()])) {
		// unsupported assign target: Expr_StaticPropertyFetch
	} else {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return (// unsupported expression: Expr_StaticPropertyFetch).str()
}

fn Class_VHttpd_WordPress_ProfilerEnv.isfullmode() bool {
	return (rt.identical(Class_VHttpd_WordPress_ProfilerEnv.getmode(), rt.new_string('full'))).to_bool()
}

fn Class_VHttpd_WordPress_ProfilerEnv.switchmode(targetMode string) bool {
	// unsupported assign target: Expr_StaticPropertyFetch
	if rt.is_true(rt.identical(rt.new_string(targetMode), rt.new_string('full'))) {
		return (Class_VHttpd_WordPress_ProfilerEnv.enablefullmode()).to_bool()
	}
	Class_VHttpd_WordPress_ProfilerEnv.enablerestrictedmode()
	return true
}

fn Class_VHttpd_WordPress_ProfilerEnv.activate()  {
	Class_VHttpd_WordPress_ProfilerEnv.deploymuloader()
	if rt.is_true(Class_VHttpd_WordPress_ProfilerEnv.isvhttpd()) {
		Class_VHttpd_WordPress_ProfilerEnv.deploydropins()
	}
	Class_VHttpd_WordPress_ProfilerEnv.resetopcache()
}

fn Class_VHttpd_WordPress_ProfilerEnv.deactivate()  {
	// unsupported assign target: Expr_StaticPropertyFetch
	Class_VHttpd_WordPress_ProfilerEnv.removemuloader()
	Class_VHttpd_WordPress_ProfilerEnv.removedropins()
	Class_VHttpd_WordPress_ProfilerEnv.resetopcache()
}

fn Class_VHttpd_WordPress_ProfilerEnv.deploydropins() bool {
	mut var_contentDir := Class_VHttpd_WordPress_ProfilerEnv.getwpcontentdir()
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_contentDir, rt.new_string(''))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [var_contentDir.dup()]))))))) {
		return false
	}
	mut var_pluginDir := Class_VHttpd_WordPress_ProfilerEnv.getplugindir()
	mut var_dbCandidates := rt.create_array([rt.ArrayItem{ key: none, val: (var_pluginDir).str() + '/v-profiler/db.php' }, rt.ArrayItem{ key: none, val: (var_pluginDir).str() + '/db.php' }])
	mut var_ocCandidates := rt.create_array([rt.ArrayItem{ key: none, val: (var_pluginDir).str() + '/v-profiler/object-cache.php' }, rt.ArrayItem{ key: none, val: (var_pluginDir).str() + '/object-cache.php' }])
	mut var_dbSrc := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_dbCandidates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_candidate := item_1.val
			if rt.is_true(rt.call_function('is_file', [var_candidate.dup()])) {
				var_dbSrc = var_candidate
				break
			}
		}
	}
	mut var_ocSrc := rt.new_string(rt.new_string(''))
	{
		mut iter_1 := var_ocCandidates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_candidate := item_1.val
			if rt.is_true(rt.call_function('is_file', [var_candidate.dup()])) {
				var_ocSrc = var_candidate
				break
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_dbSrc, rt.new_string(''))) || rt.is_true(rt.identical(var_ocSrc, rt.new_string(''))))) {
		return false
	}
	return rt.is_true(rt.call_function('copy', [var_dbSrc.dup(), (var_contentDir).str() + '/db.php'])) && rt.is_true(rt.call_function('copy', [var_ocSrc.dup(), (var_contentDir).str() + '/object-cache.php']))
}

fn Class_VHttpd_WordPress_ProfilerEnv.enablefullmode() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_VHttpd_WordPress_ProfilerEnv.isvhttpd())))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_VHttpd_WordPress_ProfilerEnv.deploydropins())))) {
		return false
	}
	Class_VHttpd_WordPress_ProfilerEnv.resetopcache()
	return true
}

fn Class_VHttpd_WordPress_ProfilerEnv.enablerestrictedmode()  {
	Class_VHttpd_WordPress_ProfilerEnv.removedropins()
	Class_VHttpd_WordPress_ProfilerEnv.resetopcache()
}

fn Class_VHttpd_WordPress_ProfilerEnv.deploymuloader()  {
	mut var_muDir := Class_VHttpd_WordPress_ProfilerEnv.getmupluginsdir()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [var_muDir.dup()]))))) {
			rt.call_function('mkdir', [var_muDir.dup(), rt.new_int(493), rt.new_bool(true)])
		}
		mut var_loaderContent := rt.new_string(rt.new_string('<?php\n/**\n * Plugin Name: v-Profiler Loader\n * Description: High-performance MUST-USE loader for v-Profiler telemetry module.\n * Version: 0.1.0\n * Author: guweigang\n *\n * Auto-generated by v-Profiler plugin. Do not edit directly.\n */\ndeclare(strict_types=1);\n\n$vProfilerEntry = (defined(\'WP_PLUGIN_DIR\') ? WP_PLUGIN_DIR : dirname(__DIR__) . \'/plugins\') . \'/v-profiler/v-profiler.php\';\nif (file_exists($vProfilerEntry)) {\n    require_once $vProfilerEntry;\n}'))
		rt.call_function('file_put_contents', [(var_muDir).str() + '/v-profiler-loader.php', var_loaderContent.dup()])
	}
}

fn Class_VHttpd_WordPress_ProfilerEnv.removemuloader()  {
	mut var_muDir := Class_VHttpd_WordPress_ProfilerEnv.getmupluginsdir()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_loader := rt.new_string((var_muDir).str() + '/v-profiler-loader.php')
		if rt.is_true(rt.call_function('is_file', [var_loader.dup()])) {
			rt.call_function('unlink', [var_loader.dup()])
		}
	}
}

fn Class_VHttpd_WordPress_ProfilerEnv.removedropins()  {
	mut var_contentDir := Class_VHttpd_WordPress_ProfilerEnv.getwpcontentdir()
	if rt.is_true(rt.identical(var_contentDir, rt.new_string(''))) {
		return rt.new_null()
	}
	mut var_dbFile := rt.new_string((var_contentDir).str() + '/db.php')
	if rt.is_true(rt.call_function('is_file', [var_dbFile.dup()])) {
		mut var_content := rt.call_function('file_get_contents', [var_dbFile.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('str_contains', [var_content.dup(), rt.new_string('Wpdb')])))) {
			rt.call_function('unlink', [var_dbFile.dup()])
		}
	}
	mut var_ocFile := rt.new_string((var_contentDir).str() + '/object-cache.php')
	if rt.is_true(rt.call_function('is_file', [var_ocFile.dup()])) {
		var_content = rt.call_function('file_get_contents', [var_ocFile.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('str_contains', [var_content.dup(), rt.new_string('ObjectCache')])))) {
			rt.call_function('unlink', [var_ocFile.dup()])
		}
	}
}

fn Class_VHttpd_WordPress_ProfilerEnv.resetopcache()  {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('opcache_reset')])) {
		rt.call_function('opcache_reset', []rt.PhpVal{})
	}
	rt.call_function('clearstatcache', [rt.new_bool(true)])
}

fn Class_VHttpd_WordPress_ProfilerEnv.getwpcontentdir() string {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_CONTENT_DIR')])) {
		return (rt.get_constant('WP_CONTENT_DIR')).str()
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) {
		return (rt.get_constant('ABSPATH')).str() + 'wp-content'
	}
	{
		mut iter_1 := rt.call_function('get_included_files', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_file := item_1.val
			if rt.is_true(rt.call_function('str_contains', [var_file.dup(), rt.new_string('wp-config.php')])) {
				return (rt.call_function('dirname', [var_file.dup()])).str() + '/wp-content'
			}
		}
	}
	return ''
}

fn Class_VHttpd_WordPress_ProfilerEnv.getmupluginsdir() string {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WPMU_PLUGIN_DIR')])) {
		return (rt.get_constant('WPMU_PLUGIN_DIR')).str()
	}
	mut var_contentDir := Class_VHttpd_WordPress_ProfilerEnv.getwpcontentdir()
	return if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { (var_contentDir).str() + '/mu-plugins' } else { '' }
}

fn Class_VHttpd_WordPress_ProfilerEnv.getplugindir() string {
	mut var_dir := rt.call_function('dirname', [rt.new_string(@DIR), rt.new_int(3)])
	if rt.is_true(rt.call_function('is_file', [(var_dir).str() + '/v-profiler.php'])) {
		return (var_dir).str()
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_PLUGIN_DIR')])) {
		return (rt.get_constant('WP_PLUGIN_DIR')).str() + '/v-profiler'
	}
	mut var_contentDir := Class_VHttpd_WordPress_ProfilerEnv.getwpcontentdir()
	return if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { (var_contentDir).str() + '/plugins/v-profiler' } else { '' }
}

fn create_vhttpd_wordpress_profilerenv() &Class_VHttpd_WordPress_ProfilerEnv {
	mut obj := &Class_VHttpd_WordPress_ProfilerEnv{
		PhpObjectBase: rt.PhpObjectBase{}
		isVHttpd: rt.new_null()
		cachedMode: rt.new_null()
	}
	return obj
}

fn (mut this Class_VHttpd_WordPress_ProfilerEnv) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'isVHttpd' {
			return rt.new_bool(Class_VHttpd_WordPress_ProfilerEnv.isvhttpd())
		}
		'getMode' {
			return rt.new_string(Class_VHttpd_WordPress_ProfilerEnv.getmode())
		}
		'isFullMode' {
			return rt.new_bool(Class_VHttpd_WordPress_ProfilerEnv.isfullmode())
		}
		'switchMode' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_VHttpd_WordPress_ProfilerEnv.switchmode(dispatch_arg_0))
		}
		'activate' {
			Class_VHttpd_WordPress_ProfilerEnv.activate()
			return rt.new_null()
		}
		'deactivate' {
			Class_VHttpd_WordPress_ProfilerEnv.deactivate()
			return rt.new_null()
		}
		'deployDropins' {
			return rt.new_bool(Class_VHttpd_WordPress_ProfilerEnv.deploydropins())
		}
		'enableFullMode' {
			return rt.new_bool(Class_VHttpd_WordPress_ProfilerEnv.enablefullmode())
		}
		'enableRestrictedMode' {
			Class_VHttpd_WordPress_ProfilerEnv.enablerestrictedmode()
			return rt.new_null()
		}
		'deployMuLoader' {
			Class_VHttpd_WordPress_ProfilerEnv.deploymuloader()
			return rt.new_null()
		}
		'removeMuLoader' {
			Class_VHttpd_WordPress_ProfilerEnv.removemuloader()
			return rt.new_null()
		}
		'removeDropins' {
			Class_VHttpd_WordPress_ProfilerEnv.removedropins()
			return rt.new_null()
		}
		'resetOpcache' {
			Class_VHttpd_WordPress_ProfilerEnv.resetopcache()
			return rt.new_null()
		}
		'getWpContentDir' {
			return rt.new_string(Class_VHttpd_WordPress_ProfilerEnv.getwpcontentdir())
		}
		'getMuPluginsDir' {
			return rt.new_string(Class_VHttpd_WordPress_ProfilerEnv.getmupluginsdir())
		}
		'getPluginDir' {
			return rt.new_string(Class_VHttpd_WordPress_ProfilerEnv.getplugindir())
		}
		else { return none }
	}
}

fn (this &Class_VHttpd_WordPress_ProfilerEnv) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'isVHttpd' { return this.isVHttpd }
		'cachedMode' { return this.cachedMode }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_VHttpd_WordPress_ProfilerEnv) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'isVHttpd' { this.isVHttpd = val; return true }
		'cachedMode' { this.cachedMode = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_v_profiler_src_vhttpd_wordpress_profilerenv_php() {
	// unsupported statement: Stmt_Declare
}
