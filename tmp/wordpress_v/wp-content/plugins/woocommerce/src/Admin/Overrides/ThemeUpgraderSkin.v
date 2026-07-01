import rt

struct Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin {
	rt.PhpObjectBase
pub mut:
		api rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin) header()  {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin) footer()  {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin) feedback(var_string rt.PhpVal, var_args rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin) after()  {
}

struct Class_Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader_Skin {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_overrides_themeupgraderskin() &Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin {
	mut obj := &Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin{
		PhpObjectBase: rt.PhpObjectBase{}
		api: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_admin_overrides_theme_upgrader_skin() &Class_Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader_Skin {
	mut obj := &Class_Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'header' {
			this.header()
			return rt.new_null()
		}
		'footer' {
			this.footer()
			return rt.new_null()
		}
		'feedback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.feedback(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'after' {
			this.after()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'api' { return this.api }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_ThemeUpgraderSkin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'api' { this.api = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Overrides_Theme_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_overrides_themeupgraderskin_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
