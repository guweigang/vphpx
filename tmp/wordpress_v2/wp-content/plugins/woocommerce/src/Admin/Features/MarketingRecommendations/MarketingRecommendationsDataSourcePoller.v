import rt

pub fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller.id() string {
	return 'marketing_recommendations'
}

pub fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller.data_sources() rt.PhpVal {
	return rt.new_array()
}

struct Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_features_marketingrecommendations_marketingrecommendationsdatasourcepoller() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller',
		'instance', rt.new_null())
}

fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller.get_instance() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller',
		'instance')))))
	{
		rt.set_static_prop('Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller',
			'instance', rt.new_object('Automattic_WooCommerce_Admin_Features_MarketingRecommendations_self',
			[]string{}, create_automattic_woocommerce_admin_features_marketingrecommendations_self(Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller.id(),
			Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller.get_data_sources(), rt.create_array([
			rt.ArrayItem{ key: 'spec_key', val: 'product' },
		]))))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller',
		'instance')
}

fn Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller.get_data_sources() rt.PhpVal {
	mut iife_temp_0 := Class_WC_Helper{}
	mut iife_result_0 := iife_temp_0.get_woocommerce_com_base_url()
	return rt.create_array([
		rt.ArrayItem{ key: none, val: iife_result_0.str() +
			'wp-json/wccom/marketing-tab/1.3/recommendations.json' },
	])
}

struct Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_self {
	rt.PhpObjectBase
}

struct Class_WC_Helper {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_marketingrecommendations_marketingrecommendationsdatasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_remotespecs_datasourcepoller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller {
	mut obj := &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_marketingrecommendations_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_self {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_helper(_args ...rt.PhpVal) &Class_WC_Helper {
	mut obj := &Class_WC_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller.get_instance()
		}
		'get_data_sources' {
			return Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller.get_data_sources()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_MarketingRecommendationsDataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_RemoteSpecs_DataSourcePoller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_MarketingRecommendations_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
