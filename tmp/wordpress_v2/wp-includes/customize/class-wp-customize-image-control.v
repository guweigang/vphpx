import rt

struct Class_WP_Customize_Image_Control {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('image')
	mime_type rt.PhpVal = rt.new_string('image')
}

fn (mut this Class_WP_Customize_Image_Control) prepare_control() {
}

fn (mut this Class_WP_Customize_Image_Control) add_tab(var_id rt.PhpVal, var_label rt.PhpVal, var_callback rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('4.1.0')])
}

fn (mut this Class_WP_Customize_Image_Control) remove_tab(var_id rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('4.1.0')])
}

fn (mut this Class_WP_Customize_Image_Control) print_tab_image(var_url rt.PhpVal, var_thumbnail_url rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('4.1.0')])
}

struct Class_WP_Customize_Upload_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_image_control(_args ...rt.PhpVal) &Class_WP_Customize_Image_Control {
	mut obj := &Class_WP_Customize_Image_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('image')
		mime_type:     rt.new_string('image')
	}
	return obj
}

fn create_wp_customize_upload_control(_args ...rt.PhpVal) &Class_WP_Customize_Upload_Control {
	mut obj := &Class_WP_Customize_Upload_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Image_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_control' {
			this.prepare_control()
			return rt.new_null()
		}
		'add_tab' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.add_tab(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'remove_tab' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_tab(dispatch_arg_0)
			return rt.new_null()
		}
		'print_tab_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.print_tab_image(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Image_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'mime_type' { return this.mime_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Image_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'mime_type' {
			this.mime_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Customize_Upload_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Upload_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Upload_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
