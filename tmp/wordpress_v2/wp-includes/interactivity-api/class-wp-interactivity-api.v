import rt

struct Class_WP_Interactivity_API {
	rt.PhpObjectBase
pub mut:
		state_data rt.PhpVal = rt.new_array()
		config_data rt.PhpVal = rt.new_array()
		derived_state_closures rt.PhpVal = rt.new_array()
		has_processed_router_region bool
		script_modules_that_can_load_on_client_navigation rt.PhpVal = rt.new_array()
		namespace_stack rt.PhpVal = rt.new_null()
		context_stack rt.PhpVal = rt.new_null()
		current_element rt.PhpVal = rt.new_null()
}

fn init_static_wp_interactivity_api() {
		rt.init_static_prop('WP_Interactivity_API', 'directive_processors', rt.create_array([rt.ArrayItem{ key: 'data-wp-interactive', val: 'data_wp_interactive_processor' }, rt.ArrayItem{ key: 'data-wp-router-region', val: 'data_wp_router_region_processor' }, rt.ArrayItem{ key: 'data-wp-context', val: 'data_wp_context_processor' }, rt.ArrayItem{ key: 'data-wp-bind', val: 'data_wp_bind_processor' }, rt.ArrayItem{ key: 'data-wp-class', val: 'data_wp_class_processor' }, rt.ArrayItem{ key: 'data-wp-style', val: 'data_wp_style_processor' }, rt.ArrayItem{ key: 'data-wp-text', val: 'data_wp_text_processor' }, rt.ArrayItem{ key: 'data-wp-each', val: 'data_wp_each_processor' }]))
}

fn (mut this Class_WP_Interactivity_API) state(mut var_store_namespace Class_?string, mut var_state Class_?array) rt.PhpVal {
	mut var_store_namespace_mutated := var_store_namespace
	mut var_state_mutated := var_state
	if rt.is_true(rt.new_bool(!(rt.is_true(var_store_namespace_mutated)))) {
		if rt.is_true(var_state_mutated) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The namespace is required when state data is passed.')]), rt.new_string('6.6.0')])
			return rt.new_array()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_store_namespace_mutated)))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The namespace should be a non-empty string.')]), rt.new_string('6.6.0')])
			return rt.new_array()
		}
		if rt.is_true(rt.identical(rt.new_null(), this.namespace_stack)) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The namespace can only be omitted during directive processing.')]), rt.new_string('6.6.0')])
			return rt.new_array()
		}
	var_store_namespace_mutated = rt.call_function('end', [this.namespace_stack])
	}
	if !(this.state_data.array_isset(var_store_namespace_mutated)) {
		this.state_data.array_set(var_store_namespace_mutated, rt.new_array())
	}
	if rt.is_true(rt.new_bool(var_state_mutated.is_array())) {
		this.state_data.array_set(var_store_namespace_mutated, rt.call_function('array_replace_recursive', [this.state_data.array_get(var_store_namespace_mutated), var_state_mutated]))
	}
	return this.state_data.array_get(var_store_namespace_mutated)
}

fn (mut this Class_WP_Interactivity_API) config(store_namespace string, mut var_config Class_array) rt.PhpVal {
	mut store_namespace_mutated := store_namespace
	mut var_config_mutated := var_config
	if !(this.config_data.array_isset(rt.new_string(store_namespace_mutated))) {
		this.config_data.array_set(store_namespace_mutated, rt.new_array())
	}
	if rt.is_true(rt.new_bool(var_config_mutated.is_array())) {
		this.config_data.array_set(store_namespace_mutated, rt.call_function('array_replace_recursive', [this.config_data.array_get(rt.new_string(store_namespace_mutated)), var_config_mutated]))
	}
	return this.config_data.array_get(rt.new_string(store_namespace_mutated))
}

fn (mut this Class_WP_Interactivity_API) print_client_interactivity_data() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('6.7.0')])
}

fn (mut this Class_WP_Interactivity_API) filter_script_module_interactivity_router_data(mut var_data Class_array) rt.PhpVal {
	mut var_data_mutated := var_data
	if !(var_data_mutated.array_isset(rt.new_string('i18n'))) {
		var_data_mutated.array_set('i18n', rt.new_array())
	}
	var_data_mutated.array_get_mut('i18n').array_set('loading', rt.call_function('__', [rt.new_string('Loading page, please wait.')]))
	var_data_mutated.array_get_mut('i18n').array_set('loaded', rt.call_function('__', [rt.new_string('Page Loaded.')]))
	return rt.new_object('array', []string{}, var_data_mutated)
}

fn (mut this Class_WP_Interactivity_API) filter_script_module_interactivity_data(mut var_data Class_array) rt.PhpVal {
	mut var_data_mutated := var_data
	if !rt.is_true(this.state_data) && !rt.is_true(this.config_data) && !rt.is_true(this.derived_state_closures) {
		return rt.new_object('array', []string{}, var_data_mutated)
	}
	mut var_config := rt.new_array()
	mut iter_1 := this.config_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		if !(!rt.is_true(var_value)) {
			var_config.array_set(var_key, var_value.clone())
		}
	}
	if !(!rt.is_true(var_config)) {
		var_data_mutated.array_set('config', var_config.clone())
	}
	mut var_state := rt.new_array()
	mut iter_2 := this.state_data.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_value := item_2.val
		mut var_key := item_2.key
		if !(!rt.is_true(var_value)) {
			var_state.array_set(var_key, var_value.clone())
		}
	}
	if !(!rt.is_true(var_state)) {
		var_data_mutated.array_set('state', var_state.clone())
	}
	mut var_derived_props := rt.new_array()
	mut iter_3 := this.derived_state_closures.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		if !(!rt.is_true(var_value)) {
			var_derived_props.array_set(var_key, var_value.clone())
		}
	}
	if !(!rt.is_true(var_derived_props)) {
		var_data_mutated.array_set('derivedStateClosures', var_derived_props.clone())
	}
	return rt.new_object('array', []string{}, var_data_mutated)
}

