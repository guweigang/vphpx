import rt

pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter.filter_query_var_prefix() string {
	return 'filter_'
}

pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter.query_type_query_var_prefix() string {
	return 'query_type_'
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('attribute-filter')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('attributes'),
		rt.call_function('array_values', [
			rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{}),
		])])
	mut var_query_state := rt.new_array()
	if rt.is_true(rt.call_function('is_product_category', []rt.PhpVal{})) {
		var_query_state.array_set('category', rt.call_function('get_queried_object_id',
			[]rt.PhpVal{}))
	}
	if rt.is_true(rt.call_function('is_product_tag', []rt.PhpVal{})) {
		var_query_state.array_set('tag', rt.get_property(rt.call_function('get_queried_object',
			[]rt.PhpVal{}), 'term_id'))
	}
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('queryState'),
		var_query_state.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter) get_block_type_style() rt.PhpVal {
	return rt.call_function('array_merge', [this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.get_block_type_style(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'wc-blocks-packages-style' }])])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_attributefilter(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('attribute-filter')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AttributeFilter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
