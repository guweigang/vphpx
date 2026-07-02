import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTag {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-tag')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTag) set_block_query_args(var_query_args rt.PhpVal) {
	if !(!rt.is_true(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductTag', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid',
	], &this), 'attributes').array_get(rt.new_string('tags')))) {
		var_query_args.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: 'product_tag' },
			rt.ArrayItem{ key: 'terms', val: rt.call_function('array_map', [
				rt.new_string('absint'),
				rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductTag', [
					'Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid',
				], &this), 'attributes').array_get(rt.new_string('tags')),
			]) },
			rt.ArrayItem{ key: 'field', val: 'term_id' },
			rt.ArrayItem{
				key: 'operator'
				val: if
					rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductTag', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid'], &this), 'attributes').array_isset(rt.new_string('tagOperator'))
					&& rt.is_true(rt.identical(rt.new_string('any'), rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductTag', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid'], &this), 'attributes').array_get(rt.new_string('tagOperator')))) {
					'IN'
				} else {
					'AND'
				}
			},
		]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTag) get_block_type_attributes() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'className', val: this.get_schema_string() },
		rt.ArrayItem{ key: 'columns', val: this.get_schema_number(rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::default_columns'),
			rt.new_int(3),
		])) },
		rt.ArrayItem{ key: 'rows', val: this.get_schema_number(rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::default_rows'),
			rt.new_int(3),
		])) },
		rt.ArrayItem{ key: 'contentVisibility', val: this.get_schema_content_visibility() },
		rt.ArrayItem{ key: 'align', val: this.get_schema_align() },
		rt.ArrayItem{ key: 'alignButtons', val: this.get_schema_boolean(rt.new_bool(false)) },
		rt.ArrayItem{ key: 'orderby', val: this.get_schema_orderby() },
		rt.ArrayItem{ key: 'tags', val: this.get_schema_list_ids() },
		rt.ArrayItem{ key: 'tagOperator', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'default', val: 'any' },
		]) },
		rt.ArrayItem{ key: 'isPreview', val: this.get_schema_boolean(rt.new_bool(false)) },
		rt.ArrayItem{ key: 'stockStatus', val: rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options',
			[]rt.PhpVal{})) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTag) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array) {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array',
		[]string{}, var_attributes))
	mut var_tag_count := rt.call_function('wp_count_terms', [
		rt.new_string('product_tag'),
	])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductTag', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('hasTags'),
		rt.greater(var_tag_count, rt.new_int(0))])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductTag', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid',
	], &this), 'asset_data_registry'), 'add', [rt.new_string('limitTags'),
		rt.greater(var_tag_count, rt.new_int(100))])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_producttag(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTag {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTag{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-tag')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractproductgrid(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTag) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'set_block_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_block_query_args(dispatch_arg_0)
			return rt.new_null()
		}
		'get_block_type_attributes' {
			return this.get_block_type_attributes()
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTag) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductTag) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
