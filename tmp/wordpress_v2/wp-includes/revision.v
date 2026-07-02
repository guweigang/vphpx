import rt

fn _wp_post_revision_fields(var_post_arg rt.PhpVal, deprecated bool) rt.PhpVal {
	mut var_deprecated := deprecated
	mut var_post := var_post_arg
	mut var_fields := rt.new_null()
	mut var_protect := rt.new_null()
	if !(var_post.clone().is_array()) {
		var_post = rt.call_function('get_post', [var_post.clone(),
			rt.get_constant('ARRAY_A')])
	}
	if rt.is_true(rt.new_bool(var_fields.clone().is_null())) {
		var_fields = rt.create_array([
			rt.ArrayItem{ key: 'post_title', val: rt.call_function('__', [
				rt.new_string('Title'),
			]) },
			rt.ArrayItem{ key: 'post_content', val: rt.call_function('__', [
				rt.new_string('Content'),
			]) },
			rt.ArrayItem{ key: 'post_excerpt', val: rt.call_function('__', [
				rt.new_string('Excerpt'),
			]) },
		])
	}
	var_fields = rt.call_function('apply_filters', [
		rt.new_string('_wp_post_revision_fields'),
		var_fields.clone(),
		var_post.clone(),
	])
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'ID' },
		rt.ArrayItem{ key: none, val: 'post_name' }, rt.ArrayItem{ key: none, val: 'post_parent' },
		rt.ArrayItem{ key: none, val: 'post_date' }, rt.ArrayItem{ key: none, val: 'post_date_gmt' },
		rt.ArrayItem{ key: none, val: 'post_status' }, rt.ArrayItem{ key: none, val: 'post_type' },
		rt.ArrayItem{ key: none, val: 'comment_count' }, rt.ArrayItem{ key: none, val: 'post_author' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_protect_shadow := item_1.val
		var_fields.array_unset(var_protect_shadow)
	}
	return var_fields.clone()
}

fn _wp_post_revision_data(var_post_arg rt.PhpVal, autosave bool) rt.PhpVal {
	mut var_autosave := autosave
	mut var_post := var_post_arg
	mut var_fields := rt.new_null()
	mut var_revision_data := rt.new_null()
	mut var_field := rt.new_null()
	if !(var_post.clone().is_array()) {
		var_post = rt.call_function('get_post', [var_post.clone(),
			rt.get_constant('ARRAY_A')])
	}
	var_fields = _wp_post_revision_fields(var_post.clone(), false)
	var_revision_data = rt.new_array()
	mut iter_2 := rt.call_function('array_intersect', [
		rt.func_array_keys(var_post.clone()),
		rt.func_array_keys(var_fields.clone()),
	]).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_field_shadow := item_2.val
		var_revision_data.array_set(var_field_shadow, var_post.array_get(var_field_shadow))
	}
	var_revision_data.array_set('post_parent', var_post.array_get(rt.new_string('ID')))
	var_revision_data.array_set('post_status', 'inherit')
	var_revision_data.array_set('post_type', 'revision')
	var_revision_data.array_set('post_name', if var_autosave {
		rt.concat(var_post.array_get(rt.new_string('ID')), rt.new_string('-autosave-v1'))
	} else {
		rt.concat(var_post.array_get(rt.new_string('ID')), rt.new_string('-revision-v1'))
	})
	var_revision_data.array_set('post_date', if !(var_post.array_get(rt.new_string('post_modified'))).is_null() {
		var_post.array_get(rt.new_string('post_modified'))
	} else {
		rt.new_string('')
	})
	var_revision_data.array_set('post_date_gmt', if !(var_post.array_get(rt.new_string('post_modified_gmt'))).is_null() {
		var_post.array_get(rt.new_string('post_modified_gmt'))
	} else {
		rt.new_string('')
	})
	return var_revision_data.clone()
}

fn wp_save_post_revision_on_insert(var_post_id rt.PhpVal, var_post rt.PhpVal, var_update rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [
		rt.new_string('post_updated'),
		rt.new_string('wp_save_post_revision'),
	])))))
	{
		return
	}
	wp_save_post_revision(var_post_id.clone())
}

