import rt

const global_const_wxr_version = '1.2'
fn export_wp(var_args_arg rt.PhpVal) bool {
	mut var_args := var_args_arg
	mut var_wpdb := rt.new_null()
	mut var_wp_query := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_sitename := rt.new_null()
	mut var_date := rt.new_null()
	mut var_wp_filename := rt.new_null()
	mut var_filename := rt.new_null()
	mut var_ptype := rt.new_null()
	mut var_where := rt.new_null()
	mut var_post_types := rt.new_null()
	mut var_esses := rt.new_null()
	mut var_join := ''
	mut var_term := rt.new_null()
	mut var_post_ids := rt.new_null()
	mut var_additional_ids := rt.new_null()
	mut var_processing_ids := rt.new_null()
	mut var_next_posts := rt.new_null()
	mut var_posts_in := rt.new_null()
	mut var_placeholders := rt.new_null()
	mut var_in_placeholder := rt.new_null()
	mut var_attachment_ids := rt.new_null()
	mut var_thumbnails_ids := rt.new_null()
	mut var_cats := rt.new_null()
	mut var_tags := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_cat := rt.new_null()
	mut var_categories := rt.new_null()
	mut var_custom_taxonomies := rt.new_null()
	mut var_custom_terms := rt.new_null()
	mut var_t := rt.new_null()
	mut var_c := rt.new_null()
	mut var_posts := rt.new_null()
	mut var_post := rt.new_null()
	mut var_title := rt.new_null()
	mut var_content := rt.new_null()
	mut var_excerpt := rt.new_null()
	mut var_is_sticky := i64(0)
	mut var_postmeta := rt.new_null()
	mut var_meta := rt.new_null()
	mut var__comments := rt.new_null()
	mut var_comments := rt.new_null()
	mut var_c_meta := rt.new_null()
	var_defaults = { 'content': rt.new_string('all'), 'author': rt.new_bool(false), 'category': rt.new_bool(false), 'start_date': rt.new_bool(false), 'end_date': rt.new_bool(false), 'status': rt.new_bool(false) }
	var_args = rt.call_function('wp_parse_args', [var_args.clone(), rt.create_array_from_native_map(var_defaults)])
	rt.call_function('do_action', [rt.new_string('export_wp'), var_args.clone()])
	var_sitename = rt.call_function('sanitize_key', [rt.call_function('get_bloginfo', [rt.new_string('name')])])
	if !(!rt.is_true(var_sitename)) {
		var_sitename = rt.concat(var_sitename, rt.new_string('.'))
	}
	var_date = rt.call_function('gmdate', [rt.new_string('Y-m-d')])
	var_wp_filename = rt.new_string((var_sitename).str() + 'WordPress.' + (var_date).str() + '.xml')
	var_filename = rt.call_function('apply_filters', [rt.new_string('export_wp_filename'), var_wp_filename.clone(), var_sitename.clone(), var_date.clone()])
	rt.call_function('header', [rt.new_string('Content-Description: File Transfer')])
	rt.call_function('header', [rt.new_string('Content-Disposition: attachment; filename=' + (var_filename).str())])
	rt.call_function('header', [rt.new_string('Content-Type: text/xml; charset=' + (rt.call_function('get_option', [rt.new_string('blog_charset')])).str()), rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_args.array_get(rt.new_string('content')))))) && rt.is_true(rt.call_function('post_type_exists', [var_args.array_get(rt.new_string('content'))])) {
		var_ptype = rt.call_function('get_post_type_object', [var_args.array_get(rt.new_string('content'))])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_ptype, 'can_export'))))) {
			var_args.array_set('content', 'post')
		}
	var_where = rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_type = %s')), var_args.array_get(rt.new_string('content'))])
	} else {
	var_post_types = rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'can_export', val: true }])])
	var_esses = rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_post_types.clone().array_count()), rt.new_string('%s')])
	var_where = rt.call_method(var_wpdb, 'prepare', [rt.new_string((rt.concat(rt.get_property(var_wpdb, 'posts'), rt.new_string('.post_type IN (')) + (rt.call_function('implode', [rt.new_string(','), var_esses.clone()])).str() + ')').str()), var_post_types.clone()])
	}
	if rt.is_true(var_args.array_get(rt.new_string('status'))) && rt.is_true(rt.identical(rt.new_string('post'), var_args.array_get(rt.new_string('content')))) || rt.is_true(rt.identical(rt.new_string('page'), var_args.array_get(rt.new_string('content')))) {
		var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_status = %s')), var_args.array_get(rt.new_string('status'))]))
	} else {
		var_where = rt.concat(var_where, rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_status != \'auto-draft\'')))
	}
	var_join = ''
	if rt.is_true(var_args.array_get(rt.new_string('category'))) && rt.is_true(rt.identical(rt.new_string('post'), var_args.array_get(rt.new_string('content')))) {
		var_term = rt.call_function('term_exists', [var_args.array_get(rt.new_string('category')), rt.new_string('category')])
		if rt.is_true(var_term) {
			var_join = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('INNER JOIN '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' ON (')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.ID = ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string('.object_id)'))
			var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string('.term_taxonomy_id = %d')), var_term.array_get(rt.new_string('term_taxonomy_id'))]))
		}
	}
	if rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('content')), rt.create_array([rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'page' }, rt.ArrayItem{ key: none, val: 'attachment' }]), rt.new_bool(true)])) {
		if rt.is_true(var_args.array_get(rt.new_string('author'))) {
			var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_author = %d')), var_args.array_get(rt.new_string('author'))]))
		}
		if rt.is_true(var_args.array_get(rt.new_string('start_date'))) {
			var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_date >= %s')), rt.call_function('gmdate', [rt.new_string('Y-m-d'), rt.call_function('strtotime', [var_args.array_get(rt.new_string('start_date'))])])]))
		}
		if rt.is_true(var_args.array_get(rt.new_string('end_date'))) {
			var_where = rt.concat(var_where, rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string(' AND '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_date < %s')), rt.call_function('gmdate', [rt.new_string('Y-m-d'), rt.call_function('strtotime', [rt.new_string('+1 month'), rt.call_function('strtotime', [var_args.array_get(rt.new_string('end_date'))])])])]))
		}
	}
	var_post_ids = rt.call_method(var_wpdb, 'get_col', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ')), rt.new_string((var_join).str())), rt.new_string(' WHERE ')), var_where)])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_args.array_get(rt.new_string('content')), rt.create_array([rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: 'attachment' }]), rt.new_bool(true)]))))) {
		var_additional_ids = rt.new_array()
		var_processing_ids = var_post_ids.clone()
		var_next_posts = rt.call_function('array_splice', [var_processing_ids.clone(), rt.new_int(0), rt.new_int(20)])
		for rt.is_true(var_next_posts) {
		var_posts_in = rt.call_function('array_map', [rt.new_string('absint'), var_next_posts.clone()])
		var_placeholders = rt.call_function('array_fill', [rt.new_int(0), rt.new_int(var_posts_in.clone().array_count()), rt.new_string('%d')])
		var_in_placeholder = rt.call_function('implode', [rt.new_string(','), var_placeholders.clone()])
		var_attachment_ids = rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT ID\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\t\tWHERE post_parent IN (')), var_in_placeholder), rt.new_string(') AND post_type = \'attachment\'\n\t\t\t\t\t')), var_posts_in.clone()])])
		var_thumbnails_ids = rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT meta_value\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\t\t\tWHERE ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.post_id IN (')), var_in_placeholder), rt.new_string(')\n\t\t\t\tAND ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.meta_key = \'_thumbnail_id\'\n\t\t\t\t\t')), var_posts_in.clone()])])
		var_additional_ids = rt.call_function('array_merge', [var_additional_ids.clone(), var_attachment_ids.clone(), var_thumbnails_ids.clone()])
		}
	var_post_ids = rt.call_function('array_unique', [rt.call_function('array_merge', [var_post_ids.clone(), var_additional_ids.clone()])])
	}
	var_cats = rt.new_array()
	var_tags = rt.new_array()
	var_terms = rt.new_array()
	if !(var_term).is_null() && rt.is_true(var_term) {
		var_cat = rt.call_function('get_term', [var_term.array_get(rt.new_string('term_id')), rt.new_string('category')])
		var_cats = rt.create_array([rt.ArrayItem{ key: rt.get_property(var_cat, 'term_id'), val: var_cat }])
		var_term = rt.new_null()
		var_cat = rt.new_null()
	} else if rt.is_true(rt.identical(rt.new_string('all'), var_args.array_get(rt.new_string('content')))) {
		var_categories = rt.cast_array(rt.call_function('get_categories', [rt.create_array([rt.ArrayItem{ key: 'get', val: 'all' }])]))
		var_tags = rt.cast_array(rt.call_function('get_tags', [rt.create_array([rt.ArrayItem{ key: 'get', val: 'all' }])]))
		var_custom_taxonomies = rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: '_builtin', val: false }])])
		var_custom_terms = rt.cast_array(rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_custom_taxonomies }, rt.ArrayItem{ key: 'get', val: 'all' }])]))
		var_cat = rt.call_function('array_shift', [var_categories.clone()])
		for rt.is_true(var_cat) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_cat, 'parent'))))) || var_cats.array_isset(rt.get_property(var_cat, 'parent')) {
				var_cats.array_set(rt.get_property(var_cat, 'term_id'), var_cat.clone())
			} else {
				var_categories.array_push(var_cat.clone())
			}
		}
		var_t = rt.call_function('array_shift', [var_custom_terms.clone()])
		for rt.is_true(var_t) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_t, 'parent'))))) || var_terms.array_isset(rt.get_property(var_t, 'parent')) {
				var_terms.array_set(rt.get_property(var_t, 'term_id'), var_t.clone())
			} else {
				var_custom_terms.array_push(var_t.clone())
			}
		}
		var_categories = rt.new_null()
		var_custom_taxonomies = rt.new_null()
		var_custom_terms = rt.new_null()
	}
