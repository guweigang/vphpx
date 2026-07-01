import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products.identifier() string {
	return 'products'
}

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products.schema_type() string {
	return 'product'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products.get_path_regex() string {
	return '/products'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products) get_args() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.readable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Products', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_response' },
			]) },
			rt.ArrayItem{ key: 'permission_callback', val: '__return_true' },
			rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			rt.ArrayItem{ key: 'allow_batch', val: rt.create_array([
				rt.ArrayItem{ key: 'v1', val: true },
			]) },
		]) },
		rt.ArrayItem{ key: 'schema', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_Products', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute',
			], &this), 'schema') },
			rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products) get_route_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	mut var_response := create_automattic_woocommerce_storeapi_routes_v1_wp_rest_response()
	mut var_product_query := create_automattic_woocommerce_storeapi_utilities_productquery()
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.readable(),
		var_request.get_method()))
	{
		mut var_query_results := var_product_query.get_objects(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request',
			[]string{}, var_request))
		mut var_response_objects := rt.new_array()
		{
			mut iter_1 := var_query_results.array_get('objects').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_object := item_1.val
				mut var_data := this.prepare_item_for_response(var_object.dup(), rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request',
					[]string{}, var_request))
				var_response_objects.array_push(this.prepare_response_for_collection(var_data.dup()))
			}
		}
		rt.call_method(var_response, 'set_data', [var_response_objects.dup()])
	} else {
		var_query_results = var_product_query.get_results(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request',
			[]string{}, var_request))
	}
	var_response = rt.call_method(create_automattic_woocommerce_storeapi_utilities_pagination(),
		'add_headers', [var_response.dup(), var_request, var_query_results.array_get('total'),
		var_query_results.array_get('pages')])
	mut var_last_modified := var_product_query.get_last_modified()
	if rt.is_true(var_last_modified) {
		rt.call_method(var_response, 'header', [rt.new_string('Last-Modified'),
			var_last_modified.dup()])
	}
	return var_response.dup()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products) get_collection_params() rt.PhpVal {
	mut var_params := rt.new_array()
	var_params.array_set('context', this.get_context_param())
	var_params.array_get_mut('context').array_set('default', 'view')
	var_params.array_set('page', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Current page of the collection.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: 1 },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		rt.ArrayItem{ key: 'minimum', val: 1 },
	]))
	var_params.array_set('per_page', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Maximum number of items to be returned in result set.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'default', val: 10 },
		rt.ArrayItem{ key: 'minimum', val: 1 },
		rt.ArrayItem{ key: 'maximum', val: 100 },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('search', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit results to those matching a string.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('slug', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products with specific slug(s). Use commas to separate.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('after', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to resources created after a given ISO8601 compliant date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('before', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit response to resources created before a given ISO8601 compliant date.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'format', val: 'date-time' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('date_column', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('When limiting response using after/before, which date column to compare against.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'date' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'date' },
			rt.ArrayItem{ key: none, val: 'date_gmt' },
			rt.ArrayItem{ key: none, val: 'modified' },
			rt.ArrayItem{ key: none, val: 'modified_gmt' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('exclude', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Ensure result set excludes specific IDs.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
	]))
	var_params.array_set('include', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to specific ids.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
	]))
	var_params.array_set('offset', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Offset the result set by a specific number of items.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('order', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Order sort attribute ascending or descending.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'desc' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'asc' },
			rt.ArrayItem{ key: none, val: 'desc' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('orderby', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Sort collection by object attribute.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'default', val: 'date' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'date' },
			rt.ArrayItem{ key: none, val: 'modified' },
			rt.ArrayItem{ key: none, val: 'id' },
			rt.ArrayItem{ key: none, val: 'include' },
			rt.ArrayItem{ key: none, val: 'title' },
			rt.ArrayItem{ key: none, val: 'slug' },
			rt.ArrayItem{ key: none, val: 'price' },
			rt.ArrayItem{ key: none, val: 'popularity' },
			rt.ArrayItem{ key: none, val: 'rating' },
			rt.ArrayItem{ key: none, val: 'menu_order' },
			rt.ArrayItem{ key: none, val: 'comment_count' },
		]) },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('parent', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to those of particular parent IDs.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
	]))
	var_params.array_set('parent_exclude', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to all items except those of a particular parent ID.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
		]) },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
	]))
	var_params.array_set('type', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products assigned a specific type.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [
			rt.func_array_keys(rt.call_function('wc_get_product_types', []rt.PhpVal{})),
			rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_ProductType.variation()
				},
			]),
		]) },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('sku', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products with specific SKU(s). Use commas to separate.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('featured', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to featured products.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'boolean' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_string_to_bool' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('category', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products assigned a set of category IDs or slugs, separated by commas.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('category_operator', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Operator to compare product category terms.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'in' },
			rt.ArrayItem{ key: none, val: 'not_in' },
			rt.ArrayItem{ key: none, val: 'and' },
		]) },
		rt.ArrayItem{ key: 'default', val: 'in' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('brand', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products assigned a set of brand IDs or slugs, separated by commas.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('brand_operator', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Operator to compare product brand terms.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'in' },
			rt.ArrayItem{ key: none, val: 'not_in' },
			rt.ArrayItem{ key: none, val: 'and' },
		]) },
		rt.ArrayItem{ key: 'default', val: 'in' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	{
		mut iter_1 := rt.get_superglobal('_REQUEST').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_param := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_param.dup().is_string()))))) {
				continue
			}
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.call_function('str_starts_with', [var_param.dup(), rt.new_string('_unstable_tax_')]))
				&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [var_param.dup(), rt.new_string('_operator')])))))))
			{
				var_params.array_set(var_param, rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Limit result set to products assigned a set of taxonomies IDs or slugs, separated by commas.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' },
					rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
				]))
			}
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.call_function('str_starts_with', [var_param.dup(), rt.new_string('_unstable_tax_')]))
				&& rt.is_true(rt.call_function('str_ends_with', [var_param.dup(), rt.new_string('_operator')]))))
			{
				var_params.array_set(var_param, rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Operator to compare product taxonomies terms.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'in' },
						rt.ArrayItem{ key: none, val: 'not_in' },
						rt.ArrayItem{ key: none, val: 'and' },
					]) },
					rt.ArrayItem{ key: 'default', val: 'in' },
					rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
					rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
				]))
			}
		}
	}
	var_params.array_set('tag', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products assigned a set of tag IDs or slugs, separated by commas.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_list' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('tag_operator', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Operator to compare product tags.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'in' },
			rt.ArrayItem{ key: none, val: 'not_in' },
			rt.ArrayItem{ key: none, val: 'and' },
		]) },
		rt.ArrayItem{ key: 'default', val: 'in' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('on_sale', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products on sale.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'boolean' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_string_to_bool' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('min_price', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products based on a minimum price, provided using the smallest unit of the currency.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('max_price', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products based on a maximum price, provided using the smallest unit of the currency.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('stock_status', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products with specified stock status.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('wc_get_product_stock_status_options',
				[]rt.PhpVal{})) },
			rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
			rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
	]))
	var_params.array_set('attributes', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products with selected global attributes.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: 'attribute', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Attribute taxonomy name.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'sanitize_callback', val: 'wc_sanitize_taxonomy_name' },
				]) },
				rt.ArrayItem{ key: 'term_id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('List of attribute term IDs.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'integer' },
					]) },
					rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
				]) },
				rt.ArrayItem{ key: 'slug', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('List of attribute slug(s). If a term ID is provided, this will be ignored.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'array' },
					rt.ArrayItem{ key: 'items', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
					]) },
					rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_slug_list' },
				]) },
				rt.ArrayItem{ key: 'operator', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Operator to compare product attribute terms.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'enum', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'in' },
						rt.ArrayItem{ key: none, val: 'not_in' },
						rt.ArrayItem{ key: none, val: 'and' },
					]) },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
	]))
	var_params.array_set('attribute_relation', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The logical relationship between attributes when filtering across multiple at once.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'in' },
			rt.ArrayItem{ key: none, val: 'and' },
		]) },
		rt.ArrayItem{ key: 'default', val: 'and' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('catalog_visibility', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Determines if hidden or visible catalog products are shown.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'enum', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'any' },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_CatalogVisibility.visible()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_CatalogVisibility.catalog()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_CatalogVisibility.search()
			},
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_CatalogVisibility.hidden()
			},
		]) },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	var_params.array_set('rating', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products with a certain average rating.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'integer' },
			rt.ArrayItem{ key: 'enum', val: rt.call_function('range', [
				rt.new_int(1), rt.new_int(5)]) },
		]) },
		rt.ArrayItem{ key: 'default', val: rt.new_array() },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_id_list' },
	]))
	var_params.array_set('related', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to products related to a specific product ID.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'integer' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.dup()
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractRoute {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_StoreApi_Utilities_Pagination {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_products() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products{
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

fn create_automattic_woocommerce_storeapi_routes_v1_wp_rest_response() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_utilities_productquery() &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery{
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products.get_path_regex())
		}
		'get_args' {
			return this.get_args()
		}
		'get_route_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_route_response(mut dispatch_arg_0)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_Products) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Utilities_ProductQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_products_php() {
	// unsupported statement: Stmt_Declare
}
