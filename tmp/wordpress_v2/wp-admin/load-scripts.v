import rt

const global_const_wpinc = 'wp-includes'

struct Class_WP_Scripts {
	rt.PhpObjectBase
}

fn create_wp_scripts(_args ...rt.PhpVal) &Class_WP_Scripts {
	mut obj := &Class_WP_Scripts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Scripts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Scripts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Scripts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('function_exists', [rt.new_string('error_reporting')])) {
		rt.call_function('error_reporting', [rt.new_int(0)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		rt.call_function('define', [rt.new_string('ABSPATH'),
			rt.new_string((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/')])
	}
	mut var_protocol := rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_PROTOCOL'))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_protocol.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'HTTP/1.1' },
			rt.ArrayItem{ key: none, val: 'HTTP/2' }, rt.ArrayItem{ key: none, val: 'HTTP/2.0' },
			rt.ArrayItem{ key: none, val: 'HTTP/3' }]),
		rt.new_bool(true)])))))
	{
		var_protocol = rt.new_string('HTTP/1.0')
	}
	mut var_load := rt.get_superglobal('_GET').array_get(rt.new_string('load'))
	if rt.is_true(rt.new_bool(var_load.clone().is_array())) {
		rt.call_function('ksort', [var_load.clone()])
		var_load = rt.call_function('implode', [rt.new_string(''),
			var_load.clone()])
	}
	var_load = rt.call_function('preg_replace', [rt.new_string('/[^a-z0-9,_-]+/i'),
		rt.new_string(''), var_load.clone()])
	var_load = rt.call_function('array_unique', [
		rt.call_function('explode', [rt.new_string(','), var_load.clone()]),
	])
	if !rt.is_true(var_load) {
		rt.call_function('header', [
			rt.new_string('${var_protocol.to_string()} 400 Bad Request'),
		])
		exit(0)
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/noop.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/script-loader.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/version.php', '3')
	mut var_expires_offset := 31536000
	mut var_out := ''
	mut var_wp_scripts := create_wp_scripts()
	rt.call_function('wp_default_scripts', [var_wp_scripts])
	rt.call_function('wp_default_packages_vendor', [var_wp_scripts])
	rt.call_function('wp_default_packages_scripts', [var_wp_scripts])
	mut var_etag := var_wp_scripts.get_etag(var_load.clone())
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_IF_NONE_MATCH'))
		&& rt.is_true(rt.identical(rt.call_function('stripslashes', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_IF_NONE_MATCH'))]), var_etag)) {
		rt.call_function('header', [
			rt.new_string('${var_protocol.to_string()} 304 Not Modified'),
		])
		exit(0)
	}
	mut iter_1 := var_load.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_handle := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_wp_scripts,
			'registered').array_isset(var_handle.clone()))))))
		{
			continue
		}
		mut var_path :=
			rt.new_string((rt.get_constant('ABSPATH')).str() +(rt.get_property(rt.get_property(var_wp_scripts, 'registered').array_get(var_handle), 'src')).str())
		var_out = var_out + (rt.call_function('get_file', [var_path.clone()])).str() + '\n'
	}
	rt.call_function('header', [rt.new_string('Etag: ${var_etag.to_string()}')])
	rt.call_function('header', [
		rt.new_string('Content-Type: application/javascript; charset=UTF-8'),
	])
	rt.call_function('header', [
		rt.new_string('Expires: ' +
			(rt.call_function('gmdate', [rt.new_string('D, d M Y H:i:s'), rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(var_expires_offset))])).str() +
			' GMT'),
	])
	rt.call_function('header', [
		rt.new_string('Cache-Control: public, max-age=${var_expires_offset.str()}'),
	])
	print(var_out)
	exit(0)
}
