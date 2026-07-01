import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSearch {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('product-search')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSearch) get_block_type_script(var_key rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSearch) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_instance_id := rt.new_null()
	mut var_attributes_mutated := var_attributes
	// unsupported statement: Stmt_Static
	var_attributes_mutated = rt.call_function('wp_parse_args', [
		var_attributes_mutated.dup(),
		rt.create_array([
			rt.ArrayItem{ key: 'hasLabel', val: true },
			rt.ArrayItem{ key: 'align', val: '' },
			rt.ArrayItem{ key: 'className', val: '' },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Search'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('Search products…'),
				rt.new_string('woocommerce'),
			]) },
		])])
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_ProductSearch', [
		'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
	], &this), 'asset_api'), 'add_inline_script', [rt.new_string('wp-hooks'),
		rt.new_string("\n\t\t\twindow.addEventListener( 'DOMContentLoaded', () => {\n\t\t\t\tconst forms = document.querySelectorAll( '.wc-block-product-search form' );\n\n\t\t\t\tfor ( const form of forms ) {\n\t\t\t\t\tform.addEventListener( 'submit', ( event ) => {\n\t\t\t\t\t\tconst field = form.querySelector( '.wc-block-product-search__field' );\n\n\t\t\t\t\t\tif ( field && field.value ) {\n\t\t\t\t\t\t\twp.hooks.doAction( 'experimental__woocommerce_blocks-product-search', { event: event, searchTerm: field.value } );\n\t\t\t\t\t\t}\n\t\t\t\t\t} );\n\t\t\t\t}\n\t\t\t} );\n\t\t\t"),
		rt.new_string('after')])
	mut var_input_id := rt.new_string('wc-block-search__input-' +
		(rt.pre_inc(var_instance_id)).str())
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				rt.call_function('array_filter', [
					rt.create_array([
						rt.ArrayItem{ key: none, val: 'wc-block-product-search' },
						rt.ArrayItem{
							key: none
							val: if rt.is_true(var_attributes_mutated.array_get('align')) {
								'align' + (var_attributes_mutated.array_get('align')).str()
							} else {
								''
							}
						},
					]),
				]),
			]) },
		]),
	])
	mut var_label_markup := if rt.is_true(var_attributes_mutated.array_get('hasLabel')) { rt.call_function('sprintf', [
			rt.new_string('<label for="%s" class="wc-block-product-search__label">%s</label>'),
			rt.call_function('esc_attr', [var_input_id.dup()]),
			rt.call_function('esc_html', [var_attributes_mutated.array_get('label')]),
		]) } else { rt.call_function('sprintf', [
			rt.new_string('<label for="%s" class="wc-block-product-search__label screen-reader-text">%s</label>'),
			rt.call_function('esc_attr', [var_input_id.dup()]),
			rt.call_function('esc_html', [var_attributes_mutated.array_get('label')]),
		]) }
	mut var_input_markup := rt.call_function('sprintf', [
		rt.new_string('<input type="search" id="%s" class="wc-block-product-search__field" placeholder="%s" name="s" />'),
		rt.call_function('esc_attr', [var_input_id.dup()]),
		rt.call_function('esc_attr', [var_attributes_mutated.array_get('placeholder')]),
	])
	mut var_button_markup := rt.call_function('sprintf', [
		rt.new_string('<button type="submit" class="wc-block-product-search__button" aria-label="%s">\n\t\t\t\t<svg aria-hidden="true" role="img" focusable="false" class="dashicon dashicons-arrow-right-alt2" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20">\n\t\t\t\t\t<path d="M6 15l5-5-5-5 1-2 7 7-7 7z" />\n\t\t\t\t</svg>\n\t\t\t</button>'),
		rt.call_function('esc_attr__', [rt.new_string('Search'),
			rt.new_string('woocommerce')]),
	])
	mut var_field_markup := rt.new_string(
		'\n\t\t\t<div class="wc-block-product-search__fields">\n\t\t\t\t' + var_input_markup.str() +
		var_button_markup.str() +
		'\n\t\t\t\t<input type="hidden" name="post_type" value="product" />\n\t\t\t</div>\n\t\t')
	return rt.call_function('sprintf', [
		rt.new_string('<div %s><form role="search" method="get" action="%s">%s</form></div>'),
		var_wrapper_attributes.dup(),
		rt.call_function('esc_url', [rt.call_function('home_url', [
			rt.new_string('/')])]),
		rt.concat(var_label_markup, var_field_markup),
	])
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_productsearch() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSearch {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSearch{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('product-search')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSearch) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_block_type_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_type_script(dispatch_arg_0)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSearch) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ProductSearch) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_productsearch_php() {
}