fn (mut this Class_WP_Interactivity_API) get_context(mut var_store_namespace Class_?string) rt.PhpVal {
	mut var_store_namespace_mutated := var_store_namespace
	if rt.is_true(rt.identical(rt.new_null(), this.context_stack)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The context can only be read during directive processing.')]), rt.new_string('6.6.0')])
		return rt.new_array()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_store_namespace_mutated)))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_store_namespace_mutated)))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The namespace should be a non-empty string.')]), rt.new_string('6.6.0')])
			return rt.new_array()
		}
	var_store_namespace_mutated = rt.call_function('end', [this.namespace_stack])
	}
	mut var_context := rt.call_function('end', [this.context_stack])
	return if rt.is_true(var_store_namespace_mutated) && rt.is_true(var_context) && var_context.array_isset(var_store_namespace_mutated) { var_context.array_get(var_store_namespace_mutated) } else { rt.new_array() }
}

fn (mut this Class_WP_Interactivity_API) get_element() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.current_element)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The element can only be read during directive processing.')]), rt.new_string('6.7.0')])
	}
	return this.current_element
}

fn (mut this Class_WP_Interactivity_API) register_script_modules() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('6.7.0'), rt.new_string('wp_default_script_modules')])
}

fn (mut this Class_WP_Interactivity_API) add_hooks() {
	rt.call_function('add_filter', [rt.new_string('script_module_data_@wordpress/interactivity'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Interactivity_API', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_script_module_interactivity_data' }])])
	rt.call_function('add_filter', [rt.new_string('script_module_data_@wordpress/interactivity-router'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Interactivity_API', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_script_module_interactivity_router_data' }])])
	rt.call_function('add_filter', [rt.new_string('wp_script_attributes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Interactivity_API', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_load_on_client_navigation_attribute_to_script_modules' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_WP_Interactivity_API) add_load_on_client_navigation_attribute_to_script_modules(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	if var_attributes_mutated.clone().is_array() && var_attributes_mutated.array_isset(rt.new_string('type')) && var_attributes_mutated.array_isset(rt.new_string('id')) && rt.is_true(rt.identical(rt.new_string('module'), var_attributes_mutated.array_get(rt.new_string('type')))) && rt.is_true(rt.new_bool(this.script_modules_that_can_load_on_client_navigation.array_isset(rt.call_function('preg_replace', [rt.new_string('/-js-module$/'), rt.new_string(''), var_attributes_mutated.array_get(rt.new_string('id'))])))) {
		var_attributes_mutated.array_set('data-wp-router-options', rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'loadOnClientNavigation', val: true }])]))
	}
	return var_attributes_mutated.clone()
}

fn (mut this Class_WP_Interactivity_API) add_client_navigation_support_to_script_module(script_module_id string) {
	this.script_modules_that_can_load_on_client_navigation.array_set(script_module_id, true)
}

fn (mut this Class_WP_Interactivity_API) process_directives(html string) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [rt.new_string(html), rt.new_string('data-wp-')]))))) {
		return html
	}
	this.namespace_stack = rt.new_array()
	this.context_stack = rt.new_array()
	mut var_result := this._process_directives(html)
	this.namespace_stack = rt.new_null()
	this.context_stack = rt.new_null()
	return (if !(var_result).is_null() { var_result } else { rt.new_string(html) }).str()
}

