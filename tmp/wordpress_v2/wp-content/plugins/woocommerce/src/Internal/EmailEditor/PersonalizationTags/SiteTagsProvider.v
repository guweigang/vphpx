import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_SiteTagsProvider {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_SiteTagsProvider) register_tags(mut var_registry Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) {
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil{}
		mut iife_result_1 := iife_temp_1.is_pos_order(var_context.array_get(rt.new_string('order')))
		if var_context.array_isset(rt.new_string('order')) && rt.is_true(iife_result_1) {
			mut var_store_name := rt.call_function('get_option', [
				rt.new_string('woocommerce_pos_store_name'),
			])
			mut iife_temp_2 :=
				Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
			mut iife_result_2 := iife_temp_2.get_default_store_name()
			mut iife_temp_3 :=
				Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{}
			mut iife_result_3 := iife_temp_3.get_default_store_name()
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Site Title'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/site-title'), rt.call_function('__', [
		rt.new_string('Site'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_4_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Homepage URL'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/site-homepage-url'), rt.call_function('__', [
		rt.new_string('Site'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_5_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_personalizationtags_sitetagsprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_SiteTagsProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_SiteTagsProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_personalizationtags_abstracttagprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_orders_pointofsaleorderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_settings_pointofsaledefaultsettings(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings {
	mut obj := &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_SiteTagsProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_tags' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.register_tags(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_SiteTagsProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_SiteTagsProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_PointOfSaleOrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Settings_PointOfSaleDefaultSettings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
