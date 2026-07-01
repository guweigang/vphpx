import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) get_product_from_context(mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) rt.PhpVal {
	mut var_post := rt.new_null()
	mut var_post_id := if !(var_parsed_block.array_get('context').array_get('postId')).is_null() {
		var_parsed_block.array_get('context').array_get('postId')
	} else {
		rt.new_int(0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		// unsupported statement: Stmt_Global
		if rt.is_true(rt.new_bool(rt.is_true(var_product)
			&& rt.is_true(rt.call_function('is_a', [var_product.dup(), rt.new_string('WC_Product')]))))
		{
			var_post_id = rt.call_method(var_product, 'get_id', []rt.PhpVal{})
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		// unsupported statement: Stmt_Global
		if rt.is_true(rt.new_bool(rt.is_true(var_post)
			&& rt.is_true(rt.identical(rt.call_function('get_post_type', [rt.get_property(var_post, 'ID')]), rt.new_string('product')))))
		{
			var_post_id = rt.get_property(var_post, 'ID')
		}
	}
	mut var_product := if rt.is_true(var_post_id) { rt.call_function('wc_get_product', [
			var_post_id.dup(),
		]) } else { rt.new_null() }
	return if rt.is_true(var_product) { var_product } else { rt.new_null() }
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_abstract_product_block_renderer() &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_core_renderer_blocks_abstract_block_renderer() &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_product_from_context' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_product_from_context(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Core_Renderer_Blocks_Abstract_Block_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_integrations_woocommerce_renderer_blocks_class_abstract_product_block_renderer_php() {
	// unsupported statement: Stmt_Declare
}
