import rt

struct Class_WC_Template_Loader {
	rt.PhpObjectBase
pub mut:
		shop_page_id rt.PhpVal = rt.new_int(0)
		in_content_filter rt.PhpVal = rt.new_bool(false)
		theme_support rt.PhpVal = rt.new_bool(false)
}

fn Class_WC_Template_Loader.init()  {
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		rt.call_function('add_filter', [rt.new_string('template_include'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'template_loader' }])])
		rt.call_function('add_filter', [rt.new_string('comments_template'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'comments_template_loader' }])])
		if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
			Class_WC_Template_Loader.add_support_for_product_page_gallery()
		}
	} else {
		rt.call_function('add_action', [rt.new_string('template_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'unsupported_theme_init' }])])
	}
}

fn Class_WC_Template_Loader.template_loader(var_template rt.PhpVal) rt.PhpVal {
	mut var_template_mutated := var_template
	if rt.is_true(rt.call_function('is_embed', []rt.PhpVal{})) {
		return var_template_mutated.dup()
	}
	mut var_default_file := Class_WC_Template_Loader.get_template_loader_default_file()
	if rt.is_true(var_default_file) {
		mut var_search_files := Class_WC_Template_Loader.get_template_loader_files(var_default_file.dup())
		var_template_mutated = rt.call_function('locate_template', [var_search_files.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_template_mutated)))) || rt.is_true(rt.get_constant('WC_TEMPLATE_DEBUG_MODE')))) {
			if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				mut var_cs_template := rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), var_default_file.dup()])
				var_template_mutated = rt.new_string((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/templates/' + (var_cs_template).str())
			} else {
				var_template_mutated = rt.new_string((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/templates/' + (var_default_file).str())
			}
		}
	}
	return var_template_mutated.dup()
}

fn Class_WC_Template_Loader.taxonomy_has_block_template(var_taxonomy rt.PhpVal) bool {
	if rt.is_true(rt.call_function('taxonomy_is_product_attribute', [rt.get_property(var_taxonomy, 'taxonomy')])) {
		mut var_template_name := rt.new_string(rt.new_string('taxonomy-product_attribute'))
	} else {
		var_template_name = rt.new_string('taxonomy-' + (rt.get_property(var_taxonomy, 'taxonomy')).str())
	}
	return (Class_WC_Template_Loader.has_block_template(var_template_name.dup())).to_bool()
}

fn Class_WC_Template_Loader.has_block_template(var_template_name rt.PhpVal) bool {
	mut var_template_name_mutated := var_template_name
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template_name_mutated)))) {
		return false
	}
	mut var_has_template := rt.call_method(fn () rt.PhpVal { mut temp := Class_WP_Block_Templates_Registry{}; return temp.get_instance() }(), 'is_registered', ['woocommerce//' + (var_template_name_mutated).str()])
	return (// unsupported expression: Expr_Cast_Bool).to_bool()
}

fn Class_WC_Template_Loader.get_template_loader_default_file() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_singular', [rt.new_string('product')])) && rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Template_Loader.has_block_template(rt.new_string('single-product')))))))) {
		mut var_default_file := rt.new_string(rt.new_string('single-product.php'))
	} else if rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{})) {
		mut var_object := rt.call_function('get_queried_object', []rt.PhpVal{})
		if rt.is_true(Class_WC_Template_Loader.taxonomy_has_block_template(var_object.dup())) {
			var_default_file = rt.new_string(rt.new_string(''))
		} else if rt.is_true(rt.call_function('taxonomy_is_product_attribute', [rt.get_property(var_object, 'taxonomy')])) {
			var_default_file = rt.new_string(rt.new_string('taxonomy-product-attribute.php'))
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_tax', [rt.new_string('product_cat')])) || rt.is_true(rt.call_function('is_tax', [rt.new_string('product_tag')])))) {
			var_default_file = rt.new_string('taxonomy-' + (rt.get_property(var_object, 'taxonomy')).str() + '.php')
		} else if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Template_Loader.has_block_template(rt.new_string('archive-product')))))) {
			var_default_file = rt.new_string(rt.new_string('archive-product.php'))
		} else {
			var_default_file = rt.new_string(rt.new_string(''))
		}
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')])) || rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('shop')])])))) && rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Template_Loader.has_block_template(rt.new_string('archive-product')))))))) {
		var_default_file = rt.new_string(if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) { rt.new_string('archive-product.php') } else { rt.new_string('') })
	} else {
		var_default_file = rt.new_string(rt.new_string(''))
	}
	return var_default_file.dup()
}

