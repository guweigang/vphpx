import rt

struct Class_WP_Customize_Site_Icon_Control {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('site_icon')
}

fn (mut this Class_WP_Customize_Site_Icon_Control) construct(var_manager rt.PhpVal, var_id rt.PhpVal, var_args rt.PhpVal) {
	this.Class_WP_Customize_Cropped_Image_Control.construct(var_manager.clone(), var_id.clone(),
		var_args.clone())
	rt.call_function('add_action', [rt.new_string('customize_controls_print_styles'),
		rt.new_string('wp_site_icon'), rt.new_int(99)])
}

fn (mut this Class_WP_Customize_Site_Icon_Control) content_template() {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [
		rt.call_function('__', [rt.new_string('App icon preview: Current image: %s')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [
		rt.call_function('__', [
			rt.new_string('App icon preview: The current image has no alternative text. The file name is: %s'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [
		rt.call_function('__', [rt.new_string('Browser icon preview: Current image: %s')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [
		rt.call_function('__', [
			rt.new_string('Browser icon preview: The current image has no alternative text. The file name is: %s'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('get_bloginfo', [rt.new_string('name')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(rt.new_object('WP_Customize_Site_Icon_Control', [
		'WP_Customize_Cropped_Image_Control',
	], &this), 'button_labels').array_get(rt.new_string('remove')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(rt.new_object('WP_Customize_Site_Icon_Control', [
		'WP_Customize_Cropped_Image_Control',
	], &this), 'button_labels').array_get(rt.new_string('change')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(rt.new_object('WP_Customize_Site_Icon_Control', [
		'WP_Customize_Cropped_Image_Control',
	], &this), 'button_labels').array_get(rt.new_string('site_icon')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(rt.new_object('WP_Customize_Site_Icon_Control', [
		'WP_Customize_Cropped_Image_Control',
	], &this), 'button_labels').array_get(rt.new_string('default')))
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Customize_Cropped_Image_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_site_icon_control(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Customize_Site_Icon_Control {
	mut obj := &Class_WP_Customize_Site_Icon_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('site_icon')
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wp_customize_cropped_image_control(_args ...rt.PhpVal) &Class_WP_Customize_Cropped_Image_Control {
	mut obj := &Class_WP_Customize_Cropped_Image_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Site_Icon_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
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

fn (this &Class_WP_Customize_Site_Icon_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Site_Icon_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Customize_Cropped_Image_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Cropped_Image_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Cropped_Image_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
