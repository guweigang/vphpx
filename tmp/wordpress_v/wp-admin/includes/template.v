import rt

fn wp_category_checklist(post_id i64, descendants_and_self i64, selected_cats bool, popular_cats bool, var_walker rt.PhpVal, checked_ontop bool) {
	rt.new_string(wp_terms_checklist(post_id, rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'category' }, rt.ArrayItem{ key: 'descendants_and_self', val: descendants_and_self }, rt.ArrayItem{ key: 'selected_cats', val: selected_cats }, rt.ArrayItem{ key: 'popular_cats', val: popular_cats }, rt.ArrayItem{ key: 'walker', val: var_walker }, rt.ArrayItem{ key: 'checked_ontop', val: checked_ontop }])))
}

fn wp_terms_checklist(post_id i64, var_args rt.PhpVal) string {
	mut var_defaults := { 'descendants_and_self': rt.new_int(0), 'selected_cats': rt.new_bool(false), 'popular_cats': rt.new_bool(false), 'walker': rt.new_null(), 'taxonomy': rt.new_string('category'), 'checked_ontop': rt.new_bool(true), 'echo': rt.new_bool(true) }
	mut var_params := rt.call_function('apply_filters', [rt.new_string('wp_terms_checklist_args'), var_args.dup(), rt.new_int(post_id)])
	mut var_parsed_args := rt.call_function('wp_parse_args', [var_params.dup(), var_defaults.dup()])
	if rt.is_true(rt.new_bool(!rt.is_true(var_parsed_args.array_get('walker')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_parsed_args.array_get('walker'), 'Walker')))))))) {
		mut var_walker := create_walker_category_checklist()
	} else {
		var_walker = var_parsed_args.array_get('walker')
	}
	mut var_taxonomy := var_parsed_args.array_get('taxonomy')
	mut var_descendants_and_self := // unsupported expression: Expr_Cast_Int
	var_args = { 'taxonomy': var_taxonomy }
	mut var_tax := rt.call_function('get_taxonomy', [var_taxonomy.dup()])
	var_args.array_set('disabled', !(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_tax, 'cap'), 'assign_terms')]))))
	var_args.array_set('list_only', !(!rt.is_true(var_parsed_args.array_get('list_only'))))
	if rt.is_true(rt.new_bool(var_parsed_args.array_get('selected_cats').is_array())) {
		var_args.array_set('selected_cats', rt.call_function('array_map', [rt.new_string('intval'), var_parsed_args.array_get('selected_cats')]))
	} else if var_post_id != 0 {
		var_args.array_set('selected_cats', rt.call_function('wp_get_object_terms', [rt.new_int(post_id), var_taxonomy.dup(), rt.call_function('array_merge', [var_args.dup(), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }])])]))
	} else {
		var_args.array_set('selected_cats', rt.new_array())
	}
	if rt.is_true(rt.new_bool(var_parsed_args.array_get('popular_cats').is_array())) {
		var_args.array_set('popular_cats', rt.call_function('array_map', [rt.new_string('intval'), var_parsed_args.array_get('popular_cats')]))
	} else {
		var_args.array_set('popular_cats', rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'orderby', val: 'count' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'number', val: 10 }, rt.ArrayItem{ key: 'hierarchical', val: false }])]))
	}
	if rt.is_true(var_descendants_and_self) {
		mut var_categories := rt.cast_array(rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'child_of', val: var_descendants_and_self }, rt.ArrayItem{ key: 'hierarchical', val: 0 }, rt.ArrayItem{ key: 'hide_empty', val: 0 }])]))
		mut var_self := rt.call_function('get_term', [var_descendants_and_self.dup(), var_taxonomy.dup()])
		rt.call_function('array_unshift', [var_categories.dup(), var_self.dup()])
	} else {
		var_categories = rt.cast_array(rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'get', val: 'all' }])]))
	}
	mut var_output := ''
	if rt.is_true(var_parsed_args.array_get('checked_ontop')) {
		mut var_checked_categories := rt.new_array()
		mut var_keys := rt.func_array_keys(var_categories.dup())
		{
			mut iter_1 := var_keys.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_k := item_1.val
				if rt.is_true(rt.call_function('in_array', [rt.get_property(var_categories.array_get(var_k), 'term_id'), var_args.array_get('selected_cats'), rt.new_bool(true)])) {
					var_checked_categories.array_push(var_categories.array_get(var_k))
					var_categories.array_unset(var_k)
				}
			}
		}
		// unsupported expression: Expr_AssignOp_Concat
	}
	// unsupported expression: Expr_AssignOp_Concat
	if rt.is_true(var_parsed_args.array_get('echo')) {
		print(var_output)
	}
	return var_output
}

