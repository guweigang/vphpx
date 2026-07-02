import rt

struct Class_WP_Block {
	rt.PhpObjectBase
pub mut:
		parsed_block rt.PhpVal = rt.new_null()
		name rt.PhpVal = rt.new_null()
		block_type rt.PhpVal = rt.new_null()
		context rt.PhpVal = rt.new_array()
		available_context rt.PhpVal = rt.new_array()
		registry rt.PhpVal = rt.new_null()
		inner_blocks rt.PhpVal = rt.new_array()
		inner_html rt.PhpVal = rt.new_string('')
		inner_content rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Block) construct(var_block rt.PhpVal, var_available_context rt.PhpVal, var_registry rt.PhpVal) {
	mut var_registry_mutated := var_registry
	this.parsed_block = var_block.clone()
	this.name = var_block.array_get(rt.new_string('blockName'))
	if rt.is_true(rt.new_bool(var_registry_mutated.clone().is_null())) {
	mut iife_temp_0 := Class_WP_Block_Type_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	var_registry_mutated = iife_result_0
	}
	this.registry = var_registry_mutated.clone()
	this.block_type = rt.call_method(var_registry_mutated, 'get_registered', [this.name])
	this.available_context = var_available_context.clone()
	this.refresh_context_dependents()
}

fn (mut this Class_WP_Block) refresh_context_dependents() {
	this.available_context = rt.call_function('array_merge', [this.available_context, this.context])
	if !(!rt.is_true(rt.get_property(this.block_type, 'uses_context'))) {
		mut iter_1 := rt.get_property(this.block_type, 'uses_context').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_context_name := item_1.val
			if rt.is_true(rt.new_bool(this.available_context.array_isset(var_context_name.clone()))) {
				this.context.array_set(var_context_name, this.available_context.array_get(var_context_name))
			}
		}
	}
	this.refresh_parsed_block_dependents()
}

fn (mut this Class_WP_Block) refresh_parsed_block_dependents() {
	if !(!rt.is_true(this.parsed_block.array_get(rt.new_string('innerBlocks')))) {
		mut var_child_context := this.available_context
		if !(!rt.is_true(rt.get_property(this.block_type, 'provides_context'))) {
			mut iter_2 := rt.get_property(this.block_type, 'provides_context').iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_attribute_name := item_2.val
				mut var_context_name := item_2.key
				if rt.is_true(rt.new_bool(rt.get_property(rt.new_object('WP_Block', []string{}, &this), 'attributes').array_isset(var_attribute_name.clone()))) {
					var_child_context.array_set(var_context_name, rt.get_property(rt.new_object('WP_Block', []string{}, &this), 'attributes').array_get(var_attribute_name))
				}
			}
		}
		this.inner_blocks = create_wp_block_list(this.parsed_block.array_get(rt.new_string('innerBlocks')), var_child_context.clone(), this.registry)
	}
	if !(!rt.is_true(this.parsed_block.array_get(rt.new_string('innerHTML')))) {
		this.inner_html = this.parsed_block.array_get(rt.new_string('innerHTML'))
	}
	if !(!rt.is_true(this.parsed_block.array_get(rt.new_string('innerContent')))) {
		this.inner_content = this.parsed_block.array_get(rt.new_string('innerContent'))
	}
}

fn (mut this Class_WP_Block) magic_get(var_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('attributes'), var_name)) {
		this.dispatch_set_prop('attributes', if !(this.parsed_block.array_get(rt.new_string('attrs'))).is_null() { this.parsed_block.array_get(rt.new_string('attrs')) } else { rt.new_array() })
		if !(this.block_type.is_null()) {
			this.dispatch_set_prop('attributes', rt.call_method(this.block_type, 'prepare_attributes_for_render', [rt.get_property(rt.new_object('WP_Block', []string{}, &this), 'attributes')]))
		}
		return rt.get_property(rt.new_object('WP_Block', []string{}, &this), 'attributes')
	}
	return rt.new_null()
}

