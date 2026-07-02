import rt

fn wp_category_checklist(post_id i64, descendants_and_self i64, selected_cats bool, popular_cats bool, var_walker rt.PhpVal, checked_ontop bool) {
	mut var_post_id := post_id
	mut var_descendants_and_self := descendants_and_self
	mut var_selected_cats := selected_cats
	mut var_popular_cats := popular_cats
	mut var_checked_ontop := checked_ontop
	rt.new_string(wp_terms_checklist(post_id, rt.create_array([
		rt.ArrayItem{ key: 'taxonomy', val: 'category' },
		rt.ArrayItem{ key: 'descendants_and_self', val: descendants_and_self },
		rt.ArrayItem{ key: 'selected_cats', val: selected_cats },
		rt.ArrayItem{ key: 'popular_cats', val: popular_cats },
		rt.ArrayItem{ key: 'walker', val: var_walker },
		rt.ArrayItem{ key: 'checked_ontop', val: checked_ontop },
	])))
}

fn wp_terms_checklist(post_id i64, var_args_arg rt.PhpVal) string {
	mut var_post_id := post_id
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_params := rt.new_null()
	mut var_parsed_args := rt.new_null()
	mut var_walker := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_descendants_and_self := rt.new_null()
	mut var_tax := rt.new_null()
	mut var_categories := rt.new_null()
	mut var_self := rt.new_null()
	mut var_output := ''
	mut var_checked_categories := rt.new_null()
	mut var_keys := rt.new_null()
	mut var_k := rt.new_null()
	var_defaults = {
		'descendants_and_self': rt.new_int(0)
		'selected_cats':        rt.new_bool(false)
		'popular_cats':         rt.new_bool(false)
		'walker':               rt.new_null()
		'taxonomy':             rt.new_string('category')
		'checked_ontop':        rt.new_bool(true)
		'echo':                 rt.new_bool(true)
	}
	var_params = rt.call_function('apply_filters', [
		rt.new_string('wp_terms_checklist_args'),
		rt.create_array_from_native_map(var_args),
		rt.new_int(post_id),
	])
	var_parsed_args = rt.call_function('wp_parse_args', [var_params.clone(),
		rt.create_array_from_native_map(var_defaults)])
	if !rt.is_true(var_parsed_args.array_get(rt.new_string('walker')))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_parsed_args.array_get(rt.new_string('walker')), 'Walker')))))) {
		var_walker = create_walker_category_checklist()
	} else {
		var_walker = var_parsed_args.array_get(rt.new_string('walker'))
	}
	var_taxonomy = var_parsed_args.array_get(rt.new_string('taxonomy'))
	var_descendants_and_self =
		rt.new_int((var_parsed_args.array_get(rt.new_string('descendants_and_self'))).to_i64())
	var_args = {
		'taxonomy': var_taxonomy
	}
	var_tax = rt.call_function('get_taxonomy', [var_taxonomy.clone()])
	var_args.array_set('disabled', !(rt.is_true(rt.call_function('current_user_can', [
		rt.get_property(rt.get_property(var_tax, 'cap'), 'assign_terms'),
	]))))
	var_args.array_set('list_only',
		!(!rt.is_true(var_parsed_args.array_get(rt.new_string('list_only')))))
	if rt.is_true(rt.new_bool(var_parsed_args.array_get(rt.new_string('selected_cats')).is_array())) {
		var_args.array_set('selected_cats', rt.call_function('array_map', [
			rt.new_string('intval'),
			var_parsed_args.array_get(rt.new_string('selected_cats')),
		]))
	} else if var_post_id != 0 {
		var_args.array_set('selected_cats', rt.call_function('wp_get_object_terms', [
			rt.new_int(post_id),
			var_taxonomy.clone(),
			rt.call_function('array_merge', [rt.create_array_from_native_map(var_args),
				rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }])]),
		]))
	} else {
		var_args.array_set('selected_cats', rt.new_array())
	}
	if rt.is_true(rt.new_bool(var_parsed_args.array_get(rt.new_string('popular_cats')).is_array())) {
		var_args.array_set('popular_cats', rt.call_function('array_map', [
			rt.new_string('intval'),
			var_parsed_args.array_get(rt.new_string('popular_cats')),
		]))
	} else {
		var_args.array_set('popular_cats', rt.call_function('get_terms', [
			rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
				rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{
					key: 'orderby'
					val: 'count'
				}, rt.ArrayItem{ key: 'order', val: 'DESC' },
				rt.ArrayItem{ key: 'number', val: 10 }, rt.ArrayItem{
					key: 'hierarchical'
					val: false
				}]),
		]))
	}
	if rt.is_true(var_descendants_and_self) {
		var_categories = rt.cast_array(rt.call_function('get_terms', [
			rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
				rt.ArrayItem{ key: 'child_of', val: var_descendants_and_self },
				rt.ArrayItem{ key: 'hierarchical', val: 0 }, rt.ArrayItem{ key: 'hide_empty', val: 0 }]),
		]))
		var_self = rt.call_function('get_term', [var_descendants_and_self.clone(),
			var_taxonomy.clone()])
		rt.call_function('array_unshift', [var_categories.clone(),
			var_self.clone()])
	} else {
		var_categories = rt.cast_array(rt.call_function('get_terms', [
			rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
				rt.ArrayItem{ key: 'get', val: 'all' }]),
		]))
	}
	var_output = ''
	if rt.is_true(var_parsed_args.array_get(rt.new_string('checked_ontop'))) {
		var_checked_categories = rt.new_array()
		var_keys = rt.func_array_keys(var_categories.clone())
		mut iter_1 := var_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_k_shadow := item_1.val
			if rt.is_true(rt.call_function('in_array', [
				rt.get_property(var_categories.array_get(var_k_shadow), 'term_id'),
				var_args.array_get(rt.new_string('selected_cats')),
				rt.new_bool(true),
			]))
			{
				var_checked_categories.array_push(var_categories.array_get(var_k_shadow))
				var_categories.array_unset(var_k_shadow)
			}
		}
		var_output = var_output +(rt.call_method(var_walker, 'walk', [var_checked_categories.clone(), rt.new_int(0), rt.create_array_from_native_map(var_args)])).str()
	}
	var_output = var_output +(rt.call_method(var_walker, 'walk', [var_categories.clone(), rt.new_int(0), rt.create_array_from_native_map(var_args)])).str()
	if rt.is_true(var_parsed_args.array_get(rt.new_string('echo'))) {
		print(var_output)
	}
	return var_output
}

fn wp_popular_terms_checklist(var_taxonomy rt.PhpVal, default_term i64, number i64, display bool) rt.PhpVal {
	mut var_default_term := default_term
	mut var_number := number
	mut var_display := display
	mut var_post := rt.new_null()
	mut var_checked_terms := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_tax := rt.new_null()
	mut var_popular_ids := []rt.PhpVal{}
	mut var_term := rt.new_null()
	mut var_id := ''
	mut var_checked := ''
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if rt.is_true(var_post) && rt.is_true(rt.get_property(var_post, 'ID')) {
		var_checked_terms = rt.call_function('wp_get_object_terms', [
			rt.get_property(var_post, 'ID'),
			var_taxonomy.clone(),
			rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }]),
		])
	} else {
		var_checked_terms = rt.new_array()
	}
	var_terms = rt.call_function('get_terms', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
			rt.ArrayItem{ key: 'orderby', val: 'count' }, rt.ArrayItem{ key: 'order', val: 'DESC' },
			rt.ArrayItem{ key: 'number', val: number }, rt.ArrayItem{
				key: 'hierarchical'
				val: false
			}]),
	])
	var_tax = rt.call_function('get_taxonomy', [var_taxonomy.clone()])
	var_popular_ids = rt.new_array()
	mut iter_2 := rt.cast_array(var_terms).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_term_shadow := item_2.val
		var_popular_ids << rt.get_property(var_term_shadow, 'term_id')
		if !var_display {
			continue
		}
		var_id = rt.concat(rt.concat(rt.concat(rt.new_string('popular-'), var_taxonomy),
			rt.new_string('-')), rt.get_property(var_term_shadow, 'term_id'))
		var_checked = if rt.is_true(rt.call_function('in_array', [
			rt.get_property(var_term_shadow, 'term_id'),
			var_checked_terms.clone(),
			rt.new_bool(true),
		]))
		{ 'checked="checked"' } else { '' }
		// unsupported statement: Stmt_InlineHTML
		print(var_id)
		// unsupported statement: Stmt_InlineHTML
		print(var_id)
		// unsupported statement: Stmt_InlineHTML
		print(var_checked)
		// unsupported statement: Stmt_InlineHTML
		print(rt.new_int((rt.get_property(var_term_shadow, 'term_id')).to_i64()).str())
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('disabled', [
			rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
				rt.get_property(rt.get_property(var_tax, 'cap'), 'assign_terms'),
			])))),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('apply_filters', [rt.new_string('the_category'),
				rt.get_property(var_term_shadow, 'name'), rt.new_string(''),
				rt.new_string('')]),
		]))
		// unsupported statement: Stmt_InlineHTML
	}
	return var_popular_ids.clone()
}

fn wp_link_category_checklist(link_id i64) {
	mut var_link_id := link_id
	mut var_default := i64(0)
	mut var_checked_categories := rt.new_null()
	mut var_categories := rt.new_null()
	mut var_category := rt.new_null()
	mut var_cat_id := rt.new_null()
	mut var_name := rt.new_null()
	mut var_checked := ''
	var_default = 1
	var_checked_categories = rt.new_array()
	if var_link_id != 0 {
		var_checked_categories = rt.call_function('wp_get_link_cats', [
			rt.new_int(link_id),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_checked_categories.clone().array_count()))))) {
			var_checked_categories.array_push(var_default)
		}
	} else {
		var_checked_categories.array_push(var_default)
	}
	var_categories = rt.call_function('get_terms', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'link_category' },
			rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'hide_empty', val: 0 }]),
	])
	if !rt.is_true(var_categories) {
		return
	}
	mut iter_3 := var_categories.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_category_shadow := item_3.val
		var_cat_id = rt.get_property(var_category_shadow, 'term_id')
		var_name = rt.call_function('esc_html', [
			rt.call_function('apply_filters', [rt.new_string('the_category'),
				rt.get_property(var_category_shadow, 'name'),
				rt.new_string(''), rt.new_string('')]),
		])
		var_checked = if rt.is_true(rt.call_function('in_array', [
			var_cat_id.clone(), var_checked_categories.clone(),
			rt.new_bool(true)]))
		{ ' checked="checked"' } else { '' }
		print('<li id="link-category-')
		rt.echo_val(var_cat_id)
		print('"><label for="in-link-category-')
		rt.echo_val(var_cat_id)
		print('" class="selectit"><input value="')
		rt.echo_val(var_cat_id)
		print('" type="checkbox" name="link_category[]" id="in-link-category-')
		rt.echo_val(var_cat_id)
		print('"')
		print(var_checked)
		print('/> ')
		rt.echo_val(var_name)
		print('</label></li>')
	}
}

