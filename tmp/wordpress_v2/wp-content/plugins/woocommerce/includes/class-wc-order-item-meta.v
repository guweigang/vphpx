import rt

struct Class_WC_Order_Item_Meta {
	rt.PhpObjectBase
pub mut:
	legacy  bool
	item    rt.PhpVal = rt.new_null()
	meta    rt.PhpVal = rt.new_null()
	product rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Order_Item_Meta) construct(var_item rt.PhpVal, var_product rt.PhpVal) {
	rt.call_function('wc_deprecated_function', [
		rt.new_string('WC_Order_Item_Meta::__construct'),
		rt.new_string('3.1'),
		rt.new_string('WC_Order_Item_Product'),
	])
	if !(var_item.array_isset(rt.new_string('item_meta'))) {
		this.legacy = true
		this.meta = rt.call_function('array_filter', [rt.cast_array(var_item)])
		return
	}
	this.item = var_item.clone()
	this.meta = rt.call_function('array_filter', [
		rt.cast_array(var_item.array_get(rt.new_string('item_meta'))),
	])
	this.product = var_product.clone()
}

fn (mut this Class_WC_Order_Item_Meta) display(flat bool, return bool, hideprefix string, delimiter string) rt.PhpVal {
	mut var_output := rt.new_string('')
	mut var_formatted_meta := this.get_formatted(hideprefix)
	if !(!rt.is_true(var_formatted_meta)) {
		mut var_meta_list := []rt.PhpVal{}
		mut iter_1 := var_formatted_meta.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_meta := item_1.val
			if var_flat {
				var_meta_list << rt.call_function('wp_kses_post', [
					rt.new_string((var_meta.array_get(rt.new_string('label'))).str() + ': ' +
						(var_meta.array_get(rt.new_string('value'))).str()),
				])
			} else {
				var_meta_list << '\n\t\t\t\t\t\t<dt class="variation-' +
					(rt.call_function('sanitize_html_class', [rt.call_function('sanitize_text_field', [var_meta.array_get(rt.new_string('key'))])])).str() +
					'">' +
					(rt.call_function('wp_kses_post', [var_meta.array_get(rt.new_string('label'))])).str() +
					':</dt>\n\t\t\t\t\t\t<dd class="variation-' +
					(rt.call_function('sanitize_html_class', [rt.call_function('sanitize_text_field', [var_meta.array_get(rt.new_string('key'))])])).str() +
					'">' +
					(rt.call_function('wp_kses_post', [rt.call_function('wpautop', [rt.call_function('make_clickable', [var_meta.array_get(rt.new_string('value'))])])])).str() +
					'</dd>\n\t\t\t\t\t'
			}
		}
		if !(!rt.is_true(var_meta_list)) {
			if var_flat {
				var_output = rt.concat(var_output, rt.call_function('implode', [
					rt.new_string(delimiter),
					rt.create_array_from_list(var_meta_list),
				]))
			} else {
				var_output = rt.concat(var_output, rt.new_string('<dl class="variation">' +
					(rt.call_function('implode', [rt.new_string(''), rt.create_array_from_list(var_meta_list)])).str() +
					'</dl>'))
			}
		}
	}
	var_output = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_order_items_meta_display'),
		var_output.clone(),
		rt.new_object('WC_Order_Item_Meta', []string{}, &this),
		rt.new_bool(flat),
	])
	if var_return {
		return var_output.clone()
	} else {
		rt.echo_val(var_output)
	}
	return rt.new_null()
}

fn (mut this Class_WC_Order_Item_Meta) get_formatted(hideprefix string) rt.PhpVal {
	if this.legacy {
		return this.get_formatted_legacy(hideprefix)
	}
	mut var_formatted_meta := []rt.PhpVal{}
	if !(!rt.is_true(this.item.array_get(rt.new_string('item_meta_array')))) {
		mut iter_2 := this.item.array_get(rt.new_string('item_meta_array')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_meta := item_2.val
			mut var_meta_id := item_2.key
			if rt.is_true(rt.identical(rt.new_string(''), rt.get_property(var_meta, 'value')))
				|| rt.is_true(rt.call_function('is_serialized', [rt.get_property(var_meta, 'value')]))
				|| (!(hideprefix == '')
				&& rt.is_true(rt.identical(rt.call_function('substr', [rt.get_property(var_meta, 'key'), rt.new_int(0), rt.new_int(1)]), rt.new_string(hideprefix)))) {
				continue
			}
			mut var_attribute_key := rt.call_function('urldecode', [
				rt.call_function('str_replace', [rt.new_string('attribute_'),
					rt.new_string(''), rt.get_property(var_meta, 'key')]),
			])
			mut var_meta_value := rt.get_property(var_meta, 'value')
			if rt.is_true(rt.call_function('taxonomy_exists', [
				var_attribute_key.clone()]))
			{
				mut var_term := rt.call_function('get_term_by', [
					rt.new_string('slug'), var_meta_value.clone(),
					var_attribute_key.clone()])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])))))
					&& var_term.clone().is_object() && rt.is_true(rt.get_property(var_term, 'name')) {
					var_meta_value = rt.get_property(var_term, 'name')
				}
			}
			var_formatted_meta.array_set(var_meta_id, rt.create_array([
				rt.ArrayItem{ key: 'key', val: rt.get_property(var_meta, 'key') },
				rt.ArrayItem{ key: 'label', val: rt.call_function('wc_attribute_label', [
					var_attribute_key.clone(),
					this.product,
				]) },
				rt.ArrayItem{ key: 'value', val: rt.call_function('apply_filters', [
					rt.new_string('woocommerce_order_item_display_meta_value'),
					var_meta_value.clone(),
					var_meta.clone(),
					this.item,
				]) },
			]))
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_order_items_meta_get_formatted'),
		var_formatted_meta.clone(),
		rt.new_object('WC_Order_Item_Meta', []string{}, &this),
	])
}

