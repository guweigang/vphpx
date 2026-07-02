import rt

struct Class_WC_REST_System_Status_Tools_V2_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v2')
	rest_base rt.PhpVal = rt.new_string('system_status/tools')
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\w-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('system_status'),
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

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('system_status'),
		rt.new_string('read'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot view this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('system_status'),
		rt.new_string('edit'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_update'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot update resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_tools() rt.PhpVal {
	mut var_tools := rt.create_array([
		rt.ArrayItem{ key: 'clear_transients', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('WooCommerce transients'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Clear transients'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This tool will clear the product/shop transients cache.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'clear_expired_transients', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Expired transients'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Clear transients'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This tool will clear ALL expired transients from WordPress.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'delete_orphaned_variations', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Orphaned variations'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Delete orphaned variations'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This tool will delete all variations which have no parent.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'clear_expired_download_permissions', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Used-up download permissions'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Clean up download permissions'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This tool will delete expired download permissions and permissions with 0 remaining downloads.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'regenerate_product_lookup_tables', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Product lookup tables'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Regenerate'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This tool will regenerate product lookup table data. This process may take a while.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'repair_coupons_lookup_table', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Coupons lookup table'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Repair'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This tool will repair the coupons lookup table data with missing discount amounts. This process may take a while.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'recount_terms', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Term counts'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Recount terms'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This tool will recount product terms - useful when changing your settings in a way which hides products from the catalog.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'reset_roles', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Capabilities'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Reset capabilities'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This tool will reset the admin, customer and shop_manager roles to default. Use this if your users cannot access all of the WooCommerce admin pages.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'clear_sessions', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Clear customer sessions'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Clear'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
				rt.new_string('<strong class="red">%1$s</strong> %2$s'),
				rt.call_function('__', [
					rt.new_string('Note:'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('__', [
					rt.new_string('This tool will delete all customer session data from the database, including current carts and saved carts in the database.'),
					rt.new_string('woocommerce'),
				]),
			]) },
		]) },
		rt.ArrayItem{ key: 'clear_template_cache', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Clear template cache'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Clear'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
				rt.new_string('<strong class="red">%1$s</strong> %2$s'),
				rt.call_function('__', [
					rt.new_string('Note:'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('__', [
					rt.new_string('This tool will empty the template cache.'),
					rt.new_string('woocommerce'),
				]),
			]) },
		]) },
		rt.ArrayItem{ key: 'clear_system_status_theme_info_cache', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Clear system status theme info cache'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Clear'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
				rt.new_string('<strong class="red">%1$s</strong> %2$s'),
				rt.call_function('__', [
					rt.new_string('Note:'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('__', [
					rt.new_string('This tool will empty the system status theme info cache.'),
					rt.new_string('woocommerce'),
				]),
			]) },
		]) },
		rt.ArrayItem{ key: 'install_pages', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Create default WooCommerce pages'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Create pages'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
				rt.new_string('<strong class="red">%1$s</strong> %2$s'),
				rt.call_function('__', [
					rt.new_string('Note:'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('__', [
					rt.new_string('This tool will install all the missing WooCommerce pages. Pages already defined and set up will not be replaced.'),
					rt.new_string('woocommerce'),
				]),
			]) },
		]) },
		rt.ArrayItem{ key: 'delete_taxes', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Delete WooCommerce tax rates'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Delete tax rates'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
				rt.new_string('<strong class="red">%1$s</strong> %2$s'),
				rt.call_function('__', [
					rt.new_string('Note:'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('__', [
					rt.new_string('This option will delete ALL of your tax rates, use with caution. This action cannot be reversed.'),
					rt.new_string('woocommerce'),
				]),
			]) },
		]) },
		rt.ArrayItem{ key: 'regenerate_thumbnails', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Regenerate shop thumbnails'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Regenerate'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This will regenerate all shop thumbnails to match your theme and/or image settings.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: 'db_update_routine', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Update database'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Update database'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
				rt.new_string('<strong class="red">%1$s</strong> %2$s'),
				rt.call_function('__', [
					rt.new_string('Note:'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('__', [
					rt.new_string('This tool will update your WooCommerce database to the latest version. Please ensure you make sufficient backups before proceeding.'),
					rt.new_string('woocommerce'),
				]),
			]) },
		]) },
		rt.ArrayItem{ key: 'recreate_order_address_fts_index', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Re-create Order Address FTS index'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Recreate index'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('This tool will recreate the full text search index for order addresses. If the index does not exist, it will try to create it.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	])
	if rt.is_true(rt.call_function('method_exists', [rt.new_string('WC_Install'),
		rt.new_string('verify_base_tables')]))
	{
		var_tools.array_set('verify_db_tables', rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Verify base database tables'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'button', val: rt.call_function('__', [
				rt.new_string('Verify database'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Verify if all base database tables are present.'),
					rt.new_string('woocommerce'),
				]),
			]) },
		]))
	}
	mut iife_temp_0 := Class_Jetpack{}
	mut iife_result_0 := iife_temp_0.is_module_active(rt.new_string('photon'))
	if (rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack')]))
		&& rt.is_true(iife_result_0))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_background_image_regeneration'), rt.new_bool(true)]))))) {
		var_tools.array_unset(rt.new_string('regenerate_thumbnails'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_clear_template_cache'),
	])))))
	{
		var_tools.array_unset(rt.new_string('clear_template_cache'))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_debug_tools'),
		var_tools.clone()])
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_tools := rt.new_array()
	mut iter_1 := this.get_tools().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_tool := item_1.val
		mut var_id := item_1.key
		var_tools.array_push(this.prepare_response_for_collection(this.prepare_item_for_response(rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_id },
			rt.ArrayItem{ key: 'name', val: var_tool.array_get(rt.new_string('name')) },
			rt.ArrayItem{ key: 'action', val: var_tool.array_get(rt.new_string('button')) },
			rt.ArrayItem{ key: 'description', val: var_tool.array_get(rt.new_string('desc')) },
		]), var_request.clone())))
	}
	mut var_response := rt.call_function('rest_ensure_response', [
		var_tools.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_tools := this.get_tools()
	if !rt.is_true(var_tools.array_get(var_request.array_get(rt.new_string('id')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_system_status_tool_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid tool ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_tool := var_tools.array_get(var_request.array_get(rt.new_string('id')))
	return rt.call_function('rest_ensure_response', [
		this.prepare_item_for_response(rt.create_array([
			rt.ArrayItem{ key: 'id', val: var_request.array_get(rt.new_string('id')) },
			rt.ArrayItem{ key: 'name', val: var_tool.array_get(rt.new_string('name')) },
			rt.ArrayItem{ key: 'action', val: var_tool.array_get(rt.new_string('button')) },
			rt.ArrayItem{ key: 'description', val: var_tool.array_get(rt.new_string('desc')) },
		]), var_request.clone()),
	])
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_tools := this.get_tools()
	if !rt.is_true(var_tools.array_get(var_request.array_get(rt.new_string('id')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_system_status_tool_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid tool ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_tool := var_tools.array_get(var_request.array_get(rt.new_string('id')))
	var_tool = rt.create_array([
		rt.ArrayItem{ key: 'id', val: var_request.array_get(rt.new_string('id')) },
		rt.ArrayItem{ key: 'name', val: var_tool.array_get(rt.new_string('name')) },
		rt.ArrayItem{ key: 'action', val: var_tool.array_get(rt.new_string('button')) },
		rt.ArrayItem{ key: 'description', val: var_tool.array_get(rt.new_string('desc')) },
	])
	mut var_execute_return := this.execute_tool(var_request.array_get(rt.new_string('id')))
	var_tool = rt.call_function('array_merge', [var_tool.clone(),
		var_execute_return.clone()])
	rt.call_function('do_action', [
		rt.new_string('woocommerce_rest_insert_system_status_tool'),
		var_tool.clone(),
		var_request.clone(),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_tool.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_context := if !rt.is_true(var_request.array_get(rt.new_string('context'))) {
		rt.new_string('view')
	} else {
		var_request.array_get(rt.new_string('context'))
	}
	mut var_data := this.add_additional_fields_to_object(var_item.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_links', [
		this.prepare_links(var_item.array_get(rt.new_string('id'))),
	])
	return var_response.clone()
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('system_status_tool')
		'type':       rt.new_string('object')
		'properties': {
			'id':          {
				'description': rt.call_function('__', [
					rt.new_string('A unique identifier for the tool.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_title')
				}
			}
			'name':        {
				'description': rt.call_function('__', [rt.new_string('Tool name.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_text_field')
				}
			}
			'action':      {
				'description': rt.call_function('__', [
					rt.new_string('What running the tool will do.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_text_field')
				}
			}
			'description': {
				'description': rt.call_function('__', [
					rt.new_string('Tool description.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_text_field')
				}
			}
			'success':     {
				'description': rt.call_function('__', [
					rt.new_string('Did the tool run successfully?'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('boolean')
				'context':     map[string]rt.PhpVal{}
			}
			'message':     {
				'description': rt.call_function('__', [
					rt.new_string('Tool return message.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_text_field')
				}
			}
		}
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) prepare_links(var_id rt.PhpVal) rt.PhpVal {
	mut var_base := rt.new_string('/' + (this.namespace).str() + '/' + (this.rest_base).str())
	mut var_links := {
		'item': {
			'href':       rt.call_function('rest_url', [
				rt.new_string((rt.call_function('trailingslashit', [var_base.clone()])).str() +
					var_id.str()),
			])
			'embeddable': rt.new_bool(true)
		}
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'view' },
		])) },
	])
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) execute_tool(var_tool rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_tool_mutated := var_tool
	mut var_ran := rt.new_bool(true)
	mut switch_val_1 := var_tool_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('clear_transients'))) {
		rt.call_function('wc_delete_product_transients', []rt.PhpVal{})
		rt.call_function('wc_delete_shop_order_transients', []rt.PhpVal{})
		rt.call_function('delete_transient', [rt.new_string('wc_count_comments')])
		rt.call_function('delete_transient', [rt.new_string('as_comment_count')])
		mut var_attribute_taxonomies := rt.call_function('wc_get_attribute_taxonomies',
			[]rt.PhpVal{})
		if rt.is_true(var_attribute_taxonomies) {
			mut iter_2 := var_attribute_taxonomies.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_attribute := item_2.val
				rt.call_function('delete_transient', [
					rt.new_string('wc_layered_nav_counts_pa_' +
						(rt.get_property(var_attribute, 'attribute_name')).str()),
				])
			}
		}
		mut iife_temp_1 := Class_WC_Cache_Helper{}
		mut iife_result_1 := iife_temp_1.get_transient_version(rt.new_string('shipping'),
			rt.new_bool(true))
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController.class(),
		]), 'delete_filter_data_transients', []rt.PhpVal{})
		mut var_message := rt.call_function('__', [
			rt.new_string('Product transients cleared'),
			rt.new_string('woocommerce'),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('clear_expired_transients'))) {
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%d transients rows cleared'),
				rt.new_string('woocommerce')]),
			rt.call_function('wc_delete_expired_transients', []rt.PhpVal{}),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_orphaned_variations'))) {
		mut var_result := rt.call_function('absint', [
			rt.call_method(var_wpdb, 'query', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE products\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb,
					'posts')), rt.new_string(' products\n\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb,
					'posts')),
					rt.new_string(" wp ON wp.ID = products.post_parent\n\t\t\t\t\tWHERE wp.ID IS NULL AND products.post_type = 'product_variation';")),
			]),
		])
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%d orphaned variations deleted'),
				rt.new_string('woocommerce')]),
			var_result.clone(),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('clear_expired_download_permissions'))) {
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
					'prefix')),
					rt.new_string('wc_download_log\n\t\t\t\t\t\tWHERE permission_id IN (\n\t\t\t\t\t\t\t\t    SELECT permission_id FROM ')), rt.get_property(var_wpdb,
					'prefix')),
					rt.new_string("woocommerce_downloadable_product_permissions\n\t\t\t\t\t\t\t\t\tWHERE ( downloads_remaining != '' AND downloads_remaining = 0 ) OR ( access_expires IS NOT NULL AND access_expires < %s )\n\t\t\t\t\t\t\t\t    )")),
				rt.call_function('current_time', [rt.new_string('Y-m-d')]),
			]),
		])
		var_result = rt.call_function('absint', [
			rt.call_method(var_wpdb, 'query', [
				rt.call_method(var_wpdb, 'prepare', [
					rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
						'prefix')),
						rt.new_string("woocommerce_downloadable_product_permissions\n\t\t\t\t\t\t\tWHERE ( downloads_remaining != '' AND downloads_remaining = 0 ) OR ( access_expires IS NOT NULL AND access_expires < %s )")),
					rt.call_function('current_time', [rt.new_string('Y-m-d')]),
				]),
			]),
		])
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%d permissions deleted'),
				rt.new_string('woocommerce')]),
			var_result.clone(),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('regenerate_product_lookup_tables'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_update_product_lookup_tables_is_running',
			[]rt.PhpVal{})))))
		{
			rt.call_function('wc_update_product_lookup_tables', []rt.PhpVal{})
		}
		var_message = rt.call_function('__', [
			rt.new_string('Lookup tables are regenerating'),
			rt.new_string('woocommerce'),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('repair_coupons_lookup_table'))) {
		var_result = rt.call_function('wc_repair_zero_discount_coupons_lookup_table', []rt.PhpVal{})
		var_message = var_result.array_get(rt.new_string('message'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('reset_roles'))) {
		mut iife_temp_2 := Class_WC_Install{}
		mut iife_result_2 := iife_temp_2.remove_roles()
		mut iife_temp_3 := Class_WC_Install{}
		mut iife_result_3 := iife_temp_3.create_roles()
		var_message = rt.call_function('__', [rt.new_string('Roles successfully reset'),
			rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('recount_terms'))) {
		rt.call_function('wc_recount_all_terms', []rt.PhpVal{})
		var_message = rt.call_function('__', [
			rt.new_string('Terms successfully recounted'),
			rt.new_string('woocommerce'),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('clear_sessions'))) {
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('TRUNCATE '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_sessions')),
		])
		var_result = rt.call_function('absint', [
			rt.call_method(var_wpdb, 'query', [
				rt.new_string((
					rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string(" WHERE meta_key='_woocommerce_persistent_cart_")) +
					(rt.call_function('get_current_blog_id', []rt.PhpVal{})).str() + "';").str()),
			]),
		])
		rt.call_function('wp_cache_flush', []rt.PhpVal{})
		var_message = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Deleted all active sessions, and %d saved carts.'),
				rt.new_string('woocommerce'),
			]),
			rt.call_function('absint', [
				var_result.clone(),
			]),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('install_pages'))) {
		mut iife_temp_4 := Class_WC_Install{}
		mut iife_result_4 := iife_temp_4.create_pages()
		var_message = rt.call_function('__', [
			rt.new_string('All missing WooCommerce pages successfully installed'),
			rt.new_string('woocommerce'),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_taxes'))) {
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_tax_rates;')),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')),
				rt.new_string('woocommerce_tax_rate_locations;')),
		])
		if rt.is_true(rt.call_function('method_exists', [
			rt.new_string('WC_Cache_Helper'),
			rt.new_string('invalidate_cache_group'),
		]))
		{
			mut iife_temp_5 := Class_WC_Cache_Helper{}
			mut iife_result_5 := iife_temp_5.invalidate_cache_group(rt.new_string('taxes'))
		} else {
			mut iife_temp_6 := Class_WC_Cache_Helper{}
			mut iife_result_6 := iife_temp_6.incr_cache_prefix(rt.new_string('taxes'))
		}
		var_message = rt.call_function('__', [
			rt.new_string('Tax rates successfully deleted'),
			rt.new_string('woocommerce'),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('regenerate_thumbnails'))) {
		mut iife_temp_7 := Class_WC_Regenerate_Images{}
		mut iife_result_7 := iife_temp_7.queue_image_regeneration()
		var_message = rt.call_function('__', [
			rt.new_string('Thumbnail regeneration has been scheduled to run in the background.'),
			rt.new_string('woocommerce'),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('db_update_routine'))) {
		mut var_blog_id := rt.call_function('get_current_blog_id', []rt.PhpVal{})
		rt.call_function('do_action', [
			rt.new_string('wp_' + var_blog_id.str() + '_wc_updater_cron'),
		])
		var_message = rt.call_function('__', [
			rt.new_string('Database upgrade routine has been scheduled to run in the background.'),
			rt.new_string('woocommerce'),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('clear_template_cache'))) {
		if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wc_clear_template_cache'),
		]))
		{
			rt.call_function('wc_clear_template_cache', []rt.PhpVal{})
			var_message = rt.call_function('__', [
				rt.new_string('Template cache cleared.'),
				rt.new_string('woocommerce'),
			])
		} else {
			var_message = rt.call_function('__', [
				rt.new_string('The active version of WooCommerce does not support template cache clearing.'),
				rt.new_string('woocommerce'),
			])
			var_ran = rt.new_bool(false)
		}
	} else if rt.is_true(rt.equal(switch_val_1,
		rt.new_string('clear_system_status_theme_info_cache')))
	{
		rt.call_function('wc_clear_system_status_theme_info_cache', []rt.PhpVal{})
		var_message = rt.call_function('__', [
			rt.new_string('System status theme info cache cleared.'),
			rt.new_string('woocommerce'),
		])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('verify_db_tables'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('method_exists', [
			rt.new_string('WC_Install'),
			rt.new_string('verify_base_tables'),
		])))))
		{
			var_message = rt.call_function('__', [
				rt.new_string('You need WooCommerce 4.2 or newer to run this tool.'),
				rt.new_string('woocommerce'),
			])
			var_ran = rt.new_bool(false)
		}
		mut iife_temp_8 := Class_WC_Install{}
		mut iife_result_8 := iife_temp_8.verify_base_tables(rt.new_bool(true), rt.new_bool(true))
		mut var_missing_tables := iife_result_8
		if 0 == var_missing_tables.clone().array_count() {
			var_message = rt.call_function('__', [
				rt.new_string('Database verified successfully.'),
				rt.new_string('woocommerce'),
			])
		} else {
			var_message = rt.call_function('__', [
				rt.new_string('Verifying database... One or more tables are still missing: '),
				rt.new_string('woocommerce'),
			])
			var_message = rt.concat(var_message, rt.call_function('implode', [
				rt.new_string(', '),
				var_missing_tables.clone(),
			]))
			var_ran = rt.new_bool(false)
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('recreate_order_address_fts_index'))) {
		mut var_hpos_controller := rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_DataStores_Orders_CustomOrdersTableController.class(),
		])
		mut var_results := rt.call_method(var_hpos_controller, 'recreate_order_address_fts_index',
			[]rt.PhpVal{})
		var_ran = var_results.array_get(rt.new_string('status'))
		var_message = var_results.array_get(rt.new_string('message'))
	} else {
		mut var_tools := this.get_tools()
		if var_tools.array_get(var_tool_mutated).array_isset(rt.new_string('callback')) {
			mut var_callback :=
				var_tools.array_get(var_tool_mutated).array_get(rt.new_string('callback'))
			mut var_return := rt.call_function('call_user_func', [
				rt.create_array_from_list(var_callback),
			])
			if rt.has_exception() {
				unsafe {
					goto catch_label_1
				}
			}
			unsafe {
				goto end_label_1
			}
			catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Exception') {
				mut var_exception := var_e_1.clone()
				var_return = var_exception
				unsafe {
					goto end_label_1
				}
			} else {
				rt.throw_exception(var_e_1)
				unsafe {
					goto end_label_1
				}
			}

			end_label_1:
			if rt.is_true(rt.call_function('is_a', [var_return.clone(),
				Class_Exception.class()]))
			{
				mut var_callback_string := rt.new_string(this.get_printable_callback_name(var_callback.clone(),
					var_tool_mutated.clone()))
				var_ran = rt.new_bool(false)
				var_message = rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('There was an error calling %1$s: %2$s'),
						rt.new_string('woocommerce'),
					]),
					var_callback_string.clone(),
					rt.call_method(var_return, 'getMessage', []rt.PhpVal{}),
				])
				mut var_logger := rt.call_function('wc_get_logger', []rt.PhpVal{})
				rt.call_method(var_logger, 'error', [
					rt.call_function('sprintf', [
						rt.new_string('Error running debug tool %s: %s'),
						var_tool_mutated.clone(),
						rt.call_method(var_return, 'getMessage', []rt.PhpVal{}),
					]),
					rt.create_array([
						rt.ArrayItem{ key: 'source', val: 'run-debug-tool' },
						rt.ArrayItem{ key: 'tool', val: var_tool_mutated },
						rt.ArrayItem{ key: 'callback', val: var_callback },
						rt.ArrayItem{ key: 'error', val: var_return },
					]),
				])
			} else if rt.is_true(rt.new_bool(var_return.clone().is_string())) {
				var_message = var_return.clone()
			} else if rt.is_true(rt.identical(rt.new_bool(false), var_return)) {
				var_callback_string = rt.new_string(this.get_printable_callback_name(var_callback.clone(),
					var_tool_mutated.clone()))
				var_ran = rt.new_bool(false)
				var_message = rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('There was an error calling %s'),
						rt.new_string('woocommerce'),
					]),
					var_callback_string.clone(),
				])
			} else {
				var_message = rt.call_function('__', [rt.new_string('Tool ran.'),
					rt.new_string('woocommerce')])
			}
		} else {
			var_ran = rt.new_bool(false)
			var_message = rt.call_function('__', [
				rt.new_string('There was an error calling this tool. There is no callback present.'),
				rt.new_string('woocommerce'),
			])
		}
	}
	return rt.create_array([rt.ArrayItem{ key: 'success', val: var_ran },
		rt.ArrayItem{ key: 'message', val: var_message }])
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_printable_callback_name(var_callback rt.PhpVal, var_default rt.PhpVal) string {
	mut var_callback_mutated := var_callback
	if rt.is_true(rt.new_bool(var_callback_mutated.clone().is_array())) {
		return
			(rt.call_function('get_class', [var_callback_mutated.array_get(rt.new_int(0))])).str() +
			'::' + (var_callback_mutated.array_get(rt.new_int(1))).str()
	}
	if rt.is_true(rt.new_bool(var_callback_mutated.clone().is_string())) {
		return var_callback_mutated.str()
	}
	return var_default.str()
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Jetpack {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

struct Class_WC_Install {
	rt.PhpObjectBase
}

struct Class_WC_Regenerate_Images {
	rt.PhpObjectBase
}

fn create_wc_rest_system_status_tools_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_System_Status_Tools_V2_Controller {
	mut obj := &Class_WC_REST_System_Status_Tools_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v2')
		rest_base:     rt.new_string('system_status/tools')
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

fn create_jetpack(_args ...rt.PhpVal) &Class_Jetpack {
	mut obj := &Class_Jetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_install(_args ...rt.PhpVal) &Class_WC_Install {
	mut obj := &Class_WC_Install{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_regenerate_images(_args ...rt.PhpVal) &Class_WC_Regenerate_Images {
	mut obj := &Class_WC_Regenerate_Images{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'get_tools' {
			return this.get_tools()
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'execute_tool' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.execute_tool(dispatch_arg_0)
		}
		'get_printable_callback_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.get_printable_callback_name(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_System_Status_Tools_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Jetpack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Jetpack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Jetpack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Install) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Install) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Install) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Regenerate_Images) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Regenerate_Images) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Regenerate_Images) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
