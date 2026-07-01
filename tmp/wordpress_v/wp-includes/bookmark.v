module wp_includes

import rt
import crypto.md5

fn get_bookmark(var_bookmark rt.PhpVal, var_output rt.PhpVal, filter string) rt.PhpVal {
	mut var_filter := filter
	mut var_wpdb := rt.new_null()
	mut var_GLOBALS := rt.new_null()
	mut var__bookmark := rt.new_null()
	if !rt.is_true(var_bookmark) {
		if var_GLOBALS.array_isset(rt.new_string('link')) {
			var__bookmark = var_GLOBALS.array_get('link')
		} else {
			var__bookmark = rt.new_null()
		}
	} else if rt.is_true(rt.new_bool(var_bookmark.clone().is_object())) {
		rt.call_function('wp_cache_add', [rt.get_property(var_bookmark, 'link_id'),
			var_bookmark.clone(), rt.new_string('bookmark')])
		var__bookmark = var_bookmark.clone()
	} else {
		if rt.is_true(rt.new_bool(var_GLOBALS.array_isset(rt.new_string('link'))
			&& rt.is_true(rt.identical(rt.get_property(var_GLOBALS.array_get('link'), 'link_id'), var_bookmark))))
		{
			var__bookmark = var_GLOBALS.array_get('link')
		} else {
			var__bookmark = rt.call_function('wp_cache_get', [
				var_bookmark.clone(), rt.new_string('bookmark')])
			if rt.is_true(rt.new_bool(!(rt.is_true(var__bookmark)))) {
				var__bookmark = rt.call_method(var_wpdb, 'get_row', [
					rt.call_method(var_wpdb, 'prepare', [
						rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
							'links')), rt.new_string(' WHERE link_id = %d LIMIT 1')),
						var_bookmark.clone(),
					]),
				])
				if rt.is_true(var__bookmark) {
					rt.set_property(var__bookmark, 'link_category', rt.call_function('array_unique', [
						rt.call_function('wp_get_object_terms', [
							rt.get_property(var__bookmark, 'link_id'),
							rt.new_string('link_category'),
							rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }]),
						]),
					]))
					rt.call_function('wp_cache_add', [
						rt.get_property(var__bookmark, 'link_id'),
						var__bookmark.clone(),
						rt.new_string('bookmark'),
					])
				}
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var__bookmark)))) {
		return var__bookmark.clone()
	}
	var__bookmark = sanitize_bookmark(var__bookmark.clone(), filter)
	if rt.is_true(rt.identical(rt.get_constant('OBJECT'), var_output)) {
		return var__bookmark.clone()
	} else if rt.is_true(rt.identical(rt.get_constant('ARRAY_A'), var_output)) {
		return rt.call_function('get_object_vars', [var__bookmark.clone()])
	} else if rt.is_true(rt.identical(rt.get_constant('ARRAY_N'), var_output)) {
		return rt.call_function('array_values', [
			rt.call_function('get_object_vars', [var__bookmark.clone()]),
		])
	} else {
		return var__bookmark.clone()
	}
	return rt.new_null()
}

fn get_bookmark_field(var_field rt.PhpVal, var_bookmark_arg rt.PhpVal, context string) string {
	mut var_context := context
	mut var_bookmark := var_bookmark_arg
	var_bookmark = rt.new_int(var_bookmark.to_i64())
	var_bookmark = get_bookmark(var_bookmark.clone(), rt.new_null(), '')
	if rt.is_true(rt.call_function('is_wp_error', [var_bookmark.clone()])) {
		return var_bookmark.str()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_bookmark.clone().is_object()))))) {
		return ''
	}
	if !(!(rt.get_property(var_bookmark, '{"nodeType":"Expr_Variable","line":90,"name":"field"}')).is_null()) {
		return ''
	}
	return (sanitize_bookmark_field(var_field.clone(), rt.get_property(var_bookmark,
		'{"nodeType":"Expr_Variable","line":94,"name":"field"}'), rt.get_property(var_bookmark,
		'link_id'), rt.new_string(context))).str()
}