fn (mut this Class_WP_Block) process_block_bindings() rt.PhpVal {
	mut var_block_type := this.name
	mut var_parsed_block := this.parsed_block
	mut var_computed_attributes := rt.new_array()
	mut var_supported_block_attributes := rt.call_function('get_block_bindings_supported_attributes', [var_block_type.clone()])
	if !rt.is_true(var_supported_block_attributes) || !rt.is_true(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata')).array_get(rt.new_string('bindings'))) || !(var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata')).array_get(rt.new_string('bindings')).is_array()) {
		return var_computed_attributes.clone()
	}
	mut var_bindings := var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata')).array_get(rt.new_string('bindings'))
	if var_bindings.array_get(rt.new_string('__default')).array_isset(rt.new_string('source')) && rt.is_true(rt.identical(rt.new_string('core/pattern-overrides'), var_bindings.array_get(rt.new_string('__default')).array_get(rt.new_string('source')))) {
		mut var_updated_bindings := rt.new_array()
		mut iter_3 := var_supported_block_attributes.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_attribute_name := item_3.val
			var_updated_bindings.array_set(var_attribute_name, if !(var_bindings.array_get(var_attribute_name)).is_null() { var_bindings.array_get(var_attribute_name) } else { rt.create_array([rt.ArrayItem{ key: 'source', val: 'core/pattern-overrides' }]) })
		}
		var_bindings = var_updated_bindings.clone()
		var_computed_attributes.array_set('metadata', rt.call_function('array_merge', [var_parsed_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('metadata')), rt.create_array([rt.ArrayItem{ key: 'bindings', val: var_bindings }])]))
	}
	mut iter_4 := var_bindings.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_block_binding := item_4.val
		mut var_attribute_name := item_4.key
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_attribute_name.clone(), var_supported_block_attributes.clone(), rt.new_bool(true)]))))) {
			continue
		}
		if !(var_block_binding.array_isset(rt.new_string('source'))) || !(var_block_binding.array_get(rt.new_string('source')).is_string()) {
			continue
		}
		mut var_block_binding_source := rt.call_function('get_block_bindings_source', [var_block_binding.array_get(rt.new_string('source'))])
		if rt.is_true(rt.identical(rt.new_null(), var_block_binding_source)) {
			continue
		}
		if !(!rt.is_true(rt.get_property(var_block_binding_source, 'uses_context'))) {
			mut iter_5 := rt.get_property(var_block_binding_source, 'uses_context').iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_context_name := item_5.val
				if rt.is_true(rt.new_bool(this.available_context.array_isset(var_context_name.clone()))) {
					this.context.array_set(var_context_name, this.available_context.array_get(var_context_name))
				}
			}
		}
		mut var_source_args := if !(!rt.is_true(var_block_binding.array_get(rt.new_string('args')))) && var_block_binding.array_get(rt.new_string('args')).is_array() { var_block_binding.array_get(rt.new_string('args')) } else { rt.new_array() }
		mut var_source_value := rt.call_method(var_block_binding_source, 'get_value', [var_source_args.clone(), rt.new_object('WP_Block', []string{}, &this), var_attribute_name.clone()])
		if !(var_source_value.clone().is_null()) {
			var_computed_attributes.array_set(var_attribute_name, var_source_value.clone())
		}
	}
	return var_computed_attributes.clone()
}

