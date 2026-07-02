import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderFeeSchema.identifier() string {
	return 'order-fee'
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderFeeSchema {
	rt.PhpObjectBase
pub mut:
	title rt.PhpVal = rt.new_string('order_fee')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderFeeSchema) get_properties() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Unique identifier for the fee within the cart'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'name', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Fee name'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
		]) },
		rt.ArrayItem{ key: 'totals', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('Fee total amounts provided using the smallest unit of the currency.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'object' },
			rt.ArrayItem{ key: 'context', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'view' },
				rt.ArrayItem{ key: none, val: 'edit' },
			]) },
			rt.ArrayItem{ key: 'readonly', val: true },
			rt.ArrayItem{ key: 'properties', val: rt.call_function('array_merge', [
				this.get_store_currency_properties(),
				rt.create_array([
					rt.ArrayItem{ key: 'total', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total amount for this fee.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'total_tax', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Total tax amount for this fee.'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]),
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderFeeSchema) get_item_response(var_fee rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_fee)))) {
		return rt.new_array()
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'key', val: rt.call_method(var_fee, 'get_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'name', val: this.prepare_html_response(rt.call_method(var_fee,
			'get_name', []rt.PhpVal{})) },
		rt.ArrayItem{ key: 'totals', val: rt.array_to_object(this.prepare_currency_response(rt.create_array([
			rt.ArrayItem{ key: 'total', val: this.prepare_money_response(rt.call_method(var_fee,
				'get_total', []rt.PhpVal{}), rt.call_function('wc_get_price_decimals',
				[]rt.PhpVal{})) },
			rt.ArrayItem{ key: 'total_tax', val: this.prepare_money_response(rt.call_method(var_fee,
				'get_total_tax', []rt.PhpVal{}), rt.call_function('wc_get_price_decimals',
				[]rt.PhpVal{}), rt.get_constant('PHP_ROUND_HALF_DOWN')) },
		]))) },
	])
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_orderfeeschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderFeeSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderFeeSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title:         rt.new_string('order_fee')
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractschema(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderFeeSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_properties' {
			return this.get_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderFeeSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_OrderFeeSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' {
			this.title = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
