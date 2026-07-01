import rt

struct Class_WP_Customize_Header_Image_Setting {
	rt.PhpObjectBase
pub mut:
	id rt.PhpVal = rt.new_string('header_image_data')
}

fn (mut this Class_WP_Customize_Header_Image_Setting) update(var_value rt.PhpVal) bool {
	mut var_value_mutated := var_value
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_custom_image_header) {
		rt.include_file(
			(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-custom-image-header.php',
			'4')
		mut var_args := rt.call_function('get_theme_support', [
			rt.new_string('custom-header'),
		])
		mut var_admin_head_callback := if !(var_args.array_get(0).array_get('admin-head-callback')).is_null() {
			var_args.array_get(0).array_get('admin-head-callback')
		} else {
			rt.new_null()
		}
		mut var_admin_preview_callback := if !(var_args.array_get(0).array_get('admin-preview-callback')).is_null() {
			var_args.array_get(0).array_get('admin-preview-callback')
		} else {
			rt.new_null()
		}
		mut var_custom_image_header := create_custom_image_header(var_admin_head_callback.dup(),
			var_admin_preview_callback.dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_value_mutated)))) {
		var_value_mutated = rt.call_method(rt.call_method(rt.get_property(rt.new_object('WP_Customize_Header_Image_Setting', [
			'WP_Customize_Setting',
		], &this), 'manager'), 'get_setting', [rt.new_string('header_image')]), 'post_value',
			[]rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_value_mutated.dup().is_array()))
		&& var_value_mutated.array_isset(rt.new_string('choice'))))
	{
		var_custom_image_header.set_header_image(var_value_mutated.array_get('choice'))
	} else {
		var_custom_image_header.set_header_image(var_value_mutated.dup())
	}
	return true
}

struct Class_WP_Customize_Setting {
	rt.PhpObjectBase
}

struct Class_Custom_Image_Header {
	rt.PhpObjectBase
}

fn create_wp_customize_header_image_setting() &Class_WP_Customize_Header_Image_Setting {
	mut obj := &Class_WP_Customize_Header_Image_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
		id:            rt.new_string('header_image_data')
	}
	return obj
}

fn create_wp_customize_setting() &Class_WP_Customize_Setting {
	mut obj := &Class_WP_Customize_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_custom_image_header() &Class_Custom_Image_Header {
	mut obj := &Class_Custom_Image_Header{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Header_Image_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WP_Customize_Header_Image_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Header_Image_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Custom_Image_Header) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Custom_Image_Header) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Custom_Image_Header) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_customize_class_wp_customize_header_image_setting_php() {
}
