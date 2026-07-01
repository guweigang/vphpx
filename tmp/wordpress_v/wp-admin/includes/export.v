import rt

const global_const_wxr_version = '1.2'
fn export_wp(var_args rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_defaults := { 'content': rt.new_string('all'), 'author': rt.new_bool(false), 'category': rt.new_bool(false), 'start_date': rt.new_bool(false), 'end_date': rt.new_bool(false), 'status': rt.new_bool(false) }
	var_args = rt.call_function('wp_parse_args', [var_args.dup(), var_defaults.dup()])
	rt.call_function('do_action', [rt.new_string('export_wp'), var_args.dup()])
	mut var_sitename := rt.call_function('sanitize_key', [rt.call_function('get_bloginfo', [rt.new_string('name')])])
	if !(!rt.is_true(var_sitename)) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_date := rt.call_function('gmdate', [rt.new_string('Y-m-d')])
	mut var_wp_filename := rt.new_string((var_sitename).str() + 'WordPress.' + (var_date).str() + '.xml')
	mut var_filename := rt.call_function('apply_filters', [rt.new_string('export_wp_filename'), var_wp_filename.dup(), var_sitename.dup(), var_date.dup()])
	rt.call_function('header', [rt.new_string('Content-Description: File Transfer')])
	rt.call_function('header', ['Content-Disposition: attachment; filename=' + (var_filename).str()])
	rt.call_function('header', ['Content-Type: text/xml; charset=' + (rt.call_function('get_option', [rt.new_string('blog_charset')])).str(), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.call_function('post_type_exists', [var_args.array_get('content')])))) {
		mut var_ptype := rt.call_function('get_post_type_object', [var_args.array_get('content')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_ptype, 'can_export'))))) {
			var_args.array_set('content', 'post')
		}
		mut var_where := rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_type = %s')), var_args.array_get('content')])
	} else {
		mut var_post_types := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'can_export', val: true }])])
		mut var_esses := rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_post_types.dup().array_count()), rt.new_string('%s')])
		var_where = rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_type IN (')) + (rt.call_function('implode', [rt.new_string(','), var_esses.dup()])).str() + ')', var_post_types.dup()])
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_args.array_get('status')) && rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('post'), var_args.array_get('content'))) || rt.is_true(rt.identical(rt.new_string('page'), var_args.array_get('content'))))))) {
		// unsupported expression: Expr_AssignOp_Concat
	} else {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_join := ''
	if rt.is_true(rt.new_bool(rt.is_true(var_args.array_get('category')) && rt.is_true(rt.identical(rt.new_string('post'), var_args.array_get('content'))))) {
		mut var_term := rt.call_function('term_exists', [var_args.array_get('category'), rt.new_string('category')])
		if rt.is_true(var_term) {
			var_join = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INNER JOIN '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' ON (')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID = ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string('.object_id)'))
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	if rt.is_true(rt.call_function('in_array', [var_args.array_get('content'), rt.create_array([rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'attachment' }]), rt.new_bool(true)])) {
		if rt.is_true(var_args.array_get('author')) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		if rt.is_true(var_args.array_get('start_date')) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		if rt.is_true(var_args.array_get('end_date')) {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	mut var_post_ids := rt.call_method(var_wpdb, 'get_col', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ')), rt.new_string(var_join)), rt.new_string(' WHERE ')), var_where)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args.array_get('content'), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'attachment' }]), rt.new_bool(true)]))))) {
		mut var_additional_ids := rt.new_array()
		mut var_processing_ids := var_post_ids.dup()
		for rt.is_true(mut var_next_posts := rt.call_function('array_splice', [var_processing_ids.dup(), rt.new_int(0), rt.new_int(20)])) {
			mut var_posts_in := rt.call_function('array_map', [rt.new_string('absint'), var_next_posts.dup()])
			mut var_placeholders := rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_posts_in.dup().array_count()), rt.new_string('%d')])
			mut var_in_placeholder := rt.call_function('implode', [rt.new_string(','), var_placeholders.dup()])
			mut var_attachment_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT ID\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\t\tWHERE post_parent IN (')), var_in_placeholder), rt.new_string(') AND post_type = \'attachment\'\n\t\t\t\t\t')), var_posts_in.dup()])])
			mut var_thumbnails_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT meta_value\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\t\t\tWHERE ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.post_id IN (')), var_in_placeholder), rt.new_string(')\n\t\t\t\tAND ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.meta_key = \'_thumbnail_id\'\n\t\t\t\t\t')), var_posts_in.dup()])])
			var_additional_ids = rt.call_function('array_merge', [var_additional_ids.dup(), var_attachment_ids.dup(), var_thumbnails_ids.dup()])
		}
		var_post_ids = rt.call_function('array_unique', [rt.call_function('array_merge', [var_post_ids.dup(), var_additional_ids.dup()])])
	}
	mut var_cats := rt.new_array()
	mut var_tags := rt.new_array()
	mut var_terms := rt.new_array()
	if rt.is_true(rt.new_bool(!(var_term).is_null() && rt.is_true(var_term))) {
		mut var_cat := rt.call_function('get_term', [var_term.array_get('term_id'), rt.new_string('category')])
		var_cats = rt.create_array([rt.ArrayItem{ key: rt.get_property(var_cat, 'term_id'), val: var_cat }])
		var_term = rt.new_null()
		var_cat = rt.new_null()
	} else if rt.is_true(rt.identical(rt.new_string('all'), var_args.array_get('content'))) {
		mut var_categories := rt.cast_array(rt.call_function('get_categories', [rt.create_array([rt.ArrayItem{ key: 'get', val: 'all' }])]))
		var_tags = rt.cast_array(rt.call_function('get_tags', [rt.create_array([rt.ArrayItem{ key: 'get', val: 'all' }])]))
		mut var_custom_taxonomies := rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: '_builtin', val: false }])])
		mut var_custom_terms := rt.cast_array(rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_custom_taxonomies }, rt.ArrayItem{ key: 'get', val: 'all' }])]))
		for rt.is_true(var_cat = rt.call_function('array_shift', [var_categories.dup()])) {
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_cat, 'parent'))))) || var_cats.array_isset(rt.get_property(var_cat, 'parent')))) {
				var_cats.array_set(rt.get_property(var_cat, 'term_id'), var_cat.dup())
			} else {
				var_categories.array_push(var_cat.dup())
			}
		}
		for rt.is_true(mut var_t := rt.call_function('array_shift', [var_custom_terms.dup()])) {
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_t, 'parent'))))) || var_terms.array_isset(rt.get_property(var_t, 'parent')))) {
				var_terms.array_set(rt.get_property(var_t, 'term_id'), var_t.dup())
			} else {
				var_custom_terms.array_push(var_t.dup())
			}
		}
		var_categories = rt.new_null()
		var_custom_taxonomies = rt.new_null()
		var_custom_terms = rt.new_null()
	}
