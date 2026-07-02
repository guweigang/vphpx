import rt

fn category_exists(var_cat_name rt.PhpVal, var_category_parent rt.PhpVal) rt.PhpVal {
	mut var_id := rt.new_null()
	var_id = rt.call_function('term_exists', [var_cat_name.clone(), rt.new_string('category'), var_category_parent.clone()])
	if rt.is_true(rt.new_bool(var_id.clone().is_array())) {
	var_id = var_id.array_get(rt.new_string('term_id'))
	}
	return var_id.clone()
}

fn get_category_to_edit(var_id rt.PhpVal) rt.PhpVal {
	mut var_category := rt.new_null()
	var_category = rt.call_function('get_term', [var_id.clone(), rt.new_string('category'), rt.get_constant('OBJECT'), rt.new_string('edit')])
	rt.call_function('_make_cat_compat', [var_category.clone()])
	return var_category.clone()
}

fn wp_create_category(var_category_name rt.PhpVal, category_parent i64) i64 {
	mut var_category_parent := category_parent
	mut var_id := rt.new_null()
	var_id = category_exists(var_category_name.clone(), rt.new_int(category_parent))
	if rt.is_true(var_id) {
		return rt.new_int((var_id).to_i64())
	}
	return wp_insert_category(rt.create_array([rt.ArrayItem{ key: 'cat_name', val: var_category_name }, rt.ArrayItem{ key: 'category_parent', val: category_parent }]))
}

fn wp_create_categories(var_categories rt.PhpVal, post_id i64) rt.PhpVal {
	mut var_post_id := post_id
	mut var_cat_ids := []rt.PhpVal{}
	mut var_category := rt.new_null()
	mut var_id := rt.new_null()
	var_cat_ids = []rt.PhpVal{}
	mut iter_1 := var_categories.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_category_shadow := item_1.val
		var_id = category_exists(var_category_shadow.clone(), rt.new_null())
		if rt.is_true(var_id) {
			var_cat_ids << var_id.clone()
		} else {
			var_id = rt.new_int(wp_create_category(var_category_shadow.clone(), 0))
			if rt.is_true(var_id) {
				var_cat_ids << var_id.clone()
			}
		}
	}
	if var_post_id != 0 {
		rt.call_function('wp_set_post_categories', [rt.new_int(post_id), rt.create_array_from_list(var_cat_ids)])
	}
	return var_cat_ids.clone()
}

fn wp_insert_category(var_catarr_arg rt.PhpVal, wp_error bool) i64 {
	mut var_wp_error := wp_error
	mut var_catarr := var_catarr_arg
	mut var_cat_defaults := map[string]rt.PhpVal{}
	mut var_update := false
	mut var_name := rt.new_null()
	mut var_description := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_parent := rt.new_null()
	mut var_args := rt.new_null()
	var_cat_defaults = { 'cat_ID': rt.new_int(0), 'taxonomy': rt.new_string('category'), 'cat_name': rt.new_string(''), 'category_description': rt.new_string(''), 'category_nicename': rt.new_string(''), 'category_parent': rt.new_string('') }
	var_catarr = rt.call_function('wp_parse_args', [var_catarr.clone(), rt.create_array_from_native_map(var_cat_defaults)])
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_catarr.array_get(rt.new_string('cat_name')).to_string().trim_space()))) {
		if !(var_wp_error) {
			return 0
		} else {
			return (create_wp_error(rt.new_string('cat_name'), rt.call_function('__', [rt.new_string('You did not enter a category name.')]))).to_i64()
		}
	}
	var_catarr.array_set('cat_ID', rt.new_int((var_catarr.array_get(rt.new_string('cat_ID'))).to_i64()))
	var_update = !(!rt.is_true(var_catarr.array_get(rt.new_string('cat_ID'))))
	var_name = var_catarr.array_get(rt.new_string('cat_name'))
	var_description = var_catarr.array_get(rt.new_string('category_description'))
	var_slug = var_catarr.array_get(rt.new_string('category_nicename'))
	var_parent = rt.new_int((var_catarr.array_get(rt.new_string('category_parent'))).to_i64())
	if rt.is_true(rt.less(var_parent, rt.new_int(0))) {
	var_parent = rt.new_int(0)
	}
	if !rt.is_true(var_parent) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('term_exists', [var_parent.clone(), var_catarr.array_get(rt.new_string('taxonomy'))]))))) || (rt.is_true(var_catarr.array_get(rt.new_string('cat_ID'))) && rt.is_true(rt.call_function('term_is_ancestor_of', [var_catarr.array_get(rt.new_string('cat_ID')), var_parent.clone(), var_catarr.array_get(rt.new_string('taxonomy'))]))) {
	var_parent = rt.new_int(0)
	}
	var_args = rt.call_function('compact', [rt.new_string('name'), rt.new_string('slug'), rt.new_string('parent'), rt.new_string('description')])
	if var_update {
		var_catarr.array_set('cat_ID', rt.call_function('wp_update_term', [var_catarr.array_get(rt.new_string('cat_ID')), var_catarr.array_get(rt.new_string('taxonomy')), var_args.clone()]))
	} else {
		var_catarr.array_set('cat_ID', rt.call_function('wp_insert_term', [var_catarr.array_get(rt.new_string('cat_name')), var_catarr.array_get(rt.new_string('taxonomy')), var_args.clone()]))
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_catarr.array_get(rt.new_string('cat_ID'))])) {
		if var_wp_error {
			return (var_catarr.array_get(rt.new_string('cat_ID'))).to_i64()
		} else {
			return 0
		}
	}
	return (var_catarr.array_get(rt.new_string('cat_ID')).array_get(rt.new_string('term_id'))).to_i64()
}