fn get_inline_data(var_post rt.PhpVal) {
	mut var_post_type_object := rt.new_null()
	mut var_title := rt.new_null()
	mut var_taxonomy_names := rt.new_null()
	mut var_taxonomy_name := rt.new_null()
	mut var_taxonomy := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_term_ids := rt.new_null()
	mut var_terms_to_edit := rt.new_null()
	var_post_type_object = rt.call_function('get_post_type_object', [
		rt.get_property(var_post, 'post_type'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_post'),
		rt.get_property(var_post, 'ID'),
	])))))
	{
		return
	}
	var_title = rt.call_function('esc_textarea', [
		rt.new_string(rt.get_property(var_post, 'post_title').to_string().trim_space()),
	])
	print('\n<div class="hidden" id="inline_' + (rt.get_property(var_post, 'ID')).str() +
		'">\n\t<div class="post_title">' + var_title.str() + '</div>' + '<div class="post_name">' +
		(rt.call_function('apply_filters', [rt.new_string('editable_slug'), rt.get_property(var_post, 'post_name'), var_post.clone()])).str() +
		'</div>\n\t<div class="post_author">' + (rt.get_property(var_post, 'post_author')).str() +
		'</div>\n\t<div class="comment_status">' +
		(rt.call_function('esc_html', [rt.get_property(var_post, 'comment_status')])).str() +
		'</div>\n\t<div class="ping_status">' +
		(rt.call_function('esc_html', [rt.get_property(var_post, 'ping_status')])).str() +
		'</div>\n\t<div class="_status">' +
		(rt.call_function('esc_html', [rt.get_property(var_post, 'post_status')])).str() +
		'</div>\n\t<div class="jj">' +
		(rt.call_function('mysql2date', [rt.new_string('d'), rt.get_property(var_post, 'post_date'), rt.new_bool(false)])).str() +
		'</div>\n\t<div class="mm">' +
		(rt.call_function('mysql2date', [rt.new_string('m'), rt.get_property(var_post, 'post_date'), rt.new_bool(false)])).str() +
		'</div>\n\t<div class="aa">' +
		(rt.call_function('mysql2date', [rt.new_string('Y'), rt.get_property(var_post, 'post_date'), rt.new_bool(false)])).str() +
		'</div>\n\t<div class="hh">' +
		(rt.call_function('mysql2date', [rt.new_string('H'), rt.get_property(var_post, 'post_date'), rt.new_bool(false)])).str() +
		'</div>\n\t<div class="mn">' +
		(rt.call_function('mysql2date', [rt.new_string('i'), rt.get_property(var_post, 'post_date'), rt.new_bool(false)])).str() +
		'</div>\n\t<div class="ss">' +
		(rt.call_function('mysql2date', [rt.new_string('s'), rt.get_property(var_post, 'post_date'), rt.new_bool(false)])).str() +
		'</div>\n\t<div class="post_password">' +
		(rt.call_function('esc_html', [rt.get_property(var_post, 'post_password')])).str() +
		'</div>')
	if rt.is_true(rt.get_property(var_post_type_object, 'hierarchical')) {
		print('<div class="post_parent">' + (rt.get_property(var_post, 'post_parent')).str() +
			'</div>')
	}
	print('<div class="page_template">' +
		(if rt.is_true(rt.get_property(var_post, 'page_template')) { rt.call_function('esc_html', [rt.get_property(var_post, 'page_template')]) } else { rt.new_string('default') }).str() +
		'</div>')
	if rt.is_true(rt.call_function('post_type_supports', [
		rt.get_property(var_post, 'post_type'),
		rt.new_string('page-attributes'),
	]))
	{
		print('<div class="menu_order">' + (rt.get_property(var_post, 'menu_order')).str() +
			'</div>')
	}
	var_taxonomy_names = rt.call_function('get_object_taxonomies', [
		rt.get_property(var_post, 'post_type'),
	])
	mut iter_4 := var_taxonomy_names.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_taxonomy_name_shadow := item_4.val
		var_taxonomy = rt.call_function('get_taxonomy', [var_taxonomy_name_shadow.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_taxonomy, 'show_in_quick_edit'))))) {
			continue
		}
		if rt.is_true(rt.get_property(var_taxonomy, 'hierarchical')) {
			var_terms = rt.call_function('get_object_term_cache', [
				rt.get_property(var_post, 'ID'),
				var_taxonomy_name_shadow.clone(),
			])
			if rt.is_true(rt.identical(rt.new_bool(false), var_terms)) {
				var_terms = rt.call_function('wp_get_object_terms', [
					rt.get_property(var_post, 'ID'),
					var_taxonomy_name_shadow.clone(),
				])
				rt.call_function('wp_cache_add', [rt.get_property(var_post, 'ID'),
					rt.call_function('wp_list_pluck', [var_terms.clone(),
						rt.new_string('term_id')]),
					rt.new_string(var_taxonomy_name_shadow.str() + '_relationships')])
			}
			var_term_ids = if !rt.is_true(var_terms) { rt.new_array() } else { rt.call_function('wp_list_pluck', [
					var_terms.clone(),
					rt.new_string('term_id'),
				]) }
			print('<div class="post_category" id="' + var_taxonomy_name_shadow.str() + '_' +
				(rt.get_property(var_post, 'ID')).str() + '">' +
				(rt.call_function('implode', [rt.new_string(','), var_term_ids.clone()])).str() +
				'</div>')
		} else {
			var_terms_to_edit = rt.call_function('get_terms_to_edit', [
				rt.get_property(var_post, 'ID'),
				var_taxonomy_name_shadow.clone(),
			])
			if !(var_terms_to_edit.clone().is_string()) {
				var_terms_to_edit = rt.new_string('')
			}
			print('<div class="tags_input" id="' + var_taxonomy_name_shadow.str() + '_' +
				(rt.get_property(var_post, 'ID')).str() + '">' +
				(rt.call_function('esc_html', [rt.call_function('str_replace', [rt.new_string(','), rt.new_string(', '), var_terms_to_edit.clone()])])).str() +
				'</div>')
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_type_object, 'hierarchical'))))) {
		print('<div class="sticky">' +
			if rt.is_true(rt.call_function('is_sticky', [rt.get_property(var_post, 'ID')])) { 'sticky' } else { '' } +
			'</div>')
	}
	if rt.is_true(rt.call_function('post_type_supports', [
		rt.get_property(var_post, 'post_type'),
		rt.new_string('post-formats'),
	]))
	{
		print('<div class="post_format">' +
			(rt.call_function('esc_html', [rt.call_function('get_post_format', [rt.get_property(var_post, 'ID')])])).str() +
			'</div>')
	}
	rt.call_function('do_action', [rt.new_string('add_inline_data'),
		var_post.clone(), var_post_type_object.clone()])
	print('</div>')
}

fn wp_comment_reply(position i64, checkbox bool, mode string, table_row bool) {
	mut var_position := position
	mut var_checkbox := checkbox
	mut var_mode := mode
	mut var_table_row := table_row
	mut var_content := rt.new_null()
	mut var_wp_list_table := rt.new_null()
	mut var_quicktags_settings := map[string]rt.PhpVal{}
	var_content = rt.call_function('apply_filters', [rt.new_string('wp_comment_reply'),
		rt.new_string(''),
		rt.create_array([
			rt.ArrayItem{ key: 'position', val: position },
			rt.ArrayItem{ key: 'checkbox', val: checkbox },
			rt.ArrayItem{ key: 'mode', val: mode },
		])])
	if !(!rt.is_true(var_content)) {
		rt.echo_val(var_content)
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_list_table)))) {
		if rt.is_true(rt.identical(rt.new_string('single'), rt.new_string(mode))) {
			var_wp_list_table = rt.call_function('_get_list_table', [
				rt.new_string('WP_Post_Comments_List_Table'),
			])
		} else {
			var_wp_list_table = rt.call_function('_get_list_table', [
				rt.new_string('WP_Comments_List_Table'),
			])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	if var_table_row {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_method(var_wp_list_table, 'get_column_count', []rt.PhpVal{}))
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Edit Comment')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Reply to Comment')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Add Comment')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Comment')])
	// unsupported statement: Stmt_InlineHTML
	var_quicktags_settings = {
		'buttons': 'strong,em,link,block,del,ins,img,ul,ol,li,code,close'
	}
	rt.call_function('wp_editor', [rt.new_string(''), rt.new_string('replycontent'),
		rt.create_array([rt.ArrayItem{ key: 'media_buttons', val: false },
			rt.ArrayItem{ key: 'tinymce', val: false }, rt.ArrayItem{
				key: 'quicktags'
				val: var_quicktags_settings
			}])])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Name')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Email')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('URL')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Add Comment')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Update Comment')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Submit Reply')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Cancel')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_notice', [rt.new_string('<p class="error"></p>'),
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'error' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'notice-alt' },
				rt.ArrayItem{ key: none, val: 'inline' },
				rt.ArrayItem{ key: none, val: 'hidden' },
			]) }, rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
	// unsupported statement: Stmt_InlineHTML
	print(var_position.str())
	// unsupported statement: Stmt_InlineHTML
	print(if var_checkbox { 1 } else { 0 }.str())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.new_string(mode)]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('replyto-comment'),
		rt.new_string('_ajax_nonce-replyto-comment'), rt.new_bool(false)])
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('unfiltered_html')])) {
		rt.call_function('wp_nonce_field', [rt.new_string('unfiltered-html-comment'),
			rt.new_string('_wp_unfiltered_html_comment'), rt.new_bool(false)])
	}
	// unsupported statement: Stmt_InlineHTML
	if var_table_row {
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}

fn wp_comment_trashnotice() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Comment by %s moved to the Trash.')]),
		rt.new_string('<strong></strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Undo')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Comment by %s marked as spam.')]),
		rt.new_string('<strong></strong>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Undo')])
	// unsupported statement: Stmt_InlineHTML
}

fn list_meta(var_meta rt.PhpVal) {
	mut var_count := i64(0)
	mut var_entry := map[string]rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_meta)))) {
		print(
			'\n<table id="list-table" style="display: none;">\n\t<thead>\n\t<tr>\n\t\t<th class="left">' +
			(rt.call_function('_x', [rt.new_string('Name'), rt.new_string('meta name')])).str() +
			'</th>\n\t\t<th>' + (rt.call_function('__', [rt.new_string('Value')])).str() +
			'</th>\n\t</tr>\n\t</thead>\n\t<tbody id="the-list" data-wp-lists="list:meta">\n\t<tr><td></td></tr>\n\t</tbody>\n</table>')
		return
	}
	var_count = 0
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Name'), rt.new_string('meta name')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Value')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_5 := var_meta.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_entry_shadow := item_5.val
		print(_list_meta_row(var_entry_shadow.clone(), var_count))
	}
	// unsupported statement: Stmt_InlineHTML
}

fn _list_meta_row(var_entry rt.PhpVal, var_count rt.PhpVal) string {
	mut var_update_nonce := rt.new_null()
	mut var_r := ''
	mut var_delete_nonce := rt.new_null()
	if rt.is_true(rt.call_function('is_protected_meta',
		[var_entry['meta_key'], rt.new_string('post')]))
	{
		return ''
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_update_nonce)))) {
		var_update_nonce = rt.call_function('wp_create_nonce', [
			rt.new_string('add-meta'),
		])
	}
	var_r = ''
	rt.pre_inc(var_count)
	if rt.is_true(rt.call_function('is_serialized', [var_entry['meta_value']])) {
		if rt.is_true(rt.call_function('is_serialized_string', [var_entry['meta_value']])) {
			var_entry['meta_value'] = rt.call_function('maybe_unserialize', [
				var_entry['meta_value'],
			])
		} else {
			rt.pre_dec(var_count)
			return ''
		}
	}
	var_entry['meta_key'] = rt.call_function('esc_attr', [var_entry['meta_key']])
	var_entry['meta_value'] = rt.call_function('esc_textarea', [var_entry['meta_value']])
	var_entry['meta_id'] = rt.new_int((var_entry['meta_id']).to_i64())
	var_delete_nonce = rt.call_function('wp_create_nonce', [
		rt.new_string('delete-meta_' + (var_entry['meta_id']).str()),
	])
	var_r = var_r +
		rt.concat(rt.concat(rt.new_string("\n\t<tr id='meta-"), var_entry['meta_id']), rt.new_string("'>"))
	var_r = var_r +
		rt.concat(rt.concat(rt.new_string("\n\t\t<td class='left'><label class='screen-reader-text' for='meta-"), var_entry['meta_id']), rt.new_string("-key'>")) +
		(rt.call_function('__', [rt.new_string('Key')])).str() +
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("</label><input name='meta["), var_entry['meta_id']), rt.new_string("][key]' id='meta-")), var_entry['meta_id']), rt.new_string("-key' type='text' size='20' value='")), var_entry['meta_key']), rt.new_string("' />"))
	var_r = var_r + "\n\t\t<div class='submit'>"
	var_r = var_r + (get_submit_button(rt.call_function('__', [rt.new_string('Delete')]), 'deletemeta small', rt.concat(rt.concat(rt.new_string('deletemeta['), var_entry['meta_id']), rt.new_string(']')), false, rt.create_array([rt.ArrayItem{
		key: 'data-wp-lists'
		val: rt.concat(rt.concat(rt.concat(rt.new_string('delete:the-list:meta-'), var_entry['meta_id']), rt.new_string('::_ajax_nonce=')), var_delete_nonce)
	}]))).str()
	var_r = var_r + '\n\t\t'
	var_r = var_r + (get_submit_button(rt.call_function('__', [rt.new_string('Update')]), 'updatemeta small', rt.concat(rt.concat(rt.new_string('meta-'), var_entry['meta_id']), rt.new_string('-submit')), false, rt.create_array([rt.ArrayItem{
		key: 'data-wp-lists'
		val: rt.concat(rt.concat(rt.concat(rt.new_string('add:the-list:meta-'), var_entry['meta_id']), rt.new_string('::_ajax_nonce-add-meta=')), var_update_nonce)
	}]))).str()
	var_r = var_r + '</div>'
	var_r = var_r +(rt.call_function('wp_nonce_field', [rt.new_string('change-meta'), rt.new_string('_ajax_nonce'), rt.new_bool(false), rt.new_bool(false)])).str()
	var_r = var_r + '</td>'
	var_r = var_r +
		rt.concat(rt.concat(rt.new_string("\n\t\t<td><label class='screen-reader-text' for='meta-"), var_entry['meta_id']), rt.new_string("-value'>")) +
		(rt.call_function('__', [rt.new_string('Value')])).str() +
		rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("</label><textarea name='meta["), var_entry['meta_id']), rt.new_string("][value]' id='meta-")), var_entry['meta_id']), rt.new_string("-value' rows='2' cols='30'>")), var_entry['meta_value']), rt.new_string('</textarea></td>\n\t</tr>'))
	return var_r
}

