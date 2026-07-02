import rt

struct Class_VHttpd_WordPress_ProfilerEnv {
	rt.PhpObjectBase
}

fn init_static_vhttpd_wordpress_profilerenv() {
	rt.init_static_prop('VHttpd_WordPress_ProfilerEnv', 'isVHttpd', rt.new_null())
	rt.init_static_prop('VHttpd_WordPress_ProfilerEnv', 'cachedMode', rt.new_null())
}

fn Class_VHttpd_WordPress_ProfilerEnv.isvhttpd() bool {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_static_prop('VHttpd_WordPress_ProfilerEnv',
		'isVHttpd'), rt.new_null()))))
	{
		return (rt.get_static_prop('VHttpd_WordPress_ProfilerEnv', 'isVHttpd')).to_bool()
	}
	mut var_serverSoftware := if !(rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE'))).is_null() {
		rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE'))
	} else {
		rt.new_string('')
	}
	rt.set_static_prop('VHttpd_WordPress_ProfilerEnv', 'isVHttpd', rt.new_bool(
		rt.is_true(rt.call_function('str_contains', [rt.new_string(var_serverSoftware.clone().to_string().to_lower()), rt.new_string('vhttpd')]))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('getenv', [rt.new_string('VHTTPD_DB_SOCKET')]), rt.new_bool(false)))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('getenv', [rt.new_string('VHTTPD_CACHE_SOCKET')]), rt.new_bool(false)))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('getenv', [rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET')]), rt.new_bool(false)))))
		|| rt.get_superglobal('_SERVER').array_isset(rt.new_string('VHTTPD_DB_SOCKET'))
		|| rt.get_superglobal('_SERVER').array_isset(rt.new_string('VHTTPD_CACHE_SOCKET'))
		|| rt.get_superglobal('_SERVER').array_isset(rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET'))
		|| rt.get_superglobal('_ENV').array_isset(rt.new_string('VHTTPD_DB_SOCKET'))
		|| rt.get_superglobal('_ENV').array_isset(rt.new_string('VHTTPD_CACHE_SOCKET'))
		|| rt.get_superglobal('_ENV').array_isset(rt.new_string('VHTTPD_INTERNAL_ADMIN_SOCKET'))))
	return (rt.get_static_prop('VHttpd_WordPress_ProfilerEnv', 'isVHttpd')).to_bool()
}

fn Class_VHttpd_WordPress_ProfilerEnv.getmode() string {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_VHttpd_WordPress_ProfilerEnv.isvhttpd())))) {
		return 'restricted'
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_static_prop('VHttpd_WordPress_ProfilerEnv',
		'cachedMode'), rt.new_null()))))
	{
		return (rt.get_static_prop('VHttpd_WordPress_ProfilerEnv', 'cachedMode')).str()
	}
	mut var_wpContentDir := Class_VHttpd_WordPress_ProfilerEnv.getwpcontentdir()
	mut var_loaderFile :=
		rt.new_string(var_wpContentDir.str() + '/mu-plugins/v-profiler-loader.php')
	mut var_dbFile := rt.new_string(var_wpContentDir.str() + '/db.php')
	if rt.is_true(rt.call_function('is_file', [var_loaderFile.clone()])) {
		rt.set_static_prop('VHttpd_WordPress_ProfilerEnv', 'cachedMode', if rt.is_true(rt.call_function('is_file', [
			var_dbFile.clone(),
		]))
		{ 'full' } else { 'restricted' })
	} else {
		rt.set_static_prop('VHttpd_WordPress_ProfilerEnv', 'cachedMode', rt.new_string('full'))
	}
	return (rt.get_static_prop('VHttpd_WordPress_ProfilerEnv', 'cachedMode')).str()
}

fn Class_VHttpd_WordPress_ProfilerEnv.isfullmode() bool {
	return (rt.identical(Class_VHttpd_WordPress_ProfilerEnv.getmode(), rt.new_string('full'))).to_bool()
}

fn Class_VHttpd_WordPress_ProfilerEnv.switchmode(targetMode string) bool {
	rt.set_static_prop('VHttpd_WordPress_ProfilerEnv', 'cachedMode', rt.new_null())
	if rt.is_true(rt.identical(rt.new_string(targetMode), rt.new_string('full'))) {
		return (Class_VHttpd_WordPress_ProfilerEnv.enablefullmode()).to_bool()
	}
	Class_VHttpd_WordPress_ProfilerEnv.enablerestrictedmode()
	return true
}

