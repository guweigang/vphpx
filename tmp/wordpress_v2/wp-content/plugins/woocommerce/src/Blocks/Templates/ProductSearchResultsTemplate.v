import rt

pub fn Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate.slug() string {
	return 'product-search-results'
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate) init() {
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate', [
				'Automattic_WooCommerce_Blocks_Templates_AbstractTemplate',
			], &this) },
			rt.ArrayItem{ key: none, val: 'render_block_template' },
		])])
	rt.call_function('add_filter', [rt.new_string('search_template_hierarchy'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate', [
				'Automattic_WooCommerce_Blocks_Templates_AbstractTemplate',
			], &this) },
			rt.ArrayItem{ key: none, val: 'update_search_template_hierarchy' },
		]),
		rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate) get_template_title() rt.PhpVal {
	return rt.call_function('_x', [rt.new_string('Product Search Results'),
		rt.new_string('Template name'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate) get_template_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Displays search results for your store.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate) render_block_template() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_embed', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')]))
		&& rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
		mut var_compatibility_layer :=
			create_automattic_woocommerce_blocks_templates_archiveproducttemplatescompatibility()
		var_compatibility_layer.init()
		mut var_templates := rt.call_function('get_block_templates', [
			rt.create_array([
				rt.ArrayItem{ key: 'slug__in', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate.slug()
					},
				]) },
			]),
		])
		mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
		mut iife_result_0 :=
			iife_temp_0.template_has_legacy_template_block(var_templates.array_get(rt.new_int(0)))
		if var_templates.array_isset(rt.new_int(0)) && rt.is_true(iife_result_0) {
			rt.call_function('add_filter', [
				rt.new_string('woocommerce_disable_compatibility_layer'),
				rt.new_string('__return_true'),
			])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate) update_search_template_hierarchy(var_templates rt.PhpVal) rt.PhpVal {
	mut var_templates_mutated := var_templates
	if rt.is_true(rt.call_function('is_search', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_post_type_archive', [rt.new_string('product')]))
		&& rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		rt.call_function('array_unshift', [var_templates_mutated.clone(),
			Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate.slug()])
	}
	return var_templates_mutated.clone()
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

fn create_automattic_woocommerce_blocks_templates_productsearchresultstemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_archiveproducttemplatescompatibility(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blocktemplateutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'update_search_template_hierarchy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_search_template_hierarchy(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}