fn (mut this Class_WC_Order_Item_Meta) get_formatted_legacy(hideprefix string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))))) {
		rt.call_function('wc_deprecated_argument', [
			rt.new_string('WC_Order_Item_Meta::get_formatted'),
			rt.new_string('2.4'),
			rt.new_string('Item Meta Data is being called with legacy arguments'),
		])
	}
	mut var_formatted_meta := []rt.PhpVal{}
	mut iter_3 := this.meta.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_meta_values := item_3.val
		mut var_meta_key := item_3.key
		if !rt.is_true(var_meta_values) || (!(hideprefix == '')
			&& rt.is_true(rt.identical(rt.call_function('substr', [var_meta_key.clone(), rt.new_int(0), rt.new_int(1)]), rt.new_string(hideprefix)))) {
			continue
		}
		mut iter_4 := rt.cast_array(var_meta_values).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_meta_value := item_4.val
			if rt.is_true(rt.call_function('is_serialized', [
				var_meta_value.clone()]))
			{
				continue
			}
			mut var_attribute_key := rt.call_function('urldecode', [
				rt.call_function('str_replace', [rt.new_string('attribute_'),
					rt.new_string(''), var_meta_key.clone()]),
			])
			if rt.is_true(rt.call_function('taxonomy_exists', [
				var_attribute_key.clone()]))
			{
				mut var_term := rt.call_function('get_term_by', [
					rt.new_string('slug'), var_meta_value.clone(),
					var_attribute_key.clone()])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])))))
					&& var_term.clone().is_object() && rt.is_true(rt.get_property(var_term, 'name')) {
					var_meta_value = rt.get_property(var_term, 'name')
				}
			}
			mut var_formatted_meta_key := var_meta_key
			mut var_loop := rt.new_int(0)
			for var_formatted_meta.array_isset(var_formatted_meta_key) {
				rt.post_inc(var_loop)
				var_formatted_meta_key = rt.new_string(var_meta_key.str() + '-' + var_loop.str())
			}
			var_formatted_meta.array_set(var_formatted_meta_key, rt.create_array([
				rt.ArrayItem{ key: 'key', val: var_meta_key },
				rt.ArrayItem{ key: 'label', val: rt.call_function('wc_attribute_label', [
					var_attribute_key.clone(),
					this.product,
				]) },
				rt.ArrayItem{ key: 'value', val: rt.call_function('apply_filters', [
					rt.new_string('woocommerce_order_item_display_meta_value'),
					var_meta_value.clone(),
					this.meta,
					this.item,
				]) },
			]))
		}
	}
	return var_formatted_meta.clone()
}

fn create_wc_order_item_meta(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_WC_Order_Item_Meta {
	mut obj := &Class_WC_Order_Item_Meta{
		PhpObjectBase: rt.PhpObjectBase{}
		legacy:        false
		item:          rt.new_null()
		meta:          rt.new_null()
		product:       rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_WC_Order_Item_Meta) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'display' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return this.display(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'get_formatted' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_formatted(dispatch_arg_0)
		}
		'get_formatted_legacy' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_formatted_legacy(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Order_Item_Meta) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'legacy' { return rt.new_bool(this.legacy) }
		'item' { return this.item }
		'meta' { return this.meta }
		'product' { return this.product }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Order_Item_Meta) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'legacy' {
			this.legacy = val.to_bool()
			return true
		}
		'item' {
			this.item = val
			return true
		}
		'meta' {
			this.meta = val
			return true
		}
		'product' {
			this.product = val
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
