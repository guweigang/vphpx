import rt

struct Class_WP_Customize_Nav_Menu_Location_Control {
	rt.PhpObjectBase
pub mut:
	prop_type   rt.PhpVal = rt.new_string('nav_menu_location')
	location_id rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WP_Customize_Nav_Menu_Location_Control) to_json() {
	this.Class_WP_Customize_Control.to_json()
	rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Location_Control', [
		'WP_Customize_Control',
	], &this), 'json').array_set('locationId', this.location_id)
}

fn (mut this Class_WP_Customize_Nav_Menu_Location_Control) render_content() {
	if !rt.is_true(rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Location_Control', [
		'WP_Customize_Control',
	], &this), 'choices')) {
		return rt.new_null()
	}
	mut var_value_hidden_class := rt.new_string(rt.new_string(''))
	mut var_no_value_hidden_class := rt.new_string(rt.new_string(''))
	if rt.is_true(this.value()) {
		var_value_hidden_class = rt.new_string(rt.new_string(' hidden'))
	} else {
		var_no_value_hidden_class = rt.new_string(rt.new_string(' hidden'))
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Location_Control', [
		'WP_Customize_Control',
	], &this), 'label'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Location_Control', [
				'WP_Customize_Control',
			], &this), 'label'),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Location_Control', [
		'WP_Customize_Control',
	], &this), 'description'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Location_Control', [
			'WP_Customize_Control',
		], &this), 'description'))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	this.link()
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Location_Control', [
			'WP_Customize_Control',
		], &this), 'choices').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_value := item_1.key
			print('<option value="' + (rt.call_function('esc_attr', [var_value.dup()])).str() +
				'"' +
				(rt.call_function('selected', [this.value(), var_value.dup(), rt.new_bool(false)])).str() +
				'>' + (rt.call_function('esc_html', [var_label.dup()])).str() + '</option>')
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_value_hidden_class)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.location_id]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Create a menu for this location')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('+ Create New Menu')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_no_value_hidden_class)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Edit selected menu')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Edit Menu')])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_nav_menu_location_control() &Class_WP_Customize_Nav_Menu_Location_Control {
	mut obj := &Class_WP_Customize_Nav_Menu_Location_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('nav_menu_location')
		location_id:   rt.new_string('')
	}
	return obj
}

fn create_wp_customize_control() &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Nav_Menu_Location_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'to_json' {
			this.to_json()
			return rt.new_null()
		}
		'render_content' {
			this.render_content()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Nav_Menu_Location_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'location_id' { return this.location_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Nav_Menu_Location_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'location_id' {
			this.location_id = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Customize_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_customize_class_wp_customize_nav_menu_location_control_php() {
}
