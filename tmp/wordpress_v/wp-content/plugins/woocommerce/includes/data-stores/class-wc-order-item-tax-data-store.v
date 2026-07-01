import rt

struct Class_WC_Order_Item_Tax_Data_Store {
	rt.PhpObjectBase
pub mut:
	internal_meta_keys rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Order_Item_Tax_Data_Store) read(var_item rt.PhpVal) {
	this.Class_Abstract_WC_Order_Item_Type_Data_Store.read(var_item.dup())
	mut var_id := rt.call_method(var_item, 'get_id', []rt.PhpVal{})
	rt.call_method(var_item, 'set_props', [
		rt.create_array([
			rt.ArrayItem{ key: 'rate_id', val: rt.call_function('get_metadata', [
				rt.new_string('order_item'),
				var_id.dup(),
				rt.new_string('rate_id'),
				rt.new_bool(true),
			]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('get_metadata', [
				rt.new_string('order_item'),
				var_id.dup(),
				rt.new_string('label'),
				rt.new_bool(true),
			]) },
			rt.ArrayItem{ key: 'compound', val: rt.call_function('get_metadata', [
				rt.new_string('order_item'),
				var_id.dup(),
				rt.new_string('compound'),
				rt.new_bool(true),
			]) },
			rt.ArrayItem{ key: 'tax_total', val: rt.call_function('get_metadata', [
				rt.new_string('order_item'),
				var_id.dup(),
				rt.new_string('tax_amount'),
				rt.new_bool(true),
			]) },
			rt.ArrayItem{ key: 'shipping_tax_total', val: rt.call_function('get_metadata', [
				rt.new_string('order_item'),
				var_id.dup(),
				rt.new_string('shipping_tax_amount'),
				rt.new_bool(true),
			]) },
			rt.ArrayItem{ key: 'rate_percent', val: rt.call_function('get_metadata', [
				rt.new_string('order_item'),
				var_id.dup(),
				rt.new_string('rate_percent'),
				rt.new_bool(true),
			]) },
		]),
	])
	rt.call_method(var_item, 'set_object_read', [rt.new_bool(true)])
}

fn (mut this Class_WC_Order_Item_Tax_Data_Store) save_item_data(var_item rt.PhpVal) {
	mut var_id := rt.call_method(var_item, 'get_id', []rt.PhpVal{})
	mut var_changes := rt.call_method(var_item, 'get_changes', []rt.PhpVal{})
	mut var_meta_key_to_props := {
		'rate_id':             'rate_id'
		'label':               'label'
		'compound':            'compound'
		'tax_amount':          'tax_total'
		'shipping_tax_amount': 'shipping_tax_total'
		'rate_percent':        'rate_percent'
	}
	mut var_props_to_update := this.get_props_to_update(var_item.dup(),
		var_meta_key_to_props.dup(), rt.new_string('order_item'))
	{
		mut iter_1 := var_props_to_update.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_prop := item_1.val
			mut var_meta_key := item_1.key
			rt.call_function('update_metadata', [rt.new_string('order_item'),
				var_id.dup(), var_meta_key.dup(),
				rt.call_method(var_item,
					'get_${var_prop.to_string()}', [rt.new_string('edit')])])
		}
	}
}

struct Class_Abstract_WC_Order_Item_Type_Data_Store {
	rt.PhpObjectBase
}

fn create_wc_order_item_tax_data_store() &Class_WC_Order_Item_Tax_Data_Store {
	mut obj := &Class_WC_Order_Item_Tax_Data_Store{
		PhpObjectBase:      rt.PhpObjectBase{}
		internal_meta_keys: rt.new_array()
	}
	return obj
}

fn create_abstract_wc_order_item_type_data_store() &Class_Abstract_WC_Order_Item_Type_Data_Store {
	mut obj := &Class_Abstract_WC_Order_Item_Type_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Order_Item_Tax_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'save_item_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.save_item_data(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Order_Item_Tax_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'internal_meta_keys' { return this.internal_meta_keys }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Order_Item_Tax_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'internal_meta_keys' {
			this.internal_meta_keys = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Abstract_WC_Order_Item_Type_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Abstract_WC_Order_Item_Type_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Abstract_WC_Order_Item_Type_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

pub fn init_wp_content_plugins_woocommerce_includes_data_stores_class_wc_order_item_tax_data_store_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
	}
}
