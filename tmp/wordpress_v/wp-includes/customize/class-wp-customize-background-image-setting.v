import rt

struct Class_WP_Customize_Background_Image_Setting {
	rt.PhpObjectBase
pub mut:
	id rt.PhpVal = rt.new_string('background_image_thumb')
}

fn (mut this Class_WP_Customize_Background_Image_Setting) update(var_value rt.PhpVal) bool {
	rt.call_function('remove_theme_mod', [rt.new_string('background_image_thumb')])
	return true
}

struct Class_WP_Customize_Setting {
	rt.PhpObjectBase
}

fn create_wp_customize_background_image_setting() &Class_WP_Customize_Background_Image_Setting {
	mut obj := &Class_WP_Customize_Background_Image_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
		id:            rt.new_string('background_image_thumb')
	}
	return obj
}

fn create_wp_customize_setting() &Class_WP_Customize_Setting {
	mut obj := &Class_WP_Customize_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Background_Image_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Background_Image_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Background_Image_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Customize_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_customize_class_wp_customize_background_image_setting_php() {
}