fn wp_save_post_revision(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_post := rt.new_null()
	mut var_revisions := rt.new_null()
	mut var_revision := rt.new_null()
	mut var_latest_revision := rt.new_null()
	mut var_post_has_changed := rt.new_null()
	mut var_field := rt.new_null()
	mut var_return := rt.new_null()
	mut var_revisions_to_keep := rt.new_null()
	mut var_delete := rt.new_null()
	mut var_i := i64(0)
	if rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AUTOSAVE')]))
		&& rt.is_true(rt.get_constant('DOING_AUTOSAVE')) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('doing_action', [rt.new_string('post_updated')]))
		&& rt.is_true(rt.call_function('has_action', [rt.new_string('wp_after_insert_post'), rt.new_string('wp_save_post_revision_on_insert')])) {
		return rt.new_null()
	}
	var_post = rt.call_function('get_post', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [
		rt.get_property(var_post, 'post_type'),
		rt.new_string('revisions'),
	])))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('auto-draft'),
		rt.get_property(var_post, 'post_status')))
	{
		return rt.new_null()
	}
	if !(wp_revisions_enabled(var_post.clone())) {
		return rt.new_null()
	}
	var_revisions = wp_get_post_revisions(var_post_id.clone(), rt.new_null())
	if rt.is_true(var_revisions) {
		mut iter_3 := var_revisions.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_revision_shadow := item_3.val
			if rt.is_true(rt.call_function('str_contains', [
				rt.get_property(var_revision_shadow, 'post_name'),
				rt.concat(rt.get_property(var_revision_shadow, 'post_parent'),
					rt.new_string('-revision')),
			]))
			{
				var_latest_revision = var_revision_shadow.clone()
				break
			}
		}
		if !var_latest_revision.is_null()
			&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('wp_save_post_revision_check_for_changes'), rt.new_bool(true), var_latest_revision.clone(), var_post.clone()])) {
			var_post_has_changed = rt.new_bool(false)
			mut iter_4 :=
				rt.func_array_keys(_wp_post_revision_fields(var_post.clone(), false)).iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_field_shadow := item_4.val
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('normalize_whitespace', [
					rt.call_function('maybe_serialize', [
						rt.get_property(var_post,
							'{"nodeType":"Expr_Variable","line":190,"name":"field"}'),
					]),
				]), rt.call_function('normalize_whitespace', [
					rt.call_function('maybe_serialize', [
						rt.get_property(var_latest_revision,
							'{"nodeType":"Expr_Variable","line":190,"name":"field"}'),
					]),
				])))))
				{
					var_post_has_changed = rt.new_bool(true)
					break
				}
			}
			var_post_has_changed = rt.new_bool((rt.call_function('apply_filters', [
				rt.new_string('wp_save_post_revision_post_has_changed'),
				var_post_has_changed.clone(),
				var_latest_revision.clone(),
				var_post.clone(),
			])).to_bool())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_post_has_changed)))) {
				return rt.new_null()
			}
		}
	}
	var_return = _wp_put_post_revision(var_post.clone(), false)
	var_revisions_to_keep = rt.new_int(wp_revisions_to_keep(var_post.clone()))
	if rt.is_true(rt.less(var_revisions_to_keep, rt.new_int(0))) {
		return var_return.clone()
	}
	var_revisions = wp_get_post_revisions(var_post_id.clone(), rt.create_array([
		rt.ArrayItem{ key: 'order', val: 'ASC' },
	]))
	var_revisions = rt.call_function('apply_filters', [
		rt.new_string('wp_save_post_revision_revisions_before_deletion'),
		var_revisions.clone(),
		var_post_id.clone(),
	])
	var_delete = rt.sub(rt.new_int(var_revisions.clone().array_count()), var_revisions_to_keep)
	if rt.is_true(rt.less(var_delete, rt.new_int(1))) {
		return var_return.clone()
	}
	var_revisions = rt.call_function('array_slice', [var_revisions.clone(),
		rt.new_int(0), var_delete.clone()])
	var_i = 0
	for {
		if !(var_revisions.array_isset(rt.new_int(var_i))) { break
		 }
		if rt.is_true(rt.call_function('str_contains', [
			rt.get_property(var_revisions.array_get(rt.new_int(var_i)), 'post_name'),
			rt.new_string('autosave'),
		]))
		{
			continue
		}
		wp_delete_post_revision(rt.get_property(var_revisions.array_get(rt.new_int(var_i)), 'ID'))
		var_i += 1
	}
	return var_return.clone()
}

