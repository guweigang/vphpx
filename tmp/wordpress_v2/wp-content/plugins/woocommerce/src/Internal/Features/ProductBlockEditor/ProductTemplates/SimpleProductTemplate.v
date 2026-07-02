import rt

pub fn Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate.group_ids() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'GENERAL', val: 'general' },
		rt.ArrayItem{ key: 'ORGANIZATION', val: 'organization' },
		rt.ArrayItem{ key: 'INVENTORY', val: 'inventory' }, rt.ArrayItem{
			key: 'SHIPPING'
			val: 'shipping'
		}, rt.ArrayItem{ key: 'VARIATIONS', val: 'variations' },
		rt.ArrayItem{ key: 'LINKED_PRODUCTS', val: 'linked-products' }])
}

struct Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) construct() {
	this.add_group_blocks()
	this.add_general_group_blocks()
	this.add_organization_group_blocks()
	this.add_inventory_group_blocks()
	this.add_shipping_group_blocks()
	this.add_variation_group_blocks()
	this.add_linked_products_group_blocks()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) get_id() string {
	return 'simple-product'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) get_title() string {
	return (rt.call_function('__', [rt.new_string('Simple Product Template'),
		rt.new_string('woocommerce')])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) get_description() string {
	return (rt.call_function('__', [
		rt.new_string('Template for the simple product form'),
		rt.new_string('woocommerce'),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) add_group_blocks() {
	this.add_group(rt.create_array([
		rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
			nodeType: 'Expr_Variable'
			line:     73
			name:     'this'
		}.group_ids().array_get(rt.new_string('GENERAL')) },
		rt.ArrayItem{ key: 'order', val: 10 },
		rt.ArrayItem{ key: 'attributes', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('General'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	]))
	mut var_variations_hide_conditions := rt.new_array()
	var_variations_hide_conditions.array_push(rt.create_array([
		rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "grouped"' },
	]))
	var_variations_hide_conditions.array_push(rt.create_array([
		rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "external"' },
	]))
	this.add_group(rt.create_array([
		rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
			nodeType: 'Expr_Variable'
			line:     92
			name:     'this'
		}.group_ids().array_get(rt.new_string('VARIATIONS')) },
		rt.ArrayItem{ key: 'order', val: 20 },
		rt.ArrayItem{ key: 'attributes', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Variations'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'hideConditions', val: var_variations_hide_conditions },
	]))
	this.add_group(rt.create_array([
		rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
			nodeType: 'Expr_Variable'
			line:     103
			name:     'this'
		}.group_ids().array_get(rt.new_string('ORGANIZATION')) },
		rt.ArrayItem{ key: 'order', val: 30 },
		rt.ArrayItem{ key: 'attributes', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Organization'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	]))
	this.add_group(rt.create_array([
		rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
			nodeType: 'Expr_Variable'
			line:     112
			name:     'this'
		}.group_ids().array_get(rt.new_string('INVENTORY')) },
		rt.ArrayItem{ key: 'order', val: 50 },
		rt.ArrayItem{ key: 'attributes', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Inventory'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	]))
	mut var_shipping_hide_conditions := rt.new_array()
	var_shipping_hide_conditions.array_push(rt.create_array([
		rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "grouped"' },
	]))
	var_shipping_hide_conditions.array_push(rt.create_array([
		rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "external"' },
	]))
	this.add_group(rt.create_array([
		rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
			nodeType: 'Expr_Variable'
			line:     129
			name:     'this'
		}.group_ids().array_get(rt.new_string('SHIPPING')) },
		rt.ArrayItem{ key: 'order', val: 60 },
		rt.ArrayItem{ key: 'attributes', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Shipping'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'hideConditions', val: var_shipping_hide_conditions },
	]))
	this.add_group(rt.create_array([
		rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
			nodeType: 'Expr_Variable'
			line:     141
			name:     'this'
		}.group_ids().array_get(rt.new_string('LINKED_PRODUCTS')) },
		rt.ArrayItem{ key: 'order', val: 70 },
		rt.ArrayItem{ key: 'attributes', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Linked products'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) add_general_group_blocks() {
	mut var_is_calc_taxes_enabled := rt.call_function('wc_tax_enabled', []rt.PhpVal{})
	mut var_general_group := this.get_group_by_id(Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
		nodeType: 'Expr_Variable'
		line:     155
		name:     'this'
	}.group_ids().array_get(rt.new_string('GENERAL')))
	rt.call_method(var_general_group, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product_variation_notice_general_tab' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-has-variations-notice' },
			rt.ArrayItem{ key: 'order', val: 10 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
					rt.new_string("This product has options, such as size or color. You can manage each variation's images, downloads, and other details individually."),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'buttonText', val: rt.call_function('__', [
					rt.new_string('Go to Variations'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'info' },
			]) },
		]),
	])
	mut var_basic_details := rt.call_method(var_general_group, 'add_section', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'basic-details' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Basic details'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('This info will be displayed on the product page, category pages, social media, and search results.'),
					rt.new_string('woocommerce'),
				]) },
			]) }]),
	])
	rt.call_method(var_basic_details, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-details-section-description' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-details-section-description' },
			rt.ArrayItem{ key: 'order', val: 10 },
		]),
	])
	rt.call_method(var_basic_details, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-name' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-name-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: 'Product name' },
				rt.ArrayItem{ key: 'autoFocus', val: true },
				rt.ArrayItem{ key: 'metadata', val: rt.create_array([
					rt.ArrayItem{ key: 'bindings', val: rt.create_array([
						rt.ArrayItem{ key: 'value', val: rt.create_array([
							rt.ArrayItem{ key: 'source', val: 'woocommerce/entity-product' },
							rt.ArrayItem{ key: 'args', val: rt.create_array([
								rt.ArrayItem{ key: 'prop', val: 'name' },
							]) },
						]) },
					]) },
				]) },
			]) }]),
	])
	mut var_pricing_columns := rt.call_method(var_basic_details, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-pricing-group-pricing-columns' },
			rt.ArrayItem{ key: 'blockName', val: 'core/columns' },
			rt.ArrayItem{ key: 'order', val: 10 },
		]),
	])
	mut var_pricing_column_1 := rt.call_method(var_pricing_columns, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-pricing-group-pricing-column-1' },
			rt.ArrayItem{ key: 'blockName', val: 'core/column' },
			rt.ArrayItem{ key: 'order', val: 10 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'templateLock', val: 'all' },
			]) },
		]),
	])
	rt.call_method(var_pricing_column_1, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-pricing-regular-price' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-regular-price-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: 'regular_price' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Regular price'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{
					key: 'help'
					val: if rt.is_true(var_is_calc_taxes_enabled) { rt.new_null() } else { rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('Per your %1$sstore settings%2$s, taxes are not enabled.'),
								rt.new_string('woocommerce'),
							]),
							rt.new_string('<a href="' + (rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=general')])).str() + '" target="_blank" rel="noreferrer">'),
							rt.new_string('</a>'),
						]) }
				},
			]) }, rt.ArrayItem{ key: 'disableConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "variable"' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "grouped"' },
				]) },
			]) }]),
	])
	mut var_pricing_column_2 := rt.call_method(var_pricing_columns, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-pricing-group-pricing-column-2' },
			rt.ArrayItem{ key: 'blockName', val: 'core/column' },
			rt.ArrayItem{ key: 'order', val: 20 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'templateLock', val: 'all' },
			]) },
		]),
	])
	rt.call_method(var_pricing_column_2, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-pricing-sale-price' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-sale-price-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Sale price'),
					rt.new_string('woocommerce'),
				]) },
			]) }, rt.ArrayItem{ key: 'disableConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "variable"' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "grouped"' },
				]) },
			]) }]),
	])
	rt.call_method(var_basic_details, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-pricing-schedule-sale-fields' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-schedule-sale-fields' },
			rt.ArrayItem{ key: 'order', val: 20 },
		]),
	])
	if rt.is_true(var_is_calc_taxes_enabled) {
		rt.call_method(var_basic_details, 'add_block', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-sale-tax' },
				rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-radio-field' },
				rt.ArrayItem{ key: 'order', val: 30 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Charge sales tax on'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'property', val: 'tax_status' },
					rt.ArrayItem{ key: 'options', val: rt.create_array([
						rt.ArrayItem{ key: none, val: rt.create_array([
							rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
								rt.new_string('Product and shipping'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{
								key: 'value'
								val: Class_Automattic_WooCommerce_Enums_ProductTaxStatus.taxable()
							},
						]) },
						rt.ArrayItem{ key: none, val: rt.create_array([
							rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
								rt.new_string('Only shipping'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'value', val: 'shipping' },
						]) },
						rt.ArrayItem{ key: none, val: rt.create_array([
							rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
								rt.new_string("Don't charge tax"),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'value', val: 'none' },
						]) },
					]) },
				]) }]),
		])
		mut var_pricing_advanced_block := rt.call_method(var_basic_details, 'add_block', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-pricing-advanced' },
				rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-collapsible' },
				rt.ArrayItem{ key: 'order', val: 40 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'toggleText', val: rt.call_function('__', [
						rt.new_string('Advanced'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'initialCollapsed', val: true },
					rt.ArrayItem{ key: 'persistRender', val: true },
				]) }]),
		])
		rt.call_method(var_pricing_advanced_block, 'add_block', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-tax-class' },
				rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-select-field' },
				rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Tax class'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'help', val: rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Apply a tax rate if this product qualifies for tax reduction or exemption. %1$sLearn more%2$s'),
							rt.new_string('woocommerce'),
						]),
						rt.new_string('<a href="https://woocommerce.com/document/setting-up-taxes-in-woocommerce/#shipping-tax-class" target="_blank" rel="noreferrer">'),
						rt.new_string('</a>'),
					]) },
					rt.ArrayItem{ key: 'property', val: 'tax_class' },
					rt.ArrayItem{
						key: 'options'
						val: Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate.get_tax_classes()
					},
				]) }]),
		])
	}
	rt.call_method(var_basic_details, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-summary' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-text-area-field' },
			rt.ArrayItem{ key: 'order', val: 50 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Summary'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'help', val: rt.call_function('__', [
					rt.new_string("Summarize this product in 1-2 short sentences. We'll show it at the top of the page."),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'property', val: 'short_description' },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'move', val: true },
				]) },
			]) }]),
	])
	mut var_description_section := rt.call_method(var_general_group, 'add_section', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-description-section' },
			rt.ArrayItem{ key: 'order', val: 20 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Description'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('What makes this product unique? What are its most important features? Enrich the product page by adding rich content using blocks.'),
					rt.new_string('woocommerce'),
				]) },
			]) }]),
	])
	mut var_description_field_block := rt.call_method(var_description_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-description' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-description-field' },
			rt.ArrayItem{ key: 'order', val: 10 }]),
	])
	rt.call_method(var_description_field_block, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-description__content' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-summary-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'helpText', val: rt.new_null() },
				rt.ArrayItem{ key: 'label', val: rt.new_null() },
				rt.ArrayItem{ key: 'property', val: 'description' },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'move', val: true },
				]) },
			]) }]),
	])
	mut var_buy_button_section := rt.call_method(var_general_group, 'add_section', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-buy-button-section' },
			rt.ArrayItem{ key: 'order', val: 30 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Buy button'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Add a link and choose a label for the button linked to a product sold elsewhere.'),
					rt.new_string('woocommerce'),
				]) },
			]) }, rt.ArrayItem{ key: 'hideConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.type !== "external"' },
				]) },
			]) }]),
	])
	rt.call_method(var_buy_button_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-external-url' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-text-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'property', val: 'external_url' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Link to the external product'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
					rt.new_string('Enter the external URL to the product'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'suffix', val: true },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: 'value', val: 'url' },
					rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
						rt.new_string('Link to the external product is an invalid URL.'),
						rt.new_string('woocommerce'),
					]) },
				]) },
			]) }]),
	])
	mut var_button_text_columns := rt.call_method(var_buy_button_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-button-text-columns' },
			rt.ArrayItem{ key: 'blockName', val: 'core/columns' },
			rt.ArrayItem{ key: 'order', val: 20 }]),
	])
	rt.call_method(rt.call_method(var_button_text_columns, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-button-text-column1' },
			rt.ArrayItem{ key: 'blockName', val: 'core/column' },
			rt.ArrayItem{ key: 'order', val: 10 }]),
	]), 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-button-text' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-text-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'property', val: 'button_text' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Buy button text'),
					rt.new_string('woocommerce'),
				]) },
			]) }]),
	])
	rt.call_method(var_button_text_columns, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-button-text-column2' },
			rt.ArrayItem{ key: 'blockName', val: 'core/column' },
			rt.ArrayItem{ key: 'order', val: 20 }]),
	])
	mut var_product_list_section := rt.call_method(var_general_group, 'add_section', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-list-section' },
			rt.ArrayItem{ key: 'order', val: 35 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Products in this group'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Make a collection of related products, enabling customers to purchase multiple items together.'),
					rt.new_string('woocommerce'),
				]) },
			]) }, rt.ArrayItem{ key: 'hideConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.type !== "grouped"' },
				]) },
			]) }]),
	])
	rt.call_method(var_product_list_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-list' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-list-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'property', val: 'grouped_products' },
			]) }]),
	])
	mut var_images_section := rt.call_method(var_general_group, 'add_section', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-images-section' },
			rt.ArrayItem{ key: 'order', val: 40 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Images'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Drag images, upload new ones or select files from your library. For best results, use JPEG files that are 1000 by 1000 pixels or larger. %1$sHow to prepare images?%2$s'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('<a href="https://woocommerce.com/posts/how-to-take-professional-product-photos-top-tips" target="_blank" rel="noreferrer">'),
					rt.new_string('</a>'),
				]) },
			]) }]),
	])
	rt.call_method(var_images_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-images' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-images-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'images', val: rt.new_array() },
				rt.ArrayItem{ key: 'property', val: 'images' },
			]) }]),
	])
	this.add_downloadable_product_blocks(var_general_group.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) add_organization_group_blocks() {
	mut var_organization_group := this.get_group_by_id(Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
		nodeType: 'Expr_Variable'
		line:     533
		name:     'this'
	}.group_ids().array_get(rt.new_string('ORGANIZATION')))
	mut var_product_catalog_section := rt.call_method(var_organization_group, 'add_section', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-catalog-section' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Product catalog'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Help customers find this product by assigning it to categories, adding extra details, and managing its visibility in your store and other channels.'),
					rt.new_string('woocommerce'),
				]) },
			]) }]),
	])
	rt.call_method(var_product_catalog_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-categories' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-taxonomy-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'slug', val: 'product_cat' },
				rt.ArrayItem{ key: 'property', val: 'categories' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Categories'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'createTitle', val: rt.call_function('__', [
					rt.new_string('Create new category'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'dialogNameHelpText', val: rt.call_function('__', [
					rt.new_string('Shown to customers on the product page.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'parentTaxonomyText', val: rt.call_function('__', [
					rt.new_string('Parent category'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
					rt.new_string('Search or create categories…'),
					rt.new_string('woocommerce'),
				]) },
			]) }]),
	])
	rt.call_method(var_product_catalog_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-tags' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-tag-field' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'name', val: 'tags' },
			]) }]),
	])
	rt.call_method(var_product_catalog_section, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-catalog-search-visibility' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-catalog-visibility-field' },
			rt.ArrayItem{ key: 'order', val: 20 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Hide in product catalog'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{
					key: 'visibility'
					val: Class_Automattic_WooCommerce_Enums_CatalogVisibility.search()
				},
			]) },
		]),
	])
	rt.call_method(var_product_catalog_section, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-catalog-catalog-visibility' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-catalog-visibility-field' },
			rt.ArrayItem{ key: 'order', val: 30 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Hide from search results'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{
					key: 'visibility'
					val: Class_Automattic_WooCommerce_Enums_CatalogVisibility.catalog()
				},
			]) },
		]),
	])
	rt.call_method(var_product_catalog_section, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-enable-product-reviews' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-checkbox-field' },
			rt.ArrayItem{ key: 'order', val: 40 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Enable product reviews'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'property', val: 'reviews_allowed' },
			]) },
		]),
	])
	rt.call_method(var_product_catalog_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-post-password' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-password-field' },
			rt.ArrayItem{ key: 'order', val: 50 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Require a password'),
					rt.new_string('woocommerce'),
				]) },
			]) }]),
	])
	mut var_product_attributes_section := rt.call_method(var_organization_group, 'add_section', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-attributes-section' },
			rt.ArrayItem{ key: 'order', val: 20 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Attributes'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Use global attributes to allow shoppers to filter and search for this product. Use custom attributes to provide detailed product information.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'blockGap', val: 'unit-40' },
			]) }]),
	])
	rt.call_method(var_product_attributes_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-attributes' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-attributes-field' },
			rt.ArrayItem{ key: 'order', val: 10 }]),
	])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_0 := iife_temp_0.is_enabled(rt.new_string('product-custom-fields'))
	if rt.is_true(iife_result_0) {
		rt.call_method(rt.call_method(rt.call_method(rt.call_method(var_organization_group,
			'add_section', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'product-custom-fields-wrapper-section' },
				rt.ArrayItem{ key: 'order', val: 30 },
			]),
		]), 'add_block', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'product-custom-fields-toggle' },
				rt.ArrayItem{
					key: 'blockName'
					val: 'woocommerce/product-custom-fields-toggle-field'
				},
				rt.ArrayItem{ key: 'order', val: 10 },
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
						rt.new_string('Show custom fields'),
						rt.new_string('woocommerce'),
					]) },
				]) },
			]),
		]), 'add_block', [
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: 'product-custom-fields-section' },
				rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-section' },
				rt.ArrayItem{ key: 'order', val: 10 },
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'blockGap', val: 'unit-30' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Custom fields'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
						rt.call_function('__', [
							rt.new_string('Custom fields can be used in a variety of ways, such as sharing more detailed product information, showing more input fields, or for internal inventory organization. %1$sRead more about custom fields%2$s'),
							rt.new_string('woocommerce'),
						]),
						rt.new_string('<a href="https://woocommerce.com/document/custom-product-fields/" target="_blank" rel="noreferrer">'),
						rt.new_string('</a>'),
					]) },
				]) },
			]),
		]), 'add_block', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-custom-fields' },
				rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-custom-fields' },
				rt.ArrayItem{ key: 'order', val: 10 }]),
		])
	}
}

