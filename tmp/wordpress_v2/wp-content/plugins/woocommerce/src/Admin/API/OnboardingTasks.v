import rt

struct Class_Automattic_WooCommerce_Admin_API_OnboardingTasks {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc-admin')
		rest_base rt.PhpVal = rt.new_string('onboarding/tasks')
		duration_to_ms rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/import_sample_products'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'import_sample_products' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_products_permission_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/create_homepage'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_homepage' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_pages_permission_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/create_product_from_template'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_product_from_template' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_products_permission_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [this.get_endpoint_args_for_item_schema(Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.creatable()), rt.create_array([rt.ArrayItem{ key: 'template_name', val: rt.create_array([rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Product template name.'), rt.new_string('woocommerce')]) }]) }])]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_0 := iife_temp_0.get_list_ids()
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str()), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_tasks' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_tasks_permission_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'ids', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Optional parameter to get only specific task lists by id.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_slug_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'enum', val: iife_result_0 }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_tasks' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_tasks_permission_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_task_list_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[a-z0-9_\\-]+)/hide'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'hide_task_list' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'hide_task_list_permission_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[a-z0-9_\\-]+)/unhide'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'unhide_task_list' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'hide_task_list_permission_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[a-z0-9_\\-]+)/dismiss'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'dismiss_task' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_tasks_permission_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[a-z0-9_\\-]+)/undo_dismiss'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'undo_dismiss_task' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_tasks_permission_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_param := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_key := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		return
		}
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[a-z0-9_-]+)/snooze'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'duration', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Time period to snooze the task.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_2_fn) }]) }, rt.ArrayItem{ key: 'task_list_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Optional parameter to query specific task list.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'snooze_task' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'snooze_task_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[a-z0-9_\\-]+)/action'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'action_task' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_tasks_permission_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[a-z0-9_\\-]+)/undo_snooze'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'undo_snooze_task' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'snooze_task_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_OnboardingTasks', ['Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) create_products_permission_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [rt.new_string('product'), rt.new_string('create')]))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) create_pages_permission_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [rt.new_string('page'), rt.new_string('create')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))))) {
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
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN), rt.new_string('7.8.0')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_woocommerce')]))))) {
		return (create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to snooze onboarding tasks.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.import_sample_products_from_csv(var_csv_file rt.PhpVal) rt.PhpVal {
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/import/class-wc-product-csv-importer.php', '2')
	if rt.is_true(rt.call_function('file_exists', [var_csv_file.clone()])) && rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Product_CSV_Importer')])) {
		rt.call_function('add_filter', [rt.new_string('locale'), rt.new_string('__return_false'), rt.new_int(9999)])
		mut var_importer_class := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_csv_importer_class'), rt.new_string('WC_Product_CSV_Importer')])
		mut var_args := rt.create_array([rt.ArrayItem{ key: 'parse', val: true }, rt.ArrayItem{ key: 'mapping', val: Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_header_mappings(var_csv_file.clone()) }])
		var_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_csv_importer_args'), var_args.clone(), var_importer_class.clone()])
		mut var_importer := rt.create_object_dynamically(var_importer_class, [var_csv_file.clone(), var_args.clone()])
		mut var_import := rt.call_method(var_importer, 'import', []rt.PhpVal{})
		return var_import.clone()
	} else {
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_import_error'), rt.call_function('__', [rt.new_string('Sorry, the sample products data file was not found.'), rt.new_string('woocommerce')])))
	}
	return rt.new_null()
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.import_sample_products() rt.PhpVal {
	mut iife_temp_2 := Class_Automattic_WooCommerce_Admin_Features_Features{}
	mut iife_result_2 := iife_temp_2.is_enabled(rt.new_string('experimental-fashion-sample-products'))
	mut var_sample_csv_file := rt.new_string((if rt.is_true(iife_result_2) { (rt.get_constant('WC_ABSPATH')).str() + 'sample-data/experimental_fashion_sample_9_products.csv' } else { (rt.get_constant('WC_ABSPATH')).str() + 'sample-data/experimental_sample_9_products.csv' }).str())
	mut var_import := Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.import_sample_products_from_csv(var_sample_csv_file.clone())
	return rt.call_function('rest_ensure_response', [var_import.clone()])
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.create_product_from_template(var_request rt.PhpVal) rt.PhpVal {
	mut var_template_name := rt.call_function('basename', [rt.call_method(var_request, 'get_param', [rt.new_string('template_name')])])
	mut var_template_path := rt.new_string(@DIR + '/Templates/' + (var_template_name).str() + '_product.csv')
	var_template_path = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_template_csv_file_path'), var_template_path.clone(), var_template_name.clone()])
	mut var_import := Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.import_sample_products_from_csv(var_template_path.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_import.clone()])) || !(var_import.array_get(rt.new_string('imported')).is_array()) || 0 == var_import.array_get(rt.new_string('imported')).array_count() {
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_product_creation_error'), rt.call_function('__', [rt.new_string('Sorry, creating the product with template failed.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	mut var_product := rt.call_function('wc_get_product', [var_import.array_get(rt.new_string('imported')).array_get(rt.new_int(0))])
	rt.call_method(var_product, 'set_status', [Class_Automattic_WooCommerce_Enums_ProductStatus.auto_draft()])
	rt.call_method(var_product, 'save', []rt.PhpVal{})
	return rt.call_function('rest_ensure_response', [rt.create_array([rt.ArrayItem{ key: 'id', val: rt.call_method(var_product, 'get_id', []rt.PhpVal{}) }])])
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_header_mappings(var_file rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/admin/importers/mappings/mappings.php', '2')
	mut var_importer_class := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_csv_importer_class'), rt.new_string('WC_Product_CSV_Importer')])
	mut var_importer := rt.create_object_dynamically(var_importer_class, [var_file.clone(), rt.new_array()])
	mut var_raw_headers := rt.call_method(var_importer, 'get_raw_keys', []rt.PhpVal{})
	mut var_default_columns := rt.call_function('wc_importer_default_english_mappings', [rt.new_array()])
	mut var_special_columns := rt.call_function('wc_importer_default_special_english_mappings', [rt.new_array()])
	mut var_headers := rt.new_array()
	mut iter_1 := var_raw_headers.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		mut var_key := item_1.key
		mut var_index := var_field
		var_headers.array_set(var_index, var_field.clone())
		if var_default_columns.array_isset(var_field) {
			var_headers.array_set(var_index, var_default_columns.array_get(var_field))
		} else {
			mut iter_2 := var_special_columns.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_special_key := item_2.val
				mut var_regex := item_2.key
				if rt.is_true(rt.call_function('preg_match', [Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.sanitize_special_column_name_regex(var_regex.clone()), var_field.clone(), var_matches.clone()])) {
					var_headers.array_set(var_index, (var_special_key).str() + (var_matches.array_get(rt.new_int(1))).str())
					break
				}
			}
		}
	}
	return var_headers.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.sanitize_special_column_name_regex(var_value rt.PhpVal) string {
	return '/' + (rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: '%d' }, rt.ArrayItem{ key: none, val: '%s' }]), rt.new_string('(.*)'), rt.new_string(rt.call_function('quotemeta', [var_value.clone()]).to_string().trim_space())])).str() + '/'
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_cover_block(var_image rt.PhpVal) string {
	mut var_shop_url := rt.call_function('wc_get_page_permalink', [rt.new_string('shop')])
	if !(!rt.is_true(var_image.array_get(rt.new_string('url')))) && !(!rt.is_true(var_image.array_get(rt.new_string('id')))) {
		return '<!-- wp:cover {"url":"' + (rt.call_function('esc_url', [var_image.array_get(rt.new_string('url'))])).str() + '","id":' + var_image.array_get(rt.new_string('id')).to_i64().str() + ',"dimRatio":0} -->\n\t\t\t<div class="wp-block-cover" style="background-image:url(' + (rt.call_function('esc_url', [var_image.array_get(rt.new_string('url'))])).str() + ')"><div class="wp-block-cover__inner-container"><!-- wp:paragraph {"align":"center","placeholder":"' + (rt.call_function('__', [rt.new_string('Write title…'), rt.new_string('woocommerce')])).str() + '","textColor":"white","fontSize":"large"} -->\n\t\t\t<p class="has-text-align-center has-large-font-size">' + (rt.call_function('__', [rt.new_string('Welcome to the store'), rt.new_string('woocommerce')])).str() + '</p>\n\t\t\t<!-- /wp:paragraph -->\n\n\t\t\t<!-- wp:paragraph {"align":"center","textColor":"white"} -->\n\t\t\t<p class="has-text-color has-text-align-center">' + (rt.call_function('__', [rt.new_string('Write a short welcome message here'), rt.new_string('woocommerce')])).str() + '</p>\n\t\t\t<!-- /wp:paragraph -->\n\n\t\t\t<!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->\n\t\t\t<div class="wp-block-buttons"><!-- wp:button -->\n\t\t\t<div class="wp-block-button"><a class="wp-block-button__link" href="' + (rt.call_function('esc_url', [var_shop_url.clone()])).str() + '">' + (rt.call_function('__', [rt.new_string('Go shopping'), rt.new_string('woocommerce')])).str() + '</a></div>\n\t\t\t<!-- /wp:button --></div>\n\t\t\t<!-- /wp:buttons --></div></div>\n\t\t\t<!-- /wp:cover -->'
	}
	return '<!-- wp:cover {"dimRatio":0} -->\n\t\t<div class="wp-block-cover"><div class="wp-block-cover__inner-container"><!-- wp:paragraph {"align":"center","placeholder":"' + (rt.call_function('__', [rt.new_string('Write title…'), rt.new_string('woocommerce')])).str() + '","textColor":"white","fontSize":"large"} -->\n\t\t<p class="has-text-color has-text-align-center has-large-font-size">' + (rt.call_function('__', [rt.new_string('Welcome to the store'), rt.new_string('woocommerce')])).str() + '</p>\n\t\t<!-- /wp:paragraph -->\n\n\t\t<!-- wp:paragraph {"align":"center","textColor":"white"} -->\n\t\t<p class="has-text-color has-text-align-center">' + (rt.call_function('__', [rt.new_string('Write a short welcome message here'), rt.new_string('woocommerce')])).str() + '</p>\n\t\t<!-- /wp:paragraph -->\n\n\t\t<!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->\n\t\t<div class="wp-block-buttons"><!-- wp:button -->\n\t\t<div class="wp-block-button"><a class="wp-block-button__link" href="' + (rt.call_function('esc_url', [var_shop_url.clone()])).str() + '">' + (rt.call_function('__', [rt.new_string('Go shopping'), rt.new_string('woocommerce')])).str() + '</a></div>\n\t\t<!-- /wp:button --></div>\n\t\t<!-- /wp:buttons --></div></div>\n\t\t<!-- /wp:cover -->'
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_media_block(var_image rt.PhpVal, align string) string {
	mut var_media_position := rt.new_string((if rt.is_true(rt.identical(rt.new_string('right'), rt.new_string(align))) { '"mediaPosition":"right",' } else { '' }).str())
	mut var_css_class := rt.new_string((if rt.is_true(rt.identical(rt.new_string('right'), rt.new_string(align))) { ' has-media-on-the-right' } else { '' }).str())
	if !(!rt.is_true(var_image.array_get(rt.new_string('url')))) && !(!rt.is_true(var_image.array_get(rt.new_string('id')))) {
		return '<!-- wp:media-text {' + (var_media_position).str() + '"mediaId":' + var_image.array_get(rt.new_string('id')).to_i64().str() + ',"mediaType":"image"} -->\n\t\t\t<div class="wp-block-media-text alignwide' + (var_css_class).str() + '""><figure class="wp-block-media-text__media"><img src="' + (rt.call_function('esc_url', [var_image.array_get(rt.new_string('url'))])).str() + '" alt="" class="wp-image-' + var_image.array_get(rt.new_string('id')).to_i64().str() + '"/></figure><div class="wp-block-media-text__content"><!-- wp:paragraph {"placeholder":"' + (rt.call_function('__', [rt.new_string('Content…'), rt.new_string('woocommerce')])).str() + '","fontSize":"large"} -->\n\t\t\t<p class="has-large-font-size"></p>\n\t\t\t<!-- /wp:paragraph --></div></div>\n\t\t\t<!-- /wp:media-text -->'
	}
	return '<!-- wp:media-text {' + (var_media_position).str() + '} -->\n\t\t<div class="wp-block-media-text alignwide' + (var_css_class).str() + '"><figure class="wp-block-media-text__media"></figure><div class="wp-block-media-text__content"><!-- wp:paragraph {"placeholder":"' + (rt.call_function('__', [rt.new_string('Content…'), rt.new_string('woocommerce')])).str() + '","fontSize":"large"} -->\n\t\t<p class="has-large-font-size"></p>\n\t\t<!-- /wp:paragraph --></div></div>\n\t\t<!-- /wp:media-text -->'
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_template(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_post_id_mutated := var_post_id
	mut var_products := rt.call_function('wp_count_posts', [rt.new_string('product')])
	if rt.is_true(rt.greater_equal(rt.get_property(var_products, 'publish'), rt.new_int(4))) {
		mut var_images := Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.sideload_homepage_images(var_post_id_mutated.clone(), rt.new_int(1))
		mut var_image_1 := if !(!rt.is_true(var_images.array_get(rt.new_int(0)))) { var_images.array_get(rt.new_int(0)) } else { rt.new_string('') }
		mut var_template := rt.new_string((Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_cover_block(var_image_1.clone())).str() + '\n\t\t\t\t<!-- wp:heading {"align":"center"} -->\n\t\t\t\t<h2 style="text-align:center">' + (rt.call_function('__', [rt.new_string('Shop by Category'), rt.new_string('woocommerce')])).str() + '</h2>\n\t\t\t\t<!-- /wp:heading -->\n\t\t\t\t<!-- wp:shortcode -->\n\t\t\t\t[product_categories number="0" parent="0"]\n\t\t\t\t<!-- /wp:shortcode -->\n\t\t\t\t<!-- wp:heading {"align":"center"} -->\n\t\t\t\t<h2 style="text-align:center">' + (rt.call_function('__', [rt.new_string('New In'), rt.new_string('woocommerce')])).str() + '</h2>\n\t\t\t\t<!-- /wp:heading -->\n\t\t\t\t<!-- wp:woocommerce/product-new {"columns":4} /-->\n\t\t\t\t<!-- wp:heading {"align":"center"} -->\n\t\t\t\t<h2 style="text-align:center">' + (rt.call_function('__', [rt.new_string('Fan Favorites'), rt.new_string('woocommerce')])).str() + '</h2>\n\t\t\t\t<!-- /wp:heading -->\n\t\t\t\t<!-- wp:woocommerce/product-top-rated {"columns":4} /-->\n\t\t\t\t<!-- wp:heading {"align":"center"} -->\n\t\t\t\t<h2 style="text-align:center">' + (rt.call_function('__', [rt.new_string('On Sale'), rt.new_string('woocommerce')])).str() + '</h2>\n\t\t\t\t<!-- /wp:heading -->\n\t\t\t\t<!-- wp:woocommerce/product-on-sale {"columns":4} /-->\n\t\t\t\t<!-- wp:heading {"align":"center"} -->\n\t\t\t\t<h2 style="text-align:center">' + (rt.call_function('__', [rt.new_string('Best Sellers'), rt.new_string('woocommerce')])).str() + '</h2>\n\t\t\t\t<!-- /wp:heading -->\n\t\t\t\t<!-- wp:woocommerce/product-best-sellers {"columns":4} /-->\n\t\t\t')
		return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_onboarding_homepage_template'), var_template.clone()])
	}
	var_images = Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.sideload_homepage_images(var_post_id_mutated.clone(), rt.new_int(3))
	var_image_1 = if !(!rt.is_true(var_images.array_get(rt.new_int(0)))) { var_images.array_get(rt.new_int(0)) } else { rt.new_string('') }
	mut var_image_2 := if !(!rt.is_true(var_images.array_get(rt.new_int(1)))) { var_images.array_get(rt.new_int(1)) } else { rt.new_string('') }
	mut var_image_3 := if !(!rt.is_true(var_images.array_get(rt.new_int(2)))) { var_images.array_get(rt.new_int(2)) } else { rt.new_string('') }
	var_template = rt.new_string((Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_cover_block(var_image_1.clone())).str() + '\n\t\t<!-- wp:heading {"align":"center"} -->\n\t\t<h2 style="text-align:center">' + (rt.call_function('__', [rt.new_string('New Products'), rt.new_string('woocommerce')])).str() + '</h2>\n\t\t<!-- /wp:heading -->\n\n\t\t<!-- wp:woocommerce/product-new /--> ' + (Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_media_block((var_image_1).str(), rt.new_string('right'))).str() + (Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_media_block((var_image_2).str(), rt.new_string('left'))).str() + (Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_media_block((var_image_3).str(), rt.new_string('right'))).str() + '\n\n\t\t<!-- wp:woocommerce/featured-product /-->')
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_onboarding_homepage_template'), var_template.clone()])
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_available_homepage_images() rt.PhpVal {
	mut var_industry_images := rt.new_array()
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries{}
	mut iife_result_3 := iife_temp_3.get_allowed_industries()
	mut var_industries := iife_result_3
	mut iter_3 := var_industries.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_label := item_3.val
		mut var_industry_slug := item_3.key
		var_industry_images.array_set(var_industry_slug, rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_onboarding_industry_image'), rt.new_string((rt.get_constant('WC_ADMIN_IMAGES_FOLDER_URL')).str() + '/onboarding/other-small.jpg'), var_industry_slug.clone()]))
	}
	return var_industry_images.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.sideload_homepage_images(var_post_id rt.PhpVal, var_number_of_images rt.PhpVal) rt.PhpVal {
	mut var_post_id_mutated := var_post_id
	mut var_profile := rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingProfile.data_option(), rt.new_array()])
	mut var_images_to_sideload := rt.new_array()
	mut var_available_images := Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_available_homepage_images()
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/media.php', '4')
	if !(!rt.is_true(var_profile.array_get(rt.new_string('industry')))) {
		mut iter_4 := var_profile.array_get(rt.new_string('industry')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_selected_industry := item_4.val
			if rt.is_true(rt.new_bool(var_selected_industry.clone().is_string())) {
			mut var_industry_slug := var_selected_industry
			} else if var_selected_industry.clone().is_array() && !(!rt.is_true(var_selected_industry.array_get(rt.new_string('slug')))) {
			var_industry_slug = var_selected_industry.array_get(rt.new_string('slug'))
			} else {
				continue
			}
			mut var_first_industry := if !(var_first_industry).is_null() { var_first_industry } else { var_industry_slug }
			var_images_to_sideload.array_push(if !(!rt.is_true(var_available_images.array_get(var_industry_slug))) { var_available_images.array_get(var_industry_slug) } else { var_available_images.array_get(rt.new_string('other')) })
		}
	}
	if rt.is_true(rt.less(rt.new_int(var_images_to_sideload.clone().array_count()), var_number_of_images)) {
		mut var_i := rt.new_int(var_images_to_sideload.clone().array_count())
		for {
			if !(rt.is_true(rt.less(var_i, var_number_of_images))) { break }
			mut var_industry := if !(var_first_industry).is_null() { var_first_industry } else { rt.new_string('other') }
			var_images_to_sideload.array_push(if !rt.is_true(var_available_images.array_get(var_industry)) { var_available_images.array_get(rt.new_string('other')) } else { var_available_images.array_get(var_industry) })
			rt.post_inc(var_i)
		}
	}
	mut var_already_sideloaded := rt.new_array()
	mut var_images_for_post := rt.new_array()
	mut iter_5 := var_images_to_sideload.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_image := item_5.val
		if !(!rt.is_true(var_already_sideloaded.array_get(var_image))) {
			var_images_for_post.array_push(var_already_sideloaded.array_get(var_image))
			continue
		}
		mut var_sideload_id := rt.call_function('media_sideload_image', [var_image.clone(), var_post_id_mutated.clone(), rt.new_null(), rt.new_string('id')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_sideload_id.clone()]))))) {
			mut var_sideload_url := rt.call_function('wp_get_attachment_url', [var_sideload_id.clone()])
			var_already_sideloaded.array_set(var_image, rt.create_array([rt.ArrayItem{ key: 'id', val: var_sideload_id }, rt.ArrayItem{ key: 'url', val: var_sideload_url }]))
			var_images_for_post.array_push(var_already_sideloaded.array_get(var_image))
		}
	}
	return var_images_for_post.clone()
}