fn Class_WC_Template_Loader.get_template_loader_files(var_default_file rt.PhpVal) rt.PhpVal {
	mut var_default_file_mutated := var_default_file
	mut var_templates := rt.call_function('apply_filters', [rt.new_string('woocommerce_template_loader_files'), rt.new_array(), var_default_file_mutated.dup()])
	var_templates.array_push('woocommerce.php')
	if rt.is_true(rt.call_function('is_page_template', []rt.PhpVal{})) {
		mut var_page_template := rt.call_function('get_page_template_slug', []rt.PhpVal{})
		if rt.is_true(var_page_template) {
			mut var_validated_file := rt.call_function('validate_file', [var_page_template.dup()])
			if rt.is_true(rt.identical(rt.new_int(0), var_validated_file)) {
				var_templates.array_push(var_page_template.dup())
			} else {
				rt.call_function('error_log', [rt.new_string("WooCommerce: Unable to validate template path: \"${var_page_template.to_string()}\". Error Code: ${var_validated_file.to_string()}.")])
				// unsupported statement: Stmt_Nop
			}
		}
	}
	if rt.is_true(rt.call_function('is_singular', [rt.new_string('product')])) {
		mut var_object := rt.call_function('get_queried_object', []rt.PhpVal{})
		mut var_name_decoded := rt.call_function('urldecode', [rt.get_property(var_object, 'post_name')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_templates.array_push("single-product-${var_name_decoded.to_string()}.php")
		}
		var_templates.array_push(rt.concat(rt.concat(rt.new_string('single-product-'), rt.get_property(var_object, 'post_name')), rt.new_string('.php')))
	}
	if rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{})) {
		var_object = rt.call_function('get_queried_object', []rt.PhpVal{})
		var_templates.array_push('taxonomy-' + (rt.get_property(var_object, 'taxonomy')).str() + '-' + (rt.get_property(var_object, 'slug')).str() + '.php')
		var_templates.array_push((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + 'taxonomy-' + (rt.get_property(var_object, 'taxonomy')).str() + '-' + (rt.get_property(var_object, 'slug')).str() + '.php')
		var_templates.array_push('taxonomy-' + (rt.get_property(var_object, 'taxonomy')).str() + '.php')
		var_templates.array_push((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + 'taxonomy-' + (rt.get_property(var_object, 'taxonomy')).str() + '.php')
		if rt.is_true(rt.call_function('taxonomy_is_product_attribute', [rt.get_property(var_object, 'taxonomy')])) {
			var_templates.array_push('taxonomy-product_attribute.php')
			var_templates.array_push((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + 'taxonomy-product_attribute.php')
			var_templates.array_push(var_default_file_mutated.dup())
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_tax', [rt.new_string('product_cat')])) || rt.is_true(rt.call_function('is_tax', [rt.new_string('product_tag')])))) {
			mut var_cs_taxonomy := rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), rt.get_property(var_object, 'taxonomy')])
			mut var_cs_default := rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), var_default_file_mutated.dup()])
			var_templates.array_push('taxonomy-' + (rt.get_property(var_object, 'taxonomy')).str() + '-' + (rt.get_property(var_object, 'slug')).str() + '.php')
			var_templates.array_push((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + 'taxonomy-' + (var_cs_taxonomy).str() + '-' + (rt.get_property(var_object, 'slug')).str() + '.php')
			var_templates.array_push('taxonomy-' + (rt.get_property(var_object, 'taxonomy')).str() + '.php')
			var_templates.array_push((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + 'taxonomy-' + (var_cs_taxonomy).str() + '.php')
			var_templates.array_push(var_cs_default.dup())
		}
	}
	var_templates.array_push(var_default_file_mutated.dup())
	if !(var_cs_default).is_null() {
		var_templates.array_push((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + (var_cs_default).str())
	}
	var_templates.array_push((rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})).str() + (var_default_file_mutated).str())
	return rt.call_function('array_unique', [var_templates.dup()])
}

