import rt

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) export() rt.PhpVal {
	mut var_shipping_settings :=
		this.Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings.export()
	mut var_steps := rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: none, val: var_shipping_settings }]),
		this.get_steps_for_classes_and_terms(),
		this.get_steps_for_zones(),
		this.get_steps_for_locations(),
		this.get_steps_for_methods_and_options(),
	])
	var_steps.array_push(this.get_step_for_local_pickup())
	return var_steps.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) get_terms(mut var_classes Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_term := rt.new_null()
	mut var_classes_mutated := var_classes
	// unsupported statement: Stmt_Global
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_term := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return
		}
		mut var_term := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return
	}
	mut var_term_ids := rt.call_function('array_map', [rt.new_closure(closure_1_fn),
		var_classes_mutated.dup()])
	var_term_ids = rt.call_function('implode', [rt.new_string(', '),
		var_term_ids.dup()])
	return if !(!rt.is_true(var_term_ids)) { rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('terms WHERE term_id IN (%s)')),
				var_term_ids.dup(),
			]),
			rt.get_constant('ARRAY_A'),
		]) } else { rt.new_array() }
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) get_steps_for_classes_and_terms() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_class_row := rt.new_null()
	mut var_term := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_classes := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'prefix')),
			rt.new_string("term_taxonomy WHERE taxonomy = 'product_shipping_class'")),
		rt.get_constant('ARRAY_A'),
	])
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_class_row := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return create_automattic_woocommerce_blueprint_steps_runsql(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
				mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}
				return temp.array_to_insert_sql(arg_0, arg_1, arg_2)
			}(var_class_row.dup(), rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
				'term_taxonomy'), rt.new_string('replace into')))
		}
		mut var_class_row := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return create_automattic_woocommerce_blueprint_steps_runsql(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}
			return temp.array_to_insert_sql(arg_0, arg_1, arg_2)
		}(var_class_row.dup(), rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
			'term_taxonomy'), rt.new_string('replace into')))
	}
	mut var_classes_steps := rt.call_function('array_map', [rt.new_closure(closure_3_fn),
		var_classes.dup()])
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_term := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return create_automattic_woocommerce_blueprint_steps_runsql(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
				mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}
				return temp.array_to_insert_sql(arg_0, arg_1, arg_2)
			}(var_term.dup(), rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'terms'),
				rt.new_string('replace into')))
		}
		mut var_term := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return create_automattic_woocommerce_blueprint_steps_runsql(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}
			return temp.array_to_insert_sql(arg_0, arg_1, arg_2)
		}(var_term.dup(), rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'terms'),
			rt.new_string('replace into')))
	}
	mut var_terms := rt.call_function('array_map', [rt.new_closure(closure_5_fn),
		this.get_terms(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_array](var_classes))])
	return rt.call_function('array_merge', [var_classes_steps.dup(),
		var_terms.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) get_step_name() string {
	return (fn () rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_Blueprint_Steps_RunSql{}
		return temp.get_step_name()
	}()).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) get_label() string {
	return (rt.call_function('__', [rt.new_string('Shipping'),
		rt.new_string('woocommerce')])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) get_description() string {
	return (rt.call_function('__', [
		rt.new_string('Includes all settings in WooCommerce | Settings | Shipping.'),
		rt.new_string('woocommerce'),
	])).str()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) get_alias() string {
	return 'setWCShipping'
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) get_steps_for_zones() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_zone := rt.new_null()
	// unsupported statement: Stmt_Global
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_zone := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return create_automattic_woocommerce_blueprint_steps_runsql(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
				mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}
				return temp.array_to_insert_sql(arg_0, arg_1, arg_2)
			}(var_zone.dup(), rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
				'woocommerce_shipping_zones'), rt.new_string('replace into')))
		}
		mut var_zone := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return create_automattic_woocommerce_blueprint_steps_runsql(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}
			return temp.array_to_insert_sql(arg_0, arg_1, arg_2)
		}(var_zone.dup(), rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
			'woocommerce_shipping_zones'), rt.new_string('replace into')))
	}
	return rt.call_function('array_map', [rt.new_closure(closure_7_fn),
		rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM '),
				rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_shipping_zones')),
			rt.get_constant('ARRAY_A'),
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) get_steps_for_locations() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_location := rt.new_null()
	// unsupported statement: Stmt_Global
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_location := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return create_automattic_woocommerce_blueprint_steps_runsql(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
				mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}
				return temp.array_to_insert_sql(arg_0, arg_1, arg_2)
			}(var_location.dup(), rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
				'woocommerce_shipping_zone_locations'), rt.new_string('replace into')))
		}
		mut var_location := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return create_automattic_woocommerce_blueprint_steps_runsql(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}
			return temp.array_to_insert_sql(arg_0, arg_1, arg_2)
		}(var_location.dup(), rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
			'woocommerce_shipping_zone_locations'), rt.new_string('replace into')))
	}
	return rt.call_function('array_map', [rt.new_closure(closure_9_fn),
		rt.call_method(var_wpdb, 'get_results', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM '),
				rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_shipping_zone_locations')),
			rt.get_constant('ARRAY_A'),
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) get_steps_for_methods_and_options() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_method := rt.new_null()
	mut var_option := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_methods := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'prefix')),
			rt.new_string('woocommerce_shipping_zone_methods')),
		rt.get_constant('ARRAY_A'),
	])
	mut var_method_options := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'prefix')),
			rt.new_string("options WHERE option_name LIKE 'woocommerce_flat_rate_%_settings'\n            OR option_name LIKE 'woocommerce_free_shipping_%_settings'")),
		rt.get_constant('ARRAY_A'),
	])
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
						closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
							mut var_method := if args.len > 0 {
								args[0].dup()
							} else {
								rt.new_null()
							}
							return create_automattic_woocommerce_blueprint_steps_runsql(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
								mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}
								return temp.array_to_insert_sql(arg_0, arg_1, arg_2)
							}(var_method.dup(), rt.new_string(
								(rt.get_property(var_wpdb, 'prefix')).str() +
								'woocommerce_shipping_zone_methods'), rt.new_string('replace into')))
						}
						mut var_method := if args.len > 0 { args[0].dup() } else { rt.new_null() }
						return create_automattic_woocommerce_blueprint_steps_runsql(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
							mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}
							return temp.array_to_insert_sql(arg_0, arg_1, arg_2)
						}(var_method.dup(), rt.new_string(
							(rt.get_property(var_wpdb, 'prefix')).str() +
							'woocommerce_shipping_zone_methods'), rt.new_string('replace into')))
					}
					mut var_option := if args.len > 0 { args[0].dup() } else { rt.new_null() }
					return create_automattic_woocommerce_blueprint_steps_runsql(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
						mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}
						return temp.array_to_insert_sql(arg_0, arg_1, arg_2)
					}(var_option.dup(), rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
						'options'), rt.new_string('replace into')))
				}
				mut var_option := if args.len > 0 { args[0].dup() } else { rt.new_null() }
				return create_automattic_woocommerce_blueprint_steps_runsql(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}
					return temp.array_to_insert_sql(arg_0, arg_1, arg_2)
				}(var_option.dup(), rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
					'options'), rt.new_string('replace into')))
			}
			mut var_method := if args.len > 0 { args[0].dup() } else { rt.new_null() }
			return create_automattic_woocommerce_blueprint_steps_runsql(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
				mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}
				return temp.array_to_insert_sql(arg_0, arg_1, arg_2)
			}(var_method.dup(), rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
				'woocommerce_shipping_zone_methods'), rt.new_string('replace into')))
		}
		mut var_method := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		return create_automattic_woocommerce_blueprint_steps_runsql(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Blueprint_Util{}
			return temp.array_to_insert_sql(arg_0, arg_1, arg_2)
		}(var_method.dup(), rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
			'woocommerce_shipping_zone_methods'), rt.new_string('replace into')))
	}
	return rt.call_function('array_merge', [
		rt.call_function('array_map', [rt.new_closure(closure_11_fn),
			var_methods.dup()]),
		rt.call_function('array_map', [rt.new_closure(closure_13_fn),
			var_method_options.dup()]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) get_step_for_local_pickup() rt.PhpVal {
	return create_automattic_woocommerce_blueprint_steps_setsiteoptions(rt.create_array([
		rt.ArrayItem{ key: 'woocommerce_pickup_location_settings', val: rt.call_function('get_option', [
			rt.new_string('woocommerce_pickup_location_settings'),
			rt.new_array(),
		]) },
		rt.ArrayItem{ key: 'pickup_location_pickup_locations', val: rt.call_function('get_option', [
			rt.new_string('pickup_location_pickup_locations'),
			rt.new_array(),
		]) },
	]))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) check_step_capabilities() bool {
	return (rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) get_page_id() string {
	return 'shipping'
}

struct Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_RunSql {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Util {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_blueprint_exporters_exportwcsettingsshipping() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_blueprint_exporters_exportwcsettings() &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_runsql() &Class_Automattic_WooCommerce_Blueprint_Steps_RunSql {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_RunSql{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_util() &Class_Automattic_WooCommerce_Blueprint_Util {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_setsiteoptions() &Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'export' {
			return this.export()
		}
		'get_terms' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_terms(mut dispatch_arg_0)
		}
		'get_steps_for_classes_and_terms' {
			return this.get_steps_for_classes_and_terms()
		}
		'get_step_name' {
			return rt.new_string(this.get_step_name())
		}
		'get_label' {
			return rt.new_string(this.get_label())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'get_alias' {
			return rt.new_string(this.get_alias())
		}
		'get_steps_for_zones' {
			return this.get_steps_for_zones()
		}
		'get_steps_for_locations' {
			return this.get_steps_for_locations()
		}
		'get_steps_for_methods_and_options' {
			return this.get_steps_for_methods_and_options()
		}
		'get_step_for_local_pickup' {
			return this.get_step_for_local_pickup()
		}
		'check_step_capabilities' {
			return rt.new_bool(this.check_step_capabilities())
		}
		'get_page_id' {
			return rt.new_string(this.get_page_id())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettingsShipping) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Blueprint_Exporters_ExportWCSettings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_RunSql) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_RunSql) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_RunSql) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_SetSiteOptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_admin_features_blueprint_exporters_exportwcsettingsshipping_php() {
	// unsupported statement: Stmt_Declare
}
