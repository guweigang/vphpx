import rt

const global_const_akismet_version = '5.7'
const global_const_akismet__minimum_wp_version = '5.8'
const global_const_akismet__plugin_dir = rt.call_function('plugin_dir_path', [
	rt.new_string(@FILE),
])
const global_const_akismet_delete_limit = 10000

struct Class_Akismet {
	rt.PhpObjectBase
}

struct Class_Akismet_Abilities {
	rt.PhpObjectBase
}

fn create_akismet() &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet_abilities() &Class_Akismet_Abilities {
	mut obj := &Class_Akismet_Abilities{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Akismet_Abilities) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet_Abilities) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Abilities) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_akismet_akismet_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('add_action'),
	])))))
	{
		print("Hi there!  I'm just a plugin, not much I can do when called directly.")
		// unsupported expression: Expr_Exit
	}
	rt.call_function('register_activation_hook', [rt.new_string(@FILE),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' },
			rt.ArrayItem{ key: none, val: 'plugin_activation' }])])
	rt.call_function('register_deactivation_hook', [rt.new_string(@FILE),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' },
			rt.ArrayItem{ key: none, val: 'plugin_deactivation' }])])
	rt.include_file(global_const_akismet__plugin_dir.str() + 'class.akismet.php', '4')
	rt.include_file(global_const_akismet__plugin_dir.str() + 'class.akismet-widget.php', '4')
	rt.include_file(global_const_akismet__plugin_dir.str() + 'class.akismet-rest-api.php', '4')
	rt.include_file(global_const_akismet__plugin_dir.str() + 'class-akismet-compatible-plugins.php',
		'4')
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet' },
			rt.ArrayItem{ key: none, val: 'init' }])])
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_REST_API' },
			rt.ArrayItem{ key: none, val: 'init' }])])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Compatible_Plugins' },
			rt.ArrayItem{ key: none, val: 'init' }])])
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_get_connectors'),
	]))
	{
		rt.include_file(global_const_akismet__plugin_dir.str() + 'class-akismet-connector.php', '4')
		rt.call_function('add_action', [rt.new_string('init'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Connector' },
				rt.ArrayItem{ key: none, val: 'init' }])])
	}
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_register_ability'),
	]))
	{
		rt.include_file(global_const_akismet__plugin_dir.str() + 'class-akismet-abilities.php', '4')
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			if rt.is_true(fn () rt.PhpVal {
				mut temp := Class_Akismet{}
				return temp.get_api_key()
			}())
			{
				fn () rt.PhpVal {
					mut temp := Class_Akismet_Abilities{}
					return temp.init()
				}()
			}
			return rt.new_null()
		}
		rt.call_function('add_action', [rt.new_string('init'),
			rt.new_closure(closure_1_fn)])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		|| rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')]))
		&& rt.is_true(rt.get_constant('WP_CLI'))))))
	{
		rt.include_file(global_const_akismet__plugin_dir.str() + 'class.akismet-admin.php', '4')
		rt.call_function('add_action', [rt.new_string('init'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
				rt.ArrayItem{ key: none, val: 'init' }])])
	}
	rt.include_file(global_const_akismet__plugin_dir.str() + 'wrapper.php', '4')
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('WP_CLI')]))
		&& rt.is_true(rt.get_constant('WP_CLI'))))
	{
		rt.include_file(global_const_akismet__plugin_dir.str() + 'class.akismet-cli.php', '4')
	}
}
