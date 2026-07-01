import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductReviewSchema.identifier() string {
	return 'product-review'
}
struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductReviewSchema {
	rt.PhpObjectBase
pub mut:
		title rt.PhpVal = rt.new_string('product_review')
		image_attachment_schema rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductReviewSchema) construct(mut var_extend Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema, mut var_controller Class_Automattic_WooCommerce_StoreApi_SchemaController)  {
	this.Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema.construct(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema', []string{}, var_extend), rt.new_object('Automattic_WooCommerce_StoreApi_SchemaController', []string{}, var_controller))
	this.image_attachment_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_ProductReviewSchema', ['Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema'], &this), 'controller'), 'get', [Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema.identifier()])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductReviewSchema) get_properties() rt.PhpVal {
	mut var_properties := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_created', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the review was created, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'formatted_date_created', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the review was created, in the site\'s timezone in human-readable format.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the review was created, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'product_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the product that the review belongs to.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'product_name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Name of the product that the review belongs to.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'product_permalink', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Permalink of the product that the review belongs to.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'product_image', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Image of the product that the review belongs to.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.call_method(this.image_attachment_schema, 'get_properties', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'reviewer', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Reviewer name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'review', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The content of the review.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_filter_post_kses' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'rating', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Review rating (0 to 5).'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'verified', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Shows if the reviewer bought the product or not.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }])
	if rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')])) {
		mut var_avatar_properties := rt.new_array()
		mut var_avatar_sizes := rt.call_function('rest_get_avatar_sizes', []rt.PhpVal{})
		{
			mut iter_1 := var_avatar_sizes.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_size := item_1.val
				var_avatar_properties.array_set(var_size, rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Avatar URL with image size of %d pixels.'), rt.new_string('woocommerce')]), var_size.dup()]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'embed' }, rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }]))
			}
		}
		var_properties.array_set('reviewer_avatar_urls', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Avatar URLs for the object reviewer.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: var_avatar_properties }]))
	}
	return var_properties.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductReviewSchema) get_item_response(var_review rt.PhpVal) rt.PhpVal {
	mut var_rating := if rt.is_true(rt.identical(rt.call_function('get_comment_meta', [rt.get_property(var_review, 'comment_ID'), rt.new_string('rating'), rt.new_bool(true)]), rt.new_string(''))) { rt.new_null() } else { // unsupported expression: Expr_Cast_Int }
	return rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_review, 'comment_date')]) }, rt.ArrayItem{ key: 'formatted_date_created', val: rt.call_function('get_comment_date', [rt.new_string('F j, Y'), rt.get_property(var_review, 'comment_ID')]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_review, 'comment_date_gmt')]) }, rt.ArrayItem{ key: 'product_id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'product_name', val: rt.call_function('get_the_title', [// unsupported expression: Expr_Cast_Int]) }, rt.ArrayItem{ key: 'product_permalink', val: rt.call_function('get_permalink', [// unsupported expression: Expr_Cast_Int]) }, rt.ArrayItem{ key: 'product_image', val: rt.call_method(this.image_attachment_schema, 'get_item_response', [rt.call_function('get_post_thumbnail_id', [// unsupported expression: Expr_Cast_Int])]) }, rt.ArrayItem{ key: 'reviewer', val: rt.get_property(var_review, 'comment_author') }, rt.ArrayItem{ key: 'review', val: rt.call_function('wpautop', [rt.get_property(var_review, 'comment_content')]) }, rt.ArrayItem{ key: 'rating', val: var_rating }, rt.ArrayItem{ key: 'verified', val: rt.call_function('wc_review_is_from_verified_owner', [rt.get_property(var_review, 'comment_ID')]) }, rt.ArrayItem{ key: 'reviewer_avatar_urls', val: rt.call_function('rest_get_avatar_urls', [rt.get_property(var_review, 'comment_author_email')]) }])
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_productreviewschema(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductReviewSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductReviewSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title: rt.new_string('product_review')
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductReviewSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductReviewSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		'image_attachment_schema' { return this.image_attachment_schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductReviewSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_storeapi_schemas_v1_productreviewschema_php() {
}