fn wp_get_post_autosave(var_post_id rt.PhpVal, user_id i64) bool {
	mut var_user_id := user_id
	mut var_args := rt.new_null()
	mut var_query := rt.new_null()
	var_args = rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'revision' },
		rt.ArrayItem{ key: 'post_status', val: 'inherit' }, rt.ArrayItem{
			key: 'post_parent'
			val: var_post_id
		}, rt.ArrayItem{ key: 'name', val: var_post_id.str() + '-autosave-v1' },
		rt.ArrayItem{ key: 'posts_per_page', val: 1 }, rt.ArrayItem{ key: 'orderby', val: 'date' },
		rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'fields', val: 'ids' },
		rt.ArrayItem{ key: 'no_found_rows', val: true }])
	if rt.is_true(rt.new_bool(0 != user_id)) {
		var_args.array_set('author', user_id)
	}
	var_query = create_wp_query(var_args.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_query.have_posts())))) {
		return false
	}
	return (rt.call_function('get_post',
		[rt.get_property(var_query, 'posts').array_get(rt.new_int(0))])).to_bool()
}

fn wp_is_post_revision(var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_post := var_post_arg
	var_post = wp_get_post_revision(var_post.clone(), rt.new_null(), '')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.new_bool(false)
	}
	return rt.new_int((rt.get_property(var_post, 'post_parent')).to_i64())
}

fn wp_is_post_autosave(var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_post := var_post_arg
	var_post = wp_get_post_revision(var_post.clone(), rt.new_null(), '')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('str_contains', [
		rt.get_property(var_post, 'post_name'),
		rt.concat(rt.get_property(var_post, 'post_parent'), rt.new_string('-autosave')),
	]))
	{
		return rt.new_int((rt.get_property(var_post, 'post_parent')).to_i64())
	}
	return rt.new_bool(false)
}

fn _wp_put_post_revision(var_post_arg rt.PhpVal, autosave bool) rt.PhpVal {
	mut var_autosave := autosave
	mut var_post := var_post_arg
	mut var_revision_id := rt.new_null()
	if rt.is_true(rt.new_bool(var_post.clone().is_object())) {
		var_post = rt.call_function('get_object_vars', [var_post.clone()])
	} else if !(var_post.clone().is_array()) {
		var_post = rt.call_function('get_post', [var_post.clone(),
			rt.get_constant('ARRAY_A')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post))))
		|| !rt.is_true(var_post.array_get(rt.new_string('ID'))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_post'), rt.call_function('__', [
			rt.new_string('Invalid post ID.'),
		])))
	}
	if var_post.array_isset(rt.new_string('post_type'))
		&& rt.is_true(rt.identical(rt.new_string('revision'), var_post.array_get(rt.new_string('post_type')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('post_type'), rt.call_function('__', [
			rt.new_string('Cannot create a revision of a revision'),
		])))
	}
	var_post = _wp_post_revision_data(var_post.clone(), autosave)
	var_post = rt.call_function('wp_slash', [var_post.clone()])
	var_revision_id = rt.call_function('wp_insert_post', [var_post.clone(),
		rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_revision_id.clone()])) {
		return var_revision_id.clone()
	}
	if rt.is_true(var_revision_id) {
		rt.call_function('do_action', [rt.new_string('_wp_put_post_revision'),
			var_revision_id.clone(), var_post.array_get(rt.new_string('post_parent'))])
	}
	return var_revision_id.clone()
}

fn wp_save_revisioned_meta_fields(var_revision_id rt.PhpVal, var_post_id rt.PhpVal) {
	mut var_post_type := rt.new_null()
	mut var_meta_key := rt.new_null()
	var_post_type = rt.call_function('get_post_type', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) {
		return
	}
	mut iter_5 := wp_post_revision_meta_keys(var_post_type.clone()).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_meta_key_shadow := item_5.val
		if rt.is_true(rt.call_function('metadata_exists', [rt.new_string('post'),
			var_post_id.clone(), var_meta_key_shadow.clone()]))
		{
			_wp_copy_post_meta(var_post_id.clone(), var_revision_id.clone(),
				var_meta_key_shadow.clone())
		}
	}
}

