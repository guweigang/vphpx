import rt

fn _wp_post_revision_fields(var_post rt.PhpVal, deprecated bool) rt.PhpVal {
	// unsupported statement: Stmt_Static
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_post.dup().is_array()))))) {
		var_post = rt.call_function('get_post', [var_post.dup(), rt.get_constant('ARRAY_A')])
	}
	if rt.is_true(rt.new_bool(var_fields.dup().is_null())) {
		mut var_fields := rt.create_array([rt.ArrayItem{ key: 'post_title', val: rt.call_function('__', [rt.new_string('Title')]) }, rt.ArrayItem{ key: 'post_content', val: rt.call_function('__', [rt.new_string('Content')]) }, rt.ArrayItem{ key: 'post_excerpt', val: rt.call_function('__', [rt.new_string('Excerpt')]) }])
	}
	var_fields = rt.call_function('apply_filters', [rt.new_string('_wp_post_revision_fields'), var_fields.dup(), var_post.dup()])
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'ID' }, rt.ArrayItem{ key: none, val: 'post_name' }, rt.ArrayItem{ key: none, val: 'post_parent' }, rt.ArrayItem{ key: none, val: 'post_date' }, rt.ArrayItem{ key: none, val: 'post_date_gmt' }, rt.ArrayItem{ key: none, val: 'post_status' }, rt.ArrayItem{ key: none, val: 'post_type' }, rt.ArrayItem{ key: none, val: 'comment_count' }, rt.ArrayItem{ key: none, val: 'post_author' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_protect := item_1.val
			var_fields.array_unset(var_protect)
		}
	}
	return var_fields.dup()
}

fn _wp_post_revision_data(var_post rt.PhpVal, autosave bool) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_post.dup().is_array()))))) {
		var_post = rt.call_function('get_post', [var_post.dup(), rt.get_constant('ARRAY_A')])
	}
	mut var_fields := _wp_post_revision_fields(var_post.dup(), false)
	mut var_revision_data := rt.new_array()
	{
		mut iter_1 := rt.call_function('array_intersect', [rt.func_array_keys(var_post.dup()), rt.func_array_keys(var_fields.dup())]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			var_revision_data.array_set(var_field, var_post.array_get(var_field))
		}
	}
	var_revision_data.array_set('post_parent', var_post.array_get('ID'))
	var_revision_data.array_set('post_status', 'inherit')
	var_revision_data.array_set('post_type', 'revision')
	var_revision_data.array_set('post_name', if var_autosave { rt.concat(var_post.array_get('ID'), rt.new_string('-autosave-v1')) } else { rt.concat(var_post.array_get('ID'), rt.new_string('-revision-v1')) })
	var_revision_data.array_set('post_date', if !(var_post.array_get('post_modified')).is_null() { var_post.array_get('post_modified') } else { rt.new_string('') })
	var_revision_data.array_set('post_date_gmt', if !(var_post.array_get('post_modified_gmt')).is_null() { var_post.array_get('post_modified_gmt') } else { rt.new_string('') })
	return var_revision_data.dup()
}

fn wp_save_post_revision_on_insert(var_post_id rt.PhpVal, var_post rt.PhpVal, var_update rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_update)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [rt.new_string('post_updated'), rt.new_string('wp_save_post_revision')]))))) {
		return rt.new_null()
	}
	wp_save_post_revision(var_post_id.dup())
}

fn wp_save_post_revision(var_post_id rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AUTOSAVE')])) && rt.is_true(rt.get_constant('DOING_AUTOSAVE')))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('doing_action', [rt.new_string('post_updated')])) && rt.is_true(rt.call_function('has_action', [rt.new_string('wp_after_insert_post'), rt.new_string('wp_save_post_revision_on_insert')])))) {
		return rt.new_null()
	}
	mut var_post := rt.call_function('get_post', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [rt.get_property(var_post, 'post_type'), rt.new_string('revisions')]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.get_property(var_post, 'post_status'))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(wp_revisions_enabled(var_post.dup()))))) {
		return rt.new_null()
	}
	mut var_revisions := wp_get_post_revisions(var_post_id.dup(), rt.new_null())
	if rt.is_true(var_revisions) {
		{
			mut iter_1 := var_revisions.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_revision := item_1.val
				if rt.is_true(rt.call_function('str_contains', [rt.get_property(var_revision, 'post_name'), rt.concat(rt.get_property(var_revision, 'post_parent'), rt.new_string('-revision'))])) {
					mut var_latest_revision := var_revision.dup()
					break
				}
			}
		}
		if rt.is_true(rt.new_bool(!(var_latest_revision).is_null() && rt.is_true(rt.call_function('apply_filters', [rt.new_string('wp_save_post_revision_check_for_changes'), rt.new_bool(true), var_latest_revision.dup(), var_post.dup()])))) {
			mut var_post_has_changed := rt.new_bool(rt.new_bool(false))
			{
				mut iter_1 := rt.func_array_keys(_wp_post_revision_fields(var_post.dup(), false)).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_field := item_1.val
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						var_post_has_changed = rt.new_bool(rt.new_bool(true))
						break
					}
				}
			}
			var_post_has_changed = // unsupported expression: Expr_Cast_Bool
			if rt.is_true(rt.new_bool(!(rt.is_true(var_post_has_changed)))) {
				return rt.new_null()
			}
		}
	}
	mut var_return := _wp_put_post_revision(var_post.dup(), false)
	mut var_revisions_to_keep := wp_revisions_to_keep(var_post.dup())
	if rt.is_true(rt.less(var_revisions_to_keep, rt.new_int(0))) {
		return var_return.dup()
	}
	var_revisions = wp_get_post_revisions(var_post_id.dup(), rt.create_array([rt.ArrayItem{ key: 'order', val: 'ASC' }]))
	var_revisions = rt.call_function('apply_filters', [rt.new_string('wp_save_post_revision_revisions_before_deletion'), var_revisions.dup(), var_post_id.dup()])
	mut var_delete := rt.sub(rt.new_int(var_revisions.dup().array_count()), var_revisions_to_keep)
	if rt.is_true(rt.less(var_delete, rt.new_int(1))) {
		return var_return.dup()
	}
	var_revisions = rt.call_function('array_slice', [var_revisions.dup(), rt.new_int(0), var_delete.dup()])
	{
		mut var_i := 0
		for {
			if !(var_revisions.array_isset(rt.new_int(var_i))) { break }
			if rt.is_true(rt.call_function('str_contains', [rt.get_property(var_revisions.array_get(var_i), 'post_name'), rt.new_string('autosave')])) {
				continue
			}
			wp_delete_post_revision(rt.get_property(var_revisions.array_get(var_i), 'ID'))
			var_i += 1
		}
	}
	return var_return.dup()
}

