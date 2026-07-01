import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AllProducts {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('all-products')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AllProducts) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AllProducts', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('hasFilterableProducts'),
		rt.new_bool(true)])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AllProducts', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('minColumns'),
		rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::min_columns'),
			rt.new_int(1),
		])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AllProducts', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('maxColumns'),
		rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::max_columns'),
			rt.new_int(6),
		])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AllProducts', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('defaultColumns'),
		rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::default_columns'),
			rt.new_int(3),
		])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AllProducts', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('minRows'),
		rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::min_rows'),
			rt.new_int(1),
		])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AllProducts', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('maxRows'),
		rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::max_rows'),
			rt.new_int(6),
		])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AllProducts', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('defaultRows'),
		rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::default_rows'),
			rt.new_int(3),
		])])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_rest_api_request', []rt.PhpVal{})))))))
	{
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AllProducts', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
		], &this), 'asset_data_registry'), 'hydrate_api_request', [
			rt.new_string('/wc/store/v1/cart'),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AllProducts) register_block_type_assets() {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.register_block_type_assets()
	this.register_chunk_translations(rt.create_array([
		rt.ArrayItem{ key: none, val: this.block_name },
	]))
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_allproducts() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AllProducts {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AllProducts{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('all-products')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AllProducts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'register_block_type_assets' {
			this.register_block_type_assets()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AllProducts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AllProducts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_allproducts_php() {
}