fn Class_VHttpd_WordPress_ProfilerEnv.activate() {
	Class_VHttpd_WordPress_ProfilerEnv.deploymuloader()
	if rt.is_true(Class_VHttpd_WordPress_ProfilerEnv.isvhttpd()) {
		Class_VHttpd_WordPress_ProfilerEnv.deploydropins()
	}
	Class_VHttpd_WordPress_ProfilerEnv.resetopcache()
}

fn Class_VHttpd_WordPress_ProfilerEnv.deactivate() {
	rt.set_static_prop('VHttpd_WordPress_ProfilerEnv', 'cachedMode', rt.new_null())
	Class_VHttpd_WordPress_ProfilerEnv.removemuloader()
	Class_VHttpd_WordPress_ProfilerEnv.removedropins()
	Class_VHttpd_WordPress_ProfilerEnv.resetopcache()
}

fn Class_VHttpd_WordPress_ProfilerEnv.deploydropins() bool {
	mut var_contentDir := Class_VHttpd_WordPress_ProfilerEnv.getwpcontentdir()
	if rt.is_true(rt.identical(var_contentDir, rt.new_string('')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_writable', [var_contentDir.clone()]))))) {
		return false
	}
	mut var_pluginDir := Class_VHttpd_WordPress_ProfilerEnv.getplugindir()
	mut var_dbCandidates := rt.create_array([
		rt.ArrayItem{ key: none, val: var_pluginDir.str() + '/v-profiler/db.php' },
		rt.ArrayItem{ key: none, val: var_pluginDir.str() + '/db.php' },
	])
	mut var_ocCandidates := rt.create_array([
		rt.ArrayItem{ key: none, val: var_pluginDir.str() + '/v-profiler/object-cache.php' },
		rt.ArrayItem{ key: none, val: var_pluginDir.str() + '/object-cache.php' },
	])
	mut var_dbSrc := rt.new_string('')
	mut iter_1 := var_dbCandidates.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_candidate := item_1.val
		if rt.is_true(rt.call_function('is_file', [var_candidate.clone()])) {
			var_dbSrc = var_candidate
			break
		}
	}
	mut var_ocSrc := rt.new_string('')
	mut iter_2 := var_ocCandidates.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_candidate := item_2.val
		if rt.is_true(rt.call_function('is_file', [var_candidate.clone()])) {
			var_ocSrc = var_candidate
			break
		}
	}
	if rt.is_true(rt.identical(var_dbSrc, rt.new_string('')))
		|| rt.is_true(rt.identical(var_ocSrc, rt.new_string(''))) {
		return false
	}
	return
		rt.is_true(rt.call_function('copy', [var_dbSrc.clone(), rt.new_string(var_contentDir.str() + '/db.php')]))
		&& rt.is_true(rt.call_function('copy', [var_ocSrc.clone(), rt.new_string(var_contentDir.str() + '/object-cache.php')]))
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

fn Class_VHttpd_WordPress_ProfilerEnv.enablerestrictedmode() {
	Class_VHttpd_WordPress_ProfilerEnv.removedropins()
	Class_VHttpd_WordPress_ProfilerEnv.resetopcache()
}

fn Class_VHttpd_WordPress_ProfilerEnv.deploymuloader() {
	mut var_muDir := Class_VHttpd_WordPress_ProfilerEnv.getmupluginsdir()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_muDir, rt.new_string(''))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_dir', [
			var_muDir.clone()])))))
		{
			rt.call_function('mkdir', [var_muDir.clone(), rt.new_int(493),
				rt.new_bool(true)])
		}
		mut var_loaderContent :=
			rt.new_string("<?php\n/**\n * Plugin Name: v-Profiler Loader\n * Description: High-performance MUST-USE loader for v-Profiler telemetry module.\n * Version: 0.1.0\n * Author: guweigang\n *\n * Auto-generated by v-Profiler plugin. Do not edit directly.\n */\ndeclare(strict_types=1);\n\n$vProfilerEntry = (defined('WP_PLUGIN_DIR') ? WP_PLUGIN_DIR : dirname(__DIR__) . '/plugins') . '/v-profiler/v-profiler.php';\nif (file_exists($vProfilerEntry)) {\n    require_once $vProfilerEntry;\n}")
		rt.call_function('file_put_contents', [
			rt.new_string(var_muDir.str() + '/v-profiler-loader.php'),
			var_loaderContent.clone(),
		])
	}
}

