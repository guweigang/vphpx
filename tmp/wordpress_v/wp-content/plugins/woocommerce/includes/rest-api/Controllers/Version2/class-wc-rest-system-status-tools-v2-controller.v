import rt

struct Class_WC_REST_System_Status_Tools_V2_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v2')
		rest_base rt.PhpVal = rt.new_string('system_status/tools')
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[\\w-]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_System_Status_Tools_V2_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('system_status'), rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('system_status'), rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('system_status'), rt.new_string('edit')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_update'), rt.call_function('__', [rt.new_string('Sorry, you cannot update resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_tools() rt.PhpVal {
	mut var_tools := rt.create_array([rt.ArrayItem{ key: 'clear_transients', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('WooCommerce transients'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Clear transients'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('This tool will clear the product/shop transients cache.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'clear_expired_transients', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Expired transients'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Clear transients'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('This tool will clear ALL expired transients from WordPress.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'delete_orphaned_variations', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Orphaned variations'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Delete orphaned variations'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('This tool will delete all variations which have no parent.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'clear_expired_download_permissions', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Used-up download permissions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Clean up download permissions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('This tool will delete expired download permissions and permissions with 0 remaining downloads.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'regenerate_product_lookup_tables', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Product lookup tables'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Regenerate'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('This tool will regenerate product lookup table data. This process may take a while.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'repair_coupons_lookup_table', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Coupons lookup table'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Repair'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('This tool will repair the coupons lookup table data with missing discount amounts. This process may take a while.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'recount_terms', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Term counts'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Recount terms'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('This tool will recount product terms - useful when changing your settings in a way which hides products from the catalog.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'reset_roles', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Capabilities'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Reset capabilities'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('This tool will reset the admin, customer and shop_manager roles to default. Use this if your users cannot access all of the WooCommerce admin pages.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'clear_sessions', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Clear customer sessions'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Clear'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [rt.new_string('<strong class="red">%1$s</strong> %2$s'), rt.call_function('__', [rt.new_string('Note:'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('This tool will delete all customer session data from the database, including current carts and saved carts in the database.'), rt.new_string('woocommerce')])]) }]) }, rt.ArrayItem{ key: 'clear_template_cache', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Clear template cache'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Clear'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [rt.new_string('<strong class="red">%1$s</strong> %2$s'), rt.call_function('__', [rt.new_string('Note:'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('This tool will empty the template cache.'), rt.new_string('woocommerce')])]) }]) }, rt.ArrayItem{ key: 'clear_system_status_theme_info_cache', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Clear system status theme info cache'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Clear'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [rt.new_string('<strong class="red">%1$s</strong> %2$s'), rt.call_function('__', [rt.new_string('Note:'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('This tool will empty the system status theme info cache.'), rt.new_string('woocommerce')])]) }]) }, rt.ArrayItem{ key: 'install_pages', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Create default WooCommerce pages'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Create pages'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [rt.new_string('<strong class="red">%1$s</strong> %2$s'), rt.call_function('__', [rt.new_string('Note:'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('This tool will install all the missing WooCommerce pages. Pages already defined and set up will not be replaced.'), rt.new_string('woocommerce')])]) }]) }, rt.ArrayItem{ key: 'delete_taxes', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Delete WooCommerce tax rates'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Delete tax rates'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [rt.new_string('<strong class="red">%1$s</strong> %2$s'), rt.call_function('__', [rt.new_string('Note:'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('This option will delete ALL of your tax rates, use with caution. This action cannot be reversed.'), rt.new_string('woocommerce')])]) }]) }, rt.ArrayItem{ key: 'regenerate_thumbnails', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Regenerate shop thumbnails'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Regenerate'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('This will regenerate all shop thumbnails to match your theme and/or image settings.'), rt.new_string('woocommerce')]) }]) }, rt.ArrayItem{ key: 'db_update_routine', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Update database'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Update database'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [rt.new_string('<strong class="red">%1$s</strong> %2$s'), rt.call_function('__', [rt.new_string('Note:'), rt.new_string('woocommerce')]), rt.call_function('__', [rt.new_string('This tool will update your WooCommerce database to the latest version. Please ensure you make sufficient backups before proceeding.'), rt.new_string('woocommerce')])]) }]) }, rt.ArrayItem{ key: 'recreate_order_address_fts_index', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Re-create Order Address FTS index'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Recreate index'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('This tool will recreate the full text search index for order addresses. If the index does not exist, it will try to create it.'), rt.new_string('woocommerce')]) }]) }])
	if rt.is_true(rt.call_function('method_exists', [rt.new_string('WC_Install'), rt.new_string('verify_base_tables')])) {
		var_tools.array_set('verify_db_tables', rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Verify base database tables'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Verify database'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Verify if all base database tables are present.'), rt.new_string('woocommerce')])]) }]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('class_exists', [rt.new_string('Jetpack')])) && rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Jetpack{}; return temp.is_module_active(arg_0) }(rt.new_string('photon'))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_background_image_regeneration'), rt.new_bool(true)]))))))) {
		var_tools.array_unset(rt.new_string('regenerate_thumbnails'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_clear_template_cache')]))))) {
		var_tools.array_unset(rt.new_string('clear_template_cache'))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_debug_tools'), var_tools.dup()])
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_tools := rt.new_array()
	{
		mut iter_1 := this.get_tools().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tool := item_1.val
			mut var_id := item_1.key
			var_tools.array_push(this.prepare_response_for_collection(this.prepare_item_for_response(rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'name', val: var_tool.array_get('name') }, rt.ArrayItem{ key: 'action', val: var_tool.array_get('button') }, rt.ArrayItem{ key: 'description', val: var_tool.array_get('desc') }]), var_request.dup())))
		}
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_tools.dup()])
	return var_response.dup()
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_tools := this.get_tools()
	if !rt.is_true(var_tools.array_get(var_request.array_get('id'))) {
		return create_wp_error(rt.new_string('woocommerce_rest_system_status_tool_invalid_id'), rt.call_function('__', [rt.new_string('Invalid tool ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_tool := var_tools.array_get(var_request.array_get('id'))
	return rt.call_function('rest_ensure_response', [this.prepare_item_for_response(rt.create_array([rt.ArrayItem{ key: 'id', val: var_request.array_get('id') }, rt.ArrayItem{ key: 'name', val: var_tool.array_get('name') }, rt.ArrayItem{ key: 'action', val: var_tool.array_get('button') }, rt.ArrayItem{ key: 'description', val: var_tool.array_get('desc') }]), var_request.dup())])
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_tools := this.get_tools()
	if !rt.is_true(var_tools.array_get(var_request.array_get('id'))) {
		return create_wp_error(rt.new_string('woocommerce_rest_system_status_tool_invalid_id'), rt.call_function('__', [rt.new_string('Invalid tool ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_tool := var_tools.array_get(var_request.array_get('id'))
	var_tool = rt.create_array([rt.ArrayItem{ key: 'id', val: var_request.array_get('id') }, rt.ArrayItem{ key: 'name', val: var_tool.array_get('name') }, rt.ArrayItem{ key: 'action', val: var_tool.array_get('button') }, rt.ArrayItem{ key: 'description', val: var_tool.array_get('desc') }])
	mut var_execute_return := this.execute_tool(var_request.array_get('id'))
	var_tool = rt.call_function('array_merge', [var_tool.dup(), var_execute_return.dup()])
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_insert_system_status_tool'), var_tool.dup(), var_request.dup()])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_tool.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_context := if !rt.is_true(var_request.array_get('context')) { rt.new_string('view') } else { var_request.array_get('context') }
	mut var_data := this.add_additional_fields_to_object(var_item.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_item.array_get('id'))])
	return var_response.dup()
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('system_status_tool'), 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('A unique identifier for the tool.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'arg_options': { 'sanitize_callback': rt.new_string('sanitize_title') } }, 'name': { 'description': rt.call_function('__', [rt.new_string('Tool name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'arg_options': { 'sanitize_callback': rt.new_string('sanitize_text_field') } }, 'action': { 'description': rt.call_function('__', [rt.new_string('What running the tool will do.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'arg_options': { 'sanitize_callback': rt.new_string('sanitize_text_field') } }, 'description': { 'description': rt.call_function('__', [rt.new_string('Tool description.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'arg_options': { 'sanitize_callback': rt.new_string('sanitize_text_field') } }, 'success': { 'description': rt.call_function('__', [rt.new_string('Did the tool run successfully?'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{} }, 'message': { 'description': rt.call_function('__', [rt.new_string('Tool return message.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'arg_options': { 'sanitize_callback': rt.new_string('sanitize_text_field') } } } }
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) prepare_links(var_id rt.PhpVal) rt.PhpVal {
	mut var_base := rt.new_string('/' + (this.namespace).str() + '/' + (this.rest_base).str())
	mut var_links := { 'item': { 'href': rt.call_function('rest_url', [rt.concat(rt.call_function('trailingslashit', [var_base.dup()]), var_id)]), 'embeddable': rt.new_bool(true) } }
	return var_links.dup()
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }])
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) execute_tool(var_tool rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_tool_mutated := var_tool
	// unsupported statement: Stmt_Global
	mut var_ran := rt.new_bool(rt.new_bool(true))
	mut switch_val_1 := var_tool_mutated
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('clear_transients'))) {
		rt.call_function('wc_delete_product_transients', []rt.PhpVal{})
		rt.call_function('wc_delete_shop_order_transients', []rt.PhpVal{})
		rt.call_function('delete_transient', [rt.new_string('wc_count_comments')])
		rt.call_function('delete_transient', [rt.new_string('as_comment_count')])
		mut var_attribute_taxonomies := rt.call_function('wc_get_attribute_taxonomies', []rt.PhpVal{})
		if rt.is_true(var_attribute_taxonomies) {
			{
				mut iter_1 := var_attribute_taxonomies.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_attribute := item_1.val
					rt.call_function('delete_transient', ['wc_layered_nav_counts_pa_' + (rt.get_property(var_attribute, 'attribute_name')).str()])
				}
			}
		}
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.get_transient_version(arg_0, arg_1) }(rt.new_string('shipping'), rt.new_bool(true))
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_ProductFilters_CacheController.class()]), 'delete_filter_data_transients', []rt.PhpVal{})
		mut var_message := rt.call_function('__', [rt.new_string('Product transients cleared'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('clear_expired_transients'))) {
		var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%d transients rows cleared'), rt.new_string('woocommerce')]), rt.call_function('wc_delete_expired_transients', []rt.PhpVal{})])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_orphaned_variations'))) {
		mut var_result := rt.call_function('absint', [rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE products\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' products\n\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' wp ON wp.ID = products.post_parent\n\t\t\t\t\tWHERE wp.ID IS NULL AND products.post_type = \'product_variation\';'))])])
		var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%d orphaned variations deleted'), rt.new_string('woocommerce')]), var_result.dup()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('clear_expired_download_permissions'))) {
		rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('wc_download_log\n\t\t\t\t\t\tWHERE permission_id IN (\n\t\t\t\t\t\t\t\t    SELECT permission_id FROM ')), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_downloadable_product_permissions\n\t\t\t\t\t\t\t\t\tWHERE ( downloads_remaining != \'\' AND downloads_remaining = 0 ) OR ( access_expires IS NOT NULL AND access_expires < %s )\n\t\t\t\t\t\t\t\t    )')), rt.call_function('current_time', [rt.new_string('Y-m-d')])])])
		var_result = rt.call_function('absint', [rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_downloadable_product_permissions\n\t\t\t\t\t\t\tWHERE ( downloads_remaining != \'\' AND downloads_remaining = 0 ) OR ( access_expires IS NOT NULL AND access_expires < %s )')), rt.call_function('current_time', [rt.new_string('Y-m-d')])])])])
		var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%d permissions deleted'), rt.new_string('woocommerce')]), var_result.dup()])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('regenerate_product_lookup_tables'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_update_product_lookup_tables_is_running', []rt.PhpVal{}))))) {
			rt.call_function('wc_update_product_lookup_tables', []rt.PhpVal{})
		}
		var_message = rt.call_function('__', [rt.new_string('Lookup tables are regenerating'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('repair_coupons_lookup_table'))) {
		var_result = rt.call_function('wc_repair_zero_discount_coupons_lookup_table', []rt.PhpVal{})
		var_message = var_result.array_get('message')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('reset_roles'))) {
		fn () rt.PhpVal { mut temp := Class_WC_Install{}; return temp.remove_roles() }()
		fn () rt.PhpVal { mut temp := Class_WC_Install{}; return temp.create_roles() }()
		var_message = rt.call_function('__', [rt.new_string('Roles successfully reset'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('recount_terms'))) {
		rt.call_function('wc_recount_all_terms', []rt.PhpVal{})
		var_message = rt.call_function('__', [rt.new_string('Terms successfully recounted'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('clear_sessions'))) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('TRUNCATE '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_sessions'))])
		var_result = rt.call_function('absint', [rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'usermeta')), rt.new_string(' WHERE meta_key=\'_woocommerce_persistent_cart_')) + (rt.call_function('get_current_blog_id', []rt.PhpVal{})).str() + '\';'])])
		rt.call_function('wp_cache_flush', []rt.PhpVal{})
		var_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Deleted all active sessions, and %d saved carts.'), rt.new_string('woocommerce')]), rt.call_function('absint', [var_result.dup()])])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('install_pages'))) {
		fn () rt.PhpVal { mut temp := Class_WC_Install{}; return temp.create_pages() }()
		var_message = rt.call_function('__', [rt.new_string('All missing WooCommerce pages successfully installed'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('delete_taxes'))) {
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_tax_rates;'))])
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_tax_rate_locations;'))])
		if rt.is_true(rt.call_function('method_exists', [rt.new_string('WC_Cache_Helper'), rt.new_string('invalidate_cache_group')])) {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.invalidate_cache_group(arg_0) }(rt.new_string('taxes'))
		} else {
			fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Cache_Helper{}; return temp.incr_cache_prefix(arg_0) }(rt.new_string('taxes'))
		}
		var_message = rt.call_function('__', [rt.new_string('Tax rates successfully deleted'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('regenerate_thumbnails'))) {
		fn () rt.PhpVal { mut temp := Class_WC_Regenerate_Images{}; return temp.queue_image_regeneration() }()
		var_message = rt.call_function('__', [rt.new_string('Thumbnail regeneration has been scheduled to run in the background.'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('db_update_routine'))) {
		mut var_blog_id := rt.call_function('get_current_blog_id', []rt.PhpVal{})
		rt.call_function('do_action', ['wp_' + (var_blog_id).str() + '_wc_updater_cron'])
		var_message = rt.call_function('__', [rt.new_string('Database upgrade routine has been scheduled to run in the background.'), rt.new_string('woocommerce')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('clear_template_cache'))) {
		if rt.is_true(rt.call_function('function_exists', [rt.new_string('wc_clear_template_cache')])) {
			rt.call_function('wc_clear_template_cache', []rt.PhpVal{})
			var_message = rt.call_function('__', [rt.new_string('Template cache cleared.'), rt.new_string('woocommerce')])
		} else {
			var_message = rt.call_function('__', [rt.new_string('The active version of WooCommerce does not support template cache clearing.'), rt.new_string('woocommerce')])
			var_ran = rt.new_bool(rt.new_bool(false))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('clear_system_status_theme_info_cache'))) {
		rt.call_function('wc_clear_system_status_theme_info_cache', []rt.PhpVal{})
		var_message = rt.call_function('__', [, ])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('verify_db_tables'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true()))) {
			
		}
		
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else {
	}
}

fn (mut this Class_WC_REST_System_Status_Tools_V2_Controller) get_printable_callback_name(var_callback rt.PhpVal, var_default rt.PhpVal) string {
	mut var_callback_mutated := var_callback
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

fn create_wc_rest_system_status_tools_v2_controller() &Class_WC_REST_System_Status_Tools_V2_Controller {
	mut obj := &Class_WC_REST_System_Status_Tools_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v2')
		rest_base: rt.new_string('system_status/tools')
	}
	return obj
}

fn create_wc_rest_controller() &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_jetpack() &Class_Jetpack {
	mut obj := &Class_Jetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_install() &Class_WC_Install {
	mut obj := &Class_WC_Install{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_regenerate_images() &Class_WC_Regenerate_Images {
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
		else { return none }
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
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version2_class_wc_rest_system_status_tools_v2_controller_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