fn wp_popular_terms_checklist(var_taxonomy rt.PhpVal, default_term i64, number i64, display bool) rt.PhpVal {
	mut var_post := rt.call_function('get_post', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(var_post) && rt.is_true(rt.get_property(var_post, 'ID')))) {
		mut var_checked_terms := rt.call_function('wp_get_object_terms', [rt.get_property(var_post, 'ID'), var_taxonomy.dup(), rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }])])
	} else {
		var_checked_terms = rt.new_array()
	}
	mut var_terms := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy }, rt.ArrayItem{ key: 'orderby', val: 'count' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'number', val: number }, rt.ArrayItem{ key: 'hierarchical', val: false }])])
	mut var_tax := rt.call_function('get_taxonomy', [var_taxonomy.dup()])
	mut var_popular_ids := rt.new_array()
	{
		mut iter_1 := rt.cast_array(var_terms).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			var_popular_ids << rt.get_property(var_term, 'term_id')
			if !(var_display) {
				continue
			}
			mut var_id := rt.concat(rt.concat(rt.concat(rt.new_string('popular-'), var_taxonomy), rt.new_string('-')), rt.get_property(var_term, 'term_id'))
			mut var_checked := if rt.is_true(rt.call_function('in_array', [rt.get_property(var_term, 'term_id'), var_checked_terms.dup(), rt.new_bool(true)])) { 'checked="checked"' } else { '' }
			// unsupported statement: Stmt_InlineHTML
			print(var_id)
			// unsupported statement: Stmt_InlineHTML
			print(var_id)
			// unsupported statement: Stmt_InlineHTML
			print(var_checked)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(// unsupported expression: Expr_Cast_Int)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('disabled', [rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_tax, 'cap'), 'assign_terms')]))))])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [rt.call_function('apply_filters', [rt.new_string('the_category'), rt.get_property(var_term, 'name'), rt.new_string(''), rt.new_string('')])]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	return var_popular_ids.dup()
}

fn wp_link_category_checklist(link_id i64) {
	mut var_default := 1
	mut var_checked_categories := rt.new_array()
	if var_link_id != 0 {
		var_checked_categories = rt.call_function('wp_get_link_cats', [rt.new_int(link_id)])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_checked_categories.dup().array_count()))))) {
			var_checked_categories.array_push(var_default)
		}
	} else {
		var_checked_categories.array_push(var_default)
	}
	mut var_categories := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'link_category' }, rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'hide_empty', val: 0 }])])
	if !rt.is_true(var_categories) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_categories.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			mut var_cat_id := rt.get_property(var_category, 'term_id')
			mut var_name := rt.call_function('esc_html', [rt.call_function('apply_filters', [rt.new_string('the_category'), rt.get_property(var_category, 'name'), rt.new_string(''), rt.new_string('')])])
			mut var_checked := if rt.is_true(rt.call_function('in_array', [var_cat_id.dup(), var_checked_categories.dup(), rt.new_bool(true)])) { ' checked="checked"' } else { '' }
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
}

