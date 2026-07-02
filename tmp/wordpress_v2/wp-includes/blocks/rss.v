import rt

fn render_block_core_rss(var_attributes rt.PhpVal) string {
	mut var_rss := rt.new_null()
	mut var_rss_items := rt.new_null()
	mut var_list_items := ''
	mut var_open_in_new_tab := false
	mut var_rel := ''
	mut var_link_attributes := ''
	mut var_item := rt.new_null()
	mut var_title := rt.new_null()
	mut var_link := rt.new_null()
	mut var_date_markup := rt.new_null()
	mut var_timestamp := rt.new_null()
	mut var_gmt_offset := rt.new_null()
	mut var_author := rt.new_null()
	mut var_excerpt := rt.new_null()
	mut var_description := rt.new_null()
	mut var_classnames := []rt.PhpVal{}
	mut var_wrapper_attributes := rt.new_null()
	if rt.is_true(rt.call_function('in_array', [
		rt.call_function('untrailingslashit', [var_attributes.array_get(rt.new_string('feedURL'))]),
		rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('site_url', []rt.PhpVal{}) },
			rt.ArrayItem{ key: none, val: rt.call_function('home_url', []rt.PhpVal{}) }]),
		rt.new_bool(true),
	]))
	{
		return '<div class="components-placeholder"><div class="notice notice-error">' +
			(rt.call_function('__', [rt.new_string('Adding an RSS feed to this site’s homepage is not supported, as it could lead to a loop that slows down your site. Try using another block, like the <strong>Latest Posts</strong> block, to list posts from the site.')])).str() +
			'</div></div>'
	}
	var_rss = rt.call_function('fetch_feed', [var_attributes.array_get(rt.new_string('feedURL'))])
	if rt.is_true(rt.call_function('is_wp_error', [var_rss.clone()])) {
		return '<div class="components-placeholder"><div class="notice notice-error"><strong>' +
			(rt.call_function('__', [rt.new_string('RSS Error:')])).str() + '</strong> ' +
			(rt.call_function('esc_html', [rt.call_method(var_rss, 'get_error_message', []rt.PhpVal{})])).str() +
			'</div></div>'
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_rss, 'get_item_quantity',
		[]rt.PhpVal{})))))
	{
		return '<div class="components-placeholder"><div class="notice notice-error">' +
			(rt.call_function('__', [rt.new_string('An error has occurred, which probably means the feed is down. Try again later.')])).str() +
			'</div></div>'
	}
	var_rss_items = rt.call_method(var_rss, 'get_items', [rt.new_int(0),
		var_attributes.array_get(rt.new_string('itemsToShow'))])
	var_list_items = ''
	var_open_in_new_tab = !(!rt.is_true(var_attributes.array_get(rt.new_string('openInNewTab'))))
	var_rel = if !(!rt.is_true(var_attributes.array_get(rt.new_string('rel')))) {
		var_attributes.array_get(rt.new_string('rel')).to_string().trim_space()
	} else {
		''
	}
	var_link_attributes = ''
	if var_open_in_new_tab {
		var_link_attributes = var_link_attributes + ' target="_blank"'
	}
	if rt.is_true(rt.new_bool('' != var_rel)) {
		var_link_attributes = var_link_attributes + ' rel="' +
			(rt.call_function('esc_attr', [rt.new_string(var_rel.str()).clone()])).str() + '"'
	}
	mut iter_1 := var_rss_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_item_shadow := item_1.val
		var_title = rt.call_function('esc_html', [
			rt.new_string(rt.call_function('strip_tags', [
				rt.call_function('html_entity_decode', [
					rt.call_method(var_item_shadow, 'get_title', []rt.PhpVal{}),
				]),
			]).to_string().trim_space()),
		])
		if !rt.is_true(var_title) {
			var_title = rt.call_function('__', [rt.new_string('(no title)')])
		}
		var_link = rt.call_method(var_item_shadow, 'get_link', []rt.PhpVal{})
		var_link = rt.call_function('esc_url', [var_link.clone()])
		if rt.is_true(var_link) {
			var_title =
				rt.new_string("<a href='${var_link.to_string()}'${var_link_attributes}>${var_title.to_string()}</a>")
		}
		var_title =
			rt.new_string("<div class='wp-block-rss__item-title'>${var_title.to_string()}</div>")
		var_date_markup = rt.new_string('')
		if !(!rt.is_true(var_attributes.array_get(rt.new_string('displayDate')))) {
			var_timestamp = rt.call_method(var_item_shadow, 'get_date', [
				rt.new_string('U'),
			])
			if rt.is_true(var_timestamp) {
				var_gmt_offset = rt.call_function('get_option', [
					rt.new_string('gmt_offset'),
				])
				var_timestamp = rt.add(var_timestamp,
					i64(rt.new_float(var_gmt_offset.to_f64()) * rt.get_constant('HOUR_IN_SECONDS')))
				var_date_markup = rt.call_function('sprintf', [
					rt.new_string('<time datetime="%1$s" class="wp-block-rss__item-publish-date">%2$s</time> '),
					rt.call_function('esc_attr', [
						rt.call_function('date_i18n', [rt.new_string('c'),
							var_timestamp.clone()]),
					]),
					rt.call_function('esc_html', [
						rt.call_function('date_i18n', [
							rt.call_function('get_option', [rt.new_string('date_format')]),
							var_timestamp.clone(),
						]),
					]),
				])
			}
		}
		var_author = rt.new_string('')
		if rt.is_true(var_attributes.array_get(rt.new_string('displayAuthor'))) {
			var_author = rt.call_method(var_item_shadow, 'get_author', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(var_author.clone().is_object())) {
				var_author = rt.call_method(var_author, 'get_name', []rt.PhpVal{})
				if !(!rt.is_true(var_author)) {
					var_author = rt.new_string('<span class="wp-block-rss__item-author">' +
						(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('by %s')]), rt.call_function('esc_html', [rt.call_function('strip_tags', [var_author.clone()])])])).str() +
						'</span>')
				}
			}
		}
		var_excerpt = rt.new_string('')
		var_description = rt.call_method(var_item_shadow, 'get_description', []rt.PhpVal{})
		if rt.is_true(var_attributes.array_get(rt.new_string('displayExcerpt')))
			&& !(!rt.is_true(var_description)) {
			var_excerpt = rt.call_function('html_entity_decode', [
				var_description.clone(), rt.get_constant('ENT_QUOTES'),
				rt.call_function('get_option', [rt.new_string('blog_charset')])])
			var_excerpt = rt.call_function('esc_attr', [
				rt.call_function('wp_trim_words', [var_excerpt.clone(),
					var_attributes.array_get(rt.new_string('excerptLength')),
					rt.new_string(' [&hellip;]')]),
			])
			if rt.is_true(rt.identical(rt.new_string('[...]'), rt.call_function('substr', [
				var_excerpt.clone(),
				rt.new_int(-5),
			])))
			{
				var_excerpt = rt.new_string(
					(rt.call_function('substr', [var_excerpt.clone(), rt.new_int(0), rt.new_int(-5)])).str() +
					'[&hellip;]')
			}
			var_excerpt = rt.new_string('<div class="wp-block-rss__item-excerpt">' +
				(rt.call_function('esc_html', [var_excerpt.clone()])).str() + '</div>')
		}
		var_list_items = var_list_items +
			"<li class='wp-block-rss__item'>${var_title.to_string()}${var_date_markup.to_string()}${var_author.to_string()}${var_excerpt.to_string()}</li>"
	}
	var_classnames = []rt.PhpVal{}
	if var_attributes.array_isset(rt.new_string('blockLayout'))
		&& rt.is_true(rt.identical(rt.new_string('grid'), var_attributes.array_get(rt.new_string('blockLayout')))) {
		var_classnames << 'is-grid'
	}
	if var_attributes.array_isset(rt.new_string('columns'))
		&& rt.is_true(rt.identical(rt.new_string('grid'), var_attributes.array_get(rt.new_string('blockLayout')))) {
		var_classnames << 'columns-' + (var_attributes.array_get(rt.new_string('columns'))).str()
	}
	if rt.is_true(var_attributes.array_get(rt.new_string('displayDate'))) {
		var_classnames << 'has-dates'
	}
	if rt.is_true(var_attributes.array_get(rt.new_string('displayAuthor'))) {
		var_classnames << 'has-authors'
	}
	if rt.is_true(var_attributes.array_get(rt.new_string('displayExcerpt'))) {
		var_classnames << 'has-excerpts'
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				rt.create_array_from_list(var_classnames),
			]) },
		]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<ul %s>%s</ul>'),
		var_wrapper_attributes.clone(), rt.new_string(var_list_items.str()).clone()])).str()
}

fn register_block_core_rss() {
	rt.call_function('register_block_type_from_metadata', [rt.new_string(@DIR + '/rss'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_rss' },
		])])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('register_block_core_rss')])
}
