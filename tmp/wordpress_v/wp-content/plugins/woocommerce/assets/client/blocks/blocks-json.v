import rt

pub fn init_wp_content_plugins_woocommerce_assets_client_blocks_blocks_json_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'accordion-group', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/accordion-group' },
			rt.ArrayItem{ key: 'title', val: 'Accordion Group' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'A group of headers and associated expandable content.'
			},
			rt.ArrayItem{ key: 'example', val: rt.new_array() },
			rt.ArrayItem{ key: '__experimental', val: true },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'background', val: rt.create_array([
					rt.ArrayItem{ key: 'backgroundImage', val: true },
					rt.ArrayItem{ key: 'backgroundSize', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'backgroundImage', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'gradient', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'top' },
						rt.ArrayItem{ key: none, val: 'bottom' },
					]) },
					rt.ArrayItem{ key: 'blockGap', val: true },
				]) },
				rt.ArrayItem{ key: 'shadow', val: true },
				rt.ArrayItem{ key: 'layout', val: true },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'iconPosition', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'right' },
				]) },
				rt.ArrayItem{ key: 'autoclose', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
			]) },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/accordion-item' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/accordion-group' },
			rt.ArrayItem{ key: 'style', val: 'file:../woocommerce/accordion-group-style.css' },
		]) },
		rt.ArrayItem{ key: 'accordion-header', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/accordion-header' },
			rt.ArrayItem{ key: 'title', val: 'Accordion Header' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Accordion header.' },
			rt.ArrayItem{ key: 'example', val: rt.new_array() },
			rt.ArrayItem{ key: '__experimental', val: true },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/accordion-item' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'gradient', val: true },
				]) },
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'border', val: true },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'top' },
						rt.ArrayItem{ key: none, val: 'bottom' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
						rt.ArrayItem{ key: 'margin', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
						rt.ArrayItem{ key: 'fontFamily', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'shadow', val: true },
				rt.ArrayItem{ key: 'layout', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'openByDefault', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'title', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'rich-text' },
					rt.ArrayItem{ key: 'source', val: 'rich-text' },
					rt.ArrayItem{ key: 'selector', val: 'span' },
				]) },
				rt.ArrayItem{ key: 'level', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'levelOptions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
				rt.ArrayItem{ key: 'textAlignment', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'left' },
				]) },
				rt.ArrayItem{ key: 'icon', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'string' },
						rt.ArrayItem{ key: none, val: 'boolean' },
					]) },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'plus' },
						rt.ArrayItem{ key: none, val: 'chevron' },
						rt.ArrayItem{ key: none, val: 'chevronRight' },
						rt.ArrayItem{ key: none, val: 'caret' },
						rt.ArrayItem{ key: none, val: 'circlePlus' },
						rt.ArrayItem{ key: none, val: false },
					]) },
					rt.ArrayItem{ key: 'default', val: 'plus' },
				]) },
				rt.ArrayItem{ key: 'iconPosition', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'left' },
						rt.ArrayItem{ key: none, val: 'right' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'right' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
		]) },
		rt.ArrayItem{ key: 'accordion-item', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/accordion-item' },
			rt.ArrayItem{ key: 'title', val: 'Accordion' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'A single accordion that displays a header and expandable content.'
			},
			rt.ArrayItem{ key: 'example', val: rt.new_array() },
			rt.ArrayItem{ key: '__experimental', val: true },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/accordion-group' },
			]) },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/accordion-header' },
				rt.ArrayItem{ key: none, val: 'woocommerce/accordion-panel' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'gradient', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'top' },
						rt.ArrayItem{ key: none, val: 'bottom' },
					]) },
					rt.ArrayItem{ key: 'blockGap', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'shadow', val: true },
				rt.ArrayItem{ key: 'layout', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'openByDefault', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
		]) },
		rt.ArrayItem{ key: 'accordion-panel', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/accordion-panel' },
			rt.ArrayItem{ key: 'title', val: 'Accordion Panel' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Accordion Panel' },
			rt.ArrayItem{ key: 'example', val: rt.new_array() },
			rt.ArrayItem{ key: '__experimental', val: true },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/accordion-item' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'gradient', val: true },
				]) },
				rt.ArrayItem{ key: 'border', val: true },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'top' },
						rt.ArrayItem{ key: none, val: 'bottom' },
					]) },
					rt.ArrayItem{ key: 'blockGap', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
						rt.ArrayItem{ key: 'blockGap', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'shadow', val: true },
				rt.ArrayItem{ key: 'layout', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
				rt.ArrayItem{ key: 'templateLock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'string' },
						rt.ArrayItem{ key: none, val: 'boolean' },
					]) },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'all' },
						rt.ArrayItem{ key: none, val: 'insert' },
						rt.ArrayItem{ key: none, val: 'contentOnly' },
						rt.ArrayItem{ key: none, val: false },
					]) },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'openByDefault', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isSelected', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
		]) },
		rt.ArrayItem{ key: 'active-filters', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/active-filters' },
			rt.ArrayItem{ key: 'title', val: 'Active Filters Controls' },
			rt.ArrayItem{ key: 'description', val: 'Display the currently active filters.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: false },
				]) },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'displayStyle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'list' },
				]) },
				rt.ArrayItem{ key: 'headingLevel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'add-to-cart-form', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/add-to-cart-form' },
			rt.ArrayItem{ key: 'title', val: 'Add to Cart with Options' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a button that lets customers add a product to their cart. Use the added options to optimize for different product types.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'quantitySelectorStyle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'input' },
						rt.ArrayItem{ key: none, val: 'stepper' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'input' },
				]) },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/add-to-cart-form' },
			rt.ArrayItem{ key: 'style', val: 'file:../woocommerce/add-to-cart-form-style.css' },
			rt.ArrayItem{ key: 'editorStyle', val: 'file:../woocommerce/add-to-cart-form-editor.css' },
		]) },
		rt.ArrayItem{ key: 'add-to-cart-with-options', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/add-to-cart-with-options' },
			rt.ArrayItem{ key: 'title', val: 'Add to Cart + Options (Beta)' },
			rt.ArrayItem{
				key: 'description'
				val: 'Use blocks to create an "Add to cart" area that\'s customized for different product types, such as variable and grouped. '
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'isDescendantOfAddToCartWithOptions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{
					key: 'woocommerce/isDescendantOfAddToCartWithOptions'
					val: 'isDescendantOfAddToCartWithOptions'
				},
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{
				key: 'style'
				val: 'file:../woocommerce/add-to-cart-with-options-style.css'
			},
			rt.ArrayItem{
				key: 'editorStyle'
				val: 'file:../woocommerce/add-to-cart-with-options-editor.css'
			},
		]) },
		rt.ArrayItem{ key: 'add-to-cart-with-options-grouped-product-item', val: rt.create_array([
			rt.ArrayItem{
				key: 'name'
				val: 'woocommerce/add-to-cart-with-options-grouped-product-item'
			},
			rt.ArrayItem{ key: 'title', val: 'Grouped Product: Template (Beta)' },
			rt.ArrayItem{
				key: 'description'
				val: 'A list item template that represents a child product within the Grouped Product Selector block.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: 'woocommerce/add-to-cart-with-options-grouped-product-selector'
				},
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{
				key: 'style'
				val: 'file:../woocommerce/add-to-cart-with-options-grouped-product-item-style.css'
			},
		]) },
		rt.ArrayItem{ key: 'add-to-cart-with-options-grouped-product-item-label', val: rt.create_array([
			rt.ArrayItem{
				key: 'name'
				val: 'woocommerce/add-to-cart-with-options-grouped-product-item-label'
			},
			rt.ArrayItem{ key: 'title', val: 'Grouped Product: Item Label (Beta)' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display the product title as a label or paragraph.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: 'woocommerce/add-to-cart-with-options-grouped-product-item'
				},
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'selfStretch', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'blockGap', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
						rt.ArrayItem{ key: 'fontWeight', val: true },
						rt.ArrayItem{ key: 'fontStyle', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
		]) },
		rt.ArrayItem{ key: 'add-to-cart-with-options-grouped-product-item-selector', val: rt.create_array([
			rt.ArrayItem{
				key: 'name'
				val: 'woocommerce/add-to-cart-with-options-grouped-product-item-selector'
			},
			rt.ArrayItem{ key: 'title', val: 'Grouped Product: Item Selector (Beta)' },
			rt.ArrayItem{
				key: 'description'
				val: 'Add a way of selecting a child product within the Grouped Product block. Depending on the type of product and its properties, this might be a button, a checkbox, or a link.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: 'woocommerce/add-to-cart-with-options-grouped-product-item'
				},
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{
				key: 'style'
				val: 'file:../woocommerce/add-to-cart-with-options-grouped-product-item-selector-style.css'
			},
		]) },
		rt.ArrayItem{ key: 'add-to-cart-with-options-grouped-product-selector', val: rt.create_array([
			rt.ArrayItem{
				key: 'name'
				val: 'woocommerce/add-to-cart-with-options-grouped-product-selector'
			},
			rt.ArrayItem{ key: 'title', val: 'Grouped Product Selector (Beta)' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a group of products that can be added to the cart.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/add-to-cart-with-options' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{
				key: 'viewScriptModule'
				val: 'woocommerce/add-to-cart-with-options-grouped-product-selector'
			},
		]) },
		rt.ArrayItem{ key: 'add-to-cart-with-options-quantity-selector', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/add-to-cart-with-options-quantity-selector' },
			rt.ArrayItem{ key: 'title', val: 'Product Quantity (Beta)' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display an input field customers can use to select the number of products to add to their cart. '
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/add-to-cart-with-options' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{
				key: 'viewScriptModule'
				val: 'woocommerce/add-to-cart-with-options-quantity-selector'
			},
		]) },
		rt.ArrayItem{ key: 'add-to-cart-with-options-variation-description', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{
				key: 'name'
				val: 'woocommerce/add-to-cart-with-options-variation-description'
			},
			rt.ArrayItem{ key: 'title', val: 'Variation Description (Beta)' },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays the description of the selected variation.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/add-to-cart-with-options' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'dimensions', val: rt.create_array([
					rt.ArrayItem{ key: 'minHeight', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/product-elements' },
		]) },
		rt.ArrayItem{ key: 'add-to-cart-with-options-variation-selector', val: rt.create_array([
			rt.ArrayItem{
				key: 'name'
				val: 'woocommerce/add-to-cart-with-options-variation-selector'
			},
			rt.ArrayItem{ key: 'title', val: 'Variation Selector (Beta)' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display any product variations available to select from and add to cart.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/add-to-cart-with-options' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{
				key: 'viewScriptModule'
				val: 'woocommerce/add-to-cart-with-options-variation-selector'
			},
		]) },
		rt.ArrayItem{ key: 'add-to-cart-with-options-variation-selector-attribute', val: rt.create_array([
			rt.ArrayItem{
				key: 'name'
				val: 'woocommerce/add-to-cart-with-options-variation-selector-attribute'
			},
			rt.ArrayItem{ key: 'title', val: 'Variation Selector: Template (Beta)' },
			rt.ArrayItem{
				key: 'description'
				val: 'A template for attribute name and options that will be applied to all variable products with attributes.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: 'woocommerce/add-to-cart-with-options-variation-selector'
				},
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
		]) },
		rt.ArrayItem{ key: 'add-to-cart-with-options-variation-selector-attribute-name', val: rt.create_array([
			rt.ArrayItem{
				key: 'name'
				val: 'woocommerce/add-to-cart-with-options-variation-selector-attribute-name'
			},
			rt.ArrayItem{ key: 'title', val: 'Variation Selector: Attribute Name (Beta)' },
			rt.ArrayItem{
				key: 'description'
				val: 'Format the name of an attribute associated with a variable product.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: 'woocommerce/add-to-cart-with-options-variation-selector-attribute'
				},
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'alignWide', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'fontSize' },
						rt.ArrayItem{ key: none, val: 'lineHeight' },
						rt.ArrayItem{ key: none, val: 'fontFamily' },
						rt.ArrayItem{ key: none, val: 'fontWeight' },
						rt.ArrayItem{ key: none, val: 'fontStyle' },
						rt.ArrayItem{ key: none, val: 'textTransform' },
						rt.ArrayItem{ key: none, val: 'textDecoration' },
						rt.ArrayItem{ key: none, val: 'letterSpacing' },
					]) },
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalWritingMode', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: 'padding', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'horizontal' },
						rt.ArrayItem{ key: none, val: 'vertical' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/attributeId' },
				rt.ArrayItem{ key: none, val: 'woocommerce/attributeName' },
				rt.ArrayItem{ key: none, val: 'woocommerce/attributeTerms' },
			]) },
			rt.ArrayItem{
				key: 'style'
				val: 'file:../woocommerce/add-to-cart-with-options-variation-selector-attribute-name-style.css'
			},
		]) },
		rt.ArrayItem{ key: 'add-to-cart-with-options-variation-selector-attribute-options', val: rt.create_array([
			rt.ArrayItem{
				key: 'name'
				val: 'woocommerce/add-to-cart-with-options-variation-selector-attribute-options'
			},
			rt.ArrayItem{ key: 'title', val: 'Variation Selector: Attribute Options (Beta)' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display the attribute options associated with a variable product.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: 'woocommerce/add-to-cart-with-options-variation-selector-attribute'
				},
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'optionStyle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'pills' },
						rt.ArrayItem{ key: none, val: 'dropdown' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'pills' },
				]) },
				rt.ArrayItem{ key: 'autoselect', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'disabledAttributesAction', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'disable' },
						rt.ArrayItem{ key: none, val: 'hide' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'disable' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/attributeId' },
				rt.ArrayItem{ key: none, val: 'woocommerce/attributeName' },
				rt.ArrayItem{ key: none, val: 'woocommerce/attributeTerms' },
			]) },
			rt.ArrayItem{
				key: 'style'
				val: 'file:../woocommerce/add-to-cart-with-options-variation-selector-attribute-options-style.css'
			},
		]) },
		rt.ArrayItem{ key: 'all-products', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/all-products' },
			rt.ArrayItem{ key: 'title', val: 'All Products' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Display products from your store in a grid layout.'
			},
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'columns', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'rows', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'alignButtons', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
				]) },
				rt.ArrayItem{ key: 'contentVisibility', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
				]) },
				rt.ArrayItem{ key: 'orderby', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'layoutConfig', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'all-reviews', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/all-reviews' },
			rt.ArrayItem{ key: 'title', val: 'All Reviews' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Show a list of all product reviews.' },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: false },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'attribute-filter', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/attribute-filter' },
			rt.ArrayItem{ key: 'title', val: 'Filter by Attribute Controls' },
			rt.ArrayItem{
				key: 'description'
				val: 'Enable customers to filter the product grid by selecting one or more attributes, such as color.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: false },
				]) },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: 'interactivity', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'attributeId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'showCounts', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'queryType', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'or' },
				]) },
				rt.ArrayItem{ key: 'headingLevel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'displayStyle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'list' },
				]) },
				rt.ArrayItem{ key: 'showFilterButton', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'selectType', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'multiple' },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'breadcrumbs', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/breadcrumbs' },
			rt.ArrayItem{ key: 'title', val: 'Store Breadcrumbs' },
			rt.ArrayItem{
				key: 'description'
				val: 'Enable customers to keep track of their location within the store and navigate back to parent pages.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'contentJustification', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'fontSize', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'small' },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'wide' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: false },
					rt.ArrayItem{ key: 'link', val: true },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'cart-link', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-link' },
			rt.ArrayItem{ key: 'title', val: 'Cart Link' },
			rt.ArrayItem{ key: 'icon', val: 'cart' },
			rt.ArrayItem{ key: 'description', val: 'Display a link to the cart.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: 'link', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'cartIcon', val: 'cart' },
					rt.ArrayItem{ key: 'content', val: 'Cart' },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'cartIcon', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'cart' },
				]) },
				rt.ArrayItem{ key: 'content', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: rt.new_null() },
				]) },
			]) },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'catalog-sorting', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/catalog-sorting' },
			rt.ArrayItem{ key: 'title', val: 'Catalog Sorting' },
			rt.ArrayItem{
				key: 'description'
				val: 'Enable customers to change the sorting order of the products.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: false },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'fontSize', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'small' },
				]) },
				rt.ArrayItem{ key: 'useLabel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'category-description', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/category-description' },
			rt.ArrayItem{ key: 'title', val: 'Product Category Description' },
			rt.ArrayItem{ key: 'description', val: 'Displays the current category description.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: true },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'termId' },
				rt.ArrayItem{ key: none, val: 'termTaxonomy' },
			]) },
		]) },
		rt.ArrayItem{ key: 'category-title', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/category-title' },
			rt.ArrayItem{ key: 'title', val: 'Product Category Title' },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays the current category title and lets permitted users edit it.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'isLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'level', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 2 },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '_self' },
				]) },
				rt.ArrayItem{ key: 'rel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: true },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'termId' },
				rt.ArrayItem{ key: none, val: 'termTaxonomy' },
			]) },
		]) },
		rt.ArrayItem{ key: 'checkout', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Checkout' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a checkout form so your customers can submit orders.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'viewportWidth', val: 800 },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'wide' },
				]) },
				rt.ArrayItem{ key: 'showFormStepNumbers', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'classic-shortcode', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/classic-shortcode' },
			rt.ArrayItem{ key: 'title', val: 'Classic Shortcode' },
			rt.ArrayItem{ key: 'description', val: 'Renders classic WooCommerce shortcodes.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'shortcode', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'cart' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'cart' },
						rt.ArrayItem{ key: none, val: 'checkout' },
					]) },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'wide' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'coming-soon', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/coming-soon' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'title', val: 'Coming Soon' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'storeOnly', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'comingSoonPatternId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
				]) },
				rt.ArrayItem{ key: 'inserter', val: false },
			]) },
		]) },
		rt.ArrayItem{ key: 'coupon-code', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/coupon-code' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Coupon Code' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{
				key: 'description'
				val: 'Include a coupon code to entice customers to make a purchase.'
			},
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'email', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'couponCode', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'source', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'createNew' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'createNew' },
						rt.ArrayItem{ key: none, val: 'existing' },
					]) },
				]) },
				rt.ArrayItem{ key: 'discountType', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'percent' },
				]) },
				rt.ArrayItem{ key: 'amount', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 10 },
				]) },
				rt.ArrayItem{ key: 'expiryDay', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 10 },
				]) },
				rt.ArrayItem{ key: 'freeShipping', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'usageLimit', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'usageLimitPerUser', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'minimumAmount', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'maximumAmount', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'individualUse', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'excludeSaleItems', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'productIds', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
					]) },
				]) },
				rt.ArrayItem{ key: 'excludedProductIds', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
					]) },
				]) },
				rt.ArrayItem{ key: 'productCategoryIds', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
					]) },
				]) },
				rt.ArrayItem{ key: 'excludedProductCategoryIds', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'object' },
					]) },
				]) },
				rt.ArrayItem{ key: 'emailRestrictions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
		]) },
		rt.ArrayItem{ key: 'customer-account', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/customer-account' },
			rt.ArrayItem{ key: 'title', val: 'Customer account' },
			rt.ArrayItem{
				key: 'description'
				val: 'A block that allows your customers to log in and out of their accounts in your store.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
				rt.ArrayItem{ key: none, val: 'My Account' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'displayStyle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'icon_and_text' },
				]) },
				rt.ArrayItem{ key: 'hasDropdownNavigation', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'iconStyle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'default' },
				]) },
				rt.ArrayItem{ key: 'iconClass', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'icon' },
				]) },
			]) },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/customer-account' },
			rt.ArrayItem{ key: 'style', val: 'file:../woocommerce/customer-account-style.css' },
			rt.ArrayItem{ key: 'editorStyle', val: 'file:../woocommerce/customer-account-editor.css' },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'email-content', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/email-content' },
			rt.ArrayItem{ key: 'title', val: 'Email Content' },
			rt.ArrayItem{ key: 'description', val: 'A placeholder block for email content.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'email', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'emailType', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'postId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'featured-category', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/featured-category' },
			rt.ArrayItem{ key: 'title', val: 'Featured Category' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Visually highlight a product category and encourage prompt action.'
			},
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'ariaLabel', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{ key: 'duotone', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
					]) },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'alt', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'contentAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'center' },
				]) },
				rt.ArrayItem{ key: 'dimRatio', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 50 },
				]) },
				rt.ArrayItem{ key: 'focalPoint', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'x', val: 0.5 },
						rt.ArrayItem{ key: 'y', val: 0.5 },
					]) },
				]) },
				rt.ArrayItem{ key: 'imageFit', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'none' },
				]) },
				rt.ArrayItem{ key: 'hasParallax', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isRepeated', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'mediaId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'mediaSrc', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'minHeight', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 500 },
				]) },
				rt.ArrayItem{ key: 'linkText', val: rt.create_array([
					rt.ArrayItem{ key: 'default', val: 'Shop now' },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'categoryId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'overlayColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '#000000' },
				]) },
				rt.ArrayItem{ key: 'overlayGradient', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'previewCategory', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.new_null() },
				]) },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{
						key: 'duotone'
						val: '.wp-block-woocommerce-featured-category .wc-block-featured-category__background-image'
					},
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'termId' },
				rt.ArrayItem{ key: none, val: 'termTaxonomy' },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'termId', val: 'categoryId' },
				rt.ArrayItem{ key: 'termTaxonomy', val: 'termTaxonomy' },
			]) },
		]) },
		rt.ArrayItem{ key: 'featured-product', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/featured-product' },
			rt.ArrayItem{ key: 'title', val: 'Featured Product' },
			rt.ArrayItem{ key: 'description', val: 'Highlight a product or variation.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'ariaLabel', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{ key: 'duotone', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
					]) },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'multiple', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'alt', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'contentAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'center' },
				]) },
				rt.ArrayItem{ key: 'dimRatio', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 50 },
				]) },
				rt.ArrayItem{ key: 'focalPoint', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'x', val: 0.5 },
						rt.ArrayItem{ key: 'y', val: 0.5 },
					]) },
				]) },
				rt.ArrayItem{ key: 'imageFit', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'none' },
				]) },
				rt.ArrayItem{ key: 'hasParallax', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isRepeated', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'mediaId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'mediaSrc', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'minHeight', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 500 },
				]) },
				rt.ArrayItem{ key: 'linkText', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'Shop now' },
				]) },
				rt.ArrayItem{ key: 'overlayColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '#000000' },
				]) },
				rt.ArrayItem{ key: 'overlayGradient', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'productId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'previewProduct', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.new_null() },
				]) },
			]) },
			rt.ArrayItem{ key: 'selectors', val: rt.create_array([
				rt.ArrayItem{ key: 'filter', val: rt.create_array([
					rt.ArrayItem{
						key: 'duotone'
						val: '.wp-block-woocommerce-featured-product .wc-block-featured-product__background-image'
					},
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'filter-wrapper', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/filter-wrapper' },
			rt.ArrayItem{ key: 'title', val: 'Filter Block' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'inserter', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'filterType', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'heading', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'handpicked-products', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/handpicked-products' },
			rt.ArrayItem{ key: 'title', val: 'Hand-picked Products' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'Handpicked Products' },
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a selection of hand-picked products in a grid.'
			},
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'columns', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'contentVisibility', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: true },
						rt.ArrayItem{ key: 'title', val: true },
						rt.ArrayItem{ key: 'price', val: true },
						rt.ArrayItem{ key: 'rating', val: true },
						rt.ArrayItem{ key: 'button', val: true },
					]) },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'image', val: true },
						]) },
						rt.ArrayItem{ key: 'title', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'title', val: true },
						]) },
						rt.ArrayItem{ key: 'price', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'price', val: true },
						]) },
						rt.ArrayItem{ key: 'rating', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'rating', val: true },
						]) },
						rt.ArrayItem{ key: 'button', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'button', val: true },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'orderby', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'date' },
						rt.ArrayItem{ key: none, val: 'popularity' },
						rt.ArrayItem{ key: none, val: 'price_asc' },
						rt.ArrayItem{ key: none, val: 'price_desc' },
						rt.ArrayItem{ key: none, val: 'rating' },
						rt.ArrayItem{ key: none, val: 'title' },
						rt.ArrayItem{ key: none, val: 'menu_order' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'date' },
				]) },
				rt.ArrayItem{ key: 'products', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
				]) },
				rt.ArrayItem{ key: 'alignButtons', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'mini-cart', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/mini-cart' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Mini-Cart' },
			rt.ArrayItem{ key: 'icon', val: 'miniCartAlt' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a button for shoppers to quickly view their cart.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'className', val: 'wc-block-mini-cart--preview' },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'miniCartIcon', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'cart' },
				]) },
				rt.ArrayItem{ key: 'addToCartBehaviour', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'none' },
				]) },
				rt.ArrayItem{ key: 'onCartClickBehaviour', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'open_drawer' },
				]) },
				rt.ArrayItem{ key: 'hasHiddenPrice', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'cartAndCheckoutRenderStyle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'hidden' },
				]) },
				rt.ArrayItem{ key: 'priceColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
				]) },
				rt.ArrayItem{ key: 'priceColorValue', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'iconColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
				]) },
				rt.ArrayItem{ key: 'iconColorValue', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'productCountColor', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
				]) },
				rt.ArrayItem{ key: 'productCountColorValue', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'productCountVisibility', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'greater_than_zero' },
				]) },
			]) },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'mini-cart-contents', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/mini-cart-contents' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Mini-Cart Contents' },
			rt.ArrayItem{ key: 'description', val: 'Display a Mini-Cart widget.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'link', val: true },
				]) },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'width', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '480px' },
				]) },
			]) },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'order-confirmation-additional-fields', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/order-confirmation-additional-fields' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Additional Field List' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display the list of additional field values from the current order.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'color', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'wide' },
				]) },
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'order-confirmation-additional-fields-wrapper', val: rt.create_array([
			rt.ArrayItem{
				key: 'name'
				val: 'woocommerce/order-confirmation-additional-fields-wrapper'
			},
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Additional Fields' },
			rt.ArrayItem{
				key: 'description'
				val: "Display additional checkout fields from the 'contact' and 'order' locations."
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'heading', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'order-confirmation-additional-information', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/order-confirmation-additional-information' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Additional Information' },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays additional information provided by third-party extensions for the current order.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'color', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'wide' },
				]) },
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'order-confirmation-billing-address', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/order-confirmation-billing-address' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Billing Address' },
			rt.ArrayItem{ key: 'description', val: 'Display the order confirmation billing address.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'color', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'wide' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'order-confirmation-billing-wrapper', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/order-confirmation-billing-wrapper' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Billing Address Section' },
			rt.ArrayItem{ key: 'description', val: 'Display the order confirmation billing section.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'heading', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'order-confirmation-create-account', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/order-confirmation-create-account' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Account Creation' },
			rt.ArrayItem{
				key: 'description'
				val: 'Allow customers to create an account after their purchase.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'customerEmail', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'nonceToken', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'wide' },
				]) },
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'hasDarkControls', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'button', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'order-confirmation-downloads', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/order-confirmation-downloads' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Order Downloads' },
			rt.ArrayItem{ key: 'description', val: 'Display links to purchased downloads.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{
					key: '__experimentalSelector'
					val: '.wp-block-woocommerce-order-confirmation-totals table'
				},
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'wide' },
				]) },
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'order-confirmation-downloads-wrapper', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/order-confirmation-downloads-wrapper' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Downloads Section' },
			rt.ArrayItem{ key: 'description', val: 'Display the downloadable products section.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'heading', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'order-confirmation-shipping-address', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/order-confirmation-shipping-address' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Shipping Address' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display the order confirmation shipping address.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'color', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'wide' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'order-confirmation-shipping-wrapper', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/order-confirmation-shipping-wrapper' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Shipping Address Section' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display the order confirmation shipping section.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'heading', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'Shipping' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'order-confirmation-status', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/order-confirmation-status' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Order Status' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a "thank you" message, or a sentence regarding the current order status.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'wide' },
				]) },
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'order-confirmation-summary', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/order-confirmation-summary' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Order Summary' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display the order summary on the order confirmation page.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'color', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'wide' },
				]) },
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'order-confirmation-totals', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/order-confirmation-totals' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Order Totals' },
			rt.ArrayItem{ key: 'description', val: 'Display the items purchased and order totals.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'style', val: true },
						rt.ArrayItem{ key: 'width', val: true },
					]) },
				]) },
				rt.ArrayItem{
					key: '__experimentalSelector'
					val: '.wp-block-woocommerce-order-confirmation-totals table'
				},
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'wide' },
				]) },
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'order-confirmation-totals-wrapper', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/order-confirmation-totals-wrapper' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Order Totals Section' },
			rt.ArrayItem{ key: 'description', val: 'Display the order details section.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'heading', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'page-content-wrapper', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/page-content-wrapper' },
			rt.ArrayItem{ key: 'title', val: 'WooCommerce Page' },
			rt.ArrayItem{ key: 'description', val: 'Displays WooCommerce page content.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'page', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'postId', val: 'postId' },
				rt.ArrayItem{ key: 'postType', val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'payment-method-icons', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/payment-method-icons' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Payment Method Icons' },
			rt.ArrayItem{ key: 'description', val: 'Display icons for available payment methods.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce' },
				rt.ArrayItem{ key: none, val: 'payments' },
				rt.ArrayItem{ key: none, val: 'payment methods' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'numberOfIcons', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'price-filter', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/price-filter' },
			rt.ArrayItem{ key: 'title', val: 'Filter by Price Controls' },
			rt.ArrayItem{
				key: 'description'
				val: 'Enable customers to filter the product grid by choosing a price range.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: false },
				]) },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'showInputFields', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'inlineInput', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'showFilterButton', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'headingLevel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-average-rating', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-average-rating' },
			rt.ArrayItem{ key: 'title', val: 'Product Average Rating (Beta)' },
			rt.ArrayItem{ key: 'description', val: 'Display the average rating of a product' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/single-product' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{
					key: '__experimentalSelector'
					val: '.wc-block-components-product-average-rating'
				},
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-best-sellers', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-best-sellers' },
			rt.ArrayItem{ key: 'title', val: 'Best Selling Products' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a grid of your all-time best selling products.'
			},
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'columns', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'rows', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'alignButtons', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'contentVisibility', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: true },
						rt.ArrayItem{ key: 'title', val: true },
						rt.ArrayItem{ key: 'price', val: true },
						rt.ArrayItem{ key: 'rating', val: true },
						rt.ArrayItem{ key: 'button', val: true },
					]) },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'title', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'price', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'rating', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'button', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'categories', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
				]) },
				rt.ArrayItem{ key: 'catOperator', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'any' },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'stockStatus', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
				rt.ArrayItem{ key: 'editMode', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'orderby', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'date' },
						rt.ArrayItem{ key: none, val: 'popularity' },
						rt.ArrayItem{ key: none, val: 'price_asc' },
						rt.ArrayItem{ key: none, val: 'price_desc' },
						rt.ArrayItem{ key: none, val: 'rating' },
						rt.ArrayItem{ key: none, val: 'title' },
						rt.ArrayItem{ key: none, val: 'menu_order' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'popularity' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-button', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-button' },
			rt.ArrayItem{ key: 'title', val: 'Add to Cart Button' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a call to action button which either adds the product to the cart, or links to the product page.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'collection' },
				rt.ArrayItem{ key: none, val: 'woocommerce/isDescendantOfAddToCartWithOptions' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'productId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'width', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfSingleProductBlock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfQueryLoop', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'link', val: false },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'email', val: true },
				rt.ArrayItem{
					key: '__experimentalSelector'
					val: '.wp-block-button.wc-block-components-product-button .wc-block-components-product-button__button'
				},
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/all-products' },
				rt.ArrayItem{ key: none, val: 'woocommerce/single-product' },
				rt.ArrayItem{ key: none, val: 'core/post-template' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-template' },
			]) },
			rt.ArrayItem{ key: 'styles', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'fill' },
					rt.ArrayItem{ key: 'label', val: 'Fill' },
					rt.ArrayItem{ key: 'isDefault', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'outline' },
					rt.ArrayItem{ key: 'label', val: 'Outline' },
				]) },
			]) },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/product-button' },
			rt.ArrayItem{ key: 'style', val: 'file:../woocommerce/product-button-style.css' },
		]) },
		rt.ArrayItem{ key: 'product-categories', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-categories' },
			rt.ArrayItem{ key: 'title', val: 'Product Categories List' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{
				key: 'description'
				val: 'Show all product categories as a list or dropdown.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: false },
					rt.ArrayItem{ key: 'link', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'hasCount', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'hasImage', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'hasEmpty', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isDropdown', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isHierarchical', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'showChildrenOnly', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'hasCount', val: true },
					rt.ArrayItem{ key: 'hasImage', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-category', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-category' },
			rt.ArrayItem{ key: 'title', val: 'Products by Category' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a grid of products from your selected categories.'
			},
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'columns', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'rows', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'alignButtons', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'contentVisibility', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: true },
						rt.ArrayItem{ key: 'title', val: true },
						rt.ArrayItem{ key: 'price', val: true },
						rt.ArrayItem{ key: 'rating', val: true },
						rt.ArrayItem{ key: 'button', val: true },
					]) },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'title', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'price', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'rating', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'button', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'categories', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
				]) },
				rt.ArrayItem{ key: 'catOperator', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'any' },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'stockStatus', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
				rt.ArrayItem{ key: 'editMode', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'orderby', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'date' },
						rt.ArrayItem{ key: none, val: 'popularity' },
						rt.ArrayItem{ key: none, val: 'price_asc' },
						rt.ArrayItem{ key: none, val: 'price_desc' },
						rt.ArrayItem{ key: none, val: 'rating' },
						rt.ArrayItem{ key: none, val: 'title' },
						rt.ArrayItem{ key: none, val: 'menu_order' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'date' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-collection', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-collection' },
			rt.ArrayItem{ key: 'title', val: 'Product Collection' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a collection of products from your store.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
				rt.ArrayItem{ key: none, val: 'Products (Beta)' },
				rt.ArrayItem{ key: none, val: 'all products' },
				rt.ArrayItem{ key: none, val: 'by attribute' },
				rt.ArrayItem{ key: none, val: 'by category' },
				rt.ArrayItem{ key: none, val: 'by tag' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'queryId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
				rt.ArrayItem{ key: 'query', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
				]) },
				rt.ArrayItem{ key: 'tagName', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'displayLayout', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'string' },
							rt.ArrayItem{ key: 'enum', val: rt.create_array([
								rt.ArrayItem{ key: none, val: 'flex' },
								rt.ArrayItem{ key: none, val: 'list' },
								rt.ArrayItem{ key: none, val: 'carousel' },
							]) },
						]) },
						rt.ArrayItem{ key: 'columns', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'number' },
						]) },
						rt.ArrayItem{ key: 'shrinkColumns', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'dimensions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
				]) },
				rt.ArrayItem{ key: 'convertedFromProducts', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'collection', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'hideControls', val: rt.create_array([
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
				rt.ArrayItem{ key: 'queryContextIncludes', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
				rt.ArrayItem{ key: 'forcePageReload', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: '__privatePreviewState', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
				]) },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'queryId', val: 'queryId' },
				rt.ArrayItem{ key: 'query', val: 'query' },
				rt.ArrayItem{ key: 'displayLayout', val: 'displayLayout' },
				rt.ArrayItem{ key: 'dimensions', val: 'dimensions' },
				rt.ArrayItem{ key: 'queryContextIncludes', val: 'queryContextIncludes' },
				rt.ArrayItem{ key: 'collection', val: 'collection' },
				rt.ArrayItem{
					key: '__privateProductCollectionPreviewState'
					val: '__privatePreviewState'
				},
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'templateSlug' },
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: '__experimentalLayout', val: true },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'email', val: true },
			]) },
			rt.ArrayItem{
				key: 'editorStyle'
				val: 'file:../woocommerce/product-collection-editor.css'
			},
			rt.ArrayItem{ key: 'style', val: 'file:../woocommerce/product-collection-style.css' },
		]) },
		rt.ArrayItem{ key: 'product-collection-no-results', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-collection-no-results' },
			rt.ArrayItem{ key: 'title', val: 'No results' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{
				key: 'description'
				val: 'The contents of this block will display when there are no products found.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'Product Collection' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'query' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-collection' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'email', val: true },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-description', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-description' },
			rt.ArrayItem{ key: 'title', val: 'Product Description' },
			rt.ArrayItem{ key: 'description', val: 'Displays the description of the product.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'queryId' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/single-product' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-template' },
				rt.ArrayItem{ key: none, val: 'core/post-template' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'layout', val: true },
				rt.ArrayItem{ key: 'background', val: rt.create_array([
					rt.ArrayItem{ key: 'backgroundImage', val: true },
					rt.ArrayItem{ key: 'backgroundSize', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'backgroundImage', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'dimensions', val: rt.create_array([
					rt.ArrayItem{ key: 'minHeight', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'blockGap', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'heading', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: false },
						rt.ArrayItem{ key: 'text', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-details', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-details' },
			rt.ArrayItem{ key: 'title', val: 'Product Details' },
			rt.ArrayItem{
				key: 'description'
				val: "Display a product's description, attributes, and reviews"
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'wide' },
				]) },
				rt.ArrayItem{ key: 'hideTabTitle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-filter-active', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-filter-active' },
			rt.ArrayItem{ key: 'title', val: 'Active Filters' },
			rt.ArrayItem{ key: 'description', val: 'Display the currently active filters.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filters' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: false },
						rt.ArrayItem{ key: 'radius', val: false },
						rt.ArrayItem{ key: 'style', val: false },
						rt.ArrayItem{ key: 'width', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'blockGap', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
						rt.ArrayItem{ key: 'blockGap', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'activeFilters' },
			]) },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/product-filter-active' },
		]) },
		rt.ArrayItem{ key: 'product-filter-attribute', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-filter-attribute' },
			rt.ArrayItem{ key: 'title', val: 'Attribute Filter' },
			rt.ArrayItem{
				key: 'description'
				val: 'Enable customers to filter the product grid by selecting one or more attributes, such as color.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filters' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'text', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'blockGap', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
						rt.ArrayItem{ key: 'blockGap', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: false },
						rt.ArrayItem{ key: 'radius', val: false },
						rt.ArrayItem{ key: 'style', val: false },
						rt.ArrayItem{ key: 'width', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'filterParams' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'attributeId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'showCounts', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'queryType', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'or' },
				]) },
				rt.ArrayItem{ key: 'displayStyle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'woocommerce/product-filter-checkbox-list' },
				]) },
				rt.ArrayItem{ key: 'selectType', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'multiple' },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'sortOrder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'count-desc' },
				]) },
				rt.ArrayItem{ key: 'hideEmpty', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'isPreview', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'style', val: 'woocommerce/product-filter-attribute-view-style' },
		]) },
		rt.ArrayItem{ key: 'product-filter-checkbox-list', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-filter-checkbox-list' },
			rt.ArrayItem{ key: 'title', val: 'List' },
			rt.ArrayItem{ key: 'description', val: 'Display a list of filter options.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filter-attribute' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filter-status' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filter-taxonomy' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filter-rating' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'filterData' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'optionElementBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'customOptionElementBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'optionElementSelected', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'customOptionElementSelected', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'optionElement', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'customOptionElement', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'labelElement', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'customLabelElement', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/product-filter-checkbox-list' },
			rt.ArrayItem{
				key: 'style'
				val: 'file:../woocommerce/product-filter-checkbox-list-style.css'
			},
			rt.ArrayItem{
				key: 'editorStyle'
				val: 'file:../woocommerce/product-filter-checkbox-list-editor.css'
			},
		]) },
		rt.ArrayItem{ key: 'product-filter-chips', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-filter-chips' },
			rt.ArrayItem{ key: 'title', val: 'Chips' },
			rt.ArrayItem{ key: 'description', val: 'Display filter options as chips.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filter-attribute' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filter-taxonomy' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filter-status' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'filterData' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'chipText', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customChipText', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'chipBackground', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customChipBackground', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'chipBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customChipBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'selectedChipText', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customSelectedChipText', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'selectedChipBackground', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customSelectedChipBackground', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'selectedChipBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customSelectedChipBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/product-filter-chips' },
			rt.ArrayItem{ key: 'style', val: 'file:../woocommerce/product-filter-chips-style.css' },
			rt.ArrayItem{
				key: 'editorStyle'
				val: 'file:../woocommerce/product-filter-chips-editor.css'
			},
		]) },
		rt.ArrayItem{ key: 'product-filter-clear-button', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-filter-clear-button' },
			rt.ArrayItem{ key: 'title', val: 'Clear filters' },
			rt.ArrayItem{ key: 'description', val: 'Allows shoppers to clear active filters.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
				rt.ArrayItem{ key: none, val: 'clear filters' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filter-active' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'filterData' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'inserter', val: true },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-filter-price', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-filter-price' },
			rt.ArrayItem{ key: 'title', val: 'Price Filter' },
			rt.ArrayItem{
				key: 'description'
				val: 'Let shoppers filter products by choosing a price range.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filters' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'html', val: false },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'filterParams' },
			]) },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/product-filter-price' },
		]) },
		rt.ArrayItem{ key: 'product-filter-price-slider', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-filter-price-slider' },
			rt.ArrayItem{ key: 'title', val: 'Price Slider' },
			rt.ArrayItem{ key: 'description', val: 'A slider helps shopper choose a price range.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'enableContrastChecker', val: false },
					rt.ArrayItem{ key: 'background', val: false },
					rt.ArrayItem{ key: 'text', val: false },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'showInputFields', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'inlineInput', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'sliderHandle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'customSliderHandle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'sliderHandleBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'customSliderHandleBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'slider', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'customSlider', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filter-price' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'filterData' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/product-filter-price-slider' },
			rt.ArrayItem{
				key: 'style'
				val: 'file:../woocommerce/product-filter-price-slider-style.css'
			},
		]) },
		rt.ArrayItem{ key: 'product-filter-rating', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-filter-rating' },
			rt.ArrayItem{ key: 'title', val: 'Rating Filter' },
			rt.ArrayItem{
				key: 'description'
				val: 'Enable customers to filter the product collection by rating.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.new_array() },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: false },
					rt.ArrayItem{ key: 'text', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filters' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'filterParams' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'showCounts', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'minRating', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '0' },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-filter-removable-chips', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-filter-removable-chips' },
			rt.ArrayItem{ key: 'title', val: 'Chips' },
			rt.ArrayItem{ key: 'description', val: 'Display removable active filters as chips.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filter-active' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowSwitching', val: false },
					rt.ArrayItem{ key: 'allowInheriting', val: false },
					rt.ArrayItem{ key: 'allowVerticalAlignment', val: false },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'flex' },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'filterData' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'chipText', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customChipText', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'chipBackground', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customChipBackground', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'chipBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'customChipBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{
				key: 'style'
				val: 'file:../woocommerce/product-filter-removable-chips-style.css'
			},
		]) },
		rt.ArrayItem{ key: 'product-filter-status', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-filter-status' },
			rt.ArrayItem{ key: 'title', val: 'Status Filter' },
			rt.ArrayItem{
				key: 'description'
				val: 'Let shoppers filter products by choosing stock status.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filters' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'text', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'blockGap', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
						rt.ArrayItem{ key: 'blockGap', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: false },
						rt.ArrayItem{ key: 'radius', val: false },
						rt.ArrayItem{ key: 'style', val: false },
						rt.ArrayItem{ key: 'width', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'showCounts', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'displayStyle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'woocommerce/product-filter-checkbox-list' },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'hideEmpty', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'filterParams' },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'isPreview', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-filter-taxonomy', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-filter-taxonomy' },
			rt.ArrayItem{ key: 'title', val: 'Taxonomy Filter' },
			rt.ArrayItem{
				key: 'description'
				val: 'Enable customers to filter the product collection by selecting one or more taxonomy terms, such as categories, brands, or tags.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-filters' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'text', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
					rt.ArrayItem{ key: 'blockGap', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'margin', val: false },
						rt.ArrayItem{ key: 'padding', val: false },
						rt.ArrayItem{ key: 'blockGap', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'color', val: false },
						rt.ArrayItem{ key: 'radius', val: false },
						rt.ArrayItem{ key: 'style', val: false },
						rt.ArrayItem{ key: 'width', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'filterParams' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'product_cat' },
				]) },
				rt.ArrayItem{ key: 'showCounts', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'displayStyle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'woocommerce/product-filter-checkbox-list' },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'sortOrder', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'count-desc' },
				]) },
				rt.ArrayItem{ key: 'hideEmpty', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'isPreview', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-filters', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-filters' },
			rt.ArrayItem{ key: 'title', val: 'Product Filters' },
			rt.ArrayItem{
				key: 'description'
				val: 'Let shoppers filter products displayed on the page.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'heading', val: true },
					rt.ArrayItem{ key: 'enableContrastChecker', val: false },
					rt.ArrayItem{ key: 'button', val: true },
				]) },
				rt.ArrayItem{ key: 'multiple', val: true },
				rt.ArrayItem{ key: 'inserter', val: true },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
				]) },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'flex' },
						rt.ArrayItem{ key: 'orientation', val: 'vertical' },
						rt.ArrayItem{ key: 'flexWrap', val: 'nowrap' },
						rt.ArrayItem{ key: 'justifyContent', val: 'stretch' },
					]) },
					rt.ArrayItem{ key: 'allowEditing', val: false },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'blockGap', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'queryId' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'isPreview', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/product-filters' },
			rt.ArrayItem{ key: 'style', val: 'file:../woocommerce/product-filters-style.css' },
			rt.ArrayItem{ key: 'editorStyle', val: 'file:../woocommerce/product-filters-editor.css' },
		]) },
		rt.ArrayItem{ key: 'product-gallery', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-gallery' },
			rt.ArrayItem{ key: 'title', val: 'Product Gallery' },
			rt.ArrayItem{
				key: 'description'
				val: 'Showcase your products relevant images and media.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'flex' },
						rt.ArrayItem{ key: 'flexWrap', val: 'nowrap' },
						rt.ArrayItem{ key: 'orientation', val: 'horizontal' },
					]) },
					rt.ArrayItem{ key: 'allowOrientation', val: true },
					rt.ArrayItem{ key: 'allowEditing', val: true },
					rt.ArrayItem{ key: 'allowJustification', val: false },
				]) },
				rt.ArrayItem{ key: 'email', val: true },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'hoverZoom', val: 'hoverZoom' },
				rt.ArrayItem{ key: 'fullScreenOnClick', val: 'fullScreenOnClick' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/single-product' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'hoverZoom', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'fullScreenOnClick', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'viewScript', val: 'wc-product-gallery-frontend' },
			rt.ArrayItem{ key: 'example', val: rt.new_array() },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/product-gallery' },
			rt.ArrayItem{ key: 'style', val: 'file:../woocommerce/product-gallery-style.css' },
		]) },
		rt.ArrayItem{ key: 'product-gallery-large-image', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-gallery-large-image' },
			rt.ArrayItem{ key: 'title', val: 'Viewer' },
			rt.ArrayItem{
				key: 'description'
				val: 'Container for the current gallery image, navigation buttons, zoom functionality and more.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'hoverZoom' },
				rt.ArrayItem{ key: none, val: 'fullScreenOnClick' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-gallery' },
			]) },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/product-gallery-large-image' },
			rt.ArrayItem{
				key: 'editorStyle'
				val: 'file:../woocommerce/product-gallery-large-image-editor.css'
			},
		]) },
		rt.ArrayItem{ key: 'product-gallery-large-image-next-previous', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-gallery-large-image-next-previous' },
			rt.ArrayItem{ key: 'title', val: 'Next/Previous Buttons' },
			rt.ArrayItem{ key: 'description', val: 'Display next and previous buttons.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'iapi/provider' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'flex' },
						rt.ArrayItem{ key: 'flexWrap', val: 'nowrap' },
						rt.ArrayItem{ key: 'verticalAlignment', val: 'center' },
					]) },
					rt.ArrayItem{ key: 'allowVerticalAlignment', val: true },
					rt.ArrayItem{ key: 'allowOrientation', val: false },
					rt.ArrayItem{ key: 'allowJustification', val: false },
				]) },
				rt.ArrayItem{ key: 'shadow', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{
					key: '__experimentalSelector'
					val: '.wc-block-next-previous-buttons__button'
				},
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-gallery-large-image' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-collection' },
			]) },
			rt.ArrayItem{
				key: 'style'
				val: 'file:../woocommerce/product-gallery-large-image-next-previous-style.css'
			},
			rt.ArrayItem{
				key: 'editorStyle'
				val: 'file:../woocommerce/product-gallery-large-image-next-previous-editor.css'
			},
		]) },
		rt.ArrayItem{ key: 'product-gallery-thumbnails', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-gallery-thumbnails' },
			rt.ArrayItem{ key: 'title', val: 'Thumbnails' },
			rt.ArrayItem{ key: 'description', val: 'Display the Thumbnails of a product.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-gallery' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'thumbnailSize', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '25%' },
				]) },
				rt.ArrayItem{ key: 'aspectRatio', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '1' },
				]) },
				rt.ArrayItem{ key: 'activeThumbnailStyle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'overlay' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{
				key: 'editorStyle'
				val: 'file:../woocommerce/product-gallery-thumbnails-editor.css'
			},
		]) },
		rt.ArrayItem{ key: 'product-image', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-image' },
			rt.ArrayItem{ key: 'title', val: 'Product Image' },
			rt.ArrayItem{ key: 'description', val: 'Display the main product image.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'showProductLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'showSaleBadge', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'saleBadgeAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'right' },
				]) },
				rt.ArrayItem{ key: 'imageSizing', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'single' },
				]) },
				rt.ArrayItem{ key: 'productId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfQueryLoop', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfSingleProductBlock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'width', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'height', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'scale', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'cover' },
				]) },
				rt.ArrayItem{ key: 'aspectRatio', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'dimensions', val: rt.create_array([
					rt.ArrayItem{ key: 'aspectRatio', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'email', val: true },
				rt.ArrayItem{
					key: '__experimentalSelector'
					val: '.wc-block-components-product-image'
				},
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/all-products' },
				rt.ArrayItem{ key: none, val: 'woocommerce/single-product' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-template' },
				rt.ArrayItem{ key: none, val: 'core/post-template' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'imageId' },
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'queryId' },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-image-gallery', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-image-gallery' },
			rt.ArrayItem{ key: 'title', val: 'Product Image Gallery' },
			rt.ArrayItem{ key: 'icon', val: 'gallery' },
			rt.ArrayItem{ key: 'description', val: "Display a product's images." },
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'multiple', val: false },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'queryId' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-meta', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-meta' },
			rt.ArrayItem{ key: 'title', val: 'Product Meta' },
			rt.ArrayItem{ key: 'icon', val: 'product' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a product’s SKU, categories, tags, and more.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'queryId' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-new', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-new' },
			rt.ArrayItem{ key: 'title', val: 'Newest Products' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Display a grid of your newest products.' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'columns', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'rows', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'alignButtons', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'contentVisibility', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: true },
						rt.ArrayItem{ key: 'title', val: true },
						rt.ArrayItem{ key: 'price', val: true },
						rt.ArrayItem{ key: 'rating', val: true },
						rt.ArrayItem{ key: 'button', val: true },
					]) },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'title', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'price', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'rating', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'button', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'categories', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
				]) },
				rt.ArrayItem{ key: 'catOperator', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'any' },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'stockStatus', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
				rt.ArrayItem{ key: 'editMode', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'orderby', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'date' },
						rt.ArrayItem{ key: none, val: 'popularity' },
						rt.ArrayItem{ key: none, val: 'price_asc' },
						rt.ArrayItem{ key: none, val: 'price_desc' },
						rt.ArrayItem{ key: none, val: 'rating' },
						rt.ArrayItem{ key: none, val: 'title' },
						rt.ArrayItem{ key: none, val: 'menu_order' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'date' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-on-sale', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-on-sale' },
			rt.ArrayItem{ key: 'title', val: 'On Sale Products' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'description', val: 'Display a grid of products currently on sale.' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'columns', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'rows', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'alignButtons', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'categories', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
				]) },
				rt.ArrayItem{ key: 'catOperator', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'any' },
				]) },
				rt.ArrayItem{ key: 'contentVisibility', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: true },
						rt.ArrayItem{ key: 'title', val: true },
						rt.ArrayItem{ key: 'price', val: true },
						rt.ArrayItem{ key: 'rating', val: true },
						rt.ArrayItem{ key: 'button', val: true },
					]) },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'title', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'price', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'rating', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'button', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'stockStatus', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
				rt.ArrayItem{ key: 'orderby', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'date' },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-price', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-price' },
			rt.ArrayItem{ key: 'title', val: 'Product Price' },
			rt.ArrayItem{ key: 'description', val: 'Display the price of a product.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'productId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfQueryLoop', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfSingleProductTemplate', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfSingleProductBlock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'link', val: false },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
				]) },
				rt.ArrayItem{
					key: '__experimentalSelector'
					val: '.wp-block-woocommerce-product-price .wc-block-components-product-price'
				},
				rt.ArrayItem{ key: 'email', val: true },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/all-products' },
				rt.ArrayItem{ key: none, val: 'woocommerce/featured-product' },
				rt.ArrayItem{ key: none, val: 'woocommerce/single-product' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-template' },
				rt.ArrayItem{ key: none, val: 'core/post-template' },
			]) },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'product-price' },
			rt.ArrayItem{ key: 'style', val: 'file:../product-price.css' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-rating', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-rating' },
			rt.ArrayItem{ key: 'icon', val: 'info' },
			rt.ArrayItem{ key: 'title', val: 'Product Rating' },
			rt.ArrayItem{ key: 'description', val: 'Display the average rating of a product.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'productId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfQueryLoop', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfSingleProductBlock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfSingleProductTemplate', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: false },
					rt.ArrayItem{ key: 'link', val: false },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{
					key: '__experimentalSelector'
					val: '.wc-block-components-product-rating'
				},
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/all-products' },
				rt.ArrayItem{ key: none, val: 'woocommerce/single-product' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-template' },
				rt.ArrayItem{ key: none, val: 'core/post-template' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-rating-counter', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-rating-counter' },
			rt.ArrayItem{ key: 'title', val: 'Product Rating Counter' },
			rt.ArrayItem{ key: 'description', val: 'Display the review count of a product' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'productId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfQueryLoop', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfSingleProductBlock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfSingleProductTemplate', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: 'background', val: false },
					rt.ArrayItem{ key: 'link', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{
					key: '__experimentalSelector'
					val: '.wc-block-components-product-rating-counter'
				},
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/single-product' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-rating-stars', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-rating-stars' },
			rt.ArrayItem{ key: 'title', val: 'Product Rating Stars' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display the average rating of a product with stars'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'productId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfQueryLoop', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfSingleProductBlock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfSingleProductTemplate', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: false },
					rt.ArrayItem{ key: 'link', val: false },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{
					key: '__experimentalSelector'
					val: '.wc-block-components-product-rating'
				},
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/single-product' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-results-count', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-results-count' },
			rt.ArrayItem{ key: 'title', val: 'Product Results Count' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display the number of products on the archive page or search result page.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: false },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'queryId' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-review-author-name', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-review-author-name' },
			rt.ArrayItem{ key: 'title', val: 'Review Author Name' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-reviews' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Displays the name of the author of the review.' },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'isLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '_self' },
				]) },
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'commentId' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-review-content', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-review-content' },
			rt.ArrayItem{ key: 'title', val: 'Review Content' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-reviews' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Displays the contents of a product review.' },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'commentId' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'horizontal' },
						rt.ArrayItem{ key: none, val: 'vertical' },
					]) },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'padding', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-review-date', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-review-date' },
			rt.ArrayItem{ key: 'title', val: 'Review Date' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-reviews' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays the date on which the review was posted.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'format', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'isLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'commentId' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-review-form', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-review-form' },
			rt.ArrayItem{ key: 'title', val: 'Reviews Form' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'description', val: "Display a product's reviews form." },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'heading', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'textAlign', val: 'center' },
				]) },
			]) },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/product-review-form' },
			rt.ArrayItem{ key: 'style', val: 'file:../woocommerce/product-review-form-style.css' },
			rt.ArrayItem{
				key: 'editorStyle'
				val: 'file:../woocommerce/product-review-form-editor.css'
			},
		]) },
		rt.ArrayItem{ key: 'product-review-rating', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-review-rating' },
			rt.ArrayItem{ key: 'title', val: 'Review Rating' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-reviews' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Displays the rating of a product review.' },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'commentId' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-review-template', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-review-template' },
			rt.ArrayItem{ key: 'title', val: 'Reviews Template' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-reviews' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Contains the block elements used to display product reviews, like the title, author, date, rating and more.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-reviews', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-reviews' },
			rt.ArrayItem{ key: 'icon', val: 'admin-comments' },
			rt.ArrayItem{ key: 'title', val: 'Product Reviews' },
			rt.ArrayItem{ key: 'description', val: "Display a product's reviews" },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'tagName', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'div' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'heading', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'radius', val: true },
						rt.ArrayItem{ key: 'color', val: true },
						rt.ArrayItem{ key: 'width', val: true },
						rt.ArrayItem{ key: 'style', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'viewScriptModule', val: 'woocommerce/product-reviews' },
		]) },
		rt.ArrayItem{ key: 'product-reviews-pagination', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-reviews-pagination' },
			rt.ArrayItem{ key: 'title', val: 'Reviews Pagination' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-reviews' },
			]) },
			rt.ArrayItem{ key: 'allowedBlocks', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-reviews-pagination-previous' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-reviews-pagination-numbers' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-reviews-pagination-next' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays a paginated navigation to next/previous set of product reviews, when applicable.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'paginationArrow', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'none' },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'paginationArrow', val: 'none' },
				]) },
			]) },
			rt.ArrayItem{ key: 'providesContext', val: rt.create_array([
				rt.ArrayItem{ key: 'reviews/paginationArrow', val: 'paginationArrow' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
						rt.ArrayItem{ key: 'link', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowSwitching', val: false },
					rt.ArrayItem{ key: 'allowInheriting', val: false },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'flex' },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-reviews-pagination-next', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-reviews-pagination-next' },
			rt.ArrayItem{ key: 'title', val: 'Reviews Next Page' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-reviews-pagination' },
			]) },
			rt.ArrayItem{ key: 'description', val: "Displays the next product review's page link." },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'reviews/paginationArrow' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-reviews-pagination-numbers', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-reviews-pagination-numbers' },
			rt.ArrayItem{ key: 'title', val: 'Reviews Page Numbers' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-reviews-pagination' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays a list of page numbers for product reviews pagination.'
			},
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-reviews-pagination-previous', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-reviews-pagination-previous' },
			rt.ArrayItem{ key: 'title', val: 'Reviews Previous Page' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-reviews-pagination' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: "Displays the previous product review's page link."
			},
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'reviews/paginationArrow' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'text', val: false },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-reviews-title', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-reviews-title' },
			rt.ArrayItem{ key: 'title', val: 'Reviews Title' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-reviews' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Displays a title with the number of reviews.' },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'textAlign', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'showProductTitle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'showReviewsCount', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'level', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 2 },
				]) },
				rt.ArrayItem{ key: 'levelOptions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'anchor', val: false },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: 'style', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
						rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
						rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
						rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-sale-badge', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-sale-badge' },
			rt.ArrayItem{ key: 'title', val: 'On-Sale Badge' },
			rt.ArrayItem{
				key: 'description'
				val: 'Displays an on-sale badge if the product is on-sale.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'productId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfQueryLoop', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfSingleProductBlock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfSingleProductTemplate', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'link', val: false },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
				]) },
				rt.ArrayItem{ key: '__experimentalBorder', val: rt.create_array([
					rt.ArrayItem{ key: 'color', val: true },
					rt.ArrayItem{ key: 'radius', val: true },
					rt.ArrayItem{ key: 'width', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
				]) },
				rt.ArrayItem{ key: 'email', val: true },
				rt.ArrayItem{
					key: '__experimentalSelector'
					val: '.wc-block-components-product-sale-badge'
				},
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/single-product' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-template' },
				rt.ArrayItem{ key: none, val: 'core/post-template' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-gallery' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'example', val: rt.new_array() },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-sku', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-sku' },
			rt.ArrayItem{ key: 'title', val: 'Product SKU' },
			rt.ArrayItem{ key: 'description', val: 'Displays the SKU of a product.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'productId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'isDescendantOfAllProducts', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'showProductSelector', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'prefix', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'SKU:' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
				rt.ArrayItem{ key: 'suffix', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
					rt.ArrayItem{ key: 'role', val: 'content' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/product-meta' },
				rt.ArrayItem{ key: none, val: 'woocommerce/all-products' },
				rt.ArrayItem{ key: none, val: 'woocommerce/single-product' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-template' },
				rt.ArrayItem{ key: none, val: 'core/post-template' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-specifications', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-specifications' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Product Specifications' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display product weight, dimensions, and attributes.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'attributes' },
				rt.ArrayItem{ key: none, val: 'weight' },
				rt.ArrayItem{ key: none, val: 'dimensions' },
				rt.ArrayItem{ key: none, val: 'additional information' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/single-product' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-template' },
				rt.ArrayItem{ key: none, val: 'core/post-template' },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'showWeight', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'showDimensions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'showAttributes', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-stock-indicator', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-stock-indicator' },
			rt.ArrayItem{ key: 'icon', val: 'info' },
			rt.ArrayItem{ key: 'title', val: 'Product Stock Indicator' },
			rt.ArrayItem{
				key: 'description'
				val: 'Let shoppers know when products are out of stock or on backorder. This block is hidden when products are in stock.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'isDescendantOfAllProducts', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/all-products' },
				rt.ArrayItem{ key: none, val: 'woocommerce/single-product' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-template' },
				rt.ArrayItem{ key: none, val: 'core/post-template' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-summary', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-summary' },
			rt.ArrayItem{ key: 'icon', val: 'page' },
			rt.ArrayItem{ key: 'title', val: 'Product Summary' },
			rt.ArrayItem{ key: 'description', val: 'Display a short description about a product.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'productId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfQueryLoop', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfSingleProductTemplate', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isDescendentOfSingleProductBlock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isDescendantOfAllProducts', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'showDescriptionIfEmpty', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'showLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'summaryLength', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'linkText', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'link', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: 'textAlign', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{
					key: '__experimentalSelector'
					val: '.wc-block-components-product-summary'
				},
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/all-products' },
				rt.ArrayItem{ key: none, val: 'woocommerce/featured-product' },
				rt.ArrayItem{ key: none, val: 'woocommerce/single-product' },
				rt.ArrayItem{ key: none, val: 'woocommerce/product-template' },
				rt.ArrayItem{ key: none, val: 'core/post-template' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'postId' },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-tag', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-tag' },
			rt.ArrayItem{ key: 'title', val: 'Products by Tag' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Display a grid of products with selected tags.' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'columns', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'rows', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'alignButtons', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'contentVisibility', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: true },
						rt.ArrayItem{ key: 'title', val: true },
						rt.ArrayItem{ key: 'price', val: true },
						rt.ArrayItem{ key: 'rating', val: true },
						rt.ArrayItem{ key: 'button', val: true },
					]) },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'title', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'price', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'rating', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'button', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'tags', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
				]) },
				rt.ArrayItem{ key: 'tagOperator', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'any' },
				]) },
				rt.ArrayItem{ key: 'orderby', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'date' },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'stockStatus', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'product-template', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-template' },
			rt.ArrayItem{ key: 'title', val: 'Product Template' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{
				key: 'description'
				val: 'Contains the block elements used to render a product.'
			},
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'queryId' },
				rt.ArrayItem{ key: none, val: 'query' },
				rt.ArrayItem{ key: none, val: 'queryContext' },
				rt.ArrayItem{ key: none, val: 'displayLayout' },
				rt.ArrayItem{ key: none, val: 'templateSlug' },
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'queryContextIncludes' },
				rt.ArrayItem{ key: none, val: 'collection' },
				rt.ArrayItem{ key: none, val: '__privateProductCollectionPreviewState' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'anchor', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: 'link', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'background', val: true },
						rt.ArrayItem{ key: 'text', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontStyle', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalTextDecoration', val: true },
					rt.ArrayItem{ key: '__experimentalLetterSpacing', val: true },
					rt.ArrayItem{ key: '__experimentalDefaultControls', val: rt.create_array([
						rt.ArrayItem{ key: 'fontSize', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'layout', val: rt.create_array([
					rt.ArrayItem{ key: 'allowEditing', val: false },
					rt.ArrayItem{ key: 'allowSwitching', val: false },
					rt.ArrayItem{ key: 'allowInheriting', val: false },
					rt.ArrayItem{ key: 'allowSizingOnChildren', val: false },
					rt.ArrayItem{ key: 'allowVerticalAlignment', val: false },
				]) },
				rt.ArrayItem{ key: 'email', val: true },
			]) },
			rt.ArrayItem{ key: 'editorStyle', val: 'file:../woocommerce/product-template-editor.css' },
			rt.ArrayItem{ key: 'style', val: 'file:../woocommerce/product-template-style.css' },
		]) },
		rt.ArrayItem{ key: 'product-title', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-title' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Product Title' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce-product-elements' },
			rt.ArrayItem{ key: 'description', val: 'Display the title of a product.' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
					rt.ArrayItem{ key: 'lineHeight', val: true },
					rt.ArrayItem{ key: '__experimentalFontWeight', val: true },
					rt.ArrayItem{ key: '__experimentalTextTransform', val: true },
					rt.ArrayItem{ key: '__experimentalFontFamily', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'link', val: false },
					rt.ArrayItem{ key: 'gradients', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'margin', val: true },
					rt.ArrayItem{ key: '__experimentalSkipSerialization', val: true },
				]) },
				rt.ArrayItem{
					key: '__experimentalSelector'
					val: '.wc-block-components-product-title'
				},
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'headingLevel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 2 },
				]) },
				rt.ArrayItem{ key: 'showProductLink', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'linkTarget', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'productId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: 'ancestor', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/all-products' },
			]) },
		]) },
		rt.ArrayItem{ key: 'product-top-rated', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/product-top-rated' },
			rt.ArrayItem{ key: 'title', val: 'Top Rated Products' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Display a grid of your top rated products.' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'columns', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'rows', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'alignButtons', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'contentVisibility', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: true },
						rt.ArrayItem{ key: 'title', val: true },
						rt.ArrayItem{ key: 'price', val: true },
						rt.ArrayItem{ key: 'rating', val: true },
						rt.ArrayItem{ key: 'button', val: true },
					]) },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'title', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'price', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'rating', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'button', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'categories', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
				]) },
				rt.ArrayItem{ key: 'catOperator', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'any' },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'stockStatus', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
				rt.ArrayItem{ key: 'editMode', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
				rt.ArrayItem{ key: 'orderby', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'date' },
						rt.ArrayItem{ key: none, val: 'popularity' },
						rt.ArrayItem{ key: none, val: 'price_asc' },
						rt.ArrayItem{ key: none, val: 'price_desc' },
						rt.ArrayItem{ key: none, val: 'rating' },
						rt.ArrayItem{ key: none, val: 'title' },
						rt.ArrayItem{ key: none, val: 'menu_order' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'rating' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'products-by-attribute', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/products-by-attribute' },
			rt.ArrayItem{ key: 'title', val: 'Products by Attribute' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a grid of products with selected attributes.'
			},
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'default', val: rt.new_array() },
				]) },
				rt.ArrayItem{ key: 'attrOperator', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'all' },
						rt.ArrayItem{ key: none, val: 'any' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'any' },
				]) },
				rt.ArrayItem{ key: 'columns', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'contentVisibility', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: true },
						rt.ArrayItem{ key: 'title', val: true },
						rt.ArrayItem{ key: 'price', val: true },
						rt.ArrayItem{ key: 'rating', val: true },
						rt.ArrayItem{ key: 'button', val: true },
					]) },
					rt.ArrayItem{ key: 'properties', val: rt.create_array([
						rt.ArrayItem{ key: 'image', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'title', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'price', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'rating', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
						rt.ArrayItem{ key: 'button', val: rt.create_array([
							rt.ArrayItem{ key: 'type', val: 'boolean' },
							rt.ArrayItem{ key: 'default', val: true },
						]) },
					]) },
				]) },
				rt.ArrayItem{ key: 'orderby', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'date' },
						rt.ArrayItem{ key: none, val: 'popularity' },
						rt.ArrayItem{ key: none, val: 'price_asc' },
						rt.ArrayItem{ key: none, val: 'price_desc' },
						rt.ArrayItem{ key: none, val: 'rating' },
						rt.ArrayItem{ key: none, val: 'title' },
						rt.ArrayItem{ key: none, val: 'menu_order' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'date' },
				]) },
				rt.ArrayItem{ key: 'rows', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'alignButtons', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'stockStatus', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'array' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'rating-filter', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/rating-filter' },
			rt.ArrayItem{ key: 'title', val: 'Filter by Rating Controls' },
			rt.ArrayItem{
				key: 'description'
				val: 'Enable customers to filter the product grid by rating.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'button', val: true },
				]) },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'showCounts', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'displayStyle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'list' },
				]) },
				rt.ArrayItem{ key: 'showFilterButton', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'selectType', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'multiple' },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'related-products', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/related-products' },
			rt.ArrayItem{ key: 'title', val: 'Related Products' },
			rt.ArrayItem{ key: 'icon', val: 'product' },
			rt.ArrayItem{ key: 'description', val: 'Display related products.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'align', val: true },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
			]) },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'queryId' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'reviews-by-category', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/reviews-by-category' },
			rt.ArrayItem{ key: 'title', val: 'Reviews by Category' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Show product reviews from specific categories.' },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: false },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'reviews-by-product', val: rt.create_array([
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: 'name', val: 'woocommerce/reviews-by-product' },
			rt.ArrayItem{ key: 'title', val: 'Reviews by Product' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'description', val: 'Display reviews for your products.' },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: false },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'single-product', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/single-product' },
			rt.ArrayItem{ key: 'icon', val: 'info' },
			rt.ArrayItem{ key: 'title', val: 'Product' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display a single product of your choice with full control over its presentation.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
				rt.ArrayItem{ key: none, val: 'single product' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: true },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'productId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
				]) },
			]) },
			rt.ArrayItem{ key: 'example', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes', val: rt.create_array([
					rt.ArrayItem{ key: 'isPreview', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'usesContext', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'postId' },
				rt.ArrayItem{ key: none, val: 'postType' },
				rt.ArrayItem{ key: none, val: 'queryId' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'stock-filter', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/stock-filter' },
			rt.ArrayItem{ key: 'title', val: 'Filter by Stock Controls' },
			rt.ArrayItem{
				key: 'description'
				val: 'Enable customers to filter the product grid by stock status.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: false },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'background', val: true },
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'button', val: true },
				]) },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'headingLevel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'showCounts', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'showFilterButton', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'displayStyle', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'list' },
				]) },
				rt.ArrayItem{ key: 'selectType', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'multiple' },
				]) },
				rt.ArrayItem{ key: 'isPreview', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'store-notices', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/store-notices' },
			rt.ArrayItem{ key: 'title', val: 'Store Notices' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display shopper-facing notifications generated by WooCommerce or extensions.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'keywords', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'WooCommerce' },
			]) },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
					rt.ArrayItem{ key: none, val: 'full' },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'wide' },
				]) },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'cart-accepted-payment-methods-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-accepted-payment-methods-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Accepted Payment Methods' },
			rt.ArrayItem{ key: 'description', val: 'Display accepted payment methods.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: true },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-cross-sells-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-cross-sells-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Cart Cross-Sells' },
			rt.ArrayItem{ key: 'description', val: 'Shows the Cross-Sells block.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-items-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-cross-sells-products-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-cross-sells-products-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Cart Cross-Sells Products' },
			rt.ArrayItem{ key: 'description', val: 'Shows the Cross-Sells products.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: 'email', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'columns', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 3 },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-cross-sells-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-express-payment-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-express-payment-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Express Checkout' },
			rt.ArrayItem{
				key: 'description'
				val: 'Allow customers to breeze through with quick payment options.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'showButtonStyles', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'buttonHeight', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '48' },
				]) },
				rt.ArrayItem{ key: 'buttonBorderRadius', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '4' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-items-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-items-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Cart Items' },
			rt.ArrayItem{ key: 'description', val: 'Column containing cart items.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/filled-cart-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-line-items-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-line-items-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Cart Line Items' },
			rt.ArrayItem{ key: 'description', val: 'Block containing current line items in Cart.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-items-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-order-summary-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-order-summary-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Order Summary' },
			rt.ArrayItem{ key: 'description', val: 'Show customers a summary of their order.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-order-summary-coupon-form-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-order-summary-coupon-form-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Coupon Form' },
			rt.ArrayItem{ key: 'description', val: 'Shows the apply coupon form.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: false },
						rt.ArrayItem{ key: 'move', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-order-summary-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-order-summary-discount-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-order-summary-discount-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Discount' },
			rt.ArrayItem{ key: 'description', val: 'Shows the cart discount row.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-order-summary-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-order-summary-fee-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-order-summary-fee-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Fees' },
			rt.ArrayItem{ key: 'description', val: 'Shows the cart fee row.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-order-summary-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-order-summary-heading-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-order-summary-heading-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Heading' },
			rt.ArrayItem{ key: 'description', val: 'Shows the heading row.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'content', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: 'Cart totals' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: false },
						rt.ArrayItem{ key: 'move', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-order-summary-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-order-summary-shipping-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-order-summary-shipping-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Shipping' },
			rt.ArrayItem{ key: 'description', val: 'Shows the cart shipping row.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-order-summary-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-order-summary-subtotal-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-order-summary-subtotal-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Subtotal' },
			rt.ArrayItem{ key: 'description', val: 'Shows the cart subtotal row.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-order-summary-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-order-summary-taxes-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-order-summary-taxes-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Taxes' },
			rt.ArrayItem{ key: 'description', val: 'Shows the cart taxes row.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-order-summary-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-order-summary-totals-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-order-summary-totals-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Totals' },
			rt.ArrayItem{
				key: 'description'
				val: 'Shows the subtotal, fees, discounts, shipping and taxes.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-order-summary-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'cart-totals-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/cart-totals-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Cart Totals' },
			rt.ArrayItem{ key: 'description', val: 'Column containing the cart totals.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'checkbox', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'text', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'required', val: false },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/filled-cart-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-actions-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-actions-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Actions' },
			rt.ArrayItem{ key: 'description', val: 'Allow customers to place their order.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
				rt.ArrayItem{ key: 'cartPageId', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'default', val: 0 },
				]) },
				rt.ArrayItem{ key: 'showReturnToCart', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'priceSeparator', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '·' },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-fields-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-additional-information-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-additional-information-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Additional information' },
			rt.ArrayItem{
				key: 'description'
				val: "Render additional fields in the 'Additional information' location."
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-fields-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-billing-address-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-billing-address-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Billing Address' },
			rt.ArrayItem{ key: 'description', val: "Collect your customer's billing address." },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-fields-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-contact-information-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-contact-information-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Contact Information' },
			rt.ArrayItem{ key: 'description', val: "Collect your customer's contact information." },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-fields-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-express-payment-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-express-payment-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Express Checkout' },
			rt.ArrayItem{
				key: 'description'
				val: 'Allow customers to breeze through with quick payment options.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'showButtonStyles', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'buttonHeight', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '48' },
				]) },
				rt.ArrayItem{ key: 'buttonBorderRadius', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '4' },
				]) },
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-fields-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-fields-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-fields-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Checkout Fields' },
			rt.ArrayItem{ key: 'description', val: 'Column containing checkout address fields.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-order-note-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-order-note-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Order Note' },
			rt.ArrayItem{ key: 'description', val: 'Allow customers to add a note to their order.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: false },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-fields-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-order-summary-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-order-summary-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Order Summary' },
			rt.ArrayItem{ key: 'description', val: 'Show customers a summary of their order.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-order-summary-cart-items-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-order-summary-cart-items-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Cart Items' },
			rt.ArrayItem{ key: 'description', val: 'Shows cart items.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'disableProductDescriptions', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-order-summary-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-order-summary-coupon-form-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-order-summary-coupon-form-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Coupon Form' },
			rt.ArrayItem{ key: 'description', val: 'Shows the apply coupon form.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: false },
						rt.ArrayItem{ key: 'move', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-order-summary-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-order-summary-discount-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-order-summary-discount-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Discount' },
			rt.ArrayItem{ key: 'description', val: 'Shows the cart discount row.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-order-summary-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-order-summary-fee-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-order-summary-fee-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Fees' },
			rt.ArrayItem{ key: 'description', val: 'Shows the cart fee row.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-order-summary-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-order-summary-shipping-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-order-summary-shipping-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Shipping' },
			rt.ArrayItem{ key: 'description', val: 'Shows the cart shipping row.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-order-summary-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-order-summary-subtotal-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-order-summary-subtotal-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Subtotal' },
			rt.ArrayItem{ key: 'description', val: 'Shows the cart subtotal row.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-order-summary-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-order-summary-taxes-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-order-summary-taxes-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Taxes' },
			rt.ArrayItem{ key: 'description', val: 'Shows the cart taxes row.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-order-summary-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-order-summary-totals-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-order-summary-totals-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Totals' },
			rt.ArrayItem{
				key: 'description'
				val: 'Shows the subtotal, fees, discounts, shipping and taxes.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-order-summary-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-payment-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-payment-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Payment Options' },
			rt.ArrayItem{ key: 'description', val: 'Payment options for your store.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-fields-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-pickup-options-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-pickup-options-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Pickup Method' },
			rt.ArrayItem{ key: 'description', val: 'Shows local pickup locations.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-fields-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-shipping-address-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-shipping-address-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Shipping Address' },
			rt.ArrayItem{ key: 'description', val: "Collect your customer's shipping address." },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-fields-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-shipping-method-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-shipping-method-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Delivery' },
			rt.ArrayItem{ key: 'description', val: 'Select between shipping or local pickup.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-fields-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-shipping-methods-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-shipping-methods-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Shipping Options' },
			rt.ArrayItem{
				key: 'description'
				val: 'Display shipping options and rates for your store.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-fields-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-terms-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-terms-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Terms and Conditions' },
			rt.ArrayItem{
				key: 'description'
				val: 'Ensure that customers agree to your Terms & Conditions and Privacy Policy.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'checkbox', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'text', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'required', val: false },
				]) },
				rt.ArrayItem{ key: 'showSeparator', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout-fields-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'checkout-totals-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/checkout-totals-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Checkout Totals' },
			rt.ArrayItem{ key: 'description', val: 'Column containing the checkout totals.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'className', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
				rt.ArrayItem{ key: 'checkbox', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'default', val: false },
				]) },
				rt.ArrayItem{ key: 'text', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'required', val: false },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/checkout' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'empty-cart-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/empty-cart-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Empty Cart' },
			rt.ArrayItem{
				key: 'description'
				val: 'Contains blocks that are displayed when the cart is empty.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'empty-mini-cart-contents-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/empty-mini-cart-contents-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Empty Mini-Cart view' },
			rt.ArrayItem{
				key: 'description'
				val: 'Blocks that are displayed when the Mini-Cart is empty.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-contents' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'filled-cart-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/filled-cart-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Filled Cart' },
			rt.ArrayItem{
				key: 'description'
				val: 'Contains blocks that are displayed when the cart contains products.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'wide' },
				]) },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
		rt.ArrayItem{ key: 'filled-mini-cart-contents-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/filled-mini-cart-contents-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Filled Mini-Cart view' },
			rt.ArrayItem{
				key: 'description'
				val: 'Contains blocks that display the content of the Mini-Cart.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-contents' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'mini-cart-cart-button-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/mini-cart-cart-button-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Mini-Cart View Cart Button' },
			rt.ArrayItem{
				key: 'description'
				val: 'Block that displays the cart button when the Mini-Cart has products.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: false },
						rt.ArrayItem{ key: 'move', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'cartButtonLabel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'styles', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'fill' },
					rt.ArrayItem{ key: 'label', val: 'Fill' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'outline' },
					rt.ArrayItem{ key: 'label', val: 'Outline' },
					rt.ArrayItem{ key: 'isDefault', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-footer-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'mini-cart-checkout-button-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/mini-cart-checkout-button-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Mini-Cart Proceed to Checkout Button' },
			rt.ArrayItem{
				key: 'description'
				val: 'Block that displays the checkout button when the Mini-Cart has products.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: false },
						rt.ArrayItem{ key: 'move', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'checkoutButtonLabel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'styles', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'fill' },
					rt.ArrayItem{ key: 'label', val: 'Fill' },
					rt.ArrayItem{ key: 'isDefault', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'outline' },
					rt.ArrayItem{ key: 'label', val: 'Outline' },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-footer-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'mini-cart-footer-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/mini-cart-footer-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Mini-Cart Footer' },
			rt.ArrayItem{
				key: 'description'
				val: 'Block that displays the footer of the Mini-Cart block.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/filled-mini-cart-contents-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'mini-cart-items-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/mini-cart-items-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Mini-Cart Items' },
			rt.ArrayItem{
				key: 'description'
				val: 'Contains the products table and other custom blocks of filled mini-cart.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/filled-mini-cart-contents-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'mini-cart-products-table-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/mini-cart-products-table-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Mini-Cart Products Table' },
			rt.ArrayItem{
				key: 'description'
				val: 'Block that displays the products table of the Mini-Cart block.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: false },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-items-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'mini-cart-shopping-button-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/mini-cart-shopping-button-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Mini-Cart Shopping Button' },
			rt.ArrayItem{
				key: 'description'
				val: 'Block that displays the shopping button when the Mini-Cart is empty.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: true },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: false },
						rt.ArrayItem{ key: 'move', val: false },
					]) },
				]) },
				rt.ArrayItem{ key: 'startShoppingButtonLabel', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'styles', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'fill' },
					rt.ArrayItem{ key: 'label', val: 'Fill' },
					rt.ArrayItem{ key: 'isDefault', val: true },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: 'outline' },
					rt.ArrayItem{ key: 'label', val: 'Outline' },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/empty-mini-cart-contents-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'mini-cart-title-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/mini-cart-title-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Mini-Cart Title' },
			rt.ArrayItem{
				key: 'description'
				val: 'Block that displays the title of the Mini-Cart block.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: false },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/filled-mini-cart-contents-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'mini-cart-title-items-counter-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/mini-cart-title-items-counter-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Mini-Cart Title Items Counter' },
			rt.ArrayItem{
				key: 'description'
				val: 'Block that displays the items counter part of the Mini-Cart Title block.'
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: true },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-title-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'mini-cart-title-label-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/mini-cart-title-label-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Mini-Cart Title Label' },
			rt.ArrayItem{
				key: 'description'
				val: "Block that displays the 'Your cart' part of the Mini-Cart Title block."
			},
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
				rt.ArrayItem{ key: 'color', val: rt.create_array([
					rt.ArrayItem{ key: 'text', val: true },
					rt.ArrayItem{ key: 'background', val: true },
				]) },
				rt.ArrayItem{ key: 'typography', val: rt.create_array([
					rt.ArrayItem{ key: 'fontSize', val: true },
				]) },
				rt.ArrayItem{ key: 'spacing', val: rt.create_array([
					rt.ArrayItem{ key: 'padding', val: true },
				]) },
				rt.ArrayItem{ key: 'interactivity', val: rt.create_array([
					rt.ArrayItem{ key: 'clientNavigation', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'label', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'default', val: '' },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/mini-cart-title-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
		]) },
		rt.ArrayItem{ key: 'proceed-to-checkout-block', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: 'woocommerce/proceed-to-checkout-block' },
			rt.ArrayItem{ key: 'version', val: '1.0.0' },
			rt.ArrayItem{ key: 'title', val: 'Proceed to Checkout' },
			rt.ArrayItem{ key: 'description', val: 'Allow customers proceed to Checkout.' },
			rt.ArrayItem{ key: 'category', val: 'woocommerce' },
			rt.ArrayItem{ key: 'supports', val: rt.create_array([
				rt.ArrayItem{ key: 'align', val: false },
				rt.ArrayItem{ key: 'html', val: false },
				rt.ArrayItem{ key: 'multiple', val: false },
				rt.ArrayItem{ key: 'reusable', val: false },
				rt.ArrayItem{ key: 'inserter', val: false },
				rt.ArrayItem{ key: 'lock', val: false },
			]) },
			rt.ArrayItem{ key: 'attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'lock', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'object' },
					rt.ArrayItem{ key: 'default', val: rt.create_array([
						rt.ArrayItem{ key: 'remove', val: true },
						rt.ArrayItem{ key: 'move', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'parent', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'woocommerce/cart-totals-block' },
			]) },
			rt.ArrayItem{ key: 'textdomain', val: 'woocommerce' },
			rt.ArrayItem{ key: '$schema', val: 'https://schemas.wp.org/trunk/block.json' },
			rt.ArrayItem{ key: 'apiVersion', val: 3 },
		]) },
	])
}
