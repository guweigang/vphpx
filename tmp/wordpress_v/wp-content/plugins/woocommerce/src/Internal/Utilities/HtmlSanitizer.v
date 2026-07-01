import rt

pub fn Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer.low_html_balanced_tags_no_links() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'pre_processors', val: rt.create_array([rt.ArrayItem{ key: none, val: 'stripslashes' }, rt.ArrayItem{ key: none, val: 'force_balance_tags' }]) }, rt.ArrayItem{ key: 'wp_kses_rules', val: rt.create_array([rt.ArrayItem{ key: 'br', val: true }, rt.ArrayItem{ key: 'img', val: rt.create_array([rt.ArrayItem{ key: 'alt', val: true }, rt.ArrayItem{ key: 'class', val: true }, rt.ArrayItem{ key: 'src', val: true }, rt.ArrayItem{ key: 'title', val: true }]) }, rt.ArrayItem{ key: 'p', val: rt.create_array([rt.ArrayItem{ key: 'class', val: true }]) }, rt.ArrayItem{ key: 'span', val: rt.create_array([rt.ArrayItem{ key: 'class', val: true }, rt.ArrayItem{ key: 'title', val: true }]) }]) }])
}
struct Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer) styled_post_content(html string) string {
	mut html_mutated := html
	mut var_rules := rt.call_function('wp_kses_allowed_html', [rt.new_string('post')])
	var_rules.array_set('style', true)
	return (rt.call_function('wp_kses', [rt.new_string(html_mutated).dup(), var_rules.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer) sanitize(html string, mut var_sanitizer_rules Class_Automattic_WooCommerce_Internal_Utilities_array) string {
	mut html_mutated := html
	if rt.is_true(rt.new_bool(var_sanitizer_rules.array_isset(rt.new_string('pre_processors')) && rt.is_true(rt.new_bool(var_sanitizer_rules.array_get('pre_processors').is_array())))) {
		html_mutated = this.apply_string_callbacks(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](var_sanitizer_rules.array_get('pre_processors')), html_mutated)
	}
	mut var_kses_rules := if rt.is_true(rt.new_bool(var_sanitizer_rules.array_isset(rt.new_string('wp_kses_rules')) && rt.is_true(rt.new_bool(var_sanitizer_rules.array_get('wp_kses_rules').is_array())))) { var_sanitizer_rules.array_get('wp_kses_rules') } else { rt.new_array() }
	return (rt.call_function('wp_kses', [rt.new_string(html_mutated).dup(), var_kses_rules.dup()])).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer) apply_string_callbacks(mut var_callbacks Class_Automattic_WooCommerce_Internal_Utilities_array, string string) string {
	mut string_mutated := string
	{
		mut iter_1 := var_callbacks.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_callback := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_callback.dup()]))))) {
				rt.call_function('_doing_it_wrong', [@STRUCT + '::apply', rt.call_function('esc_html__', [rt.new_string('String processors must be an array of valid callbacks.'), rt.new_string('woocommerce')]), rt.call_function('esc_html', [rt.get_property(rt.call_function('WC', []rt.PhpVal{}), 'version')])])
				return ''
			}
			string_mutated = (// unsupported expression: Expr_Cast_String).str()
		}
	}
	return string_mutated
}

fn create_automattic_woocommerce_internal_utilities_htmlsanitizer() &Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'styled_post_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.styled_post_content(dispatch_arg_0))
		}
		'sanitize' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.sanitize(dispatch_arg_0, mut dispatch_arg_1))
		}
		'apply_string_callbacks' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Utilities_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.apply_string_callbacks(mut dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_internal_utilities_htmlsanitizer_php() {
}