fn wxr_cdata(var_str_arg rt.PhpVal) rt.PhpVal {
	mut var_str := var_str_arg
	var_str = rt.new_string((var_str).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_valid_utf8', [var_str.clone()]))))) {
	var_str = rt.call_function('utf8_encode', [var_str.clone()])
	}
	var_str = rt.new_string('<![CDATA[' + (rt.call_function('str_replace', [rt.new_string(']]>'), rt.new_string(']]]]><![CDATA[>'), var_str.clone()])).str() + ']]>')
	return var_str.clone()
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
		return
	}
	print('<wp:cat_name>' + (wxr_cdata(rt.get_property(var_category, 'name'))).str() + '</wp:cat_name>\n')
}

fn wxr_category_description(var_category rt.PhpVal) {
	if !rt.is_true(rt.get_property(var_category, 'description')) {
		return
	}
	print('<wp:category_description>' + (wxr_cdata(rt.get_property(var_category, 'description'))).str() + '</wp:category_description>\n')
}

fn wxr_tag_name(var_tag rt.PhpVal) {
	if !rt.is_true(rt.get_property(var_tag, 'name')) {
		return
	}
	print('<wp:tag_name>' + (wxr_cdata(rt.get_property(var_tag, 'name'))).str() + '</wp:tag_name>\n')
}