fn (mut this Class_WP_Block) replace_html(block_content string, attribute_name string, var_source_value rt.PhpVal) rt.PhpVal {
	mut block_content_mutated := block_content
	mut var_source_value_mutated := var_source_value
	mut var_block_type := this.block_type
	if !(rt.get_property(var_block_type, 'attributes').array_get(rt.new_string(attribute_name)).array_isset(rt.new_string('source'))) {
		return rt.new_string(block_content_mutated)
	}
	mut switch_val_1 := rt.get_property(var_block_type, 'attributes').array_get(rt.new_string(attribute_name)).array_get(rt.new_string('source'))
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('html'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('rich-text'))) {
		mut var_block_reader := Class_WP_Block.get_block_bindings_processor(block_content_mutated)
		mut var_selectors := rt.call_function('explode', [rt.new_string(','), rt.get_property(var_block_type, 'attributes').array_get(rt.new_string(attribute_name)).array_get(rt.new_string('selector'))])
		rt.call_method(var_block_reader, 'next_tag', []rt.PhpVal{})
		rt.call_method(var_block_reader, 'set_bookmark', [rt.new_string('iterate-selectors')])
		mut iter_6 := var_selectors.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_selector := item_6.val
			if rt.is_true(rt.identical(rt.call_function('strcasecmp', [rt.call_method(var_block_reader, 'get_tag', []rt.PhpVal{}), var_selector.clone()]), rt.new_int(0))) || rt.is_true(rt.call_method(var_block_reader, 'next_tag', [rt.create_array([rt.ArrayItem{ key: 'tag_name', val: var_selector }])])) {
				rt.call_method(var_block_reader, 'release_bookmark', [rt.new_string('iterate-selectors')])
				rt.call_method(var_block_reader, 'replace_rich_text', [rt.call_function('wp_kses_post', [var_source_value_mutated.clone()])])
				return rt.call_method(var_block_reader, 'get_updated_html', []rt.PhpVal{})
			} else {
				rt.call_method(var_block_reader, 'seek', [rt.new_string('iterate-selectors')])
			}
		}
		rt.call_method(var_block_reader, 'release_bookmark', [rt.new_string('iterate-selectors')])
		return rt.new_string(block_content_mutated)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('attribute'))) {
		mut var_amended_content := create_wp_html_tag_processor(rt.new_string(block_content_mutated).clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_amended_content.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_name', val: rt.get_property(var_block_type, 'attributes').array_get(rt.new_string(attribute_name)).array_get(rt.new_string('selector')) }])))))) {
			return rt.new_string(block_content_mutated)
		}
		var_amended_content.set_attribute(rt.get_property(var_block_type, 'attributes').array_get(rt.new_string(attribute_name)).array_get(rt.new_string('attribute')), var_source_value_mutated.clone())
		return var_amended_content.get_updated_html()
	} else {
		return rt.new_string(block_content_mutated)
	}
	return rt.new_null()
}

fn Class_WP_Block.get_block_bindings_processor(block_content string) rt.PhpVal {
	mut block_content_mutated := block_content
	mut var_internal_processor_class := rt.create_object_dynamically(rt.new_null(), [rt.new_string(''), Class_WP_HTML_Processor.constructor_unlock_code()])
	mut iife_temp_1 := Class_{"nodeType":"Expr_Variable","line":474,"name":"internal_processor_class"}{}
	mut iife_result_1 := iife_temp_1.create_fragment(rt.new_string(block_content_mutated))
	return iife_result_1
}

