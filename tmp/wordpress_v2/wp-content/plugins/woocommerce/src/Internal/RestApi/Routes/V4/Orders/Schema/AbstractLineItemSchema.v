import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema) get_meta_data_schema() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Meta data.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{
			key: 'context'
			val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema.view_edit_embed_context()
		},
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Meta ID.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema.view_edit_embed_context()
					},
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
				rt.ArrayItem{ key: 'key', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Meta key.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'value', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Meta value.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'null' },
						rt.ArrayItem{ key: none, val: 'object' },
						rt.ArrayItem{ key: none, val: 'string' },
						rt.ArrayItem{ key: none, val: 'number' },
						rt.ArrayItem{ key: none, val: 'boolean' },
						rt.ArrayItem{ key: none, val: 'integer' },
						rt.ArrayItem{ key: none, val: 'array' },
					]) },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'display_key', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Meta key for UI display.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema.view_edit_embed_context()
					},
				]) },
				rt.ArrayItem{ key: 'display_value', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Meta value for UI display.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'null' },
						rt.ArrayItem{ key: none, val: 'object' },
						rt.ArrayItem{ key: none, val: 'string' },
						rt.ArrayItem{ key: none, val: 'number' },
						rt.ArrayItem{ key: none, val: 'boolean' },
						rt.ArrayItem{ key: none, val: 'integer' },
						rt.ArrayItem{ key: none, val: 'array' },
					]) },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema.view_edit_embed_context()
					},
				]) },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema) prepare_meta_data(var_order_item rt.PhpVal) rt.PhpVal {
	mut var_formatted_meta_data := rt.call_method(var_order_item, 'get_all_formatted_meta_data', [
		rt.new_null(),
	])
	mut var_return := rt.new_array()
	mut iter_1 := var_formatted_meta_data.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_meta := item_1.val
		mut var_meta_id := item_1.key
		var_return.array_push(rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_meta_id },
			rt.ArrayItem{ key: 'key', val: rt.get_property(var_meta, 'key') },
			rt.ArrayItem{ key: 'value', val: rt.get_property(var_meta, 'value') },
			rt.ArrayItem{ key: 'display_key', val: rt.call_function('wc_clean', [
				rt.get_property(var_meta, 'display_key'),
			]) },
			rt.ArrayItem{ key: 'display_value', val: rt.call_function('wc_clean', [
				rt.get_property(var_meta, 'display_value'),
			]) },
		]))
	}
	return var_return.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema) get_taxes_schema() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Line taxes.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'array' },
		rt.ArrayItem{
			key: 'context'
			val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema.view_edit_embed_context()
		},
		rt.ArrayItem{ key: 'readonly', val: true },
		rt.ArrayItem{ key: 'items', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'properties', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Tax rate ID.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema.view_edit_embed_context()
					},
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
				rt.ArrayItem{ key: 'total', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Tax total.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema.view_edit_embed_context()
					},
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
				rt.ArrayItem{ key: 'subtotal', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Tax subtotal.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{
						key: 'context'
						val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema.view_edit_embed_context()
					},
					rt.ArrayItem{ key: 'readonly', val: true },
				]) },
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema) prepare_taxes(var_order_item rt.PhpVal, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_taxes := rt.call_method(var_order_item, 'get_taxes', []rt.PhpVal{})
	mut var_dp := if var_request.array_get(rt.new_string('num_decimals')).is_null() { rt.call_function('wc_get_price_decimals', []rt.PhpVal{}) } else { rt.call_function('absint', [
			var_request.array_get(rt.new_string('num_decimals')),
		]) }
	mut var_return := rt.new_array()
	if rt.is_true(var_taxes) && !(!rt.is_true(var_taxes.array_get(rt.new_string('total')))) {
		mut iter_2 := var_taxes.array_get(rt.new_string('total')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_tax := item_2.val
			mut var_tax_rate_id := item_2.key
			var_return.array_push(rt.create_array([
				rt.ArrayItem{ key: 'id', val: var_tax_rate_id },
				rt.ArrayItem{ key: 'total', val: rt.call_function('wc_format_decimal', [
					var_tax.clone(),
					var_dp.clone(),
				]) },
				rt.ArrayItem{ key: 'subtotal', val: rt.call_function('wc_format_decimal', [
					if !(var_taxes.array_get(rt.new_string('subtotal')).array_get(var_tax_rate_id)).is_null() {
						var_taxes.array_get(rt.new_string('subtotal')).array_get(var_tax_rate_id)
					} else {
						var_tax
					},
					var_dp.clone(),
				]) },
			]))
		}
	}
	return var_return.clone()
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_orders_schema_abstractlineitemschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema{
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

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_meta_data_schema' {
			return this.get_meta_data_schema()
		}
		'prepare_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_meta_data(dispatch_arg_0)
		}
		'get_taxes_schema' {
			return this.get_taxes_schema()
		}
		'prepare_taxes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.prepare_taxes(dispatch_arg_0, mut dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_Orders_Schema_AbstractLineItemSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
