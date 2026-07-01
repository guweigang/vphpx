import rt

pub fn Class_Automattic_WooCommerce_Blocks_BlockTemplatesController.templates_root_dir() string {
	return 'templates'
}
struct Class_Automattic_WooCommerce_Blocks_BlockTemplatesController {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) init()  {
	rt.call_function('add_filter', [rt.new_string('pre_get_block_file_template'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_block_file_template' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('get_block_template'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_block_template_details' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('get_block_templates'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_db_templates_with_woo_slug' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('rest_pre_insert_wp_template'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'dont_load_templates_for_suggestions' }]), rt.new_int(10), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('block_type_metadata_settings'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_plugin_templates_parts_support' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('block_type_metadata_settings'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'prevent_shortcodes_html_breakage' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('current_screen'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'hide_template_selector_in_cart_checkout_pages' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'dequeue_legacy_scripts' }]), rt.new_int(20)])
	if rt.is_true(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_Utils{}; return temp.wp_version_compare(arg_0, arg_1) }(rt.new_string('6.8'), rt.new_string('<='))) {
		rt.call_function('add_filter', [rt.new_string('get_block_templates'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'run_hooks_on_block_templates' }]), rt.new_int(10), rt.new_int(3)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) dequeue_legacy_scripts()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_function('is_product', []rt.PhpVal{})) {
		rt.call_function('wp_dequeue_script', [rt.new_string('wc-single-product')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) render_woocommerce_template_part(var_attributes rt.PhpVal) string {
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('theme')) && rt.is_true(rt.identical(rt.new_string('woocommerce/woocommerce'), var_attributes.array_get('theme'))))) {
		mut var_template_part := rt.call_function('get_block_template', [(var_attributes.array_get('theme')).str() + '//' + (var_attributes.array_get('slug')).str(), rt.new_string('wp_template_part')])
		if rt.is_true(rt.new_bool(rt.is_true(var_template_part) && !(!rt.is_true(rt.get_property(var_template_part, 'content'))))) {
			mut var_content := rt.call_function('do_blocks', [rt.get_property(var_template_part, 'content')])
			if rt.is_true(rt.new_bool(!rt.is_true(var_attributes.array_get('tagName')) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				mut var_html_tag := rt.new_string(rt.new_string('div'))
			} else {
				var_html_tag = rt.call_function('esc_attr', [var_attributes.array_get('tagName')])
			}
			mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
			return "<${var_html_tag.to_string()} ${var_wrapper_attributes.to_string()}>" + (rt.call_function('str_replace', [rt.new_string(']]>'), rt.new_string(']]&gt;'), var_content.dup()])).str() + "</${var_html_tag.to_string()}>"
		}
	}
	return (if rt.is_true(rt.call_function('function_exists', [rt.new_string('\\gutenberg_render_block_core_template_part')])) { rt.call_function('gutenberg_render_block_core_template_part', [var_attributes.dup()]) } else { rt.call_function('render_block_core_template_part', [var_attributes.dup()]) }).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) add_plugin_templates_parts_support(var_settings rt.PhpVal, var_metadata rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_metadata.array_isset(rt.new_string('name')) && var_settings_mutated.array_isset(rt.new_string('render_callback')) && rt.is_true(rt.identical(rt.new_string('core/template-part'), var_metadata.array_get('name'))))) && rt.is_true(rt.call_function('in_array', [var_settings_mutated.array_get('render_callback'), rt.create_array([rt.ArrayItem{ key: none, val: 'render_block_core_template_part' }, rt.ArrayItem{ key: none, val: 'gutenberg_render_block_core_template_part' }]), rt.new_bool(true)])))) {
		var_settings_mutated.array_set('render_callback', rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_woocommerce_template_part' }]))
	}
	return var_settings_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) prevent_shortcodes_html_breakage(var_settings rt.PhpVal, var_metadata rt.PhpVal) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.new_bool(var_metadata.array_isset(rt.new_string('name')) && var_settings_mutated.array_isset(rt.new_string('render_callback')) && rt.is_true(rt.identical(rt.new_string('core/shortcode'), var_metadata.array_get('name'))))) {
		var_settings_mutated.array_set('original_render_callback', var_settings_mutated.array_get('render_callback'))
		closure_1_fn := fn [var_settings] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_attributes := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_content := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('strstr', [var_content.dup(), rt.new_string('woocommerce-cart-form')])) || rt.is_true(rt.call_function('strstr', [var_content.dup(), rt.new_string('wc-empty-cart-message')])))) || rt.is_true(rt.call_function('strstr', [var_content.dup(), rt.new_string('woocommerce-checkout-form')])))) {
		return var_content.dup()
	}
	mut var_render_callback := var_settings_mutated.array_get('original_render_callback')
	return rt.call_callable(var_render_callback, [var_attributes.dup(), var_content.dup()])
	}
		var_settings_mutated.array_set('render_callback', rt.new_closure(closure_1_fn))
	}
	return var_settings_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) hide_template_selector_in_cart_checkout_pages()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_current_screen) && rt.is_true(rt.identical(rt.new_string('page'), rt.get_property(var_current_screen, 'id'))))) && !(!rt.is_true(rt.get_superglobal('_GET').array_get('post'))))) && rt.is_true(rt.call_function('in_array', [rt.call_function('absint', [rt.get_superglobal('_GET').array_get('post')]), rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_id', [rt.new_string('cart')]) }, rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_id', [rt.new_string('checkout')]) }]), rt.new_bool(true)])))) {
		rt.call_function('wp_add_inline_style', [rt.new_string('wc-blocks-editor-style'), rt.new_string('.edit-post-post-template { display: none; }')])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) get_block_file_template(var_template rt.PhpVal, var_id rt.PhpVal, var_template_type rt.PhpVal) rt.PhpVal {
	mut var_template_id := rt.new_null()
	mut var_template_slug := rt.new_null()
	mut var_template_mutated := var_template
	mut var_template_name_parts := rt.call_function('explode', [rt.new_string('//'), var_id.dup()])
	if var_template_name_parts.dup().array_count() < 2 {
		return var_template_mutated.dup()
	}
	// unsupported assign target: Expr_List
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.deprecated_plugin_slug(), rt.new_string(var_template_id.dup().to_string().to_lower()))) {
		rt.call_function('remove_filter', [rt.new_string('pre_get_block_file_template'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_block_file_template' }]), rt.new_int(10), rt.new_int(3)])
		mut var_template_with_deprecated_id := rt.call_function('get_block_template', [var_id.dup(), var_template_type.dup()])
		rt.call_function('add_filter', [rt.new_string('pre_get_block_file_template'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_block_file_template' }]), rt.new_int(10), rt.new_int(3)])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			return var_template_with_deprecated_id.dup()
		}
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_template_mutated.dup()
	}
	if !(this.block_template_is_available(var_template_slug.dup(), (var_template_type).str())) {
		return var_template_mutated.dup()
	}
	mut var_directory := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.get_templates_directory(arg_0) }(var_template_type.dup())
	mut var_template_file_path := rt.new_string((var_directory).str() + '/' + (var_template_slug).str() + '.html')
	mut var_template_object := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.create_new_block_template_object(arg_0, arg_1, arg_2) }(var_template_file_path.dup(), var_template_type.dup(), var_template_slug.dup())
	mut var_template_built := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.build_template_result_from_file(arg_0, arg_1) }(var_template_object.dup(), var_template_type.dup())
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_template_built.dup()
	}
	return var_template_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) add_block_template_details(var_block_template rt.PhpVal, var_id rt.PhpVal, var_template_type rt.PhpVal) rt.PhpVal {
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.update_template_data(arg_0, arg_1) }(var_block_template.dup(), var_template_type.dup())
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) run_hooks_on_block_templates(var_templates rt.PhpVal) rt.PhpVal {
	mut var_templates_mutated := var_templates
	{
		mut iter_1 := var_templates_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('plugin'), rt.get_property(var_template, 'source'))) && rt.is_true(rt.identical(rt.new_string('woocommerce'), rt.get_property(var_template, 'plugin'))))) {
				rt.set_property(var_template, 'content', rt.call_function('apply_block_hooks_to_content', [rt.get_property(var_template, 'content'), var_template.dup(), rt.new_string('insert_hooked_blocks_and_set_ignored_hooked_blocks_metadata')]))
			}
		}
	}
	return var_templates_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) add_db_templates_with_woo_slug(var_query_result rt.PhpVal, var_query rt.PhpVal, var_template_type rt.PhpVal) rt.PhpVal {
	mut var_query_result_mutated := var_query_result
	mut var_slugs := if var_query.array_isset(rt.new_string('slug__in')) { var_query.array_get('slug__in') } else { rt.new_array() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.supports_block_templates(arg_0) }(var_template_type.dup()))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate.slug(), var_slugs.dup(), rt.new_bool(true)]))))))) {
		return var_query_result_mutated.dup()
	}
	mut var_template_files := if rt.is_true(rt.identical(rt.new_string('wp_template'), var_template_type)) { fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.get_block_templates_from_db(arg_0, arg_1) }(var_slugs.dup(), var_template_type.dup()) } else { this.get_block_templates(var_slugs.dup(), (var_template_type).str()) }
	mut var_new_templates := rt.new_array()
	{
		mut iter_1 := var_template_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template_file := item_1.val
			if rt.is_true(rt.identical(rt.new_string('custom'), rt.get_property(var_template_file, 'source'))) {
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.plugin_slug(), rt.get_property(var_template_file, 'theme'))) || rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.deprecated_plugin_slug(), rt.get_property(var_template_file, 'theme'))))) {
					rt.call_function('array_unshift', [var_new_templates.dup(), var_template_file.dup()])
				}
				continue
			}
			if rt.is_true(rt.identical(rt.new_string('wp_template_part'), var_template_type)) {
				mut var_theme_slug := rt.call_function('get_stylesheet', []rt.PhpVal{})
				mut var_possible_template_ids := rt.create_array([rt.ArrayItem{ key: none, val: (var_theme_slug).str() + '//' + (rt.get_property(var_template_file, 'slug')).str() }, rt.ArrayItem{ key: none, val: (var_theme_slug).str() + '//' + (Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.directory_names().array_get('TEMPLATE_PARTS')).str() + '/' + (rt.get_property(var_template_file, 'slug')).str() }, rt.ArrayItem{ key: none, val: (var_theme_slug).str() + '//' + (Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils.directory_names().array_get('DEPRECATED_TEMPLATE_PARTS')).str() + '/' + (rt.get_property(var_template_file, 'slug')).str() }])
				mut var_is_custom := rt.new_bool(rt.new_bool(false))
				mut var_query_result_template_ids := rt.call_function('array_column', [var_query_result_mutated.dup(), rt.new_string('id')])
				{
					mut iter_2 := var_possible_template_ids.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_template_id := item_2.val
						if rt.is_true(rt.call_function('in_array', [var_template_id.dup(), var_query_result_template_ids.dup(), rt.new_bool(true)])) {
							var_is_custom = rt.new_bool(rt.new_bool(true))
							break
						}
					}
				}
				mut var_fits_slug_query := rt.new_bool(rt.new_bool(!(var_query.array_isset(rt.new_string('slug__in'))) || rt.is_true(rt.call_function('in_array', [rt.get_property(var_template_file, 'slug'), var_query.array_get('slug__in'), rt.new_bool(true)]))))
				mut var_fits_area_query := rt.new_bool(rt.new_bool(!(var_query.array_isset(rt.new_string('area'))) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('property_exists', [var_template_file.dup(), rt.new_string('area')])) && rt.is_true(rt.identical(rt.get_property(var_template_file, 'area'), var_query.array_get('area')))))))
				mut var_is_from_filesystem := rt.new_bool(!(rt.get_property(var_template_file, 'path')).is_null())
				mut var_should_include := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_custom)))) && rt.is_true(var_fits_slug_query))) && rt.is_true(var_fits_area_query))) && rt.is_true(var_is_from_filesystem)))
				if rt.is_true(var_should_include) {
					mut var_template := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.build_template_result_from_file(arg_0, arg_1) }(var_template_file.dup(), var_template_type.dup())
					var_query_result_mutated.array_push(var_template.dup())
				}
			}
		}
	}
	var_query_result_mutated = rt.call_function('array_merge', [var_new_templates.dup(), var_query_result_mutated.dup()])
	if var_new_templates.dup().array_count() > 0 {
		var_query_result_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.remove_templates_with_custom_alternative(arg_0) }(var_query_result_mutated.dup())
		var_query_result_mutated = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.remove_duplicate_customized_templates(arg_0) }(var_query_result_mutated.dup())
	}
	closure_3_fn := fn [var_template_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn [var_template_type] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.update_template_data(arg_0, arg_1) }(var_template.dup(), var_template_type.dup())
	}
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.update_template_data(arg_0, arg_1) }(var_template.dup(), var_template_type.dup())
	}
	var_query_result_mutated = rt.call_function('array_map', [rt.new_closure(closure_2_fn), var_query_result_mutated.dup()])
	return var_query_result_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) dont_load_templates_for_suggestions(var_prepared_post rt.PhpVal) rt.PhpVal {
	if rt.get_property(var_prepared_post, 'meta_input').array_isset(rt.new_string('is_wp_suggestion')) {
		rt.call_function('remove_filter', [rt.new_string('get_block_templates'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTemplatesController', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_db_templates_with_woo_slug' }]), rt.new_int(10), rt.new_int(3)])
	}
	return var_prepared_post.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) get_block_templates_from_woocommerce(var_slugs rt.PhpVal, var_already_found_templates rt.PhpVal, template_type string) rt.PhpVal {
	mut var_slugs_mutated := var_slugs
	mut var_template_files := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.get_template_paths(arg_0) }(rt.new_string(template_type))
	mut var_templates := rt.new_array()
	{
		mut iter_1 := var_template_files.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template_file := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.should_use_blockified_product_grid_templates() }())))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				continue
			}
			mut var_template_slug := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.generate_template_slug_from_path(arg_0) }(var_template_file.dup())
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_slugs_mutated.dup().is_array())) && var_slugs_mutated.dup().array_count() > 0)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_template_slug.dup(), var_slugs_mutated.dup(), rt.new_bool(true)]))))))) {
				continue
			}
			closure_7_fn := fn [var_template_slug] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_6_fn := fn [var_template_slug] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_5_fn := fn [var_template_slug] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_4_fn := fn [var_template_slug] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_template_obj := // unsupported expression: Expr_Cast_Object
	return rt.identical(rt.get_property(var_template_obj, 'slug'), var_template_slug)
	}
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_template_obj := // unsupported expression: Expr_Cast_Object
	return rt.identical(rt.get_property(var_template_obj, 'slug'), var_template_slug)
	}
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_template_obj := 
	return 
	}
	mut var_template := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	}
			if rt.is_true(rt.new_bool(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.theme_has_template(arg_0) }(var_template_slug.dup())) || rt.call_function('array_filter', [var_already_found_templates.dup(), rt.new_closure(closure_6_fn)]).array_count() > 0)) {
				continue
			}
			var_templates.array_push(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}; return temp.create_new_block_template_object(arg_0, arg_1, arg_2) }(var_template_file.dup(), rt.new_string(template_type), var_template_slug.dup()))
		}
	}
	return var_templates.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) get_block_templates(var_slugs rt.PhpVal, template_type string) rt.PhpVal {
	mut var_slugs_mutated := var_slugs
	mut var_templates_from_db := 
	
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) block_template_is_available(var_template_name rt.PhpVal, template_type string) bool {
}

