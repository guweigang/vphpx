module wp_includes

import rt

fn _walk_bookmarks(var_bookmarks rt.PhpVal, args string) string {
	mut var_args := args
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_output := ''
	mut var_bookmark := rt.new_null()
	mut var_the_link := rt.new_null()
	mut var_desc := rt.new_null()
	mut var_name := rt.new_null()
	mut var_title := rt.new_null()
	mut var_alt := rt.new_null()
	mut var_rel := rt.new_null()
	mut var_target := rt.new_null()
	var_defaults = {
		'show_updated':     rt.new_int(0)
		'show_description': rt.new_int(0)
		'show_images':      rt.new_int(1)
		'show_name':        rt.new_int(0)
		'before':           rt.new_string('<li>')
		'after':            rt.new_string('</li>')
		'between':          rt.new_string('\n')
		'show_rating':      rt.new_int(0)
		'link_before':      rt.new_string('')
		'link_after':       rt.new_string('')
	}
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string(args),
		rt.create_array_from_native_map(var_defaults)])
	var_output = ''
	{
		mut iter_1 := rt.cast_array(var_bookmarks).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_bookmark_shadow := item_1.val
			if !(!(rt.get_property(var_bookmark_shadow, 'recently_updated')).is_null()) {
				rt.set_property(var_bookmark_shadow, 'recently_updated', rt.new_bool(false))
			}
			var_output = var_output + (var_parsed_args.array_get('before')).str()
			if rt.is_true(rt.new_bool(rt.is_true(var_parsed_args.array_get('show_updated'))
				&& rt.is_true(rt.get_property(var_bookmark_shadow, 'recently_updated'))))
			{
				var_output = var_output + '<em>'
			}
			var_the_link = rt.new_string('#')
			if !(!rt.is_true(rt.get_property(var_bookmark_shadow, 'link_url'))) {
				var_the_link = rt.call_function('esc_url', [
					rt.get_property(var_bookmark_shadow, 'link_url'),
				])
			}
			var_desc = rt.call_function('esc_attr', [
				rt.call_function('sanitize_bookmark_field', [
					rt.new_string('link_description'),
					rt.get_property(var_bookmark_shadow, 'link_description'),
					rt.get_property(var_bookmark_shadow, 'link_id'),
					rt.new_string('display'),
				]),
			])
			var_name = rt.call_function('esc_attr', [
				rt.call_function('sanitize_bookmark_field', [
					rt.new_string('link_name'), rt.get_property(var_bookmark_shadow, 'link_name'),
					rt.get_property(var_bookmark_shadow, 'link_id'),
					rt.new_string('display')]),
			])
			var_title = var_desc.clone()
			if rt.is_true(var_parsed_args.array_get('show_updated')) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_starts_with', [
					rt.get_property(var_bookmark_shadow, 'link_updated_f'),
					rt.new_string('00'),
				])))))
				{
					var_title = rt.concat(var_title, rt.new_string(' ('))
					var_title = rt.concat(var_title, rt.call_function('sprintf', [
						rt.call_function('__', [rt.new_string('Last updated: %s')]),
						rt.call_function('gmdate', [
							rt.call_function('get_option', [
								rt.new_string('links_updated_date_format'),
							]),
							rt.add(rt.get_property(var_bookmark_shadow, 'link_updated_f'), i64(rt.new_float((rt.call_function('get_option', [
								rt.new_string('gmt_offset'),
							])).to_f64()) * rt.get_constant('HOUR_IN_SECONDS'))),
						]),
					]))
					var_title = rt.concat(var_title, rt.new_string(')'))
				}
			}
			var_alt = rt.new_string(' alt="' + var_name.str() +
				if rt.is_true(var_parsed_args.array_get('show_description')) { ' ' +
				var_title.str() } else { '' } + '"')
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_title)))) {
				var_title = rt.new_string(' title="' + var_title.str() + '"')
			}
			var_rel = rt.get_property(var_bookmark_shadow, 'link_rel')
			var_target = rt.get_property(var_bookmark_shadow, 'link_target')
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_target)))) {
				var_target = rt.new_string(' target="' + var_target.str() + '"')
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_rel)))) {
				var_rel = rt.new_string(' rel="' +
					(rt.call_function('esc_attr', [var_rel.clone()])).str() + '"')
			}
			var_output = var_output + '<a href="' + var_the_link.str() + '"' + var_rel.str() +
				var_title.str() + var_target.str() + '>'
			var_output = var_output + (var_parsed_args.array_get('link_before')).str()
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_bookmark_shadow, 'link_image')))))
				&& rt.is_true(var_parsed_args.array_get('show_images'))))
			{
				if rt.is_true(rt.call_function('str_starts_with', [
					rt.get_property(var_bookmark_shadow, 'link_image'),
					rt.new_string('http'),
				]))
				{
					var_output = var_output + '<img src="' +
						(rt.get_property(var_bookmark_shadow, 'link_image')).str() + '"' +
						var_alt.str() + var_title.str() + ' />'
				} else {
					var_output = var_output + '<img src="' +
						(rt.call_function('get_option', [rt.new_string('siteurl')])).str() +
						(rt.get_property(var_bookmark_shadow, 'link_image')).str() + '"' +
						var_alt.str() + var_title.str() + ' />'
				}
				if rt.is_true(var_parsed_args.array_get('show_name')) {
					var_output = var_output + ' ${var_name.to_string()}'
				}
			} else {
				var_output = var_output + var_name.str()
			}
			var_output = var_output + (var_parsed_args.array_get('link_after')).str()
			var_output = var_output + '</a>'
			if rt.is_true(rt.new_bool(rt.is_true(var_parsed_args.array_get('show_updated'))
				&& rt.is_true(rt.get_property(var_bookmark_shadow, 'recently_updated'))))
			{
				var_output = var_output + '</em>'
			}
			if rt.is_true(rt.new_bool(rt.is_true(var_parsed_args.array_get('show_description'))
				&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_desc))))))
			{
				var_output = var_output +
					(var_parsed_args.array_get('between')).str() + var_desc.str()
			}
			if rt.is_true(var_parsed_args.array_get('show_rating')) {
				var_output = var_output +(var_parsed_args.array_get('between')).str() +(rt.call_function('sanitize_bookmark_field', [rt.new_string('link_rating'), rt.get_property(var_bookmark_shadow, 'link_rating'), rt.get_property(var_bookmark_shadow, 'link_id'), rt.new_string('display')])).str()
			}
			var_output = var_output + (var_parsed_args.array_get('after')).str() + '\n'
		}
	}
	return var_output
}

