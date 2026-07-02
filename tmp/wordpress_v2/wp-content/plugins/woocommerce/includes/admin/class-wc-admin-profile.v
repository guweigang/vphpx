import rt

struct Class_WC_Admin_Profile {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Profile) construct() {
	rt.call_function('add_action', [rt.new_string('show_user_profile'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Profile', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_customer_meta_fields' },
		])])
	rt.call_function('add_action', [rt.new_string('edit_user_profile'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Profile', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_customer_meta_fields' },
		])])
	rt.call_function('add_action', [rt.new_string('personal_options_update'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Profile', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'save_customer_meta_fields' },
		])])
	rt.call_function('add_action', [rt.new_string('edit_user_profile_update'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Profile', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'save_customer_meta_fields' },
		])])
}

fn (mut this Class_WC_Admin_Profile) get_customer_meta_fields() rt.PhpVal {
	mut var_show_fields := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_customer_meta_fields'),
		rt.create_array([
			rt.ArrayItem{ key: 'billing', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Customer billing address'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'fields', val: rt.create_array([
					rt.ArrayItem{ key: 'billing_first_name', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('First name'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'billing_last_name', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Last name'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'billing_company', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Company'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'billing_address_1', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Address line 1'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'billing_address_2', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Address line 2'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'billing_city', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('City'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'billing_postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Postcode / ZIP'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'billing_country', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Country / Region'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
						rt.ArrayItem{ key: 'class', val: 'js_field-country' },
						rt.ArrayItem{ key: 'type', val: 'select' },
						rt.ArrayItem{ key: 'options', val: rt.add(rt.create_array([
							rt.ArrayItem{ key: '', val: rt.call_function('__', [
								rt.new_string('Select a country / region&hellip;'),
								rt.new_string('woocommerce'),
							]) },
						]), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
							'countries'), 'get_allowed_countries', []rt.PhpVal{})) },
					]) },
					rt.ArrayItem{ key: 'billing_state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('State / County'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('State / County or state code'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'class', val: 'js_field-state' },
					]) },
					rt.ArrayItem{ key: 'billing_phone', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Phone'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'billing_email', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Email address'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'shipping', val: rt.create_array([
				rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
					rt.new_string('Customer shipping address'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'fields', val: rt.create_array([
					rt.ArrayItem{ key: 'copy_billing', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Copy from billing address'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
						rt.ArrayItem{ key: 'class', val: 'js_copy-billing' },
						rt.ArrayItem{ key: 'type', val: 'button' },
						rt.ArrayItem{ key: 'text', val: rt.call_function('__', [
							rt.new_string('Copy'),
							rt.new_string('woocommerce'),
						]) },
					]) },
					rt.ArrayItem{ key: 'shipping_first_name', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('First name'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'shipping_last_name', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Last name'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'shipping_company', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Company'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'shipping_address_1', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Address line 1'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'shipping_address_2', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Address line 2'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'shipping_city', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('City'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'shipping_postcode', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Postcode / ZIP'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
					rt.ArrayItem{ key: 'shipping_country', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Country / Region'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
						rt.ArrayItem{ key: 'class', val: 'js_field-country' },
						rt.ArrayItem{ key: 'type', val: 'select' },
						rt.ArrayItem{ key: 'options', val: rt.add(rt.create_array([
							rt.ArrayItem{ key: '', val: rt.call_function('__', [
								rt.new_string('Select a country / region&hellip;'),
								rt.new_string('woocommerce'),
							]) },
						]), rt.call_method(rt.get_property(rt.call_function('WC', []rt.PhpVal{}),
							'countries'), 'get_allowed_countries', []rt.PhpVal{})) },
					]) },
					rt.ArrayItem{ key: 'shipping_state', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('State / County'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('State / County or state code'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'class', val: 'js_field-state' },
					]) },
					rt.ArrayItem{ key: 'shipping_phone', val: rt.create_array([
						rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
							rt.new_string('Phone'),
							rt.new_string('woocommerce'),
						]) },
						rt.ArrayItem{ key: 'description', val: '' },
					]) },
				]) },
			]) },
		]),
	])
	return var_show_fields.clone()
}

