import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_HandpickedProducts {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('handpicked-products')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_HandpickedProducts) set_block_query_args(var_query_args rt.PhpVal) {
	mut var_query_args_mutated := var_query_args
	mut var_ids := rt.call_function('array_map', [rt.new_string('absint'),
		rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_HandpickedProducts', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid',
		], &this), 'attributes').array_get(rt.new_string('products'))])
	var_query_args_mutated.array_set('post__in', var_ids.clone())
	var_query_args_mutated.array_set('posts_per_page', var_ids.clone().array_count())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_HandpickedProducts) set_visibility_query_args(var_query_args rt.PhpVal) {
	mut var_query_args_mutated := var_query_args
	if rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_hide_out_of_stock_items'),
	])))
	{
		mut var_product_visibility_terms := rt.call_function('wc_get_product_visibility_term_ids',
			[]rt.PhpVal{})
		var_query_args_mutated.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_visibility' },
			rt.ArrayItem{ key: 'field', val: 'term_taxonomy_id' },
			rt.ArrayItem{ key: 'terms', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: var_product_visibility_terms.array_get(Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock())
				},
			]) },
			rt.ArrayItem{ key: 'operator', val: 'NOT IN' },
		]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_HandpickedProducts) get_block_type_attributes() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'align', val: this.get_schema_align() },
		rt.ArrayItem{ key: 'alignButtons', val: this.get_schema_boolean(rt.new_bool(false)) },
		rt.ArrayItem{ key: 'className', val: this.get_schema_string() },
		rt.ArrayItem{ key: 'columns', val: this.get_schema_number(rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::default_columns'),
			rt.new_int(3),
		])) }, rt.ArrayItem{ key: 'orderby', val: this.get_schema_orderby() },
		rt.ArrayItem{ key: 'products', val: this.get_schema_list_ids() },
		rt.ArrayItem{ key: 'contentVisibility', val: this.get_schema_content_visibility() },
		rt.ArrayItem{ key: 'isPreview', val: this.get_schema_boolean(rt.new_bool(false)) }])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_handpickedproducts(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_HandpickedProducts {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_HandpickedProducts{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('handpicked-products')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractproductgrid(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_HandpickedProducts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'set_block_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_block_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'set_visibility_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_visibility_query_args(dispatch_arg_0)
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_HandpickedProducts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_HandpickedProducts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