fn (mut this Class_WP_Interactivity_API) _process_directives(html string) rt.PhpVal {
	mut var_opening_tag_name := rt.new_null()
	mut var_p := create_wp_interactivity_api_directives_processor(rt.new_string(html))
	mut var_tag_stack := rt.new_array()
	mut var_unbalanced := rt.new_bool(false)
	mut var_directive_processor_prefixes := rt.func_array_keys(rt.get_static_prop('WP_Interactivity_API', 'directive_processors'))
	mut var_directive_processor_prefixes_reversed := rt.call_function('array_reverse', [var_directive_processor_prefixes.clone()])
	mut var_namespace_stack_size := rt.new_int(this.namespace_stack.array_count())
	mut var_context_stack_size := rt.new_int(this.context_stack.array_count())
	for rt.is_true(var_p.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_closers', val: 'visit' }]))) {
		mut var_tag_name := var_p.get_tag()
		if rt.is_true(rt.identical(rt.new_string('SVG'), var_tag_name)) || rt.is_true(rt.identical(rt.new_string('MATH'), var_tag_name)) {
			if rt.is_true(var_p.get_attribute_names_with_prefix(rt.new_string('data-wp-'))) {
				mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Interactivity directives were detected on an incompatible %1$s tag when processing "%2$s". These directives will be ignored in the server side render.')]), var_tag_name.clone(), rt.call_function('end', [this.namespace_stack])])
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), var_message.clone(), rt.new_string('6.6.0')])
			}
			var_p.skip_to_tag_closer()
			continue
		}
		if rt.is_true(var_p.is_tag_closer()) {
			mut list_tmp_1 := if !(!rt.is_true(var_tag_stack)) { rt.call_function('end', [rt.create_array_from_list(var_tag_stack)]) } else { rt.create_array([rt.ArrayItem{ key: none, val: rt.new_null() }, rt.ArrayItem{ key: none, val: rt.new_null() }]) }
			var_opening_tag_name = (list_tmp_1).array_get(0)
			mut var_directives_prefixes := (list_tmp_1).array_get(1)
			if 0 == var_tag_stack.len || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_opening_tag_name, var_tag_name)))) {
				var_unbalanced = rt.new_bool(true)
				break
			} else {
				rt.call_function('array_pop', [rt.create_array_from_list(var_tag_stack)])
			}
		} else {
			mut var_each_child_attrs := var_p.get_attribute_names_with_prefix(rt.new_string('data-wp-each-child'))
			if rt.is_true(rt.identical(rt.new_null(), var_each_child_attrs)) {
				continue
			}
			if rt.is_true(rt.new_bool(0 != var_each_child_attrs.clone().array_count())) {
				var_p.next_balanced_tag_closer_tag()
				continue
			} else {
				var_directives_prefixes = rt.new_array()
				mut iter_4 := var_p.get_attribute_names_with_prefix(rt.new_string('data-wp-')).iterator()
				for {
					item_4 := iter_4.next() or { break }
					mut var_attribute_name := item_4.val
					mut var_parsed_directive := this.parse_directive_name((var_attribute_name).str())
					if !rt.is_true(var_parsed_directive) {
						continue
					}
					mut var_directive_prefix := rt.new_string('data-wp-' + (var_parsed_directive.array_get(rt.new_string('prefix'))).str())
					if rt.is_true(rt.new_bool(rt.get_static_prop('WP_Interactivity_API', 'directive_processors').array_isset(var_directive_prefix.clone()))) {
						var_directives_prefixes << var_directive_prefix.clone()
					}
				}
				if rt.is_true(var_p.has_and_visits_its_closer_tag()) {
					var_tag_stack << rt.create_array([rt.ArrayItem{ key: none, val: var_tag_name }, rt.ArrayItem{ key: none, val: var_directives_prefixes }])
				}
			}
		}
		if 0 == var_directives_prefixes.len {
			continue
		}
		mut var_modes := { 'enter': !(rt.is_true(var_p.is_tag_closer())), 'exit': rt.is_true(var_p.is_tag_closer()) || rt.is_true(rt.new_bool(!(rt.is_true(var_p.has_and_visits_its_closer_tag())))) }
		mut var_element_attrs := rt.new_array()
		mut var_attr_names := if !(var_p.get_attribute_names_with_prefix(rt.new_string(''))).is_null() { var_p.get_attribute_names_with_prefix(rt.new_string('')) } else { rt.new_array() }
		mut iter_5 := var_attr_names.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_name := item_5.val
			var_element_attrs.array_set(var_name, var_p.get_attribute(var_name.clone()))
		}
		this.current_element = rt.create_array([rt.ArrayItem{ key: 'attributes', val: var_element_attrs }])
		for var_mode, var_should_run in var_modes {
			if !(var_should_run) {
				continue
			}
			mut var_existing_directives_prefixes := rt.call_function('array_intersect', [if rt.is_true(rt.identical(rt.new_string('enter'), rt.new_string(mode))) { var_directive_processor_prefixes } else { var_directive_processor_prefixes_reversed }, rt.create_array_from_list(var_directives_prefixes)])
			mut iter_6 := var_existing_directives_prefixes.iterator()
			for {
				item_6 := iter_6.next() or { break }
				mut var_directive_prefix := item_6.val
				mut var_func := if rt.get_static_prop('WP_Interactivity_API', 'directive_processors').array_get(var_directive_prefix).is_array() { rt.get_static_prop('WP_Interactivity_API', 'directive_processors').array_get(var_directive_prefix) } else { rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Interactivity_API', []string{}, &this) }, rt.ArrayItem{ key: none, val: rt.get_static_prop('WP_Interactivity_API', 'directive_processors').array_get(var_directive_prefix) }]) }
				rt.call_function('call_user_func_array', [var_func.clone(), rt.create_array([rt.ArrayItem{ key: none, val: var_p }, rt.ArrayItem{ key: none, val: mode }, rt.ArrayItem{ key: none, val: var_tag_stack }])])
			}
		}
		this.current_element = rt.new_null()
	}
	if rt.is_true(var_unbalanced) {
		rt.call_function('array_splice', [this.namespace_stack, var_namespace_stack_size.clone()])
		rt.call_function('array_splice', [this.context_stack, var_context_stack_size.clone()])
	}
	if rt.is_true(var_unbalanced) || 0 < var_tag_stack.len {
		return rt.new_null()
	}
	return var_p.get_updated_html()
}

fn (mut this Class_WP_Interactivity_API) evaluate(var_entry rt.PhpVal) rt.PhpVal {
	mut var_ns := rt.new_null()
	mut var_entry_mutated := var_entry
	mut var_context := rt.call_function('end', [this.context_stack])
	mut list_tmp_2 := var_entry_mutated
	var_ns = (list_tmp_2).array_get(0)
	mut var_path := (list_tmp_2).array_get(1)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ns)))) || rt.is_true(rt.new_bool(!(rt.is_true(var_path)))) {
		mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Namespace or reference path cannot be empty. Directive value referenced: %s')]), rt.new_string(rt.json_encode(var_entry_mutated.clone()))])
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), var_message.clone(), rt.new_string('6.6.0')])
		return rt.new_null()
	}
	mut var_store := { 'state': if !(this.state_data.array_get(var_ns)).is_null() { this.state_data.array_get(var_ns) } else { rt.new_array() }, 'context': if !(var_context.array_get(var_ns)).is_null() { var_context.array_get(var_ns) } else { rt.new_array() } }
	mut var_should_negate_value := rt.identical(rt.new_string('!'), var_path.array_get(rt.new_int(0)))
	var_path = if rt.is_true(var_should_negate_value) { rt.call_function('substr', [var_path.clone(), rt.new_int(1)]) } else { var_path }
	mut var_path_segments := rt.call_function('explode', [rt.new_string('.'), var_path.clone()])
	mut var_current := var_store.clone()
	mut iter_7 := var_path_segments.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_path_segment := item_7.val
		mut var_index := item_7.key
		if rt.is_true(rt.identical(rt.new_string('length'), var_path_segment)) {
			if var_current.clone().is_array() && rt.is_true(rt.call_function('array_is_list', [var_current.clone()])) {
				var_current = rt.new_int(var_current.clone().array_count())
				break
			}
			if rt.is_true(rt.new_bool(var_current.clone().is_string())) {
				var_current = rt.new_int(var_current.clone().to_string().len)
				break
			}
		}
		if var_current.clone().is_array() || rt.is_true(rt.new_bool(rt.instance_of(var_current, 'ArrayAccess'))) && var_current.array_isset(var_path_segment) {
		var_current = var_current.array_get(var_path_segment)
		} else if var_current.clone().is_object() && !(rt.get_property(var_current, '{"nodeType":"Expr_Variable","line":700,"name":"path_segment"}')).is_null() {
		var_current = rt.get_property(var_current, '{"nodeType":"Expr_Variable","line":701,"name":"path_segment"}')
		} else {
			var_current = rt.new_null()
			break
		}
		if rt.is_true(rt.new_bool(rt.instance_of(var_current, 'Closure'))) {
			this.namespace_stack.array_push(var_ns.clone())
			var_current = rt.call_callable(var_current, []rt.PhpVal{})
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			this.derived_state_closures.array_set(var_ns, if !(this.derived_state_closures.array_get(var_ns)).is_null() { this.derived_state_closures.array_get(var_ns) } else { rt.new_array() })
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			mut var_current_path := rt.call_function('implode', [rt.new_string('.'), rt.call_function('array_slice', [var_path_segments.clone(), rt.new_int(0), rt.add(var_index, rt.new_int(1))])])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_current_path.clone(), this.derived_state_closures.array_get(var_ns), rt.new_bool(true)]))))) {
				this.derived_state_closures.array_get_mut(var_ns).array_push(var_current_path.clone())
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto finally_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Throwable') {
				mut var_e := var_e_1.clone()
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Uncaught error executing a derived state callback with path "%1$s" and namespace "%2$s".')]), var_path.clone(), var_ns.clone()]), rt.new_string('6.6.0')])
				return rt.new_null()
				unsafe { goto finally_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto finally_label_1 }
			}

