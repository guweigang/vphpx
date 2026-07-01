import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicShortcode {
	rt.PhpObjectBase
pub mut:
		block_name rt.PhpVal = rt.new_string('classic-shortcode')
		api_version rt.PhpVal = rt.new_string('3')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicShortcode) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(var_attributes.array_isset(rt.new_string('shortcode'))) {
		return ''
	}
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Frontend_Scripts')])) {
		mut var_frontend_scripts := create_wc_frontend_scripts()
		fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":49,"name":"frontend_scripts"}{}; return temp.load_scripts() }()
	}
	if rt.is_true(rt.identical(rt.new_string('cart'), var_attributes.array_get('shortcode'))) {
		return this.render_cart(var_attributes.dup())
	}
	if rt.is_true(rt.identical(rt.new_string('checkout'), var_attributes.array_get('shortcode'))) {
		return this.render_checkout(var_attributes.dup())
	}
	return 'You\'re using the ClassicShortcode block'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicShortcode) get_container_classes(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_classes := rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce' }, rt.ArrayItem{ key: none, val: 'wp-block-group' }])
	if var_attributes.array_isset(rt.new_string('align')) {
		var_classes.array_push(rt.concat(rt.new_string('align'), var_attributes.array_get('align')))
	}
	return rt.call_function('implode', [rt.new_string(' '), var_classes.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicShortcode) render_cart(var_attributes rt.PhpVal) string {
	if !(!(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')).is_null()) {
		return ''
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	print('<div class="' + (rt.call_function('esc_attr', [this.get_container_classes(var_attributes.dup())])).str() + '">')
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Shortcode_Cart{}; return temp.output(arg_0) }(rt.new_array())
	print('</div>')
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicShortcode) render_checkout(var_attributes rt.PhpVal) string {
	if !(!(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'cart')).is_null()) {
		return ''
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	print('<div class="' + (rt.call_function('esc_attr', [this.get_container_classes(var_attributes.dup())])).str() + '">')
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Shortcode_Checkout{}; return temp.output(arg_0) }(rt.new_array())
	print('</div>')
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicShortcode) get_block_type_style() rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock {
	rt.PhpObjectBase
}

struct Class_WC_Frontend_Scripts {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":49,"name":"frontend_scripts"} {
	rt.PhpObjectBase
}

struct Class_WC_Shortcode_Cart {
	rt.PhpObjectBase
}

struct Class_WC_Shortcode_Checkout {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_classicshortcode() &Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicShortcode {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicShortcode{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name: rt.new_string('classic-shortcode')
		api_version: rt.new_string('3')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractdynamicblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_frontend_scripts() &Class_WC_Frontend_Scripts {
	mut obj := &Class_WC_Frontend_Scripts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_{"nodetype":"expr_variable","line":49,"name":"frontend_scripts"}() &Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":49,"name":"frontend_scripts"} {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":49,"name":"frontend_scripts"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shortcode_cart() &Class_WC_Shortcode_Cart {
	mut obj := &Class_WC_Shortcode_Cart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shortcode_checkout() &Class_WC_Shortcode_Checkout {
	mut obj := &Class_WC_Shortcode_Checkout{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicShortcode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_container_classes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_container_classes(dispatch_arg_0)
		}
		'render_cart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render_cart(dispatch_arg_0))
		}
		'render_checkout' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render_checkout(dispatch_arg_0))
		}
		'get_block_type_style' {
			return this.get_block_type_style()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicShortcode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'api_version' { return this.api_version }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_ClassicShortcode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' { this.block_name = val; return true }
		'api_version' { this.api_version = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractDynamicBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Frontend_Scripts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Frontend_Scripts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Frontend_Scripts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":49,"name":"frontend_scripts"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":49,"name":"frontend_scripts"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_{"nodeType":"Expr_Variable","line":49,"name":"frontend_scripts"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Shortcode_Cart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shortcode_Cart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcode_Cart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Shortcode_Checkout) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shortcode_Checkout) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcode_Checkout) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_classicshortcode_php() {
}
