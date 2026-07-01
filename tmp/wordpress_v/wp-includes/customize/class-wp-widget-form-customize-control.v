import rt

struct Class_WP_Widget_Form_Customize_Control {
	rt.PhpObjectBase
pub mut:
	prop_type      rt.PhpVal = rt.new_string('widget_form')
	widget_id      rt.PhpVal = rt.new_null()
	widget_id_base rt.PhpVal = rt.new_null()
	sidebar_id     rt.PhpVal = rt.new_null()
	is_new         rt.PhpVal = rt.new_bool(false)
	width          rt.PhpVal = rt.new_null()
	height         rt.PhpVal = rt.new_null()
	is_wide        rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WP_Widget_Form_Customize_Control) to_json() {
	mut var_wp_registered_widgets := rt.new_null()
	// unsupported statement: Stmt_Global
	this.Class_WP_Customize_Control.to_json()
	mut var_exported_properties := ['widget_id', 'widget_id_base', 'sidebar_id', 'width', 'height',
		'is_wide']
	for var_key in var_exported_properties {
		rt.get_property(rt.new_object('WP_Widget_Form_Customize_Control', [
			'WP_Customize_Control',
		], &this), 'json').array_set(key, rt.get_property(rt.new_object('WP_Widget_Form_Customize_Control', [
			'WP_Customize_Control',
		], &this), '{"nodeType":"Expr_Variable","line":95,"name":"key"}'))
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/widgets.php', '4')
	mut var_widget := var_wp_registered_widgets.array_get(this.widget_id)
	if !(var_widget.array_get('params').array_isset(rt.new_int(0))) {
		var_widget.array_get_mut('params').array_set(0, rt.new_array())
	}
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'widget_id', val: var_widget.array_get('id') },
		rt.ArrayItem{ key: 'widget_name', val: var_widget.array_get('name') },
	])
	var_args = rt.call_function('wp_list_widget_controls_dynamic_sidebar', [
		rt.create_array([rt.ArrayItem{ key: 0, val: var_args },
			rt.ArrayItem{ key: 1, val: var_widget.array_get('params').array_get(0) }]),
	])
	mut var_widget_control_parts := rt.call_method(rt.get_property(rt.get_property(rt.new_object('WP_Widget_Form_Customize_Control', [
		'WP_Customize_Control',
	], &this), 'manager'), 'widgets'), 'get_widget_control_parts', [
		var_args.dup()])
	rt.get_property(rt.new_object('WP_Widget_Form_Customize_Control', [
		'WP_Customize_Control',
	], &this), 'json').array_set('widget_control', var_widget_control_parts.array_get('control'))
	rt.get_property(rt.new_object('WP_Widget_Form_Customize_Control', [
		'WP_Customize_Control',
	], &this), 'json').array_set('widget_content', var_widget_control_parts.array_get('content'))
}

fn (mut this Class_WP_Widget_Form_Customize_Control) render_content() {
}

fn (mut this Class_WP_Widget_Form_Customize_Control) active_callback() rt.PhpVal {
	return rt.call_method(rt.get_property(rt.get_property(rt.new_object('WP_Widget_Form_Customize_Control', [
		'WP_Customize_Control',
	], &this), 'manager'), 'widgets'), 'is_widget_rendered', [this.widget_id])
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

fn create_wp_widget_form_customize_control() &Class_WP_Widget_Form_Customize_Control {
	mut obj := &Class_WP_Widget_Form_Customize_Control{
		PhpObjectBase:  rt.PhpObjectBase{}
		prop_type:      rt.new_string('widget_form')
		widget_id:      rt.new_null()
		widget_id_base: rt.new_null()
		sidebar_id:     rt.new_null()
		is_new:         rt.new_bool(false)
		width:          rt.new_null()
		height:         rt.new_null()
		is_wide:        rt.new_bool(false)
	}
	return obj
}

fn create_wp_customize_control() &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Widget_Form_Customize_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'to_json' {
			this.to_json()
			return rt.new_null()
		}
		'render_content' {
			this.render_content()
			return rt.new_null()
		}
		'active_callback' {
			return this.active_callback()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Widget_Form_Customize_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'widget_id' { return this.widget_id }
		'widget_id_base' { return this.widget_id_base }
		'sidebar_id' { return this.sidebar_id }
		'is_new' { return this.is_new }
		'width' { return this.width }
		'height' { return this.height }
		'is_wide' { return this.is_wide }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Widget_Form_Customize_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'widget_id' {
			this.widget_id = val
			return true
		}
		'widget_id_base' {
			this.widget_id_base = val
			return true
		}
		'sidebar_id' {
			this.sidebar_id = val
			return true
		}
		'is_new' {
			this.is_new = val
			return true
		}
		'width' {
			this.width = val
			return true
		}
		'height' {
			this.height = val
			return true
		}
		'is_wide' {
			this.is_wide = val
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

pub fn init_wp_includes_customize_class_wp_widget_form_customize_control_php() {
}
