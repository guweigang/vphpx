import rt

pub fn Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate.group_ids() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'GENERAL', val: 'general' },
		rt.ArrayItem{ key: 'PRICING', val: 'pricing' }, rt.ArrayItem{
			key: 'INVENTORY'
			val: 'inventory'
		}, rt.ArrayItem{ key: 'SHIPPING', val: 'shipping' }])
}

pub fn Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate.single_variation_notice_dismissed_option() string {
	return 'woocommerce_single_variation_notice_dismissed'
}

struct Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate) construct() {
	this.add_group_blocks()
	this.add_general_group_blocks()
	this.add_inventory_group_blocks()
	this.add_shipping_group_blocks()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate) get_id() string {
	return 'product-variation'
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate) get_title() string {
	return (rt.call_function('__', [rt.new_string('Product Variation Template'),
		rt.new_string('woocommerce')])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate) get_description() string {
	return (rt.call_function('__', [
		rt.new_string('Template for the product variation form'),
		rt.new_string('woocommerce'),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate) add_group_blocks() {
	this.add_group(rt.create_array([
		rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
			nodeType: 'Expr_Variable'
			line:     70
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
	this.add_group(rt.create_array([
		rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
			nodeType: 'Expr_Variable'
			line:     79
			name:     'this'
		}.group_ids().array_get(rt.new_string('INVENTORY')) },
		rt.ArrayItem{ key: 'order', val: 30 },
		rt.ArrayItem{ key: 'attributes', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Inventory'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	]))
	this.add_group(rt.create_array([
		rt.ArrayItem{ key: 'id', val: Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
			nodeType: 'Expr_Variable'
			line:     88
			name:     'this'
		}.group_ids().array_get(rt.new_string('SHIPPING')) },
		rt.ArrayItem{ key: 'order', val: 40 },
		rt.ArrayItem{ key: 'attributes', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Shipping'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate) add_general_group_blocks() {
	mut var_is_calc_taxes_enabled := rt.call_function('wc_tax_enabled', []rt.PhpVal{})
	mut var_general_group := this.get_group_by_id(Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
		nodeType: 'Expr_Variable'
		line:     103
		name:     'this'
	}.group_ids().array_get(rt.new_string('GENERAL')))
	rt.call_method(var_general_group, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'general-single-variation-notice' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-single-variation-notice' },
			rt.ArrayItem{ key: 'order', val: 10 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
					rt.new_string('<strong>You’re editing details specific to this variation.</strong> Some information, like description and images, will be inherited from the main product, <noticeLink><parentProductName/></noticeLink>.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'info' },
				rt.ArrayItem{ key: 'isDismissible', val: true },
				rt.ArrayItem{ key: 'name', val: Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
					nodeType: 'Expr_Variable'
					line:     113
					name:     'this'
				}.single_variation_notice_dismissed_option() },
			]) },
		]),
	])
	mut var_basic_details := rt.call_method(var_general_group, 'add_section', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-variation-details-section' },
			rt.ArrayItem{ key: 'order', val: 10 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Variation details'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('This info will be displayed on the product page, category pages, social media, and search results.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]),
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
				rt.ArrayItem{ key: 'isRequired', val: true },
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
		mut iife_temp_0 :=
			Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate{}
		mut iife_result_0 := iife_temp_0.get_tax_classes(rt.new_string('product_variation'))
		rt.call_method(var_basic_details, 'add_block', [
			rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-tax-class' },
				rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-select-field' },
				rt.ArrayItem{ key: 'order', val: 40 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
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
					rt.ArrayItem{ key: 'options', val: iife_result_0 },
				]) }]),
		])
	}
	rt.call_method(var_basic_details, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-variation-note' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-text-area-field' },
			rt.ArrayItem{ key: 'order', val: 20 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'property', val: 'description' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Note'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{
					key: 'help'
					val: 'Enter an optional note displayed on the product page when customers select this variation.'
				},
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'move', val: true },
				]) },
			]) }]),
	])
	rt.call_method(var_basic_details, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-variation-visibility' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-checkbox-field' },
			rt.ArrayItem{ key: 'order', val: 30 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'property', val: 'status' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Hide in product catalog'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'checkedValue', val: 'private' },
				rt.ArrayItem{ key: 'uncheckedValue', val: 'publish' },
			]) }]),
	])
	mut var_images_section := rt.call_method(var_general_group, 'add_section', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-variation-images-section' },
			rt.ArrayItem{ key: 'order', val: 30 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Image'),
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
			]) },
		]),
	])
	rt.call_method(var_images_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-variation-image' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-images-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'property', val: 'image' },
				rt.ArrayItem{ key: 'multiple', val: false },
			]) }]),
	])
	this.add_downloadable_product_blocks(var_general_group.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate) add_inventory_group_blocks() {
	mut var_inventory_group := this.get_group_by_id(Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
		nodeType: 'Expr_Variable'
		line:     279
		name:     'this'
	}.group_ids().array_get(rt.new_string('INVENTORY')))
	rt.call_method(var_inventory_group, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'inventory-single-variation-notice' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-single-variation-notice' },
			rt.ArrayItem{ key: 'order', val: 10 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
					rt.new_string('<strong>You’re editing details specific to this variation.</strong> Some information, like description and images, will be inherited from the main product, <noticeLink><parentProductName/></noticeLink>.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'info' },
				rt.ArrayItem{ key: 'isDismissible', val: true },
				rt.ArrayItem{ key: 'name', val: Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
					nodeType: 'Expr_Variable'
					line:     289
					name:     'this'
				}.single_variation_notice_dismissed_option() },
			]) },
		]),
	])
	mut var_product_inventory_section := rt.call_method(var_inventory_group, 'add_section', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-variation-inventory-section' },
			rt.ArrayItem{ key: 'order', val: 20 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
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
			]) },
		]),
	])
	mut var_product_inventory_inner_section := rt.call_method(var_product_inventory_section,
		'add_subsection', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-variation-inventory-inner-section' },
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
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-variation-sku-field' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-sku-field' },
			rt.ArrayItem{ key: 'order', val: 10 }]),
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
			]) }]),
	])
	rt.call_method(var_product_inventory_inner_section, 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-variation-track-stock' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-toggle-field' },
			rt.ArrayItem{ key: 'order', val: 20 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Track inventory'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'property', val: 'manage_stock' },
				rt.ArrayItem{ key: 'disabled', val: rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
					rt.new_string('woocommerce_manage_stock'),
				])))) },
				rt.ArrayItem{ key: 'disabledCopy', val: rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Per your %1$sstore settings%2$s, inventory management is <strong>disabled</strong>.'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('<a href="' +
						(rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-settings&tab=products&section=inventory')])).str() +
						'" target="_blank" rel="noreferrer">'),
					rt.new_string('</a>'),
				]) },
			]) }]),
	])
	rt.call_method(var_product_inventory_inner_section, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-variation-inventory-quantity' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-inventory-quantity-field' },
			rt.ArrayItem{ key: 'order', val: 10 },
			rt.ArrayItem{ key: 'hideConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.manage_stock === false' },
				]) },
			]) },
		]),
	])
	rt.call_method(var_product_inventory_section, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-variation-stock-status' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-radio-field' },
			rt.ArrayItem{ key: 'order', val: 10 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
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
			]) },
			rt.ArrayItem{ key: 'hideConditions', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'expression', val: 'editedProduct.manage_stock === true' },
				]) },
			]) },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate) add_shipping_group_blocks() {
	mut var_shipping_group := this.get_group_by_id(Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
		nodeType: 'Expr_Variable'
		line:     422
		name:     'this'
	}.group_ids().array_get(rt.new_string('SHIPPING')))
	rt.call_method(var_shipping_group, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'shipping-single-variation-notice' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-single-variation-notice' },
			rt.ArrayItem{ key: 'order', val: 10 },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'content', val: rt.call_function('__', [
					rt.new_string('<strong>You’re editing details specific to this variation.</strong> Some information, like description and images, will be inherited from the main product, <noticeLink><parentProductName/></noticeLink>.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'info' },
				rt.ArrayItem{ key: 'isDismissible', val: true },
				rt.ArrayItem{ key: 'name', val: Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_{
					nodeType: 'Expr_Variable'
					line:     432
					name:     'this'
				}.single_variation_notice_dismissed_option() },
			]) },
		]),
	])
	rt.call_method(rt.call_method(var_shipping_group, 'add_section', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-variation-virtual-section' },
			rt.ArrayItem{ key: 'order', val: 20 },
		]),
	]), 'add_block', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'product-variation-virtual' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-toggle-field' },
			rt.ArrayItem{ key: 'order', val: 10 }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'property', val: 'virtual' },
				rt.ArrayItem{ key: 'checkedValue', val: false },
				rt.ArrayItem{ key: 'uncheckedValue', val: true },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('This variation requires shipping or pickup'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'uncheckedHelp', val: rt.call_function('__', [
					rt.new_string('This variation will not trigger your customer\'s shipping calculator in cart or at checkout. This product also won\'t require your customers to enter their shipping details at checkout. <a href="https://woocommerce.com/document/managing-products/#adding-a-virtual-product" target="_blank" rel="noreferrer">Read more about virtual products</a>.'),
					rt.new_string('woocommerce'),
				]) },
			]) }]),
	])
	mut var_product_fee_and_dimensions_section := rt.call_method(var_shipping_group, 'add_section', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-variation-fee-and-dimensions-section' },
			rt.ArrayItem{ key: 'order', val: 30 },
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
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-variation-shipping-class' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-shipping-class-field' },
			rt.ArrayItem{ key: 'order', val: 10 },
		]),
	])
	rt.call_method(var_product_fee_and_dimensions_section, 'add_block', [
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'product-variation-shipping-dimensions' },
			rt.ArrayItem{ key: 'blockName', val: 'woocommerce/product-shipping-dimensions-fields' },
			rt.ArrayItem{ key: 'order', val: 20 },
		]),
	])
}

struct Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_AbstractProductFormTemplate {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_productvariationtemplate() &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate{
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

fn create_automattic_woocommerce_internal_features_productblockeditor_producttemplates_simpleproducttemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate {
	mut obj := &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'add_inventory_group_blocks' {
			this.add_inventory_group_blocks()
			return rt.new_null()
		}
		'add_shipping_group_blocks' {
			this.add_shipping_group_blocks()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_ProductVariationTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Features_ProductBlockEditor_ProductTemplates_SimpleProductTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