fn wp_get_post_revision(var_post rt.PhpVal, var_output rt.PhpVal, filter string) rt.PhpVal {
	mut var_filter := filter
	mut var_revision := rt.new_null()
	mut var__revision := rt.new_null()
	var_revision = rt.call_function('get_post', [var_post.clone(),
		rt.get_constant('OBJECT'), rt.new_string(filter)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revision)))) {
		return var_revision.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('revision'), rt.get_property(var_revision,
		'post_type')))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.get_constant('OBJECT'), var_output)) {
		return var_revision.clone()
	} else if rt.is_true(rt.identical(rt.get_constant('ARRAY_A'), var_output)) {
		var__revision = rt.call_function('get_object_vars', [
			var_revision.clone()])
		return var__revision.clone()
	} else if rt.is_true(rt.identical(rt.get_constant('ARRAY_N'), var_output)) {
		var__revision = rt.call_function('array_values', [
			rt.call_function('get_object_vars', [var_revision.clone()]),
		])
		return var__revision.clone()
	}
	return var_revision.clone()
}

fn wp_restore_post_revision(var_revision_arg rt.PhpVal, var_fields_arg rt.PhpVal) bool {
	mut var_revision := var_revision_arg
	mut var_fields := var_fields_arg
	mut var_update := rt.new_null()
	mut var_field := rt.new_null()
	mut var_post_id := rt.new_null()
	var_revision = wp_get_post_revision(var_revision.clone(), rt.get_constant('ARRAY_A'), '')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revision)))) {
		return var_revision.to_bool()
	}
	if !(var_fields.clone().is_array()) {
		var_fields = rt.func_array_keys(_wp_post_revision_fields(var_revision.clone(), false))
	}
	var_update = rt.new_array()
	mut iter_6 := rt.call_function('array_intersect', [
		rt.func_array_keys(var_revision.clone()),
		var_fields.clone(),
	]).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_field_shadow := item_6.val
		var_update.array_set(var_field_shadow, var_revision.array_get(var_field_shadow))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) {
		return false
	}
	var_update.array_set('ID', var_revision.array_get(rt.new_string('post_parent')))
	var_update = rt.call_function('wp_slash', [var_update.clone()])
	var_post_id = rt.call_function('wp_update_post', [var_update.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()])) {
		return var_post_id.to_bool()
	}
	rt.call_function('update_post_meta', [var_post_id.clone(),
		rt.new_string('_edit_last'), rt.call_function('get_current_user_id', []rt.PhpVal{})])
	rt.call_function('do_action', [rt.new_string('wp_restore_post_revision'),
		var_post_id.clone(), var_revision.array_get(rt.new_string('ID'))])
	return var_post_id.to_bool()
}

fn wp_restore_post_revision_meta(var_post_id rt.PhpVal, var_revision_id rt.PhpVal) {
	mut var_post_type := rt.new_null()
	mut var_meta_key := rt.new_null()
	var_post_type = rt.call_function('get_post_type', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) {
		return
	}
	mut iter_7 := wp_post_revision_meta_keys(var_post_type.clone()).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_meta_key_shadow := item_7.val
		rt.call_function('delete_post_meta', [var_post_id.clone(),
			var_meta_key_shadow.clone()])
		_wp_copy_post_meta(var_revision_id.clone(), var_post_id.clone(),
			var_meta_key_shadow.clone())
	}
}

fn _wp_copy_post_meta(var_source_post_id rt.PhpVal, var_target_post_id rt.PhpVal, var_meta_key rt.PhpVal) {
	mut var_meta_value := rt.new_null()
	mut iter_8 := rt.call_function('get_post_meta', [var_source_post_id.clone(),
		var_meta_key.clone()]).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_meta_value_shadow := item_8.val
		rt.call_function('add_metadata', [rt.new_string('post'),
			var_target_post_id.clone(), var_meta_key.clone(),
			rt.call_function('wp_slash', [var_meta_value_shadow.clone()])])
	}
}

