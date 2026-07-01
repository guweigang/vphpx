import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories.identifier() string {
	return 'product-categories'
}

pub fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories.schema_type() string {
	return 'product-category'
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories) get_path() rt.PhpVal {
	return Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories.get_path_regex()
}

fn Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories.get_path_regex() string {
	return '/products/categories'
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories) get_args() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{
				key: 'methods'
				val: Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Server.readable()
			},
			rt.ArrayItem{ key: 'callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories', [
					'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute',
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
			rt.ArrayItem{ key: none, val: rt.get_property(rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories', [
				'Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute',
			], &this), 'schema') },
			rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories) get_route_response(mut var_request Class_Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request) rt.PhpVal {
	return this.get_terms_response(rt.new_string('product_cat'), rt.new_object('Automattic_WooCommerce_StoreApi_Routes_V1_WP_REST_Request',
		[]string{}, var_request))
}

struct Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_routes_v1_productcategories() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_routes_v1_abstracttermsroute() &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_path' {
			return this.get_path()
		}
		'get_path_regex' {
			return rt.new_string(Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories.get_path_regex())
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_ProductCategories) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Routes_V1_AbstractTermsRoute) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_routes_v1_productcategories_php() {
}
