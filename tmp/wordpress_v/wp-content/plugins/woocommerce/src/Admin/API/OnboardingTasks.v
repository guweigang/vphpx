import rt

struct Class_Automattic_WooCommerce_Admin_API_OnboardingTasks {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-admin')
		rest_base rt.PhpVal = rt.new_string('onboarding/tasks')
		duration_to_ms rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/import_sample_products', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'import_sample_products' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_products_permission_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/create_homepage', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_homepage' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_pages_permission_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/create_product_from_template', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_product_from_template' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_products_permission_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [this.get_endpoint_args_for_item_schema(Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.creatable()), rt.create_array([rt.ArrayItem{ key: 'template_name', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product template name.'), rt.new_string('woocommerce')]) }]) }])]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_tasks' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_tasks_permission_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'ids', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Optional parameter to get only specific task lists by id.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_slug_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'enum', val: fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}; return temp.get_list_ids() }() }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_tasks' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_tasks_permission_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_task_list_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[a-z0-9_\\-]+)/hide', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'hide_task_list' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'hide_task_list_permission_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[a-z0-9_\\-]+)/unhide', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'unhide_task_list' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'hide_task_list_permission_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[a-z0-9_\\-]+)/dismiss', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'dismiss_task' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_tasks_permission_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[a-z0-9_\\-]+)/undo_dismiss', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'undo_dismiss_task' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_tasks_permission_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_param := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_request := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	mut var_key := if args.len > 2 { args[2].dup() } else { rt.new_null() }
	return rt.call_function('in_array', [var_param.dup(), rt.func_array_keys(this.duration_to_ms), rt.new_bool(true)])
	}
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[a-z0-9_-]+)/snooze', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'duration', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Time period to snooze the task.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_1_fn) }]) }, rt.ArrayItem{ key: 'task_list_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Optional parameter to query specific task list.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'snooze_task' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'snooze_task_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[a-z0-9_\\-]+)/action', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'action_task' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_tasks_permission_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[a-z0-9_\\-]+)/undo_snooze', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'undo_snooze_task' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'snooze_task_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) create_products_permission_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [rt.new_string('product'), rt.new_string('create')]))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) create_pages_permission_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [rt.new_string('page'), rt.new_string('create')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create new pages.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) get_tasks_permission_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to retrieve onboarding tasks.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) hide_task_list_permission_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_update'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to hide task lists.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) snooze_task_permissions_check(var_request rt.PhpVal) bool {
	rt.call_function('wc_deprecated_function', [@STRUCT + '::' + @FN, rt.new_string('7.8.0')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to snooze onboarding tasks.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.import_sample_products_from_csv(var_csv_file rt.PhpVal) rt.PhpVal {
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/import/class-wc-product-csv-importer.php', '2')
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('file_exists', [var_csv_file.dup()])) && rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Product_CSV_Importer')])))) {
		rt.call_function('add_filter', [rt.new_string('locale'), rt.new_string('__return_false'), rt.new_int(9999)])
		mut var_importer_class := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_csv_importer_class'), rt.new_string('WC_Product_CSV_Importer')])
		mut var_args := rt.create_array([rt.ArrayItem{ key: 'parse', val: true }, rt.ArrayItem{ key: 'mapping', val: Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_header_mappings(var_csv_file.dup()) }])
		var_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_csv_importer_args'), var_args.dup(), var_importer_class.dup()])
		mut var_importer := rt.create_object_dynamically(var_importer_class, [var_csv_file.dup(), var_args.dup()])
		mut var_import := rt.call_method(var_importer, 'import', []rt.PhpVal{})
		return var_import.dup()
	} else {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_import_error'), rt.call_function('__', [rt.new_string('Sorry, the sample products data file was not found.'), rt.new_string('woocommerce')]))
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.import_sample_products() rt.PhpVal {
	mut var_sample_csv_file := rt.new_string(if rt.is_true(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Features{}; return temp.is_enabled(arg_0) }(rt.new_string('experimental-fashion-sample-products'))) { (rt.get_constant('WC_ABSPATH')).str() + 'sample-data/experimental_fashion_sample_9_products.csv' } else { (rt.get_constant('WC_ABSPATH')).str() + 'sample-data/experimental_sample_9_products.csv' })
	mut var_import := Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.import_sample_products_from_csv(var_sample_csv_file.dup())
	return rt.call_function('rest_ensure_response', [var_import.dup()])
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.create_product_from_template(var_request rt.PhpVal) rt.PhpVal {
	mut var_template_name := rt.call_function('basename', [rt.call_method(var_request, 'get_param', [rt.new_string('template_name')])])
	mut var_template_path := rt.new_string(@DIR + '/Templates/' + (var_template_name).str() + '_product.csv')
	var_template_path = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_template_csv_file_path'), var_template_path.dup(), var_template_name.dup()])
	mut var_import := Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.import_sample_products_from_csv(var_template_path.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_import.dup()])) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_import.array_get('imported').is_array()))))))) || 0 == var_import.array_get('imported').array_count())) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_product_creation_error'), rt.call_function('__', [rt.new_string('Sorry, creating the product with template failed.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	mut var_product := rt.call_function('wc_get_product', [var_import.array_get('imported').array_get(0)])
	rt.call_method(var_product, 'set_status', [Class_Automattic_WooCommerce_Enums_ProductStatus.auto_draft()])
	rt.call_method(var_product, 'save', []rt.PhpVal{})
	return rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) }])])
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_header_mappings(var_file rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/importers/mappings/mappings.php', '2')
	mut var_importer_class := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_csv_importer_class'), rt.new_string('WC_Product_CSV_Importer')])
	mut var_importer := rt.create_object_dynamically(var_importer_class, [var_file.dup(), rt.new_array()])
	mut var_raw_headers := rt.call_method(var_importer, 'get_raw_keys', []rt.PhpVal{})
	mut var_default_columns := rt.call_function('wc_importer_default_english_mappings', [rt.new_array()])
	mut var_special_columns := rt.call_function('wc_importer_default_special_english_mappings', [rt.new_array()])
	mut var_headers := rt.new_array()
	{
		mut iter_1 := var_raw_headers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_key := item_1.key
			mut var_index := var_field
			var_headers.array_set(var_index, var_field.dup())
			if var_default_columns.array_isset(var_field) {
				var_headers.array_set(var_index, var_default_columns.array_get(var_field))
			} else {
				{
					mut iter_2 := var_special_columns.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_special_key := item_2.val
						mut var_regex := item_2.key
						if rt.is_true(rt.call_function('preg_match', [Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.sanitize_special_column_name_regex(var_regex.dup()), var_field.dup(), var_matches.dup()])) {
							var_headers.array_set(var_index, (var_special_key).str() + (var_matches.array_get(1)).str())
							break
						}
					}
				}
			}
		}
	}
	return var_headers.dup()
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.sanitize_special_column_name_regex(var_value rt.PhpVal) string {
	return '/' + (rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }]), rt.new_string('(.*)'), rt.new_string(rt.call_function('quotemeta', [var_value.dup()]).to_string().trim_space())])).str() + '/'
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_cover_block(var_image rt.PhpVal) string {
	mut var_shop_url := rt.call_function('wc_get_page_permalink', [rt.new_string('shop')])
	if !(!rt.is_true(var_image.array_get('url'))) && !(!rt.is_true(var_image.array_get('id'))) {
		return '<!-- wp:cover {"url":"' + (rt.call_function('esc_url', [var_image.array_get('url')])).str() + '","id":' + var_image.array_get('id').to_i64().str() + ',"dimRatio":0} -->\n\t\t\t<div class="wp-block-cover" style="background-image:url(' + (rt.call_function('esc_url', [var_image.array_get('url')])).str() + ')"><div class="wp-block-cover__inner-container"><!-- wp:paragraph {"align":"center","placeholder":"' + (rt.call_function('__', [rt.new_string('Write title…'), rt.new_string('woocommerce')])).str() + '","textColor":"white","fontSize":"large"} -->\n\t\t\t<p class="has-text-align-center has-large-font-size">' + (rt.call_function('__', [rt.new_string('Welcome to the store'), rt.new_string('woocommerce')])).str() + '</p>\n\t\t\t<!-- /wp:paragraph -->\n\n\t\t\t<!-- wp:paragraph {"align":"center","textColor":"white"} -->\n\t\t\t<p class="has-text-color has-text-align-center">' + (rt.call_function('__', [rt.new_string('Write a short welcome message here'), rt.new_string('woocommerce')])).str() + '</p>\n\t\t\t<!-- /wp:paragraph -->\n\n\t\t\t<!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->\n\t\t\t<div class="wp-block-buttons"><!-- wp:button -->\n\t\t\t<div class="wp-block-button"><a class="wp-block-button__link" href="' + (rt.call_function('esc_url', [var_shop_url.dup()])).str() + '">' + (rt.call_function('__', [rt.new_string('Go shopping'), rt.new_string('woocommerce')])).str() + '</a></div>\n\t\t\t<!-- /wp:button --></div>\n\t\t\t<!-- /wp:buttons --></div></div>\n\t\t\t<!-- /wp:cover -->'
	}
	return '<!-- wp:cover {"dimRatio":0} -->\n\t\t<div class="wp-block-cover"><div class="wp-block-cover__inner-container"><!-- wp:paragraph {"align":"center","placeholder":"' + (rt.call_function('__', [rt.new_string('Write title…'), rt.new_string('woocommerce')])).str() + '","textColor":"white","fontSize":"large"} -->\n\t\t<p class="has-text-color has-text-align-center has-large-font-size">' + (rt.call_function('__', [rt.new_string('Welcome to the store'), rt.new_string('woocommerce')])).str() + '</p>\n\t\t<!-- /wp:paragraph -->\n\n\t\t<!-- wp:paragraph {"align":"center","textColor":"white"} -->\n\t\t<p class="has-text-color has-text-align-center">' + (rt.call_function('__', [rt.new_string('Write a short welcome message here'), rt.new_string('woocommerce')])).str() + '</p>\n\t\t<!-- /wp:paragraph -->\n\n\t\t<!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->\n\t\t<div class="wp-block-buttons"><!-- wp:button -->\n\t\t<div class="wp-block-button"><a class="wp-block-button__link" href="' + (rt.call_function('esc_url', [var_shop_url.dup()])).str() + '">' + (rt.call_function('__', [rt.new_string('Go shopping'), rt.new_string('woocommerce')])).str() + '</a></div>\n\t\t<!-- /wp:button --></div>\n\t\t<!-- /wp:buttons --></div></div>\n\t\t<!-- /wp:cover -->'
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_media_block(var_image rt.PhpVal, align string) string {
	mut var_media_position := rt.new_string(if rt.is_true(rt.identical(rt.new_string('right'), rt.new_string(align))) { rt.new_string('"mediaPosition":"right",') } else { rt.new_string('') })
	mut var_css_class := rt.new_string(if rt.is_true(rt.identical(rt.new_string('right'), rt.new_string(align))) { rt.new_string(' has-media-on-the-right') } else { rt.new_string('') })
	if !(!rt.is_true(var_image.array_get('url'))) && !(!rt.is_true(var_image.array_get('id'))) {
		return '<!-- wp:media-text {' + (var_media_position).str() + '"mediaId":' + var_image.array_get('id').to_i64().str() + ',"mediaType":"image"} -->\n\t\t\t<div class="wp-block-media-text alignwide' + (var_css_class).str() + '""><figure class="wp-block-media-text__media"><img src="' + (rt.call_function('esc_url', [var_image.array_get('url')])).str() + '" alt="" class="wp-image-' + var_image.array_get('id').to_i64().str() + '"/></figure><div class="wp-block-media-text__content"><!-- wp:paragraph {"placeholder":"' + (rt.call_function('__', [rt.new_string('Content…'), rt.new_string('woocommerce')])).str() + '","fontSize":"large"} -->\n\t\t\t<p class="has-large-font-size"></p>\n\t\t\t<!-- /wp:paragraph --></div></div>\n\t\t\t<!-- /wp:media-text -->'
	}
	return '<!-- wp:media-text {' + (var_media_position).str() + '} -->\n\t\t<div class="wp-block-media-text alignwide' + (var_css_class).str() + '"><figure class="wp-block-media-text__media"></figure><div class="wp-block-media-text__content"><!-- wp:paragraph {"placeholder":"' + (rt.call_function('__', [rt.new_string('Content…'), rt.new_string('woocommerce')])).str() + '","fontSize":"large"} -->\n\t\t<p class="has-large-font-size"></p>\n\t\t<!-- /wp:paragraph --></div></div>\n\t\t<!-- /wp:media-text -->'
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_template(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_post_id_mutated := var_post_id
	mut var_products := rt.call_function('wp_count_posts', [rt.new_string('product')])
	if rt.is_true(rt.greater_equal(rt.get_property(var_products, 'publish'), rt.new_int(4))) {
		mut var_images := Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.sideload_homepage_images(var_post_id_mutated.dup(), rt.new_int(1))
		mut var_image_1 := if !(!rt.is_true(var_images.array_get(0))) { var_images.array_get(0) } else { rt.new_string('') }
		mut var_template := rt.new_string((Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_cover_block(var_image_1.dup())).str() + '\n\t\t\t\t<!-- wp:heading {"align":"center"} -->\n\t\t\t\t<h2 style="text-align:center">' + (rt.call_function('__', [rt.new_string('Shop by Category'), rt.new_string('woocommerce')])).str() + '</h2>\n\t\t\t\t<!-- /wp:heading -->\n\t\t\t\t<!-- wp:shortcode -->\n\t\t\t\t[product_categories number="0" parent="0"]\n\t\t\t\t<!-- /wp:shortcode -->\n\t\t\t\t<!-- wp:heading {"align":"center"} -->\n\t\t\t\t<h2 style="text-align:center">' + (rt.call_function('__', [rt.new_string('New In'), rt.new_string('woocommerce')])).str() + '</h2>\n\t\t\t\t<!-- /wp:heading -->\n\t\t\t\t<!-- wp:woocommerce/product-new {"columns":4} /-->\n\t\t\t\t<!-- wp:heading {"align":"center"} -->\n\t\t\t\t<h2 style="text-align:center">' + (rt.call_function('__', [rt.new_string('Fan Favorites'), rt.new_string('woocommerce')])).str() + '</h2>\n\t\t\t\t<!-- /wp:heading -->\n\t\t\t\t<!-- wp:woocommerce/product-top-rated {"columns":4} /-->\n\t\t\t\t<!-- wp:heading {"align":"center"} -->\n\t\t\t\t<h2 style="text-align:center">' + (rt.call_function('__', [rt.new_string('On Sale'), rt.new_string('woocommerce')])).str() + '</h2>\n\t\t\t\t<!-- /wp:heading -->\n\t\t\t\t<!-- wp:woocommerce/product-on-sale {"columns":4} /-->\n\t\t\t\t<!-- wp:heading {"align":"center"} -->\n\t\t\t\t<h2 style="text-align:center">' + (rt.call_function('__', [rt.new_string('Best Sellers'), rt.new_string('woocommerce')])).str() + '</h2>\n\t\t\t\t<!-- /wp:heading -->\n\t\t\t\t<!-- wp:woocommerce/product-best-sellers {"columns":4} /-->\n\t\t\t')
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_onboarding_homepage_template'), var_template.dup()])
	}
	var_images = Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.sideload_homepage_images(var_post_id_mutated.dup(), rt.new_int(3))
	var_image_1 = if !(!rt.is_true(var_images.array_get(0))) { var_images.array_get(0) } else { rt.new_string('') }
	mut var_image_2 := if !(!rt.is_true(var_images.array_get(1))) { var_images.array_get(1) } else { rt.new_string('') }
	mut var_image_3 := if !(!rt.is_true(var_images.array_get(2))) { var_images.array_get(2) } else { rt.new_string('') }
	var_template = rt.new_string((Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_cover_block(var_image_1.dup())).str() + '\n\t\t<!-- wp:heading {"align":"center"} -->\n\t\t<h2 style="text-align:center">' + (rt.call_function('__', [rt.new_string('New Products'), rt.new_string('woocommerce')])).str() + '</h2>\n\t\t<!-- /wp:heading -->\n\n\t\t<!-- wp:woocommerce/product-new /--> ' + (Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_media_block((var_image_1).str(), rt.new_string('right'))).str() + (Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_media_block((var_image_2).str(), rt.new_string('left'))).str() + (Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_media_block((var_image_3).str(), rt.new_string('right'))).str() + '\n\n\t\t<!-- wp:woocommerce/featured-product /-->')
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_onboarding_homepage_template'), var_template.dup()])
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_available_homepage_images() rt.PhpVal {
	mut var_industry_images := rt.new_array()
	mut var_industries := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries{}; return temp.get_allowed_industries() }()
	{
		mut iter_1 := var_industries.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_label := item_1.val
			mut var_industry_slug := item_1.key
			var_industry_images.array_set(var_industry_slug, rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_onboarding_industry_image'), (rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/other-small.jpg', var_industry_slug.dup()]))
		}
	}
	return var_industry_images.dup()
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.sideload_homepage_images(var_post_id rt.PhpVal, var_number_of_images rt.PhpVal) rt.PhpVal {
	mut var_post_id_mutated := var_post_id
	mut var_profile := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(), rt.new_array()])
	mut var_images_to_sideload := rt.new_array()
	mut var_available_images := Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_available_homepage_images()
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	rt.include_file(().str() + , '4')
	if !(!rt.is_true(.array_get())) {
		{
			mut iter_1 := .iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_selected_industry := item_1.val
			}
		}
	}
	if rt.is_true() {
	}
	
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.create_homepage() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) get_task_list_params() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) get_tasks(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) dismiss_task(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) undo_dismiss_task(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) snooze_task(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) undo_snooze_task(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) hide_task_list(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) unhide_task_list(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) action_task(var_request rt.PhpVal) rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Features {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_onboardingtasks() &Class_Automattic_WooCommerce_Admin_API_OnboardingTasks {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_OnboardingTasks{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-admin')
		rest_base: rt.new_string('onboarding/tasks')
		duration_to_ms: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_data_controller() &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasklists() &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_error() &Class_Automattic_WooCommerce_Admin_API_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features() &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingindustries() &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'create_products_permission_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.create_products_permission_check(dispatch_arg_0))
		}
		'create_pages_permission_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.create_pages_permission_check(dispatch_arg_0))
		}
		'get_tasks_permission_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_tasks_permission_check(dispatch_arg_0))
		}
		'hide_task_list_permission_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.hide_task_list_permission_check(dispatch_arg_0))
		}
		'snooze_task_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.snooze_task_permissions_check(dispatch_arg_0))
		}
		'import_sample_products_from_csv' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.import_sample_products_from_csv(dispatch_arg_0)
		}
		'import_sample_products' {
			return Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.import_sample_products()
		}
		'create_product_from_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.create_product_from_template(dispatch_arg_0)
		}
		'get_header_mappings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_header_mappings(dispatch_arg_0)
		}
		'sanitize_special_column_name_regex' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.sanitize_special_column_name_regex(dispatch_arg_0))
		}
		'get_homepage_cover_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_cover_block(dispatch_arg_0))
		}
		'get_homepage_media_block' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_media_block(dispatch_arg_0, dispatch_arg_1))
		}
		'get_homepage_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_template(dispatch_arg_0)
		}
		'get_available_homepage_images' {
			return Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_available_homepage_images()
		}
		'sideload_homepage_images' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.sideload_homepage_images(dispatch_arg_0, dispatch_arg_1)
		}
		'create_homepage' {
			return Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.create_homepage()
		}
		'get_task_list_params' {
			return this.get_task_list_params()
		}
		'get_tasks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_tasks(dispatch_arg_0)
		}
		'dismiss_task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.dismiss_task(dispatch_arg_0)
		}
		'undo_dismiss_task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.undo_dismiss_task(dispatch_arg_0)
		}
		'snooze_task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.snooze_task(dispatch_arg_0)
		}
		'undo_snooze_task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.undo_snooze_task(dispatch_arg_0)
		}
		'hide_task_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.hide_task_list(dispatch_arg_0)
		}
		'unhide_task_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.unhide_task_list(dispatch_arg_0)
		}
		'action_task' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.action_task(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'duration_to_ms' { return this.duration_to_ms }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'duration_to_ms' { this.duration_to_ms = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Features) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Admin_API_OnboardingTasks', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_api_onboardingtasks()
		return rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_api_wc_rest_data_controller()
		return rt.new_object('Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_onboardingtasks_tasklists()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_API_WP_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_api_wp_error()
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_Features', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_features()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_Features', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_admin_onboarding_onboardingindustries()
		return rt.new_object('Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_src_admin_api_onboardingtasks_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