fn wxr_tag_description(var_tag rt.PhpVal) {
	if !rt.is_true(rt.get_property(var_tag, 'description')) {
		return
	}
	print('<wp:tag_description>' + (wxr_cdata(rt.get_property(var_tag, 'description'))).str() + '</wp:tag_description>\n')
}

fn wxr_term_name(var_term rt.PhpVal) {
	if !rt.is_true(rt.get_property(var_term, 'name')) {
		return
	}
	print('<wp:term_name>' + (wxr_cdata(rt.get_property(var_term, 'name'))).str() + '</wp:term_name>\n')
}

fn wxr_term_description(var_term rt.PhpVal) {
	if !rt.is_true(rt.get_property(var_term, 'description')) {
		return
	}
	print('\t\t<wp:term_description>' + (wxr_cdata(rt.get_property(var_term, 'description'))).str() + '</wp:term_description>\n')
}

fn wxr_term_meta(var_term rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_termmeta := rt.new_null()
	mut var_meta := rt.new_null()
	var_termmeta = rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'termmeta')), rt.new_string(' WHERE term_id = %d')), rt.get_property(var_term, 'term_id')])])
	mut iter_1 := var_termmeta.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_meta_shadow := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('wxr_export_skip_termmeta'), rt.new_bool(false), rt.get_property(var_meta_shadow, 'meta_key'), var_meta_shadow.clone()]))))) {
			rt.call_function('printf', [rt.new_string('\t\t<wp:termmeta>\n\t\t\t<wp:meta_key>%s</wp:meta_key>\n\t\t\t<wp:meta_value>%s</wp:meta_value>\n\t\t</wp:termmeta>\n'), wxr_cdata(rt.get_property(var_meta_shadow, 'meta_key')), wxr_cdata(rt.get_property(var_meta_shadow, 'meta_value'))])
		}
	}
}

