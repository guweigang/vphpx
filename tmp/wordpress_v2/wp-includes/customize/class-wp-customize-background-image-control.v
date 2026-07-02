import rt

struct Class_WP_Customize_Background_Image_Control {
	rt.PhpObjectBase
pub mut:
	prop_type rt.PhpVal = rt.new_string('background')
}

fn (mut this Class_WP_Customize_Background_Image_Control) construct(var_manager rt.PhpVal) {
	this.Class_WP_Customize_Image_Control.construct(var_manager.clone(),
		rt.new_string('background_image'), rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Background Image'),
		]) },
		rt.ArrayItem{ key: 'section', val: 'background_image' },
	]))
}

fn (mut this Class_WP_Customize_Background_Image_Control) enqueue() {
	this.Class_WP_Customize_Image_Control.enqueue()
	mut var_custom_background := rt.call_function('get_theme_support', [
		rt.new_string('custom-background'),
	])
	rt.call_function('wp_localize_script', [rt.new_string('customize-controls'),
		rt.new_string('_wpCustomizeBackground'),
		rt.create_array([
			rt.ArrayItem{
				key: 'defaults'
				val: if !(!rt.is_true(var_custom_background.array_get(rt.new_int(0)))) {
					var_custom_background.array_get(rt.new_int(0))
				} else {
					rt.new_array()
				}
			},
			rt.ArrayItem{ key: 'nonces', val: rt.create_array([
				rt.ArrayItem{ key: 'add', val: rt.call_function('wp_create_nonce', [
					rt.new_string('background-add'),
				]) },
			]) },
		])])
}

struct Class_WP_Customize_Image_Control {
	rt.PhpObjectBase
}

fn create_wp_customize_background_image_control(arg_0 rt.PhpVal) &Class_WP_Customize_Background_Image_Control {
	mut obj := &Class_WP_Customize_Background_Image_Control{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type:     rt.new_string('background')
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_customize_image_control(_args ...rt.PhpVal) &Class_WP_Customize_Image_Control {
	mut obj := &Class_WP_Customize_Image_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Background_Image_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'enqueue' {
			this.enqueue()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Background_Image_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Background_Image_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Customize_Image_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Image_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Image_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
