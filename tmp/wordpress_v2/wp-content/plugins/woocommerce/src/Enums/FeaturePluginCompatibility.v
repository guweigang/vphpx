import rt

pub fn Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible() string {
	return 'compatible'
}

pub fn Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible() string {
	return 'incompatible'
}

pub fn Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.uncertain() string {
	return 'uncertain'
}

pub fn Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.valid_registration_values() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Enums_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Enums_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.incompatible()
		},
	])
}

struct Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_enums_featureplugincompatibility(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility {
	mut obj := &Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
