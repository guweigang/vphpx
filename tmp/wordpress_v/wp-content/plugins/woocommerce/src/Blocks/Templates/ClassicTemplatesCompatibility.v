import rt

struct Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility {
	rt.PhpObjectBase
pub mut:
	asset_data_registry rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility) construct(mut var_asset_data_registry Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry) {
	this.asset_data_registry = var_asset_data_registry.dup()
	this.init()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility) init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		rt.call_function('add_action', [rt.new_string('template_redirect'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'set_classic_template_data' },
			])])
		rt.call_function('add_action', [rt.new_string('load-widgets.php'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'set_filterable_product_data' },
			])])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility) set_classic_template_data() {
	this.set_filterable_product_data()
	this.set_php_template_data()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility) set_filterable_product_data() {
	mut var_pagenow := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_shop', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{}))))
		|| rt.is_true(rt.identical(rt.new_string('widgets.php'), var_pagenow))))
	{
		rt.call_method(this.asset_data_registry, 'add', [
			rt.new_string('hasFilterableProducts'),
			rt.new_bool(true),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility) set_php_template_data() {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_shop', []rt.PhpVal{}))
		|| rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{}))))
	{
		rt.call_method(this.asset_data_registry, 'add', [
			rt.new_string('isRenderingPhpTemplate'),
			rt.new_bool(true),
		])
	}
}

fn create_automattic_woocommerce_blocks_templates_classictemplatescompatibility(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility{
		PhpObjectBase:       rt.PhpObjectBase{}
		asset_data_registry: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Assets_AssetDataRegistry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'set_classic_template_data' {
			this.set_classic_template_data()
			return rt.new_null()
		}
		'set_filterable_product_data' {
			this.set_filterable_product_data()
			return rt.new_null()
		}
		'set_php_template_data' {
			this.set_php_template_data()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'asset_data_registry' { return this.asset_data_registry }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ClassicTemplatesCompatibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'asset_data_registry' {
			this.asset_data_registry = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_templates_classictemplatescompatibility_php() {
}