fn (mut this Class_WC_Admin_Profile) add_customer_meta_fields(var_user rt.PhpVal) {
	mut var_user_mutated := var_user
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_current_user_can_edit_customer_meta_fields'),
		rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]),
		rt.get_property(var_user_mutated, 'ID'),
	])))))
	{
		return
	}
	mut var_show_fields := this.get_customer_meta_fields()
	mut iter_1 := var_show_fields.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_fieldset := item_1.val
		mut var_fieldset_key := item_1.key
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(var_fieldset.array_get(rt.new_string('title')))
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('esc_attr', [
			rt.new_string('fieldset-' + var_fieldset_key.str()),
		]))
		// unsupported statement: Stmt_InlineHTML
		mut iter_2 := var_fieldset.array_get(rt.new_string('fields')).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_field := item_2.val
			mut var_key := item_2.key
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [
				var_field.array_get(rt.new_string('label')),
			]))
			// unsupported statement: Stmt_InlineHTML
			if !(!rt.is_true(var_field.array_get(rt.new_string('type'))))
				&& rt.is_true(rt.identical(rt.new_string('select'), var_field.array_get(rt.new_string('type')))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(if var_field.array_isset(rt.new_string('class')) { rt.call_function('esc_attr', [
						var_field.array_get(rt.new_string('class')),
					]) } else { rt.new_string('') })
				// unsupported statement: Stmt_InlineHTML
				mut var_selected := rt.call_function('esc_attr', [
					rt.call_function('get_user_meta', [
						rt.get_property(var_user_mutated, 'ID'),
						var_key.clone(),
						rt.new_bool(true),
					]),
				])
				mut iter_3 := var_field.array_get(rt.new_string('options')).iterator()
				for {
					item_3 := iter_3.next() or { break }
					mut var_option_value := item_3.val
					mut var_option_key := item_3.key
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_attr', [
						var_option_key.clone()]))
					// unsupported statement: Stmt_InlineHTML
					rt.call_function('selected', [var_selected.clone(),
						var_option_key.clone(), rt.new_bool(true)])
					// unsupported statement: Stmt_InlineHTML
					rt.echo_val(rt.call_function('esc_html', [
						var_option_value.clone()]))
					// unsupported statement: Stmt_InlineHTML
				}
				// unsupported statement: Stmt_InlineHTML
			} else if !(!rt.is_true(var_field.array_get(rt.new_string('type'))))
				&& rt.is_true(rt.identical(rt.new_string('checkbox'), var_field.array_get(rt.new_string('type')))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					var_field.array_get(rt.new_string('class')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('checked', [
					rt.new_int((rt.call_function('get_user_meta', [
						rt.get_property(var_user_mutated, 'ID'),
						var_key.clone(),
						rt.new_bool(true),
					])).to_i64()),
					rt.new_int(1),
					rt.new_bool(true),
				])
				// unsupported statement: Stmt_InlineHTML
			} else if !(!rt.is_true(var_field.array_get(rt.new_string('type'))))
				&& rt.is_true(rt.identical(rt.new_string('button'), var_field.array_get(rt.new_string('type')))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					var_field.array_get(rt.new_string('class')),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [
					var_field.array_get(rt.new_string('text')),
				]))
				// unsupported statement: Stmt_InlineHTML
			} else {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_key.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [
					this.get_user_meta(rt.get_property(var_user_mutated, 'ID'), var_key.clone()),
				]))
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(if !(!rt.is_true(var_field.array_get(rt.new_string('class')))) { rt.call_function('esc_attr', [
						var_field.array_get(rt.new_string('class')),
					]) } else { rt.new_string('regular-text') })
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
			if !(!rt.is_true(var_field.array_get(rt.new_string('description')))) {
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('wp_kses_post', [
					var_field.array_get(rt.new_string('description')),
				]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
}

fn (mut this Class_WC_Admin_Profile) save_customer_meta_fields(var_user_id rt.PhpVal) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_current_user_can_edit_customer_meta_fields'),
		rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]),
		var_user_id.clone(),
	])))))
	{
		return
	}
	mut var_save_fields := this.get_customer_meta_fields()
	mut iter_4 := var_save_fields.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_fieldset := item_4.val
		mut var_fieldset_type := item_4.key
		mut iter_5 := var_fieldset.array_get(rt.new_string('fields')).iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_field := item_5.val
			mut var_key := item_5.key
			if var_field.array_isset(rt.new_string('type'))
				&& rt.is_true(rt.identical(rt.new_string('checkbox'), var_field.array_get(rt.new_string('type')))) {
				rt.call_function('update_user_meta', [var_user_id.clone(),
					var_key.clone(), rt.new_bool(rt.get_superglobal('_POST').array_isset(var_key))])
			} else if rt.get_superglobal('_POST').array_isset(var_key) {
				rt.call_function('update_user_meta', [var_user_id.clone(),
					var_key.clone(),
					rt.call_function('wc_clean', [
						rt.get_superglobal('_POST').array_get(var_key)])])
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			var_fieldset_type.clone(),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'billing' },
				rt.ArrayItem{ key: none, val: 'shipping' },
			]),
			rt.new_bool(true)])))))
		{
			continue
		}
		mut var_address_type := var_fieldset_type
		rt.call_function('do_action', [
			rt.new_string('woocommerce_customer_save_address'),
			var_user_id.clone(),
			var_address_type.clone(),
		])
	}
}

fn (mut this Class_WC_Admin_Profile) get_user_meta(var_user_id rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_value := rt.call_function('get_user_meta', [var_user_id.clone(),
		var_key.clone(), rt.new_bool(true)])
	mut var_existing_fields := ['billing_first_name', 'billing_last_name']
	if rt.is_true(rt.new_bool(!(rt.is_true(var_value))))
		&& rt.is_true(rt.call_function('in_array', [var_key.clone(), rt.create_array_from_list(var_existing_fields)])) {
		var_value = rt.call_function('get_user_meta', [var_user_id.clone(),
			rt.call_function('str_replace', [rt.new_string('billing_'),
				rt.new_string(''), var_key.clone()]),
			rt.new_bool(true)])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_value))))
		&& rt.is_true(rt.identical(rt.new_string('billing_email'), var_key)) {
		mut var_user := rt.call_function('get_userdata', [var_user_id.clone()])
		var_value = rt.get_property(var_user, 'user_email')
	}
	return var_value.clone()
}

fn create_wc_admin_profile() &Class_WC_Admin_Profile {
	mut obj := &Class_WC_Admin_Profile{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn (mut this Class_WC_Admin_Profile) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_customer_meta_fields' {
			return this.get_customer_meta_fields()
		}
		'add_customer_meta_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_customer_meta_fields(dispatch_arg_0)
			return rt.new_null()
		}
		'save_customer_meta_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.save_customer_meta_fields(dispatch_arg_0)
			return rt.new_null()
		}
		'get_user_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_user_meta(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Profile) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Profile) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Admin_Profile'),
		rt.new_bool(false),
	])))))
	{
	}
	return rt.new_object('WC_Admin_Profile', []string{}, create_wc_admin_profile())
}
