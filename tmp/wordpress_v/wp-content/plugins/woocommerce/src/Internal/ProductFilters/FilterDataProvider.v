import rt

struct Class_Automattic_WooCommerce_Internal_ProductFilters_FilterDataProvider {
	rt.PhpObjectBase
pub mut:
		providers rt.PhpVal = rt.new_array()
		taxonomy_hierarchy_data rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterDataProvider) init(mut var_taxonomy_hierarchy_data Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData)  {
	this.taxonomy_hierarchy_data = var_taxonomy_hierarchy_data.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterDataProvider) with(mut var_query_clauses_generator Class_Automattic_WooCommerce_Internal_ProductFilters_Interfaces_QueryClausesGenerator) rt.PhpVal {
	mut var_class_name := rt.call_function('get_class', [var_query_clauses_generator])
	if !(this.providers.array_isset(var_class_name)) {
		this.providers.array_set(var_class_name, create_automattic_woocommerce_internal_productfilters_filterdata(var_query_clauses_generator.dup(), this.taxonomy_hierarchy_data))
	}
	return this.providers.array_get(var_class_name)
}

struct Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productfilters_filterdataprovider() &Class_Automattic_WooCommerce_Internal_ProductFilters_FilterDataProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFilters_FilterDataProvider{
		PhpObjectBase: rt.PhpObjectBase{}
		providers: rt.new_array()
		taxonomy_hierarchy_data: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_productfilters_filterdata() &Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterDataProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_TaxonomyHierarchyData](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'with' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductFilters_Interfaces_QueryClausesGenerator](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.with(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFilters_FilterDataProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'providers' { return this.providers }
		'taxonomy_hierarchy_data' { return this.taxonomy_hierarchy_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterDataProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'providers' { this.providers = val; return true }
		'taxonomy_hierarchy_data' { this.taxonomy_hierarchy_data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductFilters_FilterData) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_productfilters_filterdataprovider_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
