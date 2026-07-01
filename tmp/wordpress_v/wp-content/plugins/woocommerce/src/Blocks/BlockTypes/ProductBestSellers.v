import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductBestSellers {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-best-sellers')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductBestSellers) set_block_query_args(var_query_args rt.PhpVal) {
	mut var_query_args_mutated := var_query_args
	var_query_args_mutated.array_set('orderby', 'popularity')
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productbestsellers() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductBestSellers {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductBestSellers{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-best-sellers')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractproductgrid() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductBestSellers) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'set_block_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_block_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductBestSellers) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductBestSellers) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productbestsellers_php() {
}
