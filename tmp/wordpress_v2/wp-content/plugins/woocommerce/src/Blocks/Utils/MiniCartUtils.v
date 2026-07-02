import rt

struct Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils.migrate_attributes_to_color_panel(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_attributes_mutated := var_attributes
	if var_attributes_mutated.array_isset(rt.new_string('priceColorValue'))
		&& !(var_attributes_mutated.array_isset(rt.new_string('priceColor'))) {
		var_attributes_mutated.array_set('priceColor', rt.create_array([
			rt.ArrayItem{
				key: 'color'
				val: var_attributes_mutated.array_get(rt.new_string('priceColorValue'))
			},
		]))
		var_attributes_mutated.array_unset(rt.new_string('priceColorValue'))
	}
	if var_attributes_mutated.array_isset(rt.new_string('iconColorValue'))
		&& !(var_attributes_mutated.array_isset(rt.new_string('iconColor'))) {
		var_attributes_mutated.array_set('iconColor', rt.create_array([
			rt.ArrayItem{
				key: 'color'
				val: var_attributes_mutated.array_get(rt.new_string('iconColorValue'))
			},
		]))
		var_attributes_mutated.array_unset(rt.new_string('iconColorValue'))
	}
	if var_attributes_mutated.array_isset(rt.new_string('productCountColorValue'))
		&& !(var_attributes_mutated.array_isset(rt.new_string('productCountColor'))) {
		var_attributes_mutated.array_set('productCountColor', rt.create_array([
			rt.ArrayItem{
				key: 'color'
				val: var_attributes_mutated.array_get(rt.new_string('productCountColorValue'))
			},
		]))
		var_attributes_mutated.array_unset(rt.new_string('productCountColorValue'))
	}
	return var_attributes_mutated.clone()
}

fn Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils.get_svg_icon(var_icon_name rt.PhpVal, icon_color string) rt.PhpVal {
	mut var_icon := rt.new_string('<svg xmlns="http://www.w3.org/2000/svg" fill="' +
		(rt.call_function('esc_attr', [rt.new_string(icon_color)])).str() +
		'" class="wc-block-mini-cart__icon" viewBox="0 0 32 32"><circle cx="12.667" cy="24.667" r="2"/><circle cx="23.333" cy="24.667" r="2"/><path fill-rule="evenodd" d="M9.285 10.036a1 1 0 0 1 .776-.37h15.272a1 1 0 0 1 .99 1.142l-1.333 9.333A1 1 0 0 1 24 21H12a1 1 0 0 1-.98-.797L9.083 10.87a1 1 0 0 1 .203-.834m2.005 1.63L12.814 19h10.319l1.047-7.333z" clip-rule="evenodd"/><path fill-rule="evenodd" d="M5.667 6.667a1 1 0 0 1 1-1h2.666a1 1 0 0 1 .984.82l.727 4a1 1 0 1 1-1.967.359l-.578-3.18H6.667a1 1 0 0 1-1-1" clip-rule="evenodd"/></svg>')
	if !var_icon_name.is_null() {
		if rt.is_true(rt.identical(rt.new_string('bag'), var_icon_name)) {
			var_icon = rt.new_string(
				'<svg xmlns="http://www.w3.org/2000/svg" fill="none" class="wc-block-mini-cart__icon" viewBox="0 0 32 32"><path fill="' +
				(rt.call_function('esc_attr', [rt.new_string(icon_color)])).str() +
				'" fill-rule="evenodd" d="M12.444 14.222a.89.89 0 0 1 .89.89 2.667 2.667 0 0 0 5.333 0 .889.889 0 1 1 1.777 0 4.444 4.444 0 1 1-8.888 0c0-.492.398-.89.888-.89M11.24 6.683a1 1 0 0 1 .76-.35h8a1 1 0 0 1 .76.35l4 4.666A1 1 0 0 1 24 13H8a1 1 0 0 1-.76-1.65zm1.22 1.65L10.174 11h11.652L19.54 8.333z" clip-rule="evenodd"/><path fill="' +
				(rt.call_function('esc_attr', [rt.new_string(icon_color)])).str() +
				'" fill-rule="evenodd" d="M7 12a1 1 0 0 1 1-1h16a1 1 0 0 1 1 1v13.333a1 1 0 0 1-1 1H8a1 1 0 0 1-1-1zm2 1v11.333h14V13z" clip-rule="evenodd"/></svg>')
		} else if rt.is_true(rt.identical(rt.new_string('bag-alt'), var_icon_name)) {
			var_icon = rt.new_string(
				'<svg xmlns="http://www.w3.org/2000/svg" fill="none" class="wc-block-mini-cart__icon" viewBox="0 0 32 32"><path fill="' +
				(rt.call_function('esc_attr', [rt.new_string(icon_color)])).str() +
				'" fill-rule="evenodd" d="M19.556 12.333a.89.89 0 0 1-.89-.889c0-.707-.28-3.385-.78-3.885a2.667 2.667 0 0 0-3.772 0c-.5.5-.78 3.178-.78 3.885a.889.889 0 1 1-1.778 0c0-1.178.468-4.309 1.301-5.142a4.445 4.445 0 0 1 6.286 0c.833.833 1.302 3.964 1.302 5.142a.89.89 0 0 1-.89.89" clip-rule="evenodd"/><path fill="' +
				(rt.call_function('esc_attr', [rt.new_string(icon_color)])).str() +
				'" fill-rule="evenodd" d="M7.5 12a1 1 0 0 1 1-1h15a1 1 0 0 1 1 1v13.333a1 1 0 0 1-1 1h-15a1 1 0 0 1-1-1zm2 1v11.333h13V13z" clip-rule="evenodd"/></svg>')
		}
	}
	return var_icon.clone()
}

fn create_automattic_woocommerce_blocks_utils_minicartutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'migrate_attributes_to_color_panel' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils.migrate_attributes_to_color_panel(dispatch_arg_0)
		}
		'get_svg_icon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils.get_svg_icon(dispatch_arg_0,
				dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_MiniCartUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
