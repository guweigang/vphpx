import rt

struct Class_Automattic_WooCommerce_Blocks_TemplateOptions {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_TemplateOptions) init() {
	rt.call_function('add_action', [rt.new_string('after_switch_theme'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_TemplateOptions',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'check_should_use_blockified_product_grid_templates' },
		]),
		rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_TemplateOptions) check_should_use_blockified_product_grid_templates(var_old_name rt.PhpVal, var_old_theme rt.PhpVal) {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_old_theme, 'is_block_theme', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))
	{
		mut var_option_name :=
			Class_Automattic_WooCommerce_Blocks_Options.wc_block_use_blockified_product_grid_block_as_template()
		mut var_option_value := rt.call_function('wc_string_to_bool', [
			rt.call_function('get_option', [var_option_name.dup()]),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_option_value)))) {
			rt.call_function('update_option', [var_option_name.dup(),
				rt.new_bool(true)])
		}
	}
}

fn create_automattic_woocommerce_blocks_templateoptions() &Class_Automattic_WooCommerce_Blocks_TemplateOptions {
	mut obj := &Class_Automattic_WooCommerce_Blocks_TemplateOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_TemplateOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'check_should_use_blockified_product_grid_templates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.check_should_use_blockified_product_grid_templates(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_TemplateOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_TemplateOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_templateoptions_php() {
	// unsupported statement: Stmt_Declare
}
