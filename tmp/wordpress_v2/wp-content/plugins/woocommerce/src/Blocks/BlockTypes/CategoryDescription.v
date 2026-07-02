import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryDescription {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('category-description')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryDescription) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_term_id := if !(rt.get_property(var_block, 'context').array_get(rt.new_string('termId'))).is_null() {
		rt.get_property(var_block, 'context').array_get(rt.new_string('termId'))
	} else {
		rt.new_int(0)
	}
	mut var_term_taxonomy := if !(rt.get_property(var_block, 'context').array_get(rt.new_string('termTaxonomy'))).is_null() {
		rt.get_property(var_block, 'context').array_get(rt.new_string('termTaxonomy'))
	} else {
		rt.new_string('product_cat')
	}
	mut var_text_align := if var_attributes.array_isset(rt.new_string('textAlign')) { rt.call_function('sanitize_key', [
			var_attributes.array_get(rt.new_string('textAlign')),
		]) } else { rt.new_string('') }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term_id)))) {
		return ''
	}
	mut var_term := rt.call_function('get_term', [var_term_id.clone(),
		var_term_taxonomy.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return ''
	}
	mut var_description := rt.get_property(var_term, 'description')
	if var_description.clone().to_string().trim_space() == '' {
		return ''
	}
	mut var_classes := rt.new_array()
	if rt.is_true(var_text_align) {
		var_classes.array_push('has-text-align-' + var_text_align.str())
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				var_classes.clone(),
			]) },
		]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.clone(),
		rt.call_function('wp_kses_post', [
			rt.call_function('wc_format_content', [var_description.clone()]),
		])])).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryDescription) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'termId' },
		rt.ArrayItem{ key: none, val: 'termTaxonomy' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryDescription) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryDescription) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_categorydescription(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryDescription {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryDescription{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('category-description')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryDescription) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_block_type_uses_context' {
			return this.get_block_type_uses_context()
		}
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryDescription) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryDescription) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
