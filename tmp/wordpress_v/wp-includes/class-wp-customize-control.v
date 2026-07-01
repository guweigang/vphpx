import rt

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
pub mut:
	instance_count  rt.PhpVal = rt.new_int(0)
	instance_number rt.PhpVal = rt.new_null()
	manager         rt.PhpVal = rt.new_null()
	id              rt.PhpVal = rt.new_null()
	settings        rt.PhpVal = rt.new_null()
	setting         rt.PhpVal = rt.new_string('default')
	capability      rt.PhpVal = rt.new_null()
	priority        rt.PhpVal = rt.new_int(10)
	section         rt.PhpVal = rt.new_string('')
	label           rt.PhpVal = rt.new_string('')
	description     rt.PhpVal = rt.new_string('')
	choices         rt.PhpVal = rt.new_array()
	input_attrs     rt.PhpVal = rt.new_array()
	allow_addition  rt.PhpVal = rt.new_bool(false)
	json            rt.PhpVal = rt.new_array()
	prop_type       rt.PhpVal = rt.new_string('text')
	active_callback rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WP_Customize_Control) construct(var_manager rt.PhpVal, var_id rt.PhpVal, var_args rt.PhpVal) {
	mut var_id_mutated := var_id
	mut var_keys := rt.func_array_keys(rt.call_function('get_object_vars', [
		rt.new_object('WP_Customize_Control', []string{}, &this),
	]))
	{
		mut iter_1 := var_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if var_args.array_isset(var_key) {
				this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":220,"name":"key"}',
					var_args.array_get(var_key))
			}
		}
	}
	this.manager = var_manager.dup()
	this.id = var_id_mutated.dup()
	if !rt.is_true(this.active_callback) {
		this.active_callback = rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Control', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'active_callback' },
		])
	}
	// unsupported expression: Expr_AssignOp_Plus
	this.instance_number = if !(!(this.settings).is_null()) {
		this.settings = var_id_mutated.dup()
	}
	mut var_settings := rt.new_array()
	if rt.is_true(rt.new_bool(this.settings.is_array())) {
		{
			mut iter_1 := this.settings.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_setting := item_1.val
				mut var_key := item_1.key
				var_settings.array_set(var_key, rt.call_method(this.manager, 'get_setting', [
					var_setting.dup(),
				]))
			}
		}
	} else if rt.is_true(rt.new_bool(this.settings.is_string())) {
		this.setting = rt.call_method(this.manager, 'get_setting', [this.settings])
		var_settings.array_set('default', this.setting)
	}
	this.settings = var_settings.dup()
}

fn (mut this Class_WP_Customize_Control) enqueue() {
}

fn (mut this Class_WP_Customize_Control) active() rt.PhpVal {
	mut var_control := rt.new_object('WP_Customize_Control', []string{}, &this).dup()
	mut var_active := rt.call_function('call_user_func', [this.active_callback,
		rt.new_object('WP_Customize_Control', []string{}, &this)])
	var_active = rt.call_function('apply_filters', [
		rt.new_string('customize_control_active'),
		var_active.dup(),
		var_control.dup(),
	])
	return var_active.dup()
}

fn (mut this Class_WP_Customize_Control) active_callback() bool {
	return true
}

fn (mut this Class_WP_Customize_Control) value(setting_key string) rt.PhpVal {
	if this.settings.array_isset(rt.new_string(setting_key)) {
		return rt.call_method(this.settings.array_get(setting_key), 'value', []rt.PhpVal{})
	}
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Control) to_json() {
	this.json.array_set('settings', rt.new_array())
	{
		mut iter_1 := this.settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_setting := item_1.val
			mut var_key := item_1.key
			this.json.array_get_mut('settings').array_set(var_key, rt.get_property(var_setting,
				'id'))
		}
	}
	this.json.array_set('type', this.prop_type)
	this.json.array_set('priority', this.priority)
	this.json.array_set('active', this.active())
	this.json.array_set('section', this.section)
	this.json.array_set('content', this.get_content())
	this.json.array_set('label', this.label)
	this.json.array_set('description', this.description)
	this.json.array_set('instanceNumber', this.instance_number)
	if rt.is_true(rt.identical(rt.new_string('dropdown-pages'), this.prop_type)) {
		this.json.array_set('allow_addition', this.allow_addition)
	}
}