struct Class_Automattic_WooCommerce_Blocks_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktemplatescontroller() &Class_Automattic_WooCommerce_Blocks_BlockTemplatesController {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTemplatesController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_utils() &Class_Automattic_WooCommerce_Blocks_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blocktemplateutils() &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'dequeue_legacy_scripts' {
			this.dequeue_legacy_scripts()
			return rt.new_null()
		}
		'render_woocommerce_template_part' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render_woocommerce_template_part(dispatch_arg_0))
		}
		'add_plugin_templates_parts_support' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_plugin_templates_parts_support(dispatch_arg_0, dispatch_arg_1)
		}
		'prevent_shortcodes_html_breakage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prevent_shortcodes_html_breakage(dispatch_arg_0, dispatch_arg_1)
		}
		'hide_template_selector_in_cart_checkout_pages' {
			this.hide_template_selector_in_cart_checkout_pages()
			return rt.new_null()
		}
		'get_block_file_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_block_file_template(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'add_block_template_details' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.add_block_template_details(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'run_hooks_on_block_templates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.run_hooks_on_block_templates(dispatch_arg_0)
		}
		'add_db_templates_with_woo_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.add_db_templates_with_woo_slug(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'dont_load_templates_for_suggestions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.dont_load_templates_for_suggestions(dispatch_arg_0)
		}
		'get_block_templates_from_woocommerce' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_block_templates_from_woocommerce(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'get_block_templates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_block_templates(dispatch_arg_0, dispatch_arg_1)
		}
		'block_template_is_available' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.block_template_is_available(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktemplatescontroller_php() {
	// unsupported statement: Stmt_Declare
}