fn Class_WC_Template_Loader.comments_template_loader(var_template rt.PhpVal) string {
	mut var_template_mutated := var_template
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (var_template_mutated).str()
	}
	mut var_check_dirs := [rt.concat(rt.call_function('trailingslashit', [rt.call_function('get_stylesheet_directory', []rt.PhpVal{})]), rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})), rt.concat(rt.call_function('trailingslashit', [rt.call_function('get_template_directory', []rt.PhpVal{})]), rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'template_path', []rt.PhpVal{})), rt.call_function('trailingslashit', [rt.call_function('get_stylesheet_directory', []rt.PhpVal{})]), rt.call_function('trailingslashit', [rt.call_function('get_template_directory', []rt.PhpVal{})]), (rt.call_function('trailingslashit', [rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})])).str() + 'templates/']
	if rt.is_true(rt.get_constant('WC_TEMPLATE_DEBUG_MODE')) {
		var_check_dirs = [rt.call_function('array_pop', [var_check_dirs.dup()])]
	}
	for var_dir in var_check_dirs {
		if rt.is_true(rt.call_function('file_exists', [(rt.call_function('trailingslashit', [var_dir.dup()])).str() + 'single-product-reviews.php'])) {
			return (rt.call_function('trailingslashit', [var_dir.dup()])).str() + 'single-product-reviews.php'
		}
	}
	return ''
}

fn Class_WC_Template_Loader.unsupported_theme_init()  {
	if rt.is_true(rt.less(rt.new_int(0), // unsupported expression: Expr_StaticPropertyFetch)) {
		if rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{})) {
			Class_WC_Template_Loader.unsupported_theme_tax_archive_init()
		} else if rt.is_true(rt.call_function('is_product', []rt.PhpVal{})) {
			Class_WC_Template_Loader.unsupported_theme_product_page_init()
		} else {
			Class_WC_Template_Loader.unsupported_theme_shop_page_init()
		}
	}
}

fn Class_WC_Template_Loader.unsupported_theme_shop_page_init()  {
	rt.call_function('add_filter', [rt.new_string('the_content'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'unsupported_theme_shop_content_filter' }]), rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('the_title'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'unsupported_theme_title_filter' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('comments_number'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'unsupported_theme_comments_number_filter' }])])
}

fn Class_WC_Template_Loader.unsupported_theme_product_page_init()  {
	rt.call_function('add_filter', [rt.new_string('the_content'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'unsupported_theme_product_content_filter' }]), rt.new_int(10)])
	rt.call_function('add_filter', [rt.new_string('post_thumbnail_html'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'unsupported_theme_single_featured_image_filter' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_product_tabs'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'unsupported_theme_remove_review_tab' }])])
	rt.call_function('remove_action', [rt.new_string('woocommerce_before_main_content'), rt.new_string('woocommerce_output_content_wrapper'), rt.new_int(10)])
	rt.call_function('remove_action', [rt.new_string('woocommerce_after_main_content'), rt.new_string('woocommerce_output_content_wrapper_end'), rt.new_int(10)])
	Class_WC_Template_Loader.add_support_for_product_page_gallery()
}

fn Class_WC_Template_Loader.add_support_for_product_page_gallery()  {
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-zoom')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-lightbox')])
	rt.call_function('add_theme_support', [rt.new_string('wc-product-gallery-slider')])
}