fn meta_form(var_post_arg rt.PhpVal) {
	mut var_post := var_post_arg
	mut var_wpdb := rt.new_null()
	mut var_keys := rt.new_null()
	mut var_limit := rt.new_null()
	mut var_key := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	var_keys = rt.call_function('apply_filters', [rt.new_string('postmeta_form_keys'),
		rt.new_null(), var_post.clone()])
	if rt.is_true(rt.identical(rt.new_null(), var_keys)) {
		var_limit = rt.call_function('apply_filters', [
			rt.new_string('postmeta_form_limit'),
			rt.new_int(30),
		])
		var_keys = rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT DISTINCT meta_key\n\t\t\t\tFROM '), rt.get_property(var_wpdb,
					'postmeta')),
					rt.new_string("\n\t\t\t\tWHERE meta_key NOT BETWEEN '_' AND '_z'\n\t\t\t\tHAVING meta_key NOT LIKE %s\n\t\t\t\tORDER BY meta_key\n\t\t\t\tLIMIT %d")),
				rt.new_string((rt.call_method(var_wpdb, 'esc_like', [rt.new_string('_')])).str() +
					'%'),
				var_limit.clone(),
			]),
		])
	}
	if rt.is_true(var_keys) {
		rt.call_function('natcasesort', [var_keys.clone()])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Add Custom Field:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Name'), rt.new_string('meta name')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Value')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_keys) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('&mdash; Select &mdash;')])
		// unsupported statement: Stmt_InlineHTML
		mut iter_6 := var_keys.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_key_shadow := item_6.val
			if rt.is_true(rt.call_function('is_protected_meta', [var_key_shadow.clone(), rt.new_string('post')]))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('add_post_meta'), rt.get_property(var_post, 'ID'), var_key_shadow.clone()]))))) {
				continue
			}
			print("\n<option value='" +
				(rt.call_function('esc_attr', [var_key_shadow.clone()])).str() + "'>" +
				(rt.call_function('esc_html', [var_key_shadow.clone()])).str() + '</option>')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('New custom field name')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Enter new')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Cancel')])
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('add-meta'),
		rt.new_string('_ajax_nonce-add-meta'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	submit_button(rt.call_function('__', [rt.new_string('Add Custom Field')]), '', 'addmeta',
		false, rt.create_array([rt.ArrayItem{ key: 'id', val: 'newmeta-submit' },
		rt.ArrayItem{ key: 'data-wp-lists', val: 'add:the-list:newmeta' }]))
	// unsupported statement: Stmt_InlineHTML
}

fn touch_time(edit i64, for_post i64, tab_index i64, multi i64) {
	mut var_edit := edit
	mut var_for_post := for_post
	mut var_tab_index := tab_index
	mut var_multi := multi
	mut var_wp_locale := rt.new_null()
	mut var_unit := rt.new_null()
	mut var_curr := rt.new_null()
	mut var_post := rt.new_null()
	mut var_tab_index_attribute := ''
	mut var_post_date := rt.new_null()
	mut var_jj := rt.new_null()
	mut var_mm := rt.new_null()
	mut var_aa := rt.new_null()
	mut var_hh := rt.new_null()
	mut var_mn := rt.new_null()
	mut var_ss := rt.new_null()
	mut var_cur_jj := rt.new_null()
	mut var_cur_mm := rt.new_null()
	mut var_cur_aa := rt.new_null()
	mut var_cur_hh := rt.new_null()
	mut var_cur_mn := rt.new_null()
	mut var_month := rt.new_null()
	mut var_monthnum := rt.new_null()
	mut var_monthtext := rt.new_null()
	mut var_i := i64(0)
	mut var_day := rt.new_null()
	mut var_year := rt.new_null()
	mut var_hour := rt.new_null()
	mut var_minute := rt.new_null()
	mut var_map := map[string]rt.PhpVal{}
	mut var_value := rt.new_null()
	mut var_timeunit := rt.new_null()
	mut var_cur_timeunit := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if var_for_post != 0 {
		var_edit = !(
			rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'post_status'), rt.create_array([rt.ArrayItem{
			key: none
			val: 'draft'
		}, rt.ArrayItem{ key: none, val: 'pending' }]), rt.new_bool(true)]))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post, 'post_date_gmt')))))
			|| rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), rt.get_property(var_post, 'post_date_gmt'))))
	}
	var_tab_index_attribute = ''
	if tab_index > 0 {
		var_tab_index_attribute = " tabindex=\"${var_tab_index.str()}\""
	}
	var_post_date = if var_for_post != 0 {
		rt.get_property(var_post, 'post_date')
	} else {
		rt.get_property(rt.call_function('get_comment', []rt.PhpVal{}), 'comment_date')
	}
	var_jj = if var_edit != 0 { rt.call_function('mysql2date', [
			rt.new_string('d'), var_post_date.clone(), rt.new_bool(false)]) } else { rt.call_function('current_time', [
			rt.new_string('d'),
		]) }
	var_mm = if var_edit != 0 { rt.call_function('mysql2date', [
			rt.new_string('m'), var_post_date.clone(), rt.new_bool(false)]) } else { rt.call_function('current_time', [
			rt.new_string('m'),
		]) }
	var_aa = if var_edit != 0 { rt.call_function('mysql2date', [
			rt.new_string('Y'), var_post_date.clone(), rt.new_bool(false)]) } else { rt.call_function('current_time', [
			rt.new_string('Y'),
		]) }
	var_hh = if var_edit != 0 { rt.call_function('mysql2date', [
			rt.new_string('H'), var_post_date.clone(), rt.new_bool(false)]) } else { rt.call_function('current_time', [
			rt.new_string('H'),
		]) }
	var_mn = if var_edit != 0 { rt.call_function('mysql2date', [
			rt.new_string('i'), var_post_date.clone(), rt.new_bool(false)]) } else { rt.call_function('current_time', [
			rt.new_string('i'),
		]) }
	var_ss = if var_edit != 0 { rt.call_function('mysql2date', [
			rt.new_string('s'), var_post_date.clone(), rt.new_bool(false)]) } else { rt.call_function('current_time', [
			rt.new_string('s'),
		]) }
	var_cur_jj = rt.call_function('current_time', [rt.new_string('d')])
	var_cur_mm = rt.call_function('current_time', [rt.new_string('m')])
	var_cur_aa = rt.call_function('current_time', [rt.new_string('Y')])
	var_cur_hh = rt.call_function('current_time', [rt.new_string('H')])
	var_cur_mn = rt.call_function('current_time', [rt.new_string('i')])
	var_month = rt.new_string('<label><span class="screen-reader-text">' +
		(rt.call_function('__', [rt.new_string('Month')])).str() +
		'</span><select class="form-required" ' + if var_multi != 0 { '' } else { 'id="mm" ' } +
		'name="mm"' + var_tab_index_attribute + '>\n')
	var_i = 1
	for {
		if !(var_i < 13) { break
		 }
		var_monthnum = rt.call_function('zeroise', [rt.new_int(var_i).clone(),
			rt.new_int(2)])
		var_monthtext = rt.call_method(var_wp_locale, 'get_month_abbrev', [
			rt.call_method(var_wp_locale, 'get_month', [rt.new_int(var_i).clone()]),
		])
		var_month = rt.concat(var_month, rt.new_string('\t\t\t' + '<option value="' +
			var_monthnum.str() + '" data-text="' + var_monthtext.str() + '" ' +
			(rt.call_function('selected', [var_monthnum.clone(), var_mm.clone(), rt.new_bool(false)])).str() +
			'>'))
		var_month = rt.concat(var_month, rt.new_string(
			(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s-%2$s')]), var_monthnum.clone(), var_monthtext.clone()])).str() +
			'</option>\n'))
		var_i = var_i + 1
	}
	var_month = rt.concat(var_month, rt.new_string('</select></label>'))
	var_day = rt.new_string('<label><span class="screen-reader-text">' +
		(rt.call_function('__', [rt.new_string('Day')])).str() + '</span><input type="text" ' +
		if var_multi != 0 { '' } else { 'id="jj" ' } + 'name="jj" value="' + var_jj.str() +
		'" size="2" maxlength="2"' + var_tab_index_attribute +
		' autocomplete="off" class="form-required" inputmode="numeric" /></label>')
	var_year = rt.new_string('<label><span class="screen-reader-text">' +
		(rt.call_function('__', [rt.new_string('Year')])).str() + '</span><input type="text" ' +
		if var_multi != 0 { '' } else { 'id="aa" ' } + 'name="aa" value="' + var_aa.str() +
		'" size="4" maxlength="4"' + var_tab_index_attribute +
		' autocomplete="off" class="form-required" inputmode="numeric" /></label>')
	var_hour = rt.new_string('<label><span class="screen-reader-text">' +
		(rt.call_function('__', [rt.new_string('Hour')])).str() + '</span><input type="text" ' +
		if var_multi != 0 { '' } else { 'id="hh" ' } + 'name="hh" value="' + var_hh.str() +
		'" size="2" maxlength="2"' + var_tab_index_attribute +
		' autocomplete="off" class="form-required" inputmode="numeric" /></label>')
	var_minute = rt.new_string('<label><span class="screen-reader-text">' +
		(rt.call_function('__', [rt.new_string('Minute')])).str() + '</span><input type="text" ' +
		if var_multi != 0 { '' } else { 'id="mn" ' } + 'name="mn" value="' + var_mn.str() +
		'" size="2" maxlength="2"' + var_tab_index_attribute +
		' autocomplete="off" class="form-required" inputmode="numeric" /></label>')
	print('<div class="timestamp-wrap">')
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('%1$s %2$s, %3$s at %4$s:%5$s')]),
		var_month.clone(),
		var_day.clone(),
		var_year.clone(),
		var_hour.clone(),
		var_minute.clone(),
	])
	print('</div><input type="hidden" id="ss" name="ss" value="' + var_ss.str() + '" />')
	if var_multi != 0 {
		return
	}
	print('\n\n')
	var_map = {
		'mm': map[string]rt.PhpVal{}
		'jj': map[string]rt.PhpVal{}
		'aa': map[string]rt.PhpVal{}
		'hh': map[string]rt.PhpVal{}
		'mn': map[string]rt.PhpVal{}
	}
	for var_timeunit_shadow, var_value_shadow in var_map {
		mut list_tmp_1 := var_value_shadow
		var_unit = list_tmp_1.array_get(0)
		var_curr = list_tmp_1.array_get(1)
		print('<input type="hidden" id="hidden_' +
			(rt.new_string(var_timeunit_shadow.str())).str() + '" name="hidden_' + (rt.new_string(var_timeunit_shadow.str())).str() + '" value="' + var_unit.str() +
			'" />' + '\n')
		var_cur_timeunit = rt.new_string('cur_' + (rt.new_string(var_timeunit_shadow.str())).str())
		print('<input type="hidden" id="' + var_cur_timeunit.str() + '" name="' +
			var_cur_timeunit.str() + '" value="' + var_curr.str() + '" />' + '\n')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('OK')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Cancel')])
	// unsupported statement: Stmt_InlineHTML
}

fn page_template_dropdown(default_template string, post_type string) {
	mut var_default_template := default_template
	mut var_post_type := post_type
	mut var_templates := rt.new_null()
	mut var_template := rt.new_null()
	mut var_selected := rt.new_null()
	var_templates = rt.call_function('get_page_templates', [rt.new_null(),
		rt.new_string(post_type)])
	rt.call_function('ksort', [var_templates.clone()])
	mut iter_7 := rt.func_array_keys(var_templates.clone()).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_template_shadow := item_7.val
		var_selected = rt.call_function('selected', [rt.new_string(default_template),
			var_templates.array_get(var_template_shadow), rt.new_bool(false)])
		print("\n\t<option value='" +
			(rt.call_function('esc_attr', [var_templates.array_get(var_template_shadow)])).str() +
			"' ${var_selected.to_string()}>" +
			(rt.call_function('esc_html', [var_template_shadow.clone()])).str() + '</option>')
	}
}

fn parent_dropdown(default_page i64, parent_page i64, level i64, var_post_arg rt.PhpVal) bool {
	mut var_default_page := default_page
	mut var_parent_page := parent_page
	mut var_level := level
	mut var_post := var_post_arg
	mut var_wpdb := rt.new_null()
	mut var_items := rt.new_null()
	mut var_item := rt.new_null()
	mut var_pad := rt.new_null()
	mut var_selected := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	var_items = rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT ID, post_parent, post_title\n\t\t\tFROM '), rt.get_property(var_wpdb,
				'posts')),
				rt.new_string("\n\t\t\tWHERE post_parent = %d AND post_type = 'page'\n\t\t\tORDER BY menu_order")),
			rt.new_int(parent_page),
		]),
	])
	if rt.is_true(var_items) {
		mut iter_8 := var_items.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_item_shadow := item_8.val
			if rt.is_true(var_post) && rt.is_true(rt.get_property(var_post, 'ID'))
				&& rt.is_true(rt.identical(rt.new_int((rt.get_property(var_item_shadow, 'ID')).to_i64()), rt.get_property(var_post, 'ID'))) {
				continue
			}
			var_pad = rt.call_function('str_repeat', [rt.new_string('&nbsp;'),
				rt.new_int(level * 3)])
			var_selected = rt.call_function('selected', [rt.new_int(default_page),
				rt.get_property(var_item_shadow, 'ID'), rt.new_bool(false)])
			print(
				rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string("\n\t<option class='level-"), rt.new_int(level)), rt.new_string("' value='")), rt.get_property(var_item_shadow, 'ID')), rt.new_string("' ")), var_selected), rt.new_string('>')), var_pad), rt.new_string(' ')) +
				(rt.call_function('esc_html', [rt.get_property(var_item_shadow, 'post_title')])).str() +
				'</option>')
			rt.new_bool(parent_dropdown(default_page, rt.get_property(var_item_shadow, 'ID'),

				level + 1, rt.new_null()))
		}
	} else {
		return false
	}
	return false
}