fn wp_list_bookmarks(args string) rt.PhpVal {
	mut var_args := args
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_output := ''
	mut var_cats := rt.new_null()
	mut var_cat := rt.new_null()
	mut var_params := rt.new_null()
	mut var_bookmarks := rt.new_null()
	mut var_catname := rt.new_null()
	mut var_html := rt.new_null()
	var_defaults = {
		'orderby':          rt.new_string('name')
		'order':            rt.new_string('ASC')
		'limit':            -1
		'category':         rt.new_string('')
		'exclude_category': rt.new_string('')
		'category_name':    rt.new_string('')
		'hide_invisible':   rt.new_int(1)
		'show_updated':     rt.new_int(0)
		'echo':             rt.new_int(1)
		'categorize':       rt.new_int(1)
		'title_li':         rt.call_function('__', [rt.new_string('Bookmarks')])
		'title_before':     rt.new_string('<h2>')
		'title_after':      rt.new_string('</h2>')
		'category_orderby': rt.new_string('name')
		'category_order':   rt.new_string('ASC')
		'class':            rt.new_string('linkcat')
		'category_before':  rt.new_string('<li id="%id" class="%class">')
		'category_after':   rt.new_string('</li>')
	}
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string(args),
		rt.create_array_from_native_map(var_defaults)])
	var_output = ''
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_parsed_args.array_get('class').is_array()))))) {
		var_parsed_args.array_set('class', rt.call_function('explode', [
			rt.new_string(' '),
			var_parsed_args.array_get('class'),
		]))
	}
	var_parsed_args.array_set('class', rt.call_function('array_map', [
		rt.new_string('sanitize_html_class'),
		var_parsed_args.array_get('class'),
	]))
	var_parsed_args.array_set('class', rt.call_function('implode', [
		rt.new_string(' '), var_parsed_args.array_get('class')]).to_string().trim_space())
	if rt.is_true(var_parsed_args.array_get('categorize')) {
		var_cats = rt.call_function('get_terms', [
			rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'link_category' },
				rt.ArrayItem{ key: 'name__like', val: var_parsed_args.array_get('category_name') },
				rt.ArrayItem{ key: 'include', val: var_parsed_args.array_get('category') },
				rt.ArrayItem{ key: 'exclude', val: var_parsed_args.array_get('exclude_category') },
				rt.ArrayItem{ key: 'orderby', val: var_parsed_args.array_get('category_orderby') },
				rt.ArrayItem{ key: 'order', val: var_parsed_args.array_get('category_order') },
				rt.ArrayItem{ key: 'hierarchical', val: 0 }]),
		])
		if !rt.is_true(var_cats) {
			var_parsed_args.array_set('categorize', false)
		}
	}
	if rt.is_true(var_parsed_args.array_get('categorize')) {
		{
			mut iter_1 := rt.cast_array(var_cats).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_cat_shadow := item_1.val
				var_params = rt.call_function('array_merge', [
					var_parsed_args.clone(),
					rt.create_array([
						rt.ArrayItem{ key: 'category', val: rt.get_property(var_cat_shadow,
							'term_id') },
					])])
				var_bookmarks = rt.call_function('get_bookmarks', [
					var_params.clone()])
				if !rt.is_true(var_bookmarks) {
					continue
				}
				var_output = var_output +(rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{
					key: none
					val: '%id'
				}, rt.ArrayItem{ key: none, val: '%class' }]), rt.create_array([rt.ArrayItem{
					key: none
					val: rt.concat(rt.new_string('linkcat-'), rt.get_property(var_cat_shadow, 'term_id'))
				}, rt.ArrayItem{ key: none, val: var_parsed_args.array_get('class') }]), var_parsed_args.array_get('category_before')])).str()
				var_catname = rt.call_function('apply_filters', [
					rt.new_string('link_category'),
					rt.get_property(var_cat_shadow, 'name'),
				])
				var_output = var_output + (var_parsed_args.array_get('title_before')).str()
				var_output = var_output + var_catname.str()
				var_output = var_output + (var_parsed_args.array_get('title_after')).str()
				var_output = var_output + "\n\t<ul class='xoxo blogroll'>\n"
				var_output = var_output +
					_walk_bookmarks(var_bookmarks.clone(), var_parsed_args.clone())
				var_output = var_output + '\n\t</ul>\n'
				var_output = var_output + (var_parsed_args.array_get('category_after')).str() + '\n'
			}
		}
	} else {
		var_bookmarks = rt.call_function('get_bookmarks', [var_parsed_args.clone()])
		if !(!rt.is_true(var_bookmarks)) {
			if !(!rt.is_true(var_parsed_args.array_get('title_li'))) {
				var_output = var_output +
					(rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{
					key: none
					val: '%id'
				}, rt.ArrayItem{ key: none, val: '%class' }]), rt.create_array([rt.ArrayItem{
					key: none
					val: 'linkcat-' +(var_parsed_args.array_get('category')).str()
				}, rt.ArrayItem{ key: none, val: var_parsed_args.array_get('class') }]), var_parsed_args.array_get('category_before')])).str()
				var_output = var_output + (var_parsed_args.array_get('title_before')).str()
				var_output = var_output + (var_parsed_args.array_get('title_li')).str()
				var_output = var_output + (var_parsed_args.array_get('title_after')).str()
				var_output = var_output + "\n\t<ul class='xoxo blogroll'>\n"
				var_output = var_output +
					_walk_bookmarks(var_bookmarks.clone(), var_parsed_args.clone())
				var_output = var_output + '\n\t</ul>\n'
				var_output = var_output + (var_parsed_args.array_get('category_after')).str() + '\n'
			} else {
				var_output = var_output +
					_walk_bookmarks(var_bookmarks.clone(), var_parsed_args.clone())
			}
		}
	}
	var_html = rt.call_function('apply_filters', [rt.new_string('wp_list_bookmarks'),
		rt.new_string(var_output.str()).clone()])
	if rt.is_true(var_parsed_args.array_get('echo')) {
		rt.echo_val(var_html)
	} else {
		return var_html.clone()
	}
	return rt.new_null()
}

pub fn init_wp_includes_bookmark_template_php() {
}