finally_label_1:
			rt.call_function('array_pop', [this.namespace_stack])
			if rt.has_exception() { return rt.new_null() }

end_label_1:
		}
	}
	return if rt.is_true(var_should_negate_value) { rt.new_bool(!(rt.is_true(var_current))) } else { var_current }
}

fn (mut this Class_WP_Interactivity_API) parse_directive_name(directive_name string) rt.PhpVal {
	mut var_name := rt.call_function('substr', [rt.new_string(directive_name), rt.new_int(8)])
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/[^a-z0-9\\-_]/i'), var_name.clone()])) {
		return rt.new_null()
	}
	mut var_suffix_index := rt.call_function('strpos', [var_name.clone(), rt.new_string('--')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_suffix_index)) {
		return rt.create_array([rt.ArrayItem{ key: 'prefix', val: var_name }, rt.ArrayItem{ key: 'suffix', val: rt.new_null() }, rt.ArrayItem{ key: 'unique_id', val: rt.new_null() }])
	}
	mut var_prefix := rt.call_function('substr', [var_name.clone(), rt.new_int(0), var_suffix_index.clone()])
	mut var_remaining := rt.call_function('substr', [var_name.clone(), var_suffix_index.clone()])
	if rt.is_true(rt.identical(rt.new_string('---'), rt.call_function('substr', [var_remaining.clone(), rt.new_int(0), rt.new_int(3)]))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('-'), if !(var_remaining.array_get(rt.new_int(3))).is_null() { var_remaining.array_get(rt.new_int(3)) } else { rt.new_string('') })))) {
		return rt.create_array([rt.ArrayItem{ key: 'prefix', val: var_prefix }, rt.ArrayItem{ key: 'suffix', val: rt.new_null() }, rt.ArrayItem{ key: 'unique_id', val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('---'), var_remaining)))) { rt.call_function('substr', [var_remaining.clone(), rt.new_int(3)]) } else { rt.new_null() } }])
	}
	mut var_suffix := rt.call_function('substr', [var_remaining.clone(), rt.new_int(2)])
	mut var_unique_id_index := rt.call_function('strpos', [var_suffix.clone(), rt.new_string('---')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_unique_id_index)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('-'), if !(var_suffix.array_get(rt.add(var_unique_id_index, rt.new_int(3)))).is_null() { var_suffix.array_get(rt.add(var_unique_id_index, rt.new_int(3))) } else { rt.new_string('') })))) {
		mut var_unique_id := rt.call_function('substr', [var_suffix.clone(), rt.add(var_unique_id_index, rt.new_int(3))])
		var_suffix = rt.call_function('substr', [var_suffix.clone(), rt.new_int(0), var_unique_id_index.clone()])
		return rt.create_array([rt.ArrayItem{ key: 'prefix', val: var_prefix }, rt.ArrayItem{ key: 'suffix', val: if !rt.is_true(var_suffix) { rt.new_null() } else { var_suffix } }, rt.ArrayItem{ key: 'unique_id', val: if !rt.is_true(var_unique_id) { rt.new_null() } else { var_unique_id } }])
	}
	return rt.create_array([rt.ArrayItem{ key: 'prefix', val: var_prefix }, rt.ArrayItem{ key: 'suffix', val: if !rt.is_true(var_suffix) { rt.new_null() } else { var_suffix } }, rt.ArrayItem{ key: 'unique_id', val: rt.new_null() }])
}

fn (mut this Class_WP_Interactivity_API) extract_directive_value(var_directive_value rt.PhpVal, var_default_namespace rt.PhpVal) rt.PhpVal {
	mut var_directive_value_mutated := var_directive_value
	if !rt.is_true(var_directive_value_mutated) || var_directive_value_mutated.clone().is_bool() {
		return rt.create_array([rt.ArrayItem{ key: none, val: var_default_namespace }, rt.ArrayItem{ key: none, val: rt.new_null() }])
	}
	if rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [rt.new_string('/^([\\w\\-_\\/]+)::./'), var_directive_value_mutated.clone()]))) {
		mut list_tmp_3 := rt.call_function('explode', [rt.new_string('::'), var_directive_value_mutated.clone(), rt.new_int(2)])
		var_default_namespace = (list_tmp_3).array_get(0)
		var_directive_value_mutated = (list_tmp_3).array_get(1)
	}
	mut var_decoded_json := rt.call_function('json_decode', [var_directive_value_mutated.clone(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_decoded_json)))) || rt.is_true(rt.identical(rt.new_string('null'), var_directive_value_mutated)) {
	var_directive_value_mutated = var_decoded_json.clone()
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: var_default_namespace }, rt.ArrayItem{ key: none, val: var_directive_value_mutated }])
}

