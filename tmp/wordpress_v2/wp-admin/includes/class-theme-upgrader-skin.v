import rt

struct Class_Theme_Upgrader_Skin {
	rt.PhpObjectBase
pub mut:
	theme rt.PhpVal = rt.new_string('')
}

fn (mut this Class_Theme_Upgrader_Skin) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_defaults := {
		'url':   rt.new_string('')
		'theme': rt.new_string('')
		'nonce': rt.new_string('')
		'title': rt.call_function('__', [rt.new_string('Update Theme')])
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array_from_native_map(var_defaults)])
	this.theme = var_args_mutated.array_get(rt.new_string('theme'))
	this.Class_WP_Upgrader_Skin.construct(var_args_mutated.clone())
}

fn (mut this Class_Theme_Upgrader_Skin) after() {
	this.decrement_update_count(rt.new_string('theme'))
	mut var_update_actions := rt.new_array()
	mut var_theme_info := rt.call_method(rt.get_property(rt.new_object('Theme_Upgrader_Skin', [
		'WP_Upgrader_Skin',
	], &this), 'upgrader'), 'theme_info', []rt.PhpVal{})
	if rt.is_true(var_theme_info) {
		mut var_name := rt.call_method(var_theme_info, 'display', [
			rt.new_string('Name')])
		mut var_stylesheet := rt.get_property(rt.get_property(rt.new_object('Theme_Upgrader_Skin', [
			'WP_Upgrader_Skin',
		], &this), 'upgrader'), 'result').array_get(rt.new_string('destination_name'))
		mut var_template := rt.call_method(var_theme_info, 'get_template', []rt.PhpVal{})
		mut var_activate_link := rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'action', val: 'activate' },
				rt.ArrayItem{ key: 'template', val: rt.call_function('urlencode', [
					var_template.clone(),
				]) }, rt.ArrayItem{ key: 'stylesheet', val: rt.call_function('urlencode', [
					var_stylesheet.clone(),
				]) }]),
			rt.call_function('admin_url', [rt.new_string('themes.php')]),
		])
		var_activate_link = rt.call_function('wp_nonce_url', [
			var_activate_link.clone(), rt.new_string('switch-theme_' + var_stylesheet.str())])
		mut var_customize_url := rt.call_function('add_query_arg', [
			rt.create_array([
				rt.ArrayItem{ key: 'theme', val: rt.call_function('urlencode', [
					var_stylesheet.clone(),
				]) },
				rt.ArrayItem{ key: 'return', val: rt.call_function('urlencode', [
					rt.call_function('admin_url', [rt.new_string('themes.php')]),
				]) },
			]),
			rt.call_function('admin_url', [
				rt.new_string('customize.php'),
			]),
		])
		if rt.is_true(rt.identical(rt.call_function('get_stylesheet', []rt.PhpVal{}),
			var_stylesheet))
		{
			if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))
				&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
				var_update_actions.array_set('preview', rt.call_function('sprintf', [
					rt.new_string('<a href="%s" class="hide-if-no-customize load-customize">' +
						'<span aria-hidden="true">%s</span><span class="screen-reader-text">%s</span></a>'),
					rt.call_function('esc_url', [var_customize_url.clone()]),
					rt.call_function('__', [rt.new_string('Customize')]),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Customize &#8220;%s&#8221;'),
						]),
						var_name.clone(),
					]),
				]))
			}
		} else if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('switch_themes'),
		]))
		{
			if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))
				&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
				var_update_actions.array_set('preview', rt.call_function('sprintf', [
					rt.new_string('<a href="%s" class="hide-if-no-customize load-customize">' +
						'<span aria-hidden="true">%s</span><span class="screen-reader-text">%s</span></a>'),
					rt.call_function('esc_url', [var_customize_url.clone()]),
					rt.call_function('__', [rt.new_string('Live Preview')]),
					rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Live Preview &#8220;%s&#8221;'),
						]),
						var_name.clone(),
					]),
				]))
			}
			var_update_actions.array_set('activate', rt.call_function('sprintf', [
				rt.new_string('<a href="%s" class="activatelink">' +
					'<span aria-hidden="true">%s</span><span class="screen-reader-text">%s</span></a>'),
				rt.call_function('esc_url', [var_activate_link.clone()]),
				rt.call_function('_x', [rt.new_string('Activate'),
					rt.new_string('theme')]),
				rt.call_function('sprintf', [
					rt.call_function('_x', [rt.new_string('Activate &#8220;%s&#8221;'),
						rt.new_string('theme')]),
					var_name.clone(),
				]),
			]))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('Theme_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'result')))))
			|| rt.is_true(rt.call_function('is_wp_error', [rt.get_property(rt.new_object('Theme_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'result')]))
			|| rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
			var_update_actions.array_unset(rt.new_string('preview'))
			var_update_actions.array_unset(rt.new_string('activate'))
		}
	}
	var_update_actions.array_set('themes_page', rt.call_function('sprintf', [
		rt.new_string('<a href="%s" target="_parent">%s</a>'),
		rt.call_function('self_admin_url', [rt.new_string('themes.php')]),
		rt.call_function('__', [rt.new_string('Go to Themes page')]),
	]))
	var_update_actions = rt.call_function('apply_filters', [
		rt.new_string('update_theme_complete_actions'),
		var_update_actions.clone(),
		this.theme,
	])
	if !(!rt.is_true(var_update_actions)) {
		this.feedback(rt.call_function('implode', [rt.new_string(' | '),
			rt.cast_array(var_update_actions)]))
	}
}

struct Class_WP_Upgrader_Skin {
	rt.PhpObjectBase
}

fn create_theme_upgrader_skin(arg_0 rt.PhpVal) &Class_Theme_Upgrader_Skin {
	mut obj := &Class_Theme_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
		theme:         rt.new_string('')
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_upgrader_skin(_args ...rt.PhpVal) &Class_WP_Upgrader_Skin {
	mut obj := &Class_WP_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Theme_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Theme_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'theme' { return this.theme }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Theme_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'theme' {
			this.theme = val
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

fn main() {
	defer {
		rt.shutdown()
	}
}