fn Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate.get_tax_classes(post_type string) rt.PhpVal {
	mut var_tax_classes := rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('product_variation'), rt.new_string(post_type))) {
		var_tax_classes.array_push(rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Same as main product'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'value', val: 'parent' },
		]))
	}
	var_tax_classes.array_push(rt.create_array([
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Standard rate'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'value', val: '' },
	]))
	mut iife_temp_1 := Class_WC_Tax{}
	mut iife_result_1 := iife_temp_1.get_tax_rate_classes()
	mut var_classes := iife_result_1
	mut iter_1 := var_classes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_tax_class := item_1.val
		var_tax_classes.array_push(rt.create_array([
			rt.ArrayItem{ key: 'label', val: rt.get_property(var_tax_class, 'name') },
			rt.ArrayItem{ key: 'value', val: rt.get_property(var_tax_class, 'slug') },
		]))
	}
	return var_tax_classes.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) add_inventory_group_blocks() {
	mut var_inventory_group := this.get_group_by_id(Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
		nodeType: 'Expr_Variable'
		line:     712
		name:     'this'
	}.group_ids().array_get(rt.new_string('INVENTORY')))
	rt.call_method(var_inventory_group, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product_variation_notice_inventory_tab' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-has-variations-notice' },
			rt.ArrayItem{ key: 'order', val: 10 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
					rt.new_string("This product has options, such as size or color. You can now manage each variation's inventory and other details individually."),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'buttonText', val: rt.call_function('__', [
					rt.new_string('Go to Variations'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'info' },
			]) },
		]),
	])
	mut var_product_inventory_section := rt.call_method(var_inventory_group, 'add_section', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-inventory-section' },
			rt.ArrayItem{ key: 'order', val: 20 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Inventory'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Set up and manage inventory for this product, including status and available quantity. %1$sManage store inventory settings%2$s'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('<a href="' +
						(rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=products&section=inventory')])).str() +
						'" target="_blank" rel="noreferrer">'),
					rt.new_string('</a>'),
				]) },
				rt.ArrayItem{ key: 'blockGap', val: 'unit-40' },
			]) }]),
	])
	mut var_product_inventory_inner_section := rt.call_method(var_product_inventory_section,
		'add_subsection', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-inventory-inner-section' },
			rt.ArrayItem{ key: 'order', val: 10 },
		]),
	])
	mut var_inventory_columns := rt.call_method(var_product_inventory_inner_section, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-inventory-inner-columns' },
			rt.ArrayItem{ key: 'blockName', val: 'core/columns' },
		]),
	])
	rt.call_method(rt.call_method(var_inventory_columns, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-inventory-inner-column1' },
			rt.ArrayItem{ key: 'blockName', val: 'core/column' },
		]),
	]), 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-sku-field' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-sku-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'disableConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "variable"' },
				]) },
			]) }]),
	])
	rt.call_method(rt.call_method(var_inventory_columns, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-inventory-inner-column2' },
			rt.ArrayItem{ key: 'blockName', val: 'core/column' },
		]),
	]), 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-unique-id-field' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-text-field' },
			rt.ArrayItem{ key: 'order', val: 20 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'property', val: 'global_unique_id' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s, %2$s, %3$s, or %4$s'),
						rt.new_string('woocommerce')]),
					rt.new_string('<abbr title="' +
						(rt.call_function('esc_attr__', [rt.new_string('Global Trade Item Number'), rt.new_string('woocommerce')])).str() +
						'">' +
						(rt.call_function('esc_html__', [rt.new_string('GTIN'), rt.new_string('woocommerce')])).str() +
						'</abbr>'),
					rt.new_string('<abbr title="' +
						(rt.call_function('esc_attr__', [rt.new_string('Universal Product Code'), rt.new_string('woocommerce')])).str() +
						'">' +
						(rt.call_function('esc_html__', [rt.new_string('UPC'), rt.new_string('woocommerce')])).str() +
						'</abbr>'),
					rt.new_string('<abbr title="' +
						(rt.call_function('esc_attr__', [rt.new_string('European Article Number'), rt.new_string('woocommerce')])).str() +
						'">' +
						(rt.call_function('esc_html__', [rt.new_string('EAN'), rt.new_string('woocommerce')])).str() +
						'</abbr>'),
					rt.new_string('<abbr title="' +
						(rt.call_function('esc_attr__', [rt.new_string('International Standard Book Number'), rt.new_string('woocommerce')])).str() +
						'">' +
						(rt.call_function('esc_html__', [rt.new_string('ISBN'), rt.new_string('woocommerce')])).str() +
						'</abbr>'),
				]) },
				rt.ArrayItem{ key: 'tooltip', val: rt.call_function('__', [
					rt.new_string('Enter a barcode or any other identifier unique to this product. It can help you list this product on other channels or marketplaces.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'pattern', val: rt.create_array([
					rt.ArrayItem{ key: 'value', val: '[0-9\\-]*' },
					rt.ArrayItem{ key: 'message', val: rt.call_function('__', [
						rt.new_string('Please enter only numbers and hyphens (-).'),
						rt.new_string('woocommerce')]) },
				]) },
			]) }, rt.ArrayItem{ key: 'disableConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "variable"' },
				]) },
			]) }]),
	])
	mut var_manage_stock := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
		rt.new_string('woocommerce_manage_stock'),
	]))
	rt.call_method(var_product_inventory_inner_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-track-stock' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-toggle-field' },
			rt.ArrayItem{ key: 'order', val: 20 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Track inventory'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'property', val: 'manage_stock' },
				rt.ArrayItem{ key: 'disabled', val: !(rt.is_true(var_manage_stock)) },
				rt.ArrayItem{
					key: 'disabledCopy'
					val: if rt.is_true(rt.new_bool(!(rt.is_true(var_manage_stock)))) { rt.call_function('sprintf', [
							rt.call_function('__', [
								rt.new_string('Per your %1$sstore settings%2$s, inventory management is <strong>disabled</strong>.'),
								rt.new_string('woocommerce'),
							]),
							rt.new_string('<a href="' + (rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=products&section=inventory')])).str() + '" target="_blank" rel="noreferrer">'),
							rt.new_string('</a>'),
						]) } else { rt.new_null() }
				},
			]) }, rt.ArrayItem{ key: 'hideConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{
						key: 'expression'
						val: 'editedProduct.type === "external" || editedProduct.type === "grouped"'
					},
				]) },
			]) }, rt.ArrayItem{ key: 'disableConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "variable"' },
				]) },
			]) }]),
	])
	mut var_product_inventory_quantity_hide_conditions := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'expression', val: 'editedProduct.manage_stock === false' },
		]) },
	])
	var_product_inventory_quantity_hide_conditions.array_push(rt.create_array([
		rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "grouped"' },
	]))
	rt.call_method(var_product_inventory_inner_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-inventory-quantity' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-inventory-quantity-field' },
			rt.ArrayItem{ key: 'order', val: 30 }, rt.ArrayItem{
				key: 'hideConditions'
				val: var_product_inventory_quantity_hide_conditions
			}]),
	])
	mut var_product_stock_status_hide_conditions := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'expression', val: 'editedProduct.manage_stock === true' },
		]) },
	])
	var_product_stock_status_hide_conditions.array_push(rt.create_array([
		rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "grouped"' },
	]))
	rt.call_method(var_product_inventory_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-stock-status' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-radio-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Stock status'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'property', val: 'stock_status' },
				rt.ArrayItem{ key: 'options', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('In stock'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{
							key: 'value'
							val: Class_Automattic_WooCommerce_Enums_ProductStockStatus.in_stock()
						},
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Out of stock'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{
							key: 'value'
							val: Class_Automattic_WooCommerce_Enums_ProductStockStatus.out_of_stock()
						},
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('On backorder'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{
							key: 'value'
							val: Class_Automattic_WooCommerce_Enums_ProductStockStatus.on_backorder()
						},
					]) },
				]) },
			]) }, rt.ArrayItem{ key: 'hideConditions', val: var_product_stock_status_hide_conditions },
			rt.ArrayItem{ key: 'disableConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "variable"' },
				]) },
			]) }]),
	])
	rt.call_method(var_product_inventory_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-purchase-note' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-text-area-field' },
			rt.ArrayItem{ key: 'order', val: 20 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'property', val: 'purchase_note' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Post-purchase note'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
					rt.new_string('Enter an optional note attached to the order confirmation message sent to the shopper.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'move', val: true },
				]) },
			]) }]),
	])
	mut var_product_inventory_advanced := rt.call_method(var_product_inventory_section,
		'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-inventory-advanced' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-collapsible' },
			rt.ArrayItem{ key: 'order', val: 30 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'toggleText', val: rt.call_function('__', [
					rt.new_string('Advanced'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'initialCollapsed', val: true },
				rt.ArrayItem{ key: 'persistRender', val: true },
			]) }, rt.ArrayItem{ key: 'hideConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "grouped"' },
				]) },
			]) }]),
	])
	mut var_product_inventory_advanced_wrapper := rt.call_method(var_product_inventory_advanced,
		'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-section' },
			rt.ArrayItem{ key: 'order', val: 10 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'blockGap', val: 'unit-40' },
			]) },
		]),
	])
	rt.call_method(var_product_inventory_advanced_wrapper, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-out-of-stock' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-radio-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('When out of stock'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'property', val: 'backorders' },
				rt.ArrayItem{ key: 'options', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Allow purchases'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'value', val: 'yes' },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Allow purchases, but notify customers'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'value', val: 'notify' },
					]) },
					rt.ArrayItem{ key: none, val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string("Don't allow purchases"),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'value', val: 'no' },
					]) },
				]) },
			]) }, rt.ArrayItem{ key: 'hideConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.manage_stock === false' },
				]) },
			]) }]),
	])
	rt.call_method(var_product_inventory_advanced_wrapper, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-inventory-email' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-inventory-email-field' },
			rt.ArrayItem{ key: 'order', val: 20 }, rt.ArrayItem{ key: 'hideConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.manage_stock === false' },
				]) },
			]) }]),
	])
	rt.call_method(var_product_inventory_advanced_wrapper, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-limit-purchase' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-checkbox-field' },
			rt.ArrayItem{ key: 'order', val: 20 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Restrictions'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Limit purchases to 1 item per order'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'property', val: 'sold_individually' },
				rt.ArrayItem{ key: 'tooltip', val: rt.call_function('__', [
					rt.new_string('When checked, customers will be able to purchase only 1 item in a single order. This is particularly useful for items that have limited quantity, like art or handmade goods.'),
					rt.new_string('woocommerce'),
				]) },
			]) }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) add_shipping_group_blocks() {
	mut var_shipping_group := this.get_group_by_id(Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
		nodeType: 'Expr_Variable'
		line:     1000
		name:     'this'
	}.group_ids().array_get(rt.new_string('SHIPPING')))
	rt.call_method(var_shipping_group, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product_variation_notice_shipping_tab' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-has-variations-notice' },
			rt.ArrayItem{ key: 'order', val: 10 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
					rt.new_string("This product has options, such as size or color. You can now manage each variation's shipping settings and other details individually."),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'buttonText', val: rt.call_function('__', [
					rt.new_string('Go to Variations'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'info' },
			]) },
		]),
	])
	rt.call_method(rt.call_method(var_shipping_group, 'add_section', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-virtual-section' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'hideConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.type !== "simple"' },
				]) },
			]) }]),
	]), 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-virtual' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-toggle-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'property', val: 'virtual' },
				rt.ArrayItem{ key: 'checkedValue', val: false },
				rt.ArrayItem{ key: 'uncheckedValue', val: true },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('This product requires shipping or pickup'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'uncheckedHelp', val: rt.call_function('__', [
					rt.new_string('This product will not trigger your customer\'s shipping calculator in cart or at checkout. This product also won\'t require your customers to enter their shipping details at checkout. <a href="https://woocommerce.com/document/managing-products/#adding-a-virtual-product" target="_blank" rel="noreferrer">Read more about virtual products</a>.'),
					rt.new_string('woocommerce'),
				]) },
			]) }]),
	])
	mut var_product_fee_and_dimensions_section := rt.call_method(var_shipping_group, 'add_section', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-fee-and-dimensions-section' },
			rt.ArrayItem{ key: 'order', val: 20 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Fees & dimensions'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Set up shipping costs and enter dimensions used for accurate rate calculations. %1$sHow to get started?%2$s'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('<a href="https://woocommerce.com/posts/how-to-calculate-shipping-costs-for-your-woocommerce-store/" target="_blank" rel="noreferrer">'),
					rt.new_string('</a>'),
				]) },
			]) },
		]),
	])
	rt.call_method(var_product_fee_and_dimensions_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-shipping-class' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-shipping-class-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'disableConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "variable"' },
				]) },
			]) }]),
	])
	rt.call_method(var_product_fee_and_dimensions_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-shipping-dimensions' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-shipping-dimensions-fields' },
			rt.ArrayItem{ key: 'order', val: 20 }, rt.ArrayItem{ key: 'disableConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.type === "variable"' },
				]) },
			]) }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) add_variation_group_blocks() {
	mut var_variation_group := this.get_group_by_id(Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
		nodeType: 'Expr_Variable'
		line:     1084
		name:     'this'
	}.group_ids().array_get(rt.new_string('VARIATIONS')))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_variation_group)))) {
		return
	}
	rt.call_method(rt.call_method(var_variation_group, 'add_section', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-variation-options-section' },
			rt.ArrayItem{ key: 'order', val: 10 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Variation options'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Add and manage attributes used for product options, such as size and color.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]),
	]), 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-variation-options' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-variations-options-field' },
			rt.ArrayItem{ key: 'order', val: 10 }]),
	])
	rt.call_method(rt.call_method(var_variation_group, 'add_section', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-variation-section' },
			rt.ArrayItem{ key: 'order', val: 20 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Variations'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Manage individual product combinations created from options.'),
					rt.new_string('woocommerce'),
				]) },
			]) }]),
	]), 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-variation-items' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-variation-items-field' },
			rt.ArrayItem{ key: 'order', val: 10 }]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) add_linked_products_group_blocks() {
	mut var_linked_products_group := this.get_group_by_id(Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
		nodeType: 'Expr_Variable'
		line:     1128
		name:     'this'
	}.group_ids().array_get(rt.new_string('LINKED_PRODUCTS')))
	if !(!var_linked_products_group.is_null()) {
		return
	}
	rt.call_method(rt.call_method(var_linked_products_group, 'add_section', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-linked-upsells-section' },
			rt.ArrayItem{ key: 'order', val: 10 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Upsells'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Upsells are typically products that are extra profitable or better quality or more expensive. Experiment with combinations to boost sales. %1$sLearn more about linked products%2$s'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('<br /><a href="https://woocommerce.com/document/related-products-up-sells-and-cross-sells/" target="_blank" rel="noreferrer">'),
					rt.new_string('</a>'),
				]) },
			]) },
		]),
	]), 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-linked-upsells' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-linked-list-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'property', val: 'upsell_ids' },
				rt.ArrayItem{ key: 'emptyState', val: rt.create_array([
					rt.ArrayItem{ key: 'image', val: 'ShoppingBags' },
					rt.ArrayItem{ key: 'tip', val: rt.call_function('__', [
						rt.new_string('Tip: Upsells are products that are extra profitable or better quality or more expensive. Experiment with combinations to boost sales.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'isDismissible', val: true },
				]) },
			]) }]),
	])
	rt.call_method(rt.call_method(var_linked_products_group, 'add_section', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-linked-cross-sells-section' },
			rt.ArrayItem{ key: 'order', val: 20 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Cross-sells'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('By suggesting complementary products in the cart using cross-sells, you can significantly increase the average order value. %1$sLearn more about linked products%2$s'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('<br /><a href="https://woocommerce.com/document/related-products-up-sells-and-cross-sells/" target="_blank" rel="noreferrer">'),
					rt.new_string('</a>'),
				]) },
			]) },
			rt.ArrayItem{ key: 'hideConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{
						key: 'expression'
						val: 'editedProduct.type === "external" || editedProduct.type === "grouped"'
					},
				]) },
			]) },
		]),
	]), 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-linked-cross-sells' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-linked-list-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'property', val: 'cross_sell_ids' },
				rt.ArrayItem{ key: 'emptyState', val: rt.create_array([
					rt.ArrayItem{ key: 'image', val: 'CashRegister' },
					rt.ArrayItem{ key: 'tip', val: rt.call_function('__', [
						rt.new_string('Tip: By suggesting complementary products in the cart using cross-sells, you can significantly increase the average order value.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'isDismissible', val: true },
				]) },
			]) }]),
	])
}

struct Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_simpleproducttemplate() &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_abstractproductformtemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_title' {
			return rt.new_string(this.get_title())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'add_group_blocks' {
			this.add_group_blocks()
			return rt.new_null()
		}
		'add_general_group_blocks' {
			this.add_general_group_blocks()
			return rt.new_null()
		}
		'add_organization_group_blocks' {
			this.add_organization_group_blocks()
			return rt.new_null()
		}
		'get_tax_classes' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate.get_tax_classes(dispatch_arg_0)
		}
		'add_inventory_group_blocks' {
			this.add_inventory_group_blocks()
			return rt.new_null()
		}
		'add_shipping_group_blocks' {
			this.add_shipping_group_blocks()
			return rt.new_null()
		}
		'add_variation_group_blocks' {
			this.add_variation_group_blocks()
			return rt.new_null()
		}
		'add_linked_products_group_blocks' {
			this.add_linked_products_group_blocks()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