fn get_bookmarks(args string) rt.PhpVal {
	mut var_args := args
	mut var_wpdb := rt.new_null()
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_parsed_args := rt.new_null()
	mut var_key := ''
	mut var_cache := rt.new_null()
	mut var_bookmarks := rt.new_null()
	mut var_inclusions := rt.new_null()
	mut var_inclinks := rt.new_null()
	mut var_inclink := rt.new_null()
	mut var_exclusions := rt.new_null()
	mut var_exlinks := rt.new_null()
	mut var_exlink := rt.new_null()
	mut var_search := rt.new_null()
	mut var_like := rt.new_null()
	mut var_category_query := rt.new_null()
	mut var_join := ''
	mut var_incategories := rt.new_null()
	mut var_incat := rt.new_null()
	mut var_recently_updated_test := ''
	mut var_get_updated := ''
	mut var_orderby := ''
	mut var_length := ''
	mut var_orderparams := rt.new_null()
	mut var_keys := rt.new_null()
	mut var_ordparam := rt.new_null()
	mut var_order := ''
	mut var_visible := ''
	mut var_query := ''
	mut var_results := rt.new_null()
	var_defaults = {
		'orderby':        rt.new_string('name')
		'order':          rt.new_string('ASC')
		'limit':          -1
		'category':       rt.new_string('')
		'category_name':  rt.new_string('')
		'hide_invisible': rt.new_int(1)
		'show_updated':   rt.new_int(0)
		'include':        rt.new_string('')
		'exclude':        rt.new_string('')
		'search':         rt.new_string('')
	}
	var_parsed_args = rt.call_function('wp_parse_args', [rt.new_string(args),
		rt.create_array_from_native_map(var_defaults)])
	var_key = md5.hexhash(rt.call_function('serialize', [var_parsed_args.clone()]).to_string())
	var_cache = rt.call_function('wp_cache_get', [rt.new_string('get_bookmarks'),
		rt.new_string('bookmark')])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('rand'), var_parsed_args.array_get('orderby')))))
		&& rt.is_true(var_cache)))
	{
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_cache.clone().is_array()))
			&& var_cache.array_isset(rt.new_string(var_key.str()))))
		{
			var_bookmarks = var_cache.array_get(var_key)
			return rt.call_function('apply_filters', [rt.new_string('get_bookmarks'),
				var_bookmarks.clone(), var_parsed_args.clone()])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_cache.clone().is_array()))))) {
		var_cache = rt.new_array()
	}
	var_inclusions = rt.new_string('')
	if !(!rt.is_true(var_parsed_args.array_get('include'))) {
		var_parsed_args.array_set('exclude', '')
		var_parsed_args.array_set('category', '')
		var_parsed_args.array_set('category_name', '')
		var_inclinks = rt.call_function('wp_parse_id_list', [
			var_parsed_args.array_get('include')])
		if rt.is_true(rt.new_int(var_inclinks.clone().array_count())) {
			{
				mut iter_1 := var_inclinks.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_inclink_shadow := item_1.val
					if !rt.is_true(var_inclusions) {
						var_inclusions = rt.new_string(
							' AND ( link_id = ' + var_inclink_shadow.str() + ' ')
					} else {
						var_inclusions = rt.concat(var_inclusions, rt.new_string(' OR link_id = ' +
							var_inclink_shadow.str() + ' '))
					}
				}
			}
		}
	}
	if !(!rt.is_true(var_inclusions)) {
		var_inclusions = rt.concat(var_inclusions, rt.new_string(')'))
	}
	var_exclusions = rt.new_string('')
	if !(!rt.is_true(var_parsed_args.array_get('exclude'))) {
		var_exlinks = rt.call_function('wp_parse_id_list', [var_parsed_args.array_get('exclude')])
		if rt.is_true(rt.new_int(var_exlinks.clone().array_count())) {
			{
				mut iter_1 := var_exlinks.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_exlink_shadow := item_1.val
					if !rt.is_true(var_exclusions) {
						var_exclusions = rt.new_string(
							' AND ( link_id <> ' + var_exlink_shadow.str() + ' ')
					} else {
						var_exclusions = rt.concat(var_exclusions, rt.new_string(
							' AND link_id <> ' + var_exlink_shadow.str() + ' '))
					}
				}
			}
		}
	}
	if !(!rt.is_true(var_exclusions)) {
		var_exclusions = rt.concat(var_exclusions, rt.new_string(')'))
	}
	if !(!rt.is_true(var_parsed_args.array_get('category_name'))) {
		var_parsed_args.array_set('category', rt.call_function('get_term_by', [
			rt.new_string('name'),
			var_parsed_args.array_get('category_name'),
			rt.new_string('link_category'),
		]))
		if rt.is_true(var_parsed_args.array_get('category')) {
			var_parsed_args.array_set('category', rt.get_property(var_parsed_args.array_get('category'),
				'term_id'))
		} else {
			var_cache.array_set(var_key, rt.new_array())
			rt.call_function('wp_cache_set', [rt.new_string('get_bookmarks'),
				var_cache.clone(), rt.new_string('bookmark')])
			return rt.call_function('apply_filters', [rt.new_string('get_bookmarks'),
				rt.new_array(), var_parsed_args.clone()])
		}
	}
	var_search = rt.new_string('')
	if !(!rt.is_true(var_parsed_args.array_get('search'))) {
		var_like = rt.new_string('%' +
			(rt.call_method(var_wpdb, 'esc_like', [var_parsed_args.array_get('search')])).str() +
			'%')
		var_search = rt.call_method(var_wpdb, 'prepare', [
			rt.new_string(' AND ( (link_url LIKE %s) OR (link_name LIKE %s) OR (link_description LIKE %s) ) '),
			var_like.clone(),
			var_like.clone(),
			var_like.clone(),
		])
	}
	var_category_query = rt.new_string('')
	var_join = ''
	if !(!rt.is_true(var_parsed_args.array_get('category'))) {
		var_incategories = rt.call_function('wp_parse_id_list', [
			var_parsed_args.array_get('category'),
		])
		if rt.is_true(rt.new_int(var_incategories.clone().array_count())) {
			{
				mut iter_1 := var_incategories.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_incat_shadow := item_1.val
					if !rt.is_true(var_category_query) {
						var_category_query = rt.new_string(
							' AND ( tt.term_id = ' + var_incat_shadow.str() + ' ')
					} else {
						var_category_query = rt.concat(var_category_query, rt.new_string(
							' OR tt.term_id = ' + var_incat_shadow.str() + ' '))
					}
				}
			}
		}
	}
	if !(!rt.is_true(var_category_query)) {
		var_category_query = rt.concat(var_category_query,
			rt.new_string(") AND taxonomy = 'link_category'"))
		var_join = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string(' INNER JOIN '), rt.get_property(var_wpdb,
			'term_relationships')), rt.new_string(' AS tr ON (')), rt.get_property(var_wpdb,
			'links')), rt.new_string('.link_id = tr.object_id) INNER JOIN ')), rt.get_property(var_wpdb,
			'term_taxonomy')), rt.new_string(' as tt ON tt.term_taxonomy_id = tr.term_taxonomy_id'))
	}
	if rt.is_true(var_parsed_args.array_get('show_updated')) {
		var_recently_updated_test = ', IF (DATE_ADD(link_updated, INTERVAL 120 MINUTE) >= NOW(), 1,0) as recently_updated '
	} else {
		var_recently_updated_test = ''
	}
	var_get_updated = if rt.is_true(var_parsed_args.array_get('show_updated')) {
		', UNIX_TIMESTAMP(link_updated) AS link_updated_f '
	} else {
		''
	}
	var_orderby = var_parsed_args.array_get('orderby').to_string().to_lower()
	var_length = ''
	mut switch_val_1 := rt.new_string(var_orderby.str())
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('length'))) {
		var_length = ', CHAR_LENGTH(link_name) AS length'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('rand'))) {
		var_orderby = 'rand()'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('link_id'))) {
		var_orderby = rt.concat(rt.get_property(var_wpdb, 'links'), rt.new_string('.link_id'))
	} else {
		var_orderparams = rt.new_array()
		var_keys = rt.create_array([rt.ArrayItem{ key: none, val: 'link_id' },
			rt.ArrayItem{ key: none, val: 'link_name' }, rt.ArrayItem{ key: none, val: 'link_url' },
			rt.ArrayItem{ key: none, val: 'link_visible' }, rt.ArrayItem{
				key: none
				val: 'link_rating'
			}, rt.ArrayItem{ key: none, val: 'link_owner' }, rt.ArrayItem{
				key: none
				val: 'link_updated'
			}, rt.ArrayItem{ key: none, val: 'link_notes' }, rt.ArrayItem{
				key: none
				val: 'link_description'
			}])
		{
			mut iter_1 := rt.call_function('explode', [rt.new_string(','),
				rt.new_string(var_orderby.str()).clone()]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_ordparam_shadow := item_1.val
				var_ordparam_shadow =
					rt.new_string(var_ordparam_shadow.clone().to_string().trim_space())
				if rt.is_true(rt.call_function('in_array', [
					rt.new_string('link_' + var_ordparam_shadow.str()),
					var_keys.clone(),
					rt.new_bool(true),
				]))
				{
					var_orderparams.array_push('link_' + var_ordparam_shadow.str())
				} else if rt.is_true(rt.call_function('in_array', [
					var_ordparam_shadow.clone(), var_keys.clone(),
					rt.new_bool(true)]))
				{
					var_orderparams.array_push(var_ordparam_shadow.clone())
				}
			}
		}
		var_orderby = (rt.call_function('implode', [rt.new_string(','),
			var_orderparams.clone()])).str()
	}
	if var_orderby == '' {
		var_orderby = 'link_name'
	}
	var_order = var_parsed_args.array_get('order').to_string().to_upper()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool('' != var_order))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(var_order.str()).clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'ASC'
	}, rt.ArrayItem{ key: none, val: 'DESC' }]), rt.new_bool(true)])))))))
	{
		var_order = 'ASC'
	}
	var_visible = ''
	if rt.is_true(var_parsed_args.array_get('hide_invisible')) {
		var_visible = "AND link_visible = 'Y'"
	}
	var_query = rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT * '),
		rt.new_string(var_length.str())), rt.new_string(' ')),
		rt.new_string(var_recently_updated_test.str())), rt.new_string(' ')),
		rt.new_string(var_get_updated.str())), rt.new_string(' FROM ')), rt.get_property(var_wpdb,
		'links')), rt.new_string(' ')), rt.new_string(var_join.str())),
		rt.new_string(' WHERE 1=1 ')), rt.new_string(var_visible.str())), rt.new_string(' ')),
		var_category_query)
	var_query = var_query +
		' ${var_exclusions.to_string()} ${var_inclusions.to_string()} ${var_search.to_string()}'
	var_query = var_query + ' ORDER BY ${var_orderby} ${var_order}'
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(-1, var_parsed_args.array_get('limit'))))) {
		var_query = var_query + ' LIMIT ' +
			(rt.call_function('absint', [var_parsed_args.array_get('limit')])).str()
	}
	var_results = rt.call_method(var_wpdb, 'get_results', [rt.new_string(var_query.str()).clone()])
	if rt.is_true(rt.new_bool('rand()' != var_orderby)) {
		var_cache.array_set(var_key, var_results.clone())
		rt.call_function('wp_cache_set', [rt.new_string('get_bookmarks'),
			var_cache.clone(), rt.new_string('bookmark')])
	}
	return rt.call_function('apply_filters', [rt.new_string('get_bookmarks'),
		var_results.clone(), var_parsed_args.clone()])
}

