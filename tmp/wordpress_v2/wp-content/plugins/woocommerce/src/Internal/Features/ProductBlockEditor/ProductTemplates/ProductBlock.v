import rt

struct Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock) add_block(mut var_block_config Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_array) rt.PhpVal {
	mut var_block := create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_productblock(var_block_config,
		this.get_root_template(), this)
	return this.add_inner_block(rt.new_object('Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock',
		[]string{}, var_block))
}

struct Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_productblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_blocktemplates_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_block' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.add_block(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_BlockTemplates_AbstractBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
