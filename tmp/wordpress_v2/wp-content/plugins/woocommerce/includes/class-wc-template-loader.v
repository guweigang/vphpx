import rt

struct Class_WC_Template_Loader {
	rt.PhpObjectBase
}

fn init_static_wc_template_loader() {
	rt.init_static_prop('WC_Template_Loader', 'shop_page_id', rt.new_int(0))
	rt.init_static_prop('WC_Template_Loader', 'in_content_filter', rt.new_bool(false))
	rt.init_static_prop('WC_Template_Loader', 'theme_support', rt.new_bool(false))
}

fn Class_WC_Template_Loader.init() {
	rt.set_static_prop('WC_Template_Loader', 'theme_support', rt.call_function('wc_current_theme_supports_woocommerce_or_fse',
		[]rt.PhpVal{}))
	rt.set_static_prop('WC_Template_Loader', 'shop_page_id', rt.call_function('wc_get_page_id', [
		rt.new_string('shop'),
	]))
	if rt.is_true(rt.get_static_prop('WC_Template_Loader', 'theme_support')) {
		rt.call_function('add_filter', [rt.new_string('template_include'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'template_loader' }])])
		rt.call_function('add_filter', [rt.new_string('comments_template'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'comments_template_loader' }])])
		if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
			Class_WC_Template_Loader.add_support_for_product_page_gallery()
		}
	} else {
		rt.call_function('add_action', [rt.new_string('template_redirect'),
			rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
				rt.ArrayItem{ key: none, val: 'unsupported_theme_init' }])])
	}
}

fn Class_WC_Template_Loader.template_loader(var_template rt.PhpVal) rt.PhpVal {
	mut var_template_mutated := var_template
	if rt.is_true(rt.call_function('is_embed', []rt.PhpVal{})) {
		return var_template_mutated.clone()
	}
	mut var_default_file := Class_WC_Template_Loader.get_template_loader_default_file()
	if rt.is_true(var_default_file) {
		mut var_search_files :=
			Class_WC_Template_Loader.get_template_loader_files(var_default_file.clone())
		var_template_mutated = rt.call_function('locate_template', [
			var_search_files.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_template_mutated))))
			|| rt.is_true(rt.get_constant('WC_TEMPLATE_DEBUG_MODE')) {
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_default_file.clone(), rt.new_string('product_cat')])))))
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('strpos', [var_default_file.clone(), rt.new_string('product_tag')]))))) {
				mut var_cs_template := rt.call_function('str_replace', [
					rt.new_string('_'),
					rt.new_string('-'),
					var_default_file.clone(),
				])
				var_template_mutated = rt.new_string(
					(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
					'/templates/' + var_cs_template.str())
			} else {
				var_template_mutated = rt.new_string(
					(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
					'/templates/' + var_default_file.str())
			}
		}
	}
	return var_template_mutated.clone()
}

fn Class_WC_Template_Loader.taxonomy_has_block_template(var_taxonomy rt.PhpVal) bool {
	if rt.is_true(rt.call_function('taxonomy_is_product_attribute', [
		rt.get_property(var_taxonomy, 'taxonomy'),
	]))
	{
		mut var_template_name := rt.new_string('taxonomy-product_attribute')
	} else {
		var_template_name = rt.new_string('taxonomy-' +
			(rt.get_property(var_taxonomy, 'taxonomy')).str())
	}
	return (Class_WC_Template_Loader.has_block_template(var_template_name.clone())).to_bool()
}

fn Class_WC_Template_Loader.has_block_template(var_template_name rt.PhpVal) bool {
	mut var_template_name_mutated := var_template_name
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template_name_mutated)))) {
		return false
	}
	mut iife_temp_0 := Class_WP_Block_Templates_Registry{}
	mut iife_result_0 := iife_temp_0.get_instance()
	mut var_has_template := rt.call_method(iife_result_0, 'is_registered', [
		rt.new_string('woocommerce//' + var_template_name_mutated.str()),
	])
	return (rt.call_function('apply_filters', [
		rt.new_string('woocommerce_has_block_template'),
		var_has_template.clone(),
		var_template_name_mutated.clone(),
	])).to_bool()
}