fn Class_VHttpd_WordPress_ProfilerEnv.removemuloader() {
	mut var_muDir := Class_VHttpd_WordPress_ProfilerEnv.getmupluginsdir()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_muDir, rt.new_string(''))))) {
		mut var_loader := rt.new_string(var_muDir.str() + '/v-profiler-loader.php')
		if rt.is_true(rt.call_function('is_file', [var_loader.clone()])) {
			rt.call_function('unlink', [var_loader.clone()])
		}
	}
}

fn Class_VHttpd_WordPress_ProfilerEnv.removedropins() {
	mut var_contentDir := Class_VHttpd_WordPress_ProfilerEnv.getwpcontentdir()
	if rt.is_true(rt.identical(var_contentDir, rt.new_string(''))) {
		return
	}
	mut var_dbFile := rt.new_string(var_contentDir.str() + '/db.php')
	if rt.is_true(rt.call_function('is_file', [var_dbFile.clone()])) {
		mut var_content := rt.call_function('file_get_contents', [
			var_dbFile.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_content, rt.new_bool(false)))))
			&& rt.is_true(rt.call_function('str_contains', [var_content.clone(), rt.new_string('Wpdb')])) {
			rt.call_function('unlink', [var_dbFile.clone()])
		}
	}
	mut var_ocFile := rt.new_string(var_contentDir.str() + '/object-cache.php')
	if rt.is_true(rt.call_function('is_file', [var_ocFile.clone()])) {
		var_content = rt.call_function('file_get_contents', [
			var_ocFile.clone()])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_content, rt.new_bool(false)))))
			&& rt.is_true(rt.call_function('str_contains', [var_content.clone(), rt.new_string('ObjectCache')])) {
			rt.call_function('unlink', [var_ocFile.clone()])
		}
	}
}

fn Class_VHttpd_WordPress_ProfilerEnv.resetopcache() {
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
	mut iter_3 := rt.call_function('get_included_files', []rt.PhpVal{}).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_file := item_3.val
		if rt.is_true(rt.call_function('str_contains', [var_file.clone(),
			rt.new_string('wp-config.php')]))
		{
			return (rt.call_function('dirname', [var_file.clone()])).str() + '/wp-content'
		}
	}
	return ''
}

fn Class_VHttpd_WordPress_ProfilerEnv.getmupluginsdir() string {
	if rt.is_true(rt.call_function('defined', [rt.new_string('WPMU_PLUGIN_DIR')])) {
		return (rt.get_constant('WPMU_PLUGIN_DIR')).str()
	}
	mut var_contentDir := Class_VHttpd_WordPress_ProfilerEnv.getwpcontentdir()
	return if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_contentDir, rt.new_string(''))))) {
		var_contentDir.str() + '/mu-plugins'
	} else {
		''
	}
}

fn Class_VHttpd_WordPress_ProfilerEnv.getplugindir() string {
	mut var_dir := rt.call_function('dirname', [rt.new_string(@DIR),
		rt.new_int(3)])
	if rt.is_true(rt.call_function('is_file', [
		rt.new_string(var_dir.str() + '/v-profiler.php'),
	]))
	{
		return var_dir.str()
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('WP_PLUGIN_DIR')])) {
		return (rt.get_constant('WP_PLUGIN_DIR')).str() + '/v-profiler'
	}
	mut var_contentDir := Class_VHttpd_WordPress_ProfilerEnv.getwpcontentdir()
	return if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_contentDir, rt.new_string(''))))) {
		var_contentDir.str() + '/plugins/v-profiler'
	} else {
		''
	}
}

fn create_vhttpd_wordpress_profilerenv(_args ...rt.PhpVal) &Class_VHttpd_WordPress_ProfilerEnv {
	mut obj := &Class_VHttpd_WordPress_ProfilerEnv{
		PhpObjectBase: rt.PhpObjectBase{}
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
		else {
			return none
		}
	}
}

fn (this &Class_VHttpd_WordPress_ProfilerEnv) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_WordPress_ProfilerEnv) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
