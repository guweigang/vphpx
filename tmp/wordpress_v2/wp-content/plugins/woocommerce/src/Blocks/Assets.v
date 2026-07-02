import rt

struct Class_Automattic_WooCommerce_Blocks_Assets {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blocks_Assets.init() {
	rt.call_function('_deprecated_function', [rt.new_string('Assets::init'),
		rt.new_string('5.0.0')])
}

fn Class_Automattic_WooCommerce_Blocks_Assets.register_assets() {
	rt.call_function('_deprecated_function', [rt.new_string('Assets::register_assets'),
		rt.new_string('5.0.0')])
}

fn Class_Automattic_WooCommerce_Blocks_Assets.enqueue_scripts() {
	rt.call_function('_deprecated_function', [rt.new_string('Assets::enqueue_scripts'),
		rt.new_string('5.0.0')])
}

fn Class_Automattic_WooCommerce_Blocks_Assets.add_theme_body_class(var_classes rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [
		rt.new_string('Assets::add_theme_body_class'),
		rt.new_string('5.0.0'),
	])
	return var_classes.clone()
}

fn Class_Automattic_WooCommerce_Blocks_Assets.add_theme_admin_body_class(classes string) rt.PhpVal {
	rt.call_function('_deprecated_function', [
		rt.new_string('Assets::add_theme_admin_body_class'),
		rt.new_string('5.0.0'),
	])
	return rt.new_string(classes)
}

fn Class_Automattic_WooCommerce_Blocks_Assets.redirect_to_field() {
	rt.call_function('_deprecated_function', [rt.new_string('Assets::redirect_to_field'),
		rt.new_string('5.0.0')])
}

fn Class_Automattic_WooCommerce_Blocks_Assets.register_block_script(var_script_name rt.PhpVal, handle string, var_dependencies rt.PhpVal) {
	rt.call_function('_deprecated_function', [rt.new_string('register_block_script'),
		rt.new_string('4.5.0')])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Package{}
	mut iife_result_0 := iife_temp_0.container()
	mut var_asset_api := rt.call_method(iife_result_0, 'get', [
		Class_Automattic_WooCommerce_Blocks_Assets_Api.class(),
	])
	rt.call_method(var_asset_api, 'register_block_script', [var_script_name.clone(),
		rt.new_string(handle), var_dependencies.clone()])
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_assets(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Assets {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Assets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_Blocks_Assets.init()
			return rt.new_null()
		}
		'register_assets' {
			Class_Automattic_WooCommerce_Blocks_Assets.register_assets()
			return rt.new_null()
		}
		'enqueue_scripts' {
			Class_Automattic_WooCommerce_Blocks_Assets.enqueue_scripts()
			return rt.new_null()
		}
		'add_theme_body_class' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Assets.add_theme_body_class(dispatch_arg_0)
		}
		'add_theme_admin_body_class' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Blocks_Assets.add_theme_admin_body_class(dispatch_arg_0)
		}
		'redirect_to_field' {
			Class_Automattic_WooCommerce_Blocks_Assets.redirect_to_field()
			return rt.new_null()
		}
		'register_block_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			Class_Automattic_WooCommerce_Blocks_Assets.register_block_script(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Assets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Assets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