fn wp_post_revision_meta_keys(var_post_type rt.PhpVal) rt.PhpVal {
	mut var_registered_meta := rt.new_null()
	mut var_wp_revisioned_meta_keys := rt.new_null()
	mut var_args := rt.new_null()
	mut var_name := rt.new_null()
	var_registered_meta = rt.call_function('array_merge', [
		rt.call_function('get_registered_meta_keys', [rt.new_string('post')]),
		rt.call_function('get_registered_meta_keys', [rt.new_string('post'),
			var_post_type.clone()]),
	])
	var_wp_revisioned_meta_keys = rt.new_array()
	mut iter_9 := var_registered_meta.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_args_shadow := item_9.val
		mut var_name_shadow := item_9.key
		if rt.is_true(var_args_shadow.array_get(rt.new_string('revisions_enabled'))) {
			var_wp_revisioned_meta_keys.array_set(var_name_shadow, true)
		}
	}
	var_wp_revisioned_meta_keys = rt.func_array_keys(var_wp_revisioned_meta_keys.clone())
	return rt.call_function('apply_filters', [
		rt.new_string('wp_post_revision_meta_keys'),
		var_wp_revisioned_meta_keys.clone(),
		var_post_type.clone(),
	])
}

fn wp_check_revisioned_meta_fields_have_changed(var_post_has_changed_arg rt.PhpVal, var_last_revision rt.PhpVal, var_post rt.PhpVal) bool {
	mut var_post_has_changed := var_post_has_changed_arg
	mut var_meta_key := rt.new_null()
	mut iter_10 := wp_post_revision_meta_keys(rt.get_property(var_post, 'post_type')).iterator()
	for {
		item_10 := iter_10.next() or { break }
		mut var_meta_key_shadow := item_10.val
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_post_meta', [
			rt.get_property(var_post, 'ID'),
			var_meta_key_shadow.clone(),
		]), rt.call_function('get_post_meta', [rt.get_property(var_last_revision, 'ID'),
			var_meta_key_shadow.clone()])))))
		{
			var_post_has_changed = true
			break
		}
	}
	return var_post_has_changed
}

fn wp_delete_post_revision(var_revision_arg rt.PhpVal) rt.PhpVal {
	mut var_revision := var_revision_arg
	mut var_delete := rt.new_null()
	var_revision = wp_get_post_revision(var_revision.clone(), rt.new_null(), '')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revision)))) {
		return var_revision.clone()
	}
	var_delete = rt.call_function('wp_delete_post', [rt.get_property(var_revision, 'ID')])
	if rt.is_true(var_delete) {
		rt.call_function('do_action', [rt.new_string('wp_delete_post_revision'),
			rt.get_property(var_revision, 'ID'), var_revision.clone()])
	}
	return var_delete.clone()
}

fn wp_get_post_revisions(post i64, var_args_arg rt.PhpVal) rt.PhpVal {
	mut var_post := post
	mut var_args := var_args_arg
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_revisions := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	if !(var_post != 0) || !rt.is_true(rt.get_property(rt.new_int(var_post), 'ID')) {
		return rt.new_array()
	}
	var_defaults = {
		'order':         rt.new_string('DESC')
		'orderby':       rt.new_string('date ID')
		'check_enabled': rt.new_bool(true)
	}
	var_args = rt.call_function('wp_parse_args', [var_args.clone(),
		rt.create_array_from_native_map(var_defaults)])
	if rt.is_true(var_args.array_get(rt.new_string('check_enabled')))
		&& !(wp_revisions_enabled(var_post)) {
		return rt.new_array()
	}
	var_args = rt.call_function('array_merge', [var_args.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'post_parent', val: rt.get_property(rt.new_int(var_post), 'ID') },
			rt.ArrayItem{ key: 'post_type', val: 'revision' },
			rt.ArrayItem{ key: 'post_status', val: 'inherit' },
		])])
	var_revisions = rt.call_function('get_children', [var_args.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revisions)))) {
		return rt.new_array()
	}
	return var_revisions.clone()
}

