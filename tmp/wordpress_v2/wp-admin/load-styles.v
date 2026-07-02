import rt

const global_const_wpinc = 'wp-includes'
const global_const_wp_content_dir = (rt.get_constant('ABSPATH')).str() + 'wp-content'

struct Class_WP_Styles {
	rt.PhpObjectBase
}

fn create_wp_styles(_args ...rt.PhpVal) &Class_WP_Styles {
	mut obj := &Class_WP_Styles{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Styles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Styles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Styles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/noop.php', '3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/theme.php', '3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/class-wp-theme-json-resolver.php',
		'3')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/global-styles-and-settings.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/script-loader.php',
		'3')
	rt.include_file((rt.get_constant('ABSPATH')).str() + global_const_wpinc + '/version.php', '3')
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
	mut var_rtl := rt.get_superglobal('_GET').array_isset(rt.new_string('dir'))
		&& rt.is_true(rt.identical(rt.new_string('rtl'), rt.get_superglobal('_GET').array_get(rt.new_string('dir'))))
	mut var_expires_offset := 31536000
	mut var_out := ''
	mut var_wp_styles := create_wp_styles()
	rt.call_function('wp_default_styles', [var_wp_styles])
	mut var_etag := var_wp_styles.get_etag(var_load.clone())
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
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_property(var_wp_styles,
			'registered').array_isset(var_handle.clone()))))))
		{
			continue
		}
		mut var_style := rt.get_property(var_wp_styles, 'registered').array_get(var_handle)
		if !rt.is_true(rt.get_property(var_style, 'src')) {
			continue
		}
		mut var_path := rt.new_string(
			(rt.get_constant('ABSPATH')).str() + (rt.get_property(var_style, 'src')).str())
		if var_rtl
			&& !(!rt.is_true(rt.get_property(var_style, 'extra').array_get(rt.new_string('rtl')))) {
			var_path = rt.call_function('str_replace', [rt.new_string('.min.css'),
				rt.new_string('-rtl.min.css'), var_path.clone()])
		}
		mut var_content := rt.new_string((rt.call_function('get_file', [var_path.clone()])).str() +
			'\n')
		if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strpos', [
			rt.get_property(var_style, 'src'),
			rt.new_string('/' + global_const_wpinc + '/css/'),
		])))
		{
			var_content = rt.call_function('str_replace', [rt.new_string('../images/'),
				rt.new_string('../' + global_const_wpinc + '/images/'),
				var_content.clone()])
			var_content = rt.call_function('str_replace', [
				rt.new_string('../js/tinymce/'),
				rt.new_string('../' + global_const_wpinc + '/js/tinymce/'),
				var_content.clone(),
			])
			var_content = rt.call_function('str_replace', [rt.new_string('../fonts/'),
				rt.new_string('../' + global_const_wpinc + '/fonts/'),
				var_content.clone()])
			var_out = var_out + var_content.str()
		} else {
			var_out = var_out +(rt.call_function('str_replace', [rt.new_string('../images/'), rt.new_string('images/'), var_content.clone()])).str()
		}
	}
	rt.call_function('header', [rt.new_string('Etag: ${var_etag.to_string()}')])
	rt.call_function('header', [rt.new_string('Content-Type: text/css; charset=UTF-8')])
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