fn get_inline_data(var_post rt.PhpVal) {
	mut var_post_type_object := rt.call_function('get_post_type_object', [rt.get_property(var_post, 'post_type')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_post'), rt.get_property(var_post, 'ID')]))))) {
		return rt.new_null()
	}
	mut var_title := rt.call_function('esc_textarea', [rt.new_string(rt.get_property(var_post, 'post_title').to_string().trim_space())])
	print( +  + (rt.call_function('esc_html', [])).str() + '</div>\n\t<div class="ping_status">' + (rt.call_function('esc_html', [rt.get_property(var_post, 'ping_status')])).str() + '</div>\n\t<div class="_status">' + (rt.call_function('esc_html', [rt.get_property(var_post, 'post_status')])).str() + '</div>\n\t<div class="jj">' + (rt.call_function('mysql2date', [rt.new_string('d'), rt.get_property(var_post, 'post_date'), rt.new_bool(false)])).str() + '</div>\n\t<div class="mm">' + (rt.call_function('mysql2date', [rt.new_string('m'), rt.get_property(var_post, 'post_date'), rt.new_bool(false)])).str() + '</div>\n\t<div class="aa">' + (rt.call_function('mysql2date', [rt.new_string('Y'), rt.get_property(var_post, 'post_date'), rt.new_bool(false)])).str() + '</div>\n\t<div class="hh">' + (rt.call_function('mysql2date', [rt.new_string('H'), rt.get_property(var_post, 'post_date'), rt.new_bool(false)])).str() + '</div>\n\t<div class="mn">' + (rt.call_function('mysql2date', [rt.new_string('i'), rt.get_property(var_post, 'post_date'), rt.new_bool(false)])).str() + '</div>\n\t<div class="ss">' + (rt.call_function('mysql2date', [rt.new_string('s'), rt.get_property(var_post, 'post_date'), rt.new_bool(false)])).str() + '</div>\n\t<div class="post_password">' + (rt.call_function('esc_html', [rt.get_property(var_post, 'post_password')])).str() + '</div>')
	if rt.is_true(rt.get_property(var_post_type_object, 'hierarchical')) {
		print('<div class="post_parent">' + (rt.get_property(var_post, 'post_parent')).str() + '</div>')
	}
	print('<div class="page_template">' + (if rt.is_true(rt.get_property(var_post, 'page_template')) { rt.call_function('esc_html', [rt.get_property(var_post, 'page_template')]) } else { rt.new_string('default') }).str() + '</div>')
	if rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_post, 'post_type'), rt.new_string('page-attributes')])) {
		print('<div class="menu_order">' + (rt.get_property(var_post, 'menu_order')).str() + '</div>')
	}
	mut var_taxonomy_names := rt.call_function('get_object_taxonomies', [rt.get_property(var_post, 'post_type')])
	{
		mut iter_1 := var_taxonomy_names.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_taxonomy_name := item_1.val
			mut var_taxonomy := rt.call_function('get_taxonomy', [var_taxonomy_name.dup()])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_taxonomy, 'show_in_quick_edit'))))) {
				continue
			}
			if rt.is_true(rt.get_property(var_taxonomy, 'hierarchical')) {
				mut var_terms := rt.call_function('get_object_term_cache', [rt.get_property(var_post, 'ID'), var_taxonomy_name.dup()])
				if rt.is_true(rt.identical(rt.new_bool(false), var_terms)) {
					var_terms = rt.call_function('wp_get_object_terms', [rt.get_property(var_post, 'ID'), var_taxonomy_name.dup()])
					rt.call_function('wp_cache_add', [rt.get_property(var_post, 'ID'), rt.call_function('wp_list_pluck', [var_terms.dup(), rt.new_string('term_id')]), (var_taxonomy_name).str() + '_relationships'])
				}
				mut var_term_ids := if !rt.is_true(var_terms) { rt.new_array() } else { rt.call_function('wp_list_pluck', [var_terms.dup(), rt.new_string('term_id')]) }
				print('<div class="post_category" id="' + (var_taxonomy_name).str() + '_' + (rt.get_property(var_post, 'ID')).str() + '">' + (rt.call_function('implode', [rt.new_string(','), var_term_ids.dup()])).str() + '</div>')
			} else {
				mut var_terms_to_edit := rt.call_function('get_terms_to_edit', [rt.get_property(var_post, 'ID'), var_taxonomy_name.dup()])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_terms_to_edit.dup().is_string()))))) {
					var_terms_to_edit = rt.new_string(rt.new_string(''))
				}
				print( +  + (rt.get_property(, 'ID')).str() + '">' + (rt.call_function('esc_html', [rt.call_function('str_replace', [rt.new_string(','), rt.new_string(', '), var_terms_to_edit.dup()])])).str() + '</div>')
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_type_object, 'hierarchical'))))) {
		print('<div class="sticky">' + if rt.is_true(rt.call_function('is_sticky', [])) { 'sticky' } else { '' } + '</div>')
	}
	if rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_post, 'post_type'), rt.new_string('post-formats')])) {
		print('<div class="post_format">' + (rt.call_function('esc_html', [])).str() + '</div>')
	}
	rt.call_function('do_action', [rt.new_string('add_inline_data'), var_post.dup(), var_post_type_object.dup()])
	print('</div>')
}

fn wp_comment_reply(position i64, checkbox bool, mode string, table_row bool) {
	// unsupported statement: Stmt_Global
}

struct Class_Walker_Category_Checklist {
	rt.PhpObjectBase
}

fn create_walker_category_checklist() &Class_Walker_Category_Checklist {
	mut obj := &Class_Walker_Category_Checklist{
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




pub fn init_wp_admin_includes_template_php() {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-walker-category-checklist.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-internal-pointers.php', '4')
}
