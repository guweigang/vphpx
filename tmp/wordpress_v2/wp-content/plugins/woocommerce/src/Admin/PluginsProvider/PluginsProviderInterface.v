import rt

interface PluginsProviderInterface {
	get_active_plugin_slugs() rt.PhpVal
	get_plugin_data(rt.PhpVal) rt.PhpVal
	get_plugin_path_from_slug(rt.PhpVal) rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_plugin := rt.new_null()
	mut var_slug := rt.new_null()
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
