import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductBrandSchema.identifier() string {
	return 'product-brand'
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductBrandSchema {
	rt.PhpObjectBase
pub mut:
	title                   rt.PhpVal = rt.new_string('product-brand')
	image_attachment_schema rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductBrandSchema) construct(mut var_extend Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema, mut var_controller Class_Automattic_WooCommerce_StoreApi_SchemaController) {
	this.Class_Automattic_WooCommerce_StoreApi_Schemas_V1_TermSchema.construct(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema',
		[]string{}, var_extend), rt.new_object('Automattic_WooCommerce_StoreApi_SchemaController',
		[]string{}, var_controller))
	this.image_attachment_schema = rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Schemas_V1_ProductBrandSchema', [
		'Automattic_WooCommerce_StoreApi_Schemas_V1_TermSchema',
	], &this), 'controller'), 'get', [
		Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ImageAttachmentSchema.identifier(),
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductBrandSchema) get_properties() rt.PhpVal {
	mut var_schema :=
		this.Class_Automattic_WooCommerce_StoreApi_Schemas_V1_TermSchema.get_properties()
	var_schema.array_set('image', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Brand image.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
		rt.ArrayItem{ key: 'properties', val: rt.call_method(this.image_attachment_schema,
			'get_properties', []rt.PhpVal{}) },
	]))
	var_schema.array_set('review_count', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Number of reviews for products of this brand.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	var_schema.array_set('permalink', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Brand URL.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'uri' },
		rt.ArrayItem{ key: 'context', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'view' },
			rt.ArrayItem{ key: none, val: 'edit' },
			rt.ArrayItem{ key: none, val: 'embed' },
		]) },
		rt.ArrayItem{ key: 'readonly', val: true },
	]))
	return var_schema.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductBrandSchema) get_item_response(var_term rt.PhpVal) rt.PhpVal {
	mut var_response :=
		this.Class_Automattic_WooCommerce_StoreApi_Schemas_V1_TermSchema.get_item_response(var_term.clone())
	mut var_count := rt.call_function('get_term_meta', [
		rt.get_property(var_term, 'term_id'),
		rt.new_string('product_count_product_brand'),
		rt.new_bool(true),
	])
	if rt.is_true(var_count) {
		var_response.array_set('count', rt.new_int(var_count.to_i64()))
	}
	var_response.array_set('image', rt.call_method(this.image_attachment_schema,
		'get_item_response', [
		rt.call_function('get_term_meta', [rt.get_property(var_term, 'term_id'),
			rt.new_string('thumbnail_id'), rt.new_bool(true)]),
	]))
	var_response.array_set('review_count', this.get_brand_review_count(var_term.clone()))
	var_response.array_set('permalink', rt.call_function('get_term_link', [
		rt.get_property(var_term, 'term_id'),
		rt.new_string('product_brand'),
	]))
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductBrandSchema) get_brand_review_count(var_term rt.PhpVal) i64 {
	mut var_wpdb := rt.new_null()
	mut var_children := rt.call_function('get_term_children', [
		rt.get_property(var_term, 'term_id'),
		rt.new_string('product_brand'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_children))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_children.clone()])) {
		mut var_terms_to_count_str := rt.call_function('absint', [
			rt.get_property(var_term, 'term_id'),
		])
	} else {
		mut var_terms_to_count := rt.call_function('array_unique', [
			rt.call_function('array_map', [rt.new_string('absint'),
				rt.call_function('array_merge', [
					rt.create_array([
						rt.ArrayItem{ key: none, val: rt.get_property(var_term, 'term_id') },
					]),
					var_children.clone(),
				])]),
		])
		var_terms_to_count_str = rt.call_function('implode', [
			rt.new_string(','), var_terms_to_count.clone()])
	}
	mut var_products_of_brand_sql := rt.new_string((
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT SUM(comment_count) as review_count\n\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' AS posts\n\t\t\tINNER JOIN ')), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' AS term_relationships ON posts.ID = term_relationships.object_id\n\t\t\tWHERE term_relationships.term_taxonomy_id IN (')) + (rt.call_function('esc_sql', [var_terms_to_count_str.clone()])).str() +
		')\n\t\t').str())
	mut var_review_count := rt.call_method(var_wpdb, 'get_var', [
		var_products_of_brand_sql.clone()])
	return rt.new_int(var_review_count.to_i64())
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_TermSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_productbrandschema(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductBrandSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductBrandSchema{
		PhpObjectBase:           rt.PhpObjectBase{}
		title:                   rt.new_string('product-brand')
		image_attachment_schema: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_termschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_TermSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_TermSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductBrandSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Schemas_ExtendSchema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_SchemaController](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
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
		'get_brand_review_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.get_brand_review_count(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductBrandSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		'image_attachment_schema' { return this.image_attachment_schema }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_ProductBrandSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' {
			this.title = val
			return true
		}
		'image_attachment_schema' {
			this.image_attachment_schema = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_TermSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_TermSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_TermSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