fn wp_update_category(var_catarr_arg rt.PhpVal) rt.PhpVal {
	mut var_catarr := var_catarr_arg
	mut var_cat_id := rt.new_null()
	mut var_category := rt.new_null()
	var_cat_id = rt.new_int((var_catarr.array_get(rt.new_string('cat_ID'))).to_i64())
	if var_catarr.array_isset(rt.new_string('category_parent')) && rt.is_true(rt.identical(var_cat_id, rt.new_int((var_catarr.array_get(rt.new_string('category_parent'))).to_i64()))) {
		return rt.new_bool(false)
	}
	var_category = rt.call_function('get_term', [var_cat_id.clone(), rt.new_string('category'), rt.get_constant('ARRAY_A')])
	rt.call_function('_make_cat_compat', [var_category.clone()])
	var_category = rt.call_function('wp_slash', [var_category.clone()])
	var_catarr = rt.call_function('array_merge', [var_category.clone(), var_catarr.clone()])
	return rt.new_int(wp_insert_category(var_catarr.clone()))
}

fn tag_exists(var_tag_name rt.PhpVal) rt.PhpVal {
	return rt.call_function('term_exists', [var_tag_name.clone(), rt.new_string('post_tag')])
}

fn wp_create_tag(var_tag_name rt.PhpVal) rt.PhpVal {
	return wp_create_term(var_tag_name.clone(), 'post_tag')
}

fn get_tags_to_edit(var_post_id rt.PhpVal, taxonomy string) rt.PhpVal {
	mut var_taxonomy := taxonomy
	return rt.new_bool(get_terms_to_edit(var_post_id.clone(), taxonomy))
}

fn get_terms_to_edit(var_post_id_arg rt.PhpVal, taxonomy string) bool {
	mut var_taxonomy := taxonomy
	mut var_post_id := var_post_id_arg
	mut var_terms := rt.new_null()
	mut var_term_names := []rt.PhpVal{}
	mut var_term := rt.new_null()
	mut var_terms_to_edit := rt.new_null()
	var_post_id = rt.new_int((var_post_id).to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return false
	}
	var_terms = rt.call_function('get_object_term_cache', [var_post_id.clone(), rt.new_string(taxonomy)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_terms)) {
		var_terms = rt.call_function('wp_get_object_terms', [var_post_id.clone(), rt.new_string(taxonomy)])
		rt.call_function('wp_cache_add', [var_post_id.clone(), rt.call_function('wp_list_pluck', [var_terms.clone(), rt.new_string('term_id')]), rt.new_string(taxonomy + '_relationships')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_terms)))) {
		return false
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_terms.clone()])) {
		return (var_terms).to_bool()
	}
	var_term_names = []rt.PhpVal{}
	mut iter_2 := var_terms.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_term_shadow := item_2.val
		var_term_names << rt.get_property(var_term_shadow, 'name')
	}
	var_terms_to_edit = rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(','), rt.create_array_from_list(var_term_names)])])
	var_terms_to_edit = rt.call_function('apply_filters', [rt.new_string('terms_to_edit'), var_terms_to_edit.clone(), rt.new_string(taxonomy)])
	return (var_terms_to_edit).to_bool()
}

fn wp_create_term(var_tag_name rt.PhpVal, taxonomy string) rt.PhpVal {
	mut var_taxonomy := taxonomy
	mut var_id := rt.new_null()
	var_id = rt.call_function('term_exists', [var_tag_name.clone(), rt.new_string(taxonomy)])
	if rt.is_true(var_id) {
		return var_id.clone()
	}
	return rt.call_function('wp_insert_term', [var_tag_name.clone(), rt.new_string(taxonomy)])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
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



fn main() {
	defer {
		rt.shutdown()
	}

}
