import rt

fn get_file(var_path rt.PhpVal) bool {
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('realpath')])) {
		var_path = rt.call_function('realpath', [var_path.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_path))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [var_path.dup()])))))))
	{
		return false
	}
	return (rt.call_function('file_get_contents', [var_path.dup()])).to_bool()
}

pub fn init_wp_includes_js_tinymce_wp_tinymce_php() {
	rt.call_function('error_reporting', [rt.new_int(0)])
	mut var_basepath := rt.new_string(rt.new_string(@DIR))
	mut var_expires_offset := 31536000
	rt.call_function('header', [
		rt.new_string('Content-Type: application/javascript; charset=UTF-8'),
	])
	rt.call_function('header', [rt.new_string('Vary: Accept-Encoding')])
	rt.call_function('header', [
		'Expires: ' +
			(rt.call_function('gmdate', [rt.new_string('D, d M Y H:i:s'), rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(var_expires_offset))])).str() +
			' GMT',
	])
	rt.call_function('header', [
		rt.new_string('Cache-Control: public, max-age=${var_expires_offset.str()}'),
	])
	mut var_file := get_file(var_basepath.str() + '/wp-tinymce.js')
	if rt.get_superglobal('_GET').array_isset(rt.new_string('c')) && var_file {
		print(if var_file { '1' } else { '' })
	} else {
		rt.echo_val(rt.new_bool(get_file(var_basepath.str() + '/tinymce.min.js')))
		rt.echo_val(rt.new_bool(get_file(var_basepath.str() + '/plugins/compat3x/plugin.min.js')))
	}
	// unsupported expression: Expr_Exit
}