fn Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.create_homepage() rt.PhpVal {
	mut var_post_id := rt.call_function('wp_insert_post', [rt.create_array([rt.ArrayItem{ key: 'post_title', val: rt.call_function('__', [rt.new_string('Homepage'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'post_type', val: 'page' }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'post_content', val: '' }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_post_id.clone()]))))) && rt.is_true(rt.less(rt.new_int(0), var_post_id)) {
		mut var_template := Class_Automattic_WooCommerce_Admin_API_OnboardingTasks.get_homepage_template(var_post_id.clone())
		rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_post_id }, rt.ArrayItem{ key: 'post_content', val: var_template }])])
		rt.call_function('update_option', [rt.new_string('show_on_front'), rt.new_string('page')])
		rt.call_function('update_option', [rt.new_string('page_on_front'), var_post_id.clone()])
		rt.call_function('update_option', [rt.new_string('woocommerce_onboarding_homepage_post_id'), var_post_id.clone()])
		if rt.is_true(rt.identical(rt.new_string('storefront'), rt.call_function('get_stylesheet', []rt.PhpVal{}))) {
			rt.call_function('update_post_meta', [var_post_id.clone(), rt.new_string('_wp_page_template'), rt.new_string('template-fullwidth.php')])
		}
		return rt.create_array([rt.ArrayItem{ key: 'status', val: 'success' }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Homepage created'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'post_id', val: var_post_id }, rt.ArrayItem{ key: 'edit_post_link', val: rt.call_function('htmlspecialchars_decode', [rt.call_function('get_edit_post_link', [var_post_id.clone()])]) }])
	} else {
		return var_post_id.clone()
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) get_task_list_params() rt.PhpVal {
	mut var_params := rt.new_array()
	mut iife_temp_4 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_4 := iife_temp_4.get_list_ids()
	var_params.array_set('ids', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Optional parameter to get only specific task lists by id.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_parse_slug_list' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'enum', val: iife_result_4 }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]))
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_param := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_request := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		mut var_key := if args.len > 2 { args[2].clone() } else { rt.new_null() }
		mut var_has_valid_keys := rt.new_bool(true)
		mut iter_6 := var_param.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_task := item_6.val
			if rt.is_true(var_has_valid_keys) {
			var_has_valid_keys = rt.new_bool(rt.is_true(rt.new_bool(var_task.clone().array_isset(rt.new_string('list_id')))) && rt.is_true(rt.new_bool(var_task.clone().array_isset(rt.new_string('id')))))
			}
		}
		return var_has_valid_keys.clone()
		}
	var_params.array_set('extended_tasks', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('List of extended deprecated tasks from the client side filter.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_6_fn) }]))
	return var_params.clone()
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) get_tasks(var_request rt.PhpVal) rt.PhpVal {
	mut var_extended_tasks := rt.call_method(var_request, 'get_param', [rt.new_string('extended_tasks')])
	mut var_task_list_ids := rt.call_method(var_request, 'get_param', [rt.new_string('ids')])
	mut iife_temp_6 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_6 := iife_temp_6.maybe_add_extended_tasks(var_extended_tasks.clone())
	mut iife_temp_7 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_7 := iife_temp_7.get_lists_by_ids(var_task_list_ids.clone())
	mut iife_temp_8 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_8 := iife_temp_8.get_lists()
	mut var_lists := if var_task_list_ids.clone().is_array() && var_task_list_ids.clone().array_count() > 0 { iife_result_7 } else { iife_result_8 }
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_list := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(rt.call_method(var_list, 'sort_tasks', []rt.PhpVal{}), 'get_json', []rt.PhpVal{})
		}
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_list := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(rt.call_method(var_list, 'sort_tasks', []rt.PhpVal{}), 'get_json', []rt.PhpVal{})
		}
	mut var_json := rt.call_function('array_map', [rt.new_closure(closure_10_fn), var_lists.clone()])
	return rt.call_function('rest_ensure_response', [rt.call_function('array_values', [rt.call_function('apply_filters', [rt.new_string('woocommerce_admin_onboarding_tasks'), var_json.clone()])])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) dismiss_task(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.call_method(var_request, 'get_param', [rt.new_string('id')])
	mut iife_temp_11 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_11 := iife_temp_11.get_task(var_id.clone())
	mut var_task := iife_result_11
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task)))) && rt.is_true(var_id) {
	var_task = create_automattic_woocommerce_admin_features_onboardingtasks_deprecatedextendedtask(rt.new_null(), rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'is_dismissable', val: true }]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_task, 'is_dismissable', []rt.PhpVal{}))))) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_invalid_task'), rt.call_function('__', [rt.new_string('Sorry, no dismissable task with that ID was found.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	rt.call_method(var_task, 'dismiss', []rt.PhpVal{})
	return rt.call_function('rest_ensure_response', [rt.call_method(var_task, 'get_json', []rt.PhpVal{})])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) undo_dismiss_task(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.call_method(var_request, 'get_param', [rt.new_string('id')])
	mut iife_temp_12 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_12 := iife_temp_12.get_task(var_id.clone())
	mut var_task := iife_result_12
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task)))) && rt.is_true(var_id) {
	var_task = create_automattic_woocommerce_admin_features_onboardingtasks_deprecatedextendedtask(rt.new_null(), rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'is_dismissable', val: true }]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_task, 'is_dismissable', []rt.PhpVal{}))))) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_invalid_task'), rt.call_function('__', [rt.new_string('Sorry, no dismissable task with that ID was found.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	rt.call_method(var_task, 'undo_dismiss', []rt.PhpVal{})
	return rt.call_function('rest_ensure_response', [rt.call_method(var_task, 'get_json', []rt.PhpVal{})])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) snooze_task(var_request rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN), rt.new_string('7.8.0')])
	mut var_task_id := rt.call_method(var_request, 'get_param', [rt.new_string('id')])
	mut var_task_list_id := rt.call_method(var_request, 'get_param', [rt.new_string('task_list_id')])
	mut var_duration := rt.call_method(var_request, 'get_param', [rt.new_string('duration')])
	mut iife_temp_13 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_13 := iife_temp_13.get_task(var_task_id.clone(), var_task_list_id.clone())
	mut var_task := iife_result_13
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task)))) && rt.is_true(var_task_id) {
	var_task = create_automattic_woocommerce_admin_features_onboardingtasks_deprecatedextendedtask(rt.new_null(), rt.create_array([rt.ArrayItem{ key: 'id', val: var_task_id }, rt.ArrayItem{ key: 'is_snoozeable', val: true }]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_task, 'is_snoozeable', []rt.PhpVal{}))))) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_invalid_task'), rt.call_function('__', [rt.new_string('Sorry, no snoozeable task with that ID was found.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	rt.call_method(var_task, 'snooze', [if !(var_duration).is_null() { var_duration } else { rt.new_string('day') }])
	return rt.call_function('rest_ensure_response', [rt.call_method(var_task, 'get_json', []rt.PhpVal{})])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) undo_snooze_task(var_request rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string(@STRUCT + '::' + @FN), rt.new_string('7.8.0')])
	mut var_id := rt.call_method(var_request, 'get_param', [rt.new_string('id')])
	mut iife_temp_14 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_14 := iife_temp_14.get_task(var_id.clone())
	mut var_task := iife_result_14
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task)))) && rt.is_true(var_id) {
	var_task = create_automattic_woocommerce_admin_features_onboardingtasks_deprecatedextendedtask(rt.new_null(), rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'is_snoozeable', val: true }]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_task, 'is_snoozeable', []rt.PhpVal{}))))) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_invalid_task'), rt.call_function('__', [rt.new_string('Sorry, no snoozeable task with that ID was found.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	rt.call_method(var_task, 'undo_snooze', []rt.PhpVal{})
	return rt.call_function('rest_ensure_response', [rt.call_method(var_task, 'get_json', []rt.PhpVal{})])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) hide_task_list(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.call_method(var_request, 'get_param', [rt.new_string('id')])
	mut iife_temp_15 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_15 := iife_temp_15.get_list(var_id.clone())
	mut var_task_list := iife_result_15
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task_list)))) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_invalid_task_list'), rt.call_function('__', [rt.new_string('Sorry, that task list was not found'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_update := rt.call_method(var_task_list, 'hide', []rt.PhpVal{})
	mut var_json := rt.call_method(var_task_list, 'get_json', []rt.PhpVal{})
	return rt.call_function('rest_ensure_response', [var_json.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) unhide_task_list(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.call_method(var_request, 'get_param', [rt.new_string('id')])
	mut iife_temp_16 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_16 := iife_temp_16.get_list(var_id.clone())
	mut var_task_list := iife_result_16
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task_list)))) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_tasks_invalid_task_list'), rt.call_function('__', [rt.new_string('Sorry, that task list was not found'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_update := rt.call_method(var_task_list, 'unhide', []rt.PhpVal{})
	mut var_json := rt.call_method(var_task_list, 'get_json', []rt.PhpVal{})
	return rt.call_function('rest_ensure_response', [var_json.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_OnboardingTasks) action_task(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.call_method(var_request, 'get_param', [rt.new_string('id')])
	mut iife_temp_17 := Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{}
	mut iife_result_17 := iife_temp_17.get_task(var_id.clone())
	mut var_task := iife_result_17
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task)))) && rt.is_true(var_id) {
	var_task = create_automattic_woocommerce_admin_features_onboardingtasks_deprecatedextendedtask(rt.new_null(), rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_task)))) {
		return rt.new_object('Automattic_WooCommerce_Admin_API_WP_Error', []string{}, create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_rest_invalid_task'), rt.call_function('__', [rt.new_string('Sorry, no task with that ID was found.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	rt.call_method(var_task, 'mark_actioned', []rt.PhpVal{})
	return rt.call_function('rest_ensure_response', [rt.call_method(var_task, 'get_json', []rt.PhpVal{})])
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

struct Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_onboardingtasks(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_OnboardingTasks {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_OnboardingTasks{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc-admin')
		rest_base: rt.new_string('onboarding/tasks')
		duration_to_ms: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wc_rest_data_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WC_REST_Data_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_tasklists(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_TaskLists{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_API_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_features(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_Features {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Features{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_onboarding_onboardingindustries(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Onboarding_OnboardingIndustries{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_onboardingtasks_deprecatedextendedtask(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask{
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


fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	rt.register_class_factory('Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_features_onboardingtasks_deprecatedextendedtask()
		return rt.new_object('Automattic_WooCommerce_Admin_Features_OnboardingTasks_DeprecatedExtendedTask', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
