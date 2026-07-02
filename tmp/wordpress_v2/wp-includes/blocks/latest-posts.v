import rt

var_block_core_latest_posts_excerpt_length = 0
fn block_core_latest_posts_get_excerpt_length() rt.PhpVal {
	mut var_block_core_latest_posts_excerpt_length := i64(0)
	return rt.new_int(var_block_core_latest_posts_excerpt_length)
}

fn render_block_core_latest_posts(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_args := map[string]rt.PhpVal{}
	mut var_block_core_latest_posts_excerpt_length := i64(0)
	mut var_query := rt.new_null()
	mut var_recent_posts := rt.new_null()
	mut var_list_items_markup := ''
	mut var_post := rt.new_null()
	mut var_post_link := rt.new_null()
	mut var_title := rt.new_null()
	mut var_image_style := ''
	mut var_image_classes := ''
	mut var_featured_image := rt.new_null()
	mut var_author_display_name := rt.new_null()
	mut var_byline := rt.new_null()
	mut var_trimmed_excerpt := rt.new_null()
	mut var_excerpt_length := rt.new_null()
	mut var_post_content := rt.new_null()
	mut var_classes := []rt.PhpVal{}
	mut var_wrapper_attributes := rt.new_null()
	var_args = {
		'posts_per_page':      var_attributes['postsToShow']
		'post_status':         rt.new_string('publish')
		'order':               var_attributes['order']
		'orderby':             var_attributes['orderBy']
		'ignore_sticky_posts': rt.new_bool(true)
		'no_found_rows':       rt.new_bool(true)
	}
	var_block_core_latest_posts_excerpt_length = (var_attributes['excerptLength']).to_i64()
	rt.call_function('add_filter', [rt.new_string('excerpt_length'),
		rt.new_string('block_core_latest_posts_get_excerpt_length'),
		rt.new_int(20)])
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('categories')))) {
		var_args['category__in'] = rt.call_function('array_column', [
			var_attributes.array_get(rt.new_string('categories')),
			rt.new_string('id'),
		])
	}
	if var_attributes.array_isset(rt.new_string('selectedAuthor')) {
		var_args['author'] = var_attributes.array_get(rt.new_string('selectedAuthor'))
	}
	var_query = create_wp_query()
	var_recent_posts = var_query.query(var_args.clone())
	if var_attributes.array_isset(rt.new_string('displayFeaturedImage'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('displayFeaturedImage'))) {
		rt.call_function('update_post_thumbnail_cache', [var_query])
	}
	var_list_items_markup = ''
	mut iter_1 := var_recent_posts.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_post_shadow := item_1.val
		var_post_link = rt.call_function('esc_url', [
			rt.call_function('get_permalink', [var_post_shadow.clone()]),
		])
		var_title = rt.call_function('get_the_title', [var_post_shadow.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_title)))) {
			var_title = rt.call_function('__', [rt.new_string('(no title)')])
		}
		var_list_items_markup = var_list_items_markup + '<li>'
		if rt.is_true(var_attributes.array_get(rt.new_string('displayFeaturedImage')))
			&& rt.is_true(rt.call_function('has_post_thumbnail', [var_post_shadow.clone()])) {
			var_image_style = ''
			if var_attributes.array_isset(rt.new_string('featuredImageSizeWidth')) {
				var_image_style = var_image_style +(rt.call_function('sprintf', [rt.new_string('max-width:%spx;'), var_attributes.array_get(rt.new_string('featuredImageSizeWidth'))])).str()
			}
			if var_attributes.array_isset(rt.new_string('featuredImageSizeHeight')) {
				var_image_style = var_image_style +(rt.call_function('sprintf', [rt.new_string('max-height:%spx;'), var_attributes.array_get(rt.new_string('featuredImageSizeHeight'))])).str()
			}
			var_image_classes = 'wp-block-latest-posts__featured-image'
			if var_attributes.array_isset(rt.new_string('featuredImageAlign')) {
				var_image_classes = var_image_classes + ' align' +
					(var_attributes.array_get(rt.new_string('featuredImageAlign'))).str()
			}
			var_featured_image = rt.call_function('get_the_post_thumbnail', [
				var_post_shadow.clone(), var_attributes.array_get(rt.new_string('featuredImageSizeSlug')),
				rt.create_array([
					rt.ArrayItem{ key: 'style', val: rt.call_function('esc_attr', [
						rt.new_string(var_image_style.str()).clone(),
					]) },
				])])
			if rt.is_true(var_attributes.array_get(rt.new_string('addLinkToFeaturedImage'))) {
				var_featured_image = rt.call_function('sprintf', [
					rt.new_string('<a href="%1$s" aria-label="%2$s">%3$s</a>'),
					rt.call_function('esc_url', [var_post_link.clone()]),
					rt.call_function('esc_attr', [var_title.clone()]),
					var_featured_image.clone(),
				])
			}
			var_list_items_markup = var_list_items_markup +(rt.call_function('sprintf', [rt.new_string('<div class="%1$s">%2$s</div>'), rt.call_function('esc_attr', [rt.new_string(var_image_classes.str()).clone()]), var_featured_image.clone()])).str()
		}
		var_list_items_markup = var_list_items_markup +(rt.call_function('sprintf', [rt.new_string('<a class="wp-block-latest-posts__post-title" href="%1$s">%2$s</a>'), rt.call_function('esc_url', [var_post_link.clone()]), var_title.clone()])).str()
		if var_attributes.array_isset(rt.new_string('displayAuthor'))
			&& rt.is_true(var_attributes.array_get(rt.new_string('displayAuthor'))) {
			var_author_display_name = rt.call_function('get_the_author_meta', [
				rt.new_string('display_name'),
				rt.get_property(var_post_shadow, 'post_author'),
			])
			var_byline = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('by %s')]),
				var_author_display_name.clone(),
			])
			if !(!rt.is_true(var_author_display_name)) {
				var_list_items_markup = var_list_items_markup +(rt.call_function('sprintf', [rt.new_string('<div class="wp-block-latest-posts__post-author">%1$s</div>'), var_byline.clone()])).str()
			}
		}
		if var_attributes.array_isset(rt.new_string('displayPostDate'))
			&& rt.is_true(var_attributes.array_get(rt.new_string('displayPostDate'))) {
			var_list_items_markup = var_list_items_markup +(rt.call_function('sprintf', [rt.new_string('<time datetime="%1$s" class="wp-block-latest-posts__post-date">%2$s</time>'), rt.call_function('esc_attr', [rt.call_function('get_the_date', [rt.new_string('c'), var_post_shadow.clone()])]), rt.call_function('get_the_date', [rt.new_string(''), var_post_shadow.clone()])])).str()
		}
		if var_attributes.array_isset(rt.new_string('displayPostContent'))
			&& rt.is_true(var_attributes.array_get(rt.new_string('displayPostContent')))
			&& var_attributes.array_isset(rt.new_string('displayPostContentRadio'))
			&& rt.is_true(rt.identical(rt.new_string('excerpt'), var_attributes.array_get(rt.new_string('displayPostContentRadio')))) {
			var_trimmed_excerpt = rt.call_function('get_the_excerpt', [
				var_post_shadow.clone()])
			if rt.is_true(rt.call_function('str_ends_with', [
				var_trimmed_excerpt.clone(), rt.new_string(' [&hellip;]')]))
			{
				var_excerpt_length = rt.new_int((rt.call_function('apply_filters', [
					rt.new_string('excerpt_length'),
					rt.new_int(var_block_core_latest_posts_excerpt_length).clone(),
				])).to_i64())
				if rt.is_true(rt.less_equal(var_excerpt_length,
					rt.new_int(var_block_core_latest_posts_excerpt_length)))
				{
					var_trimmed_excerpt = rt.call_function('substr', [
						var_trimmed_excerpt.clone(), rt.new_int(0),
						rt.new_int(-11)])
					var_trimmed_excerpt = rt.concat(var_trimmed_excerpt, rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('… <a class="wp-block-latest-posts__read-more" href="%1$s" rel="noopener noreferrer">Read more<span class="screen-reader-text">: %2$s</span></a>'),
						]),
						rt.call_function('esc_url', [
							var_post_link.clone(),
						]),
						rt.call_function('esc_html', [
							var_title.clone(),
						]),
					]))
				}
			}
			if rt.is_true(rt.call_function('post_password_required', [
				var_post_shadow.clone()]))
			{
				var_trimmed_excerpt = rt.call_function('__', [
					rt.new_string('This content is password protected.'),
				])
			}
			var_list_items_markup = var_list_items_markup +(rt.call_function('sprintf', [rt.new_string('<div class="wp-block-latest-posts__post-excerpt">%1$s</div>'), var_trimmed_excerpt.clone()])).str()
		}
		if var_attributes.array_isset(rt.new_string('displayPostContent'))
			&& rt.is_true(var_attributes.array_get(rt.new_string('displayPostContent')))
			&& var_attributes.array_isset(rt.new_string('displayPostContentRadio'))
			&& rt.is_true(rt.identical(rt.new_string('full_post'), var_attributes.array_get(rt.new_string('displayPostContentRadio')))) {
			var_post_content = rt.call_function('html_entity_decode', [
				rt.get_property(var_post_shadow, 'post_content'),
				rt.get_constant('ENT_QUOTES'),
				rt.call_function('get_option', [rt.new_string('blog_charset')]),
			])
			if rt.is_true(rt.call_function('post_password_required', [
				var_post_shadow.clone()]))
			{
				var_post_content = rt.call_function('__', [
					rt.new_string('This content is password protected.'),
				])
			}
			var_list_items_markup = var_list_items_markup +(rt.call_function('sprintf', [rt.new_string('<div class="wp-block-latest-posts__post-full-content">%1$s</div>'), rt.call_function('wp_kses_post', [var_post_content.clone()])])).str()
		}
		var_list_items_markup = var_list_items_markup + '</li>\n'
	}
	rt.call_function('remove_filter', [rt.new_string('excerpt_length'),
		rt.new_string('block_core_latest_posts_get_excerpt_length'),
		rt.new_int(20)])
	var_classes = ['wp-block-latest-posts__list']
	if var_attributes.array_isset(rt.new_string('postLayout'))
		&& rt.is_true(rt.identical(rt.new_string('grid'), var_attributes.array_get(rt.new_string('postLayout')))) {
		var_classes << 'is-grid'
	}
	if var_attributes.array_isset(rt.new_string('columns'))
		&& rt.is_true(rt.identical(rt.new_string('grid'), var_attributes.array_get(rt.new_string('postLayout')))) {
		var_classes << 'columns-' + (var_attributes.array_get(rt.new_string('columns'))).str()
	}
	if var_attributes.array_isset(rt.new_string('displayPostDate'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('displayPostDate'))) {
		var_classes << 'has-dates'
	}
	if var_attributes.array_isset(rt.new_string('displayAuthor'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('displayAuthor'))) {
		var_classes << 'has-author'
	}
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		var_classes << 'has-link-color'
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([
			rt.ArrayItem{ key: 'class', val: rt.call_function('implode', [
				rt.new_string(' '),
				rt.create_array_from_list(var_classes),
			]) },
		]),
	])
	return rt.call_function('sprintf', [rt.new_string('<ul %1$s>%2$s</ul>'),
		var_wrapper_attributes.clone(), rt.new_string(var_list_items_markup.str()).clone()])
}

fn register_block_core_latest_posts() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/latest-posts'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_latest_posts' },
		]),
	])
}

fn block_core_latest_posts_migrate_categories(var_block rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('core/latest-posts'), var_block.array_get(rt.new_string('blockName'))))
		&& !(!rt.is_true(var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('categories'))))
		&& var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('categories')).is_string() {
		var_block.array_get_mut('attrs').array_set('categories', rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.call_function('absint', [
					var_block.array_get(rt.new_string('attrs')).array_get(rt.new_string('categories')),
				]) },
			]) },
		]))
	}
	return var_block.clone()
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
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

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_block_core_latest_posts_excerpt_length :=
		rt.get_superglobal('block_core_latest_posts_excerpt_length')
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_latest_posts')])
	rt.call_function('add_filter', [rt.new_string('render_block_data'),
		rt.new_string('block_core_latest_posts_migrate_categories')])
}
