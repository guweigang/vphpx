import rt

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration {
	rt.PhpObjectBase
pub mut:
	container rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) init(mut var_container Class_Automattic_WooCommerce_Container) {
	this.container = var_container
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) get_id() string {
	return 'pos'
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) get_product_feed_query_args() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'type', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'simple' },
			rt.ArrayItem{ key: none, val: 'variable' },
			rt.ArrayItem{ key: none, val: 'variation' },
		]) },
		rt.ArrayItem{ key: 'tax_query', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'taxonomy', val: 'pos_product_visibility' },
				rt.ArrayItem{ key: 'field', val: 'slug' },
				rt.ArrayItem{ key: 'terms', val: 'pos-hidden' },
				rt.ArrayItem{ key: 'operator', val: 'NOT IN' },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) register_hooks() {
	rt.call_function('add_action', [rt.new_string('rest_api_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration', [
				'IntegrationInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'rest_api_init' },
		])])
	rt.call_method(rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_AsyncGenerator.class(),
	]), 'register_hooks', []rt.PhpVal{})
	rt.call_method(rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSProductVisibilitySync.class(),
	]), 'register_hooks', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) rest_api_init() {
	rt.call_method(rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ApiController.class(),
	]), 'register_routes', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) activate() {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) deactivate() {
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) create_feed() rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed',
		[]string{},
		create_automattic_woocommerce_internal_productfeed_storage_jsonfilefeed(rt.new_string('pos-catalog-feed')))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) get_product_mapper() rt.PhpVal {
	return rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_ProductMapper.class(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) get_feed_validator() rt.PhpVal {
	return rt.call_method(this.container, 'get', [
		Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_FeedValidator.class(),
	])
}

struct Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productfeed_integrations_poscatalog_posintegration(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration{
		PhpObjectBase: rt.PhpObjectBase{}
		container:     rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_productfeed_storage_jsonfilefeed(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Container](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_id' {
			return rt.new_string(this.get_id())
		}
		'get_product_feed_query_args' {
			return this.get_product_feed_query_args()
		}
		'register_hooks' {
			this.register_hooks()
			return rt.new_null()
		}
		'rest_api_init' {
			this.rest_api_init()
			return rt.new_null()
		}
		'activate' {
			this.activate()
			return rt.new_null()
		}
		'deactivate' {
			this.deactivate()
			return rt.new_null()
		}
		'create_feed' {
			return this.create_feed()
		}
		'get_product_mapper' {
			return this.get_product_mapper()
		}
		'get_feed_validator' {
			return this.get_feed_validator()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'container' { return this.container }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Integrations_POSCatalog_POSIntegration) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'container' {
			this.container = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFeed_Storage_JsonFileFeed) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
