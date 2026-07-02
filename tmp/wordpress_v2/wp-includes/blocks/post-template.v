import rt

fn block_core_post_template_uses_featured_image(var_inner_blocks rt.PhpVal) bool {
	mut var_block := rt.new_null()
	mut iter_1 := var_inner_blocks.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_block_shadow := item_1.val
		if rt.is_true(rt.identical(rt.new_string('core/post-featured-image'), rt.get_property(var_block_shadow,
			'name')))
		{
			return true
		}
		if rt.is_true(rt.identical(rt.new_string('core/cover'), rt.get_property(var_block_shadow, 'name')))
			&& !(!rt.is_true(rt.get_property(var_block_shadow, 'attributes').array_get(rt.new_string('useFeaturedImage')))) {
			return true
		}
		if rt.is_true(rt.get_property(var_block_shadow, 'inner_blocks'))
			&& block_core_post_template_uses_featured_image(rt.get_property(var_block_shadow, 'inner_blocks')) {
			return true
		}
	}
	return false
}

fn render_block_core_post_template(var_attributes rt.PhpVal, var_content_arg rt.PhpVal, var_block rt.PhpVal) string {
	mut var_content := var_content_arg
	mut var_wp_query := rt.new_null()
	mut var_page_key := rt.new_null()
	mut var_enhanced_pagination := rt.new_null()
	mut var_page := rt.new_null()
	mut var_use_global_query := rt.new_null()
	mut var_query := rt.new_null()
	mut var_query_args := rt.new_null()
	mut var_classnames := ''
	mut var_wrapper_attributes := rt.new_null()
	mut var_block_instance := rt.new_null()
	mut var_post_id := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_filter_block_context := rt.new_null()
	mut var_block_content := rt.new_null()
	mut var_post_classes := rt.new_null()
	mut var_inner_block_directives := rt.new_null()
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
	var_use_global_query = rt.new_bool((if !(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('inherit'))).is_null() {
		rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('inherit'))
	} else {
		rt.new_bool(false)
	}).to_bool())
	if rt.is_true(var_use_global_query) {
		if rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{})) {
			var_query = var_wp_query.dup()
			rt.call_method(var_query, 'rewind_posts', []rt.PhpVal{})
		} else {
			var_query = var_wp_query
		}
	} else {
		var_query_args = rt.call_function('build_query_vars_from_query_block', [
			var_block.clone(),
			var_page.clone(),
		])
		var_query = create_wp_query(var_query_args.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_query, 'have_posts', []rt.PhpVal{}))))) {
		return ''
	}
	if rt.is_true(rt.new_bool(block_core_post_template_uses_featured_image(rt.get_property(var_block,
		'inner_blocks'))))
	{
		rt.call_function('update_post_thumbnail_cache', [var_query.clone()])
	}
	var_classnames = ''
	if rt.get_property(var_block, 'context').array_isset(rt.new_string('displayLayout'))
		&& rt.get_property(var_block, 'context').array_isset(rt.new_string('query')) {
		if rt.get_property(var_block, 'context').array_get(rt.new_string('displayLayout')).array_isset(rt.new_string('type'))
			&& rt.is_true(rt.identical(rt.new_string('flex'), rt.get_property(var_block, 'context').array_get(rt.new_string('displayLayout')).array_get(rt.new_string('type')))) {
			var_classnames = rt.concat(rt.new_string('is-flex-container columns-'), rt.get_property(var_block,
				'context').array_get(rt.new_string('displayLayout')).array_get(rt.new_string('columns')))
		}
	}
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		var_classnames = var_classnames + ' has-link-color'
	}
	if var_attributes.array_get(rt.new_string('layout')).array_isset(rt.new_string('type'))
		&& rt.is_true(rt.identical(rt.new_string('grid'), var_attributes.array_get(rt.new_string('layout')).array_get(rt.new_string('type'))))
		&& !(!rt.is_true(var_attributes.array_get(rt.new_string('layout')).array_get(rt.new_string('columnCount')))) {
		var_classnames = var_classnames + ' ' +
			(rt.call_function('sanitize_title', [rt.new_string('columns-' +(var_attributes.array_get(rt.new_string('layout')).array_get(rt.new_string('columnCount'))).str())])).str()
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_classnames.trim_space() }]),
	])
	var_content = ''
	for rt.is_true(rt.call_method(var_query, 'have_posts', []rt.PhpVal{})) {
		rt.call_method(var_query, 'the_post', []rt.PhpVal{})
		var_block_instance = rt.get_property(var_block, 'parsed_block')
		var_block_instance.array_set('blockName', 'core/null')
		var_post_id = rt.call_function('get_the_ID', []rt.PhpVal{})
		var_post_type = rt.call_function('get_post_type', []rt.PhpVal{})
		closure_1_fn := fn [var_post_id, var_post_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			var_context.array_set('postType', var_post_type.clone())
			var_context.array_set('postId', var_post_id.clone())
			return var_context.str()
		}
		var_filter_block_context = rt.new_closure(closure_1_fn)
		rt.call_function('add_filter', [rt.new_string('render_block_context'),
			var_filter_block_context.clone(), rt.new_int(1)])
		var_block_content = rt.call_method(create_wp_block(var_block_instance.clone()), 'render', [
			rt.create_array([rt.ArrayItem{ key: 'dynamic', val: false }]),
		])
		rt.call_function('remove_filter', [rt.new_string('render_block_context'),
			var_filter_block_context.clone(), rt.new_int(1)])
		var_post_classes = rt.call_function('implode', [rt.new_string(' '),
			rt.call_function('get_post_class', [rt.new_string('wp-block-post')])])
		var_inner_block_directives = rt.new_string((if rt.is_true(var_enhanced_pagination) {
			' data-wp-key="post-template-item-' + var_post_id.str() + '"'
		} else {
			''
		}).str())
		var_content = var_content + '<li' + var_inner_block_directives.str() + ' class="' +
			(rt.call_function('esc_attr', [var_post_classes.clone()])).str() + '">' +
			var_block_content.str() + '</li>'
	}
	rt.call_function('wp_reset_postdata', []rt.PhpVal{})
	return (rt.call_function('sprintf', [rt.new_string('<ul %1$s>%2$s</ul>'),
		var_wrapper_attributes.clone(), rt.new_string(var_content.str()).clone()])).str()
}

fn register_block_core_post_template() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/post-template'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_template' },
			rt.ArrayItem{ key: 'skip_inner_blocks', val: true },
		]),
	])
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_Block {
	rt.PhpObjectBase
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block(_args ...rt.PhpVal) &Class_WP_Block {
	mut obj := &Class_WP_Block{
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

fn (mut this Class_WP_Block) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_template')])
}
