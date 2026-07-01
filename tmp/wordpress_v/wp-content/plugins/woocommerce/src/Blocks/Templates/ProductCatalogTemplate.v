import rt

pub fn Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate.slug() string {
	return 'archive-product'
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate) init() {
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate', [
				'Automattic_WooCommerce_Blocks_Templates_AbstractTemplate',
			], &this) },
			rt.ArrayItem{ key: none, val: 'render_block_template' },
		])])
	rt.call_function('add_filter', [
		rt.new_string('current_theme_supports-block-templates'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate', [
				'Automattic_WooCommerce_Blocks_Templates_AbstractTemplate',
			], &this) },
			rt.ArrayItem{ key: none, val: 'remove_block_template_support_for_shop_page' },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate) get_template_title() rt.PhpVal {
	return rt.call_function('_x', [rt.new_string('Product Catalog'),
		rt.new_string('Template name'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate) get_template_description() rt.PhpVal {
	return rt.call_function('__', [rt.new_string('Displays your products.'),
		rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate) render_block_template() {
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_embed', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')]))
		|| rt.is_true(rt.call_function('is_page', [rt.call_function('wc_get_page_id', [rt.new_string('shop')])]))))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_search', []rt.PhpVal{})))))))
	{
		mut var_compatibility_layer :=
			create_automattic_woocommerce_blocks_templates_archiveproducttemplatescompatibility()
		var_compatibility_layer.init()
		mut var_templates := rt.call_function('get_block_templates', [
			rt.create_array([
				rt.ArrayItem{ key: 'slug__in', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate.slug()
					},
				]) },
			]),
		])
		if rt.is_true(rt.new_bool(var_templates.array_isset(rt.new_int(0)) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
			return temp.template_has_legacy_template_block(arg_0)
		}(var_templates.array_get(0)))))
		{
			rt.call_function('add_filter', [
				rt.new_string('woocommerce_disable_compatibility_layer'),
				rt.new_string('__return_true'),
			])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate) remove_block_template_support_for_shop_page(var_is_support rt.PhpVal) bool {
	mut var_pagenow := rt.new_null()
	mut var_post := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))
		&& rt.is_true(rt.identical(rt.new_string('post.php'), var_pagenow))))
		&& rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_get_page_id')]))))
		&& rt.is_true(rt.call_function('is_a', [var_post.dup(), rt.new_string('WP_Post')]))))
		&& rt.is_true(rt.identical(rt.call_function('wc_get_page_id', [rt.new_string('shop')]), rt.get_property(var_post, 'ID')))))
	{
		return false
	}
	return var_is_support.to_bool()
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_productcatalogtemplate() &Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplate() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_archiveproducttemplatescompatibility() &Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_template_title' {
			return this.get_template_title()
		}
		'get_template_description' {
			return this.get_template_description()
		}
		'render_block_template' {
			this.render_block_template()
			return rt.new_null()
		}
		'remove_block_template_support_for_shop_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.remove_block_template_support_for_shop_page(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_templates_productcatalogtemplate_php() {
}