fn Class_WC_Template_Loader.get_template_loader_default_file() rt.PhpVal {
	if rt.is_true(rt.call_function('is_singular', [rt.new_string('product')]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Template_Loader.has_block_template(rt.new_string('single-product')))))) {
		mut var_default_file := rt.new_string('single-product.php')
	} else if rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{})) {
		mut var_object := rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(Class_WC_Template_Loader.taxonomy_has_block_template(var_object.clone())) {
			var_default_file = rt.new_string('')
		} else if rt.is_true(rt.call_function('taxonomy_is_product_attribute', [
			rt.get_property(var_object, 'taxonomy'),
		]))
		{
			var_default_file = rt.new_string('taxonomy-product-attribute.php')
		} else if rt.is_true(rt.call_function('is_tax', [rt.new_string('product_cat')]))
			|| rt.is_true(rt.call_function('is_tax', [rt.new_string('product_tag')])) {
			var_default_file = rt.new_string('taxonomy-' +
				(rt.get_property(var_object, 'taxonomy')).str() + '.php')
		} else if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Template_Loader.has_block_template(rt.new_string('archive-product')))))) {
			var_default_file = rt.new_string('archive-product.php')
		} else {
			var_default_file = rt.new_string('')
		}
	} else if rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')]))
		|| rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('shop')])]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Template_Loader.has_block_template(rt.new_string('archive-product')))))) {
		var_default_file = rt.new_string((if rt.is_true(rt.get_static_prop('WC_Template_Loader',
			'theme_support'))
		{
			'archive-product.php'
		} else {
			''
		}).str())
	} else {
		var_default_file = rt.new_string('')
	}
	return var_default_file.clone()
}

fn Class_WC_Template_Loader.get_template_loader_files(var_default_file rt.PhpVal) rt.PhpVal {
	mut var_default_file_mutated := var_default_file
	mut var_templates := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_template_loader_files'),
		rt.new_array(),
		var_default_file_mutated.clone(),
	])
	var_templates.array_push('woocommerce.php')
	if rt.is_true(rt.call_function('is_page_template', []rt.PhpVal{})) {
		mut var_page_template := rt.call_function('get_page_template_slug', []rt.PhpVal{})
		if rt.is_true(var_page_template) {
			mut var_validated_file := rt.call_function('validate_file', [
				var_page_template.clone()])
			if rt.is_true(rt.identical(rt.new_int(0), var_validated_file)) {
				var_templates.array_push(var_page_template.clone())
			} else {
				rt.call_function('error_log', [
					rt.new_string("WooCommerce: Unable to validate template path: \"${var_page_template.to_string()}\". Error Code: ${var_validated_file.to_string()}."),
				])
			}
		}
	}
	if rt.is_true(rt.call_function('is_singular', [rt.new_string('product')])) {
		mut var_object := rt.call_function('get_queried_object', []rt.PhpVal{})
		mut var_name_decoded := rt.call_function('urldecode', [
			rt.get_property(var_object, 'post_name'),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_name_decoded, rt.get_property(var_object,
			'post_name')))))
		{
			var_templates.array_push('single-product-${var_name_decoded.to_string()}.php')
		}
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('single-product-'), rt.get_property(var_object,
			'post_name')), rt.new_string('.php')))
	}
	if rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{})) {
		var_object = rt.call_function('get_queried_object', []rt.PhpVal{})
		var_templates.array_push('taxonomy-' + (rt.get_property(var_object, 'taxonomy')).str() +
			'-' + (rt.get_property(var_object, 'slug')).str() + '.php')
		var_templates.array_push(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() +
			'taxonomy-' + (rt.get_property(var_object, 'taxonomy')).str() + '-' +
			(rt.get_property(var_object, 'slug')).str() + '.php')
		var_templates.array_push('taxonomy-' + (rt.get_property(var_object, 'taxonomy')).str() +
			'.php')
		var_templates.array_push(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() +
			'taxonomy-' + (rt.get_property(var_object, 'taxonomy')).str() + '.php')
		if rt.is_true(rt.call_function('taxonomy_is_product_attribute', [
			rt.get_property(var_object, 'taxonomy'),
		]))
		{
			var_templates.array_push('taxonomy-product_attribute.php')
			var_templates.array_push(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() +
				'taxonomy-product_attribute.php')
			var_templates.array_push(var_default_file_mutated.clone())
		}
		if rt.is_true(rt.call_function('is_tax', [rt.new_string('product_cat')]))
			|| rt.is_true(rt.call_function('is_tax', [rt.new_string('product_tag')])) {
			mut var_cs_taxonomy := rt.call_function('str_replace', [
				rt.new_string('_'), rt.new_string('-'), rt.get_property(var_object, 'taxonomy')])
			mut var_cs_default := rt.call_function('str_replace', [
				rt.new_string('_'), rt.new_string('-'), var_default_file_mutated.clone()])
			var_templates.array_push('taxonomy-' + (rt.get_property(var_object, 'taxonomy')).str() +
				'-' + (rt.get_property(var_object, 'slug')).str() + '.php')
			var_templates.array_push(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() +
				'taxonomy-' + var_cs_taxonomy.str() + '-' +
				(rt.get_property(var_object, 'slug')).str() + '.php')
			var_templates.array_push('taxonomy-' + (rt.get_property(var_object, 'taxonomy')).str() +
				'.php')
			var_templates.array_push(
				(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() +
				'taxonomy-' + var_cs_taxonomy.str() + '.php')
			var_templates.array_push(var_cs_default.clone())
		}
	}
	var_templates.array_push(var_default_file_mutated.clone())
	if !var_cs_default.is_null() {
		var_templates.array_push(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() +
			var_cs_default.str())
	}
	var_templates.array_push(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() +
		var_default_file_mutated.str())
	return rt.call_function('array_unique', [var_templates.clone()])
}