fn wxr_cdata(var_str rt.PhpVal) rt.PhpVal {
	var_str = // unsupported expression: Expr_Cast_String
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_valid_utf8', [var_str.dup()]))))) {
		var_str = rt.call_function('utf8_encode', [var_str.dup()])
	}
	var_str = rt.new_string('<![CDATA[' + (rt.call_function('str_replace', [rt.new_string(']]>'), rt.new_string(']]]]><![CDATA[>'), var_str.dup()])).str() + ']]>')
	return var_str.dup()
}

fn wxr_site_url() rt.PhpVal {
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		return rt.call_function('network_home_url', []rt.PhpVal{})
	} else {
		return rt.call_function('get_bloginfo_rss', [rt.new_string('url')])
	}
	return rt.new_null()
}

fn wxr_cat_name(var_category rt.PhpVal) {
	if !rt.is_true(rt.get_property(var_category, 'name')) {
		return rt.new_null()
	}
	print('<wp:cat_name>' + (wxr_cdata(rt.get_property(var_category, 'name'))).str() + '</wp:cat_name>\n')
}

fn wxr_category_description(var_category rt.PhpVal) {
	if !rt.is_true(rt.get_property(var_category, 'description')) {
		return rt.new_null()
	}
	print('<wp:category_description>' + (wxr_cdata(rt.get_property(var_category, 'description'))).str() + '</wp:category_description>\n')
}

fn wxr_tag_name(var_tag rt.PhpVal) {
	if !rt.is_true(rt.get_property(var_tag, 'name')) {
		return rt.new_null()
	}
	print('<wp:tag_name>' + (wxr_cdata(rt.get_property(var_tag, 'name'))).str() + '</wp:tag_name>\n')
}

fn wxr_tag_description(var_tag rt.PhpVal) {
	if !rt.is_true(rt.get_property(var_tag, 'description')) {
		return rt.new_null()
	}
	print('<wp:tag_description>' + (wxr_cdata(rt.get_property(var_tag, 'description'))).str() + '</wp:tag_description>\n')
}

fn wxr_term_name(var_term rt.PhpVal) {
	if !rt.is_true(rt.get_property(var_term, 'name')) {
		return rt.new_null()
	}
	print('<wp:term_name>' + (wxr_cdata(rt.get_property(var_term, 'name'))).str() + '</wp:term_name>\n')
}

fn wxr_term_description(var_term rt.PhpVal) {
	if !rt.is_true(rt.get_property(var_term, 'description')) {
		return rt.new_null()
	}
	print('\t\t<wp:term_description>' + (wxr_cdata(rt.get_property(var_term, 'description'))).str() + '</wp:term_description>\n')
}

fn wxr_term_meta(var_term rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_termmeta := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'termmeta')), rt.new_string(' WHERE term_id = %d')), rt.get_property(var_term, 'term_id')])])
	{
		mut iter_1 := var_termmeta.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('wxr_export_skip_termmeta'), rt.new_bool(false), rt.get_property(var_meta, 'meta_key'), var_meta.dup()]))))) {
				rt.call_function('printf', [rt.new_string('\t\t<wp:termmeta>\n\t\t\t<wp:meta_key>%s</wp:meta_key>\n\t\t\t<wp:meta_value>%s</wp:meta_value>\n\t\t</wp:termmeta>\n'), wxr_cdata(rt.get_property(var_meta, 'meta_key')), wxr_cdata(rt.get_property(var_meta, 'meta_value'))])
			}
		}
	}
}

fn wxr_authors_list(var_post_ids rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(!rt.is_true(var_post_ids)) {
		var_post_ids = rt.call_function('array_map', [rt.new_string('absint'), var_post_ids.dup()])
		mut var_post_id_chunks := rt.call_function('array_chunk', [var_post_ids.dup(), rt.new_int(20)])
	} else {
		var_post_id_chunks = rt.create_array([rt.ArrayItem{ key: none, val: rt.new_array() }])
	}
	mut var_authors := rt.new_array()
	{
		mut iter_1 := var_post_id_chunks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_next_posts := item_1.val
			mut var_and := rt.new_string(if !(!rt.is_true(var_next_posts)) {  + ().str() + ')' } else { rt.new_string('') })
			mut var_results := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.concat(, ), ), )])
			{
				mut iter_2 := rt.cast_array(var_results).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_result := item_2.val
					.array_push()
				}
			}
		}
	}
	
}



pub fn init_wp_admin_includes_export_php() {
	return false
}

}
