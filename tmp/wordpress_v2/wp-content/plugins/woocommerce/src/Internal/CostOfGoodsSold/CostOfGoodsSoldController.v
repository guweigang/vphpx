import rt

struct Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController {
	rt.PhpObjectBase
pub mut:
	features_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController) register() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_debug_tools'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController', [
				'RegisterHooksInterface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'add_debug_tools_entry' },
		]),
		rt.new_int(999), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController) init(mut var_features_controller Class_Automattic_WooCommerce_Internal_Features_FeaturesController) {
	this.features_controller = var_features_controller
}

fn (mut this Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController) feature_is_enabled() bool {
	return (rt.call_method(this.features_controller, 'feature_is_enabled', [
		rt.new_string('cost_of_goods_sold'),
	])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController) add_feature_definition(var_features_controller rt.PhpVal) {
	mut var_definition := rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Allows entering cost of goods sold information for products.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'is_experimental', val: false },
		rt.ArrayItem{ key: 'enabled_by_default', val: false },
		rt.ArrayItem{
			key: 'default_plugin_compatibility'
			val: Class_Automattic_WooCommerce_Enums_FeaturePluginCompatibility.compatible()
		},
	])
	rt.call_method(var_features_controller, 'add_feature_definition', [
		rt.new_string('cost_of_goods_sold'),
		rt.call_function('__', [rt.new_string('Cost of Goods Sold'),
			rt.new_string('woocommerce')]),
		var_definition.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController) add_debug_tools_entry(mut var_tools_array Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_array) rt.PhpVal {
	mut var_tools_array_mutated := var_tools_array
	mut var_column_exists := rt.new_bool(this.product_meta_lookup_table_cogs_value_columns_exist())
	if !(this.feature_is_enabled()) && rt.is_true(rt.new_bool(!(rt.is_true(var_column_exists)))) {
		return rt.new_object('Automattic_WooCommerce_Internal_CostOfGoodsSold_array', []string{},
			var_tools_array_mutated)
	}
	var_tools_array_mutated.array_set('generate_cogs_value_meta_column', rt.create_array([
		rt.ArrayItem{
			key: 'name'
			val: if rt.is_true(var_column_exists) { rt.call_function('__', [
					rt.new_string('Remove COGS columns from the product meta lookup table'),
					rt.new_string('woocommerce'),
				]) } else { rt.call_function('__', [
					rt.new_string('Create COGS columns in the product meta lookup table'),
					rt.new_string('woocommerce'),
				]) }
		},
		rt.ArrayItem{
			key: 'button'
			val: if rt.is_true(var_column_exists) { rt.call_function('__', [
					rt.new_string('Remove columns'),
					rt.new_string('woocommerce'),
				]) } else { rt.call_function('__', [
					rt.new_string('Create columns'),
					rt.new_string('woocommerce'),
				]) }
		},
		rt.ArrayItem{
			key: 'desc'
			val: if rt.is_true(var_column_exists) { rt.call_function('__', [
					rt.new_string('This tool will remove the Cost of Goods Sold (COGS) related columns from the product meta lookup table. COGS will continue working (if the feature is enabled) but some functionality will not be available.'),
					rt.new_string('woocommerce'),
				]) } else { rt.call_function('__', [
					rt.new_string('This tool will generate the necessary Cost of Goods Sold (COGS) related columns in the product meta lookup table, and populate them from existing product data.'),
					rt.new_string('woocommerce'),
				]) }
		},
		rt.ArrayItem{
			key: 'callback'
			val: if rt.is_true(var_column_exists) { rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController', [
						'RegisterHooksInterface',
					], &this) },
					rt.ArrayItem{ key: none, val: 'remove_lookup_cogs_columns' },
				]) } else { rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController', [
						'RegisterHooksInterface',
					], &this) },
					rt.ArrayItem{ key: none, val: 'generate_lookup_cogs_columns' },
				]) }
		},
	]))
	return rt.new_object('Automattic_WooCommerce_Internal_CostOfGoodsSold_array', []string{},
		var_tools_array_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController) generate_lookup_cogs_columns() {
	mut var_wpdb := rt.new_null()
	if this.feature_is_enabled() && !(this.product_meta_lookup_table_cogs_value_columns_exist()) {
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('wc_product_meta_lookup ADD COLUMN cogs_total_value DECIMAL(19,4)')),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('wc_product_meta_lookup AS lookup\n    \t\t\tJOIN ')), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string("postmeta AS pm ON lookup.product_id = pm.post_id\n    \t\t\tSET lookup.cogs_total_value = CAST(pm.meta_value AS DECIMAL(19, 4))\n    \t\t\tWHERE pm.meta_key = '_cogs_total_value';")),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController) remove_lookup_cogs_columns() {
	mut var_wpdb := rt.new_null()
	if this.product_meta_lookup_table_cogs_value_columns_exist() {
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('ALTER TABLE '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('wc_product_meta_lookup DROP COLUMN cogs_total_value')),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController) product_meta_lookup_table_cogs_value_columns_exist() bool {
	mut var_wpdb := rt.new_null()
	return (rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SHOW COLUMNS FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('wc_product_meta_lookup LIKE %s')),
			rt.new_string('cogs_total_value'),
		]),
	])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController) get_general_cost_edit_field_tooltip(for_variable_products bool) rt.PhpVal {
	return if var_for_variable_products { rt.call_function('__', [
			rt.new_string('Add the amount it costs you to buy or make this product. This will be applied as the default value for variations.'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [
			rt.new_string('Add the amount it costs you to buy or make this product.'),
			rt.new_string('woocommerce'),
		]) }
}

fn create_automattic_woocommerce_internal_costofgoodssold_costofgoodssoldcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController {
	mut obj := &Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController{
		PhpObjectBase:       rt.PhpObjectBase{}
		features_controller: rt.new_null()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Features_FeaturesController](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'feature_is_enabled' {
			return rt.new_bool(this.feature_is_enabled())
		}
		'add_feature_definition' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_feature_definition(dispatch_arg_0)
			return rt.new_null()
		}
		'add_debug_tools_entry' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.add_debug_tools_entry(mut dispatch_arg_0)
		}
		'generate_lookup_cogs_columns' {
			this.generate_lookup_cogs_columns()
			return rt.new_null()
		}
		'remove_lookup_cogs_columns' {
			this.remove_lookup_cogs_columns()
			return rt.new_null()
		}
		'product_meta_lookup_table_cogs_value_columns_exist' {
			return rt.new_bool(this.product_meta_lookup_table_cogs_value_columns_exist())
		}
		'get_general_cost_edit_field_tooltip' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_general_cost_edit_field_tooltip(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'features_controller' { return this.features_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'features_controller' {
			this.features_controller = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}
