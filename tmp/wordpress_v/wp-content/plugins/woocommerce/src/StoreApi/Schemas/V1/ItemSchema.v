import rt

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema) get_properties() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'key', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the item.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'type', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The item type.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The item product or variation ID.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'quantity', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Quantity of this item.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'number' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'quantity_limits', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('How the quantity of this item should be controlled, for example, any limits in place.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: 'minimum', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The minimum quantity allowed for this line item.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
				rt.ArrayItem{ key: 'maximum', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The maximum quantity allowed for this line item.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
				rt.ArrayItem{ key: 'multiple_of', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The amount that quantities increment by. Quantity must be an multiple of this value.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'number' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'default', val: 1 },
				]) },
				rt.ArrayItem{ key: 'editable', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('If the quantity is editable or fixed.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'boolean' },
					rt.ArrayItem{ key: 'context', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'view' },
						rt.ArrayItem{ key: none, val: 'edit' },
					]) },
					rt.ArrayItem{ key: 'readonly', val: true },
					rt.ArrayItem{ key: 'default', val: true },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'name', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Product name.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'short_description', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Product short description in HTML format.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Product full description in HTML format.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'sku', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Stock keeping unit, if applicable.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'low_stock_remaining', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Quantity left in stock if stock is low, or null if not applicable.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'number' },
				rt.ArrayItem{ key: none, val: 'null' },
			]) },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'backorders_allowed', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('True if backorders are allowed past stock availability.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'boolean' },
			]) },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'show_backorder_badge', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('True if the product is on backorder.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'boolean' },
			]) },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'sold_individually', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('If true, only one item of this product is allowed for purchase in a single order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'boolean' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'permalink', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Product URL.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'format', val: 'uri' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'images', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('List of images.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema', [
					'Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema',
				], &this), 'image_attachment_schema'), 'get_properties', []rt.PhpVal{}) },
			]) },
		]) },
		rt.ArrayItem{ key: 'variation', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Chosen attributes (for variations).'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'raw_attribute', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Variation system generated attribute name.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'attribute', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Variation attribute name.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'value', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Variation attribute value.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'item_data', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Metadata related to the item'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'array' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'items', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'name', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Name of the metadata.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'value', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Value of the metadata.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'display', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Optionally, how the metadata value should be displayed to the user.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'prices', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Price data for the product in the current line item, including or excluding taxes based on the "display prices during cart and checkout" setting. Provided using the smallest unit of the currency.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'properties', val: rt.call_function('array_merge', [
				this.get_store_currency_properties(),
				rt.create_array([
					rt.ArrayItem{ key: 'price', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Current product price.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'regular_price', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Regular product price.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'sale_price', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Sale product price, if applicable.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'price_range', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Price range, if applicable.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'object' },
							rt.ArrayItem{ key: none, val: 'null' },
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'min_amount', val: rt.create_array([
								rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
									rt.new_string('Price amount.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'max_amount', val: rt.create_array([
								rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
									rt.new_string('Price amount.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
						]) },
					]) },
					rt.ArrayItem{ key: 'raw_prices', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Raw unrounded product prices used in calculations. Provided using a higher unit of precision than the currency.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'object' },
							rt.ArrayItem{ key: none, val: 'null' },
						]) },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
						rt.ArrayItem{ key: 'properties', val: rt.create_array([
							rt.ArrayItem{ key: 'precision', val: rt.create_array([
								rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
									rt.new_string('Decimal precision of the returned prices.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'type', val: 'integer' },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'price', val: rt.create_array([
								rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
									rt.new_string('Current product price.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'regular_price', val: rt.create_array([
								rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
									rt.new_string('Regular product price.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
							rt.ArrayItem{ key: 'sale_price', val: rt.create_array([
								rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
									rt.new_string('Sale product price, if applicable.'),
									rt.new_string('woocommerce'),
								]) },
								rt.ArrayItem{ key: 'type', val: 'string' },
								rt.ArrayItem{ key: 'context', val: rt.create_array([
									rt.ArrayItem{ key: none, val: 'view' },
									rt.ArrayItem{ key: none, val: 'edit' },
								]) },
								rt.ArrayItem{ key: 'readonly', val: true },
							]) },
						]) },
					]) },
				]),
			]) },
		]) },
		rt.ArrayItem{ key: 'totals', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Item total amounts provided using the smallest unit of the currency.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'properties', val: rt.call_function('array_merge', [
				this.get_store_currency_properties(),
				rt.create_array([
					rt.ArrayItem{ key: 'line_subtotal', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Line subtotal (the price of the product before coupon discounts have been applied).'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'line_subtotal_tax', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Line subtotal tax.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'line_total', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Line total (the price of the product after coupon discounts have been applied).'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'line_total_tax', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Line total tax.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]),
			]) },
		]) },
		rt.ArrayItem{ key: 'catalog_visibility', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Whether the product is visible in the catalog'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema.extending_key()
			val: this.get_extended_schema(Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema.identifier())
		},
	])
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_itemschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_productschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_properties' {
			return this.get_properties()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ItemSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_schemas_v1_itemschema_php() {
	// unsupported statement: Stmt_Declare
}