fn wp_dropdown_roles(selected string, var_editable_roles_arg rt.PhpVal) {
	mut var_selected := selected
	mut var_editable_roles := var_editable_roles_arg
	mut var_r := ''
	mut var_details := map[string]rt.PhpVal{}
	mut var_role := rt.new_null()
	mut var_name := rt.new_null()
	var_r = ''
	if rt.is_true(rt.identical(rt.new_null(), var_editable_roles)) {
		var_editable_roles = rt.call_function('array_reverse', [
			rt.call_function('get_editable_roles', []rt.PhpVal{}),
		])
	}
	mut iter_9 := var_editable_roles.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_details_shadow := item_9.val
		mut var_role_shadow := item_9.key
		var_name = rt.call_function('translate_user_role', [
			rt.new_string((var_details_shadow['name']).str()),
		])
		if rt.is_true(rt.identical(rt.new_string(selected), var_role_shadow)) {
			var_r = var_r + "\n\t<option selected='selected' value='" +
				(rt.call_function('esc_attr', [var_role_shadow.clone()])).str() +
				"'>${var_name.to_string()}</option>"
		} else {
			var_r = var_r + "\n\t<option value='" +
				(rt.call_function('esc_attr', [var_role_shadow.clone()])).str() +
				"'>${var_name.to_string()}</option>"
		}
	}
	print(var_r)
}

fn wp_import_upload_form(var_action rt.PhpVal) {
	mut var_bytes := rt.new_null()
	mut var_size := rt.new_null()
	mut var_upload_dir := rt.new_null()
	mut var_upload_directory_error := rt.new_null()
	var_bytes = rt.call_function('apply_filters', [
		rt.new_string('import_upload_size_limit'),
		rt.call_function('wp_max_upload_size', []rt.PhpVal{}),
	])
	var_size = rt.call_function('size_format', [var_bytes.clone()])
	var_upload_dir = rt.call_function('wp_upload_dir', []rt.PhpVal{})
	if !(!rt.is_true(var_upload_dir.array_get(rt.new_string('error')))) {
		var_upload_directory_error = rt.new_string('<p>' +
			(rt.call_function('__', [rt.new_string('Before you can upload your import file, you will need to fix the following error:')])).str() +
			'</p>')
		var_upload_directory_error = rt.concat(var_upload_directory_error, rt.new_string(
			'<p><strong>' +
			(var_upload_dir.array_get(rt.new_string('error'))).str() + '</strong></p>'))
		rt.call_function('wp_admin_notice', [var_upload_directory_error.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
				rt.ArrayItem{ key: 'paragraph_wrap', val: false },
			])])
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_url', [
			rt.call_function('wp_nonce_url', [var_action.clone(),
				rt.new_string('import-upload')]),
		]))
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('printf', [rt.new_string('<label for="upload">%s</label> (%s)'),
			rt.call_function('__', [rt.new_string('Choose a file from your computer:')]),
			rt.call_function('sprintf', [rt.call_function('__', [
				rt.new_string('Maximum size: %s'),
			]),
				var_size.clone()])])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_bytes)
		// unsupported statement: Stmt_InlineHTML
		submit_button(rt.call_function('__', [rt.new_string('Upload file and import')]), 'primary',
			'', false, '')
		// unsupported statement: Stmt_InlineHTML
	}
}

fn add_meta_box(var_id rt.PhpVal, var_title_arg rt.PhpVal, var_callback_arg rt.PhpVal, var_screen_arg rt.PhpVal, context string, priority string, var_callback_args_arg rt.PhpVal) {
	mut var_context := context
	mut var_priority := priority
	mut var_title := var_title_arg
	mut var_callback := var_callback_arg
	mut var_screen := var_screen_arg
	mut var_callback_args := var_callback_args_arg
	mut var_single_screen := rt.new_null()
	mut var_page := rt.new_null()
	mut var_wp_meta_boxes := rt.new_null()
	mut var_a_context := rt.new_null()
	mut var_a_priority := rt.new_null()
	if !rt.is_true(var_screen) {
		var_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
	} else if rt.is_true(rt.new_bool(var_screen.clone().is_string())) {
		var_screen = convert_to_screen(var_screen.clone())
	} else if rt.is_true(rt.new_bool(var_screen.clone().is_array())) {
		mut iter_10 := var_screen.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_single_screen_shadow := item_10.val
			add_meta_box(var_id.clone(), var_title.clone(), var_callback.clone(),
				var_single_screen_shadow.clone(), context, var_priority, var_callback_args.clone())
		}
	}
	if !(!(rt.get_property(var_screen, 'id')).is_null()) {
		return
	}
	var_page = rt.get_property(var_screen, 'id')
	if !(!var_wp_meta_boxes.is_null()) {
		var_wp_meta_boxes = rt.new_array()
	}
	if !(var_wp_meta_boxes.array_isset(var_page)) {
		var_wp_meta_boxes.array_set(var_page, rt.new_array())
	}
	if !(var_wp_meta_boxes.array_get(var_page).array_isset(rt.new_string(context))) {
		var_wp_meta_boxes.array_get_mut(var_page).array_set(context, rt.new_array())
	}
	mut iter_11 := rt.func_array_keys(var_wp_meta_boxes.array_get(var_page)).iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_a_context_shadow := item_11.val
		mut iter_12 := rt.create_array([rt.ArrayItem{ key: none, val: 'high' },
			rt.ArrayItem{ key: none, val: 'core' }, rt.ArrayItem{ key: none, val: 'default' },
			rt.ArrayItem{ key: none, val: 'low' }]).iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_a_priority_shadow := item_12.val
			if !(var_wp_meta_boxes.array_get(var_page).array_get(var_a_context_shadow).array_get(var_a_priority_shadow).array_isset(var_id)) {
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('core'), rt.new_string(var_priority.str())))
				|| rt.is_true(rt.identical(rt.new_string('sorted'), rt.new_string(var_priority.str())))
				&& rt.is_true(rt.identical(rt.new_bool(false), var_wp_meta_boxes.array_get(var_page).array_get(var_a_context_shadow).array_get(var_a_priority_shadow).array_get(var_id))) {
				return
			}
			if rt.is_true(rt.identical(rt.new_string('core'), rt.new_string(var_priority.str()))) {
				if rt.is_true(rt.identical(rt.new_string('default'), var_a_priority_shadow)) {
					var_wp_meta_boxes.array_get_mut(var_page).array_get_mut(var_a_context_shadow).array_get_mut('core').array_set(var_id,
						var_wp_meta_boxes.array_get(var_page).array_get(var_a_context_shadow).array_get(rt.new_string('default')).array_get(var_id))
					var_wp_meta_boxes.array_get(var_page).array_get(var_a_context_shadow).array_get(rt.new_string('default')).array_unset(var_id)
				}
				return
			}
			if var_priority == '' {
				var_priority = var_a_priority_shadow.str()
			} else if rt.is_true(rt.identical(rt.new_string('sorted'),
				rt.new_string(var_priority.str())))
			{
				var_title =
					var_wp_meta_boxes.array_get(var_page).array_get(var_a_context_shadow).array_get(var_a_priority_shadow).array_get(var_id).array_get(rt.new_string('title'))
				var_callback =
					var_wp_meta_boxes.array_get(var_page).array_get(var_a_context_shadow).array_get(var_a_priority_shadow).array_get(var_id).array_get(rt.new_string('callback'))
				var_callback_args =
					var_wp_meta_boxes.array_get(var_page).array_get(var_a_context_shadow).array_get(var_a_priority_shadow).array_get(var_id).array_get(rt.new_string('args'))
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(var_priority.str()), var_a_priority_shadow))))
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(context), var_a_context_shadow)))) {
				var_wp_meta_boxes.array_get(var_page).array_get(var_a_context_shadow).array_get(var_a_priority_shadow).array_unset(var_id)
			}
		}
	}
	if var_priority == '' {
		var_priority = 'low'
	}
	if !(var_wp_meta_boxes.array_get(var_page).array_get(rt.new_string(context)).array_isset(rt.new_string(var_priority.str()))) {
		var_wp_meta_boxes.array_get_mut(var_page).array_get_mut(context).array_set(var_priority,
			rt.new_array())
	}
	var_wp_meta_boxes.array_get_mut(var_page).array_get_mut(context).array_get_mut(var_priority).array_set(var_id, rt.create_array([
		rt.ArrayItem{ key: 'id', val: var_id },
		rt.ArrayItem{ key: 'title', val: var_title },
		rt.ArrayItem{ key: 'callback', val: var_callback },
		rt.ArrayItem{ key: 'args', val: var_callback_args },
	]))
}

fn do_block_editor_incompatible_meta_box(var_data_object rt.PhpVal, var_box rt.PhpVal) {
	mut var_plugin := rt.new_null()
	mut var_plugins := rt.new_null()
	mut var_install_url := rt.new_null()
	mut var_activate_url := rt.new_null()
	mut var_edit_url := rt.new_null()
	var_plugin = _get_plugin_from_callback(var_box.array_get(rt.new_string('old_callback')))
	var_plugins = rt.call_function('get_plugins', []rt.PhpVal{})
	print('<p>')
	if rt.is_true(var_plugin) {
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('This meta box, from the %s plugin, is not compatible with the block editor.'),
			]),
			rt.concat(rt.concat(rt.new_string('<strong>'),
				var_plugin.array_get(rt.new_string('Name'))), rt.new_string('</strong>')),
		])
	} else {
		rt.call_function('_e', [
			rt.new_string('This meta box is not compatible with the block editor.'),
		])
	}
	print('</p>')
	if !rt.is_true(var_plugins.array_get(rt.new_string('classic-editor/classic-editor.php'))) {
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('install_plugins'),
		]))
		{
			var_install_url = rt.call_function('wp_nonce_url', [
				rt.call_function('self_admin_url', [
					rt.new_string('plugin-install.php?tab=favorites&user=wordpressdotorg&save=0'),
				]),
				rt.new_string('save_wporg_username_' +
					(rt.call_function('get_current_user_id', []rt.PhpVal{})).str()),
			])
			print('<p>')
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('Please install the <a href="%s">Classic Editor plugin</a> to use this meta box.'),
				]),
				rt.call_function('esc_url', [
					var_install_url.clone(),
				]),
			])
			print('</p>')
		}
	} else if rt.is_true(rt.call_function('is_plugin_inactive', [
		rt.new_string('classic-editor/classic-editor.php'),
	]))
	{
		if rt.is_true(rt.call_function('current_user_can', [
			rt.new_string('activate_plugins'),
		]))
		{
			var_activate_url = rt.call_function('wp_nonce_url', [
				rt.call_function('self_admin_url', [
					rt.new_string('plugins.php?action=activate&plugin=classic-editor/classic-editor.php'),
				]),
				rt.new_string('activate-plugin_classic-editor/classic-editor.php'),
			])
			print('<p>')
			rt.call_function('printf', [
				rt.call_function('__', [
					rt.new_string('Please activate the <a href="%s">Classic Editor plugin</a> to use this meta box.'),
				]),
				rt.call_function('esc_url', [
					var_activate_url.clone(),
				]),
			])
			print('</p>')
		}
	} else if rt.is_true(rt.new_bool(rt.instance_of(var_data_object, 'WP_Post'))) {
		var_edit_url = rt.call_function('add_query_arg', [
			rt.create_array([rt.ArrayItem{ key: 'classic-editor', val: '' },
				rt.ArrayItem{ key: 'classic-editor__forget', val: '' }]),
			rt.call_function('get_edit_post_link', [var_data_object.clone()]),
		])
		print('<p>')
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('Please open the <a href="%s">classic editor</a> to use this meta box.'),
			]),
			rt.call_function('esc_url', [
				var_edit_url.clone(),
			]),
		])
		print('</p>')
	}
}

fn _get_plugin_from_callback(var_callback rt.PhpVal) rt.PhpVal {
	mut var_reflection := rt.new_null()
	mut var_exception := rt.new_null()
	mut var_filename := rt.new_null()
	mut var_plugin_dir := rt.new_null()
	mut var_plugins := rt.new_null()
	mut var_plugin := rt.new_null()
	mut var_name := rt.new_null()
	if rt.is_true(rt.new_bool(var_callback.clone().is_array())) {
		var_reflection = create_reflectionmethod(var_callback.array_get(rt.new_int(0)),
			var_callback.array_get(rt.new_int(1)))
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	} else if var_callback.clone().is_string()
		&& rt.is_true(rt.call_function('str_contains', [var_callback.clone(), rt.new_string('::')])) {
		var_reflection = create_reflectionmethod(var_callback.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	} else {
		var_reflection = create_reflectionfunction(var_callback.clone())
		if rt.has_exception() {
			unsafe {
				goto catch_label_1
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'ReflectionException') {
		var_exception = var_e_1.clone()
		return rt.new_null()
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_reflection, 'isInternal',
		[]rt.PhpVal{})))))
	{
		var_filename = rt.call_function('wp_normalize_path', [
			rt.call_method(var_reflection, 'getFileName', []rt.PhpVal{}),
		])
		var_plugin_dir = rt.call_function('wp_normalize_path', [
			rt.get_constant('WP_PLUGIN_DIR'),
		])
		if rt.is_true(rt.call_function('str_starts_with', [var_filename.clone(),
			var_plugin_dir.clone()]))
		{
			var_filename = rt.call_function('str_replace', [var_plugin_dir.clone(),
				rt.new_string(''), var_filename.clone()])
			var_filename = rt.call_function('preg_replace', [
				rt.new_string('|^/([^/]*/).*$|'),
				rt.new_string('\\1'),
				var_filename.clone(),
			])
			var_plugins = rt.call_function('get_plugins', []rt.PhpVal{})
			mut iter_13 := var_plugins.iterator()
			for {
				item_13 := iter_13.next() or { break }
				mut var_plugin_shadow := item_13.val
				mut var_name_shadow := item_13.key
				if rt.is_true(rt.call_function('str_starts_with', [
					var_name_shadow.clone(), var_filename.clone()]))
				{
					return var_plugin_shadow.clone()
				}
			}
		}
	}
	return rt.new_null()
}

