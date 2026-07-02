import rt

fn get_categories(args string) rt.PhpVal {
	mut var_args := args
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_categories := rt.new_null()
	mut var_k := rt.new_null()
	var_defaults = {
		'taxonomy': 'category'
	}
	var_args = (rt.call_function('wp_parse_args', [rt.new_string(var_args.str()),
		rt.create_array_from_native_map(var_defaults)])).str()
	rt.new_string(var_args.str()).array_set('taxonomy', rt.call_function('apply_filters', [
		rt.new_string('get_categories_taxonomy'),
		rt.new_string(var_args.str()).array_get(rt.new_string('taxonomy')),
		rt.new_string(var_args.str()),
	]))
	if rt.new_string(var_args.str()).array_isset(rt.new_string('type'))
		&& rt.is_true(rt.identical(rt.new_string('link'), rt.new_string(var_args.str()).array_get(rt.new_string('type')))) {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN),
			rt.new_string('3.0.0'),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('%1$s is deprecated. Use %2$s instead.'),
				]),
				rt.new_string('<code>type => link</code>'),
				rt.new_string('<code>taxonomy => link_category</code>'),
			])])
		rt.new_string(var_args.str()).array_set('taxonomy', 'link_category')
	}
	var_categories = rt.call_function('get_terms', [rt.new_string(var_args.str())])
	if rt.is_true(rt.call_function('is_wp_error', [var_categories.clone()])) {
		var_categories = rt.new_array()
	} else {
		var_categories = rt.cast_array(var_categories)
		mut iter_1 := rt.func_array_keys(var_categories.clone()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_k_shadow := item_1.val
			_make_cat_compat(var_categories.array_get(var_k_shadow))
		}
	}
	return var_categories.clone()
}

fn get_category(var_category_arg rt.PhpVal, var_output rt.PhpVal, filter string) rt.PhpVal {
	mut var_filter := filter
	mut var_category := var_category_arg
	var_category = rt.call_function('get_term', [var_category.clone(),
		rt.new_string('category'), var_output.clone(), rt.new_string(filter)])
	if rt.is_true(rt.call_function('is_wp_error', [var_category.clone()])) {
		return var_category.clone()
	}
	_make_cat_compat(var_category.clone())
	return var_category.clone()
}

fn get_category_by_path(var_category_path_arg rt.PhpVal, full_match bool, var_output rt.PhpVal) rt.PhpVal {
	mut var_full_match := full_match
	mut var_category_path := var_category_path_arg
	mut var_category_paths := rt.new_null()
	mut var_leaf_path := rt.new_null()
	mut var_full_path := ''
	mut var_pathdir := rt.new_null()
	mut var_categories := rt.new_null()
	mut var_category := rt.new_null()
	mut var_path := rt.new_null()
	mut var_curcategory := rt.new_null()
	var_category_path = rt.call_function('rawurlencode', [
		rt.call_function('urldecode', [var_category_path.clone()]),
	])
	var_category_path = rt.call_function('str_replace', [rt.new_string('%2F'),
		rt.new_string('/'), var_category_path.clone()])
	var_category_path = rt.call_function('str_replace', [rt.new_string('%20'),
		rt.new_string(' '), var_category_path.clone()])
	var_category_paths = rt.new_string('/' + var_category_path.clone().to_string().trim_space())
	var_leaf_path = rt.call_function('sanitize_title', [
		rt.call_function('basename', [var_category_paths.clone()]),
	])
	var_category_paths = rt.call_function('explode', [rt.new_string('/'),
		var_category_paths.clone()])
	var_full_path = ''
	mut iter_2 := rt.cast_array(var_category_paths).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_pathdir_shadow := item_2.val
		var_full_path = var_full_path +
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_pathdir_shadow)))) { '/' } else { '' } +
			(rt.call_function('sanitize_title', [var_pathdir_shadow.clone()])).str()
	}
	var_categories = rt.call_function('get_terms', [
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'category' },
			rt.ArrayItem{ key: 'get', val: 'all' }, rt.ArrayItem{ key: 'slug', val: var_leaf_path }]),
	])
	if !rt.is_true(var_categories) {
		return rt.new_null()
	}
	mut iter_3 := var_categories.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_category_shadow := item_3.val
		var_path = rt.new_string('/' + var_leaf_path.str())
		var_curcategory = var_category_shadow.clone()
		for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_curcategory, 'parent')))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_curcategory, 'parent'), rt.get_property(var_curcategory, 'term_id'))))) {
			var_curcategory = rt.call_function('get_term', [
				rt.get_property(var_curcategory, 'parent'),
				rt.new_string('category'),
			])
			if rt.is_true(rt.call_function('is_wp_error', [var_curcategory.clone()])) {
				return var_curcategory.clone()
			}
			var_path = rt.new_string('/' + (rt.get_property(var_curcategory, 'slug')).str() +
				var_path.str())
		}
		if rt.is_true(rt.identical(var_path, rt.new_string(var_full_path.str()))) {
			var_category_shadow = rt.call_function('get_term', [
				rt.get_property(var_category_shadow, 'term_id'),
				rt.new_string('category'),
				var_output.clone(),
			])
			_make_cat_compat(var_category_shadow.clone())
			return var_category_shadow.clone()
		}
	}
	if !var_full_match {
		var_category = rt.call_function('get_term', [
			rt.get_property(rt.call_function('reset', [var_categories.clone()]), 'term_id'),
			rt.new_string('category'),
			var_output.clone(),
		])
		_make_cat_compat(var_category.clone())
		return var_category.clone()
	}
	return rt.new_null()
}