fn sanitize_bookmark(var_bookmark rt.PhpVal, context string) rt.PhpVal {
	mut var_context := context
	mut var_fields := []rt.PhpVal{}
	mut var_do_object := false
	mut var_link_id := rt.new_null()
	mut var_field := rt.new_null()
	var_fields = ['link_id', 'link_url', 'link_name', 'link_image', 'link_target', 'link_category',
		'link_description', 'link_visible', 'link_owner', 'link_rating', 'link_updated', 'link_rel',
		'link_notes', 'link_rss']
	if rt.is_true(rt.new_bool(var_bookmark.clone().is_object())) {
		var_do_object = true
		var_link_id = rt.get_property(var_bookmark, 'link_id')
	} else {
		var_do_object = false
		var_link_id = var_bookmark.array_get('link_id')
	}
	for var_field_shadow in var_fields {
		if var_do_object {
			if !(rt.get_property(var_bookmark,
				'{"nodeType":"Expr_Variable","line":362,"name":"field"}')).is_null() {
				rt.set_property(var_bookmark,
					'{"nodeType":"Expr_Variable","line":363,"name":"field"}', sanitize_bookmark_field(rt.new_string(var_field_shadow.str()).clone(), rt.get_property(var_bookmark,
					'{"nodeType":"Expr_Variable","line":363,"name":"field"}'), var_link_id.clone(),
					rt.new_string(context)))
			}
		} else {
			if var_bookmark.array_isset(rt.new_string(var_field_shadow.str())) {
				var_bookmark.array_set(rt.new_string(var_field_shadow.str()), sanitize_bookmark_field(rt.new_string(var_field_shadow.str()).clone(),
					var_bookmark.array_get(rt.new_string(var_field_shadow.str())),
					var_link_id.clone(), rt.new_string(context)))
			}
		}
	}
	return var_bookmark.clone()
}