fn wxr_authors_list(var_post_ids_arg rt.PhpVal) {
	mut var_post_ids := var_post_ids_arg
	mut var_wpdb := rt.new_null()
	mut var_post_id_chunks := rt.new_null()
	mut var_authors := rt.new_null()
	mut var_next_posts := rt.new_null()
	mut var_and := rt.new_null()
	mut var_results := rt.new_null()
	mut var_result := rt.new_null()
	mut var_author := rt.new_null()
	if !(!rt.is_true(var_post_ids)) {
	var_post_ids = rt.call_function('array_map', [rt.new_string('absint'), var_post_ids.clone()])
	var_post_id_chunks = rt.call_function('array_chunk', [var_post_ids.clone(), rt.new_int(20)])
	} else {
	var_post_id_chunks = rt.create_array([rt.ArrayItem{ key: none, val: rt.new_array() }])
	}
	var_authors = rt.new_array()
	mut iter_2 := var_post_id_chunks.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_next_posts_shadow := item_2.val
		var_and = rt.new_string((if !(!rt.is_true(var_next_posts_shadow)) { 'AND ID IN (' + (rt.call_function('implode', [rt.new_string(', '), var_next_posts_shadow.clone()])).str() + ')' } else { '' }).str())
		var_results = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT post_author FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_status != \'auto-draft\' ')), var_and)])
		mut iter_3 := rt.cast_array(var_results).iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_result_shadow := item_3.val
			var_authors.array_push(rt.call_function('get_userdata', [rt.get_property(var_result_shadow, 'post_author')]))
		}
	}
	var_authors = rt.call_function('array_filter', [var_authors.clone()])
	var_authors = rt.call_function('array_unique', [var_authors.clone(), rt.get_constant('SORT_REGULAR')])
	mut iter_4 := var_authors.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_author_shadow := item_4.val
		print('\t<wp:author>')
		print('<wp:author_id>' + rt.new_int((rt.get_property(var_author_shadow, 'ID')).to_i64()).str() + '</wp:author_id>')
		print('<wp:author_login>' + (wxr_cdata(rt.get_property(var_author_shadow, 'user_login'))).str() + '</wp:author_login>')
		print('<wp:author_email>' + (wxr_cdata(rt.get_property(var_author_shadow, 'user_email'))).str() + '</wp:author_email>')
		print('<wp:author_display_name>' + (wxr_cdata(rt.get_property(var_author_shadow, 'display_name'))).str() + '</wp:author_display_name>')
		print('<wp:author_first_name>' + (wxr_cdata(rt.get_property(var_author_shadow, 'first_name'))).str() + '</wp:author_first_name>')
		print('<wp:author_last_name>' + (wxr_cdata(rt.get_property(var_author_shadow, 'last_name'))).str() + '</wp:author_last_name>')
		print('</wp:author>\n')
	}
}

