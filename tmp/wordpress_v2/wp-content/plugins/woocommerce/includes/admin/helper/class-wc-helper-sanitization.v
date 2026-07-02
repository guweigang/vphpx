import rt

struct Class_WC_Helper_Sanitization {
	rt.PhpObjectBase
}

fn Class_WC_Helper_Sanitization.sanitize_css(var_css rt.PhpVal) string {
	mut var_css_mutated := var_css
	if !(var_css_mutated.clone().is_string()) {
		return ''
	}
	var_css_mutated = rt.call_function('preg_replace', [
		rt.new_string('/@import\\s+[^;]+;?/'),
		rt.new_string(''),
		var_css_mutated.clone(),
	])
	var_css_mutated = rt.call_function('preg_replace', [
		rt.new_string('/url\\s*\\(\\s*([\'"]?)data:/i'),
		rt.new_string('url($1invalid:'),
		var_css_mutated.clone(),
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_matches := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_url := var_matches.array_get(rt.new_int(2))
		mut var_quote := var_matches.array_get(rt.new_int(1))
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('/^https?:\\/\\/(([\\w-]+\\.)*woocommerce\\.com|' +
				'([\\w-]+\\.)*woocommerce\\.test|' + '([\\w-]+\\.)*WordPress\\.com|' +
				'([\\w-]+\\.)*wp\\.com)/ix'),
			var_url.clone(),
		]))
		{
			return 'url(${var_quote.to_string()}${var_url.to_string()}${var_quote.to_string()})'
		} else {
			return 'url(${var_quote.to_string()}#blocked-url${var_quote.to_string()})'
		}
		return rt.new_null()
	}
	var_css_mutated = rt.call_function('preg_replace_callback', [
		rt.new_string('/url\\s*\\(\\s*([\'"]?)(https?:\\/\\/[^)]+)\\1\\s*\\)/i'),
		rt.new_closure(closure_1_fn),
		var_css_mutated.clone(),
	])
	var_css_mutated = rt.call_function('str_replace', [rt.new_string('*'),
		rt.new_string('__PRESERVED_ASTERISK__'), var_css_mutated.clone()])
	var_css_mutated = rt.call_function('wp_strip_all_tags', [
		var_css_mutated.clone()])
	var_css_mutated = rt.call_function('preg_replace', [
		rt.new_string('/\\s*expression\\s*\\(.*?\\)/'),
		rt.new_string(''),
		var_css_mutated.clone(),
	])
	var_css_mutated = rt.call_function('preg_replace', [
		rt.new_string('/\\s*javascript\\s*:/'),
		rt.new_string(''),
		var_css_mutated.clone(),
	])
	var_css_mutated = rt.call_function('preg_replace', [
		rt.new_string('/(behavior|eval|calc|mocha)(\\s*:|\\s*\\()/i'),
		rt.new_string('blocked'),
		var_css_mutated.clone(),
	])
	var_css_mutated = rt.call_function('str_replace', [
		rt.new_string('__PRESERVED_ASTERISK__'),
		rt.new_string('*'),
		var_css_mutated.clone(),
	])
	var_css_mutated = rt.call_function('substr', [var_css_mutated.clone(),
		rt.new_int(0), rt.new_int(100000)])
	return var_css_mutated.str()
}

fn Class_WC_Helper_Sanitization.sanitize_html(var_html rt.PhpVal) rt.PhpVal {
	mut var_allowed_html := rt.call_function('wp_kses_allowed_html', [
		rt.new_string('post'),
	])
	mut var_svg_tags := Class_WC_Helper_Sanitization.wc_kses_safe_svg_tags()
	var_allowed_html = rt.call_function('array_merge', [var_allowed_html.clone(),
		var_svg_tags.clone()])
	return rt.call_function('wp_kses', [
		Class_WC_Helper_Sanitization.wc_pre_sanitize_svg(var_html.clone()),
		var_allowed_html.clone(),
	])
}

fn Class_WC_Helper_Sanitization.wc_pre_sanitize_svg(var_content rt.PhpVal) rt.PhpVal {
	mut var_content_mutated := var_content
	var_content_mutated = rt.call_function('preg_replace', [
		rt.new_string('/xlink:href\\s*=\\s*(["\'])\\s*javascript:.*?\\1/i'),
		rt.new_string(''),
		var_content_mutated.clone(),
	])
	var_content_mutated = rt.call_function('preg_replace', [
		rt.new_string('/<foreignObject\\b[^>]*>.*?<\\/foreignObject>/is'),
		rt.new_string(''),
		var_content_mutated.clone(),
	])
	return var_content_mutated.clone()
}

