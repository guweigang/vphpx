import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews.identifier() string {
	return 'product-reviews'
}
pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews.schema_type() string {
	return 'product-review'
}
struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews.get_path_regex() string {
	return '/products/reviews'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews) get_args() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute'], &this) }, rt.ArrayItem{ key: none, val: 'get_response' }]) }, rt.ArrayItem{ key: 'permission_callback', val: '__return_true' }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }, rt.ArrayItem{ key: 'allow_batch', val: rt.create_array([rt.ArrayItem{ key: 'v1', val: true }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute'], &this), 'schema') }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews) get_route_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_prepared_args := rt.create_array([rt.ArrayItem{ key: 'type', val: 'review' }, rt.ArrayItem{ key: 'status', val: 'approve' }, rt.ArrayItem{ key: 'no_found_rows', val: false }, rt.ArrayItem{ key: 'offset', val: var_request.array_get('offset') }, rt.ArrayItem{ key: 'order', val: var_request.array_get('order') }, rt.ArrayItem{ key: 'number', val: var_request.array_get('per_page') }, rt.ArrayItem{ key: 'post__in', val: var_request.array_get('product_id') }])
	if !(!rt.is_true(var_request.array_get('category_id'))) {
		mut var_category_ids := var_request.array_get('category_id')
		mut var_child_ids := rt.new_array()
		{
			mut iter_1 := var_category_ids.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_category_id := item_1.val
				var_child_ids = rt.call_function('array_merge', [var_child_ids.dup(), rt.call_function('get_term_children', [var_category_id.dup(), rt.new_string('product_cat')])])
			}
		}
		var_category_ids = rt.call_function('array_unique', [rt.call_function('array_merge', [var_category_ids.dup(), var_child_ids.dup()])])
		mut var_product_ids := rt.call_function('get_objects_in_term', [var_category_ids.dup(), rt.new_string('product_cat')])
		var_prepared_args.array_set('post__in', if var_prepared_args.array_isset(rt.new_string('post__in')) { rt.call_function('array_merge', [var_prepared_args.array_get('post__in'), var_product_ids.dup()]) } else { var_product_ids })
	}
	if rt.is_true(rt.identical(rt.new_string('rating'), var_request.array_get('orderby'))) {
		var_prepared_args.array_set('meta_query', rt.create_array([rt.ArrayItem{ key: 'relation', val: 'OR' }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: 'rating' }, rt.ArrayItem{ key: 'compare', val: 'EXISTS' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: 'rating' }, rt.ArrayItem{ key: 'compare', val: 'NOT EXISTS' }]) }]))
	}
	var_prepared_args.array_set('orderby', this.normalize_query_param(var_request.array_get('orderby')))
	if !rt.is_true(var_request.array_get('offset')) {
		var_prepared_args.array_set('offset', rt.mul(var_prepared_args.array_get('number'), rt.sub(rt.call_function('absint', [var_request.array_get('page')]), rt.new_int(1))))
	}
	mut var_query := create_wp_comment_query()
	mut var_query_result := var_query.query(var_prepared_args.dup())
	mut var_response_objects := rt.new_array()
	{
		mut iter_1 := var_query_result.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_review := item_1.val
			mut var_data := this.prepare_item_for_response(var_review.dup(), rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request))
			var_response_objects.array_push(this.prepare_response_for_collection(var_data.dup()))
		}
	}
	mut var_total_reviews := // unsupported expression: Expr_Cast_Int
	mut var_max_pages := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.less(var_total_reviews, rt.new_int(1))) {
		var_prepared_args.array_unset(rt.new_string('number'))
		var_prepared_args.array_unset(rt.new_string('offset'))
		var_query = create_wp_comment_query()
		var_prepared_args.array_set('count', true)
		var_total_reviews = var_query.query(var_prepared_args.dup())
		var_max_pages = if rt.is_true(var_request.array_get('per_page')) { rt.call_function('ceil', [rt.div(var_total_reviews, var_request.array_get('per_page'))]) } else { rt.new_int(1) }
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_response_objects.dup()])
	var_response = rt.call_method(create_automattic_woocommerce_storeapi_utilities_pagination(), 'add_headers', [var_response.dup(), var_request, var_total_reviews.dup(), var_max_pages.dup()])
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews) normalize_query_param(var_query_param rt.PhpVal) rt.PhpVal {
	mut var_prefix := rt.new_string(rt.new_string('comment_'))
	mut switch_val_1 := var_query_param
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('id'))) {
		mut var_normalized := rt.new_string((var_prefix).str() + 'ID')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('product'))) {
		var_normalized = rt.new_string((var_prefix).str() + 'post_ID')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('rating'))) {
		var_normalized = rt.new_string(rt.new_string('meta_value_num'))
	} else {
		var_normalized = rt.new_string(rt.concat(var_prefix, var_query_param))
	}
	return var_normalized.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews) get_collection_params() rt.PhpVal {
	mut var_params := rt.new_array()
	var_params.array_set('context', this.get_context_param())
	var_params.array_get_mut('context').array_set('default', 'view')
	var_params.array_set('page', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Current page of the collection.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 1 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'minimum', val: 1 }]))
	var_params.array_set('per_page', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Maximum number of items to be returned in result set.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 10 }, rt.ArrayItem{ key: 'minimum', val: 1 }, rt.ArrayItem{ key: 'maximum', val: 100 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('offset', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Offset the result set by a specific number of items.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('order', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order sort attribute ascending or descending.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: 'desc' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'desc' }]) }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('orderby', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Sort collection by object attribute.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'default', val: 'date' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'date' }, rt.ArrayItem{ key: none, val: 'date_gmt' }, rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: 'rating' }, rt.ArrayItem{ key: none, val: 'product' }]) }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('category_id', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to reviews from specific category IDs.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	var_params.array_set('product_id', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit result set to reviews from specific product IDs.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }]))
	return var_params.dup()
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	rt.PhpObjectBase
}

struct Class_WP_Comment_Query {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_productreviews() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstractroute() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_comment_query() &Class_WP_Comment_Query {
	mut obj := &Class_WP_Comment_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_pagination() &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'get_route_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_route_response(mut dispatch_arg_0)
		}
		'normalize_query_param' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.normalize_query_param(dispatch_arg_0)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductReviews) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Comment_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Comment_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Comment_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_productreviews_php() {
}
