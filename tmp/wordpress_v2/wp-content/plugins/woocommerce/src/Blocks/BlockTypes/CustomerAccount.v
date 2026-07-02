import rt

pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount.text_only() string {
	return 'text_only'
}

pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount.icon_only() string {
	return 'icon_only'
}

pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount.display_alt() string {
	return 'alt'
}

pub fn Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount.display_line() string {
	return 'line'
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount {
	rt.PhpObjectBase
pub mut:
	block_name              rt.PhpVal = rt.new_string('customer-account')
	hooked_block_placements rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) initialize() {
	this.Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock.initialize()
	if rt.is_true(rt.call_function('version_compare', [
		rt.call_function('get_bloginfo', [rt.new_string('version')]),
		rt.new_string('6.5'),
		rt.new_string('>='),
	]))
	{
		rt.call_function('add_filter', [
			rt.new_string('hooked_block_woocommerce/customer-account'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount', [
					'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
				], &this) },
				rt.ArrayItem{ key: none, val: 'modify_hooked_block_attributes' },
			]),
			rt.new_int(10),
			rt.new_int(5),
		])
		rt.call_function('add_filter', [rt.new_string('hooked_block_types'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount', [
					'Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock',
				], &this) },
				rt.ArrayItem{ key: none, val: 'register_hooked_block' },
			]),
			rt.new_int(9), rt.new_int(4)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) modify_hooked_block_attributes(var_parsed_hooked_block rt.PhpVal, var_hooked_block_type rt.PhpVal, var_relative_position rt.PhpVal, var_parsed_anchor_block rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	var_parsed_hooked_block.array_get_mut('attrs').array_set('displayStyle', 'icon_only')
	var_parsed_hooked_block.array_get_mut('attrs').array_set('iconStyle', 'line')
	var_parsed_hooked_block.array_get_mut('attrs').array_set('iconClass',
		'wc-block-customer-account__account-icon')
	mut var_customer_account_block_font_size := rt.call_function('wp_get_global_styles', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'blocks' },
			rt.ArrayItem{ key: none, val: 'woocommerce/customer-account' },
			rt.ArrayItem{ key: none, val: 'typography' }, rt.ArrayItem{ key: none, val: 'fontSize' }]),
	])
	if !(var_customer_account_block_font_size.clone().is_string()) {
		mut var_navigation_block_font_size := rt.call_function('wp_get_global_styles', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'blocks' },
				rt.ArrayItem{ key: none, val: 'core/navigation' },
				rt.ArrayItem{ key: none, val: 'typography' },
				rt.ArrayItem{ key: none, val: 'fontSize' }]),
		])
		if rt.is_true(rt.new_bool(var_navigation_block_font_size.clone().is_string())) {
			var_parsed_hooked_block.array_get_mut('attrs').array_get_mut('style').array_get_mut('typography').array_set('fontSize',
				var_navigation_block_font_size.clone())
		}
	}
	return var_parsed_hooked_block.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) should_unhook_block(var_hooked_blocks rt.PhpVal, var_position rt.PhpVal, var_anchor_block rt.PhpVal, var_context rt.PhpVal) rt.PhpVal {
	mut var_context_mutated := var_context
	mut var_block_name := rt.new_string(
		(rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount', ['Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock'], &this), 'namespace')).str() +
		'/' + (this.block_name).str())
	mut var_block_is_hooked := rt.call_function('in_array', [
		var_block_name.clone(), var_hooked_blocks.clone(), rt.new_bool(true)])
	if rt.is_true(var_block_is_hooked) {
		mut var_active_theme := rt.call_method(rt.call_function('wp_get_theme', []rt.PhpVal{}),
			'get', [rt.new_string('Name')])
		mut var_exclude_themes := rt.create_array([
			rt.ArrayItem{ key: none, val: 'Twenty Twenty-Two' },
			rt.ArrayItem{ key: none, val: 'Twenty Twenty-Three' },
		])
		if rt.is_true(rt.call_function('in_array', [var_active_theme.clone(),
			var_exclude_themes.clone(), rt.new_bool(true)]))
		{
			mut var_key := rt.call_function('array_search', [
				var_block_name.clone(), var_hooked_blocks.clone(),
				rt.new_bool(true)])
			var_hooked_blocks.array_unset(var_key)
		}
	}
	return var_hooked_blocks.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) render(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) rt.PhpVal {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{}
	mut iife_result_0 := iife_temp_0.get_classes_and_styles_by_attributes(var_attributes.clone())
	mut var_classes_and_styles := iife_result_0
	mut var_has_myaccount_page := rt.call_function('get_option', [
		rt.new_string('woocommerce_myaccount_page_id'),
	])
	mut var_account_link := if rt.is_true(var_has_myaccount_page) { rt.call_function('wc_get_account_endpoint_url', [
			rt.new_string('dashboard'),
		]) } else { rt.call_function('wp_login_url', []rt.PhpVal{}) }
	mut var_has_dropdown := rt.new_bool(
		!(!rt.is_true(var_attributes.array_get(rt.new_string('hasDropdownNavigation'))))
		&& rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))
		&& rt.is_true(var_has_myaccount_page))
	mut var_aria_label := rt.new_string((if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount.icon_only(),
		var_attributes.array_get(rt.new_string('displayStyle'))))
	{
		' aria-label="' + (rt.call_function('esc_attr', [this.render_label()])).str() + '"'
	} else {
		''
	}).str())
	mut var_label_markup := rt.new_string((if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount.icon_only(),
		var_attributes.array_get(rt.new_string('displayStyle'))))
	{
		''
	} else {
		'<span class="label">' +
			(rt.call_function('wp_kses', [this.render_label(), rt.new_array()])).str() + '</span>'
	}).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_dropdown)))) {
		return rt.new_string(this.render_link(var_attributes.clone(),
			var_classes_and_styles.clone(), var_account_link.clone(), var_aria_label.clone(),
			var_label_markup.clone()))
	}
	return rt.new_string(this.render_dropdown(var_attributes.clone(),
		var_classes_and_styles.clone(), var_aria_label.clone(), var_label_markup.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) render_link(var_attributes rt.PhpVal, var_classes_and_styles rt.PhpVal, var_account_link rt.PhpVal, var_aria_label rt.PhpVal, var_label_markup rt.PhpVal) string {
	mut var_classes_and_styles_mutated := var_classes_and_styles
	mut var_account_link_mutated := var_account_link
	mut var_aria_label_mutated := var_aria_label
	mut var_label_markup_mutated := var_label_markup
	mut var_allowed_svg := this.get_allowed_svg()
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr',
		[var_classes_and_styles_mutated.array_get(rt.new_string('classes'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr',
		[var_classes_and_styles_mutated.array_get(rt.new_string('styles'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_account_link_mutated.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_aria_label_mutated)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses', [
		rt.new_string(this.render_icon(var_attributes.clone())),
		var_allowed_svg.clone(),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_label_markup_mutated)
	// unsupported statement: Stmt_InlineHTML
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) render_dropdown(var_attributes rt.PhpVal, var_classes_and_styles rt.PhpVal, var_aria_label rt.PhpVal, var_label_markup rt.PhpVal) string {
	mut var_classes_and_styles_mutated := var_classes_and_styles
	mut var_aria_label_mutated := var_aria_label
	mut var_label_markup_mutated := var_label_markup
	mut var_allowed_svg := this.get_allowed_svg()
	mut var_context := rt.create_array([
		rt.ArrayItem{ key: 'isDropdownOpen', val: false },
		rt.ArrayItem{ key: 'showAbove', val: false },
		rt.ArrayItem{ key: 'alignRight', val: false },
	])
	mut var_menu_items := rt.call_function('wc_get_account_menu_items', []rt.PhpVal{})
	mut var_dropdown_html := this.render_dropdown_menu(var_menu_items.clone())
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr',
		[var_classes_and_styles_mutated.array_get(rt.new_string('classes'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr',
		[var_classes_and_styles_mutated.array_get(rt.new_string('styles'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_interactivity_data_wp_context', [
		var_context.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_aria_label_mutated)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses', [
		rt.new_string(this.render_icon(var_attributes.clone())),
		var_allowed_svg.clone(),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_label_markup_mutated)
	// unsupported statement: Stmt_InlineHTML
	print(this.render_caret_icon())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr__', [rt.new_string('Account navigation'),
		rt.new_string('woocommerce')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_dropdown_html)
	// unsupported statement: Stmt_InlineHTML
	return (rt.call_function('ob_get_clean', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) render_dropdown_menu(var_menu_items rt.PhpVal) rt.PhpVal {
	mut var_menu_items_mutated := var_menu_items
	mut var_sections := rt.new_array()
	if var_menu_items_mutated.array_isset(rt.new_string('dashboard')) {
		var_sections.array_push(this.render_section(rt.create_array([
			rt.ArrayItem{
				key: 'dashboard'
				val: var_menu_items_mutated.array_get(rt.new_string('dashboard'))
			},
		])))
	}
	mut var_nav_items := rt.call_function('array_diff_key', [
		var_menu_items_mutated.clone(),
		rt.call_function('array_flip', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'dashboard' },
				rt.ArrayItem{ key: none, val: 'customer-logout' }]),
		])])
	if !(!rt.is_true(var_nav_items)) {
		var_sections.array_push(this.render_section(var_nav_items.clone()))
	}
	if var_menu_items_mutated.array_isset(rt.new_string('customer-logout')) {
		var_sections.array_push(this.render_section(rt.create_array([
			rt.ArrayItem{
				key: 'customer-logout'
				val: var_menu_items_mutated.array_get(rt.new_string('customer-logout'))
			},
		])))
	}
	return rt.call_function('implode', [
		rt.new_string('<div class="wc-block-customer-account__dropdown-divider"></div>'),
		var_sections.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) render_section(var_items rt.PhpVal) rt.PhpVal {
	mut var_output := rt.new_string('<div class="wc-block-customer-account__dropdown-section">')
	mut iter_1 := var_items.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_label := item_1.val
		mut var_endpoint := item_1.key
		var_output = rt.concat(var_output, this.render_menu_item(var_endpoint.clone(),
			var_label.clone()))
	}
	var_output = rt.concat(var_output, rt.new_string('</div>'))
	return var_output.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) render_menu_item(var_endpoint rt.PhpVal, var_label rt.PhpVal) string {
	mut var_url := rt.call_function('wc_get_account_endpoint_url', [
		var_endpoint.clone()])
	return '<a href="' + (rt.call_function('esc_url', [var_url.clone()])).str() +
		'" class="wc-block-customer-account__dropdown-item">' +
		(rt.call_function('esc_html', [var_label.clone()])).str() + '</a>'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) render_caret_icon() string {
	return '<svg class="wc-block-customer-account__caret" width="10" height="6" viewBox="0 0 10 6" fill="none" xmlns="http://www.w3.org/2000/svg">\n\t\t\t<path d="M1 1L5 5L9 1" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>\n\t\t</svg>'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) get_allowed_svg() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'svg', val: rt.create_array([
			rt.ArrayItem{ key: 'class', val: true },
			rt.ArrayItem{ key: 'xmlns', val: true },
			rt.ArrayItem{ key: 'width', val: true },
			rt.ArrayItem{ key: 'height', val: true },
			rt.ArrayItem{ key: 'viewbox', val: true },
		]) },
		rt.ArrayItem{ key: 'path', val: rt.create_array([
			rt.ArrayItem{ key: 'd', val: true },
			rt.ArrayItem{ key: 'fill', val: true },
			rt.ArrayItem{ key: 'fill-rule', val: true },
			rt.ArrayItem{ key: 'clip-rule', val: true },
		]) },
		rt.ArrayItem{ key: 'circle', val: rt.create_array([
			rt.ArrayItem{ key: 'cx', val: true },
			rt.ArrayItem{ key: 'cy', val: true },
			rt.ArrayItem{ key: 'r', val: true },
			rt.ArrayItem{ key: 'stroke', val: true },
			rt.ArrayItem{ key: 'stroke-width', val: true },
			rt.ArrayItem{ key: 'fill', val: true },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) render_icon(var_attributes rt.PhpVal) string {
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount.text_only(),
		var_attributes.array_get(rt.new_string('displayStyle'))))
	{
		return ''
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount.display_line(),
		var_attributes.array_get(rt.new_string('iconStyle'))))
	{
		return '<svg class="' +
			(var_attributes.array_get(rt.new_string('iconClass'))).str() + '" viewBox="1 1 29 29" fill="none" xmlns="http://www.w3.org/2000/svg">\n\t\t\t\t<circle\n\t\t\t\t\tcx="16"\n\t\t\t\t\tcy="10.5"\n\t\t\t\t\tr="3.5"\n\t\t\t\t\tstroke="currentColor"\n\t\t\t\t\tstroke-width="2"\n\t\t\t\t\tfill="none"\n\t\t\t\t/>\n\t\t\t\t<path\n\t\t\t\t\tfill-rule="evenodd"\n\t\t\t\t\tclip-rule="evenodd"\n\t\t\t\t\td="M11.5 18.5H20.5C21.8807 18.5 23 19.6193 23 21V25.5H25V21C25 18.5147 22.9853 16.5 20.5 16.5H11.5C9.01472 16.5 7 18.5147 7 21V25.5H9V21C9 19.6193 10.1193 18.5 11.5 18.5Z"\n\t\t\t\t\tfill="currentColor"\n\t\t\t\t/>\n\t\t\t</svg>'
	}
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Blocks_BlockTypes_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount.display_alt(),
		var_attributes.array_get(rt.new_string('iconStyle'))))
	{
		return '<svg class="' +
			(var_attributes.array_get(rt.new_string('iconClass'))).str() + '" xmlns="http://www.w3.org/2000/svg" viewBox="-4 -4 25 25">\n\t\t\t\t<path\n\t\t\t\t\td="M9 0C4.03579 0 0 4.03579 0 9C0 13.9642 4.03579 18 9 18C13.9642 18 18 13.9642 18 9C18 4.03579 13.9642 0 9 0ZM9 4.32C10.5347 4.32 11.7664 5.57056 11.7664 7.08638C11.7664 8.62109 10.5158 9.85277 9 9.85277C7.4653 9.85277 6.23362 8.60221 6.23362 7.08638C6.23362 5.57056 7.46526 4.32 9 4.32ZM9 10.7242C11.1221 10.7242 12.96 12.2021 13.7937 14.4189C12.5242 15.5559 10.8379 16.238 9 16.238C7.16207 16.238 5.49474 15.5369 4.20632 14.4189C5.05891 12.2021 6.87793 10.7242 9 10.7242Z"\n\t\t\t\t\tfill="currentColor"\n\t\t\t\t/>\n\t\t\t</svg>'
	}
	return '<svg class="' +
		(var_attributes.array_get(rt.new_string('iconClass'))).str() + '" xmlns="http://www.w3.org/2000/svg" viewBox="-5 -5 25 25">\n\t\t\t<path\n\t\t\t\tfill-rule="evenodd"\n\t\t\t\tclip-rule="evenodd"\n\t\t\t\td="M8.00009 8.34785C10.3096 8.34785 12.1819 6.47909 12.1819 4.17393C12.1819 1.86876 10.3096 0 8.00009 0C5.69055 0 3.81824 1.86876 3.81824 4.17393C3.81824 6.47909 5.69055 8.34785 8.00009 8.34785ZM0.333496 15.6522C0.333496 15.8444 0.489412 16 0.681933 16H15.3184C15.5109 16 15.6668 15.8444 15.6668 15.6522V14.9565C15.6668 12.1428 13.7821 9.73911 10.0912 9.73911H5.90931C2.21828 9.73911 0.333645 12.1428 0.333645 14.9565L0.333496 15.6522Z"\n\t\t\t\tfill="currentColor"\n\t\t\t/>\n\t\t</svg>'
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) render_label() rt.PhpVal {
	return if rt.is_true(rt.call_function('get_current_user_id', []rt.PhpVal{})) { rt.call_function('__', [
			rt.new_string('My Account'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [rt.new_string('Login'),
			rt.new_string('woocommerce')]) }
}

struct Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_blocktypes_customeraccount(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount{
		PhpObjectBase:           rt.PhpObjectBase{}
		block_name:              rt.new_string('customer-account')
		hooked_block_placements: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_blocktypes_abstractblock(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock {
	mut obj := &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_styleattributesutils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'modify_hooked_block_attributes' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.modify_hooked_block_attributes(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'should_unhook_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.should_unhook_block(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.render(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'render_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_string(this.render_link(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4))
		}
		'render_dropdown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_string(this.render_dropdown(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3))
		}
		'render_dropdown_menu' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render_dropdown_menu(dispatch_arg_0)
		}
		'render_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render_section(dispatch_arg_0)
		}
		'render_menu_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.render_menu_item(dispatch_arg_0, dispatch_arg_1))
		}
		'render_caret_icon' {
			return rt.new_string(this.render_caret_icon())
		}
		'get_allowed_svg' {
			return this.get_allowed_svg()
		}
		'render_icon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.render_icon(dispatch_arg_0))
		}
		'render_label' {
			return this.render_label()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'block_name' { return this.block_name }
		'hooked_block_placements' { return this.hooked_block_placements }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_CustomerAccount) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'block_name' {
			this.block_name = val
			return true
		}
		'hooked_block_placements' {
			this.hooked_block_placements = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_BlockTypes_AbstractBlock) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_StyleAttributesUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
