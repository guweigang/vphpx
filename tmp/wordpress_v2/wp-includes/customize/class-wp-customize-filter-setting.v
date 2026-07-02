import rt

struct Class_WP_Customize_Filter_Setting {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Customize_Filter_Setting) update(var_value rt.PhpVal) bool {
	return true
}

struct Class_WP_Customize_Setting {
	rt.PhpObjectBase
}

fn create_wp_customize_filter_setting(_args ...rt.PhpVal) &Class_WP_Customize_Filter_Setting {
	mut obj := &Class_WP_Customize_Filter_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_setting(_args ...rt.PhpVal) &Class_WP_Customize_Setting {
	mut obj := &Class_WP_Customize_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Filter_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WP_Customize_Filter_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Filter_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn main() {
	defer {
		rt.shutdown()
	}
}
