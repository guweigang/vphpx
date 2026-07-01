import rt

fn render_block_core_query(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_is_interactive := rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('enhancedPagination')) && rt.is_true(rt.identical(rt.new_bool(true), var_attributes.array_get('enhancedPagination'))))) && var_attributes.array_isset(rt.new_string('queryId'))
	if var_is_interactive {
		rt.call_function('wp_enqueue_script_module', [rt.new_string('@wordpress/block-library/query/view')])
		mut var_p := create_wp_html_tag_processor(var_content.dup())
		if rt.is_true(var_p.next_tag()) {
			var_p.set_attribute(rt.new_string('data-wp-interactive'), rt.new_string('core/query'))
			var_p.set_attribute(rt.new_string('data-wp-router-region'), rt.new_string('query-' + (var_attributes.array_get('queryId')).str()))
			var_p.set_attribute(rt.new_string('data-wp-context'), rt.new_string('{}'))
			var_p.set_attribute(rt.new_string('data-wp-key'), var_attributes.array_get('queryId'))
			var_content = var_p.get_updated_html()
		}
	}
	mut var_style_asset := 'wp-block-query'
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_style_is', [rt.new_string(var_style_asset).dup()]))))) {
		mut var_style_handles := rt.get_property(rt.get_property(var_block, 'block_type'), 'style_handles')
		if rt.is_true(rt.new_bool(!(var_is_interactive) && rt.is_true(rt.call_function('in_array', [rt.new_string(var_style_asset).dup(), var_style_handles.dup(), rt.new_bool(true)])))) {
			rt.set_property(rt.get_property(var_block, 'block_type'), 'style_handles', rt.call_function('array_diff', [var_style_handles.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_style_asset }])]))
		}
		if rt.is_true(rt.new_bool(var_is_interactive && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(var_style_asset).dup(), var_style_handles.dup(), rt.new_bool(true)]))))))) {
			rt.set_property(rt.get_property(var_block, 'block_type'), 'style_handles', rt.call_function('array_merge', [var_style_handles.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_style_asset }])]))
		}
	}
	return var_content.dup()
}

fn register_block_core_query() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/query', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_query' }])])
}

fn block_core_query_disable_enhanced_pagination(var_parsed_block rt.PhpVal) rt.PhpVal {
	mut var_enhanced_query_stack := []rt.PhpVal{}
	mut var_dirty_enhanced_queries := rt.new_null()
	// unsupported statement: Stmt_Static
	// unsupported statement: Stmt_Static
	// unsupported statement: Stmt_Static
	mut var_block_name := var_parsed_block.array_get('blockName')
	mut var_block_type := rt.call_method(fn () rt.PhpVal { mut temp := Class_WP_Block_Type_Registry{}; return temp.get_instance() }(), 'get_registered', [var_block_name.dup()])
	mut var_has_enhanced_pagination := rt.is_true(rt.new_bool(var_parsed_block.array_get('attrs').array_isset(rt.new_string('enhancedPagination')) && rt.is_true(rt.identical(rt.new_bool(true), var_parsed_block.array_get('attrs').array_get('enhancedPagination'))))) && var_parsed_block.array_get('attrs').array_isset(rt.new_string('queryId'))
	mut var_supports_client_navigation := rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'supports').array_get('interactivity').array_isset(rt.new_string('clientNavigation')) && rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_block_type, 'supports').array_get('interactivity').array_get('clientNavigation'))))) || rt.is_true(rt.new_bool(rt.get_property(var_block_type, 'supports').array_isset(rt.new_string('interactivity')) && rt.is_true(rt.identical(rt.new_bool(true), rt.get_property(var_block_type, 'supports').array_get('interactivity')))))
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('core/query'), var_block_name)) && var_has_enhanced_pagination)) {
		var_enhanced_query_stack << var_parsed_block.array_get('attrs').array_get('queryId')
		if !(!(var_render_query_callback).is_null()) {
			closure_1_fn := fn [mut var_enhanced_query_stack, mut var_dirty_enhanced_queries, mut var_render_query_callback] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_content := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_block := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_has_enhanced_pagination := rt.is_true(rt.new_bool(var_block.array_get('attrs').array_isset(rt.new_string('enhancedPagination')) && rt.is_true(rt.identical(rt.new_bool(true), var_block.array_get('attrs').array_get('enhancedPagination'))))) && var_block.array_get('attrs').array_isset(rt.new_string('queryId'))
	if !(var_has_enhanced_pagination) {
		return var_content.dup()
	}
	if var_dirty_enhanced_queries.array_isset(var_block.array_get('attrs').array_get('queryId')) {
		rt.call_function('wp_interactivity_config', [rt.new_string('core/router'), rt.create_array([rt.ArrayItem{ key: 'clientNavigationDisabled', val: true }])])
		var_dirty_enhanced_queries.array_set(var_block.array_get('attrs').array_get('queryId'), rt.new_null())
	}
	rt.call_function('array_pop', [var_enhanced_query_stack.dup()])
	if !rt.is_true(var_enhanced_query_stack) {
		rt.call_function('remove_filter', [rt.new_string('render_block_core/query'), var_render_query_callback.dup()])
		var_render_query_callback = rt.new_null()
	}
	return var_content.dup()
	}
			mut var_render_query_callback := rt.new_closure(closure_1_fn)
			rt.call_function('add_filter', [rt.new_string('render_block_core/query'), var_render_query_callback.dup(), rt.new_int(10), rt.new_int(2)])
		}
	} else if !(!rt.is_true(var_enhanced_query_stack)) && !(var_block_name).is_null() && !(var_supports_client_navigation) {
		for var_query_id in var_enhanced_query_stack {
			var_dirty_enhanced_queries.array_set(var_query_id, true)
		}
	}
	return var_parsed_block.dup()
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor() &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_type_registry() &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
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


fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_blocks_query_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_query')])
	rt.call_function('add_filter', [rt.new_string('render_block_data'), rt.new_string('block_core_query_disable_enhanced_pagination'), rt.new_int(10), rt.new_int(1)])
}