fn Class_WC_Template_Loader.comments_template_loader(var_template rt.PhpVal) string {
	mut var_template_mutated := var_template
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_post_type',
		[]rt.PhpVal{}), rt.new_string('product')))))
	{
		return var_template_mutated.str()
	}
	mut var_check_dirs := [
			(rt.call_function('trailingslashit', [rt.call_function('get_stylesheet_directory', []rt.PhpVal{})])).str() +(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str(),
			(rt.call_function('trailingslashit', [rt.call_function('get_template_directory', []rt.PhpVal{})])).str() +(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str(),
		rt.call_function('trailingslashit', [
			rt.call_function('get_stylesheet_directory', []rt.PhpVal{}),
		]),
		rt.call_function('trailingslashit', [
			rt.call_function('get_template_directory', []rt.PhpVal{}),
		]),
			(rt.call_function('trailingslashit', [rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})])).str() +
			'templates/',
	]
	if rt.is_true(rt.get_constant('WC_TEMPLATE_DEBUG_MODE')) {
		var_check_dirs = [
			rt.call_function('array_pop', [rt.create_array_from_list(var_check_dirs)]),
		]
	}
	for var_dir in var_check_dirs {
		if rt.is_true(rt.call_function('file_exists', [
			rt.new_string((rt.call_function('trailingslashit', [var_dir.clone()])).str() +
				'single-product-reviews.php'),
		]))
		{
			return (rt.call_function('trailingslashit', [var_dir.clone()])).str() +
				'single-product-reviews.php'
		}
	}
	return ''
}

fn Class_WC_Template_Loader.unsupported_theme_init() {
	if rt.is_true(rt.less(rt.new_int(0), rt.get_static_prop('WC_Template_Loader', 'shop_page_id'))) {
		if rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{})) {
			Class_WC_Template_Loader.unsupported_theme_tax_archive_init()
		} else if rt.is_true(rt.call_function('is_product', []rt.PhpVal{})) {
			Class_WC_Template_Loader.unsupported_theme_product_page_init()
		} else {
			Class_WC_Template_Loader.unsupported_theme_shop_page_init()
		}
	}
}

fn Class_WC_Template_Loader.unsupported_theme_shop_page_init() {
	rt.call_function('add_filter', [rt.new_string('the_content'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'unsupported_theme_shop_content_filter' }]),
		rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('the_title'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'unsupported_theme_title_filter' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('comments_number'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'unsupported_theme_comments_number_filter' }])])
}

fn Class_WC_Template_Loader.unsupported_theme_product_page_init() {
	rt.call_function('add_filter', [rt.new_string('the_content'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'unsupported_theme_product_content_filter' }]),
		rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('post_thumbnail_html'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'unsupported_theme_single_featured_image_filter' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_product_tabs'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'unsupported_theme_remove_review_tab' }])])
	rt.call_function('remove_action', [rt.new_string('woocommerce_before_main_content'),
		rt.new_string('woocommerce_output_content_wrapper'), rt.new_int(10)])
	rt.call_function('remove_action', [rt.new_string('woocommerce_after_main_content'),
		rt.new_string('woocommerce_output_content_wrapper_end'),
		rt.new_int(10)])
	Class_WC_Template_Loader.add_support_for_product_page_gallery()
}

fn Class_WC_Template_Loader.add_support_for_product_page_gallery() {
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-zoom')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-lightbox')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-slider')])
}

