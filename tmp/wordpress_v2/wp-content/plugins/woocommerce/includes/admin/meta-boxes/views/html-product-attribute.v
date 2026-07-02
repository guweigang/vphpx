import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_attribute := rt.new_null()
	mut var_metabox_class := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_attribute, 'get_taxonomy', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('implode', [rt.new_string(' '), var_metabox_class.clone()]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_method(var_attribute, 'get_position', []rt.PhpVal{}),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Click to toggle'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [
		rt.new_string('Drag and drop to set admin attribute order'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Remove'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.new_string((if rt.is_true(rt.identical(rt.call_method(var_attribute, 'get_name',
			[]rt.PhpVal{}), rt.new_string('')))
		{
			' placeholder'
		} else {
			''
		}).str()),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}), rt.new_string(''))))) { rt.call_function('wc_attribute_label', [
			rt.call_method(var_attribute, 'get_name', []rt.PhpVal{}),
		]) } else { rt.call_function('__', [
			rt.new_string('New attribute'),
			rt.new_string('woocommerce'),
		]) }]))
	// unsupported statement: Stmt_InlineHTML
	rt.include_file(@DIR + '/html-product-attribute-inner.php', '3')
	// unsupported statement: Stmt_InlineHTML
}