fn do_meta_boxes(var_screen_arg rt.PhpVal, var_context rt.PhpVal, var_data_object rt.PhpVal) i64 {
	mut var_screen := var_screen_arg
	mut var_wp_meta_boxes := rt.new_null()
	mut var_page := rt.new_null()
	mut var_hidden := rt.new_null()
	mut var_sorted := rt.new_null()
	mut var_ids := rt.new_null()
	mut var_box_context := rt.new_null()
	mut var_id := rt.new_null()
	mut var_already_sorted := false
	mut var_i := i64(0)
	mut var_priority := rt.new_null()
	mut var_box := map[string]rt.PhpVal{}
	mut var_block_compatible := rt.new_null()
	mut var_hidden_class := ''
	mut var_widget_title := rt.new_null()
	mut var_plugin := rt.new_null()
	mut var_meta_box_not_compatible_message := rt.new_null()
	if !rt.is_true(var_screen) {
		var_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
	} else if rt.is_true(rt.new_bool(var_screen.clone().is_string())) {
		var_screen = convert_to_screen(var_screen.clone())
	}
	var_page = rt.get_property(var_screen, 'id')
	var_hidden = rt.call_function('get_hidden_meta_boxes', [var_screen.clone()])
	rt.call_function('printf', [
		rt.new_string('<div id="%s-sortables" class="meta-box-sortables">'),
		rt.call_function('esc_attr', [var_context.clone()]),
	])
	var_sorted = rt.call_function('get_user_option', [
		rt.new_string('meta-box-order_${var_page.to_string()}'),
	])
	if !var_already_sorted && rt.is_true(var_sorted) {
		mut iter_14 := var_sorted.iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_ids_shadow := item_14.val
			mut var_box_context_shadow := item_14.key
			mut iter_15 := rt.call_function('explode', [rt.new_string(','),
				var_ids_shadow.clone()]).iterator()
			for {
				item_15 := iter_15.next() or { break }
				mut var_id_shadow := item_15.val
				if rt.is_true(var_id_shadow)
					&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('dashboard_browser_nag'), var_id_shadow)))) {
					add_meta_box(var_id_shadow.clone(), rt.new_null(), rt.new_null(),
						var_screen.clone(), var_box_context_shadow.clone(), 'sorted', rt.new_null())
				}
			}
		}
	}
	var_already_sorted = true
	var_i = 0
	if var_wp_meta_boxes.array_get(var_page).array_isset(var_context) {
		mut iter_16 := rt.create_array([rt.ArrayItem{ key: none, val: 'high' },
			rt.ArrayItem{ key: none, val: 'sorted' }, rt.ArrayItem{ key: none, val: 'core' },
			rt.ArrayItem{ key: none, val: 'default' }, rt.ArrayItem{ key: none, val: 'low' }]).iterator()
		for {
			item_16 := iter_16.next() or { break }
			mut var_priority_shadow := item_16.val
			if var_wp_meta_boxes.array_get(var_page).array_get(var_context).array_isset(var_priority_shadow) {
				mut iter_17 :=
					rt.cast_array(var_wp_meta_boxes.array_get(var_page).array_get(var_context).array_get(var_priority_shadow)).iterator()
				for {
					item_17 := iter_17.next() or { break }
					mut var_box_shadow := item_17.val
					if rt.is_true(rt.identical(rt.new_bool(false), var_box_shadow))
						|| rt.is_true(rt.new_bool(!(rt.is_true(var_box_shadow['title'])))) {
						continue
					}
					var_block_compatible = rt.new_bool(true)
					if rt.is_true(rt.new_bool(var_box_shadow['args'].is_array())) {
						if rt.is_true(rt.call_method(var_screen, 'is_block_editor', []rt.PhpVal{}))
							&& var_box_shadow['args'].array_isset(rt.new_string('__back_compat_meta_box'))
							&& rt.is_true(var_box_shadow['args'].array_get(rt.new_string('__back_compat_meta_box'))) {
							continue
						}
						if var_box_shadow['args'].array_isset(rt.new_string('__block_editor_compatible_meta_box')) {
							var_block_compatible =
								rt.new_bool((var_box_shadow['args'].array_get(rt.new_string('__block_editor_compatible_meta_box'))).to_bool())
							var_box_shadow['args'].array_unset(rt.new_string('__block_editor_compatible_meta_box'))
						}
						if rt.is_true(rt.new_bool(!(rt.is_true(var_block_compatible))))
							&& rt.is_true(rt.call_method(var_screen, 'is_block_editor', []rt.PhpVal{})) {
							var_box_shadow['old_callback'] = var_box_shadow['callback']
							var_box_shadow['callback'] =
								rt.new_string('do_block_editor_incompatible_meta_box')
						}
						if var_box_shadow['args'].array_isset(rt.new_string('__back_compat_meta_box')) {
							var_block_compatible = rt.new_bool(rt.is_true(var_block_compatible)
								|| rt.is_true((var_box_shadow['args'].array_get(rt.new_string('__back_compat_meta_box'))).to_bool()))
							var_box_shadow['args'].array_unset(rt.new_string('__back_compat_meta_box'))
						}
					}
					var_i += 1
					var_hidden_class = if
						rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_screen, 'is_block_editor', []rt.PhpVal{})))))
						&& rt.is_true(rt.call_function('in_array', [var_box_shadow['id'], var_hidden.clone(), rt.new_bool(true)])) {
						' hide-if-js'
					} else {
						''
					}
					print('<div id="' +
						(var_box_shadow['id']).str() + '" class="postbox ' + (rt.call_function('postbox_classes', [var_box_shadow['id'], var_page.clone()])).str() +
						var_hidden_class + '" ' + '>' + '\n')
					print('<div class="postbox-header">')
					print('<h2 class="hndle">')
					if rt.is_true(rt.identical(rt.new_string('dashboard_php_nag'),
						var_box_shadow['id']))
					{
						print('<span aria-hidden="true" class="dashicons dashicons-warning"></span>')
						print('<span class="screen-reader-text">' +
							(rt.call_function('__', [rt.new_string('Warning:')])).str() + ' </span>')
					}
					rt.echo_val(var_box_shadow['title'])
					print('</h2>\n')
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('dashboard_browser_nag'),
						var_box_shadow['id']))))
					{
						var_widget_title = var_box_shadow['title']
						if var_box_shadow['args'].is_array()
							&& var_box_shadow['args'].array_isset(rt.new_string('__widget_basename')) {
							var_widget_title =
								var_box_shadow['args'].array_get(rt.new_string('__widget_basename'))
							var_box_shadow['args'].array_unset(rt.new_string('__widget_basename'))
						}
						print('<div class="handle-actions hide-if-no-js">')
						print(
							'<button type="button" class="handle-order-higher" aria-disabled="false" aria-describedby="' +
							(var_box_shadow['id']).str() + '-handle-order-higher-description">')
						print('<span class="screen-reader-text">' +
							(rt.call_function('__', [rt.new_string('Move up')])).str() + '</span>')
						print('<span class="order-higher-indicator" aria-hidden="true"></span>')
						print('</button>')
						print('<span class="hidden" id="' +
							(var_box_shadow['id']).str() + '-handle-order-higher-description">' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Move %s box up')]), var_widget_title.clone()])).str() +
							'</span>')
						print(
							'<button type="button" class="handle-order-lower" aria-disabled="false" aria-describedby="' +
							(var_box_shadow['id']).str() + '-handle-order-lower-description">')
						print('<span class="screen-reader-text">' +
							(rt.call_function('__', [rt.new_string('Move down')])).str() + '</span>')
						print('<span class="order-lower-indicator" aria-hidden="true"></span>')
						print('</button>')
						print('<span class="hidden" id="' +
							(var_box_shadow['id']).str() + '-handle-order-lower-description">' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Move %s box down')]), var_widget_title.clone()])).str() +
							'</span>')
						print('<button type="button" class="handlediv" aria-expanded="true">')
						print('<span class="screen-reader-text">' +
							(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Toggle panel: %s')]), var_widget_title.clone()])).str() +
							'</span>')
						print('<span class="toggle-indicator" aria-hidden="true"></span>')
						print('</button>')
						print('</div>')
					}
					print('</div>')
					print('<div class="inside">' + '\n')
					if rt.is_true(rt.get_constant('WP_DEBUG'))
						&& rt.is_true(rt.new_bool(!(rt.is_true(var_block_compatible))))
						&& rt.is_true(rt.identical(rt.new_string('edit'), rt.get_property(var_screen, 'parent_base')))
						&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_screen, 'is_block_editor', []rt.PhpVal{})))))
						&& !(rt.get_superglobal('_GET').array_isset(rt.new_string('meta-box-loader'))) {
						var_plugin = _get_plugin_from_callback(var_box_shadow['callback'])
						if rt.is_true(var_plugin) {
							var_meta_box_not_compatible_message = rt.call_function('sprintf', [
								rt.call_function('__', [
									rt.new_string('This meta box, from the %s plugin, is not compatible with the block editor.'),
								]),
								rt.concat(rt.concat(rt.new_string('<strong>'),
									var_plugin.array_get(rt.new_string('Name'))),
									rt.new_string('</strong>')),
							])
							rt.call_function('wp_admin_notice', [
								var_meta_box_not_compatible_message.clone(),
								rt.create_array([
									rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
										rt.ArrayItem{ key: none, val: 'error' },
										rt.ArrayItem{ key: none, val: 'inline' },
									]) },
								])])
						}
					}
					rt.call_function('call_user_func', [var_box_shadow['callback'], var_data_object.clone(),
						var_box_shadow.clone()])
					print('</div>\n')
					print('</div>\n')
				}
			}
		}
	}
	print('</div>')
	return var_i
}

fn remove_meta_box(var_id rt.PhpVal, var_screen_arg rt.PhpVal, var_context rt.PhpVal) {
	mut var_screen := var_screen_arg
	mut var_single_screen := rt.new_null()
	mut var_page := rt.new_null()
	mut var_wp_meta_boxes := rt.new_null()
	mut var_priority := rt.new_null()
	if !rt.is_true(var_screen) {
		var_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
	} else if rt.is_true(rt.new_bool(var_screen.clone().is_string())) {
		var_screen = convert_to_screen(var_screen.clone())
	} else if rt.is_true(rt.new_bool(var_screen.clone().is_array())) {
		mut iter_18 := var_screen.iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_single_screen_shadow := item_18.val
			remove_meta_box(var_id.clone(), var_single_screen_shadow.clone(), var_context.clone())
		}
	}
	if !(!(rt.get_property(var_screen, 'id')).is_null()) {
		return
	}
	var_page = rt.get_property(var_screen, 'id')
	if !(!var_wp_meta_boxes.is_null()) {
		var_wp_meta_boxes = rt.new_array()
	}
	if !(var_wp_meta_boxes.array_isset(var_page)) {
		var_wp_meta_boxes.array_set(var_page, rt.new_array())
	}
	if !(var_wp_meta_boxes.array_get(var_page).array_isset(var_context)) {
		var_wp_meta_boxes.array_get_mut(var_page).array_set(var_context, rt.new_array())
	}
	mut iter_19 := rt.create_array([rt.ArrayItem{ key: none, val: 'high' },
		rt.ArrayItem{ key: none, val: 'core' }, rt.ArrayItem{ key: none, val: 'default' },
		rt.ArrayItem{ key: none, val: 'low' }]).iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_priority_shadow := item_19.val
		var_wp_meta_boxes.array_get_mut(var_page).array_get_mut(var_context).array_get_mut(var_priority_shadow).array_set(var_id,
			false)
	}
}