fn wp_get_latest_revision_id_and_total_count(post i64) rt.PhpVal {
	mut var_post := post
	mut var_args := rt.new_null()
	mut var_revision_query := rt.new_null()
	mut var_revisions := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	if !(var_post != 0) {
		return create_wp_error(rt.new_string('invalid_post'), rt.call_function('__', [
			rt.new_string('Invalid post.'),
		]))
	}
	if !(wp_revisions_enabled(var_post)) {
		return create_wp_error(rt.new_string('revisions_not_enabled'), rt.call_function('__', [
			rt.new_string('Revisions not enabled.'),
		]))
	}
	var_args = rt.create_array([
		rt.ArrayItem{ key: 'post_parent', val: rt.get_property(rt.new_int(var_post), 'ID') },
		rt.ArrayItem{ key: 'fields', val: 'ids' },
		rt.ArrayItem{ key: 'post_type', val: 'revision' },
		rt.ArrayItem{ key: 'post_status', val: 'inherit' },
		rt.ArrayItem{ key: 'order', val: 'DESC' },
		rt.ArrayItem{ key: 'orderby', val: 'date ID' },
		rt.ArrayItem{ key: 'posts_per_page', val: 1 },
		rt.ArrayItem{ key: 'ignore_sticky_posts', val: true },
	])
	var_revision_query = create_wp_query()
	var_revisions = var_revision_query.query(var_args.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revisions)))) {
		return rt.create_array([rt.ArrayItem{ key: 'latest_id', val: 0 },
			rt.ArrayItem{ key: 'count', val: 0 }])
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'latest_id', val: var_revisions.array_get(rt.new_int(0)) },
		rt.ArrayItem{ key: 'count', val: rt.get_property(var_revision_query, 'found_posts') },
	])
}

fn wp_get_post_revisions_url(post i64) rt.PhpVal {
	mut var_post := post
	mut var_revisions := rt.new_null()
	var_post = (rt.call_function('get_post', [rt.new_int(var_post)])).to_i64()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(rt.new_int(var_post),
		'WP_Post'))))))
	{
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('revision'), rt.get_property(rt.new_int(var_post),
		'post_type')))
	{
		return rt.call_function('get_edit_post_link', [rt.new_int(var_post)])
	}
	if !(wp_revisions_enabled(var_post)) {
		return rt.new_null()
	}
	var_revisions =
		wp_get_latest_revision_id_and_total_count(rt.get_property(rt.new_int(var_post), 'ID'))
	if rt.is_true(rt.call_function('is_wp_error', [var_revisions.clone()]))
		|| rt.is_true(rt.identical(rt.new_int(0), var_revisions.array_get(rt.new_string('count')))) {
		return rt.new_null()
	}
	return rt.call_function('get_edit_post_link', [
		var_revisions.array_get(rt.new_string('latest_id')),
	])
}

fn wp_revisions_enabled(var_post rt.PhpVal) bool {
	return rt.new_bool(wp_revisions_to_keep(var_post.clone()) != 0)
}

fn wp_revisions_to_keep(var_post rt.PhpVal) i64 {
	mut var_num := rt.new_null()
	var_num = rt.get_constant('WP_POST_REVISIONS')
	if rt.is_true(rt.identical(rt.new_bool(true), var_num)) {
		var_num = rt.new_int(-1)
	} else {
		var_num = rt.new_int(var_num.to_i64())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [
		rt.get_property(var_post, 'post_type'),
		rt.new_string('revisions'),
	])))))
	{
		var_num = rt.new_int(0)
	}
	var_num = rt.call_function('apply_filters', [rt.new_string('wp_revisions_to_keep'),
		var_num.clone(), var_post.clone()])
	var_num = rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('wp_'), rt.get_property(var_post, 'post_type')),
			rt.new_string('_revisions_to_keep')),
		var_num.clone(),
		var_post.clone(),
	])
	return rt.new_int(var_num.to_i64())
}

