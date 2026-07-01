import rt

fn block_core_latest_posts_get_excerpt_length() rt.PhpVal {
	mut var_block_core_latest_posts_excerpt_length := i64(0)
	// unsupported statement: Stmt_Global
	return rt.new_int(var_block_core_latest_posts_excerpt_length)
}

fn render_block_core_latest_posts(var_attributes rt.PhpVal) rt.PhpVal {
	// unsupported statement: Stmt_Global
	mut var_args := { 'posts_per_page': var_attributes['postsToShow'], 'post_status': rt.new_string('publish'), 'order': var_attributes['order'], 'orderby': var_attributes['orderBy'], 'ignore_sticky_posts': rt.new_bool(true), 'no_found_rows': rt.new_bool(true) }
	mut var_block_core_latest_posts_excerpt_length := (var_attributes['excerptLength']).to_i64()
	rt.call_function('add_filter', [rt.new_string('excerpt_length'), rt.new_string('block_core_latest_posts_get_excerpt_length'), rt.new_int(20)])
	if !(!rt.is_true(var_attributes.array_get('categories'))) {
		var_args['category__in'] = rt.call_function('array_column', [var_attributes.array_get('categories'), rt.new_string('id')])
	}
	if var_attributes.array_isset(rt.new_string('selectedAuthor')) {
		var_args['author'] = var_attributes.array_get('selectedAuthor')
	}
	mut var_query := create_wp_query()
	mut var_recent_posts := var_query.query(var_args.dup())
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('displayFeaturedImage')) && rt.is_true(var_attributes.array_get('displayFeaturedImage')))) {
		rt.call_function('update_post_thumbnail_cache', [var_query])
	}
	mut var_list_items_markup := ''
	{
		mut iter_1 := var_recent_posts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post := item_1.val
			mut var_post_link := rt.call_function('esc_url', [rt.call_function('get_permalink', [var_post.dup()])])
			mut var_title := rt.call_function('get_the_title', [var_post.dup()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_title)))) {
				var_title = rt.call_function('__', [rt.new_string('(no title)')])
			}
			// unsupported expression: Expr_AssignOp_Concat
			if rt.is_true(rt.new_bool(rt.is_true(var_attributes.array_get('displayFeaturedImage')) && rt.is_true(rt.call_function('has_post_thumbnail', [var_post.dup()])))) {
				mut var_image_style := ''
				if var_attributes.array_isset(rt.new_string('featuredImageSizeWidth')) {
					// unsupported expression: Expr_AssignOp_Concat
				}
				if var_attributes.array_isset(rt.new_string('featuredImageSizeHeight')) {
					// unsupported expression: Expr_AssignOp_Concat
				}
				mut var_image_classes := 'wp-block-latest-posts__featured-image'
				if var_attributes.array_isset(rt.new_string('featuredImageAlign')) {
					// unsupported expression: Expr_AssignOp_Concat
				}
				mut var_featured_image := rt.call_function('get_the_post_thumbnail', [var_post.dup(), var_attributes.array_get('featuredImageSizeSlug'), rt.create_array([rt.ArrayItem{ key: 'style', val: rt.call_function('esc_attr', [rt.new_string(var_image_style).dup()]) }])])
				if rt.is_true(var_attributes.array_get('addLinkToFeaturedImage')) {
					var_featured_image = rt.call_function('sprintf', [rt.new_string('<a href="%1$s" aria-label="%2$s">%3$s</a>'), rt.call_function('esc_url', [var_post_link.dup()]), rt.call_function('esc_attr', [var_title.dup()]), var_featured_image.dup()])
				}
				// unsupported expression: Expr_AssignOp_Concat
			}
			// unsupported expression: Expr_AssignOp_Concat
			if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('displayAuthor')) && rt.is_true(var_attributes.array_get('displayAuthor')))) {
				mut var_author_display_name := rt.call_function('get_the_author_meta', [rt.new_string('display_name'), rt.get_property(var_post, 'post_author')])
				mut var_byline := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('by %s')]), var_author_display_name.dup()])
				if !(!rt.is_true(var_author_display_name)) {
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
			if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('displayPostDate')) && rt.is_true(var_attributes.array_get('displayPostDate')))) {
				// unsupported expression: Expr_AssignOp_Concat
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('displayPostContent')) && rt.is_true(var_attributes.array_get('displayPostContent')))) && var_attributes.array_isset(rt.new_string('displayPostContentRadio')))) && rt.is_true(rt.identical(rt.new_string('excerpt'), var_attributes.array_get('displayPostContentRadio'))))) {
				mut var_trimmed_excerpt := rt.call_function('get_the_excerpt', [var_post.dup()])
				if rt.is_true(rt.call_function('str_ends_with', [var_trimmed_excerpt.dup(), rt.new_string(' [&hellip;]')])) {
					mut var_excerpt_length := // unsupported expression: Expr_Cast_Int
					if rt.is_true(rt.less_equal(var_excerpt_length, rt.new_int(var_block_core_latest_posts_excerpt_length))) {
						var_trimmed_excerpt = rt.call_function('substr', [var_trimmed_excerpt.dup(), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])
						// unsupported expression: Expr_AssignOp_Concat
					}
				}
				if rt.is_true(rt.call_function('post_password_required', [var_post.dup()])) {
					var_trimmed_excerpt = rt.call_function('__', [rt.new_string('This content is password protected.')])
				}
				// unsupported expression: Expr_AssignOp_Concat
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('displayPostContent')) && rt.is_true(var_attributes.array_get('displayPostContent')))) && var_attributes.array_isset(rt.new_string('displayPostContentRadio')))) && rt.is_true(rt.identical(rt.new_string('full_post'), var_attributes.array_get('displayPostContentRadio'))))) {
				mut var_post_content := rt.call_function('html_entity_decode', [rt.get_property(var_post, 'post_content'), rt.get_constant('ENT_QUOTES'), rt.call_function('get_option', [rt.new_string('blog_charset')])])
				if rt.is_true(rt.call_function('post_password_required', [var_post.dup()])) {
					var_post_content = rt.call_function('__', [rt.new_string('This content is password protected.')])
				}
				// unsupported expression: Expr_AssignOp_Concat
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	rt.call_function('remove_filter', [rt.new_string('excerpt_length'), rt.new_string('block_core_latest_posts_get_excerpt_length'), rt.new_int(20)])
	mut var_classes := ['wp-block-latest-posts__list']
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('postLayout')) && rt.is_true(rt.identical(rt.new_string('grid'), var_attributes.array_get('postLayout'))))) {
		var_classes << 'is-grid'
	}
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('columns')) && rt.is_true(rt.identical(rt.new_string('grid'), var_attributes.array_get('postLayout'))))) {
		var_classes << 'columns-' + (var_attributes.array_get('columns')).str()
	}
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('displayPostDate')) && rt.is_true(var_attributes.array_get('displayPostDate')))) {
		var_classes << 'has-dates'
	}
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('displayAuthor')) && rt.is_true(var_attributes.array_get('displayAuthor')))) {
		var_classes << 'has-author'
	}
	if var_attributes.array_get('style').array_get('elements').array_get('link').array_get('color').array_isset(rt.new_string('text')) {
		var_classes << 'has-link-color'
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [rt.new_string(' '), var_classes.dup()]) }])])
	return rt.call_function('sprintf', [rt.new_string('<ul %1$s>%2$s</ul>'), var_wrapper_attributes.dup(), rt.new_string(var_list_items_markup).dup()])
}

fn register_block_core_latest_posts() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/latest-posts', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_latest_posts' }])])
}

fn block_core_latest_posts_migrate_categories(var_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('core/latest-posts'), var_block.array_get('blockName'))) && !(!rt.is_true(var_block.array_get('attrs').array_get('categories'))))) && rt.is_true(rt.new_bool(var_block.array_get('attrs').array_get('categories').is_string())))) {
		var_block.array_get_mut('attrs').array_set('categories', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_function('absint', [var_block.array_get('attrs').array_get('categories')]) }]) }]))
	}
	return var_block.dup()
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




pub fn init_wp_includes_blocks_latest_posts_php() {
	// unsupported statement: Stmt_Global
	mut var_block_core_latest_posts_excerpt_length := 0
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_latest_posts')])
	rt.call_function('add_filter', [rt.new_string('render_block_data'), rt.new_string('block_core_latest_posts_migrate_categories')])
}