fn (mut this Class_WP_Block) render(var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	mut var_post := rt.get_superglobal('post')
	mut var_before_wp_enqueue_scripts_count := rt.call_function('did_action', [rt.new_string('wp_enqueue_scripts')])
	mut var_before_styles_queue := rt.get_property(rt.call_function('wp_styles', []rt.PhpVal{}), 'queue')
	mut var_before_scripts_queue := rt.get_property(rt.call_function('wp_scripts', []rt.PhpVal{}), 'queue')
	mut var_before_script_modules_queue := rt.call_method(rt.call_function('wp_script_modules', []rt.PhpVal{}), 'get_queue', []rt.PhpVal{})
	mut var_root_interactive_block := rt.new_null()
	mut var_interactivity_process_directives_enabled := rt.call_function('apply_filters', [rt.new_string('interactivity_process_directives'), rt.new_bool(true)])
	if rt.is_true(var_interactivity_process_directives_enabled) && rt.is_true(rt.identical(rt.new_null(), var_root_interactive_block)) && (rt.get_property(this.block_type, 'supports').array_isset(rt.new_string('interactivity')) && rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(this.block_type, 'supports').array_get(rt.new_string('interactivity'))))) || !(!rt.is_true(rt.get_property(this.block_type, 'supports').array_get(rt.new_string('interactivity')).array_get(rt.new_string('interactive')))) {
	var_root_interactive_block = rt.new_object('WP_Block', []string{}, &this)
	}
	var_options_mutated = rt.call_function('wp_parse_args', [var_options_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'dynamic', val: true }])])
	mut var_computed_attributes := this.process_block_bindings()
	if !(!rt.is_true(var_computed_attributes)) {
		this.dispatch_set_prop('attributes', rt.call_function('array_merge', [rt.get_property(rt.new_object('WP_Block', []string{}, &this), 'attributes'), var_computed_attributes.clone()]))
	}
	mut var_is_dynamic := rt.new_bool(rt.is_true(var_options_mutated.array_get(rt.new_string('dynamic'))) && rt.is_true(this.name) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), this.block_type)))) && rt.is_true(rt.call_method(this.block_type, 'is_dynamic', []rt.PhpVal{})))
	mut var_block_content := rt.new_string('')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_options_mutated.array_get(rt.new_string('dynamic')))))) || !rt.is_true(rt.get_property(this.block_type, 'skip_inner_blocks')) {
		mut var_index := rt.new_int(0)
		mut iter_7 := this.inner_content.iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_chunk := item_7.val
			if rt.is_true(rt.new_bool(var_chunk.clone().is_string())) {
				var_block_content = rt.concat(var_block_content, var_chunk)
			} else {
				mut var_inner_block := this.inner_blocks.array_get(var_index)
				mut var_parent_block := rt.new_object('WP_Block', []string{}, &this)
				mut var_pre_render := rt.call_function('apply_filters', [rt.new_string('pre_render_block'), rt.new_null(), rt.get_property(var_inner_block, 'parsed_block'), var_parent_block.clone()])
				if !(var_pre_render.clone().is_null()) {
					var_block_content = rt.concat(var_block_content, var_pre_render)
				} else {
					mut var_source_block := rt.get_property(var_inner_block, 'parsed_block')
					mut var_inner_block_context := rt.get_property(var_inner_block, 'context')
					rt.set_property(var_inner_block, 'parsed_block', rt.call_function('apply_filters', [rt.new_string('render_block_data'), rt.get_property(var_inner_block, 'parsed_block'), var_source_block.clone(), var_parent_block.clone()]))
					rt.set_property(var_inner_block, 'context', rt.call_function('apply_filters', [rt.new_string('render_block_context'), rt.get_property(var_inner_block, 'context'), rt.get_property(var_inner_block, 'parsed_block'), var_parent_block.clone()]))
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_inner_block, 'context'), var_inner_block_context)))) {
						rt.call_method(var_inner_block, 'refresh_context_dependents', []rt.PhpVal{})
					} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_inner_block, 'parsed_block'), var_source_block)))) {
						rt.call_method(var_inner_block, 'refresh_parsed_block_dependents', []rt.PhpVal{})
					}
					var_block_content = rt.concat(var_block_content, rt.call_method(var_inner_block, 'render', []rt.PhpVal{}))
				}
				rt.pre_inc(var_index)
			}
		}
	}
	if !(!rt.is_true(var_computed_attributes)) && !(!rt.is_true(var_block_content)) {
		mut iter_8 := var_computed_attributes.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_source_value := item_8.val
			mut var_attribute_name := item_8.key
		var_block_content = this.replace_html((var_block_content).str(), (var_attribute_name).str(), var_source_value.clone())
		}
	}
	if rt.is_true(var_is_dynamic) {
		mut var_global_post := var_post.clone()
		mut var_parent := rt.get_static_prop('WP_Block_Supports', 'block_to_render')
		rt.set_static_prop('WP_Block_Supports', 'block_to_render', this.parsed_block)
		var_block_content = rt.new_string((rt.call_function('call_user_func', [rt.get_property(this.block_type, 'render_callback'), rt.get_property(rt.new_object('WP_Block', []string{}, &this), 'attributes'), var_block_content.clone(), rt.new_object('WP_Block', []string{}, &this)])).str())
		rt.set_static_prop('WP_Block_Supports', 'block_to_render', var_parent.clone())
	var_post = var_global_post.clone()
	}
	if !(!rt.is_true(rt.get_property(this.block_type, 'script_handles'))) {
		mut iter_9 := rt.get_property(this.block_type, 'script_handles').iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_script_handle := item_9.val
			rt.call_function('wp_enqueue_script', [var_script_handle.clone()])
		}
	}
	if !(!rt.is_true(rt.get_property(this.block_type, 'view_script_handles'))) {
		mut iter_10 := rt.get_property(this.block_type, 'view_script_handles').iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_view_script_handle := item_10.val
			rt.call_function('wp_enqueue_script', [var_view_script_handle.clone()])
		}
	}
	if !(!rt.is_true(rt.get_property(this.block_type, 'view_script_module_ids'))) {
		mut iter_11 := rt.get_property(this.block_type, 'view_script_module_ids').iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_view_script_module_id := item_11.val
			rt.call_function('wp_enqueue_script_module', [var_view_script_module_id.clone()])
		}
	}
	if !(!rt.is_true(rt.get_property(this.block_type, 'style_handles'))) {
		mut iter_12 := rt.get_property(this.block_type, 'style_handles').iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_style_handle := item_12.val
			rt.call_function('wp_enqueue_style', [var_style_handle.clone()])
		}
	}
	if !(!rt.is_true(rt.get_property(this.block_type, 'view_style_handles'))) {
		mut iter_13 := rt.get_property(this.block_type, 'view_style_handles').iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_view_style_handle := item_13.val
			rt.call_function('wp_enqueue_style', [var_view_style_handle.clone()])
		}
	}
	var_block_content = rt.call_function('apply_filters', [rt.new_string('render_block'), var_block_content.clone(), this.parsed_block, rt.new_object('WP_Block', []string{}, &this)])
	var_block_content = rt.call_function('apply_filters', [rt.concat(rt.new_string('render_block_'), this.name), var_block_content.clone(), this.parsed_block, rt.new_object('WP_Block', []string{}, &this)])
	if rt.is_true(rt.identical(var_root_interactive_block, rt.new_object('WP_Block', []string{}, &this))) {
	var_block_content = rt.call_function('wp_interactivity_process_directives', [var_block_content.clone()])
	var_root_interactive_block = rt.new_null()
	}
	mut var_after_styles_queue := rt.get_property(rt.call_function('wp_styles', []rt.PhpVal{}), 'queue')
	mut var_after_scripts_queue := rt.get_property(rt.call_function('wp_scripts', []rt.PhpVal{}), 'queue')
	mut var_after_script_modules_queue := rt.call_method(rt.call_function('wp_script_modules', []rt.PhpVal{}), 'get_queue', []rt.PhpVal{})
	mut var_just_did_wp_enqueue_scripts := rt.new_bool(!rt.is_true(rt.identical(rt.call_function('did_action', [rt.new_string('wp_enqueue_scripts')]), var_before_wp_enqueue_scripts_count)))
	mut var_has_new_styles := rt.new_bool(!rt.is_true(rt.identical(var_before_styles_queue, var_after_styles_queue)))
	mut var_has_new_scripts := rt.new_bool(!rt.is_true(rt.identical(var_before_scripts_queue, var_after_scripts_queue)))
	mut var_has_new_script_modules := rt.new_bool(!rt.is_true(rt.identical(var_before_script_modules_queue, var_after_script_modules_queue)))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_just_did_wp_enqueue_scripts)))) && rt.is_true(var_has_new_styles) || rt.is_true(var_has_new_scripts) || rt.is_true(var_has_new_script_modules) && rt.is_true(rt.identical(rt.new_string(var_block_content.clone().to_string().trim_space()), rt.new_string(''))) && rt.is_true(rt.new_bool(!(rt.is_true((rt.call_function('apply_filters', [rt.new_string('enqueue_empty_block_content_assets'), rt.new_bool(false), this.name])).to_bool())))) {
		mut iter_14 := rt.call_function('array_diff', [var_after_styles_queue.clone(), var_before_styles_queue.clone()]).iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_handle := item_14.val
			rt.call_function('wp_dequeue_style', [var_handle.clone()])
		}
		mut iter_15 := rt.call_function('array_diff', [var_after_scripts_queue.clone(), var_before_scripts_queue.clone()]).iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_handle := item_15.val
			rt.call_function('wp_dequeue_script', [var_handle.clone()])
		}
		mut iter_16 := rt.call_function('array_diff', [var_after_script_modules_queue.clone(), var_before_script_modules_queue.clone()]).iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_handle := item_16.val
			rt.call_function('wp_dequeue_script_module', [var_handle.clone()])
		}
	}
	return var_block_content.clone()
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

