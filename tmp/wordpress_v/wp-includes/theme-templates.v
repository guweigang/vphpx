import rt

fn wp_set_unique_slug_on_create_template_part(var_post_id rt.PhpVal) {
	mut var_post := rt.call_function('get_post', [var_post_id.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post, 'post_name'))))) {
		rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_post_id }, rt.ArrayItem{ key: 'post_name', val: 'custom_slug_' + (rt.call_function('uniqid', []rt.PhpVal{})).str() }])])
	}
	mut var_terms := rt.call_function('get_the_terms', [var_post_id.dup(), rt.new_string('wp_theme')])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_terms.dup().is_array()))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_terms.dup().array_count()))))))) {
		rt.call_function('wp_set_post_terms', [var_post_id.dup(), rt.call_function('get_stylesheet', []rt.PhpVal{}), rt.new_string('wp_theme')])
	}
}

fn wp_filter_wp_template_unique_post_slug(var_override_slug rt.PhpVal, var_slug rt.PhpVal, var_post_id rt.PhpVal, var_post_status rt.PhpVal, var_post_type rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return var_override_slug.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_override_slug)))) {
		var_override_slug = var_slug
	}
	mut var_theme := rt.call_function('get_stylesheet', []rt.PhpVal{})
	mut var_terms := rt.call_function('get_the_terms', [var_post_id.dup(), rt.new_string('wp_theme')])
	if rt.is_true(rt.new_bool(rt.is_true(var_terms) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_terms.dup()]))))))) {
		var_theme = rt.get_property(var_terms.array_get(0), 'name')
	}
	mut var_check_query_args := { 'post_name__in': map[string]rt.PhpVal{}, 'post_type': var_post_type, 'posts_per_page': rt.new_int(1), 'no_found_rows': rt.new_bool(true), 'post__not_in': map[string]rt.PhpVal{}, 'tax_query': map[string]rt.PhpVal{} }
	mut var_check_query := create_wp_query(var_check_query_args.dup())
	mut var_posts := rt.get_property(var_check_query, 'posts')
	if var_posts.dup().array_count() > 0 {
		mut var_suffix := 2
		for {
			mut var_query_args := var_check_query_args.dup()
			mut var_alt_post_name := rt.new_string((rt.call_function('_truncate_post_slug', [var_override_slug.dup(), 200 - rt.new_int(var_suffix).dup().to_string().len + 1])).str() + "-${var_suffix.str()}")
			var_query_args.array_set('post_name__in', rt.create_array([rt.ArrayItem{ key: none, val: var_alt_post_name }]))
			mut var_query := create_wp_query(var_query_args.dup())
			var_suffix += 1
			if !(rt.get_property(var_query, 'posts').array_count() > 0) {
				break
			}
		}
		var_override_slug = var_alt_post_name.dup()
	}
	return var_override_slug.dup()
}

fn wp_enqueue_block_template_skip_link() {
	mut var__wp_current_template_content := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [rt.new_string('wp_footer'), rt.new_string('the_block_template_skip_link')]))))) {
		return rt.new_null()
	}
	rt.call_function('remove_action', [rt.new_string('wp_footer'), rt.new_string('the_block_template_skip_link')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('block-templates')]))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var__wp_current_template_content)))) {
		return rt.new_null()
	}
	rt.call_function('wp_enqueue_style', [rt.new_string('wp-block-template-skip-link')])
}

fn wp_enable_block_templates() {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) || rt.is_true(rt.call_function('wp_theme_has_theme_json', []rt.PhpVal{})))) {
		rt.call_function('add_theme_support', [rt.new_string('block-templates')])
	}
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
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




pub fn init_wp_includes_theme_templates_php() {
}
