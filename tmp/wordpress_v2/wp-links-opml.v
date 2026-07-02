import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/wp-load.php', '4')
	rt.call_function('header', [
		rt.new_string('Content-Type: text/xml; charset=' +
			(rt.call_function('get_option', [rt.new_string('blog_charset')])).str()),
		rt.new_bool(true),
	])
	mut var_link_cat := rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('link_cat')))) {
		var_link_cat = rt.get_superglobal('_GET').array_get(rt.new_string('link_cat'))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_link_cat.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'all' },
				rt.ArrayItem{ key: none, val: '0' }]),
			rt.new_bool(true)])))))
		{
			var_link_cat = rt.call_function('absint', [
				rt.call_function('urldecode', [var_link_cat.clone()]),
			])
		}
	}
	print('<?xml version="1.0"?' + '>\n')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [rt.call_function('__', [rt.new_string('Links for %s')]),
		rt.call_function('esc_attr', [
			rt.call_function('get_bloginfo', [rt.new_string('name'),
				rt.new_string('display')]),
		])])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('gmdate', [rt.new_string('D, d M Y H:i:s')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('opml_head')])
	// unsupported statement: Stmt_InlineHTML
	if !rt.is_true(var_link_cat) {
		mut var_cats := rt.call_function('get_categories', [
			rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'link_category' },
				rt.ArrayItem{ key: 'hierarchical', val: 0 }]),
		])
	} else {
		var_cats = rt.call_function('get_categories', [
			rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'link_category' },
				rt.ArrayItem{ key: 'hierarchical', val: 0 }, rt.ArrayItem{
					key: 'include'
					val: var_link_cat
				}]),
		])
	}
	mut iter_1 := rt.cast_array(var_cats).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_cat := item_1.val
		mut var_catname := rt.call_function('apply_filters', [
			rt.new_string('link_category'),
			rt.get_property(var_cat, 'name'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [var_catname.clone()]))
		// unsupported statement: Stmt_InlineHTML
		mut var_bookmarks := rt.call_function('get_bookmarks', [
			rt.create_array([
				rt.ArrayItem{ key: 'category', val: rt.get_property(var_cat, 'term_id') },
			]),
		])
		mut iter_2 := rt.cast_array(var_bookmarks).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_bookmark := item_2.val
			mut var_title := rt.call_function('apply_filters', [
				rt.new_string('link_title'),
				rt.get_property(var_bookmark, 'link_name'),
			])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_title.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.get_property(var_bookmark, 'link_rss'),
			]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_url', [
				rt.get_property(var_bookmark, 'link_url'),
			]))
			// unsupported statement: Stmt_InlineHTML
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('0000-00-00 00:00:00'), rt.get_property(var_bookmark,
				'link_updated')))))
			{
				rt.echo_val(rt.get_property(var_bookmark, 'link_updated'))
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
