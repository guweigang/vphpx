import rt

struct Class_WP_Interactivity_API {
	rt.PhpObjectBase
pub mut:
		directive_processors rt.PhpVal = rt.new_array()
		state_data rt.PhpVal = rt.new_array()
		config_data rt.PhpVal = rt.new_array()
		derived_state_closures rt.PhpVal = rt.new_array()
		has_processed_router_region bool
		script_modules_that_can_load_on_client_navigation rt.PhpVal = rt.new_array()
		namespace_stack rt.PhpVal = rt.new_null()
		context_stack rt.PhpVal = rt.new_null()
		current_element rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Interactivity_API) state(mut var_store_namespace Class_?string, mut var_state Class_?array) rt.PhpVal {
	mut var_store_namespace_mutated := var_store_namespace
	mut var_state_mutated := var_state
	if rt.is_true(rt.new_bool(!(rt.is_true(var_store_namespace_mutated)))) {
		if rt.is_true(var_state_mutated) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The namespace is required when state data is passed.')]), rt.new_string('6.6.0')])
			return rt.new_array()
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
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
	if rt.is_true(rt.new_bool(var_state_mutated.dup().is_array())) {
		this.state_data.array_set(var_store_namespace_mutated, rt.call_function('array_replace_recursive', [this.state_data.array_get(var_store_namespace_mutated), var_state_mutated.dup()]))
	}
	return this.state_data.array_get(var_store_namespace_mutated)
}

fn (mut this Class_WP_Interactivity_API) config(store_namespace string, mut var_config Class_array) rt.PhpVal {
	mut store_namespace_mutated := store_namespace
	mut var_config_mutated := var_config
	if !(this.config_data.array_isset(rt.new_string(store_namespace_mutated))) {
		this.config_data.array_set(store_namespace_mutated, rt.new_array())
	}
	if rt.is_true(rt.new_bool(var_config_mutated.dup().is_array())) {
		this.config_data.array_set(store_namespace_mutated, rt.call_function('array_replace_recursive', [this.config_data.array_get(store_namespace_mutated), var_config_mutated.dup()]))
	}
	return this.config_data.array_get(store_namespace_mutated)
}

fn (mut this Class_WP_Interactivity_API) print_client_interactivity_data()  {
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
	{
		mut iter_1 := this.config_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if !(!rt.is_true(var_value)) {
				var_config.array_set(var_key, var_value.dup())
			}
		}
	}
	if !(!rt.is_true(var_config)) {
		var_data_mutated.array_set('config', var_config.dup())
	}
	mut var_state := rt.new_array()
	{
		mut iter_1 := this.state_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if !(!rt.is_true(var_value)) {
				var_state.array_set(var_key, var_value.dup())
			}
		}
	}
	if !(!rt.is_true(var_state)) {
		var_data_mutated.array_set('state', var_state.dup())
	}
	mut var_derived_props := rt.new_array()
	{
		mut iter_1 := this.derived_state_closures.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if !(!rt.is_true(var_value)) {
				var_derived_props.array_set(var_key, var_value.dup())
			}
		}
	}
	if !(!rt.is_true(var_derived_props)) {
		var_data_mutated.array_set('derivedStateClosures', var_derived_props.dup())
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
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The namespace should be a non-empty string.')]), rt.new_string('6.6.0')])
			return rt.new_array()
		}
		var_store_namespace_mutated = rt.call_function('end', [this.namespace_stack])
	}
	mut var_context := rt.call_function('end', [this.context_stack])
	return if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_store_namespace_mutated) && rt.is_true(var_context))) && var_context.array_isset(var_store_namespace_mutated))) { var_context.array_get(var_store_namespace_mutated) } else { rt.new_array() }
}

fn (mut this Class_WP_Interactivity_API) get_element() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.current_element)) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('The element can only be read during directive processing.')]), rt.new_string('6.7.0')])
	}
	return this.current_element
}

fn (mut this Class_WP_Interactivity_API) register_script_modules()  {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('6.7.0'), rt.new_string('wp_default_script_modules')])
}

