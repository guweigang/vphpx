import rt

fn render_block_core_query_pagination_numbers(var_attributes rt.PhpVal, var_content_arg rt.PhpVal, var_block rt.PhpVal) string {
	mut var_content := var_content_arg
	mut var_page_key := rt.new_null()
	mut var_enhanced_pagination := rt.new_null()
	mut var_page := rt.new_null()
	mut var_max_page := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	mut var_mid_size := rt.new_null()
	mut var_total := rt.new_null()
	mut var_paginate_args := map[string]rt.PhpVal{}
	mut var_block_query := rt.new_null()
	mut var_prev_wp_query := rt.new_null()
	mut var_wp_query := rt.new_null()
	mut var_paged := rt.new_null()
	mut var_p := rt.new_null()
	mut var_tag_index := i64(0)
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
	var_page = rt.new_int(if !rt.is_true(rt.get_superglobal('_GET').array_get(var_page_key)) {
		1
	} else {
		rt.new_int((rt.get_superglobal('_GET').array_get(var_page_key)).to_i64())
	})
	var_max_page = rt.new_int((if !(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('pages'))).is_null() {
		rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('pages'))
	} else {
		rt.new_int(0)
	}).to_i64())
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	var_content = rt.new_string('')
	var_mid_size = if rt.get_property(var_block, 'attributes').array_isset(rt.new_string('midSize')) {
		rt.new_int((rt.get_property(var_block, 'attributes').array_get(rt.new_string('midSize'))).to_i64())
	} else {
		rt.new_null()
	}
	if rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_isset(rt.new_string('inherit'))
		&& rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('inherit'))) {
		var_total = if rt.is_true(rt.new_bool(!(rt.is_true(var_max_page))))
			|| rt.is_true(rt.greater(var_max_page, rt.get_property(var_wp_query, 'max_num_pages'))) {
			rt.get_property(var_wp_query, 'max_num_pages')
		} else {
			var_max_page
		}
		var_paginate_args = {
			'prev_next': rt.new_bool(false)
			'total':     var_total
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_mid_size)))) {
			var_paginate_args['mid_size'] = var_mid_size.clone()
		}
		var_content = rt.call_function('paginate_links', [
			rt.create_array_from_native_map(var_paginate_args),
		])
	} else {
		var_block_query = create_wp_query(rt.call_function('build_query_vars_from_query_block', [
			var_block.clone(),
			var_page.clone(),
		]))
		var_prev_wp_query = var_wp_query.clone()
		var_wp_query = var_block_query
		var_total = if rt.is_true(rt.new_bool(!(rt.is_true(var_max_page))))
			|| rt.is_true(rt.greater(var_max_page, rt.get_property(var_wp_query, 'max_num_pages'))) {
			rt.get_property(var_wp_query, 'max_num_pages')
		} else {
			var_max_page
		}
		var_paginate_args = {
			'base':      rt.new_string('%_%')
			'format':    rt.new_string('?${var_page_key.to_string()}=%#%')
			'current':   rt.call_function('max', [rt.new_int(1),
				var_page.clone()])
			'total':     var_total
			'prev_next': rt.new_bool(false)
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_mid_size)))) {
			var_paginate_args['mid_size'] = var_mid_size.clone()
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), var_page)))) {
			var_paginate_args['add_args'] = rt.create_array([
				rt.ArrayItem{ key: 'cst', val: '' },
			])
		}
		var_paged = if !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('paged'))) {
			rt.new_null()
		} else {
			rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('paged'))).to_i64())
		}
		if rt.is_true(var_paged) {
			var_paginate_args['add_args'] = rt.create_array([
				rt.ArrayItem{ key: 'paged', val: var_paged },
			])
		}
		var_content = rt.call_function('paginate_links', [
			rt.create_array_from_native_map(var_paginate_args),
		])
		rt.call_function('wp_reset_postdata', []rt.PhpVal{})
		var_wp_query = var_prev_wp_query.clone()
	}
	if !rt.is_true(var_content) {
		return ''
	}
	if rt.is_true(var_enhanced_pagination) {
		var_p = create_wp_html_tag_processor(var_content.clone())
		var_tag_index = 0
		for rt.is_true(var_p.next_tag(rt.create_array([rt.ArrayItem, {
			key: 'class_name'
			val: 'page-numbers'
		}]))) {
			if rt.is_true(rt.identical(rt.new_null(),
				var_p.get_attribute(rt.new_string('data-wp-key'))))
			{
				var_p.set_attribute(rt.new_string('data-wp-key'), rt.new_string('index-' +
					(rt.post_inc(rt.new_int(var_tag_index))).str()))
			}
			if rt.is_true(rt.identical(rt.new_string('A'), var_p.get_tag())) {
				var_p.set_attribute(rt.new_string('data-wp-on--click'),
					rt.new_string('core/query::actions.navigate'))
			}
		}
		var_content = var_p.get_updated_html()
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.clone(), var_content.clone()])).str()
}

fn register_block_core_query_pagination_numbers() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/query-pagination-numbers'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_query_pagination_numbers' },
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
		rt.new_string('register_block_core_query_pagination_numbers')])
}
