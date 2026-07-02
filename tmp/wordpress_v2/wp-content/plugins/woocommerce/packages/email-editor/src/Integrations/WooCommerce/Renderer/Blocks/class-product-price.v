import rt

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Price {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Price) render_content(block_content string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_product := this.get_product_from_context(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array',
		[]string{}, var_parsed_block))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
		return ''
	}
	mut var_attributes := if !(var_parsed_block.array_get(rt.new_string('attrs'))).is_null() {
		var_parsed_block.array_get(rt.new_string('attrs'))
	} else {
		rt.new_array()
	}
	mut var_price_content := rt.new_string(this.generate_price_html(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product](var_product), mut
		rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](var_attributes), mut
		var_rendering_context))
	return this.apply_email_wrapper(var_price_content.str(), mut var_parsed_block)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Price) generate_price_html(mut var_product Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product, mut var_attributes Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array, mut var_rendering_context Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context) string {
	mut var_product_mutated := var_product
	mut var_attributes_mutated := var_attributes
	mut var_price_html := rt.new_string(this.build_price_from_scratch(mut var_product_mutated))
	if !rt.is_true(var_price_html) {
		return ''
	}
	mut var_price_styles := rt.create_array([
		rt.ArrayItem{ key: 'display', val: 'block' },
		rt.ArrayItem{ key: 'margin', val: '0' },
		rt.ArrayItem{ key: 'padding', val: '0' },
		rt.ArrayItem{ key: 'font-family', val: 'inherit' },
		rt.ArrayItem{ key: 'color', val: 'inherit' },
		rt.ArrayItem{ key: 'text-decoration', val: 'none' },
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{}
	mut iife_result_0 := iife_temp_0.get_block_styles(rt.new_object('Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array',
		[]string{}, var_attributes_mutated), rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context',
		[]string{}, var_rendering_context), rt.create_array([
		rt.ArrayItem{ key: none, val: 'border' },
		rt.ArrayItem{ key: none, val: 'background-color' },
		rt.ArrayItem{ key: none, val: 'color' },
		rt.ArrayItem{ key: none, val: 'typography' },
		rt.ArrayItem{ key: none, val: 'spacing' },
	]))
	mut var_custom_styles := iife_result_0
	var_price_styles = rt.call_function('array_merge', [var_price_styles.clone(),
		var_custom_styles.array_get(rt.new_string('declarations'))])
	mut iife_temp_1 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine{}
	mut iife_result_1 := iife_temp_1.compile_css(var_price_styles.clone(), rt.new_string(''))
	mut var_style_attr := iife_result_1
	return (rt.call_function('sprintf', [
		rt.new_string('<div class="wc-block-components-product-price" style="%s">%s</div>'),
		rt.call_function('esc_attr', [var_style_attr.clone()]),
		var_price_html.clone(),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Price) build_price_from_scratch(mut var_product Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product) string {
	mut var_product_mutated := var_product
	mut var_product_type := rt.call_method(var_product_mutated, 'get_type', []rt.PhpVal{})
	mut switch_val_1 := var_product_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('simple')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('external'))) {
		return this.build_simple_product_price(mut var_product_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('variable'))) {
		if rt.is_true(rt.new_bool(rt.instance_of(var_product_mutated,
			'Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product_Variable')))
		{
			return this.build_variable_product_price(mut var_product_mutated)
		}
		return this.build_simple_product_price(mut var_product_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('grouped'))) {
		if rt.is_true(rt.new_bool(rt.instance_of(var_product_mutated,
			'Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product_Grouped')))
		{
			return this.build_grouped_product_price(mut var_product_mutated)
		}
		return this.build_simple_product_price(mut var_product_mutated)
	} else {
		return this.build_simple_product_price(mut var_product_mutated)
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Price) build_simple_product_price(mut var_product Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product) string {
	mut var_product_mutated := var_product
	mut var_regular_price := rt.call_function('wc_get_price_to_display', [
		var_product_mutated,
		rt.create_array([
			rt.ArrayItem{ key: 'price', val: rt.new_float((rt.call_method(var_product_mutated,
				'get_regular_price', []rt.PhpVal{})).to_f64()) },
		]),
	])
	mut var_sale_price := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_product_mutated, 'get_sale_price', []rt.PhpVal{}), rt.new_string(''))))) { rt.call_function('wc_get_price_to_display', [
			var_product_mutated,
			rt.create_array([
				rt.ArrayItem{
					key: 'price'
					val: rt.new_float((rt.call_method(var_product_mutated, 'get_sale_price', []rt.PhpVal{})).to_f64())
				},
			]),
		]) } else { rt.new_string('') }
	if !rt.is_true(var_regular_price) {
		return ''
	}
	if rt.is_true(rt.call_method(var_product_mutated, 'is_on_sale', []rt.PhpVal{}))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_sale_price)))) {
		return (rt.call_function('sprintf', [
			rt.new_string('<del style="text-decoration: line-through; font-size: 0.9em; margin-right: 0.5em;">%s</del><span>%s</span>'),
			rt.call_function('wc_price', [var_regular_price.clone(),
				rt.create_array([rt.ArrayItem{ key: 'in_span', val: false }])]),
			rt.call_function('wc_price', [var_sale_price.clone(),
				rt.create_array([rt.ArrayItem{ key: 'in_span', val: false }])]),
		])).str()
	} else {
		return (rt.call_function('sprintf', [rt.new_string('<span>%s</span>'),
			rt.call_function('wc_price', [var_regular_price.clone(),
				rt.create_array([rt.ArrayItem{ key: 'in_span', val: false }])])])).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Price) build_variable_product_price(mut var_product Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product_Variable) string {
	mut var_product_mutated := var_product
	mut var_min_price := rt.call_method(var_product_mutated, 'get_variation_price', [
		rt.new_string('min'),
		rt.new_bool(true),
	])
	mut var_max_price := rt.call_method(var_product_mutated, 'get_variation_price', [
		rt.new_string('max'),
		rt.new_bool(true),
	])
	return (rt.call_function('sprintf', [rt.new_string('<span>%s — %s</span>'),
		rt.call_function('wc_price', [rt.new_float(var_min_price.to_f64()),
			rt.create_array([rt.ArrayItem{ key: 'in_span', val: false }])]),
		rt.call_function('wc_price', [rt.new_float(var_max_price.to_f64()),
			rt.create_array([rt.ArrayItem{ key: 'in_span', val: false }])])])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Price) build_grouped_product_price(mut var_product Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product_Grouped) string {
	mut var_product_mutated := var_product
	mut var_children := rt.call_method(var_product_mutated, 'get_children', []rt.PhpVal{})
	if !rt.is_true(var_children) {
		return ''
	}
	mut var_prices := rt.new_array()
	mut iter_1 := var_children.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_child_id := item_1.val
		mut var_child := rt.call_function('wc_get_product', [
			var_child_id.clone()])
		if rt.is_true(var_child)
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_child, 'get_price', []rt.PhpVal{}), rt.new_string(''))))) {
			var_prices.array_push(rt.call_function('wc_get_price_to_display', [
				var_child.clone(),
				rt.create_array([
					rt.ArrayItem{ key: 'price', val: rt.new_float((rt.call_method(var_child,
						'get_price', []rt.PhpVal{})).to_f64()) },
				]),
			]))
		}
	}
	if !rt.is_true(var_prices) {
		return ''
	}
	mut var_min_price := rt.call_function('min', [var_prices.clone()])
	mut var_max_price := rt.call_function('max', [var_prices.clone()])
	return (rt.call_function('sprintf', [rt.new_string('<span>%s — %s</span>'),
		rt.call_function('wc_price', [rt.new_float(var_min_price.to_f64()),
			rt.create_array([rt.ArrayItem{ key: 'in_span', val: false }])]),
		rt.call_function('wc_price', [rt.new_float(var_max_price.to_f64()),
			rt.create_array([rt.ArrayItem{ key: 'in_span', val: false }])])])).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Price) apply_email_wrapper(price_html string, mut var_parsed_block Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array) string {
	mut price_html_mutated := price_html
	mut var_align := if !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('textAlign'))).is_null() {
		var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('textAlign'))
	} else {
		rt.new_string('left')
	}
	mut var_wrapper_styles := rt.create_array([
		rt.ArrayItem{ key: 'border-collapse', val: 'collapse' },
		rt.ArrayItem{ key: 'width', val: '100%' },
	])
	mut var_cell_styles := rt.create_array([rt.ArrayItem{ key: 'padding', val: '5px 0' },
		rt.ArrayItem{ key: 'text-align', val: var_align }, rt.ArrayItem{
			key: 'font-family'
			val: 'inherit'
		}])
	mut iife_temp_2 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine{}
	mut iife_result_2 := iife_temp_2.compile_css(var_wrapper_styles.clone(), rt.new_string(''))
	mut var_table_attrs := rt.create_array([
		rt.ArrayItem{ key: 'style', val: iife_result_2 },
		rt.ArrayItem{ key: 'width', val: '100%' },
	])
	mut iife_temp_3 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine{}
	mut iife_result_3 := iife_temp_3.compile_css(var_cell_styles.clone(), rt.new_string(''))
	mut var_cell_attrs := rt.create_array([
		rt.ArrayItem{ key: 'class', val: 'email-product-price-cell' },
		rt.ArrayItem{ key: 'style', val: iife_result_3 },
		rt.ArrayItem{ key: 'align', val: var_align },
	])
	mut iife_temp_4 :=
		Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{}
	mut iife_result_4 := iife_temp_4.render_table_wrapper(rt.new_string(price_html_mutated),
		var_table_attrs.clone(), var_cell_attrs.clone())
	return iife_result_4.str()
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_product_price(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Price {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Price{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_abstract_product_block_renderer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_styles_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_woocommerce_renderer_blocks_wp_style_engine(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_integrations_utils_table_wrapper_helper(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Price) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.render_content(dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
		}
		'generate_price_html' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Rendering_Context](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.generate_price_html(mut dispatch_arg_0, mut dispatch_arg_1, mut
				dispatch_arg_2))
		}
		'build_price_from_scratch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.build_price_from_scratch(mut dispatch_arg_0))
		}
		'build_simple_product_price' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.build_simple_product_price(mut dispatch_arg_0))
		}
		'build_variable_product_price' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product_Variable](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.build_variable_product_price(mut dispatch_arg_0))
		}
		'build_grouped_product_price' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WC_Product_Grouped](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.build_grouped_product_price(mut dispatch_arg_0))
		}
		'apply_email_wrapper' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.apply_email_wrapper(dispatch_arg_0, mut dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Price) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Product_Price) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_Abstract_Product_Block_Renderer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Styles_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_WooCommerce_Renderer_Blocks_WP_Style_Engine) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Integrations_Utils_Table_Wrapper_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
