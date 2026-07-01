import rt

pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter.stock_status_query_var() string {
	return 'filter_stock_status'
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('stock-filter')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter) enqueue_data(mut var_stock_statuses Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_stock_statuses))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_StockFilter', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('stockStatusOptions'),
		rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{})])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_StockFilter', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('hideOutOfStockItems'),
		rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
			rt.new_string('woocommerce_hide_out_of_stock_items'),
		]))])
}

fn Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter.get_stock_status_query_var_values() rt.PhpVal {
	return rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options', []rt.PhpVal{}))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter) get_block_type_style() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.get_block_type_style(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks-packages-style' }])])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_stockfilter() &Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('stock-filter')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_stock_status_query_var_values' {
			return Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter.get_stock_status_query_var_values()
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_StockFilter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_stockfilter_php() {
}
