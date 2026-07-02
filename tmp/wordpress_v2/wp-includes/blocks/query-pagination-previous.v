import rt

fn render_block_core_query_pagination_previous(var_attributes rt.PhpVal, var_content_arg rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_content := var_content_arg
	mut var_page_key := rt.new_null()
	mut var_enhanced_pagination := rt.new_null()
	mut var_max_page := rt.new_null()
	mut var_page := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	mut var_show_label := rt.new_null()
	mut var_default_label := rt.new_null()
	mut var_label_text := rt.new_null()
	mut var_label := rt.new_null()
	mut var_pagination_arrow := rt.new_null()
	mut var_filter_link_attributes := rt.new_null()
	mut var_block_query := rt.new_null()
	mut var_block_max_pages := rt.new_null()
	mut var_total := rt.new_null()
	mut var_p := rt.new_null()
	var_page_key = rt.new_string((if rt.get_property(var_block, 'context').array_isset(rt.new_string('queryId')) {
		'query-' +
			(rt.get_property(var_block, 'context').array_get(rt.new_string('queryId'))).str() +
			'-page'
	} else {
		'query-page'
	}).str())
	var_enhanced_pagination = rt.new_bool((if !(rt.get_property(var_block, 'context').array_get(rt.new_string('enhancedPagination'))).is_null() {
		rt.get_property(var_block, 'context').array_get(rt.new_string('enhancedPagination'))
	} else {
		rt.new_bool(false)
	}).to_bool())
	var_max_page = rt.new_int((if !(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('pages'))).is_null() {
		rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('pages'))
	} else {
		rt.new_int(0)
	}).to_i64())
	var_page = rt.new_int(if !rt.is_true(rt.get_superglobal('_GET').array_get(var_page_key)) {
		1
	} else {
		rt.new_int((rt.get_superglobal('_GET').array_get(var_page_key)).to_i64())
	})
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	var_show_label = rt.new_bool((if !(rt.get_property(var_block, 'context').array_get(rt.new_string('showLabel'))).is_null() {
		rt.get_property(var_block, 'context').array_get(rt.new_string('showLabel'))
	} else {
		rt.new_bool(true)
	}).to_bool())
	var_default_label = rt.call_function('__', [rt.new_string('Previous Page')])
	var_label_text = if var_attributes.array_isset(rt.new_string('label')) && !(!rt.is_true(var_attributes.array_get(rt.new_string('label')))) { rt.call_function('esc_html', [
			var_attributes.array_get(rt.new_string('label')),
		]) } else { var_default_label }
	var_label = if rt.is_true(var_show_label) { var_label_text } else { rt.new_string('') }
	var_pagination_arrow = rt.call_function('get_query_pagination_arrow', [
		var_block.clone(), rt.new_bool(false)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_label)))) {
		var_wrapper_attributes = rt.concat(var_wrapper_attributes, rt.new_string(' aria-label="' +
			var_label_text.str() + '"'))
	}
	if rt.is_true(var_pagination_arrow) {
		var_label = rt.new_string(var_pagination_arrow.str() + var_label.str())
	}
	var_content = rt.new_string('')
	if rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_isset(rt.new_string('inherit'))
		&& rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('inherit'))) {
		closure_1_fn := fn [var_wrapper_attributes] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			return var_wrapper_attributes.clone()
		}
		var_filter_link_attributes = rt.new_closure(closure_1_fn)
		rt.call_function('add_filter', [rt.new_string('previous_posts_link_attributes'),
			var_filter_link_attributes.clone()])
		var_content = rt.call_function('get_previous_posts_link', [
			var_label.clone()])
		rt.call_function('remove_filter', [
			rt.new_string('previous_posts_link_attributes'),
			var_filter_link_attributes.clone(),
		])
	} else {
		var_block_query = create_wp_query(rt.call_function('build_query_vars_from_query_block', [
			var_block.clone(),
			var_page.clone(),
		]))
		var_block_max_pages = rt.get_property(var_block_query, 'max_num_pages')
		var_total = if rt.is_true(rt.new_bool(!(rt.is_true(var_max_page))))
			|| rt.is_true(rt.greater(var_max_page, var_block_max_pages)) {
			var_block_max_pages
		} else {
			var_max_page
		}
		rt.call_function('wp_reset_postdata', []rt.PhpVal{})
		if rt.is_true(rt.less(rt.new_int(1), var_page))
			&& rt.is_true(rt.less_equal(var_page, var_total)) {
			var_content = rt.call_function('sprintf', [
				rt.new_string('<a href="%1$s" %2$s>%3$s</a>'),
				rt.call_function('esc_url', [
					rt.call_function('add_query_arg', [var_page_key.clone(),
						rt.sub(var_page, rt.new_int(1))]),
				]),
				var_wrapper_attributes.clone(),
				var_label.clone(),
			])
		}
	}
	if rt.is_true(var_enhanced_pagination) && !var_content.is_null() {
		var_p = create_wp_html_tag_processor(var_content.clone())
		if rt.is_true(var_p.next_tag(rt.create_array([
			rt.ArrayItem{ key: 'tag_name', val: 'a' },
			rt.ArrayItem{ key: 'class_name', val: 'wp-block-query-pagination-previous' },
		])))
		{
			var_p.set_attribute(rt.new_string('data-wp-key'),
				rt.new_string('query-pagination-previous'))
			var_p.set_attribute(rt.new_string('data-wp-on--click'),
				rt.new_string('core/query::actions.navigate'))
			var_p.set_attribute(rt.new_string('data-wp-on--mouseenter'),
				rt.new_string('core/query::actions.prefetch'))
			var_p.set_attribute(rt.new_string('data-wp-watch'),
				rt.new_string('core/query::callbacks.prefetch'))
			var_content = var_p.get_updated_html()
		}
	}
	return var_content.clone()
}

fn register_block_core_query_pagination_previous() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/query-pagination-previous'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_query_pagination_previous' },
		]),
	])
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
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

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_query_pagination_previous')])
}
