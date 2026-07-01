import rt

pub fn Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate.slug() string {
	return 'taxonomy-product_attribute'
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate {
	rt.PhpObjectBase
pub mut:
	fallback_template rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate) get_template_title() rt.PhpVal {
	return rt.call_function('_x', [rt.new_string('Products by Attribute'),
		rt.new_string('Template name'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate) get_template_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Displays products filtered by an attribute.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate) render_block_template() {
	mut var_queried_object := rt.call_function('get_queried_object', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(var_queried_object.dup().is_null())) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.get_property(var_queried_object, 'taxonomy')).is_null()
		&& rt.is_true(rt.call_function('taxonomy_is_product_attribute', [rt.get_property(var_queried_object, 'taxonomy')]))))
	{
		mut var_compatibility_layer :=
			create_automattic_woocommerce_blocks_templates_archiveproducttemplatescompatibility()
		var_compatibility_layer.init()
		mut var_templates := rt.call_function('get_block_templates', [
			rt.create_array([
				rt.ArrayItem{ key: 'slug__in', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate.slug()
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate) template_hierarchy(var_templates rt.PhpVal) rt.PhpVal {
	mut var_templates_mutated := var_templates
	mut var_queried_object := rt.call_function('get_queried_object', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_queried_object.dup().is_null())))))
		&& rt.is_true(rt.call_function('taxonomy_is_product_attribute', [rt.get_property(var_queried_object, 'taxonomy')]))))
		&& rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))
	{
		mut var_slugs := rt.create_array([
			rt.ArrayItem{ key: none, val: this.fallback_template },
		])
		if rt.is_true(rt.new_bool(rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
			return temp.theme_has_template(arg_0)
		}(Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate.slug())) || rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
			return temp.get_block_templates_from_db(arg_0)
		}(rt.create_array([rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate.slug()
		}])))))
		{
			var_slugs = rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Blocks_Templates_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate.slug()
				},
				rt.ArrayItem{ key: none, val: this.fallback_template },
			])
		}
		rt.call_function('array_splice', [var_templates_mutated.dup(), var_templates_mutated.dup().array_count() - 1,
			rt.new_int(0), var_slugs.dup()])
	}
	return var_templates_mutated.dup()
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

fn create_automattic_woocommerce_blocks_templates_productattributetemplate() &Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate{
		PhpObjectBase:     rt.PhpObjectBase{}
		fallback_template: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplatewithfallback() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplateWithFallback{
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'template_hierarchy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.template_hierarchy(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fallback_template' { return this.fallback_template }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fallback_template' {
			this.fallback_template = val
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_templates_productattributetemplate_php() {
	// unsupported statement: Stmt_Declare
}
