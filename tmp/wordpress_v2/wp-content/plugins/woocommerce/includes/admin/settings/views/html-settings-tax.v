import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_current_class := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Search&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if rt.get_superglobal('_GET').array_isset(rt.new_string('s')) { rt.call_function('esc_attr', [
			rt.get_superglobal('_GET').array_get(rt.new_string('s')),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('"%s" tax rates'),
			rt.new_string('woocommerce')]),
		if rt.is_true(var_current_class) { rt.call_function('esc_html', [
				var_current_class.clone()]) } else { rt.call_function('__', [
				rt.new_string('Standard'), rt.new_string('woocommerce')]) },
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Country&nbsp;code'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('A 2 digit country code, e.g. US. Leave blank to apply to all.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('State code'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('A 2 digit state code, e.g. AL. Leave blank to apply to all.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Postcode / ZIP'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('Postcode for this rule. Semi-colon (;) separate multiple values. Leave blank to apply to all areas. Wildcards (*) and ranges for numeric postcodes (e.g. 12345...12350) can also be used.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('City'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('Cities for this rule. Semi-colon (;) separate multiple values. Leave blank to apply to all cities.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Rate&nbsp;%'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('Enter a tax rate (percentage) to 4 decimal places.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Tax name'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [rt.new_string('Enter a name for this tax rate.'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Priority'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('Choose a priority for this tax rate. Only 1 matching rate per priority will be used. To define multiple tax rates for a single area you need to specify a different priority per rate.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Compound'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('Choose whether or not this is a compound rate. Compound tax rates are applied on top of other tax rates.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Shipping'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wc_help_tip', [
		rt.call_function('__', [
			rt.new_string('Choose whether or not this tax rate also gets applied to shipping.'),
			rt.new_string('woocommerce'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Insert row'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Remove selected row(s)'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Export CSV'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('admin_url', [
		rt.new_string('admin.php?import=woocommerce_tax_rate_csv'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Import CSV'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Loading&hellip;'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_attr__', [rt.new_string('Tax rate ID: %s'),
			rt.new_string('woocommerce')]),
		rt.new_string('{{ data.tax_rate_id }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('No matching tax rates found.'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('__', [rt.new_string('%s items'), rt.new_string('woocommerce')]),
		rt.new_string('{{ data.qty_rates }}'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('First page'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Previous page'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Current page'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('printf', [
		rt.call_function('esc_html_x', [rt.new_string('%1$s of %2$s'),
			rt.new_string('Pagination'), rt.new_string('woocommerce')]),
		rt.new_string('<input class="current-page" id="current-page-selector" type="text" name="paged" value="{{ data.current_page }}" size="<# print( data.qty_pages.toString().length ) #>" aria-describedby="table-paging">'),
		rt.new_string('<span class="total-pages">{{ data.qty_pages }}</span>'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Next page'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Last page'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}