fn (mut this Class_WP_Interactivity_API) get_directive_entries(mut var_p Class_WP_Interactivity_API_Directives_Processor, prefix string) rt.PhpVal {
	mut var_attr_prefix := rt.new_null()
	mut var_suffix := rt.new_null()
	mut var_unique_id := rt.new_null()
	mut var_namespace := rt.new_null()
	mut var_value := rt.new_null()
	mut var_p_mutated := var_p
	mut prefix_mutated := prefix
	mut var_directive_attributes := var_p_mutated.get_attribute_names_with_prefix(rt.new_string('data-wp-' + prefix_mutated))
	mut var_entries := rt.new_array()
	mut iter_8 := var_directive_attributes.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_attribute_name := item_8.val
		mut list_tmp_4 := this.parse_directive_name((var_attribute_name).str())
		var_attr_prefix = (list_tmp_4).array_get(0)
		var_suffix = (list_tmp_4).array_get(1)
		var_unique_id = (list_tmp_4).array_get(2)
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(prefix_mutated), var_attr_prefix)))) {
			continue
		}
		mut list_tmp_5 := this.extract_directive_value(var_p_mutated.get_attribute(var_attribute_name.clone()), rt.call_function('end', [this.namespace_stack]))
		var_namespace = (list_tmp_5).array_get(0)
		var_value = (list_tmp_5).array_get(1)
		var_entries.array_push(rt.create_array([rt.ArrayItem{ key: 'namespace', val: var_namespace }, rt.ArrayItem{ key: 'value', val: var_value }, rt.ArrayItem{ key: 'suffix', val: var_suffix }, rt.ArrayItem{ key: 'unique_id', val: var_unique_id }]))
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_a_suffix := if !(var_a.array_get(rt.new_string('suffix'))).is_null() { var_a.array_get(rt.new_string('suffix')) } else { rt.new_string('') }
		mut var_b_suffix := if !(var_b.array_get(rt.new_string('suffix'))).is_null() { var_b.array_get(rt.new_string('suffix')) } else { rt.new_string('') }
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_a_suffix, var_b_suffix)))) {
			return rt.new_null()
		}
		mut var_a_id := if !(var_a.array_get(rt.new_string('unique_id'))).is_null() { var_a.array_get(rt.new_string('unique_id')) } else { rt.new_string('') }
		mut var_b_id := if !(var_b.array_get(rt.new_string('unique_id'))).is_null() { var_b.array_get(rt.new_string('unique_id')) } else { rt.new_string('') }
		return rt.new_null()
		}
	rt.call_function('usort', [var_entries.clone(), rt.new_closure(closure_1_fn)])
	return var_entries.clone()
}

fn (mut this Class_WP_Interactivity_API) kebab_to_camel_case(str string) string {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_matches := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_matches.array_get(rt.new_int(2)).to_string().to_upper()
		}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_matches := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return var_matches.array_get(rt.new_int(2)).to_string().to_upper()
		}
	return (rt.call_function('lcfirst', [rt.call_function('preg_replace_callback', [rt.new_string('/(-)([a-z])/'), rt.new_closure(closure_2_fn), rt.new_string(str.trim_right(' \t\n\r').to_lower())])])).str()
}

fn (mut this Class_WP_Interactivity_API) data_wp_interactive_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string) {
	mut var_p_mutated := var_p
	if rt.is_true(rt.identical(rt.new_string('exit'), rt.new_string(mode))) {
		rt.call_function('array_pop', [this.namespace_stack])
		return
	}
	mut var_attribute_value := var_p_mutated.get_attribute(rt.new_string('data-wp-interactive'))
	mut var_new_namespace := rt.new_null()
	if var_attribute_value.clone().is_string() && !(!rt.is_true(var_attribute_value)) {
		mut var_decoded_json := rt.call_function('json_decode', [var_attribute_value.clone(), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(var_decoded_json.clone().is_array())) {
		var_new_namespace = if !(var_decoded_json.array_get(rt.new_string('namespace'))).is_null() { var_decoded_json.array_get(rt.new_string('namespace')) } else { rt.new_null() }
		} else {
		var_new_namespace = var_attribute_value.clone()
		}
	}
	this.namespace_stack.array_push(if rt.is_true(var_new_namespace) && rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [rt.new_string('/^([\\w\\-_\\/]+)/'), var_new_namespace.clone()]))) { var_new_namespace } else { rt.call_function('end', [this.namespace_stack]) })
}

fn (mut this Class_WP_Interactivity_API) data_wp_context_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string) {
	mut var_p_mutated := var_p
	if rt.is_true(rt.identical(rt.new_string('exit'), rt.new_string(mode))) {
		rt.call_function('array_pop', [this.context_stack])
		return
	}
	mut var_entries := this.get_directive_entries(mut var_p_mutated, 'context')
	mut var_context := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('end', [this.context_stack]), rt.new_bool(false))))) { rt.call_function('end', [this.context_stack]) } else { rt.new_array() }
	mut iter_9 := var_entries.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_entry := item_9.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_entry.array_get(rt.new_string('suffix')))))) {
			continue
		}
	var_context = rt.call_function('array_replace_recursive', [var_context.clone(), rt.create_array([rt.ArrayItem{ key: var_entry.array_get(rt.new_string('namespace')), val: if var_entry.array_get(rt.new_string('value')).is_array() { var_entry.array_get(rt.new_string('value')) } else { rt.new_array() } }])])
	}
	this.context_stack.array_push(var_context.clone())
}

fn (mut this Class_WP_Interactivity_API) data_wp_bind_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string) {
	mut var_p_mutated := var_p
	if rt.is_true(rt.identical(rt.new_string('enter'), rt.new_string(mode))) {
		mut var_entries := this.get_directive_entries(mut var_p_mutated, 'bind')
		mut iter_10 := var_entries.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_entry := item_10.val
			if !rt.is_true(var_entry.array_get(rt.new_string('suffix'))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_entry.array_get(rt.new_string('unique_id')))))) {
				continue
			}
			if rt.is_true(rt.call_function('str_starts_with', [var_entry.array_get(rt.new_string('suffix')), rt.new_string('on')])) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Binding event handler attributes is not supported. Please use "%s" instead.')]), rt.call_function('esc_attr', [rt.new_string('data-wp-on--' + (rt.call_function('substr', [var_entry.array_get(rt.new_string('suffix')), rt.new_int(2)])).str())])]), rt.new_string('6.9.2')])
				continue
			}
			mut var_result := this.evaluate(var_entry.clone())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_result)))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_result)))) || (var_entry.array_get(rt.new_string('suffix')).to_string().len > 5 && rt.is_true(rt.identical(rt.new_string('-'), var_entry.array_get(rt.new_string('suffix')).array_get(rt.new_int(4))))) {
				if var_result.clone().is_bool() && var_entry.array_get(rt.new_string('suffix')).to_string().len > 5 && rt.is_true(rt.identical(rt.new_string('-'), var_entry.array_get(rt.new_string('suffix')).array_get(rt.new_int(4)))) {
				var_result = rt.new_string((if rt.is_true(var_result) { 'true' } else { 'false' }).str())
				}
				var_p_mutated.set_attribute(var_entry.array_get(rt.new_string('suffix')), var_result.clone())
			} else {
				var_p_mutated.remove_attribute(var_entry.array_get(rt.new_string('suffix')))
			}
		}
	}
}

