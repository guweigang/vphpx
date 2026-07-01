import rt

pub fn Class_Automattic_WooCommerce_RestApi_Package.version() rt.PhpVal {
	return rt.get_constant('WC_VERSION')
}
struct Class_Automattic_WooCommerce_RestApi_Package {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_RestApi_Package.init()  {
	rt.call_function('wc_deprecated_function', [rt.new_string('Automattic\\WooCommerce\\RestApi\\Server::instance()->init()'), rt.new_string('4.5.0')])
	rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_RestApi_Automattic_WooCommerce_RestApi_Server{}; return temp.instance() }(), 'init', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_RestApi_Package.get_version() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('WC()->version'), rt.new_string('4.5.0')])
	return rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')
}

fn Class_Automattic_WooCommerce_RestApi_Package.get_path() rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('Automattic\\WooCommerce\\RestApi\\Server::get_path()'), rt.new_string('4.5.0')])
	return fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_RestApi_Automattic_WooCommerce_RestApi_Server{}; return temp.get_path() }()
}

struct Class_Automattic_WooCommerce_RestApi_Automattic_WooCommerce_RestApi_Server {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_restapi_package() &Class_Automattic_WooCommerce_RestApi_Package {
	mut obj := &Class_Automattic_WooCommerce_RestApi_Package{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_restapi_automattic_woocommerce_restapi_server() &Class_Automattic_WooCommerce_RestApi_Automattic_WooCommerce_RestApi_Server {
	mut obj := &Class_Automattic_WooCommerce_RestApi_Automattic_WooCommerce_RestApi_Server{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Package) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Automattic_WooCommerce_RestApi_Package.init()
			return rt.new_null()
		}
		'get_version' {
			return Class_Automattic_WooCommerce_RestApi_Package.get_version()
		}
		'get_path' {
			return Class_Automattic_WooCommerce_RestApi_Package.get_path()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_RestApi_Package) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Package) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_RestApi_Automattic_WooCommerce_RestApi_Server) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_RestApi_Automattic_WooCommerce_RestApi_Server) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_RestApi_Automattic_WooCommerce_RestApi_Server) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_package_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