fn (mut this Class_WP_Interactivity_API) add_hooks()  {
	rt.call_function('add_filter', [rt.new_string('script_module_data_@wordpress/interactivity'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Interactivity_API', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_script_module_interactivity_data' }])])
	rt.call_function('add_filter', [rt.new_string('script_module_data_@wordpress/interactivity-router'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Interactivity_API', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_script_module_interactivity_router_data' }])])
	rt.call_function('add_filter', [rt.new_string('wp_script_attributes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Interactivity_API', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_load_on_client_navigation_attribute_to_script_modules' }]), rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_WP_Interactivity_API) add_load_on_client_navigation_attribute_to_script_modules(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_attributes_mutated.dup().is_array())) && var_attributes_mutated.array_isset(rt.new_string('type')) && var_attributes_mutated.array_isset(rt.new_string('id')))) && rt.is_true(rt.identical(rt.new_string('module'), var_attributes_mutated.array_get('type'))))) && rt.is_true(rt.new_bool(this.script_modules_that_can_load_on_client_navigation.array_isset(rt.call_function('preg_replace', [rt.new_string('/-js-module$/'), rt.new_string(''), var_attributes_mutated.array_get('id')])))))) {
		var_attributes_mutated.array_set('data-wp-router-options', rt.call_function('wp_json_encode', [rt.create_array([rt.ArrayItem{ key: 'loadOnClientNavigation', val: true }])]))
	}
	return var_attributes_mutated.dup()
}

fn (mut this Class_WP_Interactivity_API) add_client_navigation_support_to_script_module(script_module_id string)  {
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
	mut var_p := create_wp_interactivity_api_directives_processor(rt.new_string(html).dup())
	mut var_tag_stack := rt.new_array()
	mut var_unbalanced := rt.new_bool(rt.new_bool(false))
	mut var_directive_processor_prefixes := rt.func_array_keys(// unsupported expression: Expr_StaticPropertyFetch)
	mut var_directive_processor_prefixes_reversed := rt.call_function('array_reverse', [var_directive_processor_prefixes.dup()])
	mut var_namespace_stack_size := rt.new_int(rt.new_int(this.namespace_stack.array_count()))
	mut var_context_stack_size := rt.new_int(rt.new_int(this.context_stack.array_count()))
	for rt.is_true(var_p.next_tag(rt.create_array([rt.ArrayItem{ key: 'tag_closers', val: 'visit' }]))) {
		mut var_tag_name := var_p.get_tag()
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('SVG'), var_tag_name)) || rt.is_true(rt.identical(rt.new_string('MATH'), var_tag_name)))) {
			if rt.is_true(var_p.get_attribute_names_with_prefix(rt.new_string('data-wp-'))) {
				mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Interactivity directives were detected on an incompatible %1$s tag when processing "%2$s". These directives will be ignored in the server side render.')]), var_tag_name.dup(), rt.call_function('end', [this.namespace_stack])])
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), var_message.dup(), rt.new_string('6.6.0')])
			}
			var_p.skip_to_tag_closer()
			continue
		}
		if rt.is_true(var_p.is_tag_closer()) {
			// unsupported assign target: Expr_List
			if rt.is_true(rt.new_bool(0 == var_tag_stack.len || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				var_unbalanced = rt.new_bool(rt.new_bool(true))
				break
			} else {
				rt.call_function('array_pop', [var_tag_stack.dup()])
			}
		} else {
			mut var_each_child_attrs := var_p.get_attribute_names_with_prefix(rt.new_string('data-wp-each-child'))
			if rt.is_true(rt.identical(rt.new_null(), var_each_child_attrs)) {
				continue
			}
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				var_p.next_balanced_tag_closer_tag()
				continue
			} else {
				mut var_directives_prefixes := rt.new_array()
				{
					mut iter_1 := var_p.get_attribute_names_with_prefix(rt.new_string('data-wp-')).iterator()
					for {
						item_1 := iter_1.next() or { break }
						mut var_attribute_name := item_1.val
						mut var_parsed_directive := this.parse_directive_name((var_attribute_name).str())
						if !rt.is_true(var_parsed_directive) {
							continue
						}
						mut var_directive_prefix := rt.new_string('data-wp-' + (var_parsed_directive.array_get('prefix')).str())
						if rt.is_true(rt.new_bool(// unsupported expression: Expr_StaticPropertyFetch.array_isset(var_directive_prefix.dup()))) {
							var_directives_prefixes << var_directive_prefix.dup()
						}
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
		{
			mut iter_1 := var_attr_names.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_name := item_1.val
				var_element_attrs.array_set(var_name, var_p.get_attribute(var_name.dup()))
			}
		}
		this.current_element = rt.create_array([rt.ArrayItem{ key: 'attributes', val: var_element_attrs }])
		for var_mode, var_should_run in var_modes {
			if !(var_should_run) {
				continue
			}
			mut var_existing_directives_prefixes := rt.call_function('array_intersect', [if rt.is_true(rt.identical(rt.new_string('enter'), rt.new_string(mode))) { var_directive_processor_prefixes } else { var_directive_processor_prefixes_reversed }, var_directives_prefixes.dup()])
			{
				mut iter_1 := var_existing_directives_prefixes.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_directive_prefix := item_1.val
					mut var_func := if rt.is_true(rt.new_bool(.array_get().is_array())) { // unsupported expression: Expr_StaticPropertyFetch.array_get(var_directive_prefix) } else { rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Interactivity_API', []string{}, &this) }, rt.ArrayItem{ key: none, val: .array_get() }]) }
					rt.call_function('call_user_func_array', [var_func.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_p }, rt.ArrayItem{ key: none, val: mode }, rt.ArrayItem{ key: none, val: var_tag_stack }])])
				}
			}
		}
		this.current_element = rt.new_null()
	}
	if rt.is_true(var_unbalanced) {
		
	}
	if rt.is_true() {
	}
	return 
}