fn (mut this Class_WP_Interactivity_API) data_wp_class_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string) {
	mut var_p_mutated := var_p
	if rt.is_true(rt.identical(rt.new_string('enter'), rt.new_string(mode))) {
		mut var_all_class_directives := var_p_mutated.get_attribute_names_with_prefix(rt.new_string('data-wp-class--'))
		mut var_entries := this.get_directive_entries(mut var_p_mutated, 'class')
		mut iter_11 := var_entries.iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_entry := item_11.val
			if !rt.is_true(var_entry.array_get(rt.new_string('suffix'))) {
				continue
			}
			mut var_class_name := if var_entry.array_isset(rt.new_string('unique_id')) && rt.is_true(var_entry.array_get(rt.new_string('unique_id'))) { rt.concat(rt.concat(var_entry.array_get(rt.new_string('suffix')), rt.new_string('---')), var_entry.array_get(rt.new_string('unique_id'))) } else { var_entry.array_get(rt.new_string('suffix')) }
			if !rt.is_true(var_class_name) {
				return
			}
			mut var_result := this.evaluate(var_entry.clone())
			if rt.is_true(var_result) {
				var_p_mutated.add_class(var_class_name.clone())
			} else {
				var_p_mutated.remove_class(var_class_name.clone())
			}
		}
	}
}

fn (mut this Class_WP_Interactivity_API) data_wp_style_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string) {
	mut var_p_mutated := var_p
	if rt.is_true(rt.identical(rt.new_string('enter'), rt.new_string(mode))) {
		mut var_entries := this.get_directive_entries(mut var_p_mutated, 'style')
		mut iter_12 := var_entries.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_entry := item_12.val
			mut var_style_property := var_entry.array_get(rt.new_string('suffix'))
			if !rt.is_true(var_style_property) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_entry.array_get(rt.new_string('unique_id')))))) {
				continue
			}
			mut var_style_property_value := this.evaluate(var_entry.clone())
			mut var_style_attribute_value := var_p_mutated.get_attribute(rt.new_string('style'))
			var_style_attribute_value = if rt.is_true(var_style_attribute_value) && !(var_style_attribute_value.clone().is_bool()) { var_style_attribute_value } else { rt.new_string('') }
			if rt.is_true(var_style_property_value) || rt.is_true(var_style_attribute_value) {
				var_style_attribute_value = rt.new_string(this.merge_style_property((var_style_attribute_value).str(), (var_style_property).str(), var_style_property_value.clone()))
				if !(!rt.is_true(var_style_attribute_value)) {
					var_p_mutated.set_attribute(rt.new_string('style'), var_style_attribute_value.clone())
				} else {
					var_p_mutated.remove_attribute(rt.new_string('style'))
				}
			}
		}
	}
}

fn (mut this Class_WP_Interactivity_API) merge_style_property(style_attribute_value string, style_property_name string, var_style_property_value rt.PhpVal) string {
	mut var_name := rt.new_null()
	mut var_value := rt.new_null()
	mut style_attribute_value_mutated := style_attribute_value
	mut var_style_property_value_mutated := var_style_property_value
	mut var_style_assignments := rt.call_function('explode', [rt.new_string(';'), rt.new_string(style_attribute_value_mutated).clone()])
	mut var_result := rt.new_array()
	var_style_property_value_mutated = if !(!rt.is_true(var_style_property_value_mutated)) { rt.new_string(var_style_property_value_mutated.clone().to_string().trim_space().trim_right(' \t\n\r')) } else { rt.new_null() }
	mut var_new_style_property := rt.new_string((if rt.is_true(var_style_property_value_mutated) { style_property_name + ':' + (var_style_property_value_mutated).str() + ';' } else { '' }).str())
	mut iter_13 := var_style_assignments.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_style_assignment := item_13.val
		if var_style_assignment.clone().to_string().trim_space() == '' {
			continue
		}
		mut list_tmp_6 := rt.call_function('explode', [rt.new_string(':'), var_style_assignment.clone()])
		var_name = (list_tmp_6).array_get(0)
		var_value = (list_tmp_6).array_get(1)
		if rt.is_true(rt.new_bool(var_name.clone().to_string().trim_space() != style_property_name)) {
			var_result.array_push(var_name.clone().to_string().trim_space() + ':' + var_value.clone().to_string().trim_space() + ';')
		}
	}
	var_result.array_push(var_new_style_property.clone())
	return (rt.call_function('implode', [rt.new_string(''), var_result.clone()])).str()
}

fn (mut this Class_WP_Interactivity_API) data_wp_text_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string) {
	mut var_p_mutated := var_p
	if rt.is_true(rt.identical(rt.new_string('enter'), rt.new_string(mode))) {
		mut var_entries := this.get_directive_entries(mut var_p_mutated, 'text')
		mut var_valid_entry := rt.new_null()
		mut iter_14 := var_entries.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_entry := item_14.val
			if rt.is_true(rt.identical(rt.new_null(), var_entry.array_get(rt.new_string('suffix')))) && rt.is_true(rt.identical(rt.new_null(), var_entry.array_get(rt.new_string('unique_id')))) && !(!rt.is_true(var_entry.array_get(rt.new_string('value')))) {
				var_valid_entry = var_entry.clone()
				break
			}
		}
		if rt.is_true(rt.identical(rt.new_null(), var_valid_entry)) {
			return
		}
		mut var_result := this.evaluate(var_valid_entry.clone())
		if var_result.clone().is_string() || var_result.clone().is_long() || var_result.clone().is_double() {
			var_p_mutated.set_content_between_balanced_tags(rt.call_function('esc_html', [var_result.clone()]))
		} else {
			var_p_mutated.set_content_between_balanced_tags(rt.new_string(''))
		}
	}
}