fn do_accordion_sections(var_screen_arg rt.PhpVal, var_context rt.PhpVal, var_data_object rt.PhpVal) i64 {
	mut var_screen := var_screen_arg
	mut var_wp_meta_boxes := rt.new_null()
	mut var_page := rt.new_null()
	mut var_hidden := rt.new_null()
	mut var_i := i64(0)
	mut var_first_open := false
	mut var_priority := rt.new_null()
	mut var_box := map[string]rt.PhpVal{}
	mut var_hidden_class := ''
	mut var_open_class := ''
	mut var_aria_expanded := ''
	rt.call_function('wp_enqueue_script', [rt.new_string('accordion')])
	if !rt.is_true(var_screen) {
		var_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
	} else if rt.is_true(rt.new_bool(var_screen.clone().is_string())) {
		var_screen = convert_to_screen(var_screen.clone())
	}
	var_page = rt.get_property(var_screen, 'id')
	var_hidden = rt.call_function('get_hidden_meta_boxes', [var_screen.clone()])
	// unsupported statement: Stmt_InlineHTML
	var_i = 0
	var_first_open = false
	if var_wp_meta_boxes.array_get(var_page).array_isset(var_context) {
		mut iter_20 := rt.create_array([rt.ArrayItem{ key: none, val: 'high' },
			rt.ArrayItem{ key: none, val: 'core' }, rt.ArrayItem{ key: none, val: 'default' },
			rt.ArrayItem{ key: none, val: 'low' }]).iterator()
		for {
			item_20 := iter_20.next() or { break }
			mut var_priority_shadow := item_20.val
			if var_wp_meta_boxes.array_get(var_page).array_get(var_context).array_isset(var_priority_shadow) {
				mut iter_21 :=
					var_wp_meta_boxes.array_get(var_page).array_get(var_context).array_get(var_priority_shadow).iterator()
				for {
					item_21 := iter_21.next() or { break }
					mut var_box_shadow := item_21.val
					if rt.is_true(rt.identical(rt.new_bool(false), var_box_shadow))
						|| rt.is_true(rt.new_bool(!(rt.is_true(var_box_shadow['title'])))) {
						continue
					}
					var_i += 1
					var_hidden_class = if rt.is_true(rt.call_function('in_array', [
						var_box_shadow['id'],
						var_hidden.clone(),
						rt.new_bool(true),
					]))
					{ 'hide-if-js' } else { '' }
					var_open_class = ''
					var_aria_expanded = 'false'
					if !var_first_open && var_hidden_class == '' {
						var_first_open = true
						var_open_class = 'open'
						var_aria_expanded = 'true'
					}
					// unsupported statement: Stmt_InlineHTML
					print(var_hidden_class)
					// unsupported statement: Stmt_InlineHTML
					print(var_open_class)
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [var_box_shadow['id']]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [var_box_shadow['id']]))
					// unsupported statement: Stmt_InlineHTML
					print(var_aria_expanded)
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [var_box_shadow['id']]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [var_box_shadow['title']]))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('postbox_classes', [var_box_shadow['id'], var_page.clone()])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [var_box_shadow['id']]))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('call_user_func', [var_box_shadow['callback'], var_data_object.clone(),
						var_box_shadow.clone()])
					// unsupported statement: Stmt_InlineHTML
				}
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	return var_i
}

fn add_settings_section(var_id rt.PhpVal, var_title rt.PhpVal, var_callback rt.PhpVal, var_page_arg rt.PhpVal, var_args rt.PhpVal) {
	mut var_page := var_page_arg
	mut var_wp_settings_sections := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_section := rt.new_null()
	var_defaults = {
		'id':             var_id
		'title':          var_title
		'callback':       var_callback
		'before_section': rt.new_string('')
		'after_section':  rt.new_string('')
		'section_class':  rt.new_string('')
	}
	var_section = rt.call_function('wp_parse_args', [
		rt.create_array_from_native_map(var_args),
		rt.create_array_from_native_map(var_defaults),
	])
	if rt.is_true(rt.identical(rt.new_string('misc'), rt.new_string(var_page.str()))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.0.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The "%s" options group has been removed. Use another settings group.'),
				]),
				rt.new_string('misc'),
			])])
		var_page = 'general'
	}
	if rt.is_true(rt.identical(rt.new_string('privacy'), rt.new_string(var_page.str()))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.5.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The "%s" options group has been removed. Use another settings group.'),
				]),
				rt.new_string('privacy'),
			])])
		var_page = 'reading'
	}
	var_wp_settings_sections.array_get_mut(var_page).array_set(var_id, var_section.clone())
}

fn add_settings_field(var_id rt.PhpVal, var_title rt.PhpVal, var_callback rt.PhpVal, var_page_arg rt.PhpVal, section string, var_args rt.PhpVal) {
	mut var_section := section
	mut var_page := var_page_arg
	mut var_wp_settings_fields := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('misc'), rt.new_string(var_page.str()))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.0.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The "%s" options group has been removed. Use another settings group.'),
				]),
				rt.new_string('misc'),
			])])
		var_page = 'general'
	}
	if rt.is_true(rt.identical(rt.new_string('privacy'), rt.new_string(var_page.str()))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.5.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The "%s" options group has been removed. Use another settings group.'),
				]),
				rt.new_string('privacy'),
			])])
		var_page = 'reading'
	}
	var_wp_settings_fields.array_get_mut(var_page).array_get_mut(section).array_set(var_id, rt.create_array([
		rt.ArrayItem{ key: 'id', val: var_id },
		rt.ArrayItem{ key: 'title', val: var_title },
		rt.ArrayItem{ key: 'callback', val: var_callback },
		rt.ArrayItem{ key: 'args', val: var_args },
	]))
}

fn do_settings_sections(var_page rt.PhpVal) {
	mut var_wp_settings_sections := rt.new_null()
	mut var_wp_settings_fields := rt.new_null()
	mut var_section := rt.new_null()
	if !(var_wp_settings_sections.array_isset(var_page)) {
		return
	}
	mut iter_22 := rt.cast_array(var_wp_settings_sections.array_get(var_page)).iterator()
	for {
		item_22 := iter_22.next() or { break }
		mut var_section_shadow := item_22.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
			var_section_shadow.array_get(rt.new_string('before_section'))))))
		{
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
				var_section_shadow.array_get(rt.new_string('section_class'))))))
			{
				rt.echo_val(rt.call_function('wp_kses_post', [
					rt.call_function('sprintf', [
						var_section_shadow.array_get(rt.new_string('before_section')),
						rt.call_function('esc_attr', [
							var_section_shadow.array_get(rt.new_string('section_class')),
						]),
					]),
				]))
			} else {
				rt.echo_val(rt.call_function('wp_kses_post', [
					var_section_shadow.array_get(rt.new_string('before_section')),
				]))
			}
		}
		if rt.is_true(var_section_shadow.array_get(rt.new_string('title'))) {
			print(rt.concat(rt.concat(rt.new_string('<h2>'),
				var_section_shadow.array_get(rt.new_string('title'))), rt.new_string('</h2>\n')))
		}
		if rt.is_true(var_section_shadow.array_get(rt.new_string('callback'))) {
			rt.call_function('call_user_func', [var_section_shadow.array_get(rt.new_string('callback')),
				var_section_shadow.clone()])
		}
		if var_wp_settings_fields.array_get(var_page).array_isset(var_section_shadow.array_get(rt.new_string('id'))) {
			print('<table class="form-table" role="presentation">')
			do_settings_fields(var_page.clone(), var_section_shadow.array_get(rt.new_string('id')))
			print('</table>')
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''),
			var_section_shadow.array_get(rt.new_string('after_section'))))))
		{
			rt.echo_val(rt.call_function('wp_kses_post', [
				var_section_shadow.array_get(rt.new_string('after_section')),
			]))
		}
	}
}

fn do_settings_fields(var_page rt.PhpVal, var_section rt.PhpVal) {
	mut var_wp_settings_fields := rt.new_null()
	mut var_field := map[string]rt.PhpVal{}
	mut var_class := rt.new_null()
	if !(var_wp_settings_fields.array_get(var_page).array_isset(var_section)) {
		return
	}
	mut iter_23 :=
		rt.cast_array(var_wp_settings_fields.array_get(var_page).array_get(var_section)).iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_field_shadow := item_23.val
		var_class = rt.new_string('')
		if !(!rt.is_true(var_field_shadow['args'].array_get(rt.new_string('class')))) {
			var_class = rt.new_string(' class="' +
				(rt.call_function('esc_attr', [var_field_shadow['args'].array_get(rt.new_string('class'))])).str() +
				'"')
		}
		print('<tr${var_class.to_string()}>')
		if !(!rt.is_true(var_field_shadow['args'].array_get(rt.new_string('label_for')))) {
			print('<th scope="row"><label for="' +
				(rt.call_function('esc_attr', [var_field_shadow['args'].array_get(rt.new_string('label_for'))])).str() +
				'">' + (var_field_shadow['title']).str() + '</label></th>')
		} else {
			print('<th scope="row">' + (var_field_shadow['title']).str() + '</th>')
		}
		print('<td>')
		rt.call_function('call_user_func', [var_field_shadow['callback'], var_field_shadow['args']])
		print('</td>')
		print('</tr>')
	}
}

fn add_settings_error(var_setting rt.PhpVal, var_code rt.PhpVal, var_message rt.PhpVal, type string) {
	mut var_type := type
	mut var_wp_settings_errors := rt.new_null()
	var_wp_settings_errors.array_push(rt.create_array([
		rt.ArrayItem{ key: 'setting', val: var_setting },
		rt.ArrayItem{ key: 'code', val: var_code },
		rt.ArrayItem{ key: 'message', val: var_message },
		rt.ArrayItem{ key: 'type', val: type },
	]))
}

fn get_settings_errors(setting string, sanitize bool) rt.PhpVal {
	mut var_setting := setting
	mut var_sanitize := sanitize
	mut var_wp_settings_errors := rt.new_null()
	mut var_setting_errors := []rt.PhpVal{}
	mut var_details := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	if var_sanitize {
		rt.call_function('sanitize_option', [rt.new_string(setting),
			rt.call_function('get_option', [rt.new_string(setting)])])
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('settings-updated'))
		&& rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('settings-updated')))
		&& rt.is_true(rt.call_function('get_transient', [rt.new_string('settings_errors')])) {
		var_wp_settings_errors = rt.call_function('array_merge', [
			rt.cast_array(var_wp_settings_errors),
			rt.call_function('get_transient', [rt.new_string('settings_errors')]),
		])
		rt.call_function('delete_transient', [rt.new_string('settings_errors')])
	}
	if !rt.is_true(var_wp_settings_errors) {
		return rt.new_array()
	}
	if var_setting.len > 0 && var_setting != '0' {
		var_setting_errors = rt.new_array()
		mut iter_24 := rt.cast_array(var_wp_settings_errors).iterator()
		for {
			item_24 := iter_24.next() or { break }
			mut var_details_shadow := item_24.val
			mut var_key_shadow := item_24.key
			if rt.is_true(rt.identical(rt.new_string(setting),
				rt.new_string((var_details_shadow['setting']).str())))
			{
				var_setting_errors << var_wp_settings_errors.array_get(var_key_shadow)
			}
		}
		return var_setting_errors.clone()
	}
	return var_wp_settings_errors.clone()
}

fn settings_errors(setting string, sanitize bool, hide_on_update bool) {
	mut var_setting := setting
	mut var_sanitize := sanitize
	mut var_hide_on_update := hide_on_update
	mut var_settings_errors := rt.new_null()
	mut var_output := ''
	mut var_details := map[string]rt.PhpVal{}
	mut var_key := rt.new_null()
	mut var_css_id := rt.new_null()
	mut var_css_class := rt.new_null()
	if var_hide_on_update
		&& !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('settings-updated')))) {
		return
	}
	var_settings_errors = get_settings_errors(setting, sanitize)
	if !rt.is_true(var_settings_errors) {
		return
	}
	var_output = ''
	mut iter_25 := var_settings_errors.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_details_shadow := item_25.val
		mut var_key_shadow := item_25.key
		if rt.is_true(rt.identical(rt.new_string('updated'),
			rt.new_string((var_details_shadow['type']).str())))
		{
			var_details_shadow['type'] = 'success'
		}
		if rt.is_true(rt.call_function('in_array', [
			rt.new_string((var_details_shadow['type']).str()),
			rt.create_array([rt.ArrayItem{ key: none, val: 'error' },
				rt.ArrayItem{ key: none, val: 'success' }, rt.ArrayItem{ key: none, val: 'warning' },
				rt.ArrayItem{ key: none, val: 'info' }]),
			rt.new_bool(true),
		]))
		{
			var_details_shadow['type'] = 'notice-' + var_details_shadow['type']
		}
		var_css_id = rt.call_function('sprintf', [rt.new_string('setting-error-%s'),
			rt.call_function('esc_attr', [
				rt.new_string((var_details_shadow['code']).str()),
			])])
		var_css_class = rt.call_function('sprintf', [
			rt.new_string('notice %s settings-error is-dismissible'),
			rt.call_function('esc_attr', [
				rt.new_string((var_details_shadow['type']).str()),
			]),
		])
		var_output = var_output +
			"<div id='${var_css_id.to_string()}' class='${var_css_class.to_string()}'> \n"
		var_output = var_output +
			rt.concat(rt.concat(rt.new_string('<p><strong>'), rt.new_string((var_details_shadow['message']).str())), rt.new_string('</strong></p>'))
		var_output = var_output + '</div> \n'
	}
	print(var_output)
}

fn find_posts_div(found_action string) {
	mut var_found_action := found_action
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Attach to existing content')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Close media attachment panel')])
	// unsupported statement: Stmt_InlineHTML
	if var_found_action.len > 0 && var_found_action != '0' {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [rt.new_string(found_action)]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('find-posts'),
		rt.new_string('_ajax_nonce'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Search')])
	// unsupported statement: Stmt_InlineHTML
	submit_button(rt.call_function('__', [rt.new_string('Select')]), 'primary alignright',
		'find-posts-submit', false, '')
	// unsupported statement: Stmt_InlineHTML
}

fn the_post_password() {
	mut var_post := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if !(rt.get_property(var_post, 'post_password')).is_null() {
		rt.echo_val(rt.call_function('esc_attr', [
			rt.get_property(var_post, 'post_password'),
		]))
	}
}

fn _draft_or_post_title(post i64) rt.PhpVal {
	mut var_post := post
	mut var_title := rt.new_null()
	var_title = rt.call_function('get_the_title', [rt.new_int(post)])
	if !rt.is_true(var_title) {
		var_title = rt.call_function('__', [rt.new_string('(no title)')])
	}
	return rt.call_function('esc_html', [var_title.clone()])
}

fn _admin_search_query() {
	rt.echo_val(if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('esc_attr', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))]),
		]) } else { rt.new_string('') })
}

