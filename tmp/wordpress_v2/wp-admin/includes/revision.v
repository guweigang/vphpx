import rt

fn wp_get_revision_ui_diff(var_post_arg rt.PhpVal, var_compare_from_arg rt.PhpVal, var_compare_to_arg rt.PhpVal) bool {
	mut var_post := var_post_arg
	mut var_compare_from := var_compare_from_arg
	mut var_compare_to := var_compare_to_arg
	mut var_temp := rt.new_null()
	mut var_return := []rt.PhpVal{}
	mut var_name := rt.new_null()
	mut var_field := rt.new_null()
	mut var_content_from := rt.new_null()
	mut var_content_to := rt.new_null()
	mut var_args := rt.new_null()
	mut var_diff := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	if rt.is_true(var_compare_from) {
		var_compare_from = rt.call_function('get_post', [var_compare_from.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_compare_from)))) {
			return false
		}
	} else {
		var_compare_from = rt.new_bool(false)
	}
	var_compare_to = rt.call_function('get_post', [var_compare_to.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_compare_to)))) {
		return false
	}
	if rt.is_true(var_compare_from)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_compare_from, 'post_parent'), rt.get_property(var_post, 'ID')))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_compare_from, 'ID'), rt.get_property(var_post, 'ID'))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_compare_to, 'post_parent'), rt.get_property(var_post, 'ID')))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_compare_to, 'ID'), rt.get_property(var_post, 'ID'))))) {
		return false
	}
	if rt.is_true(var_compare_from)
		&& rt.is_true(rt.greater(rt.call_function('strtotime', [rt.get_property(var_compare_from, 'post_date_gmt')]), rt.call_function('strtotime', [rt.get_property(var_compare_to, 'post_date_gmt')]))) {
		var_temp = var_compare_from.clone()
		var_compare_from = var_compare_to.clone()
		var_compare_to = var_temp.clone()
	}
	if rt.is_true(var_compare_from) && !rt.is_true(rt.get_property(var_compare_from, 'post_title')) {
		rt.set_property(var_compare_from, 'post_title', rt.call_function('__', [
			rt.new_string('(no title)'),
		]))
	}
	if !rt.is_true(rt.get_property(var_compare_to, 'post_title')) {
		rt.set_property(var_compare_to, 'post_title', rt.call_function('__', [
			rt.new_string('(no title)'),
		]))
	}
	var_return = []rt.PhpVal{}
	mut iter_1 := rt.call_function('_wp_post_revision_fields', [
		var_post.clone()]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_name_shadow := item_1.val
		mut var_field_shadow := item_1.key
		var_content_from = if rt.is_true(var_compare_from) { rt.call_function('apply_filters', [
				rt.new_string('_wp_post_revision_field_${var_field.to_string()}'),
				rt.get_property(var_compare_from, '{"nodeType":"Expr_Variable","line":90,"name":"field"}'),
				var_field_shadow.clone(),
				var_compare_from.clone(),
				rt.new_string('from'),
			]) } else { rt.new_string('') }
		var_content_to = rt.call_function('apply_filters', [
			rt.new_string('_wp_post_revision_field_${var_field.to_string()}'),
			rt.get_property(var_compare_to, '{"nodeType":"Expr_Variable","line":93,"name":"field"}'),
			var_field_shadow.clone(),
			var_compare_to.clone(),
			rt.new_string('to'),
		])
		var_args = rt.create_array([rt.ArrayItem{ key: 'show_split_view', val: true },
			rt.ArrayItem{ key: 'title_left', val: rt.call_function('__', [
				rt.new_string('Removed'),
			]) }, rt.ArrayItem{ key: 'title_right', val: rt.call_function('__', [
				rt.new_string('Added'),
			]) }])
		var_args = rt.call_function('apply_filters', [
			rt.new_string('revision_text_diff_options'),
			var_args.clone(),
			var_field_shadow.clone(),
			var_compare_from.clone(),
			var_compare_to.clone(),
		])
		var_diff = rt.call_function('wp_text_diff', [var_content_from.clone(),
			var_content_to.clone(), var_args.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_diff))))
			&& rt.is_true(rt.identical(rt.new_string('post_title'), var_field_shadow)) {
			var_diff =
				rt.new_string('<table class="diff"><colgroup><col class="content diffsplit left"><col class="content diffsplit middle"><col class="content diffsplit right"></colgroup><tbody><tr>')
			if rt.is_true(rt.identical(rt.new_bool(true),
				var_args.array_get(rt.new_string('show_split_view'))))
			{
				var_diff = rt.concat(var_diff, rt.new_string('<td>' +
					(rt.call_function('esc_html', [rt.get_property(var_compare_from, 'post_title')])).str() +
					'</td><td></td><td>' +
					(rt.call_function('esc_html', [rt.get_property(var_compare_to, 'post_title')])).str() +
					'</td>'))
			} else {
				var_diff = rt.concat(var_diff, rt.new_string('<td>' +
					(rt.call_function('esc_html', [rt.get_property(var_compare_from, 'post_title')])).str() +
					'</td>'))
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_compare_from,
					'post_title'), rt.get_property(var_compare_to, 'post_title')))))
				{
					var_diff = rt.concat(var_diff, rt.new_string('</tr><tr><td>' +
						(rt.call_function('esc_html', [rt.get_property(var_compare_to, 'post_title')])).str() +
						'</td>'))
				}
			}
			var_diff = rt.concat(var_diff, rt.new_string('</tr></tbody>'))
			var_diff = rt.concat(var_diff, rt.new_string('</table>'))
		}
		if rt.is_true(var_diff) {
			var_return << rt.create_array([
				rt.ArrayItem{ key: 'id', val: var_field_shadow },
				rt.ArrayItem{ key: 'name', val: var_name_shadow },
				rt.ArrayItem{ key: 'diff', val: var_diff },
			])
		}
	}
	return (rt.call_function('apply_filters', [rt.new_string('wp_get_revision_ui_diff'),
		rt.create_array_from_list(var_return), var_compare_from.clone(),
		var_compare_to.clone()])).to_bool()
}

