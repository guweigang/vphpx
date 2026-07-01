import rt

fn render_block_core_rss(var_attributes rt.PhpVal) string {
	if rt.is_true(rt.call_function('in_array', [rt.call_function('untrailingslashit', [var_attributes.array_get('feedURL')]), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('site_url', []rt.PhpVal{}) }, rt.ArrayItem{ key: none, val: rt.call_function('home_url', []rt.PhpVal{}) }]), rt.new_bool(true)])) {
		return '<div class="components-placeholder"><div class="notice notice-error">' + (rt.call_function('__', [rt.new_string('Adding an RSS feed to this site’s homepage is not supported, as it could lead to a loop that slows down your site. Try using another block, like the <strong>Latest Posts</strong> block, to list posts from the site.')])).str() + '</div></div>'
	}
	mut var_rss := rt.call_function('fetch_feed', [var_attributes.array_get('feedURL')])
	if rt.is_true(rt.call_function('is_wp_error', [var_rss.dup()])) {
		return '<div class="components-placeholder"><div class="notice notice-error"><strong>' + (rt.call_function('__', [rt.new_string('RSS Error:')])).str() + '</strong> ' + (rt.call_function('esc_html', [rt.call_method(var_rss, 'get_error_message', []rt.PhpVal{})])).str() + '</div></div>'
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_rss, 'get_item_quantity', []rt.PhpVal{}))))) {
		return '<div class="components-placeholder"><div class="notice notice-error">' + (rt.call_function('__', [rt.new_string('An error has occurred, which probably means the feed is down. Try again later.')])).str() + '</div></div>'
	}
	mut var_rss_items := rt.call_method(var_rss, 'get_items', [rt.new_int(0), var_attributes.array_get('itemsToShow')])
	mut var_list_items := ''
	mut var_open_in_new_tab := !(!rt.is_true(var_attributes.array_get('openInNewTab')))
	mut var_rel := if !(!rt.is_true(var_attributes.array_get('rel'))) { var_attributes.array_get('rel').to_string().trim_space() } else { '' }
	mut var_link_attributes := ''
	if var_open_in_new_tab {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	{
		mut iter_1 := var_rss_items.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_title := rt.call_function('esc_html', [rt.new_string(rt.call_function('strip_tags', [rt.call_function('html_entity_decode', [rt.call_method(var_item, 'get_title', []rt.PhpVal{})])]).to_string().trim_space())])
			if !rt.is_true(var_title) {
				var_title = rt.call_function('__', [rt.new_string('(no title)')])
			}
			mut var_link := rt.call_method(var_item, 'get_link', []rt.PhpVal{})
			var_link = rt.call_function('esc_url', [var_link.dup()])
			if rt.is_true(var_link) {
				var_title = rt.new_string(rt.new_string("<a href='${var_link.to_string()}'${var_link_attributes}>${var_title.to_string()}</a>"))
			}
			var_title = rt.new_string(rt.new_string("<div class='wp-block-rss__item-title'>${var_title.to_string()}</div>"))
			mut var_date_markup := rt.new_string(rt.new_string(''))
			if !(!rt.is_true(var_attributes.array_get('displayDate'))) {
				mut var_timestamp := rt.call_method(var_item, 'get_date', [rt.new_string('U')])
				if rt.is_true(var_timestamp) {
					mut var_gmt_offset := rt.call_function('get_option', [rt.new_string('gmt_offset')])
					// unsupported expression: Expr_AssignOp_Plus
					var_date_markup = rt.call_function('sprintf', [rt.new_string('<time datetime="%1$s" class="wp-block-rss__item-publish-date">%2$s</time> '), rt.call_function('esc_attr', [rt.call_function('date_i18n', [rt.new_string('c'), var_timestamp.dup()])]), rt.call_function('esc_html', [rt.call_function('date_i18n', [rt.call_function('get_option', [rt.new_string('date_format')]), var_timestamp.dup()])])])
				}
			}
			mut var_author := rt.new_string(rt.new_string(''))
			if rt.is_true(var_attributes.array_get('displayAuthor')) {
				var_author = rt.call_method(var_item, 'get_author', []rt.PhpVal{})
				if rt.is_true(rt.new_bool(var_author.dup().is_object())) {
					var_author = rt.call_method(var_author, 'get_name', []rt.PhpVal{})
					if !(!rt.is_true(var_author)) {
						var_author = rt.new_string('<span class="wp-block-rss__item-author">' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('by %s')]), rt.call_function('esc_html', [rt.call_function('strip_tags', [var_author.dup()])])])).str() + '</span>')
					}
				}
			}
			mut var_excerpt := rt.new_string(rt.new_string(''))
			mut var_description := rt.call_method(var_item, 'get_description', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(rt.is_true(var_attributes.array_get('displayExcerpt')) && !(!rt.is_true(var_description)))) {
				var_excerpt = rt.call_function('html_entity_decode', [var_description.dup(), rt.get_constant('ENT_QUOTES'), rt.call_function('get_option', [rt.new_string('blog_charset')])])
				var_excerpt = rt.call_function('esc_attr', [rt.call_function('wp_trim_words', [var_excerpt.dup(), var_attributes.array_get('excerptLength'), rt.new_string(' [&hellip;]')])])
				if rt.is_true(rt.identical(rt.new_string('[...]'), rt.call_function('substr', [var_excerpt.dup(), // unsupported expression: Expr_UnaryMinus]))) {
					var_excerpt = rt.new_string((rt.call_function('substr', [var_excerpt.dup(), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])).str() + '[&hellip;]')
				}
				var_excerpt = rt.new_string('<div class="wp-block-rss__item-excerpt">' + (rt.call_function('esc_html', [var_excerpt.dup()])).str() + '</div>')
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	mut var_classnames := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('blockLayout')) && rt.is_true(rt.identical(rt.new_string('grid'), var_attributes.array_get('blockLayout'))))) {
		var_classnames << 'is-grid'
	}
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('columns')) && rt.is_true(rt.identical(rt.new_string('grid'), var_attributes.array_get('blockLayout'))))) {
		var_classnames << 'columns-' + (var_attributes.array_get('columns')).str()
	}
	if rt.is_true(var_attributes.array_get('displayDate')) {
		var_classnames << 'has-dates'
	}
	if rt.is_true(var_attributes.array_get('displayAuthor')) {
		var_classnames << 'has-authors'
	}
	if rt.is_true(var_attributes.array_get('displayExcerpt')) {
		var_classnames << 'has-excerpts'
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [rt.new_string(' '), var_classnames.dup()]) }])])
	return (rt.call_function('sprintf', [rt.new_string('<ul %s>%s</ul>'), var_wrapper_attributes.dup(), rt.new_string(var_list_items).dup()])).str()
}

fn register_block_core_rss() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/rss', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_rss' }])])
}



pub fn init_wp_includes_blocks_rss_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_rss')])
}