fn Class_WC_Template_Loader.unsupported_theme_tax_archive_init() {
	mut var_wp_query := rt.new_null()
	mut var_post := rt.get_superglobal('post')
	mut var_queried_object := rt.call_function('get_queried_object', []rt.PhpVal{})
	mut var_args := Class_WC_Template_Loader.get_current_shop_view_args()
	mut var_shortcode_args := {
		'page':     rt.get_property(var_args, 'page')
		'columns':  rt.get_property(var_args, 'columns')
		'rows':     rt.get_property(var_args, 'rows')
		'orderby':  rt.new_string('')
		'order':    rt.new_string('')
		'paginate': rt.new_bool(true)
		'cache':    rt.new_bool(false)
	}
	if rt.is_true(rt.call_function('is_product_category', []rt.PhpVal{})) {
		var_shortcode_args['category'] = rt.call_function('sanitize_title', [
			rt.get_property(var_queried_object, 'slug'),
		])
	} else if rt.is_true(rt.call_function('taxonomy_is_product_attribute', [
		rt.get_property(var_queried_object, 'taxonomy'),
	]))
	{
		var_shortcode_args['attribute'] = rt.call_function('sanitize_title', [
			rt.get_property(var_queried_object, 'taxonomy'),
		])
		var_shortcode_args['terms'] = rt.call_function('sanitize_title', [
			rt.get_property(var_queried_object, 'slug'),
		])
	} else if rt.is_true(rt.call_function('is_product_tag', []rt.PhpVal{})) {
		var_shortcode_args['tag'] = rt.call_function('sanitize_title', [
			rt.get_property(var_queried_object, 'slug'),
		])
	} else {
		return
	}
	if !(!rt.is_true(rt.get_property(var_queried_object, 'description')))
		&& !rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('product-page')))
		|| rt.is_true(rt.identical(rt.new_int(1), rt.call_function('absint', [rt.get_superglobal('_GET').array_get(rt.new_string('product-page'))]))) {
		mut var_prefix := rt.new_string('<div class="term-description">' +
			(rt.call_function('wc_format_content', [rt.call_function('wp_kses_post', [rt.get_property(var_queried_object, 'description')])])).str() +
			'</div>')
	} else {
		var_prefix = rt.new_string('')
	}
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_shortcode_products_query'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'unsupported_archive_layered_nav_compatibility' }]),
	])
	mut var_shortcode := create_wc_shortcode_products(var_shortcode_args.clone())
	rt.call_function('remove_filter', [
		rt.new_string('woocommerce_shortcode_products_query'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'unsupported_archive_layered_nav_compatibility' }]),
	])
	mut var_shop_page := rt.call_function('get_post', [
		rt.get_static_prop('WC_Template_Loader', 'shop_page_id'),
	])
	mut var_dummy_post_properties := {
		'ID':                    rt.new_int(0)
		'post_status':           rt.new_string('publish')
		'post_author':           rt.get_property(var_shop_page, 'post_author')
		'post_parent':           rt.new_int(0)
		'post_type':             rt.new_string('page')
		'post_date':             rt.get_property(var_shop_page, 'post_date')
		'post_date_gmt':         rt.get_property(var_shop_page, 'post_date_gmt')
		'post_modified':         rt.get_property(var_shop_page, 'post_modified')
		'post_modified_gmt':     rt.get_property(var_shop_page, 'post_modified_gmt')
		'post_content':          var_prefix.str() + (var_shortcode.get_content()).str()
		'post_title':            rt.call_function('wc_clean', [
			rt.get_property(var_queried_object, 'name'),
		])
		'post_excerpt':          rt.new_string('')
		'post_content_filtered': rt.new_string('')
		'post_mime_type':        rt.new_string('')
		'post_password':         rt.new_string('')
		'post_name':             rt.get_property(var_queried_object, 'slug')
		'guid':                  rt.new_string('')
		'menu_order':            rt.new_int(0)
		'pinged':                rt.new_string('')
		'to_ping':               rt.new_string('')
		'ping_status':           rt.new_string('')
		'comment_status':        rt.new_string('closed')
		'comment_count':         rt.new_int(0)
		'filter':                rt.new_string('raw')
	}
	var_post = create_wp_post(rt.array_to_object(var_dummy_post_properties))
	rt.set_property(var_wp_query, 'post', var_post)
	rt.set_property(var_wp_query, 'posts', rt.create_array([
		rt.ArrayItem{ key: none, val: var_post },
	]))
	rt.set_property(var_wp_query, 'post_count', rt.new_int(1))
	rt.set_property(var_wp_query, 'is_404', rt.new_bool(false))
	rt.set_property(var_wp_query, 'is_page', rt.new_bool(true))
	rt.set_property(var_wp_query, 'is_single', rt.new_bool(true))
	rt.set_property(var_wp_query, 'is_archive', rt.new_bool(false))
	rt.set_property(var_wp_query, 'is_tax', rt.new_bool(true))
	rt.set_property(var_wp_query, 'max_num_pages', rt.new_int(0))
	rt.call_function('setup_postdata', [var_post])
	rt.call_function('remove_all_filters', [rt.new_string('the_content')])
	rt.call_function('remove_all_filters', [rt.new_string('the_excerpt')])
	rt.call_function('add_filter', [rt.new_string('template_include'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'force_single_template_filter' }])])
}