struct Class_WP_Block_List {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_{"nodeType":"Expr_Variable","line":474,"name":"internal_processor_class"} {
	rt.PhpObjectBase
}

fn create_wp_block(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Block {
	mut obj := &Class_WP_Block{
		PhpObjectBase: rt.PhpObjectBase{}
		parsed_block: rt.new_null()
		name: rt.new_null()
		block_type: rt.new_null()
		context: rt.new_array()
		available_context: rt.new_array()
		registry: rt.new_null()
		inner_blocks: rt.new_array()
		inner_html: rt.new_string('')
		inner_content: rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_list(_args ...rt.PhpVal) &Class_WP_Block_List {
	mut obj := &Class_WP_Block_List{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_{"nodetype":"expr_variable","line":474,"name":"internal_processor_class"}(_args ...rt.PhpVal) &Class_{"nodeType":"Expr_Variable","line":474,"name":"internal_processor_class"} {
	mut obj := &Class_{"nodeType":"Expr_Variable","line":474,"name":"internal_processor_class"}{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'refresh_context_dependents' {
			this.refresh_context_dependents()
			return rt.new_null()
		}
		'refresh_parsed_block_dependents' {
			this.refresh_parsed_block_dependents()
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'process_block_bindings' {
			return this.process_block_bindings()
		}
		'replace_html' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.replace_html(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_block_bindings_processor' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_WP_Block.get_block_bindings_processor(dispatch_arg_0)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'parsed_block' { return this.parsed_block }
		'name' { return this.name }
		'block_type' { return this.block_type }
		'context' { return this.context }
		'available_context' { return this.available_context }
		'registry' { return this.registry }
		'inner_blocks' { return this.inner_blocks }
		'inner_html' { return this.inner_html }
		'inner_content' { return this.inner_content }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'parsed_block' { this.parsed_block = val; return true }
		'name' { this.name = val; return true }
		'block_type' { this.block_type = val; return true }
		'context' { this.context = val; return true }
		'available_context' { this.available_context = val; return true }
		'registry' { this.registry = val; return true }
		'inner_blocks' { this.inner_blocks = val; return true }
		'inner_html' { this.inner_html = val; return true }
		'inner_content' { this.inner_content = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Block_List) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_List) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_List) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_{"nodeType":"Expr_Variable","line":474,"name":"internal_processor_class"}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_{"nodeType":"Expr_Variable","line":474,"name":"internal_processor_class"}) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_{"nodeType":"Expr_Variable","line":474,"name":"internal_processor_class"}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WP_Block', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		c_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		c_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		obj := create_wp_block(c_arg_0, c_arg_1, c_arg_2)
		return rt.new_object('WP_Block', []string{}, obj)
	})
	rt.register_class_factory('WP_Block_Type_Registry', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_block_type_registry()
		return rt.new_object('WP_Block_Type_Registry', []string{}, obj)
	})
	rt.register_class_factory('WP_Block_List', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_block_list()
		return rt.new_object('WP_Block_List', []string{}, obj)
	})
	rt.register_class_factory('WP_HTML_Tag_Processor', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_html_tag_processor()
		return rt.new_object('WP_HTML_Tag_Processor', []string{}, obj)
	})
	rt.register_class_factory('{"nodeType":"Expr_Variable","line":474,"name":"internal_processor_class"}', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_{"nodetype":"expr_variable","line":474,"name":"internal_processor_class"}()
		return rt.new_object('{"nodeType":"Expr_Variable","line":474,"name":"internal_processor_class"}', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