fn wxr_nav_menu_terms() {
	mut var_nav_menus := rt.new_null()
	mut var_menu := rt.new_null()
	var_nav_menus = rt.call_function('wp_get_nav_menus', []rt.PhpVal{})
	if !rt.is_true(var_nav_menus) || !(var_nav_menus.clone().is_array()) {
		return
	}
	mut iter_5 := var_nav_menus.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_menu_shadow := item_5.val
		print('\t<wp:term>')
		print('<wp:term_id>' + rt.new_int((rt.get_property(var_menu_shadow, 'term_id')).to_i64()).str() + '</wp:term_id>')
		print('<wp:term_taxonomy>nav_menu</wp:term_taxonomy>')
		print('<wp:term_slug>' + (wxr_cdata(rt.get_property(var_menu_shadow, 'slug'))).str() + '</wp:term_slug>')
		wxr_term_name(var_menu_shadow.clone())
		print('</wp:term>\n')
	}
}

fn wxr_post_taxonomy() {
	mut var_post := rt.new_null()
	mut var_taxonomies := rt.new_null()
	mut var_terms := rt.new_null()
	mut var_term := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	var_taxonomies = rt.call_function('get_object_taxonomies', [rt.get_property(var_post, 'post_type')])
	if !rt.is_true(var_taxonomies) {
		return
	}
	var_terms = rt.call_function('wp_get_object_terms', [rt.get_property(var_post, 'ID'), var_taxonomies.clone()])
	mut iter_6 := rt.cast_array(var_terms).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_term_shadow := item_6.val
		print(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\t\t<category domain="'), rt.get_property(var_term_shadow, 'taxonomy')), rt.new_string('" nicename="')), rt.get_property(var_term_shadow, 'slug')), rt.new_string('">')) + (wxr_cdata(rt.get_property(var_term_shadow, 'name'))).str() + '</category>\n')
	}
}

