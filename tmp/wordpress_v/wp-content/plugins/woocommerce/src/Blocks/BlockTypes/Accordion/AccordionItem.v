import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Accordion_AccordionItem {
	rt.PhpObjectBase
pub mut:
	block_name rt.PhpVal = rt.new_string('accordion-item')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Accordion_AccordionItem) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	if rt.is_true(rt.new_bool(!(rt.is_true(var_content_mutated)))) {
		return var_content_mutated.dup()
	}
	mut var_p :=
		create_automattic_woocommerce_blocks_blocktypes_accordion_wp_html_tag_processor(var_content_mutated.dup())
	mut var_unique_id := rt.call_function('wp_unique_id', [
		rt.new_string('woocommerce-accordion-item-'),
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := rt.call_function('wp_interactivity_get_context', []rt.PhpVal{})
		return var_context.array_get('openByDefault')
	}
	rt.call_function('wp_interactivity_state', [rt.new_string('woocommerce/accordion'),
		rt.create_array([
			rt.ArrayItem{ key: 'isOpen', val: rt.new_closure(closure_1_fn) },
		])])
	if rt.is_true(var_p.next_tag(rt.create_array([
		rt.ArrayItem{ key: 'class_name', val: 'wp-block-woocommerce-accordion-item' },
	])))
	{
		mut var_interactivity_context := rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_unique_id },
			rt.ArrayItem{ key: 'openByDefault', val: var_attributes.array_get('openByDefault') },
		])
		var_p.set_attribute(rt.new_string('data-wp-context'), rt.call_function('wp_json_encode', [
			var_interactivity_context.dup(),
			rt.bitwise_or(rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_HEX_APOS')), rt.get_constant('JSON_HEX_QUOT')),
				rt.get_constant('JSON_HEX_AMP')),
		]))
		var_p.set_attribute(rt.new_string('data-wp-class--is-open'), rt.new_string('state.isOpen'))
		var_p.set_attribute(rt.new_string('data-wp-init'), rt.new_string('callbacks.initIsOpen'))
		if rt.is_true(var_p.next_tag(rt.create_array([
			rt.ArrayItem{ key: 'class_name', val: 'accordion-item__toggle' },
		])))
		{
			var_p.set_attribute(rt.new_string('data-wp-on--click'), rt.new_string('actions.toggle'))
			var_p.set_attribute(rt.new_string('id'), var_unique_id.dup())
			var_p.set_attribute(rt.new_string('aria-controls'), rt.new_string(var_unique_id.str() +
				'-panel'))
			var_p.set_attribute(rt.new_string('data-wp-bind--aria-expanded'),
				rt.new_string('state.isOpen'))
			if rt.is_true(var_p.next_tag(rt.create_array([
				rt.ArrayItem{ key: 'class_name', val: 'wp-block-woocommerce-accordion-panel' },
			])))
			{
				var_p.set_attribute(rt.new_string('id'), rt.new_string(var_unique_id.str() +
					'-panel'))
				var_p.set_attribute(rt.new_string('aria-labelledby'), var_unique_id.dup())
				var_p.set_attribute(rt.new_string('role'), rt.new_string('region'))
				var_p.set_attribute(rt.new_string('data-wp-bind--inert'),
					rt.new_string('!state.isOpen'))
				var_content_mutated = var_p.get_updated_html()
			}
		}
	}
	return var_content_mutated.dup()
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_Accordion_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_accordion_accordionitem() &Class_Automattic_WooCommerce_Blocks_BlockTypes_Accordion_AccordionItem {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Accordion_AccordionItem{
		PhpObjectBase: rt.PhpObjectBase{}
		block_name:    rt.new_string('accordion-item')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock() &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_accordion_wp_html_tag_processor() &Class_Automattic_WooCommerce_Blocks_BlockTypes_Accordion_WP_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_Accordion_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Accordion_AccordionItem) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Accordion_AccordionItem) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Accordion_AccordionItem) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Accordion_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_Accordion_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_Accordion_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktypes_accordion_accordionitem_php() {
	// unsupported statement: Stmt_Declare
}
