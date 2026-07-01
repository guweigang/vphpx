import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema.identifier() string {
	return 'product'
}
struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema {
	rt.PhpObjectBase
pub mut:
		title rt.PhpVal = rt.new_string('product')
		image_attachment_schema rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) construct(mut var_extend Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema, mut var_controller Class_Automattic_WooCommerce_StoreApi_SchemaController)  {
	this.Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema.construct(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema', []string{}, var_extend), rt.new_object('Automattic_WooCommerce_StoreApi_SchemaController', []string{}, var_controller))
	this.image_attachment_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema', ['Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema'], &this), 'controller'), 'get', [Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema.identifier()])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) get_properties() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product slug.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }]) }, rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('ID of the parent product, if applicable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product type.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'variation', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product variation attributes, if applicable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }]) }, rt.ArrayItem{ key: 'permalink', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product URL.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'short_description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product short description in HTML format.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product full description in HTML format.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }]) }, rt.ArrayItem{ key: 'on_sale', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Is the product on sale?'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'sku', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }]) }, rt.ArrayItem{ key: 'prices', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Price data provided using the smallest unit of the currency.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.call_function('array_merge', [this.get_store_currency_properties(), rt.create_array([rt.ArrayItem{ key: 'price', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Current product price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'regular_price', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Regular product price.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'sale_price', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Sale product price, if applicable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'price_range', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Price range, if applicable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'object' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'min_amount', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Price amount.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'max_amount', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Price amount.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }])]) }]) }, rt.ArrayItem{ key: 'price_html', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Price string formatted as HTML.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'average_rating', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Reviews average rating.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'review_count', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Amount of reviews that the product has.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'images', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of images.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.call_method(this.image_attachment_schema, 'get_properties', []rt.PhpVal{}) }]) }]) }, rt.ArrayItem{ key: 'categories', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of categories, if applicable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Category ID'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Category name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Category slug'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'link', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Category link'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }, rt.ArrayItem{ key: 'tags', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of tags, if applicable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tag ID'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tag name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tag slug'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'link', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tag link.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }, rt.ArrayItem{ key: 'brands', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of brands, if applicable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Brand ID'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Brand name'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Brand slug'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'link', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Brand link'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of attributes (taxonomy terms) assigned to the product. For variable products, these are mapped to variations (see the `variations` field).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The attribute ID, or 0 if the attribute is not taxonomy based.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The attribute name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'taxonomy', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The attribute taxonomy, or null if the attribute is not taxonomy based.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'has_variations', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('True if this attribute is used by product variations.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'terms', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of assigned attribute terms.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The term ID, or 0 if the attribute is not a global attribute.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The term name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The term slug.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'default', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If this is a default attribute'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'variations', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of variation IDs, if applicable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The attribute ID, or 0 if the attribute is not taxonomy based.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'attributes', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of variation attributes.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The attribute name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'value', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The assigned attribute.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'grouped_products', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of grouped product IDs, if applicable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of grouped product ids.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }, rt.ArrayItem{ key: 'has_options', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Does the product have additional options before it can be added to the cart?'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'is_purchasable', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Is the product purchasable?'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'is_in_stock', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Is the product in stock?'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'is_on_backorder', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Is the product stock backordered? This will also return false if backorder notifications are turned off.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'stock_availability', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Information about the product\'s availability.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'text', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stock availability text.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'class', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Stock availability class.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }, rt.ArrayItem{ key: 'low_stock_remaining', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Quantity left in stock if stock is low, or null if not applicable.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'number' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'sold_individually', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If true, only one item of this product is allowed for purchase in a single order.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'weight', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product weight (%s).'), rt.new_string('woocommerce')]), rt.call_function('get_option', [rt.new_string('woocommerce_weight_unit')])]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'dimensions', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product dimensions.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'length', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product length (%s).'), rt.new_string('woocommerce')]), rt.call_function('get_option', [rt.new_string('woocommerce_dimension_unit')])]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'width', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product width (%s).'), rt.new_string('woocommerce')]), rt.call_function('get_option', [rt.new_string('woocommerce_dimension_unit')])]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'height', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Product height (%s).'), rt.new_string('woocommerce')]), rt.call_function('get_option', [rt.new_string('woocommerce_dimension_unit')])]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }, rt.ArrayItem{ key: 'formatted_weight', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product weight formatted for display (e.g. "2.5 kg").'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'formatted_dimensions', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product dimensions formatted for display (e.g. "10 × 5 × 3 cm").'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'add_to_cart', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Add to cart button parameters.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'text', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Button text.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Button description.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'url', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Add to cart URL.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'minimum', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The minimum quantity that can be added to the cart.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'maximum', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The maximum quantity that can be added to the cart.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'multiple_of', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The amount that quantities increment by. Quantity must be an multiple of this value.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'default', val: 1 }]) }, rt.ArrayItem{ key: 'single_text', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Button text in the single product page.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }, rt.ArrayItem{ key: 'is_password_protected', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the product requires a password to access its content.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema.extending_key(), val: this.get_extended_schema(Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema.identifier()) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) get_item_response(var_product rt.PhpVal) rt.PhpVal {
	mut var_availability := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils{}; return temp.get_product_availability(arg_0) }(var_product.dup())
	mut var_password_required := rt.call_function('post_password_required', [rt.call_method(var_product, 'get_id', []rt.PhpVal{})])
	mut var_short_description := if rt.is_true(var_password_required) { rt.new_string('') } else { this.prepare_html_response(rt.call_function('wc_format_content', [rt.call_function('wp_kses_post', [rt.call_method(var_product, 'get_short_description', []rt.PhpVal{})])])) }
	mut var_description := if rt.is_true(var_password_required) { rt.new_string('') } else { this.prepare_html_response(rt.call_function('wc_format_content', [rt.call_function('wp_kses_post', [rt.call_method(var_product, 'get_description', []rt.PhpVal{})])])) }
	return rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'name', val: this.prepare_html_response(rt.call_method(var_product, 'get_title', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'slug', val: rt.call_method(var_product, 'get_slug', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'parent', val: rt.call_method(var_product, 'get_parent_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'type', val: rt.call_method(var_product, 'get_type', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'variation', val: this.prepare_html_response(if rt.is_true(rt.call_method(var_product, 'is_type', [Class_Automattic_WooCommerce_Enums_ProductType.variation()])) { rt.call_function('wc_get_formatted_variation', [var_product.dup(), rt.new_bool(true), rt.new_bool(true), rt.new_bool(false)]) } else { rt.new_string('') }) }, rt.ArrayItem{ key: 'permalink', val: rt.call_method(var_product, 'get_permalink', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'sku', val: this.prepare_html_response(rt.call_method(var_product, 'get_sku', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'short_description', val: var_short_description }, rt.ArrayItem{ key: 'description', val: var_description }, rt.ArrayItem{ key: 'on_sale', val: rt.call_method(var_product, 'is_on_sale', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'prices', val: // unsupported expression: Expr_Cast_Object }, rt.ArrayItem{ key: 'price_html', val: this.prepare_html_response(rt.call_method(var_product, 'get_price_html', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'average_rating', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'review_count', val: rt.call_method(var_product, 'get_review_count', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'images', val: this.get_images(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](var_product)) }, rt.ArrayItem{ key: 'categories', val: this.get_term_list(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](var_product), 'product_cat') }, rt.ArrayItem{ key: 'tags', val: this.get_term_list(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](var_product), 'product_tag') }, rt.ArrayItem{ key: 'brands', val: this.get_term_list(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](var_product), 'product_brand') }, rt.ArrayItem{ key: 'attributes', val: this.get_attributes(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](var_product)) }, rt.ArrayItem{ key: 'variations', val: this.get_variations(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](var_product)) }, rt.ArrayItem{ key: 'grouped_products', val: this.get_grouped_products(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](var_product)) }, rt.ArrayItem{ key: 'has_options', val: rt.call_method(var_product, 'has_options', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_purchasable', val: rt.call_method(var_product, 'is_purchasable', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_in_stock', val: rt.call_method(var_product, 'is_in_stock', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'is_on_backorder', val: rt.identical(Class_Automattic_WooCommerce_Enums_ProductStockStatus.on_backorder(), rt.call_method(var_product, 'get_stock_status', []rt.PhpVal{})) }, rt.ArrayItem{ key: 'low_stock_remaining', val: this.get_low_stock_remaining(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](var_product)) }, rt.ArrayItem{ key: 'stock_availability', val: // unsupported expression: Expr_Cast_Object }, rt.ArrayItem{ key: 'sold_individually', val: rt.call_method(var_product, 'is_sold_individually', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'weight', val: rt.call_method(var_product, 'get_weight', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'dimensions', val: // unsupported expression: Expr_Cast_Object }, rt.ArrayItem{ key: 'formatted_weight', val: rt.call_function('wc_format_weight', [// unsupported expression: Expr_Cast_Double]) }, rt.ArrayItem{ key: 'formatted_dimensions', val: rt.call_function('html_entity_decode', [rt.call_function('wc_format_dimensions', [rt.cast_array(rt.call_method(var_product, 'get_dimensions', [rt.new_bool(false)]))]), rt.get_constant('ENT_QUOTES'), rt.call_function('get_bloginfo', [rt.new_string('charset')])]) }, rt.ArrayItem{ key: 'add_to_cart', val: // unsupported expression: Expr_Cast_Object }, rt.ArrayItem{ key: 'is_password_protected', val: // unsupported expression: Expr_BinaryOp_NotIdentical }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema.extending_key(), val: this.get_extended_data(Class_Automattic_WooCommerce_StoreApi_Schemas_V1_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema.identifier(), var_product.dup()) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) get_images(mut var_product Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product) rt.PhpVal {
	mut var_attachment_ids := rt.call_function('array_filter', [rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: var_product.get_image_id() }]), var_product.get_gallery_image_ids()])])
	if !(!rt.is_true(var_attachment_ids)) {
		rt.call_function('_prime_post_caches', [var_attachment_ids.dup()])
	}
	return rt.call_function('array_values', [rt.call_function('array_filter', [rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: this.image_attachment_schema }, rt.ArrayItem{ key: none, val: 'get_item_response' }]), var_attachment_ids.dup()])])])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) get_remaining_stock(mut var_product Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_product.get_stock_quantity().is_null())) {
		return rt.new_null()
	}
	return var_product.get_stock_quantity()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) get_low_stock_remaining(mut var_product Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product) rt.PhpVal {
	mut var_remaining_stock := this.get_remaining_stock(mut var_product)
	mut var_stock_format := rt.call_function('get_option', [rt.new_string('woocommerce_stock_format')])
	if rt.is_true(rt.identical(rt.new_string('no_amount'), var_stock_format)) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_remaining_stock.dup().is_null()))))) && rt.is_true(rt.less_equal(var_remaining_stock, rt.call_function('wc_get_low_stock_amount', [var_product]))))) {
		return rt.call_function('max', [var_remaining_stock.dup(), rt.new_int(0)])
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) filter_valid_attribute(var_attribute rt.PhpVal) rt.PhpVal {
	return rt.call_function('is_a', [var_attribute.dup(), rt.new_string('\\WC_Product_Attribute')])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) filter_variation_attribute(var_attribute rt.PhpVal) bool {
	return rt.is_true(this.filter_valid_attribute(var_attribute.dup())) && rt.is_true(rt.call_method(var_attribute, 'get_variation', []rt.PhpVal{}))
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) get_variations(mut var_product Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_variation_ids := if rt.is_true(var_product.is_type(Class_Automattic_WooCommerce_Enums_ProductType.variable())) { var_product.get_visible_children() } else { rt.new_array() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(var_variation_ids.dup().array_count()))))) {
		return rt.new_array()
	}
	mut var_attributes := rt.call_function('array_filter', [var_product.get_attributes(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema', ['Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema'], &this) }, rt.ArrayItem{ key: none, val: 'filter_variation_attribute' }])])
	closure_1_fn := fn [var_product] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_defaults := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_attribute := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_meta_key := rt.call_function('wc_variation_attribute_name', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])
	var_defaults.array_set(var_meta_key, rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('wc_attribute_label', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}), var_product]) }, rt.ArrayItem{ key: 'value', val: rt.new_null() }]))
	return var_defaults.dup()
	}
	mut var_default_variation_meta_data := rt.call_function('array_reduce', [var_attributes.dup(), rt.new_closure(closure_1_fn), rt.new_array()])
	mut var_default_variation_meta_keys := rt.func_array_keys(var_default_variation_meta_data.dup())
	mut var_cache_group := rt.new_string(rt.new_string('product_variation_meta_data'))
	mut var_cache_value := rt.call_function('wp_cache_get', [var_product.get_id(), var_cache_group.dup()])
	mut var_last_modified := rt.call_function('get_the_modified_date', [rt.new_string('U'), var_product.get_id()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_cache_value)) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		// unsupported statement: Stmt_Global
		mut var_variation_meta_data := rt.call_method(var_wpdb, 'get_results', [rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT post_id as variation_id, meta_key as attribute_key, meta_value as attribute_value\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\t\t\tWHERE post_id IN (')) + (rt.call_function('implode', [rt.new_string(','), rt.call_function('array_map', [rt.new_string('esc_sql'), var_variation_ids.dup()])])).str() + ')\n\t\t\t\tAND meta_key IN (\'' + (rt.call_function('implode', [rt.new_string('\',\''), rt.call_function('array_map', [rt.new_string('esc_sql'), var_default_variation_meta_keys.dup()])])).str() + '\')\n\t\t\t'])
		rt.call_function('wp_cache_set', [var_product.get_id(), rt.create_array([rt.ArrayItem{ key: 'last_modified', val: var_last_modified }, rt.ArrayItem{ key: 'data', val: var_variation_meta_data }]), var_cache_group.dup()])
	} else {
		var_variation_meta_data = var_cache_value.array_get('data')
	}
	closure_2_fn := fn [var_default_variation_meta_keys] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_values := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_data := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	if rt.is_true(rt.call_function('in_array', [rt.get_property(var_data, 'attribute_key'), var_default_variation_meta_keys.dup(), rt.new_bool(true)])) {
		var_values.array_get_mut(rt.get_property(var_data, 'variation_id')).array_set(rt.get_property(var_data, 'attribute_key'), rt.get_property(var_data, 'attribute_value'))
	}
	return var_values.dup()
	}
	mut var_attributes_by_variation := rt.call_function('array_reduce', [var_variation_meta_data.dup(), rt.new_closure(closure_2_fn), rt.call_function('array_fill_keys', [var_variation_ids.dup(), rt.new_array()])])
	mut var_variations := rt.new_array()
	{
		mut iter_1 := var_variation_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_variation_id := item_1.val
			mut var_attribute_data := var_default_variation_meta_data.dup()
			{
				mut iter_2 := var_attributes_by_variation.array_get(var_variation_id).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_meta_value := item_2.val
					mut var_meta_key := item_2.key
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						var_attribute_data.array_get_mut(var_meta_key).array_set('value', var_meta_value.dup())
					}
				}
			}
			var_variations.array_push(// unsupported expression: Expr_Cast_Object)
		}
	}
	return var_variations.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) get_grouped_products(mut var_product Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product) rt.PhpVal {
	if rt.is_true(var_product.is_type(Class_Automattic_WooCommerce_Enums_ProductType.grouped())) {
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_child := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_child, 'get_id', []rt.PhpVal{})
	}
	mut var_child := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_child, 'get_id', []rt.PhpVal{})
	}
		return rt.call_function('array_map', [rt.new_closure(closure_3_fn), var_product.get_visible_children()])
	}
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) get_attributes(mut var_product Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product) rt.PhpVal {
	mut var_attributes := rt.call_function('array_filter', [var_product.get_attributes(), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema', ['Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema'], &this) }, rt.ArrayItem{ key: none, val: 'filter_valid_attribute' }])])
	mut var_default_attributes := var_product.get_default_attributes()
	mut var_return := rt.new_array()
	{
		mut iter_1 := var_attributes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_attribute := item_1.val
			mut var_attribute_slug := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_attribute, 'get_visible', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_attribute, 'get_variation', []rt.PhpVal{}))))))) {
				continue
			}
			mut var_terms := if rt.is_true(rt.call_method(var_attribute, 'is_taxonomy', []rt.PhpVal{})) { rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema', ['Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema'], &this) }, rt.ArrayItem{ key: none, val: 'prepare_product_attribute_taxonomy_value' }]), rt.call_method(var_attribute, 'get_terms', []rt.PhpVal{})]) } else { rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema', ['Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema'], &this) }, rt.ArrayItem{ key: none, val: 'prepare_product_attribute_value' }]), rt.call_method(var_attribute, 'get_options', []rt.PhpVal{})]) }
			mut var_sanitized_attribute_name := rt.call_function('sanitize_key', [rt.call_method(var_attribute, 'get_name', []rt.PhpVal{})])
			if rt.is_true(rt.new_bool(var_default_attributes.dup().array_isset(var_sanitized_attribute_name.dup()))) {
				{
					mut iter_2 := var_terms.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_term := item_2.val
						rt.set_property(var_term, 'default', rt.identical(rt.get_property(var_term, 'slug'), var_default_attributes.array_get(var_sanitized_attribute_name)))
					}
				}
			}
			var_return.array_push(// unsupported expression: Expr_Cast_Object)
		}
	}
	return var_return.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) prepare_product_attribute_taxonomy_value(mut var_term Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Term) rt.PhpVal {
	mut var_term_mutated := var_term
	return this.prepare_product_attribute_value(rt.get_property(var_term_mutated, 'name'), (rt.get_property(var_term_mutated, 'term_id')).to_i64(), (rt.get_property(var_term_mutated, 'slug')).str())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) prepare_product_attribute_value(var_name rt.PhpVal, id i64, slug string) rt.PhpVal {
	return // unsupported expression: Expr_Cast_Object
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) prepare_product_price_response(mut var_product Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product, tax_display_mode string) rt.PhpVal {
	mut tax_display_mode_mutated := tax_display_mode
	mut var_prices := rt.new_array()
	tax_display_mode_mutated = (this.get_tax_display_mode(tax_display_mode_mutated)).str()
	mut var_price_function := rt.new_string(this.get_price_function_from_tax_display_mode(rt.new_string(tax_display_mode_mutated)))
	if rt.is_true(var_product.is_type(Class_Automattic_WooCommerce_Enums_ProductType.variable())) {
		mut var_regular_price := var_product.get_variation_regular_price()
		mut var_sale_price := var_product.get_variation_sale_price()
	} else {
		var_regular_price = var_product.get_regular_price()
		var_sale_price = var_product.get_sale_price()
	}
	var_prices.array_set('price', this.prepare_money_response(rt.call_callable(var_price_function, [var_product]), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})))
	var_prices.array_set('regular_price', this.prepare_money_response(rt.call_callable(var_price_function, [var_product, rt.create_array([rt.ArrayItem{ key: 'price', val: var_regular_price }])]), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})))
	var_prices.array_set('sale_price', this.prepare_money_response(rt.call_callable(var_price_function, [var_product, rt.create_array([rt.ArrayItem{ key: 'price', val: var_sale_price }])]), rt.call_function('wc_get_price_decimals', []rt.PhpVal{})))
	var_prices.array_set('price_range', this.get_price_range(mut var_product, tax_display_mode_mutated))
	return this.prepare_currency_response(var_prices.dup())
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) get_tax_display_mode(tax_display_mode string) rt.PhpVal {
	mut tax_display_mode_mutated := tax_display_mode
	return if rt.is_true(rt.call_function('in_array', [rt.new_string(tax_display_mode_mutated).dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'incl' }, rt.ArrayItem{ key: none, val: 'excl' }]), rt.new_bool(true)])) { rt.new_string(tax_display_mode_mutated) } else { rt.call_function('get_option', [rt.new_string('woocommerce_tax_display_shop')]) }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) get_price_function_from_tax_display_mode(var_tax_display_mode rt.PhpVal) string {
	mut var_tax_display_mode_mutated := var_tax_display_mode
	return if rt.is_true(rt.identical(rt.new_string('incl'), var_tax_display_mode_mutated)) { 'wc_get_price_including_tax' } else { 'wc_get_price_excluding_tax' }
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) get_price_range(mut var_product Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product, tax_display_mode string) rt.PhpVal {
	mut var_child_prices := rt.new_null()
	mut tax_display_mode_mutated := tax_display_mode
	tax_display_mode_mutated = (this.get_tax_display_mode(tax_display_mode_mutated)).str()
	if rt.is_true(var_product.is_type(Class_Automattic_WooCommerce_Enums_ProductType.variable())) {
		mut var_prices := var_product.get_variation_prices(rt.new_bool(true))
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_prices.array_get('price'))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return // unsupported expression: Expr_Cast_Object
		}
	}
	if rt.is_true(var_product.is_type(Class_Automattic_WooCommerce_Enums_ProductType.grouped())) {
		mut var_children := var_product.get_visible_children()
		mut var_price_function := rt.new_string(if rt.is_true(rt.identical(rt.new_string('incl'), rt.new_string(tax_display_mode_mutated))) { rt.new_string('wc_get_price_including_tax') } else { rt.new_string('wc_get_price_excluding_tax') })
		{
			mut iter_1 := var_children.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_child := item_1.val
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_child_prices.array_push(rt.call_callable(var_price_function, [var_child.dup()]))
				}
			}
		}
		if !(!rt.is_true(var_child_prices)) {
			return // unsupported expression: Expr_Cast_Object
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) get_term_list(mut var_product Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product, taxonomy string) rt.PhpVal {
	if !(var_taxonomy.len > 0 && var_taxonomy != '0') {
		return rt.new_array()
	}
	mut var_terms := rt.call_function('get_the_terms', [var_product.get_id(), rt.new_string(taxonomy)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_terms)))) || rt.is_true(rt.call_function('is_wp_error', [var_terms.dup()])))) {
		return rt.new_array()
	}
	mut var_return := rt.new_array()
	mut var_default_category := // unsupported expression: Expr_Cast_Int
	{
		mut iter_1 := var_terms.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			
		}
	}
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_productschema(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title: rt.new_string('product')
		image_attachment_schema: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_productavailabilityutils() &Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_SchemaController](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_properties' {
			return this.get_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		'get_images' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_images(mut dispatch_arg_0)
		}
		'get_remaining_stock' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_remaining_stock(mut dispatch_arg_0)
		}
		'get_low_stock_remaining' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_low_stock_remaining(mut dispatch_arg_0)
		}
		'filter_valid_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_valid_attribute(dispatch_arg_0)
		}
		'filter_variation_attribute' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.filter_variation_attribute(dispatch_arg_0))
		}
		'get_variations' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_variations(mut dispatch_arg_0)
		}
		'get_grouped_products' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_grouped_products(mut dispatch_arg_0)
		}
		'get_attributes' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_attributes(mut dispatch_arg_0)
		}
		'prepare_product_attribute_taxonomy_value' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WP_Term](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.prepare_product_attribute_taxonomy_value(mut dispatch_arg_0)
		}
		'prepare_product_attribute_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.prepare_product_attribute_value(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'prepare_product_price_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.prepare_product_price_response(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_tax_display_mode' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_tax_display_mode(dispatch_arg_0)
		}
		'get_price_function_from_tax_display_mode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_price_function_from_tax_display_mode(dispatch_arg_0))
		}
		'get_price_range' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_price_range(mut dispatch_arg_0, dispatch_arg_1)
		}
		'get_term_list' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_V1_WC_Product](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_term_list(mut dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		'image_attachment_schema' { return this.image_attachment_schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' { this.title = val; return true }
		'image_attachment_schema' { this.image_attachment_schema = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_ProductAvailabilityUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_storeapi_schemas_v1_productschema_php() {
}
