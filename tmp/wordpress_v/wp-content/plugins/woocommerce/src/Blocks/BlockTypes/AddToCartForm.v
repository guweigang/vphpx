import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('add-to-cart-form')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm) parse_attributes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_defaults := rt.create_array([rt.ArrayItem{ key: 'quantitySelectorStyle', val: 'input' }])
	return rt.call_function('wp_parse_args', [var_attributes.dup(), var_defaults.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm) enqueue_assets(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal)  {
	mut var_parsed_attributes := this.parse_attributes(var_attributes.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_assets(var_attributes.dup(), var_content.dup(), var_block.dup())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm) enqueue_data(mut var_attributes Class_Automattic_WooCommerce_Blocks_BlockTypes_array)  {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.enqueue_data(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_array', []string{}, var_attributes))
	rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'asset_data_registry'), 'add', [rt.new_string('isBlockTheme'), rt.call_function('wp_is_block_theme', []rt.PhpVal{})])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm) add_steppers(var_product_html rt.PhpVal, var_product_name rt.PhpVal) rt.PhpVal {
	mut var_product_html_mutated := var_product_html
	mut var_product_name_mutated := var_product_name
	mut var_pattern := rt.new_string(rt.new_string('/(<input[^>]*id="quantity_[^"]*"[^>]*\\/>)/'))
	closure_1_fn := fn [var_product_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_matches := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_plus_aria := rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Increase quantity of %s'), rt.new_string('woocommerce')]), var_product_name_mutated.dup()])])
	return rt.new_string((var_matches.array_get(1)).str() + '<button aria-label="' + (var_plus_aria).str() + '" type="button" data-wp-on--click="actions.increaseQuantity" class="wc-block-components-quantity-selector__button wc-block-components-quantity-selector__button--plus">+</button>')
	}
	mut var_new_html := rt.call_function('preg_replace_callback', [var_pattern.dup(), rt.new_closure(closure_1_fn), if !(var_product_html_mutated).is_null() { var_product_html_mutated } else { rt.new_string('') }])
	closure_2_fn := fn [var_product_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_matches := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_minus_aria := rt.call_function('esc_attr', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Reduce quantity of %s'), rt.new_string('woocommerce')]), var_product_name_mutated.dup()])])
	return rt.new_string((var_matches.array_get(1)).str() + '<button aria-label="' + (var_minus_aria).str() + '" type="button" data-wp-on--click="actions.decreaseQuantity" class="wc-block-components-quantity-selector__button wc-block-components-quantity-selector__button--minus">−</button>')
	}
	var_new_html = rt.call_function('preg_replace_callback', [var_pattern.dup(), rt.new_closure(closure_2_fn), if !(var_new_html).is_null() { var_new_html } else { rt.new_string('') }])
	return if !(var_new_html).is_null() { var_new_html } else { rt.new_string('') }
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm) add_stepper_classes_to_add_to_cart_form_input(var_product_html rt.PhpVal) rt.PhpVal {
	mut var_product_html_mutated := var_product_html
	mut var_processor := create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor(var_product_html_mutated.dup())
	for rt.is_true(var_processor.next_tag()) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_processor.get_tag(), rt.new_string('DIV'))) && rt.is_true(var_processor.has_class(rt.new_string('quantity'))))) {
			var_processor.add_class(rt.new_string('wc-block-components-quantity-selector'))
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_processor.get_tag(), rt.new_string('INPUT'))) && rt.is_true(var_processor.has_class(rt.new_string('qty'))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_processor.add_class(rt.new_string('wc-block-components-quantity-selector__input'))
		}
	}
	return var_processor.get_updated_html()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm) has_all_attributes_set(var_product rt.PhpVal) bool {
	mut var_product_mutated := var_product
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_product_mutated, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()]))))) {
		return true
	}
	mut var_variation_attributes := rt.call_method(var_product_mutated, 'get_variation_attributes', []rt.PhpVal{})
	if !rt.is_true(var_variation_attributes) {
		return true
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string(''), rt.call_function('array_values', [var_variation_attributes.dup()]), rt.new_bool(true)])) {
		return false
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	// unsupported statement: Stmt_Global
	mut var_post_id := rt.get_property(var_block, 'context').array_get('postId')
	if !(!(var_post_id).is_null()) {
		return ''
	}
	mut var_is_descendent_of_single_product_block := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(var_product.dup().is_null())) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical)))
	mut var_previous_product := var_product.dup()
	mut var_product := rt.call_function('wc_get_product', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_WC_Product')))))) {
		var_product = var_previous_product.dup()
		return ''
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) && !(this.has_all_attributes_set(var_product.dup())))) {
		var_product = var_previous_product.dup()
		return ''
	}
	mut var_is_external_product_with_url := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_product, 'Automattic_WooCommerce_Blocks_BlockTypes_WC_Product_External'))) && rt.is_true(rt.call_method(var_product, 'get_product_url', []rt.PhpVal{}))))
	mut var_managing_stock := rt.call_method(var_product, 'managing_stock', []rt.PhpVal{})
	mut var_stock_quantity := rt.call_method(var_product, 'get_stock_quantity', []rt.PhpVal{})
	mut var_should_hide_quantity_selector := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product, 'is_sold_individually', []rt.PhpVal{})) || rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}; return temp.is_min_max_quantity_same(arg_0) }(var_product.dup())))) || rt.is_true(rt.new_bool(rt.is_true(var_managing_stock) && rt.is_true(rt.less_equal(var_stock_quantity, rt.new_int(1)))))))
	mut var_is_stepper_style := rt.new_bool(rt.new_bool(rt.is_true(rt.identical(rt.new_string('stepper'), var_attributes.array_get('quantitySelectorStyle'))) && rt.is_true(rt.new_bool(!(rt.is_true(var_should_hide_quantity_selector))))))
	if rt.is_true(var_is_descendent_of_single_product_block) {
		rt.call_function('add_filter', [rt.new_string('woocommerce_add_to_cart_form_action'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'add_to_cart_form_action' }]), rt.new_int(10)])
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('add_action', [rt.new_string('woocommerce_variation_add_to_cart'), rt.new_string('woocommerce_simple_add_to_cart'), rt.new_int(10)])
	rt.call_function('do_action', ['woocommerce_' + (rt.call_method(var_product, 'get_type', []rt.PhpVal{})).str() + '_add_to_cart'])
	rt.call_function('remove_action', [rt.new_string('woocommerce_variation_add_to_cart'), rt.new_string('woocommerce_simple_add_to_cart'), rt.new_int(10)])
	mut var_product_html := rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.is_true(var_is_descendent_of_single_product_block) {
		rt.call_function('remove_filter', [rt.new_string('woocommerce_add_to_cart_form_action'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this) }, rt.ArrayItem{ key: none, val: 'add_to_cart_form_action' }]), rt.new_int(10)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_product_html)))) {
		var_product = var_previous_product.dup()
		return ''
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_is_stepper_style) && rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{}; return temp.has_visible_quantity_input(arg_0) }(var_product_html.dup()))))))) {
		var_is_stepper_style = rt.new_bool(rt.new_bool(false))
	}
	if rt.is_true(var_is_stepper_style) {
		mut var_product_name := rt.call_method(var_product, 'get_name', []rt.PhpVal{})
		var_product_html = this.add_steppers(var_product_html.dup(), var_product_name.dup())
		var_product_html = this.add_stepper_classes_to_add_to_cart_form_input(var_product_html.dup())
	}
	mut var_classes_and_styles := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}; return temp.get_classes_and_styles_by_attributes(arg_0, arg_1, arg_2) }(var_attributes.dup(), rt.new_array(), rt.create_array([rt.ArrayItem{ key: none, val: 'extra_classes' }]))
	mut var_product_classname := rt.new_string(if rt.is_true(var_is_descendent_of_single_product_block) { rt.new_string('product') } else { rt.new_string('') })
	mut var_classes := rt.call_function('implode', [rt.new_string(' '), rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: 'wp-block-add-to-cart-form wc-block-add-to-cart-form' }, rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [var_classes_and_styles.array_get('classes')]) }, rt.ArrayItem{ key: none, val: rt.call_function('esc_attr', [var_product_classname.dup()]) }, rt.ArrayItem{ key: none, val: if rt.is_true(var_is_stepper_style) { 'wc-block-add-to-cart-form--stepper' } else { 'wc-block-add-to-cart-form--input' } }])])])
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes }, rt.ArrayItem{ key: 'style', val: rt.call_function('esc_attr', [var_classes_and_styles.array_get('styles')]) }])])
	mut var_form := rt.call_function('sprintf', [rt.new_string('<div %1$s %2$s>%3$s</div>'), var_wrapper_attributes.dup(), if rt.is_true(var_is_stepper_style) { rt.new_string('data-wp-interactive="woocommerce/add-to-cart-form"') } else { rt.new_string('') }, var_product_html.dup()])
	var_product = var_previous_product.dup()
	return (var_form).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm) add_to_cart_form_action() rt.PhpVal {
	mut var_wp := rt.new_null()
	// unsupported statement: Stmt_Global
	return rt.call_function('home_url', [rt.call_function('add_query_arg', [rt.get_superglobal('_GET').dup(), rt.get_property(var_wp, 'request')])])
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartform() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('add-to-cart-form')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_wp_html_tag_processor() &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_addtocartwithoptions_utils() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils() &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'parse_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.parse_attributes(dispatch_arg_0)
		}
		'enqueue_assets' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.enqueue_assets(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'enqueue_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_BlockTypes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.enqueue_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'add_steppers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_steppers(dispatch_arg_0, dispatch_arg_1)
		}
		'add_stepper_classes_to_add_to_cart_form_input' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_stepper_classes_to_add_to_cart_form_input(dispatch_arg_0)
		}
		'has_all_attributes_set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.has_all_attributes_set(dispatch_arg_0))
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'add_to_cart_form_action' {
			return this.add_to_cart_form_action()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartForm) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' { this.block_name = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AddToCartWithOptions_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_addtocartform_php() {
	// unsupported statement: Stmt_Declare
}