fn Class_WC_Template_Loader.unsupported_archive_layered_nav_compatibility(var_query rt.PhpVal) rt.PhpVal {
	mut iter_1 := rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'),
		'get_layered_nav_chosen_attributes', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_data := item_1.val
		mut var_taxonomy := item_1.key
		var_query.array_get_mut('tax_query').array_push(rt.create_array([
			rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy },
			rt.ArrayItem{ key: 'field', val: 'slug' },
			rt.ArrayItem{ key: 'terms', val: var_data.array_get(rt.new_string('terms')) },
			rt.ArrayItem{
				key: 'operator'
				val: if rt.is_true(rt.identical(rt.new_string('and'),
					var_data.array_get(rt.new_string('query_type'))))
				{
					'AND'
				} else {
					'IN'
				}
			},
			rt.ArrayItem{ key: 'include_children', val: false },
		]))
	}
	return var_query.clone()
}

fn Class_WC_Template_Loader.force_single_template_filter(var_template rt.PhpVal) rt.PhpVal {
	mut var_template_mutated := var_template
	mut var_possible_templates := ['page', 'single', 'singular', 'index']
	for var_possible_template in var_possible_templates {
		mut var_path := rt.call_function('get_query_template', [
			rt.new_string(possible_template),
		])
		if rt.is_true(var_path) {
			return var_path.clone()
		}
	}
	return var_template_mutated.clone()
}

fn Class_WC_Template_Loader.get_current_shop_view_args() rt.PhpVal {
	return mut rt.array_to_object(rt.create_array([
		rt.ArrayItem{ key: 'page', val: rt.call_function('absint', [
			rt.call_function('max', [rt.new_int(1),
				rt.call_function('absint', [
					rt.call_function('get_query_var', [rt.new_string('paged')]),
				])]),
		]) },
		rt.ArrayItem{ key: 'columns', val: rt.call_function('wc_get_default_products_per_row',
			[]rt.PhpVal{}) },
		rt.ArrayItem{ key: 'rows', val: rt.call_function('wc_get_default_product_rows_per_page',
			[]rt.PhpVal{}) },
	]))
}

fn Class_WC_Template_Loader.unsupported_theme_title_filter(var_title rt.PhpVal, var_id rt.PhpVal) rt.PhpVal {
	mut var_title_mutated := var_title
	if var_id.clone().is_null()
		|| rt.is_true(rt.get_static_prop('WC_Template_Loader', 'theme_support'))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(!(rt.is_true(var_id))), rt.get_static_prop('WC_Template_Loader', 'shop_page_id'))))) {
		return var_title_mutated.clone()
	}
	if rt.is_true(rt.call_function('is_page', [rt.get_static_prop('WC_Template_Loader', 'shop_page_id')]))
		|| (rt.is_true(rt.call_function('is_home', []rt.PhpVal{}))
		&& rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_option', [rt.new_string('show_on_front')])))
		&& rt.is_true(rt.identical(rt.call_function('absint', [rt.call_function('get_option', [rt.new_string('page_on_front')])]), rt.get_static_prop('WC_Template_Loader', 'shop_page_id')))) {
		mut var_args := Class_WC_Template_Loader.get_current_shop_view_args()
		mut var_title_suffix := rt.new_array()
		if rt.is_true(rt.greater(rt.get_property(var_args, 'page'), rt.new_int(1))) {
			var_title_suffix << rt.call_function('sprintf', [
				rt.call_function('esc_html__', [rt.new_string('Page %d'),
					rt.new_string('woocommerce')]),
				rt.get_property(var_args, 'page'),
			])
		}
		if rt.is_true(var_title_suffix) {
			var_title_mutated =
				rt.new_string(var_title_mutated.str() + ' &ndash; ' +(rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_title_suffix)])).str())
		}
	}
	return var_title_mutated.clone()
}

