import rt

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))) { rt.call_function('sanitize_text_field', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')),
		]) } else { rt.new_string('') }
	if rt.get_superglobal('_GET').array_isset(rt.new_string('updated'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('page')) {
		rt.call_function('add_settings_error', [rt.new_string('general'),
			rt.new_string('settings_updated'),
			rt.call_function('__', [
				rt.new_string('Settings saved.'),
			]),
			rt.new_string('success')])
	}
	rt.call_function('settings_errors', []rt.PhpVal{})
}
