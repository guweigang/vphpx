import rt

struct Class_WC_SmoothGenerator_Plugin {
	rt.PhpObjectBase
}

fn (mut this Class_WC_SmoothGenerator_Plugin) construct(var_file rt.PhpVal) {
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		fn () rt.PhpVal {
			mut temp := Class_WC_SmoothGenerator_Admin_Settings{}
			return temp.init()
		}()
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_CLI')])) {
		mut var_cli := create_wc_smoothgenerator_cli()
	}
}

struct Class_WC_SmoothGenerator_Admin_Settings {
	rt.PhpObjectBase
}

struct Class_WC_SmoothGenerator_CLI {
	rt.PhpObjectBase
}

fn create_wc_smoothgenerator_plugin(arg_0 rt.PhpVal) &Class_WC_SmoothGenerator_Plugin {
	mut obj := &Class_WC_SmoothGenerator_Plugin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(arg_0)
	return obj
}

fn create_wc_smoothgenerator_admin_settings() &Class_WC_SmoothGenerator_Admin_Settings {
	mut obj := &Class_WC_SmoothGenerator_Admin_Settings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_smoothgenerator_cli() &Class_WC_SmoothGenerator_CLI {
	mut obj := &Class_WC_SmoothGenerator_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_SmoothGenerator_Plugin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_SmoothGenerator_Plugin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Plugin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_Admin_Settings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_Admin_Settings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_Admin_Settings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_SmoothGenerator_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_SmoothGenerator_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_SmoothGenerator_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_wc_smooth_generator_includes_plugin_php() {
}