fn (mut this Class_WP_Interactivity_API) get_router_animation_styles() string {
	return '\t\t\t.wp-interactivity-router-loading-bar {\n\t\t\t\tposition: fixed;\n\t\t\t\ttop: 0;\n\t\t\t\tleft: 0;\n\t\t\t\tmargin: 0;\n\t\t\t\tpadding: 0;\n\t\t\t\twidth: 100vw;\n\t\t\t\tmax-width: 100vw !important;\n\t\t\t\theight: 4px;\n\t\t\t\tbackground-color: #000;\n\t\t\t\topacity: 0\n\t\t\t}\n\t\t\t.wp-interactivity-router-loading-bar.start-animation {\n\t\t\t\tanimation: wp-interactivity-router-loading-bar-start-animation 30s cubic-bezier(0.03, 0.5, 0, 1) forwards\n\t\t\t}\n\t\t\t.wp-interactivity-router-loading-bar.finish-animation {\n\t\t\t\tanimation: wp-interactivity-router-loading-bar-finish-animation 300ms ease-in\n\t\t\t}\n\t\t\t@keyframes wp-interactivity-router-loading-bar-start-animation {\n\t\t\t\t0% { transform: scaleX(0); transform-origin: 0 0; opacity: 1 }\n\t\t\t\t100% { transform: scaleX(1); transform-origin: 0 0; opacity: 1 }\n\t\t\t}\n\t\t\t@keyframes wp-interactivity-router-loading-bar-finish-animation {\n\t\t\t\t0% { opacity: 1 }\n\t\t\t\t50% { opacity: 1 }\n\t\t\t\t100% { opacity: 0 }\n\t\t\t}'
}

fn (mut this Class_WP_Interactivity_API) print_router_loading_and_screen_reader_markup() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('6.7.0'), rt.new_string('WP_Interactivity_API::print_router_markup')])
	this.print_router_markup()
}

fn (mut this Class_WP_Interactivity_API) print_router_markup() {
	print('\t\t\t<div\n\t\t\t\tclass="wp-interactivity-router-loading-bar"\n\t\t\t\tdata-wp-interactive="core/router/private"\n\t\t\t\tdata-wp-class--start-animation="state.navigation.hasStarted"\n\t\t\t\tdata-wp-class--finish-animation="state.navigation.hasFinished"\n\t\t\t></div>')
}

fn (mut this Class_WP_Interactivity_API) data_wp_router_region_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string) {
	mut var_p_mutated := var_p
	if rt.is_true(rt.identical(rt.new_string('enter'), rt.new_string(mode))) && !(this.has_processed_router_region) {
		this.has_processed_router_region = true
		this.state(mut 'core/router', mut rt.cast_object_ptr[Class_?array](rt.create_array([rt.ArrayItem{ key: 'url', val: rt.call_function('get_self_link', []rt.PhpVal{}) }])))
		rt.call_function('wp_register_style', [rt.new_string('wp-interactivity-router-animations'), rt.new_bool(false)])
		rt.call_function('wp_add_inline_style', [rt.new_string('wp-interactivity-router-animations'), rt.new_string(this.get_router_animation_styles())])
		rt.call_function('wp_enqueue_style', [rt.new_string('wp-interactivity-router-animations')])
		rt.call_function('add_action', [rt.new_string('wp_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Interactivity_API', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'print_router_markup' }])])
	}
}

fn (mut this Class_WP_Interactivity_API) data_wp_each_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string, mut var_tag_stack Class_array) {
	mut var_p_mutated := var_p
	mut var_tag_stack_mutated := var_tag_stack
	if rt.is_true(rt.identical(rt.new_string('enter'), rt.new_string(mode))) && rt.is_true(rt.identical(rt.new_string('TEMPLATE'), var_p_mutated.get_tag())) {
		mut var_entries := this.get_directive_entries(mut var_p_mutated, 'each')
		if var_entries.clone().array_count() > 1 || !rt.is_true(var_entries) {
			return
		}
		mut var_entry := var_entries.array_get(rt.new_int(0))
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_entry.array_get(rt.new_string('unique_id')))))) {
			return
		}
		mut var_item_name := rt.new_string((if var_entry.array_isset(rt.new_string('suffix')) { this.kebab_to_camel_case((var_entry.array_get(rt.new_string('suffix'))).str()) } else { 'item' }).str())
		mut var_result := this.evaluate(var_entry.clone())
		mut var_inner_content := var_p_mutated.get_content_between_balanced_template_tags()
		mut var_template_end := rt.new_string('data-wp-each: template end')
		var_p_mutated.set_bookmark(var_template_end.clone())
		var_p_mutated.next_tag()
		mut var_manual_sdp := var_p_mutated.get_attribute(rt.new_string('data-wp-each-child'))
		var_p_mutated.seek(var_template_end.clone())
		var_p_mutated.release_bookmark(var_template_end.clone())
		if rt.is_true(var_manual_sdp) || !rt.is_true(var_result) || !(var_result.clone().is_array()) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('array_is_list', [var_result.clone()]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [rt.new_string(var_inner_content.clone().to_string().trim_space()), rt.new_string('<')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [rt.new_string(var_inner_content.clone().to_string().trim_space()), rt.new_string('>')]))))) {
			rt.call_function('array_pop', [var_tag_stack_mutated])
			return
		}
		mut var_processed_content := rt.new_string('')
		mut iter_15 := var_result.iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_item := item_15.val
			this.context_stack.array_push(rt.call_function('array_replace_recursive', [if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('end', [this.context_stack]), rt.new_bool(false))))) { rt.call_function('end', [this.context_stack]) } else { rt.new_array() }, rt.create_array([rt.ArrayItem{ key: var_entry.array_get(rt.new_string('namespace')), val: rt.create_array([rt.ArrayItem{ key: var_item_name, val: var_item }]) }])]))
			mut var_processed_item := this._process_directives((var_inner_content).str())
			if rt.is_true(rt.identical(rt.new_null(), var_processed_item)) {
				rt.call_function('array_pop', [this.context_stack])
				return
			}
			mut var_i := create_wp_interactivity_api_directives_processor(var_processed_item.clone())
			for rt.is_true(var_i.next_tag()) {
				var_i.set_attribute(rt.new_string('data-wp-each-child'), rt.new_string((var_entry.array_get(rt.new_string('namespace'))).str() + '::' + (var_entry.array_get(rt.new_string('value'))).str()))
				var_i.next_balanced_tag_closer_tag()
			}
			var_processed_content = rt.concat(var_processed_content, var_i.get_updated_html())
			rt.call_function('array_pop', [this.context_stack])
		}
		var_p_mutated.append_content_after_template_tag_closer(var_processed_content.clone())
		rt.call_function('array_pop', [var_tag_stack_mutated])
	}
}

