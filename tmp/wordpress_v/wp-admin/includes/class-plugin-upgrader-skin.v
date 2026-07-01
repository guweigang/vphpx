import rt

struct Class_Plugin_Upgrader_Skin {
	rt.PhpObjectBase
pub mut:
	plugin                rt.PhpVal = rt.new_string('')
	plugin_active         rt.PhpVal = rt.new_bool(false)
	plugin_network_active rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Plugin_Upgrader_Skin) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_defaults := {
		'url':    rt.new_string('')
		'plugin': rt.new_string('')
		'nonce':  rt.new_string('')
		'title':  rt.call_function('__', [rt.new_string('Update Plugin')])
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(),
		var_defaults.dup()])
	this.plugin = var_args_mutated.array_get('plugin')
	this.plugin_active = rt.call_function('is_plugin_active', [this.plugin])
	this.plugin_network_active = rt.call_function('is_plugin_active_for_network', [
		this.plugin,
	])
	this.Class_WP_Upgrader_Skin.construct(var_args_mutated.dup())
}

fn (mut this Class_Plugin_Upgrader_Skin) after() {
	this.plugin = rt.call_method(rt.get_property(rt.new_object('Plugin_Upgrader_Skin', [
		'WP_Upgrader_Skin',
	], &this), 'upgrader'), 'plugin_info', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(this.plugin))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [rt.get_property(rt.new_object('Plugin_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'result')])))))))
		&& rt.is_true(this.plugin_active)))
	{
		rt.call_function('printf', [
			rt.new_string('<iframe title="%s" style="border:0;overflow:hidden" width="100%%" height="170" src="%s"></iframe>'),
			rt.call_function('esc_attr__', [rt.new_string('Update progress')]),
			rt.call_function('wp_nonce_url', [
				'update.php?action=activate-plugin&networkwide=' +
					(this.plugin_network_active).str() + '&plugin=' +
					(rt.call_function('urlencode', [this.plugin])).str(),
				'activate-plugin_' + (this.plugin).str(),
			]),
		])
	}
	this.decrement_update_count(rt.new_string('plugin'))
	mut var_update_actions := rt.create_array([
		rt.ArrayItem{ key: 'activate_plugin', val: rt.call_function('sprintf', [
			rt.new_string('<a href="%s" target="_parent">%s</a>'),
			rt.call_function('wp_nonce_url', [
				'plugins.php?action=activate&amp;plugin=' +
					(rt.call_function('urlencode', [this.plugin])).str(),
				'activate-plugin_' + (this.plugin).str(),
			]),
			rt.call_function('__', [
				rt.new_string('Activate Plugin'),
			]),
		]) },
		rt.ArrayItem{ key: 'plugins_page', val: rt.call_function('sprintf', [
			rt.new_string('<a href="%s" target="_parent">%s</a>'),
			rt.call_function('self_admin_url', [
				rt.new_string('plugins.php'),
			]),
			rt.call_function('__', [
				rt.new_string('Go to Plugins page'),
			]),
		]) },
	])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(this.plugin_active)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('Plugin_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'result')))))))
		|| rt.is_true(rt.call_function('is_wp_error', [rt.get_property(rt.new_object('Plugin_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'result')]))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugin'), this.plugin])))))))
	{
		var_update_actions.array_unset(rt.new_string('activate_plugin'))
	}
	var_update_actions = rt.call_function('apply_filters', [
		rt.new_string('update_plugin_complete_actions'),
		var_update_actions.dup(),
		this.plugin,
	])
	if !(!rt.is_true(var_update_actions)) {
		this.feedback(rt.call_function('implode', [rt.new_string(' | '),
			rt.cast_array(var_update_actions)]))
	}
}

struct Class_WP_Upgrader_Skin {
	rt.PhpObjectBase
}

fn create_plugin_upgrader_skin(arg_0 rt.PhpVal) &Class_Plugin_Upgrader_Skin {
	mut obj := &Class_Plugin_Upgrader_Skin{
		PhpObjectBase:         rt.PhpObjectBase{}
		plugin:                rt.new_string('')
		plugin_active:         rt.new_bool(false)
		plugin_network_active: rt.new_bool(false)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_upgrader_skin() &Class_WP_Upgrader_Skin {
	mut obj := &Class_WP_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Plugin_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'after' {
			this.after()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Plugin_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'plugin' { return this.plugin }
		'plugin_active' { return this.plugin_active }
		'plugin_network_active' { return this.plugin_network_active }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Plugin_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'plugin' {
			this.plugin = val
			return true
		}
		'plugin_active' {
			this.plugin_active = val
			return true
		}
		'plugin_network_active' {
			this.plugin_network_active = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_admin_includes_class_plugin_upgrader_skin_php() {
}