fn _set_preview(var_post rt.PhpVal) rt.PhpVal {
	mut var_preview := rt.new_null()
	if !(var_post.clone().is_object()) {
		return var_post.clone()
	}
	var_preview = rt.new_bool(wp_get_post_autosave(rt.get_property(var_post, 'ID'), 0))
	if rt.is_true(rt.new_bool(var_preview.clone().is_object())) {
		var_preview = rt.call_function('sanitize_post', [var_preview.clone()])
		rt.set_property(var_post, 'post_content', rt.get_property(var_preview, 'post_content'))
		rt.set_property(var_post, 'post_title', rt.get_property(var_preview, 'post_title'))
		rt.set_property(var_post, 'post_excerpt', rt.get_property(var_preview, 'post_excerpt'))
	}
	rt.call_function('add_filter', [rt.new_string('get_the_terms'),
		rt.new_string('_wp_preview_terms_filter'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('get_post_metadata'),
		rt.new_string('_wp_preview_post_thumbnail_filter'), rt.new_int(10),
		rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('get_post_metadata'),
		rt.new_string('_wp_preview_meta_filter'), rt.new_int(10),
		rt.new_int(4)])
	return var_post.clone()
}

fn _show_post_preview() {
	mut var_id := rt.new_null()
	if rt.get_superglobal('_GET').array_isset(rt.new_string('preview_id'))
		&& rt.get_superglobal('_GET').array_isset(rt.new_string('preview_nonce')) {
		var_id =
			rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('preview_id'))).to_i64())
		if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('wp_verify_nonce', [
			rt.get_superglobal('_GET').array_get(rt.new_string('preview_nonce')),
			rt.new_string('post_preview_' + var_id.str()),
		])))
		{
			rt.call_function('wp_die', [
				rt.call_function('__', [
					rt.new_string('Sorry, you are not allowed to preview drafts.'),
				]),
				rt.new_int(403),
			])
		}
		rt.call_function('add_filter', [rt.new_string('the_preview'),
			rt.new_string('_set_preview')])
	}
}

fn _wp_preview_terms_filter(var_terms_arg rt.PhpVal, var_post_id rt.PhpVal, var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_terms := var_terms_arg
	mut var_post := rt.new_null()
	mut var_term := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return var_terms.clone()
	}
	if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_format')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_post, 'ID'), var_post_id))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post_format'), var_taxonomy))))
		|| rt.is_true(rt.identical(rt.new_string('revision'), rt.get_property(var_post, 'post_type'))) {
		return var_terms.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('standard'),
		rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_format'))))
	{
		var_terms = rt.new_array()
	} else {
		var_term = rt.call_function('get_term_by', [rt.new_string('slug'),
			rt.new_string('post-format-' +(rt.call_function('sanitize_key', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_format'))])).str()),
			rt.new_string('post_format')])
		if rt.is_true(var_term) {
			var_terms = [var_term]
		}
	}
	return var_terms.clone()
}

fn _wp_preview_post_thumbnail_filter(var_value rt.PhpVal, var_post_id rt.PhpVal, var_meta_key rt.PhpVal) string {
	mut var_post := rt.new_null()
	mut var_thumbnail_id := rt.new_null()
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return var_value.str()
	}
	if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('_thumbnail_id')))
		|| !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('preview_id')))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_post, 'ID'), var_post_id))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_post_id, rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('preview_id'))).to_i64())))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('_thumbnail_id'), var_meta_key))))
		|| rt.is_true(rt.identical(rt.new_string('revision'), rt.get_property(var_post, 'post_type'))) {
		return var_value.str()
	}
	var_thumbnail_id =
		rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('_thumbnail_id'))).to_i64())
	if rt.is_true(rt.less_equal(var_thumbnail_id, rt.new_int(0))) {
		return ''
	}
	return var_thumbnail_id.str()
}

fn _wp_get_post_revision_version(var_revision_arg rt.PhpVal) rt.PhpVal {
	mut var_revision := var_revision_arg
	mut var_matches := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(var_revision.clone().is_object())) {
		var_revision = rt.call_function('get_object_vars', [var_revision.clone()])
	} else if !(var_revision.clone().is_array()) {
		return rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('preg_match', [
		rt.new_string('/^\\d+-(?:autosave|revision)-v(\\d+)$/'),
		var_revision.array_get(rt.new_string('post_name')),
		rt.create_array_from_list(var_matches),
	]))
	{
		return rt.new_int((var_matches[1]).to_i64())
	}
	return rt.new_int(0)
}

