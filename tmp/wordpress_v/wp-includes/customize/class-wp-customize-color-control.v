import rt

struct Class_WP_Customize_Color_Control {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('color')
	statuses  rt.PhpVal = rt.new_null()
	mode      rt.PhpVal = rt.new_string('full')
}

fn (mut this Class_WP_Customize_Color_Control) construct(var_manager rt.PhpVal, var_id rt.PhpVal, var_args rt.PhpVal) {
	this.statuses = rt.create_array([
		rt.ArrayItem{ key: '', val: rt.call_function('__', [rt.new_string('Default')]) },
	])
	this.Class_WP_Customize_Control.construct(var_manager.dup(), var_id.dup(), var_args.dup())
}

fn (mut this Class_WP_Customize_Color_Control) enqueue() {
	rt.call_function('wp_enqueue_script', [rt.new_string('wp-color-picker')])
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-color-picker')])
}

fn (mut this Class_WP_Customize_Color_Control) to_json() {
	this.Class_WP_Customize_Control.to_json()
	rt.get_property(rt.new_object('WP_Customize_Color_Control', [
		'WP_Customize_Control',
	], &this), 'json').array_set('statuses', this.statuses)
	rt.get_property(rt.new_object('WP_Customize_Color_Control', [
		'WP_Customize_Control',
	], &this), 'json').array_set('defaultValue', rt.get_property(rt.get_property(rt.new_object('WP_Customize_Color_Control', [
		'WP_Customize_Control',
	], &this), 'setting'), 'default'))
	rt.get_property(rt.new_object('WP_Customize_Color_Control', [
		'WP_Customize_Control',
	], &this), 'json').array_set('mode', this.mode)
}

fn (mut this Class_WP_Customize_Color_Control) render_content() {
}

fn (mut this Class_WP_Customize_Color_Control) content_template() {
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_color_control(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Customize_Color_Control {
	mut obj := &Class_WP_Customize_Color_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('color')
		statuses:      rt.new_null()
		mode:          rt.new_string('full')
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wp_customize_control() &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Color_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'to_json' {
			this.to_json()
			return rt.new_null()
		}
		'render_content' {
			this.render_content()
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

fn (this &Class_WP_Customize_Color_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'statuses' { return this.statuses }
		'mode' { return this.mode }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Color_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'statuses' {
			this.statuses = val
			return true
		}
		'mode' {
			this.mode = val
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

pub fn init_wp_includes_customize_class_wp_customize_color_control_php() {
}
