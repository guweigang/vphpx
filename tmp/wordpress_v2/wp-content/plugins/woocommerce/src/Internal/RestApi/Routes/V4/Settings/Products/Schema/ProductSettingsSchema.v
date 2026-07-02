import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_ProductSettingsSchema.identifier() string {
	return 'product_settings'
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_ProductSettingsSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_ProductSettingsSchema) get_item_schema_properties() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the settings group.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'title', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Settings title.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'description', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Settings description.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'values', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Flat key-value mapping of all setting field values.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Setting field value.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'string' },
					rt.ArrayItem{ key: none, val: 'number' },
					rt.ArrayItem{ key: none, val: 'array' },
					rt.ArrayItem{ key: none, val: 'boolean' },
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'groups', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Collection of setting groups.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Settings group.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'title', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Group title.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'description', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Group description.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'order', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Display order for the group.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'integer' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'fields', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Settings fields.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'array' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'items', val: this.get_field_schema() },
					]) },
				]) },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_ProductSettingsSchema) get_field_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Setting field ID.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'label', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Setting field label.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'type', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Setting field type.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'enum', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'text' },
					rt.ArrayItem{ key: none, val: 'number' },
					rt.ArrayItem{ key: none, val: 'select' },
					rt.ArrayItem{ key: none, val: 'multiselect' },
					rt.ArrayItem{ key: none, val: 'checkbox' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Available options for select/multiselect fields.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Description for the setting field.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
		]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_ProductSettingsSchema) get_item_response(var_item rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_array) rt.PhpVal {
	mut var_raw_settings := var_item
	mut var_groups := rt.new_array()
	mut var_values := rt.new_array()
	mut var_current_group := rt.new_null()
	mut var_current_group_id := rt.new_null()
	mut iter_1 := var_raw_settings.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_setting := item_1.val
		mut var_setting_type := if !(var_setting.array_get(rt.new_string('type'))).is_null() {
			var_setting.array_get(rt.new_string('type'))
		} else {
			rt.new_string('')
		}
		if rt.is_true(rt.identical(rt.new_string('title'), var_setting_type)) {
			var_current_group_id = if !(var_setting.array_get(rt.new_string('id'))).is_null() {
				var_setting.array_get(rt.new_string('id'))
			} else {
				rt.new_string('')
			}
			var_current_group = rt.create_array([
				rt.ArrayItem{
					key: 'title'
					val: if !(var_setting.array_get(rt.new_string('title'))).is_null() {
						var_setting.array_get(rt.new_string('title'))
					} else {
						rt.new_string('')
					}
				},
				rt.ArrayItem{
					key: 'description'
					val: if !(var_setting.array_get(rt.new_string('desc'))).is_null() {
						var_setting.array_get(rt.new_string('desc'))
					} else {
						rt.new_string('')
					}
				},
				rt.ArrayItem{
					key: 'order'
					val: if var_setting.array_isset(rt.new_string('order')) {
						rt.new_int((var_setting.array_get(rt.new_string('order'))).to_i64())
					} else {
						999
					}
				},
				rt.ArrayItem{ key: 'fields', val: rt.new_array() },
			])
			continue
		}
		if rt.is_true(rt.identical(rt.new_string('sectionend'), var_setting_type)) {
			if rt.is_true(var_current_group) && rt.is_true(var_current_group_id) {
				var_groups.array_set(var_current_group_id, var_current_group.clone())
			}
			var_current_group = rt.new_null()
			var_current_group_id = rt.new_null()
			continue
		}
		if rt.is_true(rt.call_function('in_array', [var_setting_type.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'title' },
				rt.ArrayItem{ key: none, val: 'sectionend' }]),
			rt.new_bool(true)]))
		{
			continue
		}
		if var_setting.array_isset(rt.new_string('id')) && rt.is_true(var_current_group) {
			mut var_field :=
				this.transform_setting_to_field(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_array](var_setting))
			if rt.is_true(var_field) {
				var_current_group.array_get_mut('fields').array_push(var_field.clone())
				mut var_raw_value := rt.call_function('get_option', [
					var_field.array_get(rt.new_string('id')),
					if !(var_setting.array_get(rt.new_string('default'))).is_null() {
						var_setting.array_get(rt.new_string('default'))
					} else {
						rt.new_string('')
					},
				])
				var_values.array_set(var_field.array_get(rt.new_string('id')), this.validate_field_value(var_raw_value.clone(),
					(var_field.array_get(rt.new_string('type'))).str()))
			}
		}
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_a_order := if !(var_a.array_get(rt.new_string('order'))).is_null() {
			var_a.array_get(rt.new_string('order'))
		} else {
			rt.new_int(999)
		}
		mut var_b_order := if !(var_b.array_get(rt.new_string('order'))).is_null() {
			var_b.array_get(rt.new_string('order'))
		} else {
			rt.new_int(999)
		}
		return rt.sub(var_a_order, var_b_order)
	}
	rt.call_function('uasort', [var_groups.clone(), rt.new_closure(closure_1_fn)])
	return rt.create_array([rt.ArrayItem{ key: 'id', val: 'products' },
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Products'),
			rt.new_string('woocommerce'),
		]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Manage product settings including dimensions, weight units, and display options.'),
			rt.new_string('woocommerce'),
		]) }, rt.ArrayItem{ key: 'values', val: var_values },
		rt.ArrayItem{ key: 'groups', val: var_groups }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_ProductSettingsSchema) transform_setting_to_field(mut var_setting Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_array) rt.PhpVal {
	mut var_setting_id := if !(var_setting.array_get(rt.new_string('id'))).is_null() {
		var_setting.array_get(rt.new_string('id'))
	} else {
		rt.new_string('')
	}
	mut var_setting_type := if !(var_setting.array_get(rt.new_string('type'))).is_null() {
		var_setting.array_get(rt.new_string('type'))
	} else {
		rt.new_string('text')
	}
	mut var_field := rt.create_array([rt.ArrayItem{ key: 'id', val: var_setting_id },
		rt.ArrayItem{
			key: 'label'
			val: if !(var_setting.array_get(rt.new_string('title'))).is_null() {
				var_setting.array_get(rt.new_string('title'))
			} else {
				var_setting_id
			}
		}, rt.ArrayItem{ key: 'type', val: this.normalize_field_type(var_setting_type.str()) },
		rt.ArrayItem{
			key: 'desc'
			val: if !(var_setting.array_get(rt.new_string('desc'))).is_null() {
				var_setting.array_get(rt.new_string('desc'))
			} else {
				rt.new_string('')
			}
		}])
	if var_setting.array_isset(rt.new_string('options'))
		&& var_setting.array_get(rt.new_string('options')).is_array() {
		var_field.array_set('options', var_setting.array_get(rt.new_string('options')))
	} else {
		var_field.array_set('options', this.get_field_options(var_setting_id.str()))
	}
	return var_field.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_ProductSettingsSchema) get_field_options(field_id string) rt.PhpVal {
	mut switch_val_1 := rt.new_string(field_id)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_weight_unit'))) {
		return rt.create_array([
			rt.ArrayItem{ key: 'kg', val: rt.call_function('__', [
				rt.new_string('kg'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'g', val: rt.call_function('__', [
				rt.new_string('g'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'lbs', val: rt.call_function('__', [
				rt.new_string('lbs'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'oz', val: rt.call_function('__', [
				rt.new_string('oz'), rt.new_string('woocommerce')]) },
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_dimension_unit'))) {
		return rt.create_array([
			rt.ArrayItem{ key: 'm', val: rt.call_function('__', [
				rt.new_string('m'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'cm', val: rt.call_function('__', [
				rt.new_string('cm'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'mm', val: rt.call_function('__', [
				rt.new_string('mm'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'in', val: rt.call_function('__', [
				rt.new_string('in'), rt.new_string('woocommerce')]) },
			rt.ArrayItem{ key: 'yd', val: rt.call_function('__', [
				rt.new_string('yd'), rt.new_string('woocommerce')]) },
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('woocommerce_product_type'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wc_get_product_types'),
		])))))
		{
			return rt.new_array()
		}
		mut var_product_types := rt.call_function('wc_get_product_types', []rt.PhpVal{})
		return if var_product_types.clone().is_array() { var_product_types } else { rt.new_array() }
	}
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_ProductSettingsSchema) normalize_field_type(wc_type string) string {
	mut var_type_map := rt.create_array([
		rt.ArrayItem{ key: 'single_select_product', val: 'select' },
		rt.ArrayItem{ key: 'multi_select_product', val: 'multiselect' },
	])
	return (if !(var_type_map.array_get(rt.new_string(wc_type))).is_null() {
		var_type_map.array_get(rt.new_string(wc_type))
	} else {
		rt.new_string(wc_type)
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_ProductSettingsSchema) validate_field_value(var_value rt.PhpVal, type string) rt.PhpVal {
	mut switch_val_2 := rt.new_string(type)
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('number'))) {
		return if var_value.clone().is_long() || var_value.clone().is_double() {
			rt.new_float(var_value.to_f64())
		} else {
			rt.new_int(0)
		}
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('checkbox'))) {
		if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wc_string_to_bool'),
		]))
		{
			return rt.call_function('wc_string_to_bool', [var_value.clone()])
		}
		if rt.is_true(rt.new_bool(var_value.clone().is_bool())) {
			return var_value.clone()
		}
		return rt.call_function('filter_var', [var_value.clone(),
			rt.get_constant('FILTER_VALIDATE_BOOLEAN')])
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('multiselect'))) {
		return if var_value.clone().is_array() { var_value } else { rt.new_array() }
	} else {
		return if var_value.clone().is_string() { var_value } else { var_value.str() }
	}
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_settings_products_schema_productsettingsschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_ProductSettingsSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_ProductSettingsSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_ProductSettingsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'get_field_schema' {
			return this.get_field_schema()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'transform_setting_to_field' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.transform_setting_to_field(mut dispatch_arg_0)
		}
		'get_field_options' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_field_options(dispatch_arg_0)
		}
		'normalize_field_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.normalize_field_type(dispatch_arg_0))
		}
		'validate_field_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.validate_field_value(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_ProductSettingsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Settings_Products_Schema_ProductSettingsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