fn (mut this Class_WP_Customize_Control) json() rt.PhpVal {
	this.to_json()
	return this.json
}

fn (mut this Class_WP_Customize_Control) check_capabilities() bool {
	if rt.is_true(rt.new_bool(!(!rt.is_true(this.capability))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [this.capability])))))))
	{
		return false
	}
	{
		mut iter_1 := this.settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_setting := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_setting))))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_setting, 'check_capabilities', []rt.PhpVal{})))))))
			{
				return false
			}
		}
	}
	mut var_section := rt.call_method(this.manager, 'get_section', [this.section])
	if rt.is_true(rt.new_bool(!var_section.is_null()
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_section, 'check_capabilities', []rt.PhpVal{})))))))
	{
		return false
	}
	return true
}

fn (mut this Class_WP_Customize_Control) get_content() string {
	rt.call_function('ob_start', []rt.PhpVal{})
	this.maybe_render()
	return rt.call_function('ob_get_clean', []rt.PhpVal{}).to_string().trim_space()
}

fn (mut this Class_WP_Customize_Control) maybe_render() {
	if !(this.check_capabilities()) {
		return rt.new_null()
	}
	rt.call_function('do_action', [rt.new_string('customize_render_control'),
		rt.new_object('WP_Customize_Control', []string{}, &this)])
	rt.call_function('do_action', [
		rt.concat(rt.new_string('customize_render_control_'), this.id),
		rt.new_object('WP_Customize_Control', []string{}, &this),
	])
	this.render()
}

fn (mut this Class_WP_Customize_Control) render() {
	mut var_id := rt.new_string('customize-control-' +(rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{
		key: none
		val: '['
	}, rt.ArrayItem{ key: none, val: ']' }]), rt.create_array([rt.ArrayItem{
		key: none
		val: '-'
	}, rt.ArrayItem{ key: none, val: '' }]), this.id])).str())
	mut var_class := rt.new_string('customize-control customize-control-' + (this.prop_type).str())
	rt.call_function('printf', [rt.new_string('<li id="%s" class="%s">'),
		rt.call_function('esc_attr', [var_id.dup()]), rt.call_function('esc_attr', [
			var_class.dup()])])
	this.render_content()
	print('</li>')
}

fn (mut this Class_WP_Customize_Control) get_link(setting_key string) string {
	if rt.is_true(rt.new_bool(this.settings.array_isset(rt.new_string(setting_key))
		&& rt.is_true(rt.new_bool(rt.instance_of(this.settings.array_get(setting_key), 'WP_Customize_Setting')))))
	{
		return 'data-customize-setting-link="' +
			(rt.call_function('esc_attr', [rt.get_property(this.settings.array_get(setting_key), 'id')])).str() +
			'"'
	} else {
		return 'data-customize-setting-key-link="' +
			(rt.call_function('esc_attr', [rt.new_string(setting_key)])).str() + '"'
	}
	return ''
}

fn (mut this Class_WP_Customize_Control) link(setting_key string) {
	print(this.get_link(setting_key))
}

fn (mut this Class_WP_Customize_Control) input_attrs() {
	{
		mut iter_1 := this.input_attrs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_attr := item_1.key
			print(var_attr.str() + '="' + (rt.call_function('esc_attr', [var_value.dup()])).str() +
				'" ')
		}
	}
}