fn iframe_header(title string, deprecated bool) {
	mut var_title := title
	mut var_deprecated := deprecated
	mut var_hook_suffix := rt.new_null()
	mut var_body_id := rt.new_null()
	mut var_wp_locale := rt.new_null()
	mut var_admin_body_class := rt.new_null()
	mut var_current_screen := rt.new_null()
	mut var_admin_body_id := rt.new_null()
	mut var_admin_body_classes := rt.new_null()
	rt.call_function('show_admin_bar', [rt.new_bool(false)])
	var_admin_body_class = rt.call_function('preg_replace', [
		rt.new_string('/[^a-z0-9_-]+/i'),
		rt.new_string('-'),
		var_hook_suffix.clone(),
	])
	var_current_screen = rt.call_function('get_current_screen', []rt.PhpVal{})
	rt.call_function('header', [
		rt.new_string('Content-Type: ' +
			(rt.call_function('get_option', [rt.new_string('html_type')])).str() + '; charset=' +
			(rt.call_function('get_option', [rt.new_string('blog_charset')])).str()),
	])
	_wp_admin_html_begin()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('name')])
	// unsupported statement: Stmt_InlineHTML
	print(var_title)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('WordPress')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_enqueue_style', [rt.new_string('colors')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('admin_url', [rt.new_string('admin-ajax.php'),
			rt.new_string('relative')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [rt.get_property(var_current_screen, 'id')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.get_property(var_current_screen, 'post_type'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [var_admin_body_class.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js',
		[rt.get_property(var_wp_locale, 'number_format').array_get(rt.new_string('thousands_sep'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js',
		[rt.get_property(var_wp_locale, 'number_format').array_get(rt.new_string('decimal_point'))]))
	// unsupported statement: Stmt_InlineHTML
	print(rt.new_int((rt.call_function('is_rtl', []rt.PhpVal{})).to_i64()).str())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('admin_enqueue_scripts'),
		var_hook_suffix.clone()])
	rt.call_function('do_action', [
		rt.new_string('admin_print_styles-${var_hook_suffix.to_string()}'),
	])
	rt.call_function('do_action', [rt.new_string('admin_print_styles')])
	rt.call_function('do_action', [
		rt.new_string('admin_print_scripts-${var_hook_suffix.to_string()}'),
	])
	rt.call_function('do_action', [rt.new_string('admin_print_scripts')])
	rt.call_function('do_action', [
		rt.new_string('admin_head-${var_hook_suffix.to_string()}'),
	])
	rt.call_function('do_action', [rt.new_string('admin_head')])
	var_admin_body_class = rt.concat(var_admin_body_class,
		rt.new_string(' locale-' +(rt.call_function('sanitize_html_class', [rt.new_string(rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), rt.call_function('get_user_locale', []rt.PhpVal{})]).to_string().to_lower())])).str()))
	var_admin_body_class = rt.concat(var_admin_body_class,
		rt.new_string(' admin-color-' +(rt.call_function('sanitize_html_class', [rt.call_function('get_user_option', [rt.new_string('admin_color')]), rt.new_string('modern')])).str()))
	if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		var_admin_body_class = rt.concat(var_admin_body_class, rt.new_string(' rtl'))
	}
	// unsupported statement: Stmt_InlineHTML
	var_admin_body_id = rt.new_string((if !var_body_id.is_null() {
		'id="' + var_body_id.str() + '" '
	} else {
		''
	}).str())
	var_admin_body_classes = rt.call_function('apply_filters', [
		rt.new_string('admin_body_class'),
		rt.new_string(''),
	])
	var_admin_body_classes = rt.new_string(var_admin_body_classes.str() + ' ' +
		var_admin_body_class.str().trim_left(' \t\n\r'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_admin_body_id)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_admin_body_classes.clone()]))
	// unsupported statement: Stmt_InlineHTML
}

fn iframe_footer() {
	mut var_hook_suffix := rt.new_null()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('admin_footer'),
		var_hook_suffix.clone()])
	rt.call_function('do_action', [
		rt.new_string('admin_print_footer_scripts-${var_hook_suffix.to_string()}'),
	])
	rt.call_function('do_action', [rt.new_string('admin_print_footer_scripts')])
	// unsupported statement: Stmt_InlineHTML
}

fn _post_states(var_post rt.PhpVal, display bool) rt.PhpVal {
	mut var_display := display
	mut var_post_states := rt.new_null()
	mut var_post_states_html := rt.new_null()
	mut var_state_count := i64(0)
	mut var_separator := rt.new_null()
	mut var_i := i64(0)
	mut var_state := rt.new_null()
	mut var_suffix := rt.new_null()
	var_post_states = get_post_states(var_post.clone())
	var_post_states_html = rt.new_string('')
	if !(!rt.is_true(var_post_states)) {
		var_state_count = var_post_states.clone().array_count()
		var_separator = rt.call_function('wp_get_list_item_separator', []rt.PhpVal{})
		var_i = 0
		var_post_states_html = rt.concat(var_post_states_html, rt.new_string(' &mdash; '))
		mut iter_26 := var_post_states.iterator()
		for {
			item_26 := iter_26.next() or { break }
			mut var_state_shadow := item_26.val
			var_i += 1
			var_suffix = if var_i < var_state_count { var_separator } else { rt.new_string('') }
			var_post_states_html = rt.concat(var_post_states_html,
				rt.new_string("<span class='post-state'>${var_state.to_string()}${var_suffix.to_string()}</span>"))
		}
	}
	var_post_states_html = rt.call_function('apply_filters', [
		rt.new_string('post_states_html'),
		var_post_states_html.clone(),
		var_post_states.clone(),
		var_post.clone(),
	])
	if var_display {
		rt.echo_val(var_post_states_html)
	}
	return var_post_states_html.clone()
}

fn get_post_states(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_states := rt.new_null()
	mut var_post_status := rt.new_null()
	var_post_states = rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post')))))) {
		return var_post_states.clone()
	}
	var_post_status = if !(rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_status'))).is_null() {
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_status'))
	} else {
		rt.new_string('')
	}
	if !(!rt.is_true(rt.get_property(var_post, 'post_password'))) {
		var_post_states.array_set('protected', rt.call_function('_x', [
			rt.new_string('Password protected'),
			rt.new_string('post status'),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('private'), rt.get_property(var_post, 'post_status')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('private'), var_post_status)))) {
		var_post_states.array_set('private', rt.call_function('_x', [
			rt.new_string('Private'),
			rt.new_string('post status'),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('draft'), rt.get_property(var_post, 'post_status'))) {
		if rt.is_true(rt.call_function('get_post_meta', [rt.get_property(var_post, 'ID'),
			rt.new_string('_customize_changeset_uuid'), rt.new_bool(true)]))
		{
			var_post_states.array_push(rt.call_function('__', [
				rt.new_string('Customization Draft'),
			]))
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('draft'),
			var_post_status))))
		{
			var_post_states.array_set('draft', rt.call_function('_x', [
				rt.new_string('Draft'),
				rt.new_string('post status'),
			]))
		}
	} else if
		rt.is_true(rt.identical(rt.new_string('trash'), rt.get_property(var_post, 'post_status')))
		&& rt.is_true(rt.call_function('get_post_meta', [rt.get_property(var_post, 'ID'), rt.new_string('_customize_changeset_uuid'), rt.new_bool(true)])) {
		var_post_states.array_push(rt.call_function('_x', [
			rt.new_string('Customization Draft'),
			rt.new_string('post status'),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('pending'), rt.get_property(var_post, 'post_status')))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('pending'), var_post_status)))) {
		var_post_states.array_set('pending', rt.call_function('_x', [
			rt.new_string('Pending'),
			rt.new_string('post status'),
		]))
	}
	if rt.is_true(rt.call_function('is_sticky', [rt.get_property(var_post, 'ID')])) {
		var_post_states.array_set('sticky', rt.call_function('_x', [
			rt.new_string('Sticky'),
			rt.new_string('post status'),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('future'), rt.get_property(var_post, 'post_status'))) {
		var_post_states.array_set('scheduled', rt.call_function('_x', [
			rt.new_string('Scheduled'),
			rt.new_string('post status'),
		]))
	}
	if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [
		rt.new_string('show_on_front'),
	])))
	{
		if rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [
			rt.new_string('page_on_front'),
		])).to_i64()), rt.get_property(var_post, 'ID')))
		{
			var_post_states.array_set('page_on_front', rt.call_function('_x', [
				rt.new_string('Front Page'),
				rt.new_string('page label'),
			]))
		}
		if rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [
			rt.new_string('page_for_posts'),
		])).to_i64()), rt.get_property(var_post, 'ID')))
		{
			var_post_states.array_set('page_for_posts', rt.call_function('_x', [
				rt.new_string('Posts Page'),
				rt.new_string('page label'),
			]))
		}
	}
	if rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [
		rt.new_string('wp_page_for_privacy_policy'),
	])).to_i64()), rt.get_property(var_post, 'ID')))
	{
		var_post_states.array_set('page_for_privacy_policy', rt.call_function('_x', [
			rt.new_string('Privacy Policy Page'),
			rt.new_string('page label'),
		]))
	}
	return rt.call_function('apply_filters', [rt.new_string('display_post_states'),
		var_post_states.clone(), var_post.clone()])
}

fn _media_states(var_post rt.PhpVal, display bool) string {
	mut var_display := display
	mut var_media_states := rt.new_null()
	mut var_media_states_string := ''
	mut var_state_count := i64(0)
	mut var_separator := rt.new_null()
	mut var_i := i64(0)
	mut var_state := rt.new_null()
	mut var_suffix := rt.new_null()
	var_media_states = get_media_states(var_post.clone())
	var_media_states_string = ''
	if !(!rt.is_true(var_media_states)) {
		var_state_count = var_media_states.clone().array_count()
		var_separator = rt.call_function('wp_get_list_item_separator', []rt.PhpVal{})
		var_i = 0
		var_media_states_string = var_media_states_string + ' &mdash; '
		mut iter_27 := var_media_states.iterator()
		for {
			item_27 := iter_27.next() or { break }
			mut var_state_shadow := item_27.val
			var_i += 1
			var_suffix = if var_i < var_state_count { var_separator } else { rt.new_string('') }
			var_media_states_string = var_media_states_string +
				"<span class='post-state'>${var_state.to_string()}${var_suffix.to_string()}</span>"
		}
	}
	if var_display {
		print(var_media_states_string)
	}
	return var_media_states_string
}

fn get_media_states(var_post rt.PhpVal) rt.PhpVal {
	mut var_media_states := rt.new_null()
	mut var_stylesheet := rt.new_null()
	mut var_meta_header := rt.new_null()
	mut var_header_images := rt.new_null()
	mut var_header_image := rt.new_null()
	mut var_mods := rt.new_null()
	mut var_meta_background := rt.new_null()
	mut var_background_image := rt.new_null()
	var_media_states = rt.new_array()
	var_stylesheet = rt.call_function('get_option', [rt.new_string('stylesheet')])
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-header'),
	]))
	{
		var_meta_header = rt.call_function('get_post_meta', [
			rt.get_property(var_post, 'ID'),
			rt.new_string('_wp_attachment_is_custom_header'),
			rt.new_bool(true),
		])
		if rt.is_true(rt.call_function('is_random_header_image', []rt.PhpVal{})) {
			if !(!var_header_images.is_null()) {
				var_header_images = rt.call_function('wp_list_pluck', [
					rt.call_function('get_uploaded_header_images', []rt.PhpVal{}),
					rt.new_string('attachment_id'),
				])
			}
			if rt.is_true(rt.identical(var_meta_header, var_stylesheet))
				&& rt.is_true(rt.call_function('in_array', [rt.get_property(var_post, 'ID'), var_header_images.clone(), rt.new_bool(true)])) {
				var_media_states.array_push(rt.call_function('__', [
					rt.new_string('Header Image'),
				]))
			}
		} else {
			var_header_image = rt.call_function('get_header_image', []rt.PhpVal{})
			if !(!rt.is_true(var_meta_header))
				&& rt.is_true(rt.identical(var_meta_header, var_stylesheet))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('wp_get_attachment_url', [rt.get_property(var_post, 'ID')]), var_header_image)))) {
				var_media_states.array_push(rt.call_function('__', [
					rt.new_string('Header Image'),
				]))
			}
			if rt.is_true(var_header_image)
				&& rt.is_true(rt.identical(rt.call_function('wp_get_attachment_url', [rt.get_property(var_post, 'ID')]), var_header_image)) {
				var_media_states.array_push(rt.call_function('__', [
					rt.new_string('Current Header Image'),
				]))
			}
		}
		if rt.is_true(rt.call_function('get_theme_support', [rt.new_string('custom-header'), rt.new_string('video')]))
			&& rt.is_true(rt.call_function('has_header_video', []rt.PhpVal{})) {
			var_mods = rt.call_function('get_theme_mods', []rt.PhpVal{})
			if var_mods.array_isset(rt.new_string('header_video'))
				&& rt.is_true(rt.identical(rt.get_property(var_post, 'ID'), var_mods.array_get(rt.new_string('header_video')))) {
				var_media_states.array_push(rt.call_function('__', [
					rt.new_string('Current Header Video'),
				]))
			}
		}
	}
	if rt.is_true(rt.call_function('current_theme_supports', [
		rt.new_string('custom-background'),
	]))
	{
		var_meta_background = rt.call_function('get_post_meta', [
			rt.get_property(var_post, 'ID'),
			rt.new_string('_wp_attachment_is_custom_background'),
			rt.new_bool(true),
		])
		if !(!rt.is_true(var_meta_background))
			&& rt.is_true(rt.identical(var_meta_background, var_stylesheet)) {
			var_media_states.array_push(rt.call_function('__', [
				rt.new_string('Background Image'),
			]))
			var_background_image = rt.call_function('get_background_image', []rt.PhpVal{})
			if rt.is_true(var_background_image)
				&& rt.is_true(rt.identical(rt.call_function('wp_get_attachment_url', [rt.get_property(var_post, 'ID')]), var_background_image)) {
				var_media_states.array_push(rt.call_function('__', [
					rt.new_string('Current Background Image'),
				]))
			}
		}
	}
	if rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [
		rt.new_string('site_icon'),
	])).to_i64()), rt.get_property(var_post, 'ID')))
	{
		var_media_states.array_push(rt.call_function('__', [rt.new_string('Site Icon')]))
	}
	if rt.is_true(rt.identical(rt.new_int((rt.call_function('get_theme_mod', [
		rt.new_string('custom_logo'),
	])).to_i64()), rt.get_property(var_post, 'ID')))
	{
		var_media_states.array_push(rt.call_function('__', [rt.new_string('Logo')]))
	}
	return rt.call_function('apply_filters', [rt.new_string('display_media_states'),
		var_media_states.clone(), var_post.clone()])
}