fn get_category_by_slug(var_slug rt.PhpVal) rt.PhpVal {
	mut var_category := rt.new_null()
	var_category = rt.call_function('get_term_by', [rt.new_string('slug'),
		var_slug.clone(), rt.new_string('category')])
	if rt.is_true(var_category) {
		_make_cat_compat(var_category.clone())
	}
	return var_category.clone()
}

fn get_cat_id(var_cat_name rt.PhpVal) i64 {
	mut var_cat := rt.new_null()
	var_cat = rt.call_function('get_term_by', [rt.new_string('name'),
		var_cat_name.clone(), rt.new_string('category')])
	if rt.is_true(var_cat) {
		return (rt.get_property(var_cat, 'term_id')).to_i64()
	}
	return 0
}

fn get_cat_name(var_cat_id_arg rt.PhpVal) string {
	mut var_cat_id := var_cat_id_arg
	mut var_category := rt.new_null()
	var_cat_id = rt.new_int(var_cat_id.to_i64())
	var_category = rt.call_function('get_term', [var_cat_id.clone(),
		rt.new_string('category')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_category))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_category.clone()])) {
		return ''
	}
	return (rt.get_property(var_category, 'name')).str()
}

fn cat_is_ancestor_of(var_cat1 rt.PhpVal, var_cat2 rt.PhpVal) rt.PhpVal {
	return rt.call_function('term_is_ancestor_of', [var_cat1.clone(),
		var_cat2.clone(), rt.new_string('category')])
}

fn sanitize_category(var_category rt.PhpVal, context string) rt.PhpVal {
	mut var_context := context
	return rt.call_function('sanitize_term', [var_category.clone(),
		rt.new_string('category'), rt.new_string(context)])
}

fn sanitize_category_field(var_field rt.PhpVal, var_value rt.PhpVal, var_cat_id rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	return rt.call_function('sanitize_term_field', [var_field.clone(),
		var_value.clone(), var_cat_id.clone(), rt.new_string('category'),
		var_context.clone()])
}

fn get_tags(args string) rt.PhpVal {
	mut var_args := args
	mut var_defaults := map[string]rt.PhpVal{}
	mut var_tags := rt.new_null()
	var_defaults = {
		'taxonomy': 'post_tag'
	}
	var_args = (rt.call_function('wp_parse_args', [rt.new_string(var_args.str()),
		rt.create_array_from_native_map(var_defaults)])).str()
	var_tags = rt.call_function('get_terms', [rt.new_string(var_args.str())])
	if !rt.is_true(var_tags) {
		var_tags = rt.new_array()
	} else {
		var_tags = rt.call_function('apply_filters', [rt.new_string('get_tags'),
			var_tags.clone(), rt.new_string(var_args.str())])
	}
	return var_tags.clone()
}

fn get_tag(var_tag rt.PhpVal, var_output rt.PhpVal, filter string) rt.PhpVal {
	mut var_filter := filter
	return rt.call_function('get_term', [var_tag.clone(), rt.new_string('post_tag'),
		var_output.clone(), rt.new_string(filter)])
}

fn clean_category_cache(var_id rt.PhpVal) {
	rt.call_function('clean_term_cache', [var_id.clone(), rt.new_string('category')])
}

fn _make_cat_compat(var_category rt.PhpVal) {
	if var_category.clone().is_object()
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_category.clone()]))))) {
		rt.set_property(var_category, 'cat_ID', rt.get_property(var_category, 'term_id'))
		rt.set_property(var_category, 'category_count', rt.get_property(var_category, 'count'))
		rt.set_property(var_category, 'category_description', rt.get_property(var_category,
			'description'))
		rt.set_property(var_category, 'cat_name', rt.get_property(var_category, 'name'))
		rt.set_property(var_category, 'category_nicename', rt.get_property(var_category, 'slug'))
		rt.set_property(var_category, 'category_parent', rt.get_property(var_category, 'parent'))
	} else if var_category.clone().is_array() && var_category.array_isset(rt.new_string('term_id')) {
		var_category.array_get(rt.new_string('cat_ID')) =
			var_category.array_get(rt.new_string('term_id'))
		var_category.array_get(rt.new_string('category_count')) =
			var_category.array_get(rt.new_string('count'))
		var_category.array_get(rt.new_string('category_description')) =
			var_category.array_get(rt.new_string('description'))
		var_category.array_get(rt.new_string('cat_name')) =
			var_category.array_get(rt.new_string('name'))
		var_category.array_get(rt.new_string('category_nicename')) =
			var_category.array_get(rt.new_string('slug'))
		var_category.array_get(rt.new_string('category_parent')) =
			var_category.array_get(rt.new_string('parent'))
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