fn sanitize_bookmark_field(var_field rt.PhpVal, var_value_arg rt.PhpVal, var_bookmark_id rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_value := var_value_arg
	mut var_int_fields := []rt.PhpVal{}
	mut var_targets := rt.new_null()
	var_int_fields = ['link_id', 'link_rating']
	if rt.is_true(rt.call_function('in_array', [var_field.clone(),
		rt.create_array_from_list(var_int_fields), rt.new_bool(true)]))
	{
		var_value = rt.new_int(var_value.to_i64())
	}
	mut switch_val_2 := var_field
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('link_category'))) {
		var_value = rt.call_function('array_map', [rt.new_string('absint'),
			rt.cast_array(var_value)])
		return var_value.clone()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('link_visible'))) {
		var_value = rt.call_function('preg_replace', [rt.new_string('/[^YNyn]/'),
			rt.new_string(''), var_value.clone()])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('link_target'))) {
		var_targets = rt.create_array([rt.ArrayItem{ key: none, val: '_top' },
			rt.ArrayItem{ key: none, val: '_blank' }])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_value.clone(), var_targets.clone(), rt.new_bool(true)])))))
		{
			var_value = rt.new_string('')
		}
	}
	if rt.is_true(rt.identical(rt.new_string('raw'), var_context)) {
		return var_value.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('edit'), var_context)) {
		var_value = rt.call_function('apply_filters', [
			rt.new_string('edit_${var_field.to_string()}'),
			var_value.clone(),
			var_bookmark_id.clone(),
		])
		if rt.is_true(rt.identical(rt.new_string('link_notes'), var_field)) {
			var_value = rt.call_function('esc_html', [var_value.clone()])
		} else {
			var_value = rt.call_function('esc_attr', [var_value.clone()])
		}
	} else if rt.is_true(rt.identical(rt.new_string('db'), var_context)) {
		var_value = rt.call_function('apply_filters', [
			rt.new_string('pre_${var_field.to_string()}'),
			var_value.clone(),
		])
	} else {
		var_value = rt.call_function('apply_filters', [
			rt.new_string('${var_field.to_string()}'),
			var_value.clone(),
			var_bookmark_id.clone(),
			var_context.clone(),
		])
		if rt.is_true(rt.identical(rt.new_string('attribute'), var_context)) {
			var_value = rt.call_function('esc_attr', [var_value.clone()])
		} else if rt.is_true(rt.identical(rt.new_string('js'), var_context)) {
			var_value = rt.call_function('esc_js', [var_value.clone()])
		}
	}
	if rt.is_true(rt.call_function('in_array', [var_field.clone(),
		rt.create_array_from_list(var_int_fields), rt.new_bool(true)]))
	{
		var_value = rt.new_int(var_value.to_i64())
	}
	return var_value.clone()
}

fn clean_bookmark_cache(var_bookmark_id rt.PhpVal) {
	rt.call_function('wp_cache_delete', [var_bookmark_id.clone(),
		rt.new_string('bookmark')])
	rt.call_function('wp_cache_delete', [rt.new_string('get_bookmarks'),
		rt.new_string('bookmark')])
	rt.call_function('clean_object_term_cache', [var_bookmark_id.clone(),
		rt.new_string('link')])
}

pub fn init_wp_includes_bookmark_php() {
}
