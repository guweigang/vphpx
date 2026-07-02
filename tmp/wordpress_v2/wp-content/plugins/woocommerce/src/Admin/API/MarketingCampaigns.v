import rt

struct Class_Automattic_WooCommerce_Admin_API_MarketingCampaigns {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc-admin')
	rest_base rt.PhpVal = rt.new_string('marketing/campaigns')
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingCampaigns) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{
					key: 'methods'
					val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable()
				},
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_MarketingCampaigns', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_MarketingCampaigns', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_MarketingCampaigns', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingCampaigns) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('settings'),
		rt.new_string('read'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot list resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingCampaigns) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_marketing_channels_service := rt.call_method(rt.call_function('wc_get_container',
		[]rt.PhpVal{}), 'get', [
		Class_Automattic_WooCommerce_Admin_Marketing_MarketingChannels.class(),
	])
	mut var_responses := rt.new_array()
	mut iter_1 := rt.call_method(var_marketing_channels_service, 'get_registered_channels',
		[]rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_channel := item_1.val
		mut iter_2 := rt.call_method(var_channel, 'get_campaigns', []rt.PhpVal{}).iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_campaign := item_2.val
			mut var_response := this.prepare_item_for_response(var_campaign.clone(),
				var_request.clone())
			var_responses.array_push(this.prepare_response_for_collection(var_response.clone()))
		}
	}
	mut var_page := var_request.array_get(rt.new_string('page'))
	mut var_items_per_page := var_request.array_get(rt.new_string('per_page'))
	mut var_offset := rt.mul(rt.sub(var_page, rt.new_int(1)), var_items_per_page)
	mut var_paginated_results := rt.call_function('array_slice', [
		var_responses.clone(), var_offset.clone(), var_items_per_page.clone()])
	mut var_response := rt.call_function('rest_ensure_response', [
		var_paginated_results.clone()])
	mut var_total_campaigns := rt.new_int(var_responses.clone().array_count())
	mut var_max_pages := rt.call_function('ceil', [
		rt.div(var_total_campaigns, var_items_per_page),
	])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		var_total_campaigns.clone()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int(var_max_pages.to_i64())])
	mut var_request_params := rt.call_method(var_request, 'get_query_params', []rt.PhpVal{})
	mut var_base := rt.call_function('add_query_arg', [
		rt.call_function('urlencode_deep', [var_request_params.clone()]),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('%s/%s'), this.namespace, this.rest_base]),
		]),
	])
	if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_page, rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
			var_prev_page = var_max_pages.clone()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_prev_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'),
			var_prev_link.clone()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_page)) {
		mut var_next_page := rt.add(var_page, rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [
			rt.new_string('page'), var_next_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'),
			var_next_link.clone()])
	}
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingCampaigns) get_formatted_price(var_price rt.PhpVal) rt.PhpVal {
	mut var_locale_info_all := rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/i18n/locale-info.php', '1')
	mut var_locale_index := rt.call_function('array_search', [
		rt.call_method(var_price, 'get_currency', []rt.PhpVal{}),
		rt.call_function('array_column', [var_locale_info_all.clone(),
			rt.new_string('currency_code')]),
		rt.new_bool(true),
	])
	mut var_locale :=
		rt.call_function('array_values', [var_locale_info_all.clone()]).array_get(var_locale_index)
	mut var_num_decimals := var_locale.array_get(rt.new_string('num_decimals'))
	mut var_currency_locales := var_locale.array_get(rt.new_string('locales'))
	mut var_user_locale := rt.call_function('get_user_locale', []rt.PhpVal{})
	mut var_currency_info := if !(var_currency_locales.array_get(var_user_locale)).is_null() {
		var_currency_locales.array_get(var_user_locale)
	} else {
		var_currency_locales.array_get(rt.new_string('default'))
	}
	mut var_currency_pos := var_currency_info.array_get(rt.new_string('currency_pos'))
	mut var_currency_formats := rt.create_array([
		rt.ArrayItem{ key: 'left', val: '%1$s%2$s' },
		rt.ArrayItem{ key: 'right', val: '%2$s%1$s' },
		rt.ArrayItem{ key: 'left_space', val: '%1$s&nbsp;%2$s' },
		rt.ArrayItem{ key: 'right_space', val: '%2$s&nbsp;%1$s' },
	])
	mut var_price_format := if !(var_currency_formats.array_get(var_currency_pos)).is_null() {
		var_currency_formats.array_get(var_currency_pos)
	} else {
		var_currency_formats.array_get(rt.new_string('left'))
	}
	mut var_price_value := rt.call_function('wc_format_decimal', [
		rt.call_method(var_price, 'get_value', []rt.PhpVal{}),
	])
	mut var_price_formatted := rt.call_function('wc_price', [
		var_price_value.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'currency', val: rt.call_method(var_price, 'get_currency',
				[]rt.PhpVal{}) },
			rt.ArrayItem{
				key: 'decimal_separator'
				val: var_currency_info.array_get(rt.new_string('decimal_sep'))
			},
			rt.ArrayItem{
				key: 'thousand_separator'
				val: var_currency_info.array_get(rt.new_string('thousand_sep'))
			},
			rt.ArrayItem{ key: 'decimals', val: var_num_decimals },
			rt.ArrayItem{ key: 'price_format', val: var_price_format },
		])])
	return rt.call_function('html_entity_decode', [
		rt.call_function('wp_strip_all_tags', [var_price_formatted.clone()]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingCampaigns) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'channel', val: rt.call_method(rt.call_method(rt.call_method(var_item,
			'get_type', []rt.PhpVal{}), 'get_channel', []rt.PhpVal{}), 'get_slug', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'title', val: rt.call_method(var_item, 'get_title', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'manage_url', val: rt.call_method(var_item, 'get_manage_url',
			[]rt.PhpVal{}) },
	])
	if rt.is_true(rt.new_bool(rt.instance_of(rt.call_method(var_item, 'get_cost', []rt.PhpVal{}),
		'Automattic_WooCommerce_Admin_Marketing_Price')))
	{
		var_data.array_set('cost', rt.create_array([
			rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_decimal', [
				rt.call_method(rt.call_method(var_item, 'get_cost', []rt.PhpVal{}), 'get_value',
					[]rt.PhpVal{}),
			]) },
			rt.ArrayItem{ key: 'currency', val: rt.call_method(rt.call_method(var_item, 'get_cost',
				[]rt.PhpVal{}), 'get_currency', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'formatted', val: this.get_formatted_price(rt.call_method(var_item,
				'get_cost', []rt.PhpVal{})) },
		]))
	}
	if rt.is_true(rt.new_bool(rt.instance_of(rt.call_method(var_item, 'get_sales', []rt.PhpVal{}),
		'Automattic_WooCommerce_Admin_Marketing_Price')))
	{
		var_data.array_set('sales', rt.create_array([
			rt.ArrayItem{ key: 'value', val: rt.call_function('wc_format_decimal', [
				rt.call_method(rt.call_method(var_item, 'get_sales', []rt.PhpVal{}), 'get_value',
					[]rt.PhpVal{}),
			]) },
			rt.ArrayItem{ key: 'currency', val: rt.call_method(rt.call_method(var_item,
				'get_sales', []rt.PhpVal{}), 'get_currency', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'formatted', val: this.get_formatted_price(rt.call_method(var_item,
				'get_sales', []rt.PhpVal{})) },
		]))
	}
	mut var_context := if !(var_request.array_get(rt.new_string('context'))).is_null() {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingCampaigns) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'marketing_campaign' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The unique identifier for the marketing campaign.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'channel', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The unique identifier for the marketing channel that this campaign belongs to.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'title', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Title of the marketing campaign.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'manage_url', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('URL to the campaign management page.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'cost', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Cost of the marketing campaign.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'value', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'currency', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'sales', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Sales of the marketing campaign.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'value', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
					rt.ArrayItem{ key: 'currency', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'view' },
						]) },
						rt.ArrayItem{ key: 'readonly', val: true },
					]) },
				]) },
			]) },
		]) },
	])
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingCampaigns) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_Controller.get_collection_params()
	var_params.array_unset(rt.new_string('search'))
	return var_params.clone()
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_marketingcampaigns(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_MarketingCampaigns {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_MarketingCampaigns{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc-admin')
		rest_base:     rt.new_string('marketing/campaigns')
	}
	return obj
}

fn create_wc_rest_controller(_args ...rt.PhpVal) &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingCampaigns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_formatted_price' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_formatted_price(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_MarketingCampaigns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_MarketingCampaigns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
