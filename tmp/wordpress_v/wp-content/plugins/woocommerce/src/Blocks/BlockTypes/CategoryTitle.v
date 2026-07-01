import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryTitle {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('category-title')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryTitle) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_term_id := if !(rt.get_property(var_block, 'context').array_get('termId')).is_null() {
		rt.get_property(var_block, 'context').array_get('termId')
	} else {
		rt.new_int(0)
	}
	mut var_term_taxonomy := if !(rt.get_property(var_block, 'context').array_get('termTaxonomy')).is_null() {
		rt.get_property(var_block, 'context').array_get('termTaxonomy')
	} else {
		rt.new_string('product_cat')
	}
	mut var_level := if var_attributes.array_isset(rt.new_string('level')) { rt.call_function('max', [
			rt.new_int(0),
			rt.call_function('min', [rt.new_int(6),
				rt.new_int(var_attributes.array_get('level').to_i64())]),
		]) } else { rt.new_int(2) }
	mut var_text_align := if var_attributes.array_isset(rt.new_string('textAlign')) { rt.call_function('sanitize_key', [
			var_attributes.array_get('textAlign'),
		]) } else { rt.new_string('') }
	mut var_is_link := rt.new_bool(rt.new_bool(!(!rt.is_true(var_attributes.array_get('isLink')))))
	mut var_rel := if var_attributes.array_isset(rt.new_string('rel')) { rt.call_function('esc_attr', [
			var_attributes.array_get('rel'),
		]) } else { rt.new_string('') }
	mut var_target := if var_attributes.array_isset(rt.new_string('linkTarget')) { rt.call_function('esc_attr', [
			var_attributes.array_get('linkTarget'),
		]) } else { rt.new_string('_self') }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term_id)))) {
		return ''
	}
	mut var_term := rt.call_function('get_term', [var_term_id.dup(),
		var_term_taxonomy.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_term))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_term.dup()]))))
	{
		return ''
	}
	mut var_tag_name := rt.new_string(if rt.is_true(rt.identical(rt.new_int(0), var_level)) {
		rt.new_string('p')
	} else {
		'h' + var_level.str()
	})
	mut var_classes := rt.new_string(if rt.is_true(var_text_align) {
		'has-text-align-' + var_text_align.str()
	} else {
		rt.new_string('')
	})
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes }]),
	])
	mut var_title_html := rt.new_string(rt.new_string(''))
	if rt.is_true(var_is_link) {
		mut var_link := rt.call_function('get_term_link', [var_term.dup()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
			var_link.dup()])))))
		{
			var_title_html = rt.call_function('sprintf', [
				rt.new_string('<%1$s %2$s><a href="%3$s" target="%4$s" rel="%5$s">%6$s</a></%1$s>'),
				rt.call_function('esc_attr', [var_tag_name.dup()]),
				var_wrapper_attributes.dup(),
				rt.call_function('esc_url', [var_link.dup()]),
				rt.call_function('esc_attr', [var_target.dup()]),
				var_rel.dup(),
				rt.call_function('esc_html', [rt.get_property(var_term, 'name')]),
			])
		}
	}
	if rt.is_true(rt.identical(rt.new_string(''), var_title_html)) {
		var_title_html = rt.call_function('sprintf', [
			rt.new_string('<%1$s %2$s>%3$s</%1$s>'),
			rt.call_function('esc_attr', [var_tag_name.dup()]),
			var_wrapper_attributes.dup(),
			rt.call_function('esc_html', [rt.get_property(var_term, 'name')]),
		])
	}
	return var_title_html.str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryTitle) get_block_type_uses_context() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'termId' },
		rt.ArrayItem{ key: none, val: 'termTaxonomy' }])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryTitle) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryTitle) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_categorytitle() &Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryTitle {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryTitle{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('category-title')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryTitle) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryTitle) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CategoryTitle) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_categorytitle_php() {
	// unsupported statement: Stmt_Declare
}
