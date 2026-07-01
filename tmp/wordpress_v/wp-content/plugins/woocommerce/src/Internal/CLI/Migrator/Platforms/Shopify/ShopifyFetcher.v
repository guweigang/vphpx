import rt

pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher.shopify_product_query() string {
	return 'query GetShopifyProducts(\n\t$first: Int!,\n\t$after: String,\n\t$query: String,\n\t$variantsFirst: Int = 100\n) {\n\tproducts(first: $first, after: $after, query: $query) {\n\t\tedges {\n\t\t\tcursor\n\t\t\tnode {\n\t\t\t\tid\n\t\t\t\ttitle\n\t\t\t\thandle\n\t\t\t\tdescriptionHtml\n\t\t\t\tstatus\n\t\t\t\tcreatedAt\n\t\t\t\tvendor\n\t\t\t\ttags\n\t\t\t\tonlineStoreUrl\n\t\t\t\toptions(first: 10) {\n\t\t\t\t\tid\n\t\t\t\t\tname\n\t\t\t\t\tposition\n\t\t\t\t\tvalues\n\t\t\t\t}\n\t\t\t\tfeaturedMedia {\n\t\t\t\t\t... on MediaImage {\n\t\t\t\t\t\tid\n\t\t\t\t\t\timage {\n\t\t\t\t\t\t\turl\n\t\t\t\t\t\t\taltText\n\t\t\t\t\t\t}\n\t\t\t\t\t}\n\t\t\t\t}\n\t\t\t\tmedia(first: 50) {\n\t\t\t\t\tedges {\n\t\t\t\t\t\tnode {\n\t\t\t\t\t\t\t... on MediaImage {\n\t\t\t\t\t\t\t\tid\n\t\t\t\t\t\t\t\timage {\n\t\t\t\t\t\t\t\t\turl\n\t\t\t\t\t\t\t\t\taltText\n\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t}\n\t\t\t\t\t}\n\t\t\t\t}\n\t\t\t\tvariants(first: $variantsFirst) {\n\t\t\t\t\tedges {\n\t\t\t\t\t\tnode {\n\t\t\t\t\t\t\tid\n\t\t\t\t\t\t\tproduct { id }\n\t\t\t\t\t\t\tprice\n\t\t\t\t\t\t\tcompareAtPrice\n\t\t\t\t\t\t\tsku\n\t\t\t\t\t\t\ttaxable\n\t\t\t\t\t\t\tinventoryPolicy\n\t\t\t\t\t\t\tinventoryQuantity\n\t\t\t\t\t\t\tposition\n\t\t\t\t\t\t\tinventoryItem {\n\t\t\t\t\t\t\t\ttracked\n\t\t\t\t\t\t\t\tunitCost {\n\t\t\t\t\t\t\t\t\tamount\n\t\t\t\t\t\t\t\t\tcurrencyCode\n\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t\tmeasurement {\n\t\t\t\t\t\t\t\t\tweight {\n\t\t\t\t\t\t\t\t\t\tvalue\n\t\t\t\t\t\t\t\t\t\tunit\n\t\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\tmedia(first: 1) {\n\t\t\t\t\t\t\t\tedges {\n\t\t\t\t\t\t\t\t\tnode {\n\t\t\t\t\t\t\t\t\t\t... on MediaImage {\n\t\t\t\t\t\t\t\t\t\t\tid\n\t\t\t\t\t\t\t\t\t\t\timage {\n\t\t\t\t\t\t\t\t\t\t\t\turl\n\t\t\t\t\t\t\t\t\t\t\t\taltText\n\t\t\t\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t\tselectedOptions {\n\t\t\t\t\t\t\t\tname\n\t\t\t\t\t\t\t\tvalue\n\t\t\t\t\t\t\t}\n\t\t\t\t\t\t}\n\t\t\t\t\t}\n\t\t\t\t}\n\t\t\t\tcollections(first: 20) {\n\t\t\t\t\tedges {\n\t\t\t\t\t\tnode {\n\t\t\t\t\t\t\tid\n\t\t\t\t\t\t\thandle\n\t\t\t\t\t\t\ttitle\n\t\t\t\t\t\t}\n\t\t\t\t\t}\n\t\t\t\t}\n\t\t\t\tmetafields(first: 20, namespace: "global") {\n\t\t\t\t\tedges {\n\t\t\t\t\t\tnode {\n\t\t\t\t\t\t\tnamespace\n\t\t\t\t\t\t\tkey\n\t\t\t\t\t\t\tvalue\n\t\t\t\t\t\t}\n\t\t\t\t\t}\n\t\t\t\t}\n\t\t\t}\n\t\t}\n\t\tpageInfo {\n\t\t\thasNextPage\n\t\t}\n\t}\n}'
}
struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher {
	rt.PhpObjectBase
pub mut:
		shopify_client rt.PhpVal = rt.new_null()
		credentials rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher) construct(mut var_credentials Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array)  {
	this.credentials = var_credentials.dup()
	this.shopify_client = create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_shopifyclient(var_credentials.dup())
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher) fetch_batch(mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array) rt.PhpVal {
	mut var_variables := this.build_graphql_variables(mut var_args)
	mut var_response_data := rt.call_method(this.shopify_client, 'graphql_request', [Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher.shopify_product_query(), var_variables.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_response_data.dup()])) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_CLI{}; return temp.warning(arg_0) }(rt.new_string('Failed to fetch products via GraphQL: ' + (rt.call_method(var_response_data, 'get_error_message', []rt.PhpVal{})).str()))
		return rt.create_array([rt.ArrayItem{ key: 'items', val: rt.new_array() }, rt.ArrayItem{ key: 'cursor', val: rt.new_null() }, rt.ArrayItem{ key: 'has_next_page', val: false }])
	}
	if !(!(rt.get_property(rt.get_property(var_response_data, 'products'), 'edges')).is_null()) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_CLI{}; return temp.warning(arg_0) }(rt.new_string('Invalid GraphQL response structure - missing products.edges field.'))
		return rt.create_array([rt.ArrayItem{ key: 'items', val: rt.new_array() }, rt.ArrayItem{ key: 'cursor', val: rt.new_null() }, rt.ArrayItem{ key: 'has_next_page', val: false }])
	}
	mut var_items := rt.get_property(rt.get_property(var_response_data, 'products'), 'edges')
	mut var_page_info := if !(rt.get_property(rt.get_property(var_response_data, 'products'), 'pageInfo')).is_null() { rt.get_property(rt.get_property(var_response_data, 'products'), 'pageInfo') } else { rt.new_null() }
	mut var_last_cursor := rt.new_null()
	if !(!rt.is_true(var_items)) {
		mut var_last_edge := rt.call_function('end', [var_items.dup()])
		var_last_cursor = if !(rt.get_property(var_last_edge, 'cursor')).is_null() { rt.get_property(var_last_edge, 'cursor') } else { rt.new_null() }
	}
	return rt.create_array([rt.ArrayItem{ key: 'items', val: var_items }, rt.ArrayItem{ key: 'cursor', val: var_last_cursor }, rt.ArrayItem{ key: 'has_next_page', val: if rt.is_true(var_page_info) { rt.get_property(var_page_info, 'hasNextPage') } else { rt.new_bool(false) } }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher) build_graphql_variables(mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array) rt.PhpVal {
	mut var_variables := rt.create_array([rt.ArrayItem{ key: 'first', val: if !(var_args.array_get('limit')).is_null() { var_args.array_get('limit') } else { rt.new_int(50) } }, rt.ArrayItem{ key: 'after', val: if !(var_args.array_get('after_cursor')).is_null() { var_args.array_get('after_cursor') } else { rt.new_null() } }, rt.ArrayItem{ key: 'query', val: this.build_graphql_query_string(mut var_args) }, rt.ArrayItem{ key: 'variantsFirst', val: if !(var_args.array_get('variants_per_product')).is_null() { var_args.array_get('variants_per_product') } else { rt.new_int(100) } }])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))
	}
	return rt.call_function('array_filter', [var_variables.dup(), rt.new_closure(closure_1_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher) build_graphql_query_string(mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array) string {
	mut var_query_parts := rt.new_array()
	if var_args.array_isset(rt.new_string('status')) {
		var_query_parts.array_push('status:' + var_args.array_get('status').to_string().to_upper())
	}
	if var_args.array_isset(rt.new_string('product_type')) {
		var_query_parts.array_push('product_type:"' + (var_args.array_get('product_type')).str() + '"')
	}
	if var_args.array_isset(rt.new_string('vendor')) {
		var_query_parts.array_push('vendor:"' + (var_args.array_get('vendor')).str() + '"')
	}
	if var_args.array_isset(rt.new_string('handle')) {
		var_query_parts.array_push('handle:' + (var_args.array_get('handle')).str())
	}
	if var_args.array_isset(rt.new_string('created_after')) {
		var_query_parts.array_push('created_at:>=' + (var_args.array_get('created_after')).str())
	}
	if var_args.array_isset(rt.new_string('created_before')) {
		var_query_parts.array_push('created_at:<=' + (var_args.array_get('created_before')).str())
	}
	if var_args.array_isset(rt.new_string('ids')) {
		mut var_ids := if rt.is_true(rt.new_bool(var_args.array_get('ids').is_array())) { var_args.array_get('ids') } else { rt.call_function('explode', [rt.new_string(','), var_args.array_get('ids')]) }
		var_ids = rt.call_function('array_filter', [rt.call_function('array_map', [rt.new_string('trim'), var_ids.dup()])])
		if !(!rt.is_true(var_ids)) {
			closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_id := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return 'gid://shopify/Product/' + (var_id).str()
	}
	mut var_id := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return 'gid://shopify/Product/' + (var_id).str()
	}
			mut var_formatted_ids := rt.call_function('array_map', [rt.new_closure(closure_2_fn), var_ids.dup()])
			var_query_parts.array_push('id:(' + (rt.call_function('implode', [rt.new_string(' OR '), var_formatted_ids.dup()])).str() + ')')
		}
	}
	return (rt.call_function('implode', [rt.new_string(' AND '), var_query_parts.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher) fetch_total_count(mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array) i64 {
	if var_args.array_isset(rt.new_string('ids')) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_CLI{}; return temp.debug(arg_0) }(rt.new_string('Calculating total count based on provided product IDs.'))
		mut var_ids := if rt.is_true(rt.new_bool(var_args.array_get('ids').is_array())) { var_args.array_get('ids') } else { rt.call_function('explode', [rt.new_string(','), var_args.array_get('ids')]) }
		return rt.call_function('array_filter', [var_ids.dup()]).array_count()
	}
	mut var_rest_api_path := rt.new_string(rt.new_string('/products/count.json'))
	mut var_query_params := this.build_count_query_params(mut var_args)
	mut var_response := rt.call_method(this.shopify_client, 'rest_request', [var_rest_api_path.dup(), var_query_params.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_CLI{}; return temp.warning(arg_0) }(rt.new_string('Could not fetch total product count from Shopify REST API: ' + (rt.call_method(var_response, 'get_error_message', []rt.PhpVal{})).str()))
		return 0
	}
	if !(!(rt.get_property(var_response, 'count')).is_null()) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_CLI{}; return temp.warning(arg_0) }(rt.new_string('Unexpected response format from Shopify count API - missing count field.'))
		return 0
	}
	return (// unsupported expression: Expr_Cast_Int).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher) build_count_query_params(mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array) rt.PhpVal {
	mut var_query_params := rt.new_array()
	if var_args.array_isset(rt.new_string('status')) {
		var_query_params.array_set('status', var_args.array_get('status').to_string().to_lower())
		// unsupported statement: Stmt_Nop
	}
	if var_args.array_isset(rt.new_string('created_at_min')) {
		var_query_params.array_set('created_at_min', var_args.array_get('created_at_min'))
	}
	if var_args.array_isset(rt.new_string('created_at_max')) {
		var_query_params.array_set('created_at_max', var_args.array_get('created_at_max'))
	}
	if var_args.array_isset(rt.new_string('updated_at_min')) {
		var_query_params.array_set('updated_at_min', var_args.array_get('updated_at_min'))
	}
	if var_args.array_isset(rt.new_string('updated_at_max')) {
		var_query_params.array_set('updated_at_max', var_args.array_get('updated_at_max'))
	}
	if var_args.array_isset(rt.new_string('vendor')) {
		var_query_params.array_set('vendor', var_args.array_get('vendor'))
	}
	if var_args.array_isset(rt.new_string('product_type')) {
		var_query_params.array_set('product_type', var_args.array_get('product_type'))
	}
	return var_query_params.dup()
}

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_CLI {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_shopifyfetcher(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher{
		PhpObjectBase: rt.PhpObjectBase{}
		shopify_client: rt.new_null()
		credentials: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_shopifyclient() &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_cli_migrator_platforms_shopify_wp_cli() &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_CLI {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_CLI{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'fetch_batch' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.fetch_batch(mut dispatch_arg_0)
		}
		'build_graphql_variables' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.build_graphql_variables(mut dispatch_arg_0)
		}
		'build_graphql_query_string' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(this.build_graphql_query_string(mut dispatch_arg_0))
		}
		'fetch_total_count' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_int(this.fetch_total_count(mut dispatch_arg_0))
		}
		'build_count_query_params' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.build_count_query_params(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'shopify_client' { return this.shopify_client }
		'credentials' { return this.credentials }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyFetcher) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'shopify_client' { this.shopify_client = val; return true }
		'credentials' { this.credentials = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_ShopifyClient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_CLI) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_CLI) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Platforms_Shopify_WP_CLI) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_cli_migrator_platforms_shopify_shopifyfetcher_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
