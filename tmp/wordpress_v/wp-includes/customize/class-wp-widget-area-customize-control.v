import rt

struct Class_WP_Widget_Area_Customize_Control {
	rt.PhpObjectBase
pub mut:
	prop_type  rt.PhpVal = rt.new_string('sidebar_widgets')
	sidebar_id rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Widget_Area_Customize_Control) to_json() {
	this.Class_WP_Customize_Control.to_json()
	mut var_exported_properties := ['sidebar_id']
	for var_key in var_exported_properties {
		rt.get_property(rt.new_object('WP_Widget_Area_Customize_Control', [
			'WP_Customize_Control',
		], &this), 'json').array_set(key, rt.get_property(rt.new_object('WP_Widget_Area_Customize_Control', [
			'WP_Customize_Control',
		], &this), '{"nodeType":"Expr_Variable","line":44,"name":"key"}'))
	}
}

fn (mut this Class_WP_Widget_Area_Customize_Control) render_content() {
	mut var_id := rt.new_string('reorder-widgets-desc-' +(rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{
		key: none
		val: '['
	}, rt.ArrayItem{ key: none, val: ']' }]), rt.create_array([rt.ArrayItem{
		key: none
		val: '-'
	}, rt.ArrayItem{ key: none, val: '' }]), rt.get_property(rt.new_object('WP_Widget_Area_Customize_Control', ['WP_Customize_Control'], &this), 'id')])).str())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Add a Widget')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Reorder widgets')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Reorder')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Done')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_id.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('When in reorder mode, additional controls to reorder widgets will be available in the widgets list above.'),
	])
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

fn create_wp_widget_area_customize_control() &Class_WP_Widget_Area_Customize_Control {
	mut obj := &Class_WP_Widget_Area_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('sidebar_widgets')
		sidebar_id:    rt.new_null()
	}
	return obj
}

fn create_wp_customize_control() &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Widget_Area_Customize_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WP_Widget_Area_Customize_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'sidebar_id' { return this.sidebar_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Widget_Area_Customize_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'sidebar_id' {
			this.sidebar_id = val
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

pub fn init_wp_includes_customize_class_wp_widget_area_customize_control_php() {
}
