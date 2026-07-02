import rt

struct Class_WP_Customize_Section {
	rt.PhpObjectBase
pub mut:
	instance_number    rt.PhpVal = rt.new_null()
	manager            rt.PhpVal = rt.new_null()
	id                 rt.PhpVal = rt.new_null()
	priority           rt.PhpVal = rt.new_int(160)
	panel              rt.PhpVal = rt.new_string('')
	capability         rt.PhpVal = rt.new_string('edit_theme_options')
	theme_supports     rt.PhpVal = rt.new_string('')
	title              rt.PhpVal = rt.new_string('')
	description        rt.PhpVal = rt.new_string('')
	controls           rt.PhpVal = rt.new_null()
	prop_type          rt.PhpVal = rt.new_string('default')
	active_callback    rt.PhpVal = rt.new_string('')
	description_hidden rt.PhpVal = rt.new_bool(false)
}

fn init_static_wp_customize_section() {
	rt.init_static_prop('WP_Customize_Section', 'instance_count', rt.new_int(0))
}

fn (mut this Class_WP_Customize_Section) construct(var_manager rt.PhpVal, var_id rt.PhpVal, var_args rt.PhpVal) {
	mut var_keys := rt.func_array_keys(rt.call_function('get_object_vars', [
		rt.new_object('WP_Customize_Section', []string{}, &this),
	]))
	mut iter_1 := var_keys.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		if var_args.array_isset(var_key) {
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":177,"name":"key"}',
				var_args.array_get(var_key))
		}
	}
	this.manager = var_manager.clone()
	this.id = var_id.clone()
	if !rt.is_true(this.active_callback) {
		this.active_callback = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Section', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'active_callback' },
		])
	}
	rt.get_static_prop('WP_Customize_Section', 'instance_count') = rt.add(rt.get_static_prop('WP_Customize_Section',
		'instance_count'), rt.new_int(1))
	this.instance_number = rt.get_static_prop('WP_Customize_Section', 'instance_count')
	this.controls = rt.new_array()
}

fn (mut this Class_WP_Customize_Section) active() rt.PhpVal {
	mut var_section := rt.new_object('WP_Customize_Section', []string{}, &this)
	mut var_active := rt.call_function('call_user_func', [this.active_callback,
		rt.new_object('WP_Customize_Section', []string{}, &this)])
	var_active = rt.call_function('apply_filters', [
		rt.new_string('customize_section_active'),
		var_active.clone(),
		var_section.clone(),
	])
	return var_active.clone()
}

fn (mut this Class_WP_Customize_Section) active_callback() bool {
	return true
}

fn (mut this Class_WP_Customize_Section) json() rt.PhpVal {
	mut var_array := rt.call_function('wp_array_slice_assoc', [
		rt.cast_array(rt.new_object('WP_Customize_Section', []string{}, &this)),
		rt.create_array([rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'priority' },
			rt.ArrayItem{ key: none, val: 'panel' }, rt.ArrayItem{ key: none, val: 'type' },
			rt.ArrayItem{ key: none, val: 'description_hidden' }]),
	])
	var_array.array_set('title', rt.call_function('html_entity_decode', [this.title,
		rt.get_constant('ENT_QUOTES'), rt.call_function('get_bloginfo', [
			rt.new_string('charset'),
		])]))
	var_array.array_set('content', this.get_content())
	var_array.array_set('active', this.active())
	var_array.array_set('instanceNumber', this.instance_number)
	if rt.is_true(this.panel) {
		var_array.array_set('customizeAction', rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Customizing &#9656; %s')]),
			rt.call_function('esc_html', [
				rt.get_property(rt.call_method(this.manager, 'get_panel', [this.panel]), 'title'),
			]),
		]))
	} else {
		var_array.array_set('customizeAction', rt.call_function('__', [
			rt.new_string('Customizing'),
		]))
	}
	return var_array.clone()
}

fn (mut this Class_WP_Customize_Section) check_capabilities() bool {
	if rt.is_true(this.capability)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [this.capability]))))) {
		return false
	}
	if rt.is_true(this.theme_supports)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.cast_array(this.theme_supports)]))))) {
		return false
	}
	return true
}

fn (mut this Class_WP_Customize_Section) get_content() string {
	rt.call_function('ob_start', []rt.PhpVal{})
	this.maybe_render()
	return rt.call_function('ob_get_clean', []rt.PhpVal{}).to_string().trim_space()
}

fn (mut this Class_WP_Customize_Section) maybe_render() {
	if !(this.check_capabilities()) {
		return
	}
	rt.call_function('do_action', [rt.new_string('customize_render_section'),
		rt.new_object('WP_Customize_Section', []string{}, &this)])
	rt.call_function('do_action', [
		rt.concat(rt.new_string('customize_render_section_'), this.id),
	])
	this.render()
}

fn (mut this Class_WP_Customize_Section) render() {
}

fn (mut this Class_WP_Customize_Section) print_template() {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.prop_type)
	// unsupported statement: Stmt_InlineHTML
	this.render_template()
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Section) render_template() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Back')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Help')])
	// unsupported statement: Stmt_InlineHTML
}

fn create_wp_customize_section(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Customize_Section {
	mut obj := &Class_WP_Customize_Section{
		PhpObjectBase:      rt.PhpObjectBase{}
		instance_number:    rt.new_null()
		manager:            rt.new_null()
		id:                 rt.new_null()
		priority:           rt.new_int(160)
		panel:              rt.new_string('')
		capability:         rt.new_string('edit_theme_options')
		theme_supports:     rt.new_string('')
		title:              rt.new_string('')
		description:        rt.new_string('')
		controls:           rt.new_null()
		prop_type:          rt.new_string('default')
		active_callback:    rt.new_string('')
		description_hidden: rt.new_bool(false)
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn (mut this Class_WP_Customize_Section) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'active' {
			return this.active()
		}
		'active_callback' {
			return rt.new_bool(this.active_callback())
		}
		'json' {
			return this.json()
		}
		'check_capabilities' {
			return rt.new_bool(this.check_capabilities())
		}
		'get_content' {
			return rt.new_string(this.get_content())
		}
		'maybe_render' {
			this.maybe_render()
			return rt.new_null()
		}
		'render' {
			this.render()
			return rt.new_null()
		}
		'print_template' {
			this.print_template()
			return rt.new_null()
		}
		'render_template' {
			this.render_template()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Section) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance_number' { return this.instance_number }
		'manager' { return this.manager }
		'id' { return this.id }
		'priority' { return this.priority }
		'panel' { return this.panel }
		'capability' { return this.capability }
		'theme_supports' { return this.theme_supports }
		'title' { return this.title }
		'description' { return this.description }
		'controls' { return this.controls }
		'type' { return this.prop_type }
		'active_callback' { return this.active_callback }
		'description_hidden' { return this.description_hidden }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Section) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance_number' {
			this.instance_number = val
			return true
		}
		'manager' {
			this.manager = val
			return true
		}
		'id' {
			this.id = val
			return true
		}
		'priority' {
			this.priority = val
			return true
		}
		'panel' {
			this.panel = val
			return true
		}
		'capability' {
			this.capability = val
			return true
		}
		'theme_supports' {
			this.theme_supports = val
			return true
		}
		'title' {
			this.title = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'controls' {
			this.controls = val
			return true
		}
		'type' {
			this.prop_type = val
			return true
		}
		'active_callback' {
			this.active_callback = val
			return true
		}
		'description_hidden' {
			this.description_hidden = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-themes-section.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-sidebar-section.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-nav-menu-section.php',
		'4')
}
