import rt

struct Class_WC_Meta_Box_Product_Reviews {
	rt.PhpObjectBase
}

fn Class_WC_Meta_Box_Product_Reviews.output(var_comment rt.PhpVal) {
	rt.call_function('wp_nonce_field', [rt.new_string('woocommerce_save_data'),
		rt.new_string('woocommerce_meta_nonce')])
	mut var_current := rt.call_function('get_comment_meta', [
		rt.get_property(var_comment, 'comment_ID'),
		rt.new_string('rating'),
		rt.new_bool(true),
	])
	// unsupported statement: Stmt_InlineHTML
	mut var_rating := rt.new_int(1)
	for {
		if !(rt.is_true(rt.less_equal(var_rating, rt.new_int(5)))) { break
		 }
		rt.call_function('printf', [
			rt.new_string('<option value="%1$s"%2$s>%1$s</option>'),
			var_rating.clone(),
			rt.call_function('selected', [var_current.clone(),
				var_rating.clone(), rt.new_bool(false)]),
		])
		rt.post_inc(var_rating)
	}
	// unsupported statement: Stmt_InlineHTML
}

fn Class_WC_Meta_Box_Product_Reviews.save(var_data rt.PhpVal) rt.PhpVal {
	if (!(rt.get_superglobal('_POST').array_isset(rt.new_string('woocommerce_meta_nonce'))
		&& rt.get_superglobal('_POST').array_isset(rt.new_string('rating'))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('woocommerce_meta_nonce'))]), rt.new_string('woocommerce_save_data')]))))) {
		return var_data.clone()
	}
	if rt.is_true(rt.greater(rt.get_superglobal('_POST').array_get(rt.new_string('rating')), rt.new_int(5)))
		|| rt.is_true(rt.less(rt.get_superglobal('_POST').array_get(rt.new_string('rating')), rt.new_int(0))) {
		return var_data.clone()
	}
	mut var_comment_id := var_data.array_get(rt.new_string('comment_ID'))
	rt.call_function('update_comment_meta', [var_comment_id.clone(),
		rt.new_string('rating'),
		rt.new_int(rt.call_function('wp_unslash', [
			rt.get_superglobal('_POST').array_get(rt.new_string('rating')),
		]).to_i64())])
	return var_data.clone()
}

fn create_wc_meta_box_product_reviews(_args ...rt.PhpVal) &Class_WC_Meta_Box_Product_Reviews {
	mut obj := &Class_WC_Meta_Box_Product_Reviews{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Meta_Box_Product_Reviews) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'output' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Meta_Box_Product_Reviews.output(dispatch_arg_0)
			return rt.new_null()
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Meta_Box_Product_Reviews.save(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Meta_Box_Product_Reviews) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Box_Product_Reviews) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