fn wxr_filter_postmeta(var_return_me_arg rt.PhpVal, var_meta_key rt.PhpVal) bool {
	mut var_return_me := var_return_me_arg
	if rt.is_true(rt.identical(rt.new_string('_edit_lock'), var_meta_key)) {
	var_return_me = true
	}
	return var_return_me
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_filter', [rt.new_string('wxr_export_skip_postmeta'), rt.new_string('wxr_filter_postmeta'), rt.new_int(10), rt.new_int(2)])
	print('<?xml version="1.0" encoding="' + (rt.call_function('get_bloginfo', [rt.new_string('charset')])).str() + '" ?>\n')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('the_generator', [rt.new_string('export')])
	// unsupported statement: Stmt_InlineHTML
	print(global_const_wxr_version)
	// unsupported statement: Stmt_InlineHTML
	print(global_const_wxr_version)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('name')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('url')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('description')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('gmdate', [rt.new_string('D, d M Y H:i:s +0000')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('language')])
	// unsupported statement: Stmt_InlineHTML
	print(global_const_wxr_version)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(wxr_site_url())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo_rss', [rt.new_string('url')])
	// unsupported statement: Stmt_InlineHTML
	wxr_authors_list(var_post_ids.clone())
	// unsupported statement: Stmt_InlineHTML
	mut iter_7 := var_cats.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_c_shadow := item_7.val
		// unsupported statement: Stmt_InlineHTML
		print(rt.new_int((rt.get_property(var_c_shadow, 'term_id')).to_i64()).str())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(wxr_cdata(rt.get_property(var_c_shadow, 'slug')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(wxr_cdata(if rt.is_true(rt.get_property(var_c_shadow, 'parent')) { rt.get_property(var_cats.array_get(rt.get_property(var_c_shadow, 'parent')), 'slug') } else { rt.new_string('') }))
		// unsupported statement: Stmt_InlineHTML
		wxr_cat_name(var_c_shadow.clone())
		wxr_category_description(var_c_shadow.clone())
		wxr_term_meta(var_c_shadow.clone())
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_8 := var_tags.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_t_shadow := item_8.val
		// unsupported statement: Stmt_InlineHTML
		print(rt.new_int((rt.get_property(var_t_shadow, 'term_id')).to_i64()).str())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(wxr_cdata(rt.get_property(var_t_shadow, 'slug')))
		// unsupported statement: Stmt_InlineHTML
		wxr_tag_name(var_t_shadow.clone())
		wxr_tag_description(var_t_shadow.clone())
		wxr_term_meta(var_t_shadow.clone())
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	mut iter_9 := var_terms.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_t_shadow := item_9.val
		// unsupported statement: Stmt_InlineHTML
		print(rt.new_int((rt.get_property(var_t_shadow, 'term_id')).to_i64()).str())
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(wxr_cdata(rt.get_property(var_t_shadow, 'taxonomy')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(wxr_cdata(rt.get_property(var_t_shadow, 'slug')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(wxr_cdata(if rt.is_true(rt.get_property(var_t_shadow, 'parent')) { rt.get_property(var_terms.array_get(rt.get_property(var_t_shadow, 'parent')), 'slug') } else { rt.new_string('') }))
		// unsupported statement: Stmt_InlineHTML
		wxr_term_name(var_t_shadow.clone())
		wxr_term_description(var_t_shadow.clone())
		wxr_term_meta(var_t_shadow.clone())
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.identical(rt.new_string('all'), var_args.array_get(rt.new_string('content')))) {
		wxr_nav_menu_terms()
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('rss2_head')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_post_ids) {
		rt.set_property(var_wp_query, 'in_the_loop', rt.new_bool(true))
		var_next_posts = rt.call_function('array_splice', [var_post_ids.clone(), rt.new_int(0), rt.new_int(20)])
		for rt.is_true(var_next_posts) {
			var_where = rt.new_string('WHERE ID IN (' + (rt.call_function('implode', [rt.new_string(','), var_next_posts.clone()])).str() + ')')
			var_posts = rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' ')), var_where)])
			mut iter_10 := var_posts.iterator()
			for {
				item_10 := iter_10.next() or { break }
				mut var_post_shadow := item_10.val
				rt.call_function('setup_postdata', [var_post_shadow.clone()])
				var_title = wxr_cdata(rt.call_function('apply_filters', [rt.new_string('the_title_export'), rt.get_property(var_post_shadow, 'post_title')]))
				var_content = wxr_cdata(rt.call_function('apply_filters', [rt.new_string('the_content_export'), rt.get_property(var_post_shadow, 'post_content')]))
				var_excerpt = wxr_cdata(rt.call_function('apply_filters', [rt.new_string('the_excerpt_export'), rt.get_property(var_post_shadow, 'post_excerpt')]))
				var_is_sticky = if rt.is_true(rt.call_function('is_sticky', [rt.get_property(var_post_shadow, 'ID')])) { 1 } else { 0 }
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(var_title)
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('the_permalink_rss', []rt.PhpVal{})
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('mysql2date', [rt.new_string('D, d M Y H:i:s +0000'), rt.call_function('get_post_time', [rt.new_string('Y-m-d H:i:s'), rt.new_bool(true)]), rt.new_bool(false)]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(wxr_cdata(rt.call_function('get_the_author_meta', [rt.new_string('login')])))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('the_guid', []rt.PhpVal{})
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(var_content)
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(var_excerpt)
				// unsupported statement: Stmt_InlineHTML
				print(rt.new_int((rt.get_property(var_post_shadow, 'ID')).to_i64()).str())
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(wxr_cdata(rt.get_property(var_post_shadow, 'post_date')))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(wxr_cdata(rt.get_property(var_post_shadow, 'post_date_gmt')))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(wxr_cdata(rt.get_property(var_post_shadow, 'post_modified')))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(wxr_cdata(rt.get_property(var_post_shadow, 'post_modified_gmt')))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(wxr_cdata(rt.get_property(var_post_shadow, 'comment_status')))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(wxr_cdata(rt.get_property(var_post_shadow, 'ping_status')))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(wxr_cdata(rt.get_property(var_post_shadow, 'post_name')))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(wxr_cdata(rt.get_property(var_post_shadow, 'post_status')))
				// unsupported statement: Stmt_InlineHTML
				print(rt.new_int((rt.get_property(var_post_shadow, 'post_parent')).to_i64()).str())
				// unsupported statement: Stmt_InlineHTML
				print(rt.new_int((rt.get_property(var_post_shadow, 'menu_order')).to_i64()).str())
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(wxr_cdata(rt.get_property(var_post_shadow, 'post_type')))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(wxr_cdata(rt.get_property(var_post_shadow, 'post_password')))
				// unsupported statement: Stmt_InlineHTML
				print(var_is_sticky.str())
				// unsupported statement: Stmt_InlineHTML
				if rt.is_true(rt.identical(rt.new_string('attachment'), rt.get_property(var_post_shadow, 'post_type'))) {
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(wxr_cdata(rt.call_function('wp_get_attachment_url', [rt.get_property(var_post_shadow, 'ID')])))
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
				wxr_post_taxonomy()
				// unsupported statement: Stmt_InlineHTML
				var_postmeta = rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' WHERE post_id = %d')), rt.get_property(var_post_shadow, 'ID')])])
				mut iter_11 := var_postmeta.iterator()
				for {
					item_11 := iter_11.next() or { break }
					mut var_meta_shadow := item_11.val
					if rt.is_true(rt.call_function('apply_filters', [rt.new_string('wxr_export_skip_postmeta'), rt.new_bool(false), rt.get_property(var_meta_shadow, 'meta_key'), var_meta_shadow.clone()])) {
						continue
					}
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(wxr_cdata(rt.get_property(var_meta_shadow, 'meta_key')))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(wxr_cdata(rt.get_property(var_meta_shadow, 'meta_value')))
					// unsupported statement: Stmt_InlineHTML
				}
				var__comments = rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'comments')), rt.new_string(' WHERE comment_post_ID = %d AND comment_approved <> \'spam\'')), rt.get_property(var_post_shadow, 'ID')])])
				closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_comment := if args.len > 0 { args[0].clone() } else { rt.new_null() }
					return (rt.new_bool(rt.instance_of(var_comment, 'WP_Comment'))).to_bool()
					}
				var_comments = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('get_comment'), var__comments.clone()]), rt.new_closure(closure_1_fn)])
				mut iter_12 := var_comments.iterator()
				for {
					item_12 := iter_12.next() or { break }
					mut var_c_shadow := item_12.val
					// unsupported statement: Stmt_InlineHTML
					print(rt.new_int((rt.get_property(var_c_shadow, 'comment_ID')).to_i64()).str())
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(wxr_cdata(rt.get_property(var_c_shadow, 'comment_author')))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(wxr_cdata(rt.get_property(var_c_shadow, 'comment_author_email')))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('sanitize_url', [rt.get_property(var_c_shadow, 'comment_author_url')]))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(wxr_cdata(rt.get_property(var_c_shadow, 'comment_author_IP')))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(wxr_cdata(rt.get_property(var_c_shadow, 'comment_date')))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(wxr_cdata(rt.get_property(var_c_shadow, 'comment_date_gmt')))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(wxr_cdata(rt.get_property(var_c_shadow, 'comment_content')))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(wxr_cdata(rt.get_property(var_c_shadow, 'comment_approved')))
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(wxr_cdata(rt.get_property(var_c_shadow, 'comment_type')))
					// unsupported statement: Stmt_InlineHTML
					print(rt.new_int((rt.get_property(var_c_shadow, 'comment_parent')).to_i64()).str())
					// unsupported statement: Stmt_InlineHTML
					print(rt.new_int((rt.get_property(var_c_shadow, 'user_id')).to_i64()).str())
					// unsupported statement: Stmt_InlineHTML
					var_c_meta = rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'commentmeta')), rt.new_string(' WHERE comment_id = %d')), rt.get_property(var_c_shadow, 'comment_ID')])])
					mut iter_13 := var_c_meta.iterator()
					for {
						item_13 := iter_13.next() or { break }
						mut var_meta_shadow := item_13.val
						if rt.is_true(rt.call_function('apply_filters', [rt.new_string('wxr_export_skip_commentmeta'), rt.new_bool(false), rt.get_property(var_meta_shadow, 'meta_key'), var_meta_shadow.clone()])) {
							continue
						}
						// unsupported statement: Stmt_InlineHTML
						rt.echo_val(wxr_cdata(rt.get_property(var_meta_shadow, 'meta_key')))
						// unsupported statement: Stmt_InlineHTML
						rt.echo_val(wxr_cdata(rt.get_property(var_meta_shadow, 'meta_value')))
						// unsupported statement: Stmt_InlineHTML
					}
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			}
		}
	}
	// unsupported statement: Stmt_InlineHTML
	return false
}

}
