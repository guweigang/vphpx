import rt

pub fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.directory_names() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'DEPRECATED_TEMPLATES', val: 'block-templates' }, rt.ArrayItem{ key: 'DEPRECATED_TEMPLATE_PARTS', val: 'block-template-parts' }, rt.ArrayItem{ key: 'TEMPLATES', val: 'templates' }, rt.ArrayItem{ key: 'TEMPLATE_PARTS', val: 'parts' }])
}
pub fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.templates_root_dir() string {
	return 'templates'
}
pub fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.plugin_slug() string {
	return 'woocommerce/woocommerce'
}
pub fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.deprecated_plugin_slug() string {
	return 'woocommerce'
}
struct Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_template(var_template_slug rt.PhpVal) rt.PhpVal {
	mut var_block_templates_registry := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Package{}; return temp.container() }(), 'get', [Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry.class()])
	return rt.call_method(var_block_templates_registry, 'get_template', [var_template_slug.dup()])
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.flatten_blocks(var_blocks rt.PhpVal) rt.PhpVal {
	mut var_blocks_mutated := var_blocks
	mut var_all_blocks := rt.new_array()
	mut var_queue := rt.new_array()
	{
		mut iter_1 := var_blocks_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			// unsupported expression: Expr_AssignRef
		}
	}
	mut var_queue_count := rt.new_int(rt.new_int(var_queue.dup().array_count()))
	for rt.is_true(rt.greater(var_queue_count, rt.new_int(0))) {
		// unsupported expression: Expr_AssignRef
		rt.call_function('array_shift', [var_queue.dup()])
		// unsupported expression: Expr_AssignRef
		if !(!rt.is_true(var_block.array_get('innerBlocks'))) {
			{
				mut iter_1 := var_block.array_get('innerBlocks').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_inner_block := item_1.val
					// unsupported expression: Expr_AssignRef
				}
			}
		}
		var_queue_count = rt.new_int(rt.new_int(var_queue.dup().array_count()))
	}
	return var_all_blocks.dup()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.inject_theme_attribute_in_content(var_template_content rt.PhpVal) rt.PhpVal {
	mut var_template_content_mutated := var_template_content
	mut var_has_updated_content := rt.new_bool(rt.new_bool(false))
	mut var_new_content := rt.new_string(rt.new_string(''))
	mut var_template_blocks := rt.call_function('parse_blocks', [var_template_content_mutated.dup()])
	mut var_blocks := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.flatten_blocks(var_template_blocks.dup())
	{
		mut iter_1 := var_blocks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_block := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('core/template-part'), var_block.array_get('blockName'))) && !(var_block.array_get('attrs').array_isset(rt.new_string('theme'))))) {
				var_block.array_get_mut('attrs').array_set('theme', rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}), 'get_stylesheet', []rt.PhpVal{}))
				var_has_updated_content = rt.new_bool(rt.new_bool(true))
			}
		}
	}
	if rt.is_true(var_has_updated_content) {
		{
			mut iter_1 := var_template_blocks.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_block := item_1.val
				// unsupported expression: Expr_AssignOp_Concat
			}
		}
		return var_new_content.dup()
	}
	return var_template_content_mutated.dup()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.build_template_result_from_post(var_post rt.PhpVal) rt.PhpVal {
	mut var_terms := rt.call_function('get_the_terms', [var_post.dup(), rt.new_string('wp_theme')])
	if rt.is_true(rt.call_function('is_wp_error', [var_terms.dup()])) {
		return mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Utils_WP_Block_Template](var_terms)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_terms)))) {
		return mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Utils_WP_Block_Template](create_automattic_woocommerce_blocks_utils_wp_error(rt.new_string('template_missing_theme'), rt.call_function('__', [rt.new_string('No theme is defined for this template.'), rt.new_string('woocommerce')])))
	}
	mut var_theme := rt.get_property(var_terms.array_get(0), 'name')
	mut var_has_theme_file := rt.new_bool(rt.new_bool(true))
	mut var_template := create_automattic_woocommerce_blocks_utils_wp_block_template()
	rt.set_property(var_template, 'wp_id', rt.get_property(var_post, 'ID'))
	rt.set_property(var_template, 'id', (var_theme).str() + '//' + (rt.get_property(var_post, 'post_name')).str())
	rt.set_property(var_template, 'theme', var_theme.dup())
	rt.set_property(var_template, 'content', rt.get_property(var_post, 'post_content'))
	rt.set_property(var_template, 'slug', rt.get_property(var_post, 'post_name'))
	rt.set_property(var_template, 'source', rt.new_string('custom'))
	rt.set_property(var_template, 'type', rt.get_property(var_post, 'post_type'))
	rt.set_property(var_template, 'description', rt.get_property(var_post, 'post_excerpt'))
	rt.set_property(var_template, 'title', rt.get_property(var_post, 'post_title'))
	rt.set_property(var_template, 'status', rt.get_property(var_post, 'post_status'))
	rt.set_property(var_template, 'has_theme_file', var_has_theme_file.dup())
	rt.set_property(var_template, 'is_custom', rt.new_bool(false))
	rt.set_property(var_template, 'post_types', rt.new_array())
	if rt.is_true(rt.identical(rt.new_string('wp_template_part'), rt.get_property(var_post, 'post_type'))) {
		mut var_type_terms := rt.call_function('get_the_terms', [var_post.dup(), rt.new_string('wp_template_part_area')])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_type_terms.dup()]))))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			rt.set_property(var_template, 'area', rt.get_property(var_type_terms.array_get(0), 'name'))
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.plugin_slug(), var_theme)) || rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.deprecated_plugin_slug(), rt.new_string(var_theme.dup().to_string().to_lower()))))) {
		rt.set_property(var_template, 'origin', rt.new_string('plugin'))
	}
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('inject_ignored_hooked_blocks_metadata_attributes')])) {
		mut var_hooked_blocks := rt.call_function('get_hooked_blocks', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_hooked_blocks)) || rt.is_true(rt.call_function('has_filter', [rt.new_string('hooked_block_types')])))) {
			mut var_before_block_visitor := rt.call_function('make_before_block_visitor', [var_hooked_blocks.dup(), var_template])
			mut var_after_block_visitor := rt.call_function('make_after_block_visitor', [var_hooked_blocks.dup(), var_template])
			mut var_blocks := rt.call_function('parse_blocks', [rt.get_property(var_template, 'content')])
			rt.set_property(var_template, 'content', rt.call_function('traverse_and_serialize_blocks', [var_blocks.dup(), var_before_block_visitor.dup(), var_after_block_visitor.dup()]))
		}
	}
	return mut var_template
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.build_template_result_from_file(var_template_file rt.PhpVal, var_template_type rt.PhpVal) rt.PhpVal {
	mut var_template_file_mutated := var_template_file
	var_template_file_mutated = // unsupported expression: Expr_Cast_Object
	mut var_template_is_from_theme := rt.identical(rt.new_string('theme'), rt.get_property(var_template_file_mutated, 'source'))
	mut var_theme_name := rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}), 'get', [rt.new_string('TextDomain')])
	mut var_template_content := rt.call_function('file_get_contents', [rt.get_property(var_template_file_mutated, 'path')])
	mut var_template := create_automattic_woocommerce_blocks_utils_wp_block_template()
	rt.set_property(var_template, 'id', if rt.is_true(var_template_is_from_theme) { (var_theme_name).str() + '//' + (rt.get_property(var_template_file_mutated, 'slug')).str() } else { (Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.plugin_slug()).str() + '//' + (rt.get_property(var_template_file_mutated, 'slug')).str() })
	rt.set_property(var_template, 'theme', if rt.is_true(var_template_is_from_theme) { var_theme_name } else { Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.plugin_slug() })
	rt.set_property(var_template, 'content', Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.inject_theme_attribute_in_content(var_template_content.dup()))
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate.slug(), rt.get_property(var_template_file_mutated, 'slug'))) {
		rt.set_property(var_template, 'content', rt.call_function('str_replace', [rt.new_string('<!-- wp:term-description {"align":"wide"} /-->'), rt.new_string(''), rt.get_property(var_template, 'content')]))
	}
	rt.set_property(var_template, 'source', if rt.is_true(rt.get_property(var_template_file_mutated, 'source')) { rt.get_property(var_template_file_mutated, 'source') } else { rt.new_string('plugin') })
	rt.set_property(var_template, 'slug', rt.get_property(var_template_file_mutated, 'slug'))
	rt.set_property(var_template, 'type', var_template_type.dup())
	rt.set_property(var_template, 'title', if !(!rt.is_true(rt.get_property(var_template_file_mutated, 'title'))) { rt.get_property(var_template_file_mutated, 'title') } else { Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_block_template_title(rt.get_property(var_template_file_mutated, 'slug')) })
	rt.set_property(var_template, 'description', if !(!rt.is_true(rt.get_property(var_template_file_mutated, 'description'))) { rt.get_property(var_template_file_mutated, 'description') } else { Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_block_template_description(rt.get_property(var_template_file_mutated, 'slug')) })
	rt.set_property(var_template, 'status', rt.new_string('publish'))
	rt.set_property(var_template, 'has_theme_file', rt.new_bool(true))
	rt.set_property(var_template, 'origin', rt.get_property(var_template_file_mutated, 'source'))
	rt.set_property(var_template, 'is_custom', rt.new_bool(false))
	rt.set_property(var_template, 'post_types', rt.new_array())
	rt.set_property(var_template, 'area', Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_block_template_area(rt.get_property(var_template, 'slug'), var_template_type.dup()))
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('inject_ignored_hooked_blocks_metadata_attributes')])) {
		mut var_before_block_visitor := rt.new_string(rt.new_string('_inject_theme_attribute_in_template_part_block'))
		mut var_after_block_visitor := rt.new_null()
		mut var_hooked_blocks := rt.call_function('get_hooked_blocks', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_hooked_blocks)) || rt.is_true(rt.call_function('has_filter', [rt.new_string('hooked_block_types')])))) {
			var_before_block_visitor = rt.call_function('make_before_block_visitor', [var_hooked_blocks.dup(), var_template])
			var_after_block_visitor = rt.call_function('make_after_block_visitor', [var_hooked_blocks.dup(), var_template])
		}
		mut var_blocks := rt.call_function('parse_blocks', [rt.get_property(var_template, 'content')])
		rt.set_property(var_template, 'content', rt.call_function('traverse_and_serialize_blocks', [var_blocks.dup(), var_before_block_visitor.dup(), var_after_block_visitor.dup()]))
	}
	return mut var_template
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.create_new_block_template_object(var_template_file rt.PhpVal, var_template_type rt.PhpVal, var_template_slug rt.PhpVal, template_is_from_theme bool) rt.PhpVal {
	mut var_template_file_mutated := var_template_file
	mut template_is_from_theme_mutated := template_is_from_theme
	mut var_theme_name := rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}), 'get', [rt.new_string('TextDomain')])
	mut var_new_template_item := rt.create_array([rt.ArrayItem{ key: 'slug', val: var_template_slug }, rt.ArrayItem{ key: 'id', val: if rt.is_true(rt.new_bool(template_is_from_theme_mutated)) { (var_theme_name).str() + '//' + (var_template_slug).str() } else { (Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.plugin_slug()).str() + '//' + (var_template_slug).str() } }, rt.ArrayItem{ key: 'path', val: var_template_file_mutated }, rt.ArrayItem{ key: 'type', val: var_template_type }, rt.ArrayItem{ key: 'theme', val: if rt.is_true(rt.new_bool(template_is_from_theme_mutated)) { var_theme_name } else { Class_Automattic_WooCommerce_Blocks_Utils_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.plugin_slug() } }, rt.ArrayItem{ key: 'source', val: if rt.is_true(rt.new_bool(template_is_from_theme_mutated)) { 'theme' } else { 'plugin' } }, rt.ArrayItem{ key: 'title', val: Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_block_template_title(var_template_slug.dup()) }, rt.ArrayItem{ key: 'description', val: Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_block_template_description(var_template_slug.dup()) }, rt.ArrayItem{ key: 'post_types', val: rt.new_array() }])
	return // unsupported expression: Expr_Cast_Object
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_template_paths(var_template_type rt.PhpVal) rt.PhpVal {
	mut var_wp_template_filenames := rt.create_array([rt.ArrayItem{ key: none, val: 'archive-product.html' }, rt.ArrayItem{ key: none, val: 'order-confirmation.html' }, rt.ArrayItem{ key: none, val: 'page-cart.html' }, rt.ArrayItem{ key: none, val: 'page-checkout.html' }, rt.ArrayItem{ key: none, val: 'product-search-results.html' }, rt.ArrayItem{ key: none, val: 'single-product.html' }, rt.ArrayItem{ key: none, val: 'taxonomy-product_attribute.html' }])
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('launch-your-store'))) {
		var_wp_template_filenames.array_push('coming-soon.html')
	}
	mut var_wp_template_part_filenames := rt.create_array([rt.ArrayItem{ key: none, val: 'checkout-header.html' }, rt.ArrayItem{ key: none, val: 'coming-soon-social-links.html' }, rt.ArrayItem{ key: none, val: 'mini-cart.html' }, rt.ArrayItem{ key: none, val: 'simple-product-add-to-cart-with-options.html' }, rt.ArrayItem{ key: none, val: 'external-product-add-to-cart-with-options.html' }, rt.ArrayItem{ key: none, val: 'variable-product-add-to-cart-with-options.html' }, rt.ArrayItem{ key: none, val: 'grouped-product-add-to-cart-with-options.html' }])
	mut var_directory := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_templates_directory(().str())
	mut var_path_list := 
	return .dup()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_templates_directory(template_type string) string {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_block_template_title(var_template_slug rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_block_template_description(var_template_slug rt.PhpVal) string {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_block_template_area(var_template_slug rt.PhpVal, var_template_type rt.PhpVal) string {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.generate_template_slug_from_path(var_path rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_theme_template_path(var_template_slug rt.PhpVal, template_type string) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.theme_has_template(var_template_name rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.theme_has_template_part(var_template_name rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.supports_block_templates(template_type string) bool {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_fallback_template_from_db(var_template_slug rt.PhpVal, var_db_templates rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.remove_templates_with_custom_alternative(var_templates rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.remove_duplicate_customized_templates(var_templates rt.PhpVal) rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.should_use_blockified_product_grid_templates() rt.PhpVal {
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.has_block_including_patterns(var_block_names rt.PhpVal, var_blocks rt.PhpVal) bool {
	mut var_blocks_mutated := var_blocks
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.template_has_legacy_template_block(var_template rt.PhpVal) bool {
	mut var_template_mutated := var_template
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.update_template_data(var_template rt.PhpVal, var_template_type rt.PhpVal) rt.PhpVal {
	mut var_template_mutated := var_template
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_block_templates_from_db(var_slugs rt.PhpVal, template_type string) rt.PhpVal {
	mut var_request_level_cache := rt.new_null()
	mut var_template := rt.new_null()
	mut var_slugs_mutated := var_slugs
}

fn Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_template_part(var_slug rt.PhpVal) rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Blocks_Package {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_WP_Block_Template {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_utils_blocktemplateutils() &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_package() &Class_Automattic_WooCommerce_Blocks_Package {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_wp_error() &Class_Automattic_WooCommerce_Blocks_Utils_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_wp_block_template() &Class_Automattic_WooCommerce_Blocks_Utils_WP_Block_Template {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_WP_Block_Template{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_template(dispatch_arg_0)
		}
		'flatten_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.flatten_blocks(dispatch_arg_0)
		}
		'inject_theme_attribute_in_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.inject_theme_attribute_in_content(dispatch_arg_0)
		}
		'build_template_result_from_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.build_template_result_from_post(dispatch_arg_0)
		}
		'build_template_result_from_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.build_template_result_from_file(dispatch_arg_0, dispatch_arg_1)
		}
		'create_new_block_template_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.create_new_block_template_object(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_template_paths' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_template_paths(dispatch_arg_0)
		}
		'get_templates_directory' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_templates_directory(dispatch_arg_0))
		}
		'get_block_template_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_block_template_title(dispatch_arg_0)
		}
		'get_block_template_description' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_block_template_description(dispatch_arg_0))
		}
		'get_block_template_area' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_block_template_area(dispatch_arg_0, dispatch_arg_1))
		}
		'generate_template_slug_from_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.generate_template_slug_from_path(dispatch_arg_0)
		}
		'get_theme_template_path' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_theme_template_path(dispatch_arg_0, dispatch_arg_1)
		}
		'theme_has_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.theme_has_template(dispatch_arg_0)
		}
		'theme_has_template_part' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.theme_has_template_part(dispatch_arg_0)
		}
		'supports_block_templates' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.supports_block_templates(dispatch_arg_0))
		}
		'get_fallback_template_from_db' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_fallback_template_from_db(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_templates_with_custom_alternative' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.remove_templates_with_custom_alternative(dispatch_arg_0)
		}
		'remove_duplicate_customized_templates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.remove_duplicate_customized_templates(dispatch_arg_0)
		}
		'should_use_blockified_product_grid_templates' {
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.should_use_blockified_product_grid_templates()
		}
		'has_block_including_patterns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.has_block_including_patterns(dispatch_arg_0, dispatch_arg_1))
		}
		'template_has_legacy_template_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.template_has_legacy_template_block(dispatch_arg_0))
		}
		'update_template_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.update_template_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_block_templates_from_db' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_block_templates_from_db(dispatch_arg_0, dispatch_arg_1)
		}
		'get_template_part' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.get_template_part(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_WP_Block_Template) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_WP_Block_Template) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_WP_Block_Template) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_utils_blocktemplateutils_php() {
	// unsupported statement: Stmt_Declare
}
