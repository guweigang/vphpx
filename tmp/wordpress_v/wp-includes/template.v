import rt

fn get_query_template(type string, var_templates rt.PhpVal) rt.PhpVal {
	type = (rt.call_function('preg_replace', [rt.new_string('|[^a-z0-9-]+|'), rt.new_string(''), rt.new_string(type)])).str()
	if !rt.is_true(var_templates) {
		var_templates = rt.create_array([rt.ArrayItem{ key: none, val: "${var_type}.php" }])
	}
	var_templates = rt.call_function('apply_filters', [rt.new_string("${var_type}_template_hierarchy"), var_templates.dup()])
	mut var_template := locate_template(var_templates.dup(), false, false, rt.new_null())
	var_template = rt.call_function('locate_block_template', [var_template.dup(), rt.new_string(type), var_templates.dup()])
	return rt.call_function('apply_filters', [rt.new_string("${var_type}_template"), var_template.dup(), rt.new_string(type), var_templates.dup()])
}

fn get_index_template() rt.PhpVal {
	return get_query_template('index', rt.new_null())
}

fn get_404_template() rt.PhpVal {
	return get_query_template('404', rt.new_null())
}

fn get_archive_template() rt.PhpVal {
	mut var_post_types := rt.call_function('array_filter', [rt.cast_array(rt.call_function('get_query_var', [rt.new_string('post_type')]))])
	mut var_templates := rt.new_array()
	if var_post_types.dup().array_count() == 1 {
		mut var_post_type := rt.call_function('reset', [var_post_types.dup()])
		var_templates.array_push("archive-${var_post_type.to_string()}.php")
	}
	var_templates.array_push('archive.php')
	return get_query_template('archive', var_templates.dup())
}

fn get_post_type_archive_template() string {
	mut var_post_type := rt.call_function('get_query_var', [rt.new_string('post_type')])
	if rt.is_true(rt.new_bool(var_post_type.dup().is_array())) {
		var_post_type = rt.call_function('reset', [var_post_type.dup()])
	}
	mut var_obj := rt.call_function('get_post_type_object', [var_post_type.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_obj, 'WP_Post_Type')))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_obj, 'has_archive'))))))) {
		return ''
	}
	return (get_archive_template()).str()
}

fn get_author_template() rt.PhpVal {
	mut var_author := rt.call_function('get_queried_object', []rt.PhpVal{})
	mut var_templates := rt.new_array()
	if rt.is_true(rt.new_bool(rt.instance_of(var_author, 'WP_User'))) {
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('author-'), rt.get_property(var_author, 'user_nicename')), rt.new_string('.php')))
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('author-'), rt.get_property(var_author, 'ID')), rt.new_string('.php')))
	}
	var_templates.array_push('author.php')
	return get_query_template('author', var_templates.dup())
}

fn get_category_template() rt.PhpVal {
	mut var_category := rt.call_function('get_queried_object', []rt.PhpVal{})
	mut var_templates := rt.new_array()
	if !(!rt.is_true(rt.get_property(var_category, 'slug'))) {
		mut var_slug_decoded := rt.call_function('urldecode', [rt.get_property(var_category, 'slug')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_templates.array_push("category-${var_slug_decoded.to_string()}.php")
		}
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('category-'), rt.get_property(var_category, 'slug')), rt.new_string('.php')))
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('category-'), rt.get_property(var_category, 'term_id')), rt.new_string('.php')))
	}
	var_templates.array_push('category.php')
	return get_query_template('category', var_templates.dup())
}

fn get_tag_template() rt.PhpVal {
	mut var_tag := rt.call_function('get_queried_object', []rt.PhpVal{})
	mut var_templates := rt.new_array()
	if !(!rt.is_true(rt.get_property(var_tag, 'slug'))) {
		mut var_slug_decoded := rt.call_function('urldecode', [rt.get_property(var_tag, 'slug')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_templates.array_push("tag-${var_slug_decoded.to_string()}.php")
		}
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('tag-'), rt.get_property(var_tag, 'slug')), rt.new_string('.php')))
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('tag-'), rt.get_property(var_tag, 'term_id')), rt.new_string('.php')))
	}
	var_templates.array_push('tag.php')
	return get_query_template('tag', var_templates.dup())
}

