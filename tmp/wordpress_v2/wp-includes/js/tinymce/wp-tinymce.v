import rt

mut var_basepath := rt.new_string(@DIR)
fn get_file(var_path_arg rt.PhpVal) bool {
	mut var_path := var_path_arg
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('realpath')])) {
		var_path = rt.call_function('realpath', [var_path.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_path))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_file', [var_path.clone()]))))) {
		return false
	}
	return (rt.call_function('file_get_contents', [var_path.clone()])).to_bool()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('error_reporting', [rt.new_int(0)])
	mut var_expires_offset := 31536000
	rt.call_function('header', [
		rt.new_string('Content-Type: application/javascript; charset=UTF-8'),
	])
	rt.call_function('header', [rt.new_string('Vary: Accept-Encoding')])
	rt.call_function('header', [
		rt.new_string('Expires: ' +
			(rt.call_function('gmdate', [rt.new_string('D, d M Y H:i:s'), rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(var_expires_offset))])).str() +
			' GMT'),
	])
	rt.call_function('header', [
		rt.new_string('Cache-Control: public, max-age=${var_expires_offset.str()}'),
	])
	mut var_file := get_file(var_basepath.str() + '/wp-tinymce.js')
	if rt.get_superglobal('_GET').array_isset(rt.new_string('c')) && var_file {
		print(if var_file { '1' } else { '' })
	} else {
		rt.echo_val(rt.new_bool(get_file(rt.new_string(var_basepath.str() + '/tinymce.min.js'))))
		rt.echo_val(rt.new_bool(get_file(rt.new_string(var_basepath.str() +
			'/plugins/compat3x/plugin.min.js'))))
	}
	exit(0)
}