fn (mut this Class_WP_Interactivity_API) evaluate(var_entry rt.PhpVal) rt.PhpVal {
	mut var_ns := rt.new_null()
	mut var_entry_mutated := var_entry
}

fn (mut this Class_WP_Interactivity_API) parse_directive_name(directive_name string) rt.PhpVal {
}

fn (mut this Class_WP_Interactivity_API) extract_directive_value(var_directive_value rt.PhpVal, var_default_namespace rt.PhpVal) rt.PhpVal {
	mut var_directive_value_mutated := var_directive_value
}

fn (mut this Class_WP_Interactivity_API) get_directive_entries(mut var_p Class_WP_Interactivity_API_Directives_Processor, prefix string) rt.PhpVal {
	mut var_attr_prefix := rt.new_null()
	mut var_suffix := rt.new_null()
	mut var_unique_id := rt.new_null()
	mut var_namespace := rt.new_null()
	mut var_value := rt.new_null()
	mut var_p_mutated := var_p
	mut prefix_mutated := prefix
}

fn (mut this Class_WP_Interactivity_API) kebab_to_camel_case(str string) string {
}

fn (mut this Class_WP_Interactivity_API) data_wp_interactive_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string)  {
	mut var_p_mutated := var_p
}

fn (mut this Class_WP_Interactivity_API) data_wp_context_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string)  {
	mut var_p_mutated := var_p
}

fn (mut this Class_WP_Interactivity_API) data_wp_bind_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string)  {
	mut var_p_mutated := var_p
}

fn (mut this Class_WP_Interactivity_API) data_wp_class_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string)  {
	mut var_p_mutated := var_p
}

fn (mut this Class_WP_Interactivity_API) data_wp_style_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string)  {
	mut var_p_mutated := var_p
}

fn (mut this Class_WP_Interactivity_API) merge_style_property(style_attribute_value string, style_property_name string, var_style_property_value rt.PhpVal) string {
	mut var_name := rt.new_null()
	mut var_value := rt.new_null()
	mut style_attribute_value_mutated := style_attribute_value
	mut var_style_property_value_mutated := var_style_property_value
}

fn (mut this Class_WP_Interactivity_API) data_wp_text_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string)  {
	mut var_p_mutated := var_p
}

fn (mut this Class_WP_Interactivity_API) get_router_animation_styles() string {
}

fn (mut this Class_WP_Interactivity_API) print_router_loading_and_screen_reader_markup()  {
}

fn (mut this Class_WP_Interactivity_API) print_router_markup()  {
}

fn (mut this Class_WP_Interactivity_API) data_wp_router_region_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string)  {
	mut var_p_mutated := var_p
}

fn (mut this Class_WP_Interactivity_API) data_wp_each_processor(mut var_p Class_WP_Interactivity_API_Directives_Processor, mode string, mut var_tag_stack Class_array)  {
	mut var_p_mutated := var_p
	mut var_tag_stack_mutated := var_tag_stack
}

struct Class_WP_Interactivity_API_Directives_Processor {
	rt.PhpObjectBase
}

fn create_wp_interactivity_api() &Class_WP_Interactivity_API {
	mut obj := &Class_WP_Interactivity_API{
		PhpObjectBase: rt.PhpObjectBase{}
		directive_processors: rt.new_array()
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

fn create_wp_interactivity_api_directives_processor() &Class_WP_Interactivity_API_Directives_Processor {
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
		'directive_processors' { return this.directive_processors }
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
		'directive_processors' { this.directive_processors = val; return true }
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



pub fn init_wp_includes_interactivity_api_class_wp_interactivity_api_php() {
}