fn wp_prepare_revisions_for_js(var_post_arg rt.PhpVal, var_selected_revision_id rt.PhpVal, var_from_arg rt.PhpVal) rt.PhpVal {
	mut var_post := var_post_arg
	mut var_from := var_from_arg
	mut var_authors := rt.new_null()
	mut var_now_gmt := rt.new_null()
	mut var_revisions := rt.new_null()
	mut var_revision := rt.new_null()
	mut var_revision_id := rt.new_null()
	mut var_show_avatars := rt.new_null()
	mut var_can_restore := rt.new_null()
	mut var_current_id := rt.new_null()
	mut var_modified := rt.new_null()
	mut var_modified_gmt := rt.new_null()
	mut var_restore_link := rt.new_null()
	mut var_autosave := rt.new_null()
	mut var_current := false
	mut var_revisions_data := map[string]rt.PhpVal{}
	mut var_compare_two_mode := false
	mut var_found := rt.new_null()
	mut var_diffs := []rt.PhpVal{}
	var_post = rt.call_function('get_post', [var_post.clone()])
	var_authors = []rt.PhpVal{}
	var_now_gmt = rt.call_function('time', []rt.PhpVal{})
	var_revisions = rt.call_function('wp_get_post_revisions', [
		rt.get_property(var_post, 'ID'),
		rt.create_array([rt.ArrayItem{ key: 'order', val: 'ASC' },
			rt.ArrayItem{ key: 'check_enabled', val: false }]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_revisions_enabled', [
		var_post.clone(),
	])))))
	{
		mut iter_2 := var_revisions.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_revision_shadow := item_2.val
			mut var_revision_id_shadow := item_2.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_post_autosave', [
				var_revision_shadow.clone(),
			])))))
			{
				var_revisions.array_unset(var_revision_id_shadow)
			}
		}
		var_revisions = rt.add(rt.create_array([
			rt.ArrayItem{ key: rt.get_property(var_post, 'ID'), val: var_post },
		]), var_revisions)
	}
	var_show_avatars = rt.call_function('get_option', [rt.new_string('show_avatars')])
	rt.call_function('update_post_author_caches', [var_revisions.clone()])
	var_can_restore = rt.call_function('current_user_can', [rt.new_string('edit_post'),
		rt.get_property(var_post, 'ID')])
	var_current_id = rt.new_bool(false)
	mut iter_3 := var_revisions.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_revision_shadow := item_3.val
		var_modified = rt.call_function('strtotime', [
			rt.get_property(var_revision_shadow, 'post_modified'),
		])
		var_modified_gmt = rt.call_function('strtotime', [
			rt.new_string((rt.get_property(var_revision_shadow, 'post_modified_gmt')).str() +
				' +0000'),
		])
		if rt.is_true(var_can_restore) {
			var_restore_link = rt.call_function('str_replace', [
				rt.new_string('&amp;'), rt.new_string('&'),
				rt.call_function('wp_nonce_url', [
					rt.call_function('add_query_arg', [
						rt.create_array([
							rt.ArrayItem{
								key: 'revision'
								val: rt.get_property(var_revision_shadow, 'ID')
							},
							rt.ArrayItem{ key: 'action', val: 'restore' },
						]),
						rt.call_function('admin_url', [
							rt.new_string('revision.php'),
						]),
					]),
					rt.concat(rt.new_string('restore-post_'),
						rt.get_property(var_revision_shadow, 'ID')),
				])])
		}
		if !(var_authors.array_isset(rt.get_property(var_revision_shadow, 'post_author'))) {
			var_authors.array_set(rt.get_property(var_revision_shadow, 'post_author'), rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.new_int((rt.get_property(var_revision_shadow,
					'post_author')).to_i64()) },
				rt.ArrayItem{
					key: 'avatar'
					val: if rt.is_true(var_show_avatars) { rt.call_function('get_avatar', [
							rt.get_property(var_revision_shadow, 'post_author'),
							rt.new_int(32),
						]) } else { rt.new_string('') }
				},
				rt.ArrayItem{ key: 'name', val: rt.call_function('get_the_author_meta', [
					rt.new_string('display_name'),
					rt.get_property(var_revision_shadow, 'post_author'),
				]) },
			]))
		}
		var_autosave = rt.new_bool((rt.call_function('wp_is_post_autosave', [
			var_revision_shadow.clone()])).to_bool())
		var_current = rt.is_true(rt.new_bool(!(rt.is_true(var_autosave))))
			&& rt.is_true(rt.identical(rt.get_property(var_revision_shadow, 'post_modified_gmt'), rt.get_property(var_post, 'post_modified_gmt')))
		if var_current && !(!rt.is_true(var_current_id)) {
			if rt.is_true(rt.less(var_current_id, rt.get_property(var_revision_shadow, 'ID'))) {
				var_revisions.array_get_mut(var_current_id).array_set('current', false)
				var_current_id = rt.get_property(var_revision_shadow, 'ID')
			} else {
				var_current = false
			}
		} else if var_current {
			var_current_id = rt.get_property(var_revision_shadow, 'ID')
		}
		var_revisions_data = {
			'id':         rt.get_property(var_revision_shadow, 'ID')
			'title':      rt.call_function('get_the_title', [
				rt.get_property(var_post, 'ID'),
			])
			'author':     var_authors.array_get(rt.get_property(var_revision_shadow, 'post_author'))
			'date':       rt.call_function('date_i18n', [
				rt.call_function('__', [rt.new_string('M j, Y @ H:i')]),
				var_modified.clone(),
			])
			'dateShort':  rt.call_function('date_i18n', [
				rt.call_function('_x', [rt.new_string('j M Y @ H:i'),
					rt.new_string('revision date short format')]),
				var_modified.clone(),
			])
			'timeAgo':    rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('%s ago')]),
				rt.call_function('human_time_diff', [var_modified_gmt.clone(),
					var_now_gmt.clone()]),
			])
			'autosave':   var_autosave
			'current':    rt.new_bool(var_current)
			'restoreUrl': if rt.is_true(var_can_restore) {
				var_restore_link
			} else {
				rt.new_bool(false)
			}
		}
		var_revisions.array_set(rt.get_property(var_revision_shadow, 'ID'), rt.call_function('apply_filters', [
			rt.new_string('wp_prepare_revision_for_js'),
			rt.create_array_from_native_map(var_revisions_data),
			var_revision_shadow.clone(),
			var_post.clone(),
		]))
	}
	if 1 == var_revisions.clone().array_count() {
		var_revisions.array_set(rt.get_property(var_post, 'ID'), rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.get_property(var_post, 'ID') },
			rt.ArrayItem{ key: 'title', val: rt.call_function('get_the_title', [
				rt.get_property(var_post, 'ID'),
			]) },
			rt.ArrayItem{ key: 'author', val: var_authors.array_get(rt.get_property(var_revision,
				'post_author')) },
			rt.ArrayItem{ key: 'date', val: rt.call_function('date_i18n', [
				rt.call_function('__', [rt.new_string('M j, Y @ H:i')]),
				rt.call_function('strtotime', [rt.get_property(var_post, 'post_modified')]),
			]) },
			rt.ArrayItem{ key: 'dateShort', val: rt.call_function('date_i18n', [
				rt.call_function('_x', [rt.new_string('j M @ H:i'),
					rt.new_string('revision date short format')]),
				rt.call_function('strtotime', [rt.get_property(var_post, 'post_modified')]),
			]) },
			rt.ArrayItem{ key: 'timeAgo', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%s ago'),
				]),
				rt.call_function('human_time_diff', [
					rt.call_function('strtotime', [
						rt.get_property(var_post, 'post_modified_gmt'),
					]),
					var_now_gmt.clone(),
				]),
			]) },
			rt.ArrayItem{ key: 'autosave', val: false },
			rt.ArrayItem{ key: 'current', val: true },
			rt.ArrayItem{ key: 'restoreUrl', val: false },
		]))
		var_current_id = rt.get_property(var_post, 'ID')
	}
	if !rt.is_true(var_current_id) {
		if rt.is_true(var_revisions.array_get(rt.get_property(var_revision, 'ID')).array_get(rt.new_string('autosave'))) {
			var_revision = rt.call_function('end', [var_revisions.clone()])
			for rt.is_true(var_revision.array_get(rt.new_string('autosave'))) {
				var_revision = rt.call_function('prev', [var_revisions.clone()])
			}
			var_current_id = var_revision.array_get(rt.new_string('id'))
		} else {
			var_current_id = rt.get_property(var_revision, 'ID')
		}
		var_revisions.array_get_mut(var_current_id).array_set('current', true)
	}
	var_compare_two_mode = var_from.clone().is_long() || var_from.clone().is_double()
	if !var_compare_two_mode {
		var_found = rt.call_function('array_search', [var_selected_revision_id.clone(),
			rt.func_array_keys(var_revisions.clone()), rt.new_bool(true)])
		if rt.is_true(var_found) {
			var_from = rt.func_array_keys(rt.call_function('array_slice', [
				var_revisions.clone(), rt.sub(var_found, rt.new_int(1)),
				rt.new_int(1), rt.new_bool(true)]))
			var_from = rt.call_function('reset', [var_from.clone()])
		} else {
			var_from = rt.new_int(0)
		}
	}
	var_from = rt.call_function('absint', [var_from.clone()])
	var_diffs = [
		[var_from.str() + ':' + var_selected_revision_id.str(),
			rt.new_bool(wp_get_revision_ui_diff(rt.get_property(var_post, 'ID'), var_from.clone(),
				var_selected_revision_id.clone()))],
	]
	return rt.create_array([
		rt.ArrayItem{ key: 'postId', val: rt.get_property(var_post, 'ID') },
		rt.ArrayItem{ key: 'nonce', val: rt.call_function('wp_create_nonce', [
			rt.new_string('revisions-ajax-nonce'),
		]) },
		rt.ArrayItem{ key: 'revisionData', val: rt.call_function('array_values', [
			var_revisions.clone(),
		]) },
		rt.ArrayItem{ key: 'to', val: var_selected_revision_id },
		rt.ArrayItem{ key: 'from', val: var_from },
		rt.ArrayItem{ key: 'diffData', val: var_diffs },
		rt.ArrayItem{ key: 'baseUrl', val: rt.call_function('parse_url', [
			rt.call_function('admin_url', [rt.new_string('revision.php')]),
			rt.get_constant('PHP_URL_PATH'),
		]) },
		rt.ArrayItem{ key: 'compareTwoMode', val: rt.call_function('absint', [
			rt.new_bool(var_compare_two_mode).clone(),
		]) },
		rt.ArrayItem{ key: 'revisionIds', val: rt.func_array_keys(var_revisions.clone()) },
	])
}

fn wp_print_revision_templates() {
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Previous'),
		rt.new_string('Button label for a previous revision')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr_x', [rt.new_string('Next'),
		rt.new_string('Button label for a next revision')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Select a revision')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Change revision by using the left and right arrow keys'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Compare any two revisions')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex',
		[rt.new_string('From:'), rt.new_string('Followed by post revision info')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('To:'), rt.new_string('Followed by post revision info')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Autosave by %s')]),
		rt.new_string('<span class="author-name">{{ data.attributes.author.name }}</span>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Current Revision by %s')]),
		rt.new_string('<span class="author-name">{{ data.attributes.author.name }}</span>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('Revision by %s')]),
		rt.new_string('<span class="author-name">{{ data.attributes.author.name }}</span>'),
	])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('wp_check_post_lock', [
		rt.get_property(var_post, 'ID'),
	]))
	{
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Restore This Autosave')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Restore This Revision')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [
		rt.new_string('An error occurred while loading the comparison. Please refresh the page and try again.'),
	])
	// unsupported statement: Stmt_InlineHTML
}

fn main() {
	defer {
		rt.shutdown()
	}
}