fn Class_WC_Template_Loader.unsupported_theme_shop_content_filter(var_content rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	mut var_content_mutated := var_content
	if rt.is_true(rt.get_static_prop('WC_Template_Loader', 'theme_support'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_query', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{}))))) {
		return var_content_mutated.clone()
	}
	rt.set_static_prop('WC_Template_Loader', 'in_content_filter', rt.new_bool(true))
	rt.call_function('remove_filter', [rt.new_string('the_content'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'unsupported_theme_shop_content_filter' }])])
	if rt.is_true(rt.call_function('is_page', [
		rt.get_static_prop('WC_Template_Loader', 'shop_page_id'),
	]))
	{
		mut var_args := Class_WC_Template_Loader.get_current_shop_view_args()
		mut var_shortcode := create_wc_shortcode_products(rt.call_function('array_merge', [
			rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'),
				'get_catalog_ordering_args', []rt.PhpVal{}),
			rt.create_array([
				rt.ArrayItem{ key: 'page', val: rt.get_property(var_args, 'page') },
				rt.ArrayItem{ key: 'columns', val: rt.get_property(var_args, 'columns') },
				rt.ArrayItem{ key: 'rows', val: rt.get_property(var_args, 'rows') },
				rt.ArrayItem{ key: 'orderby', val: '' },
				rt.ArrayItem{ key: 'order', val: '' },
				rt.ArrayItem{ key: 'paginate', val: true },
				rt.ArrayItem{ key: 'cache', val: false },
			]),
		]), rt.new_string('products'))
		rt.call_function('add_action', [rt.new_string('pre_get_posts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
					'query') },
				rt.ArrayItem{ key: none, val: 'product_query' },
			])])
		var_content_mutated = rt.new_string(var_content_mutated.str() +
			(var_shortcode.get_content()).str())
		rt.call_function('remove_action', [rt.new_string('pre_get_posts'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
					'query') },
				rt.ArrayItem{ key: none, val: 'product_query' },
			])])
		rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'query'),
			'remove_ordering_args', []rt.PhpVal{})
	}
	rt.set_static_prop('WC_Template_Loader', 'in_content_filter', rt.new_bool(false))
	return var_content_mutated.clone()
}

fn Class_WC_Template_Loader.unsupported_theme_product_content_filter(var_content rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	mut var_content_mutated := var_content
	if rt.is_true(rt.get_static_prop('WC_Template_Loader', 'theme_support'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_query', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{}))))) {
		return var_content_mutated.clone()
	}
	rt.set_static_prop('WC_Template_Loader', 'in_content_filter', rt.new_bool(true))
	rt.call_function('remove_filter', [rt.new_string('the_content'),
		rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT },
			rt.ArrayItem{ key: none, val: 'unsupported_theme_product_content_filter' }])])
	if rt.is_true(rt.call_function('is_product', []rt.PhpVal{})) {
		var_content_mutated = rt.call_function('do_shortcode', [
			rt.new_string('[product_page id="' +
				(rt.call_function('get_the_ID', []rt.PhpVal{})).str() +
				'" show_title=0 status="any"]'),
		])
	}
	rt.set_static_prop('WC_Template_Loader', 'in_content_filter', rt.new_bool(false))
	return var_content_mutated.clone()
}

fn Class_WC_Template_Loader.unsupported_theme_comments_number_filter(var_comments_number rt.PhpVal) string {
	if rt.is_true(rt.call_function('is_page', [
		rt.get_static_prop('WC_Template_Loader', 'shop_page_id'),
	]))
	{
		return ''
	}
	return var_comments_number.str()
}

fn Class_WC_Template_Loader.in_content_filter() bool {
	return (rt.get_static_prop('WC_Template_Loader', 'in_content_filter')).to_bool()
}

