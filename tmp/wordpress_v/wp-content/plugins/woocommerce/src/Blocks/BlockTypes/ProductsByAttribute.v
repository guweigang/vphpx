import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductsByAttribute {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('products-by-attribute')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductsByAttribute) set_block_query_args(var_query_args rt.PhpVal) {
	if !(!rt.is_true(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductsByAttribute', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid',
	], &this), 'attributes').array_get('attributes'))) {
		mut var_taxonomy := rt.call_function('sanitize_title', [
			rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductsByAttribute', [
				'Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid',
			], &this), 'attributes').array_get('attributes').array_get(0).array_get('attr_slug'),
		])
		mut var_terms := rt.call_function('wp_list_pluck', [rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductsByAttribute', [
			'Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid',
		], &this), 'attributes').array_get('attributes'),
			rt.new_string('id')])
		var_query_args.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
			rt.ArrayItem{ key: 'terms', val: rt.call_function('array_map', [
				rt.new_string('absint'),
				var_terms.dup(),
			]) },
			rt.ArrayItem{ key: 'field', val: 'term_id' },
			rt.ArrayItem{
				key: 'operator'
				val: if rt.is_true(rt.identical(rt.new_string('all'), rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductsByAttribute', [
					'Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid',
				], &this), 'attributes').array_get('attrOperator')))
				{ 'AND' } else { 'IN' }
			},
		]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductsByAttribute) get_block_type_attributes() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'align', val: this.get_schema_align() },
		rt.ArrayItem{ key: 'alignButtons', val: this.get_schema_boolean(rt.new_bool(false)) },
		rt.ArrayItem{ key: 'attributes', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'number' },
					]) },
					rt.ArrayItem{ key: 'attr_slug', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'default', val: rt.new_array() },
		]) }, rt.ArrayItem{ key: 'attrOperator', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'default', val: 'any' },
		]) }, rt.ArrayItem{ key: 'className', val: this.get_schema_string() },
		rt.ArrayItem{ key: 'columns', val: this.get_schema_number(rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::default_columns'),
			rt.new_int(3),
		])) }, rt.ArrayItem{ key: 'contentVisibility', val: this.get_schema_content_visibility() },
		rt.ArrayItem{ key: 'orderby', val: this.get_schema_orderby() },
		rt.ArrayItem{ key: 'rows', val: this.get_schema_number(rt.call_function('wc_get_theme_support', [
			rt.new_string('product_blocks::default_rows'),
			rt.new_int(3),
		])) }, rt.ArrayItem{ key: 'isPreview', val: this.get_schema_boolean(rt.new_bool(false)) },
		rt.ArrayItem{ key: 'stockStatus', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'default', val: rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options',
				[]rt.PhpVal{})) },
		]) }])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productsbyattribute() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductsByAttribute {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductsByAttribute{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('products-by-attribute')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractproductgrid() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractProductGrid{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductsByAttribute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductsByAttribute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductsByAttribute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productsbyattribute_php() {
}
