import rt

fn block_core_accordion_item_render(var_attributes rt.PhpVal, content string) string {
	mut var_content := content
	mut var_p := rt.new_null()
	mut var_unique_id := rt.new_null()
	mut var_open_by_default := ''
	mut var_processor := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_content.str()))) {
		return var_content
	}
	var_p = create_wp_html_tag_processor(rt.new_string(var_content.str()))
	var_unique_id = rt.call_function('wp_unique_id', [rt.new_string('accordion-item-')])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := rt.call_function('wp_interactivity_get_context', []rt.PhpVal{})
		return (var_context.array_get(rt.new_string('openByDefault'))).str()
	}
	rt.call_function('wp_interactivity_state', [rt.new_string('core/accordion'),
		rt.create_array([
			rt.ArrayItem{ key: 'isOpen', val: rt.new_closure(closure_1_fn) },
		])])
	if rt.is_true(var_p.next_tag(rt.create_array([
		rt.ArrayItem{ key: 'class_name', val: 'wp-block-accordion-item' },
	])))
	{
		var_open_by_default = if rt.is_true(var_attributes.array_get(rt.new_string('openByDefault'))) {
			'true'
		} else {
			'false'
		}
		var_p.set_attribute(rt.new_string('data-wp-context'), rt.new_string('{ "id": "' +
			var_unique_id.str() + '", "openByDefault": ' + var_open_by_default + ' }'))
		var_p.set_attribute(rt.new_string('data-wp-class--is-open'), rt.new_string('state.isOpen'))
		var_p.set_attribute(rt.new_string('data-wp-init'),
			rt.new_string('callbacks.initAccordionItems'))
		var_p.set_attribute(rt.new_string('data-wp-on-window--hashchange'),
			rt.new_string('callbacks.hashChange'))
		if rt.is_true(var_p.next_tag(rt.create_array([
			rt.ArrayItem{ key: 'class_name', val: 'wp-block-accordion-heading__toggle' },
		])))
		{
			var_p.set_attribute(rt.new_string('data-wp-on--click'), rt.new_string('actions.toggle'))
			var_p.set_attribute(rt.new_string('data-wp-on--keydown'),
				rt.new_string('actions.handleKeyDown'))
			var_p.set_attribute(rt.new_string('id'), var_unique_id.clone())
			var_p.set_attribute(rt.new_string('aria-controls'), rt.new_string(var_unique_id.str() +
				'-panel'))
			var_p.set_attribute(rt.new_string('data-wp-bind--aria-expanded'),
				rt.new_string('state.isOpen'))
			if rt.is_true(var_p.next_tag(rt.create_array([
				rt.ArrayItem{ key: 'class_name', val: 'wp-block-accordion-panel' },
			])))
			{
				var_p.set_attribute(rt.new_string('id'), rt.new_string(var_unique_id.str() +
					'-panel'))
				var_p.set_attribute(rt.new_string('aria-labelledby'), var_unique_id.clone())
				var_p.set_attribute(rt.new_string('data-wp-bind--inert'),
					rt.new_string('!state.isOpen'))
				var_content = (var_p.get_updated_html()).str()
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_attributes.array_get(rt.new_string('openByDefault')))))) {
		var_processor = create_wp_html_tag_processor(rt.new_string(var_content.str()))
		for rt.is_true(var_processor.next_tag(rt.new_string('IMG'))) {
			var_processor.set_attribute(rt.new_string('fetchpriority'), rt.new_string('low'))
		}
		var_content = (var_processor.get_updated_html()).str()
	}
	return var_content
}

fn register_block_core_accordion_item() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/accordion-item'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'block_core_accordion_item_render' },
		]),
	])
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_accordion_item')])
}
