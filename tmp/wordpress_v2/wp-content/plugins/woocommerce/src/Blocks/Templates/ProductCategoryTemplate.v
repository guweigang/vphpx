import rt

pub fn Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate.slug() string {
	return 'taxonomy-product_cat'
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate {
	rt.PhpObjectBase
pub mut:
	fallback_template    rt.PhpVal = rt.new_null()
	is_taxonomy_template rt.PhpVal = rt.new_bool(true)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate) get_template_title() rt.PhpVal {
	return rt.call_function('_x', [rt.new_string('Products by Category'),
		rt.new_string('Template name'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate) get_template_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Displays products filtered by a category.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate) render_block_template() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_embed', []rt.PhpVal{})))))
		&& rt.is_true(rt.call_function('is_product_taxonomy', []rt.PhpVal{}))
		&& rt.is_true(rt.call_function('is_tax', [rt.new_string('product_cat')])) {
		mut var_compatibility_layer :=
			create_automattic_woocommerce_blocks_templates_archiveproducttemplatescompatibility()
		var_compatibility_layer.init()
		mut var_templates := rt.call_function('get_block_templates', [
			rt.create_array([
				rt.ArrayItem{ key: 'slug__in', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate.slug()
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
		rt.call_function('add_filter', [rt.new_string('woocommerce_has_block_template'),
			rt.new_string('__return_true'), rt.new_int(10), rt.new_int(0)])
	}
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ArchiveProductTemplatesCompatibility {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_productcategorytemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate{
		PhpObjectBase:        rt.PhpObjectBase{}
		fallback_template:    rt.new_null()
		is_taxonomy_template: rt.new_bool(true)
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplatewithfallback(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fallback_template' { return this.fallback_template }
		'is_taxonomy_template' { return this.is_taxonomy_template }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fallback_template' {
			this.fallback_template = val
			return true
		}
		'is_taxonomy_template' {
			this.is_taxonomy_template = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