fn _wp_upgrade_revisions_of_post(var_post rt.PhpVal, var_revisions rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_lock := ''
	mut var_now := rt.new_null()
	mut var_result := rt.new_null()
	mut var_locked := rt.new_null()
	mut var_add_last := false
	mut var_this_revision := rt.new_null()
	mut var_prev_revision := rt.new_null()
	mut var_this_revision_version := rt.new_null()
	mut var_update := rt.new_null()
	mut var_prev_revision_version := rt.new_null()
	var_lock = rt.concat(rt.new_string('revision-upgrade-'), rt.get_property(var_post, 'ID'))
	var_now = rt.call_function('time', []rt.PhpVal{})
	var_result = rt.call_method(var_wpdb, 'query', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('INSERT IGNORE INTO `'), rt.get_property(var_wpdb,
				'options')),
				rt.new_string("` (`option_name`, `option_value`, `autoload`) VALUES (%s, %s, 'off') /* LOCK */")),
			rt.new_string(var_lock.str()).clone(),
			var_now.clone(),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		var_locked = rt.call_function('get_option', [rt.new_string(var_lock.str()).clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_locked)))) {
			return false
		}
		if rt.is_true(rt.greater(var_locked, rt.sub(var_now, rt.get_constant('HOUR_IN_SECONDS')))) {
			return false
		}
	}
	rt.call_function('update_option', [rt.new_string(var_lock.str()).clone(),
		var_now.clone()])
	rt.call_function('reset', [var_revisions.clone()])
	var_add_last = true
	for {
		var_this_revision = rt.call_function('current', [var_revisions.clone()])
		var_prev_revision = rt.call_function('next', [var_revisions.clone()])
		var_this_revision_version = _wp_get_post_revision_version(var_this_revision.clone())
		if rt.is_true(rt.identical(rt.new_bool(false), var_this_revision_version)) {
			continue
		}
		if rt.is_true(rt.less(rt.new_int(0), var_this_revision_version)) {
			var_add_last = false
			continue
		}
		var_update = rt.create_array([
			rt.ArrayItem{ key: 'post_name', val: rt.call_function('preg_replace', [
				rt.new_string('/^(\\d+-(?:autosave|revision))[\\d-]*$/'),
				rt.new_string('$1-v1'),
				rt.get_property(var_this_revision, 'post_name'),
			]) },
		])
		if rt.is_true(var_prev_revision) {
			var_prev_revision_version = _wp_get_post_revision_version(var_prev_revision.clone())
			if rt.is_true(rt.less(var_prev_revision_version, rt.new_int(1))) {
				var_update.array_set('post_author', rt.get_property(var_prev_revision,
					'post_author'))
			}
		}
		var_result = rt.call_method(var_wpdb, 'update', [
			rt.get_property(var_wpdb, 'posts'),
			var_update.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'ID', val: rt.get_property(var_this_revision, 'ID') },
			]),
		])
		if rt.is_true(var_result) {
			rt.call_function('wp_cache_delete', [
				rt.get_property(var_this_revision, 'ID'),
				rt.new_string('posts'),
			])
		}
		if !(rt.is_true(var_prev_revision)) {
			break
		}
	}
	rt.call_function('delete_option', [rt.new_string(var_lock.str()).clone()])
	if var_add_last {
		wp_save_post_revision(rt.get_property(var_post, 'ID'))
	}
	return true
}

fn _wp_preview_meta_filter(var_value rt.PhpVal, var_object_id rt.PhpVal, var_meta_key rt.PhpVal, var_single rt.PhpVal) rt.PhpVal {
	mut var_post := rt.new_null()
	mut var_preview := false
	var_post = rt.call_function('get_post', []rt.PhpVal{})
	if !rt.is_true(var_post)
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_post, 'ID'), var_object_id))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_meta_key.clone(), wp_post_revision_meta_keys(rt.get_property(var_post, 'post_type')), rt.new_bool(true)])))))
		|| rt.is_true(rt.identical(rt.new_string('revision'), rt.get_property(var_post, 'post_type'))) {
		return var_value.clone()
	}
	var_preview = wp_get_post_autosave(rt.get_property(var_post, 'ID'))
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_preview))) {
		return var_value.clone()
	}
	return rt.call_function('get_post_meta', [
		rt.get_property(rt.new_bool(var_preview), 'ID'),
		var_meta_key.clone(),
		var_single.clone(),
	])
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