fn Class_WC_Template_Loader.unsupported_theme_single_featured_image_filter(var_html rt.PhpVal) string {
	if rt.is_true(Class_WC_Template_Loader.in_content_filter())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_product', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_main_query', []rt.PhpVal{}))))) {
		return var_html.str()
	}
	return ''
}

fn Class_WC_Template_Loader.unsupported_theme_remove_review_tab(var_tabs rt.PhpVal) rt.PhpVal {
	var_tabs.array_unset(rt.new_string('reviews'))
	return var_tabs.clone()
}

struct Class_WP_Block_Templates_Registry {
	rt.PhpObjectBase
}

struct Class_WC_Shortcode_Products {
	rt.PhpObjectBase
}

struct Class_WP_Post {
	rt.PhpObjectBase
}

fn create_wc_template_loader(_args ...rt.PhpVal) &Class_WC_Template_Loader {
	mut obj := &Class_WC_Template_Loader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_templates_registry(_args ...rt.PhpVal) &Class_WP_Block_Templates_Registry {
	mut obj := &Class_WP_Block_Templates_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shortcode_products(_args ...rt.PhpVal) &Class_WC_Shortcode_Products {
	mut obj := &Class_WC_Shortcode_Products{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_post(_args ...rt.PhpVal) &Class_WP_Post {
	mut obj := &Class_WP_Post{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Template_Loader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Template_Loader.init()
			return rt.new_null()
		}
		'template_loader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Template_Loader.template_loader(dispatch_arg_0)
		}
		'taxonomy_has_block_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Template_Loader.taxonomy_has_block_template(dispatch_arg_0))
		}
		'has_block_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WC_Template_Loader.has_block_template(dispatch_arg_0))
		}
		'get_template_loader_default_file' {
			return Class_WC_Template_Loader.get_template_loader_default_file()
		}
		'get_template_loader_files' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Template_Loader.get_template_loader_files(dispatch_arg_0)
		}
		'comments_template_loader' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Template_Loader.comments_template_loader(dispatch_arg_0))
		}
		'unsupported_theme_init' {
			Class_WC_Template_Loader.unsupported_theme_init()
			return rt.new_null()
		}
		'unsupported_theme_shop_page_init' {
			Class_WC_Template_Loader.unsupported_theme_shop_page_init()
			return rt.new_null()
		}
		'unsupported_theme_product_page_init' {
			Class_WC_Template_Loader.unsupported_theme_product_page_init()
			return rt.new_null()
		}
		'add_support_for_product_page_gallery' {
			Class_WC_Template_Loader.add_support_for_product_page_gallery()
			return rt.new_null()
		}
		'unsupported_theme_tax_archive_init' {
			Class_WC_Template_Loader.unsupported_theme_tax_archive_init()
			return rt.new_null()
		}
		'unsupported_archive_layered_nav_compatibility' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Template_Loader.unsupported_archive_layered_nav_compatibility(dispatch_arg_0)
		}
		'force_single_template_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Template_Loader.force_single_template_filter(dispatch_arg_0)
		}
		'get_current_shop_view_args' {
			return Class_WC_Template_Loader.get_current_shop_view_args()
		}
		'unsupported_theme_title_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Template_Loader.unsupported_theme_title_filter(dispatch_arg_0,
				dispatch_arg_1)
		}
		'unsupported_theme_shop_content_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Template_Loader.unsupported_theme_shop_content_filter(dispatch_arg_0)
		}
		'unsupported_theme_product_content_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Template_Loader.unsupported_theme_product_content_filter(dispatch_arg_0)
		}
		'unsupported_theme_comments_number_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Template_Loader.unsupported_theme_comments_number_filter(dispatch_arg_0))
		}
		'in_content_filter' {
			return rt.new_bool(Class_WC_Template_Loader.in_content_filter())
		}
		'unsupported_theme_single_featured_image_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Template_Loader.unsupported_theme_single_featured_image_filter(dispatch_arg_0))
		}
		'unsupported_theme_remove_review_tab' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Template_Loader.unsupported_theme_remove_review_tab(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Template_Loader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Template_Loader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Templates_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Templates_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Templates_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Shortcode_Products) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Shortcode_Products) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Shortcode_Products) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Post) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Post) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Post) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Template_Loader' },
			rt.ArrayItem{ key: none, val: 'init' }])])
}