fn compression_test() {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [
		rt.call_function('wp_create_nonce', [
			rt.new_string('update_can_compress_scripts'),
		]),
		rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES')),
	]))
	// unsupported statement: Stmt_InlineHTML
}

fn submit_button(text string, type string, name string, wrap bool, other_attributes string) {
	mut var_text := text
	mut var_type := type
	mut var_name := name
	mut var_wrap := wrap
	mut var_other_attributes := other_attributes
	rt.echo_val(get_submit_button(text, type, name, wrap, other_attributes))
}

fn get_submit_button(text string, type string, name string, wrap bool, other_attributes string) rt.PhpVal {
	mut var_text := text
	mut var_type := type
	mut var_name := name
	mut var_wrap := wrap
	mut var_other_attributes := other_attributes
	mut var_button_shorthand := []rt.PhpVal{}
	mut var_classes := []rt.PhpVal{}
	mut var_t := rt.new_null()
	mut var_class := rt.new_null()
	mut var_id := rt.new_null()
	mut var_attributes := ''
	mut var_value := rt.new_null()
	mut var_attribute := rt.new_null()
	mut var_name_attr := rt.new_null()
	mut var_id_attr := rt.new_null()
	mut var_button := rt.new_null()
	if !(rt.new_string(var_type.str()).is_array()) {
		var_type = (rt.call_function('explode', [rt.new_string(' '),
			rt.new_string(var_type.str())])).str()
	}
	var_button_shorthand = ['primary', 'small', 'large']
	var_classes = [rt.new_string('button')]
	mut iter_28 := rt.new_string(var_type.str()).iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_t_shadow := item_28.val
		if rt.is_true(rt.identical(rt.new_string('secondary'), var_t_shadow))
			|| rt.is_true(rt.identical(rt.new_string('button-secondary'), var_t_shadow)) {
			continue
		}
		var_classes << if rt.is_true(rt.call_function('in_array', [
			var_t_shadow.clone(), rt.create_array_from_list(var_button_shorthand),
			rt.new_bool(true)]))
		{ 'button-' + var_t_shadow.str() } else { var_t_shadow }
	}
	var_class = rt.call_function('implode', [rt.new_string(' '),
		rt.call_function('array_unique', [
			rt.call_function('array_filter', [rt.create_array_from_list(var_classes)]),
		])])
	var_text = (if var_text.len > 0 && var_text != '0' { rt.new_string(var_text.str()) } else { rt.call_function('__', [
			rt.new_string('Save Changes'),
		]) }).str()
	var_id = rt.new_string(name)
	if rt.new_string(other_attributes).is_array()
		&& rt.new_string(other_attributes).array_isset(rt.new_string('id')) {
		var_id = rt.new_string(other_attributes).array_get(rt.new_string('id'))
		rt.new_string(other_attributes).array_unset(rt.new_string('id'))
	}
	var_attributes = ''
	if rt.is_true(rt.new_bool(rt.new_string(other_attributes).is_array())) {
		mut iter_29 := rt.new_string(other_attributes).iterator()
		for {
			item_29 := iter_29.next() or { break }
			mut var_value_shadow := item_29.val
			mut var_attribute_shadow := item_29.key
			var_attributes = var_attributes + var_attribute_shadow.str() + '="' +
				(rt.call_function('esc_attr', [var_value_shadow.clone()])).str() + '" '
		}
	} else if !(other_attributes == '') {
		var_attributes = other_attributes
	}
	var_name_attr = rt.new_string((if var_name.len > 0 && var_name != '0' {
		' name="' + (rt.call_function('esc_attr', [rt.new_string(name)])).str() + '"'
	} else {
		''
	}).str())
	var_id_attr = rt.new_string((if rt.is_true(var_id) {
		' id="' + (rt.call_function('esc_attr', [var_id.clone()])).str() + '"'
	} else {
		''
	}).str())
	var_button = rt.new_string('<input type="submit"' + var_name_attr.str() + var_id_attr.str() +
		' class="' + (rt.call_function('esc_attr', [var_class.clone()])).str())
	var_button = rt.concat(var_button, rt.new_string('" value="' +
		(rt.call_function('esc_attr', [rt.new_string(var_text.str())])).str() + '" ' +
		var_attributes + ' />'))
	if var_wrap {
		var_button = rt.new_string('<p class="submit">' + var_button.str() + '</p>')
	}
	return var_button.clone()
}

fn _wp_admin_html_begin() {
	mut var_is_IE := rt.new_null()
	mut var_admin_html_class := ''
	var_admin_html_class = if rt.is_true(rt.call_function('is_admin_bar_showing', []rt.PhpVal{})) {
		'wp-toolbar'
	} else {
		''
	}
	if rt.is_true(var_is_IE) {
		rt.call_function('header', [rt.new_string('X-UA-Compatible: IE=edge')])
	}
	// unsupported statement: Stmt_InlineHTML
	print(var_admin_html_class)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('admin_xml_ns')])
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('html_type')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_option', [rt.new_string('blog_charset')]))
	// unsupported statement: Stmt_InlineHTML
}

fn convert_to_screen(var_hook_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WP_Screen'),
	])))))
	{
		rt.call_function('_doing_it_wrong', [
			rt.new_string('convert_to_screen(), add_meta_box()'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Likely direct inclusion of %1$s in order to use %2$s. This is very wrong. Hook the %2$s call into the %3$s action instead.'),
				]),
				rt.new_string('<code>wp-admin/includes/template.php</code>'),
				rt.new_string('<code>add_meta_box()</code>'),
				rt.new_string('<code>add_meta_boxes</code>'),
			]),
			rt.new_string('3.3.0'),
		])
		return mut rt.array_to_object(rt.create_array([
			rt.ArrayItem{ key: 'id', val: '_invalid' },
			rt.ArrayItem{ key: 'base', val: '_are_belong_to_us' },
		]))
	}
	mut iife_temp_0 := Class_WP_Screen{}
	mut iife_result_0 := iife_temp_0.get(var_hook_name.clone())
	return mut rt.cast_object_ptr[Class_stdClass](iife_result_0)
}

fn _local_storage_notice() {
	mut var_local_storage_message := ''
	var_local_storage_message = '<p class="local-restore">'
	var_local_storage_message = var_local_storage_message +(rt.call_function('__', [rt.new_string('The backup of this post in your browser is different from the version below.')])).str()
	var_local_storage_message = var_local_storage_message +
		'<button type="button" class="button restore-backup">' +
		(rt.call_function('__', [rt.new_string('Restore the backup')])).str() + '</button></p>'
	var_local_storage_message = var_local_storage_message + '<p class="help">'
	var_local_storage_message = var_local_storage_message +(rt.call_function('__', [rt.new_string('This will replace the current editor content with the last backup version. You can use undo and redo in the editor to get the old content back or to return to the restored version.')])).str()
	var_local_storage_message = var_local_storage_message + '</p>'
	rt.call_function('wp_admin_notice', [rt.new_string(var_local_storage_message.str()).clone(),
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'local-storage-notice' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'hidden' },
			]) }, rt.ArrayItem{ key: 'dismissible', val: true },
			rt.ArrayItem{ key: 'paragraph_wrap', val: false }])])
}

fn wp_star_rating(var_args rt.PhpVal) string {
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_rating := rt.new_null()
	mut var_full_stars := rt.new_null()
	mut var_half_stars := rt.new_null()
	mut var_empty_stars := rt.new_null()
	mut var_format := rt.new_null()
	mut var_title := rt.new_null()
	mut var_output := ''
	var_defaults = {
		'rating': rt.new_int(0)
		'type':   rt.new_string('rating')
		'number': rt.new_int(0)
		'echo':   rt.new_bool(true)
	}
	var_parsed_args = rt.call_function('wp_parse_args', [
		rt.create_array_from_native_map(var_args),
		rt.create_array_from_native_map(var_defaults),
	])
	var_rating = rt.new_float((rt.call_function('str_replace', [
		rt.new_string(','), rt.new_string('.'), var_parsed_args.array_get(rt.new_string('rating'))])).to_f64())
	if rt.is_true(rt.identical(rt.new_string('percent'),
		var_parsed_args.array_get(rt.new_string('type'))))
	{
		var_rating = rt.div(rt.call_function('round', [
			rt.div(var_rating, rt.new_int(10)),
			rt.new_int(0),
		]), rt.new_int(2))
	}
	var_full_stars = rt.call_function('floor', [var_rating.clone()])
	var_half_stars = rt.call_function('ceil', [rt.sub(var_rating, var_full_stars)])
	var_empty_stars = rt.sub(rt.sub(rt.new_int(5), var_full_stars), var_half_stars)
	if rt.is_true(var_parsed_args.array_get(rt.new_string('number'))) {
		var_format = rt.call_function('_n', [
			rt.new_string('%1$s rating based on %2$s rating'),
			rt.new_string('%1$s rating based on %2$s ratings'),
			var_parsed_args.array_get(rt.new_string('number')),
		])
		var_title = rt.call_function('sprintf', [var_format.clone(),
			rt.call_function('number_format_i18n', [var_rating.clone(),
				rt.new_int(1)]),
			rt.call_function('number_format_i18n',
				[var_parsed_args.array_get(rt.new_string('number'))])])
	} else {
		var_title = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s rating')]),
			rt.call_function('number_format_i18n', [var_rating.clone(),
				rt.new_int(1)]),
		])
	}
	var_output = '<div class="star-rating">'
	var_output = var_output + '<span class="screen-reader-text">' + var_title.str() + '</span>'
	var_output = var_output +(rt.call_function('str_repeat', [rt.new_string('<div class="star star-full" aria-hidden="true"></div>'), var_full_stars.clone()])).str()
	var_output = var_output +(rt.call_function('str_repeat', [rt.new_string('<div class="star star-half" aria-hidden="true"></div>'), var_half_stars.clone()])).str()
	var_output = var_output +(rt.call_function('str_repeat', [rt.new_string('<div class="star star-empty" aria-hidden="true"></div>'), var_empty_stars.clone()])).str()
	var_output = var_output + '</div>'
	if rt.is_true(var_parsed_args.array_get(rt.new_string('echo'))) {
		print(var_output)
	}
	return var_output
}

fn _wp_posts_page_notice() {
	rt.call_function('wp_admin_notice', [
		rt.call_function('__', [
			rt.new_string('You are currently editing the page that shows your latest posts.'),
		]),
		rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'warning' },
			rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'inline' },
			]) },
		]),
	])
}

fn _wp_block_editor_posts_page_notice() {
	rt.call_function('wp_add_inline_script', [rt.new_string('wp-notices'),
		rt.call_function('sprintf', [
			rt.new_string('wp.data.dispatch( "core/notices" ).createWarningNotice( "%s", { isDismissible: false } )'),
			rt.call_function('__', [
				rt.new_string('You are currently editing the page that shows your latest posts.'),
			]),
		]),
		rt.new_string('after')])
}

struct Class_Walker_Category_Checklist {
	rt.PhpObjectBase
}

struct Class_ReflectionMethod {
	rt.PhpObjectBase
}

struct Class_ReflectionFunction {
	rt.PhpObjectBase
}

struct Class_WP_Screen {
	rt.PhpObjectBase
}

fn create_walker_category_checklist(_args ...rt.PhpVal) &Class_Walker_Category_Checklist {
	mut obj := &Class_Walker_Category_Checklist{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_reflectionmethod(_args ...rt.PhpVal) &Class_ReflectionMethod {
	mut obj := &Class_ReflectionMethod{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_reflectionfunction(_args ...rt.PhpVal) &Class_ReflectionFunction {
	mut obj := &Class_ReflectionFunction{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_screen(_args ...rt.PhpVal) &Class_WP_Screen {
	mut obj := &Class_WP_Screen{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Walker_Category_Checklist) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Walker_Category_Checklist) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker_Category_Checklist) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ReflectionMethod) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ReflectionMethod) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ReflectionMethod) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ReflectionFunction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ReflectionFunction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ReflectionFunction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Screen) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Screen) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Screen) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-walker-category-checklist.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-internal-pointers.php',
		'4')
}