struct Class_WP_Interactivity_API_Directives_Processor {
	rt.PhpObjectBase
}

fn create_wp_interactivity_api(_args ...rt.PhpVal) &Class_WP_Interactivity_API {
	mut obj := &Class_WP_Interactivity_API{
		PhpObjectBase: rt.PhpObjectBase{}
		state_data: rt.new_array()
		config_data: rt.new_array()
		derived_state_closures: rt.new_array()
		has_processed_router_region: false
		script_modules_that_can_load_on_client_navigation: rt.new_array()
		namespace_stack: rt.new_null()
		context_stack: rt.new_null()
		current_element: rt.new_null()
	}
	return obj
}

fn create_wp_interactivity_api_directives_processor(_args ...rt.PhpVal) &Class_WP_Interactivity_API_Directives_Processor {
	mut obj := &Class_WP_Interactivity_API_Directives_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Interactivity_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'state' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.state(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'config' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.config(dispatch_arg_0, mut dispatch_arg_1)
		}
		'print_client_interactivity_data' {
			this.print_client_interactivity_data()
			return rt.new_null()
		}
		'filter_script_module_interactivity_router_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.filter_script_module_interactivity_router_data(mut dispatch_arg_0)
		}
		'filter_script_module_interactivity_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.filter_script_module_interactivity_data(mut dispatch_arg_0)
		}
		'get_context' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_context(mut dispatch_arg_0)
		}
		'get_element' {
			return this.get_element()
		}
		'register_script_modules' {
			this.register_script_modules()
			return rt.new_null()
		}
		'add_hooks' {
			this.add_hooks()
			return rt.new_null()
		}
		'add_load_on_client_navigation_attribute_to_script_modules' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_load_on_client_navigation_attribute_to_script_modules(dispatch_arg_0)
		}
		'add_client_navigation_support_to_script_module' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.add_client_navigation_support_to_script_module(dispatch_arg_0)
			return rt.new_null()
		}
		'process_directives' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.process_directives(dispatch_arg_0))
		}
		'_process_directives' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this._process_directives(dispatch_arg_0)
		}
		'evaluate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.evaluate(dispatch_arg_0)
		}
		'parse_directive_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.parse_directive_name(dispatch_arg_0)
		}
		'extract_directive_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.extract_directive_value(dispatch_arg_0, dispatch_arg_1)
		}
		'get_directive_entries' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Interactivity_API_Directives_Processor](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_directive_entries(mut dispatch_arg_0, dispatch_arg_1)
		}
		'kebab_to_camel_case' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.kebab_to_camel_case(dispatch_arg_0))
		}
		'data_wp_interactive_processor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Interactivity_API_Directives_Processor](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.data_wp_interactive_processor(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'data_wp_context_processor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Interactivity_API_Directives_Processor](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.data_wp_context_processor(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'data_wp_bind_processor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Interactivity_API_Directives_Processor](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.data_wp_bind_processor(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'data_wp_class_processor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Interactivity_API_Directives_Processor](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.data_wp_class_processor(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'data_wp_style_processor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Interactivity_API_Directives_Processor](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.data_wp_style_processor(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'merge_style_property' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.merge_style_property(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'data_wp_text_processor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Interactivity_API_Directives_Processor](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.data_wp_text_processor(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_router_animation_styles' {
			return rt.new_string(this.get_router_animation_styles())
		}
		'print_router_loading_and_screen_reader_markup' {
			this.print_router_loading_and_screen_reader_markup()
			return rt.new_null()
		}
		'print_router_markup' {
			this.print_router_markup()
			return rt.new_null()
		}
		'data_wp_router_region_processor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Interactivity_API_Directives_Processor](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.data_wp_router_region_processor(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'data_wp_each_processor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Interactivity_API_Directives_Processor](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.data_wp_each_processor(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Interactivity_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'state_data' { return this.state_data }
		'config_data' { return this.config_data }
		'derived_state_closures' { return this.derived_state_closures }
		'has_processed_router_region' { return rt.new_bool(this.has_processed_router_region) }
		'script_modules_that_can_load_on_client_navigation' { return this.script_modules_that_can_load_on_client_navigation }
		'namespace_stack' { return this.namespace_stack }
		'context_stack' { return this.context_stack }
		'current_element' { return this.current_element }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Interactivity_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'state_data' { this.state_data = val; return true }
		'config_data' { this.config_data = val; return true }
		'derived_state_closures' { this.derived_state_closures = val; return true }
		'has_processed_router_region' { this.has_processed_router_region = (val).to_bool(); return true }
		'script_modules_that_can_load_on_client_navigation' { this.script_modules_that_can_load_on_client_navigation = val; return true }
		'namespace_stack' { this.namespace_stack = val; return true }
		'context_stack' { this.context_stack = val; return true }
		'current_element' { this.current_element = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Interactivity_API_Directives_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Interactivity_API_Directives_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Interactivity_API_Directives_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}