fn wp_get_post_autosave(var_post_id rt.PhpVal, user_id i64) bool {
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'revision' }, rt.ArrayItem{ key: 'post_status', val: 'inherit' }, rt.ArrayItem{ key: 'post_parent', val: var_post_id }, rt.ArrayItem{ key: 'name', val: (var_post_id).str() + '-autosave-v1' }, rt.ArrayItem{ key: 'posts_per_page', val: 1 }, rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'no_found_rows', val: true }])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_args.array_set('author', user_id)
	}
	mut var_query := create_wp_query(var_args.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_query.have_posts())))) {
		return false
	}
	return (rt.call_function('get_post', [rt.get_property(var_query, 'posts').array_get(0)])).to_bool()
}

fn wp_is_post_revision(var_post rt.PhpVal) bool {
	var_post = wp_get_post_revision(var_post.dup(), rt.new_null(), '')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	return (// unsupported expression: Expr_Cast_Int).to_bool()
}

fn wp_is_post_autosave(var_post rt.PhpVal) bool {
	var_post = wp_get_post_revision(var_post.dup(), rt.new_null(), '')
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	if rt.is_true(rt.call_function('str_contains', [rt.get_property(var_post, 'post_name'), rt.concat(rt.get_property(var_post, 'post_parent'), rt.new_string('-autosave'))])) {
		return (// unsupported expression: Expr_Cast_Int).to_bool()
	}
	return false
}

fn _wp_put_post_revision(var_post rt.PhpVal, autosave bool) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_post.dup().is_object())) {
		var_post = rt.call_function('get_object_vars', [var_post.dup()])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_post.dup().is_array()))))) {
		var_post = rt.call_function('get_post', [var_post.dup(), rt.get_constant('ARRAY_A')])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) || !rt.is_true(var_post.array_get('ID')))) {
		return create_wp_error(rt.new_string('invalid_post'), rt.call_function('__', [rt.new_string('Invalid post ID.')]))
	}
	if rt.is_true(rt.new_bool(var_post.array_isset(rt.new_string('post_type')) && rt.is_true(rt.identical(rt.new_string('revision'), var_post.array_get('post_type'))))) {
		return create_wp_error(rt.new_string('post_type'), rt.call_function('__', [rt.new_string('Cannot create a revision of a revision')]))
	}
	var_post = _wp_post_revision_data(var_post.dup(), autosave)
	var_post = rt.call_function('wp_slash', [var_post.dup()])
	mut var_revision_id := rt.call_function('wp_insert_post', [var_post.dup(), rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_revision_id.dup()])) {
		return var_revision_id.dup()
	}
	if rt.is_true(var_revision_id) {
		rt.call_function('do_action', [rt.new_string('_wp_put_post_revision'), var_revision_id.dup(), var_post.array_get('post_parent')])
	}
	return var_revision_id.dup()
}

fn wp_save_revisioned_meta_fields(var_revision_id rt.PhpVal, var_post_id rt.PhpVal) {
	mut var_post_type := rt.call_function('get_post_type', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type)))) {
		return rt.new_null()
	}
	{
		mut iter_1 := wp_post_revision_meta_keys(var_post_type.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta_key := item_1.val
			if rt.is_true(rt.call_function('metadata_exists', [rt.new_string('post'), var_post_id.dup(), var_meta_key.dup()])) {
				_wp_copy_post_meta(var_post_id.dup(), var_revision_id.dup(), var_meta_key.dup())
			}
		}
	}
}

fn wp_get_post_revision(var_post rt.PhpVal, var_output rt.PhpVal, filter string) rt.PhpVal {
	mut var_revision := rt.call_function('get_post', [var_post.dup(), rt.get_constant('OBJECT'), rt.new_string(filter)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revision)))) {
		return var_revision.dup()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	if rt.is_true(rt.identical(rt.get_constant('OBJECT'), var_output)) {
		return var_revision.dup()
	} else if rt.is_true(rt.identical(rt.get_constant('ARRAY_A'), var_output)) {
		mut var__revision := rt.call_function('get_object_vars', [var_revision.dup()])
		return var__revision.dup()
	} else if rt.is_true(rt.identical(rt.get_constant('ARRAY_N'), var_output)) {
		var__revision = rt.call_function('array_values', [rt.call_function('get_object_vars', [var_revision.dup()])])
		return var__revision.dup()
	}
	return var_revision.dup()
}

fn wp_restore_post_revision(var_revision rt.PhpVal, var_fields rt.PhpVal) bool {
	var_revision = wp_get_post_revision(.dup(), , '')
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		return ().to_bool()
	}
	if rt.is_true() {
	}
	
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
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




pub fn init_wp_includes_revision_php() {
}
