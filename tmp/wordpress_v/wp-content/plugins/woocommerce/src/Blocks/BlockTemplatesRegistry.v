import rt

struct Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry {
	rt.PhpObjectBase
pub mut:
	templates rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry) init() {
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
		return temp.supports_block_templates(arg_0)
	}(rt.new_string('wp_template')))
	{
		mut var_templates := rt.create_array([
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate.slug()
				val: create_automattic_woocommerce_blocks_templates_productcatalogtemplate()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate.slug()
				val: create_automattic_woocommerce_blocks_templates_productcategorytemplate()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Blocks_Templates_ProductTagTemplate.slug()
				val: create_automattic_woocommerce_blocks_templates_producttagtemplate()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate.slug()
				val: create_automattic_woocommerce_blocks_templates_productattributetemplate()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Blocks_Templates_ProductBrandTemplate.slug()
				val: create_automattic_woocommerce_blocks_templates_productbrandtemplate()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate.slug()
				val: create_automattic_woocommerce_blocks_templates_productsearchresultstemplate()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate.slug()
				val: create_automattic_woocommerce_blocks_templates_carttemplate()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Blocks_Templates_CheckoutTemplate.slug()
				val: create_automattic_woocommerce_blocks_templates_checkouttemplate()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate.slug()
				val: create_automattic_woocommerce_blocks_templates_orderconfirmationtemplate()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate.slug()
				val: create_automattic_woocommerce_blocks_templates_singleproducttemplate()
			},
		])
	} else {
		var_templates = rt.new_array()
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}
		return temp.is_enabled(arg_0)
	}(rt.new_string('launch-your-store')))
	{
		var_templates.array_set(Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate.slug(),
			create_automattic_woocommerce_blocks_templates_comingsoontemplate())
	}
	if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
		return temp.supports_block_templates(arg_0)
	}(rt.new_string('wp_template_part')))
	{
		mut var_template_parts := rt.create_array([
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate.slug()
				val: create_automattic_woocommerce_blocks_templates_minicarttemplate()
			},
			rt.ArrayItem{
				key: Class_Automattic_WooCommerce_Blocks_Templates_CheckoutHeaderTemplate.slug()
				val: create_automattic_woocommerce_blocks_templates_checkoutheadertemplate()
			},
		])
		if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
			mut var_product_types := rt.call_function('wc_get_product_types', []rt.PhpVal{})
			if var_product_types.dup().array_count() > 0 {
				rt.call_function('add_filter', [
					rt.new_string('default_wp_template_part_areas'),
					rt.create_array([
						rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTemplatesRegistry',
							[]string{}, &this) },
						rt.ArrayItem{
							key: none
							val: 'register_add_to_cart_with_options_template_part_area'
						},
					]),
					rt.new_int(10),
					rt.new_int(1),
				])
				if rt.is_true(rt.new_bool(var_product_types.dup().array_isset(Class_Automattic_WooCommerce_Enums_ProductType.simple()))) {
					var_template_parts.array_set(Class_Automattic_WooCommerce_Blocks_Templates_SimpleProductAddToCartWithOptionsTemplate.slug(),
						create_automattic_woocommerce_blocks_templates_simpleproductaddtocartwithoptionstemplate())
				}
				if rt.is_true(rt.new_bool(var_product_types.dup().array_isset(Class_Automattic_WooCommerce_Enums_ProductType.external()))) {
					var_template_parts.array_set(Class_Automattic_WooCommerce_Blocks_Templates_ExternalProductAddToCartWithOptionsTemplate.slug(),
						create_automattic_woocommerce_blocks_templates_externalproductaddtocartwithoptionstemplate())
				}
				if rt.is_true(rt.new_bool(var_product_types.dup().array_isset(Class_Automattic_WooCommerce_Enums_ProductType.variable()))) {
					var_template_parts.array_set(Class_Automattic_WooCommerce_Blocks_Templates_VariableProductAddToCartWithOptionsTemplate.slug(),
						create_automattic_woocommerce_blocks_templates_variableproductaddtocartwithoptionstemplate())
				}
				if rt.is_true(rt.new_bool(var_product_types.dup().array_isset(Class_Automattic_WooCommerce_Enums_ProductType.grouped()))) {
					var_template_parts.array_set(Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate.slug(),
						create_automattic_woocommerce_blocks_templates_groupedproductaddtocartwithoptionstemplate())
				}
			}
		}
	} else {
		var_template_parts = rt.new_array()
	}
	{
		mut iter_1 := var_templates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template := item_1.val
			rt.call_method(var_template, 'init', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_template,
				'is_taxonomy_template')))))
			{
				mut var_directory := fn (arg_0 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{}
					return temp.get_templates_directory(arg_0)
				}(rt.new_string('wp_template'))
				mut var_template_file_path := rt.new_string(var_directory.str() + '/' + (Class_Automattic_WooCommerce_Blocks_{
					nodeType: 'Expr_Variable'
					line:     100
					name:     'template'
				}.slug()).str() + '.html')
				rt.call_function('register_block_template', [
					'woocommerce//' + (Class_Automattic_WooCommerce_Blocks_{
						nodeType: 'Expr_Variable'
						line:     102
						name:     'template'
					}.slug()).str(),
					rt.create_array([
						rt.ArrayItem{ key: 'title', val: rt.call_method(var_template,
							'get_template_title', []rt.PhpVal{}) },
						rt.ArrayItem{ key: 'description', val: rt.call_method(var_template,
							'get_template_description', []rt.PhpVal{}) },
						rt.ArrayItem{ key: 'content', val: rt.call_function('file_get_contents', [
							var_template_file_path.dup(),
						]) },
					]),
				])
			}
		}
	}
	{
		mut iter_1 := var_template_parts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template_part := item_1.val
			rt.call_method(var_template_part, 'init', []rt.PhpVal{})
		}
	}
	this.templates = rt.call_function('array_merge', [var_templates.dup(),
		var_template_parts.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry) register_add_to_cart_with_options_template_part_area(var_default_area_definitions rt.PhpVal) rt.PhpVal {
	mut var_add_to_cart_with_options_template_part_area := rt.create_array([
		rt.ArrayItem{ key: 'area', val: 'add-to-cart-with-options' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Add to Cart + Options'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The Add to Cart + Options templates allow defining a different layout for each product type.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'icon', val: 'add-to-cart-with-options' },
		rt.ArrayItem{ key: 'area_tag', val: 'add-to-cart-with-options' },
	])
	return rt.call_function('array_merge', [var_default_area_definitions.dup(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: var_add_to_cart_with_options_template_part_area },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry) get_template(var_template_slug rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(this.templates.array_isset(var_template_slug.dup()))) {
		mut var_registered_template := this.templates.array_get(var_template_slug)
		return var_registered_template.dup()
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ProductTagTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ProductBrandTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_CheckoutTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_CheckoutHeaderTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_SimpleProductAddToCartWithOptionsTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ExternalProductAddToCartWithOptionsTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_VariableProductAddToCartWithOptionsTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktemplatesregistry() &Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
		templates:     rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_blocktemplateutils() &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlockTemplateUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_productcatalogtemplate() &Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_productcategorytemplate() &Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_producttagtemplate() &Class_Automattic_WooCommerce_Blocks_Templates_ProductTagTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ProductTagTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_productattributetemplate() &Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_productbrandtemplate() &Class_Automattic_WooCommerce_Blocks_Templates_ProductBrandTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ProductBrandTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_productsearchresultstemplate() &Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_carttemplate() &Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_checkouttemplate() &Class_Automattic_WooCommerce_Blocks_Templates_CheckoutTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_CheckoutTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_orderconfirmationtemplate() &Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_singleproducttemplate() &Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate{
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

fn create_automattic_woocommerce_blocks_templates_comingsoontemplate() &Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_minicarttemplate() &Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_checkoutheadertemplate() &Class_Automattic_WooCommerce_Blocks_Templates_CheckoutHeaderTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_CheckoutHeaderTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_simpleproductaddtocartwithoptionstemplate() &Class_Automattic_WooCommerce_Blocks_Templates_SimpleProductAddToCartWithOptionsTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_SimpleProductAddToCartWithOptionsTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_externalproductaddtocartwithoptionstemplate() &Class_Automattic_WooCommerce_Blocks_Templates_ExternalProductAddToCartWithOptionsTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ExternalProductAddToCartWithOptionsTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_variableproductaddtocartwithoptionstemplate() &Class_Automattic_WooCommerce_Blocks_Templates_VariableProductAddToCartWithOptionsTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_VariableProductAddToCartWithOptionsTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_groupedproductaddtocartwithoptionstemplate() &Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'register_add_to_cart_with_options_template_part_area' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_add_to_cart_with_options_template_part_area(dispatch_arg_0)
		}
		'get_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_template(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'templates' { return this.templates }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTemplatesRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'templates' {
			this.templates = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCatalogTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductCategoryTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductTagTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ProductTagTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductTagTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductAttributeTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductBrandTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ProductBrandTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductBrandTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ProductSearchResultsTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_CartTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_CheckoutTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_CheckoutTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_CheckoutTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_OrderConfirmationTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SingleProductTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_CheckoutHeaderTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_CheckoutHeaderTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_CheckoutHeaderTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SimpleProductAddToCartWithOptionsTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_SimpleProductAddToCartWithOptionsTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_SimpleProductAddToCartWithOptionsTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ExternalProductAddToCartWithOptionsTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ExternalProductAddToCartWithOptionsTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ExternalProductAddToCartWithOptionsTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_VariableProductAddToCartWithOptionsTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_VariableProductAddToCartWithOptionsTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_VariableProductAddToCartWithOptionsTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_blocktemplatesregistry_php() {
	// unsupported statement: Stmt_Declare
}
