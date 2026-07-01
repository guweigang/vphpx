import rt

fn render_block_core_categories(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut var_block_id := rt.new_null()
	// unsupported statement: Stmt_Static
	rt.pre_inc(var_block_id)
	mut var_taxonomy := rt.call_function('get_taxonomy', [var_attributes.array_get('taxonomy')])
	mut var_args := {
		'echo':         rt.new_bool(false)
		'hierarchical': rt.new_bool(!(!rt.is_true(var_attributes.array_get('showHierarchy'))))
		'orderby':      rt.new_string('name')
		'show_count':   rt.new_bool(!(!rt.is_true(var_attributes.array_get('showPostCounts'))))
		'taxonomy':     var_attributes['taxonomy']
		'title_li':     rt.new_string('')
		'hide_empty':   !rt.is_true(var_attributes.array_get('showEmpty'))
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_attributes.array_get('showOnlyTopLevel')))
		&& rt.is_true(var_attributes.array_get('showOnlyTopLevel'))))
	{
		var_args['parent'] = rt.new_int(0)
	}
	if !(!rt.is_true(var_attributes.array_get('displayAsDropdown'))) {
		mut var_id := rt.new_string('wp-block-categories-' + var_block_id.str())
		var_args['id'] = var_id.dup()
		var_args['name'] = rt.get_property(var_taxonomy, 'query_var')
		var_args['value_field'] = rt.new_string('slug')
		var_args['show_option_none'] = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Select %s')]),
			rt.get_property(rt.get_property(var_taxonomy, 'labels'), 'singular_name'),
		])
		var_args['selected'] = rt.call_function('get_query_var', [
			rt.get_property(var_taxonomy, 'query_var'),
		])
		mut var_show_label := if !rt.is_true(var_attributes.array_get('showLabel')) {
			' screen-reader-text'
		} else {
			''
		}
		mut var_default_label := rt.get_property(var_taxonomy, 'label')
		mut var_label_text := if !(!rt.is_true(var_attributes.array_get('label'))) { rt.call_function('wp_kses_post', [
				var_attributes.array_get('label'),
			]) } else { var_default_label }
		mut var_wrapper_markup := rt.new_string(
			'<div %1$s><label class="wp-block-categories__label' + var_show_label + '" for="' +
			(rt.call_function('esc_attr', [var_id.dup()])).str() + '">' + var_label_text.str() +
			'</label>%2$s</div>')
		mut var_items_markup := rt.call_function('wp_dropdown_categories', [
			var_args.dup()])
		mut var_type := 'dropdown'
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
			var_items_markup = rt.call_function('preg_replace', [
				rt.new_string('#(?<=</select>)#'),
				build_dropdown_script_block_core_categories(var_id.dup()),
				var_items_markup.dup(),
				rt.new_int(1),
			])
		}
	} else {
		var_args['show_option_none'] = rt.get_property(rt.get_property(var_taxonomy, 'labels'),
			'no_terms')
		var_wrapper_markup = rt.new_string(rt.new_string('<ul %1$s>%2$s</ul>'))
		var_items_markup = rt.call_function('wp_list_categories', [
			var_args.dup()])
		var_type = 'list'
		if !(!rt.is_true(rt.get_property(var_block, 'context').array_get('enhancedPagination'))) {
			mut var_p := create_wp_html_tag_processor(var_items_markup.dup())
			for rt.is_true(var_p.next_tag(rt.new_string('a'))) {
				var_p.set_attribute(rt.new_string('data-wp-on--click'),
					rt.new_string('core/query::actions.navigate'))
			}
			var_items_markup = var_p.get_updated_html()
		}
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.concat(rt.concat(rt.concat(rt.new_string('wp-block-categories-'),
				rt.new_string(var_type)), rt.new_string(' wp-block-categories-taxonomy-')),
				var_attributes.array_get('taxonomy')) },
		]),
	])
	return rt.call_function('sprintf', [var_wrapper_markup.dup(),
		var_wrapper_attributes.dup(), var_items_markup.dup()])
}

fn build_dropdown_script_block_core_categories(var_dropdown_id rt.PhpVal) rt.PhpVal {
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_exports := [var_dropdown_id, rt.call_function('home_url', []rt.PhpVal{})]
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [var_exports.dup(),
		rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('wp_get_inline_script_tag', [
			rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '<script>' }, rt.ArrayItem{
			key: none
			val: '</script>'
		}]), rt.new_string(''), rt.call_function('ob_get_clean', []rt.PhpVal{})]).to_string().trim_space() +
			'\n//# sourceURL=' + (rt.call_function('rawurlencode', [rt.new_string(@FN)])).str(),
	])
}

fn register_block_core_categories() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/categories',
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_categories' },
		])])
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_html_tag_processor() &Class_WP_HTML_Tag_Processor {
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

pub fn init_wp_includes_blocks_categories_php() {
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_categories')])
}
