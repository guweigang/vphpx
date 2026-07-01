import rt

fn category_exists(var_cat_name rt.PhpVal, var_category_parent rt.PhpVal) rt.PhpVal {
	mut var_id := rt.call_function('term_exists', [var_cat_name.dup(), rt.new_string('category'), var_category_parent.dup()])
	if rt.is_true(rt.new_bool(var_id.dup().is_array())) {
		var_id = var_id.array_get('term_id')
	}
	return var_id.dup()
}

fn get_category_to_edit(var_id rt.PhpVal) rt.PhpVal {
	mut var_category := rt.call_function('get_term', [var_id.dup(), rt.new_string('category'), rt.get_constant('OBJECT'), rt.new_string('edit')])
	rt.call_function('_make_cat_compat', [var_category.dup()])
	return var_category.dup()
}

fn wp_create_category(var_category_name rt.PhpVal, category_parent i64) rt.PhpVal {
	mut var_id := category_exists(var_category_name.dup(), rt.new_int(category_parent))
	if rt.is_true(var_id) {
		return // unsupported expression: Expr_Cast_Int
	}
	return rt.new_int(wp_insert_category(rt.create_array([rt.ArrayItem{ key: 'cat_name', val: var_category_name }, rt.ArrayItem{ key: 'category_parent', val: category_parent }])))
}

fn wp_create_categories(var_categories rt.PhpVal, post_id i64) rt.PhpVal {
	mut var_cat_ids := []rt.PhpVal{}
	{
		mut iter_1 := var_categories.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_category := item_1.val
			mut var_id := category_exists(var_category.dup(), rt.new_null())
			if rt.is_true(var_id) {
				var_cat_ids << var_id.dup()
			} else {
				var_id = wp_create_category(var_category.dup(), 0)
				if rt.is_true(var_id) {
					var_cat_ids << var_id.dup()
				}
			}
		}
	}
	if var_post_id != 0 {
		rt.call_function('wp_set_post_categories', [rt.new_int(post_id), var_cat_ids.dup()])
	}
	return var_cat_ids.dup()
}

fn wp_insert_category(var_catarr rt.PhpVal, wp_error bool) i64 {
	mut var_cat_defaults := { 'cat_ID': rt.new_int(0), 'taxonomy': rt.new_string('category'), 'cat_name': rt.new_string(''), 'category_description': rt.new_string(''), 'category_nicename': rt.new_string(''), 'category_parent': rt.new_string('') }
	var_catarr = rt.call_function('wp_parse_args', [var_catarr.dup(), var_cat_defaults.dup()])
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_catarr.array_get('cat_name').to_string().trim_space()))) {
		if !(var_wp_error) {
			return 0
		} else {
			return (create_wp_error(rt.new_string('cat_name'), rt.call_function('__', [rt.new_string('You did not enter a category name.')]))).to_i64()
		}
	}
	var_catarr.array_set('cat_ID', // unsupported expression: Expr_Cast_Int)
	mut var_update := !(!rt.is_true(var_catarr.array_get('cat_ID')))
	mut var_name := var_catarr.array_get('cat_name')
	mut var_description := var_catarr.array_get('category_description')
	mut var_slug := var_catarr.array_get('category_nicename')
	mut var_parent := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.less(var_parent, rt.new_int(0))) {
		var_parent = rt.new_int(rt.new_int(0))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_parent) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('term_exists', [var_parent.dup(), var_catarr.array_get('taxonomy')]))))))) || rt.is_true(rt.new_bool(rt.is_true(var_catarr.array_get('cat_ID')) && rt.is_true(rt.call_function('term_is_ancestor_of', [var_catarr.array_get('cat_ID'), var_parent.dup(), var_catarr.array_get('taxonomy')])))))) {
		var_parent = rt.new_int(rt.new_int(0))
	}
	mut var_args := rt.call_function('compact', [rt.new_string('name'), rt.new_string('slug'), rt.new_string('parent'), rt.new_string('description')])
	if var_update {
		var_catarr.array_set('cat_ID', rt.call_function('wp_update_term', [var_catarr.array_get('cat_ID'), var_catarr.array_get('taxonomy'), var_args.dup()]))
	} else {
		var_catarr.array_set('cat_ID', rt.call_function('wp_insert_term', [var_catarr.array_get('cat_name'), var_catarr.array_get('taxonomy'), var_args.dup()]))
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_catarr.array_get('cat_ID')])) {
		if var_wp_error {
			return (var_catarr.array_get('cat_ID')).to_i64()
		} else {
			return 0
		}
	}
	return (var_catarr.array_get('cat_ID').array_get('term_id')).to_i64()
}

fn wp_update_category(var_catarr rt.PhpVal) rt.PhpVal {
	mut var_cat_id := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(var_catarr.array_isset(rt.new_string('category_parent')) && rt.is_true(rt.identical(var_cat_id, // unsupported expression: Expr_Cast_Int)))) {
		return rt.new_bool(false)
	}
	mut var_category := rt.call_function('get_term', [var_cat_id.dup(), rt.new_string('category'), rt.get_constant('ARRAY_A')])
	rt.call_function('_make_cat_compat', [var_category.dup()])
	var_category = rt.call_function('wp_slash', [var_category.dup()])
	var_catarr = rt.call_function('array_merge', [var_category.dup(), var_catarr.dup()])
	return rt.new_int(wp_insert_category(var_catarr.dup()))
}

fn tag_exists(var_tag_name rt.PhpVal) rt.PhpVal {
	return rt.call_function('term_exists', [var_tag_name.dup(), rt.new_string('post_tag')])
}

fn wp_create_tag(var_tag_name rt.PhpVal) rt.PhpVal {
	return wp_create_term(var_tag_name.dup(), 'post_tag')
}

fn get_tags_to_edit(var_post_id rt.PhpVal, taxonomy string) rt.PhpVal {
	return rt.new_bool(get_terms_to_edit(var_post_id.dup(), taxonomy))
}

fn get_terms_to_edit(var_post_id rt.PhpVal, taxonomy string) bool {
	var_post_id = // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return false
	}
	mut var_terms := rt.call_function('get_object_term_cache', [var_post_id.dup(), rt.new_string(taxonomy)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_terms)) {
		var_terms = rt.call_function('wp_get_object_terms', [var_post_id.dup(), rt.new_string(taxonomy)])
		rt.call_function('wp_cache_add', [var_post_id.dup(), rt.call_function('wp_list_pluck', [var_terms.dup(), rt.new_string('term_id')]), taxonomy + '_relationships'])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_terms)))) {
		return false
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_terms.dup()])) {
		return (var_terms).to_bool()
	}
	mut var_term_names := []rt.PhpVal{}
	{
		mut iter_1 := var_terms.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			var_term_names << rt.get_property(var_term, 'name')
		}
	}
	mut var_terms_to_edit := rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(','), var_term_names.dup()])])
	var_terms_to_edit = rt.call_function('apply_filters', [rt.new_string('terms_to_edit'), var_terms_to_edit.dup(), rt.new_string(taxonomy)])
	return (var_terms_to_edit).to_bool()
}

fn wp_create_term(var_tag_name rt.PhpVal, taxonomy string) rt.PhpVal {
	mut var_id := rt.call_function('term_exists', [var_tag_name.dup(), rt.new_string(taxonomy)])
	if rt.is_true(var_id) {
		return var_id.dup()
	}
	return rt.call_function('wp_insert_term', [var_tag_name.dup(), rt.new_string(taxonomy)])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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




pub fn init_wp_admin_includes_taxonomy_php() {
}