fn (mut this Class_WP_Customize_Control) render_content() {
	mut var_input_id := rt.new_string('_customize-input-' + (this.id).str())
	mut var_description_id := rt.new_string('_customize-description-' + (this.id).str())
	mut var_describedby_attr := rt.new_string(if !(!rt.is_true(this.description)) {
		' aria-describedby="' + (rt.call_function('esc_attr', [var_description_id.dup()])).str() +
			'" '
	} else {
		rt.new_string('')
	})
	mut switch_val_1 := this.prop_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('checkbox'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_input_id.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_describedby_attr)
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [this.value('')]))
		// unsupported statement: Stmt_InlineHTML
		this.link('')
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('checked', [this.value('')])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_input_id.dup()]))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [this.label]))
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(this.description)) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_description_id.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(this.description)
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('radio'))) {
		if !rt.is_true(this.choices) {
			return rt.new_null()
		}
		mut var_name := rt.new_string('_customize-radio-' + (this.id).str())
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(this.label)) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [this.label]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		if !(!rt.is_true(this.description)) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_description_id.dup()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(this.description)
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
		{
			mut iter_1 := this.choices.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_label := item_1.val
				mut var_value := item_1.key
				// unsupported statement: Stmt_InlineHTML
			}
		}
	} else if rt.is_true(rt.equal(switch_val_1)) {
	} else if rt.is_true(rt.equal(switch_val_1)) {
	} else if rt.is_true(rt.equal(switch_val_1)) {
	} else {
	}
}

fn (mut this Class_WP_Customize_Control) print_template() {
}

fn (mut this Class_WP_Customize_Control) content_template() {
}

fn create_wp_customize_control(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase:   rt.PhpObjectBase{}
		instance_count:  rt.new_int(0)
		instance_number: rt.new_null()
		manager:         rt.new_null()
		id:              rt.new_null()
		settings:        rt.new_null()
		setting:         rt.new_string('default')
		capability:      rt.new_null()
		priority:        rt.new_int(10)
		section:         rt.new_string('')
		label:           rt.new_string('')
		description:     rt.new_string('')
		choices:         rt.new_array()
		input_attrs:     rt.new_array()
		allow_addition:  rt.new_bool(false)
		json:            rt.new_array()
		prop_type:       rt.new_string('text')
		active_callback: rt.new_string('')
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn (mut this Class_WP_Customize_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'enqueue' {
			this.enqueue()
			return rt.new_null()
		}
		'active' {
			return this.active()
		}
		'active_callback' {
			return rt.new_bool(this.active_callback())
		}
		'value' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.value(dispatch_arg_0)
		}
		'to_json' {
			this.to_json()
			return rt.new_null()
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
		'get_link' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_link(dispatch_arg_0))
		}
		'link' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.link(dispatch_arg_0)
			return rt.new_null()
		}
		'input_attrs' {
			this.input_attrs()
			return rt.new_null()
		}
		'render_content' {
			this.render_content()
			return rt.new_null()
		}
		'print_template' {
			this.print_template()
			return rt.new_null()
		}
		'content_template' {
			this.content_template()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance_count' { return this.instance_count }
		'instance_number' { return this.instance_number }
		'manager' { return this.manager }
		'id' { return this.id }
		'settings' { return this.settings }
		'setting' { return this.setting }
		'capability' { return this.capability }
		'priority' { return this.priority }
		'section' { return this.section }
		'label' { return this.label }
		'description' { return this.description }
		'choices' { return this.choices }
		'input_attrs' { return this.input_attrs }
		'allow_addition' { return this.allow_addition }
		'json' { return this.json }
		'type' { return this.prop_type }
		'active_callback' { return this.active_callback }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance_count' {
			this.instance_count = val
			return true
		}
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
		'settings' {
			this.settings = val
			return true
		}
		'setting' {
			this.setting = val
			return true
		}
		'capability' {
			this.capability = val
			return true
		}
		'priority' {
			this.priority = val
			return true
		}
		'section' {
			this.section = val
			return true
		}
		'label' {
			this.label = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'choices' {
			this.choices = val
			return true
		}
		'input_attrs' {
			this.input_attrs = val
			return true
		}
		'allow_addition' {
			this.allow_addition = val
			return true
		}
		'json' {
			this.json = val
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
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_includes_class_wp_customize_control_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