fn get_taxonomy_template() rt.PhpVal {
	mut var_term := rt.call_function('get_queried_object', []rt.PhpVal{})
	mut var_templates := rt.new_array()
	if !(!rt.is_true(rt.get_property(var_term, 'slug'))) {
		mut var_taxonomy := rt.get_property(var_term, 'taxonomy')
		mut var_slug_decoded := rt.call_function('urldecode', [rt.get_property(var_term, 'slug')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_templates.array_push("taxonomy-${var_taxonomy.to_string()}-${var_slug_decoded.to_string()}.php")
		}
		var_templates.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('taxonomy-'), var_taxonomy), rt.new_string('-')), rt.get_property(var_term, 'slug')), rt.new_string('.php')))
		var_templates.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('taxonomy-'), var_taxonomy), rt.new_string('-')), rt.get_property(var_term, 'term_id')), rt.new_string('.php')))
		var_templates.array_push("taxonomy-${var_taxonomy.to_string()}.php")
	}
	var_templates.array_push('taxonomy.php')
	return get_query_template('taxonomy', var_templates.dup())
}

fn get_date_template() rt.PhpVal {
	return get_query_template('date', rt.new_null())
}

fn get_home_template() rt.PhpVal {
	mut var_templates := rt.create_array([rt.ArrayItem{ key: none, val: 'home.php' }, rt.ArrayItem{ key: none, val: 'index.php' }])
	return get_query_template('home', var_templates.dup())
}

fn get_front_page_template() rt.PhpVal {
	mut var_templates := rt.create_array([rt.ArrayItem{ key: none, val: 'front-page.php' }])
	return get_query_template('frontpage', var_templates.dup())
}

fn get_privacy_policy_template() rt.PhpVal {
	mut var_templates := rt.create_array([rt.ArrayItem{ key: none, val: 'privacy-policy.php' }])
	return get_query_template('privacypolicy', var_templates.dup())
}

fn get_page_template() rt.PhpVal {
	mut var_id := rt.call_function('get_queried_object_id', []rt.PhpVal{})
	mut var_template := rt.call_function('get_page_template_slug', []rt.PhpVal{})
	mut var_pagename := rt.call_function('get_query_var', [rt.new_string('pagename')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_pagename)))) && rt.is_true(var_id))) {
		mut var_post := rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(var_post) {
			var_pagename = rt.get_property(var_post, 'post_name')
		}
	}
	mut var_templates := rt.new_array()
	if rt.is_true(rt.new_bool(rt.is_true(var_template) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_template.dup()]))))) {
		var_templates.array_push(var_template.dup())
	}
	if rt.is_true(var_pagename) {
		mut var_pagename_decoded := rt.call_function('urldecode', [var_pagename.dup()])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_templates.array_push("page-${var_pagename_decoded.to_string()}.php")
		}
		var_templates.array_push("page-${var_pagename.to_string()}.php")
	}
	if rt.is_true(var_id) {
		var_templates.array_push("page-${var_id.to_string()}.php")
	}
	var_templates.array_push('page.php')
	return get_query_template('page', var_templates.dup())
}

fn get_search_template() rt.PhpVal {
	return get_query_template('search', rt.new_null())
}

fn get_single_template() rt.PhpVal {
	mut var_object := rt.call_function('get_queried_object', []rt.PhpVal{})
	mut var_templates := rt.new_array()
	if !(!rt.is_true(rt.get_property(var_object, 'post_type'))) {
		mut var_template := rt.call_function('get_page_template_slug', [var_object.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(var_template) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_template.dup()]))))) {
			var_templates.array_push(var_template.dup())
		}
		mut var_name_decoded := rt.call_function('urldecode', [rt.get_property(var_object, 'post_name')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_templates.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('single-'), rt.get_property(, 'post_type')), rt.new_string('-')), var_name_decoded), rt.new_string('.php')))
		}
		var_templates.array_push(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('single-'), rt.get_property(, 'post_type')), rt.new_string('-')), rt.get_property(, 'post_name')), rt.new_string('.php')))
		var_templates.array_push(rt.concat(rt.concat(, ), ))
	}
	var_templates.array_push('single.php')
	return get_query_template('single', var_templates.dup())
}

fn get_embed_template() rt.PhpVal {
	
}



pub fn init_wp_includes_template_php() {
}
