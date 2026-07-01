import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData.identifier() string {
	return 'product-collection-data'
}
pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData.schema_type() string {
	return 'product-collection-data'
}
struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData.get_path_regex() string {
	return '/products/collection-data'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData) get_args() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute'], &this) }, rt.ArrayItem{ key: none, val: 'get_response' }]) }, rt.ArrayItem{ key: 'permission_callback', val: '__return_true' }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }, rt.ArrayItem{ key: 'allow_batch', val: rt.create_array([rt.ArrayItem{ key: 'v1', val: true }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute'], &this), 'schema') }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData) get_route_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'min_price', val: rt.new_null() }, rt.ArrayItem{ key: 'max_price', val: rt.new_null() }, rt.ArrayItem{ key: 'attribute_counts', val: rt.new_null() }, rt.ArrayItem{ key: 'stock_status_counts', val: rt.new_null() }, rt.ArrayItem{ key: 'rating_counts', val: rt.new_null() }, rt.ArrayItem{ key: 'taxonomy_counts', val: rt.new_null() }])
	mut var_filters := create_automattic_woocommerce_storeapi_utilities_productqueryfilters()
	if !(!rt.is_true(var_request.array_get('calculate_price_range'))) {
		mut var_filter_request := // unsupported expression: Expr_Clone
		rt.call_method(var_filter_request, 'set_param', [rt.new_string('min_price'), rt.new_null()])
		rt.call_method(var_filter_request, 'set_param', [rt.new_string('max_price'), rt.new_null()])
		mut var_price_results := var_filters.get_filtered_price(var_filter_request.dup())
		var_data.array_set('min_price', rt.get_property(var_price_results, 'min_price'))
		var_data.array_set('max_price', rt.get_property(var_price_results, 'max_price'))
	}
	if !(!rt.is_true(var_request.array_get('calculate_stock_status_counts'))) {
		var_filter_request = // unsupported expression: Expr_Clone
		mut var_counts := var_filters.get_stock_status_counts(var_filter_request.dup())
		var_data.array_set('stock_status_counts', rt.new_array())
		{
			mut iter_1 := var_counts.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				var_data.array_get_mut('stock_status_counts').array_push(// unsupported expression: Expr_Cast_Object)
			}
		}
	}
	if !(!rt.is_true(var_request.array_get('calculate_attribute_counts'))) {
		mut var_taxonomy__or_queries := rt.new_array()
		mut var_taxonomy__and_queries := rt.new_array()
		{
			mut iter_1 := var_request.array_get('calculate_attribute_counts').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attributes_to_count := item_1.val
				if !(!rt.is_true(var_attributes_to_count.array_get('taxonomy'))) {
					if rt.is_true(rt.new_bool(!rt.is_true(var_attributes_to_count.array_get('query_type')) || rt.is_true(rt.identical(rt.new_string('or'), var_attributes_to_count.array_get('query_type'))))) {
						var_taxonomy__or_queries.array_push(var_attributes_to_count.array_get('taxonomy'))
					} else {
						var_taxonomy__and_queries.array_push(var_attributes_to_count.array_get('taxonomy'))
					}
				}
			}
		}
		var_data.array_set('attribute_counts', rt.new_array())
		if rt.is_true(var_taxonomy__or_queries) {
			{
				mut iter_1 := var_taxonomy__or_queries.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_taxonomy := item_1.val
					var_filter_request = // unsupported expression: Expr_Clone
					mut var_filter_attributes := rt.call_method(var_filter_request, 'get_param', [rt.new_string('attributes')])
					if !(!rt.is_true(var_filter_attributes)) {
						closure_1_fn := fn [var_taxonomy] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_query := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return // unsupported expression: Expr_BinaryOp_NotIdentical
	}
						var_filter_attributes = rt.call_function('array_filter', [var_filter_attributes.dup(), rt.new_closure(closure_1_fn)])
					}
					rt.call_method(var_filter_request, 'set_param', [rt.new_string('attributes'), var_filter_attributes.dup()])
					var_counts = var_filters.get_attribute_counts(var_filter_request.dup(), rt.create_array([rt.ArrayItem{ key: none, val: var_taxonomy }]))
					{
						mut iter_2 := var_counts.iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_value := item_2.val
							mut var_key := item_2.key
							var_data.array_get_mut('attribute_counts').array_push(// unsupported expression: Expr_Cast_Object)
						}
					}
				}
			}
		}
		if rt.is_true(var_taxonomy__and_queries) {
			var_counts = var_filters.get_attribute_counts(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request), var_taxonomy__and_queries.dup())
			{
				mut iter_1 := var_counts.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_value := item_1.val
					mut var_key := item_1.key
					var_data.array_get_mut('attribute_counts').array_push(// unsupported expression: Expr_Cast_Object)
				}
			}
		}
	}
	if !(!rt.is_true(var_request.array_get('calculate_rating_counts'))) {
		var_filter_request = // unsupported expression: Expr_Clone
		var_counts = var_filters.get_rating_counts(var_filter_request.dup())
		var_data.array_set('rating_counts', rt.new_array())
		{
			mut iter_1 := var_counts.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				var_data.array_get_mut('rating_counts').array_push(// unsupported expression: Expr_Cast_Object)
			}
		}
	}
	if !(!rt.is_true(var_request.array_get('calculate_taxonomy_counts'))) {
		mut var_taxonomies := var_request.array_get('calculate_taxonomy_counts')
		var_data.array_set('taxonomy_counts', rt.new_array())
		if rt.is_true(var_taxonomies) {
			var_counts = var_filters.get_taxonomy_counts(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request', []string{}, var_request), var_taxonomies.dup())
			{
				mut iter_1 := var_counts.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_value := item_1.val
					mut var_key := item_1.key
					var_data.array_get_mut('taxonomy_counts').array_push(// unsupported expression: Expr_Cast_Object)
				}
			}
		}
	}
	return rt.call_function('rest_ensure_response', [rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute'], &this), 'schema'), 'get_item_response', [var_data.dup()])])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData) get_collection_params() rt.PhpVal {
	mut var_params := rt.call_method(create_automattic_woocommerce_storeapi_routes_v1_products(rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute'], &this), 'schema_controller'), rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData', ['Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute'], &this), 'schema')), 'get_collection_params', []rt.PhpVal{})
	var_params.array_set('calculate_price_range', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If true, calculates the minimum and maximum product prices for the collection.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }]))
	var_params.array_set('calculate_stock_status_counts', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If true, calculates stock counts for products in the collection.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }]))
	var_params.array_set('calculate_attribute_counts', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If requested, calculates attribute term counts for products in the collection.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Taxonomy name.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'query_type', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Filter condition\t being performed which may affect counts. Valid values include "and" and "or".'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'and' }, rt.ArrayItem{ key: none, val: 'or' }]) }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }]) }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }]))
	var_params.array_set('calculate_rating_counts', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If true, calculates rating counts for products in the collection.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }]))
	var_params.array_set('calculate_taxonomy_counts', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If requested, calculates taxonomy term counts for products in the collection.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Taxonomy name.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'default', val: rt.new_array() }]))
	return var_params.dup()
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_productcollectiondata() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData{
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

fn create_automattic_woocommerce_storeapi_utilities_productqueryfilters() &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_products() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'get_route_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.get_route_response(mut dispatch_arg_0)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCollectionData) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQueryFilters) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_productcollectiondata_php() {
}