fn Class_WC_Template_Loader.unsupported_theme_tax_archive_init()  {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_queried_object := rt.call_function('get_queried_object', []rt.PhpVal{})
	mut var_args := Class_WC_Template_Loader.get_current_shop_view_args()
	mut var_shortcode_args := { 'page': rt.get_property(var_args, 'page'), 'columns': rt.get_property(var_args, 'columns'), 'rows': rt.get_property(var_args, 'rows'), 'orderby': rt.new_string(''), 'order': rt.new_string(''), 'paginate': rt.new_bool(true), 'cache': rt.new_bool(false) }
	if rt.is_true(rt.call_function('is_product_category', []rt.PhpVal{})) {
		var_shortcode_args['category'] = rt.call_function('sanitize_title', [rt.get_property(var_queried_object, 'slug')])
	} else if rt.is_true(rt.call_function('taxonomy_is_product_attribute', [rt.get_property(var_queried_object, 'taxonomy')])) {
		var_shortcode_args['attribute'] = rt.call_function('sanitize_title', [rt.get_property(var_queried_object, 'taxonomy')])
		var_shortcode_args['terms'] = rt.call_function('sanitize_title', [rt.get_property(var_queried_object, 'slug')])
	} else if rt.is_true(rt.call_function('is_product_tag', []rt.PhpVal{})) {
		var_shortcode_args['tag'] = rt.call_function('sanitize_title', [rt.get_property(var_queried_object, 'slug')])
	} else {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_queried_object, 'description'))) && rt.is_true(rt.new_bool(!rt.is_true(rt.get_superglobal('_GET').array_get('product-page')) || rt.is_true(rt.identical(rt.new_int(1), rt.call_function('absint', [rt.get_superglobal('_GET').array_get('product-page')]))))))) {
		mut var_prefix := rt.new_string('<div class="term-description">' + (rt.call_function('wc_format_content', [rt.call_function('wp_kses_post', [rt.get_property(var_queried_object, 'description')])])).str() + '</div>')
	} else {
		var_prefix = rt.new_string(rt.new_string(''))
	}
	rt.call_function('add_filter', [rt.new_string('woocommerce_shortcode_products_query'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'unsupported_archive_layered_nav_compatibility' }])])
	mut var_shortcode := create_wc_shortcode_products(var_shortcode_args.dup())
	rt.call_function('remove_filter', [rt.new_string('woocommerce_shortcode_products_query'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'unsupported_archive_layered_nav_compatibility' }])])
	mut var_shop_page := rt.call_function('get_post', [// unsupported expression: Expr_StaticPropertyFetch])
	mut var_dummy_post_properties := { : , : , : , : , : , : , : , : , : , : , : , : , : , : , : , : , : , : , : , : , : , : , : , :  }
	mut var_post := 
	
}

fn Class_WC_Template_Loader.unsupported_archive_layered_nav_compatibility(var_query rt.PhpVal) rt.PhpVal {
}

fn Class_WC_Template_Loader.force_single_template_filter(var_template rt.PhpVal) rt.PhpVal {
	mut var_template_mutated := var_template
}

fn Class_WC_Template_Loader.get_current_shop_view_args() rt.PhpVal {
}

fn Class_WC_Template_Loader.unsupported_theme_title_filter(var_title rt.PhpVal, var_id rt.PhpVal) rt.PhpVal {
	mut var_title_mutated := var_title
}

fn Class_WC_Template_Loader.unsupported_theme_shop_content_filter(var_content rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	mut var_content_mutated := var_content
}

fn Class_WC_Template_Loader.unsupported_theme_product_content_filter(var_content rt.PhpVal) rt.PhpVal {
	mut var_wp_query := rt.new_null()
	mut var_content_mutated := var_content
}

fn Class_WC_Template_Loader.unsupported_theme_comments_number_filter(var_comments_number rt.PhpVal) string {
}

fn Class_WC_Template_Loader.in_content_filter() rt.PhpVal {
}

fn Class_WC_Template_Loader.unsupported_theme_single_featured_image_filter(var_html rt.PhpVal) string {
}

fn Class_WC_Template_Loader.unsupported_theme_remove_review_tab(var_tabs rt.PhpVal) rt.PhpVal {
}

struct Class_WP_Block_Templates_Registry {
	rt.PhpObjectBase
}

struct Class_WC_Shortcode_Products {
	rt.PhpObjectBase
}

fn create_wc_template_loader() &Class_WC_Template_Loader {
	mut obj := &Class_WC_Template_Loader{
		PhpObjectBase: rt.PhpObjectBase{}
		shop_page_id: rt.new_int(0)
		in_content_filter: rt.new_bool(false)
		theme_support: rt.new_bool(false)
	}
	return obj
}

fn create_wp_block_templates_registry() &Class_WP_Block_Templates_Registry {
	mut obj := &Class_WP_Block_Templates_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_shortcode_products() &Class_WC_Shortcode_Products {
	mut obj := &Class_WC_Shortcode_Products{
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
			return Class_WC_Template_Loader.unsupported_theme_title_filter(dispatch_arg_0, dispatch_arg_1)
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
			return Class_WC_Template_Loader.in_content_filter()
		}
		'unsupported_theme_single_featured_image_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Template_Loader.unsupported_theme_single_featured_image_filter(dispatch_arg_0))
		}
		'unsupported_theme_remove_review_tab' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Template_Loader.unsupported_theme_remove_review_tab(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Template_Loader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'shop_page_id' { return this.shop_page_id }
		'in_content_filter' { return this.in_content_filter }
		'theme_support' { return this.theme_support }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Template_Loader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'shop_page_id' { this.shop_page_id = val; return true }
		'in_content_filter' { this.in_content_filter = val; return true }
		'theme_support' { this.theme_support = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_template_loader_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
