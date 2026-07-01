import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductOnSale {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-on-sale')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductOnSale) set_block_query_args(var_query_args rt.PhpVal) {
	mut var_query_args_mutated := var_query_args
	var_query_args_mutated.array_set('post__in', rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: none, val: 0 }]),
		rt.call_function('wc_get_product_ids_on_sale', []rt.PhpVal{}),
	]))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductOnSale) get_block_type_attributes() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid.get_block_type_attributes(),
		rt.create_array([rt.ArrayItem{ key: 'className', val: this.get_schema_string() },
			rt.ArrayItem{ key: 'orderby', val: this.get_schema_orderby() }])])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productonsale() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductOnSale {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductOnSale{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-on-sale')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractproductgrid() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductOnSale) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'set_block_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_block_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'get_block_type_attributes' {
			return this.get_block_type_attributes()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductOnSale) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductOnSale) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productonsale_php() {
}