fn Class_WC_Helper_Sanitization.wc_kses_safe_svg_tags() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'svg', val: rt.create_array([
			rt.ArrayItem{ key: 'class', val: true },
			rt.ArrayItem{ key: 'aria-hidden', val: true },
			rt.ArrayItem{ key: 'aria-labelledby', val: true },
			rt.ArrayItem{ key: 'role', val: true },
			rt.ArrayItem{ key: 'xmlns', val: true },
			rt.ArrayItem{ key: 'width', val: true },
			rt.ArrayItem{ key: 'height', val: true },
			rt.ArrayItem{ key: 'viewbox', val: true },
			rt.ArrayItem{ key: 'viewBox', val: true },
			rt.ArrayItem{ key: 'preserveAspectRatio', val: true },
			rt.ArrayItem{ key: 'fill', val: true },
			rt.ArrayItem{ key: 'stroke', val: true },
			rt.ArrayItem{ key: 'stroke-width', val: true },
			rt.ArrayItem{ key: 'stroke-linecap', val: true },
			rt.ArrayItem{ key: 'stroke-linejoin', val: true },
			rt.ArrayItem{ key: 'onload', val: false },
			rt.ArrayItem{ key: 'onclick', val: false },
		]) },
		rt.ArrayItem{ key: 'g', val: rt.create_array([
			rt.ArrayItem{ key: 'fill', val: true },
			rt.ArrayItem{ key: 'transform', val: true },
			rt.ArrayItem{ key: 'stroke', val: true },
		]) },
		rt.ArrayItem{ key: 'title', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: true },
		]) },
		rt.ArrayItem{ key: 'path', val: rt.create_array([
			rt.ArrayItem{ key: 'd', val: true },
			rt.ArrayItem{ key: 'fill', val: true },
			rt.ArrayItem{ key: 'transform', val: true },
			rt.ArrayItem{ key: 'stroke', val: true },
			rt.ArrayItem{ key: 'stroke-width', val: true },
			rt.ArrayItem{ key: 'stroke-linecap', val: true },
			rt.ArrayItem{ key: 'stroke-linejoin', val: true },
		]) },
		rt.ArrayItem{ key: 'polyline', val: rt.create_array([
			rt.ArrayItem{ key: 'points', val: true },
			rt.ArrayItem{ key: 'fill', val: true },
			rt.ArrayItem{ key: 'stroke', val: true },
			rt.ArrayItem{ key: 'stroke-width', val: true },
		]) },
		rt.ArrayItem{ key: 'polygon', val: rt.create_array([
			rt.ArrayItem{ key: 'points', val: true },
			rt.ArrayItem{ key: 'fill', val: true },
			rt.ArrayItem{ key: 'stroke', val: true },
			rt.ArrayItem{ key: 'stroke-width', val: true },
		]) },
		rt.ArrayItem{ key: 'circle', val: rt.create_array([
			rt.ArrayItem{ key: 'cx', val: true },
			rt.ArrayItem{ key: 'cy', val: true },
			rt.ArrayItem{ key: 'r', val: true },
			rt.ArrayItem{ key: 'fill', val: true },
			rt.ArrayItem{ key: 'stroke', val: true },
			rt.ArrayItem{ key: 'stroke-width', val: true },
		]) },
		rt.ArrayItem{ key: 'rect', val: rt.create_array([
			rt.ArrayItem{ key: 'x', val: true },
			rt.ArrayItem{ key: 'y', val: true },
			rt.ArrayItem{ key: 'width', val: true },
			rt.ArrayItem{ key: 'height', val: true },
			rt.ArrayItem{ key: 'fill', val: true },
			rt.ArrayItem{ key: 'stroke', val: true },
			rt.ArrayItem{ key: 'stroke-width', val: true },
			rt.ArrayItem{ key: 'rx', val: true },
			rt.ArrayItem{ key: 'ry', val: true },
		]) },
		rt.ArrayItem{ key: 'line', val: rt.create_array([
			rt.ArrayItem{ key: 'x1', val: true },
			rt.ArrayItem{ key: 'y1', val: true },
			rt.ArrayItem{ key: 'x2', val: true },
			rt.ArrayItem{ key: 'y2', val: true },
			rt.ArrayItem{ key: 'stroke', val: true },
			rt.ArrayItem{ key: 'stroke-width', val: true },
		]) },
		rt.ArrayItem{ key: 'defs', val: rt.new_array() },
		rt.ArrayItem{ key: 'linearGradient', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: true },
			rt.ArrayItem{ key: 'x1', val: true },
			rt.ArrayItem{ key: 'y1', val: true },
			rt.ArrayItem{ key: 'x2', val: true },
			rt.ArrayItem{ key: 'y2', val: true },
			rt.ArrayItem{ key: 'gradientUnits', val: true },
		]) },
		rt.ArrayItem{ key: 'radialGradient', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: true },
			rt.ArrayItem{ key: 'cx', val: true },
			rt.ArrayItem{ key: 'cy', val: true },
			rt.ArrayItem{ key: 'r', val: true },
			rt.ArrayItem{ key: 'gradientUnits', val: true },
		]) },
		rt.ArrayItem{ key: 'stop', val: rt.create_array([
			rt.ArrayItem{ key: 'offset', val: true },
			rt.ArrayItem{ key: 'stop-color', val: true },
			rt.ArrayItem{ key: 'stop-opacity', val: true },
			rt.ArrayItem{ key: 'style', val: false },
		]) },
	])
}

fn create_wc_helper_sanitization(_args ...rt.PhpVal) &Class_WC_Helper_Sanitization {
	mut obj := &Class_WC_Helper_Sanitization{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Helper_Sanitization) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'sanitize_css' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WC_Helper_Sanitization.sanitize_css(dispatch_arg_0))
		}
		'sanitize_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper_Sanitization.sanitize_html(dispatch_arg_0)
		}
		'wc_pre_sanitize_svg' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Helper_Sanitization.wc_pre_sanitize_svg(dispatch_arg_0)
		}
		'wc_kses_safe_svg_tags' {
			return Class_WC_Helper_Sanitization.wc_kses_safe_svg_tags()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Helper_Sanitization) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Helper_Sanitization) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
