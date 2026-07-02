import rt

pub fn Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator.products_per_generation_step() i64 {
	return 100
}
struct Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator {
	rt.PhpObjectBase
pub mut:
		data_store rt.PhpVal = rt.new_null()
		lookup_table_name rt.PhpVal = rt.new_null()
		last_regeneration_step_failed bool
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) construct() {
	mut var_wpdb := rt.new_null()
	this.lookup_table_name = (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_product_attributes_lookup'
	rt.call_function('add_filter', [rt.new_string('woocommerce_debug_tools'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_initiate_regeneration_entry_to_tools_array' }]), rt.new_int(1), rt.new_int(999)])
	rt.call_function('add_action', [rt.new_string('woocommerce_run_product_attribute_lookup_regeneration_callback'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'run_regeneration_step_callback' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_installed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'run_woocommerce_installed_callback' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) init(mut var_data_store Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore) {
	this.data_store = var_data_store
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) get_last_regeneration_step_failed() bool {
	return this.last_regeneration_step_failed
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) initiate_regeneration(in_background bool) i64 {
	this.check_can_do_lookup_table_regeneration(rt.new_null())
	this.enable_or_disable_lookup_table_usage(rt.new_bool(false))
	this.delete_all_attributes_lookup_data(true)
	mut var_last_product_id := rt.new_int(this.initialize_table_and_data())
	if rt.is_true(rt.greater(var_last_product_id, rt.new_int(0))) {
		rt.call_method(this.data_store, 'set_regeneration_in_progress_flag', []rt.PhpVal{})
		if var_in_background {
			this.enqueue_regeneration_step_run()
		}
	} else {
		this.finalize_regeneration(true)
	}
	return (var_last_product_id).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) delete_all_attributes_lookup_data(truncate_table bool) {
	mut var_wpdb := rt.new_null()
	rt.call_function('delete_option', [rt.new_string('woocommerce_attribute_lookup_enabled')])
	rt.call_function('delete_option', [rt.new_string('woocommerce_attribute_lookup_last_product_id_to_process')])
	rt.call_function('delete_option', [rt.new_string('woocommerce_attribute_lookup_processed_count')])
	rt.call_method(this.data_store, 'unset_regeneration_in_progress_flag', []rt.PhpVal{})
	rt.call_method(this.data_store, 'unset_regeneration_aborted_flag', []rt.PhpVal{})
	if var_truncate_table && rt.is_true(rt.call_method(this.data_store, 'check_lookup_table_exists', []rt.PhpVal{})) {
		this.truncate_lookup_table()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) truncate_lookup_table() {
	mut var_wpdb := rt.new_null()
	rt.call_method(var_wpdb, 'query', [rt.concat(rt.new_string('TRUNCATE TABLE '), this.lookup_table_name)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) initialize_table_and_data() i64 {
	mut var_database_util := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil.class()])
	rt.call_method(var_database_util, 'dbdelta', [rt.new_string(this.get_table_creation_sql())])
	mut var_last_existing_product_id := rt.new_int(this.get_last_existing_product_id())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_last_existing_product_id)))) {
		return 0
	}
	rt.call_function('update_option', [rt.new_string('woocommerce_attribute_lookup_last_product_id_to_process'), var_last_existing_product_id.clone()])
	rt.call_function('update_option', [rt.new_string('woocommerce_attribute_lookup_processed_count'), rt.new_int(0)])
	return (var_last_existing_product_id).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) get_last_existing_product_id() i64 {
	mut var_last_existing_product_id_array := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('wc_get_products'), rt.create_array([rt.ArrayItem{ key: 'return', val: 'ids' }, rt.ArrayItem{ key: 'limit', val: 1 }, rt.ArrayItem{ key: 'orderby', val: rt.create_array([rt.ArrayItem{ key: 'ID', val: 'DESC' }]) }])])
	return (if !rt.is_true(var_last_existing_product_id_array) { rt.new_null() } else { rt.call_function('current', [var_last_existing_product_id_array.clone()]) }).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) run_regeneration_step_callback() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_store, 'regeneration_is_in_progress', []rt.PhpVal{}))))) {
		rt.call_method(this.data_store, 'set_regeneration_aborted_flag', []rt.PhpVal{})
		this.finalize_regeneration(false)
		return
	}
	mut var_result := rt.new_bool(this.do_regeneration_step(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_?int](rt.new_null()), (rt.call_method(this.data_store, 'optimized_data_access_is_enabled', []rt.PhpVal{})).to_bool()))
	if rt.is_true(var_result) {
		this.enqueue_regeneration_step_run()
	} else {
		this.finalize_regeneration(true)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) enqueue_regeneration_step_run() {
	mut var_queue := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'get_instance_of', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Queue.class()])
	rt.call_method(var_queue, 'schedule_single', [rt.add(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('time')]), rt.new_int(1)), rt.new_string('woocommerce_run_product_attribute_lookup_regeneration_callback'), rt.new_array(), rt.new_string('woocommerce-db-updates')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) do_regeneration_step(mut var_step_size Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_?int, use_optimized_db_access bool) bool {
	mut var_products_per_generation_step := rt.call_function('apply_filters', [rt.new_string('woocommerce_attribute_lookup_regeneration_step_size'), if !(var_step_size).is_null() { var_step_size } else { Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator.products_per_generation_step() }])
	mut var_products_already_processed := rt.call_function('get_option', [rt.new_string('woocommerce_attribute_lookup_processed_count'), rt.new_int(0)])
	mut var_product_ids := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [rt.new_string('wc_get_products'), rt.create_array([rt.ArrayItem{ key: 'limit', val: var_products_per_generation_step }, rt.ArrayItem{ key: 'offset', val: var_products_already_processed }, rt.ArrayItem{ key: 'orderby', val: rt.create_array([rt.ArrayItem{ key: 'ID', val: 'ASC' }]) }, rt.ArrayItem{ key: 'return', val: 'ids' }])])
	if !(var_product_ids.clone().is_array()) || !rt.is_true(var_product_ids) {
		return false
	}
	this.last_regeneration_step_failed = false
	mut iter_1 := var_product_ids.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_id := item_1.val
		rt.call_method(this.data_store, 'create_data_for_product', [var_id.clone(), rt.new_bool(use_optimized_db_access)])
		this.last_regeneration_step_failed = this.last_regeneration_step_failed || rt.is_true(rt.call_method(this.data_store, 'get_last_create_operation_failed', []rt.PhpVal{}))
	}
	var_products_already_processed = rt.add(var_products_already_processed, rt.new_int(var_product_ids.clone().array_count()))
	rt.call_function('update_option', [rt.new_string('woocommerce_attribute_lookup_processed_count'), var_products_already_processed.clone()])
	mut var_last_product_id_to_process := rt.call_function('get_option', [rt.new_string('woocommerce_attribute_lookup_last_product_id_to_process'), rt.get_constant('PHP_INT_MAX')])
	return (rt.less(rt.call_function('end', [var_product_ids.clone()]), var_last_product_id_to_process)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) finalize_regeneration(enable_usage bool) {
	this.cancel_regeneration_scheduled_action()
	this.delete_all_attributes_lookup_data(false)
	rt.call_function('update_option', [rt.new_string('woocommerce_attribute_lookup_enabled'), rt.new_string((if var_enable_usage { 'yes' } else { 'no' }).str())])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) add_initiate_regeneration_entry_to_tools_array(mut var_tools_array Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array) rt.PhpVal {
	mut var_tools_array_mutated := var_tools_array
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_store, 'check_lookup_table_exists', []rt.PhpVal{}))))) {
		return rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_array', []string{}, var_tools_array_mutated)
	}
	mut var_generation_is_in_progress := rt.call_method(this.data_store, 'regeneration_is_in_progress', []rt.PhpVal{})
	mut var_generation_was_aborted := rt.call_method(this.data_store, 'regeneration_was_aborted', []rt.PhpVal{})
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		this.initiate_regeneration_from_tools_page()
		return rt.call_function('__', [rt.new_string('Product attributes lookup table data is regenerating'), rt.new_string('woocommerce')])
		}
	mut var_entry := rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Regenerate the product attributes lookup table'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('This tool will regenerate the product attributes lookup table data from existing product(s) data. This process may take a while.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'requires_refresh', val: true }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'selector', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Select a product to regenerate the data for, or leave empty for a full table regeneration:'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'class', val: 'wc-product-search' }, rt.ArrayItem{ key: 'search_action', val: 'woocommerce_json_search_products' }, rt.ArrayItem{ key: 'name', val: 'regenerate_product_attribute_lookup_data_product_id' }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('esc_attr__', [rt.new_string('Search for a product&hellip;'), rt.new_string('woocommerce')]) }]) }])
	if rt.is_true(var_generation_is_in_progress) {
		var_entry.array_set('button', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Filling in progress (%d)'), rt.new_string('woocommerce')]), rt.call_function('get_option', [rt.new_string('woocommerce_attribute_lookup_processed_count'), rt.new_int(0)])]))
		var_entry.array_set('disabled', true)
	} else {
		var_entry.array_set('button', rt.call_function('__', [rt.new_string('Regenerate'), rt.new_string('woocommerce')]))
	}
	var_tools_array_mutated.array_set('regenerate_product_attributes_lookup_table', var_entry.clone())
	if rt.is_true(var_generation_is_in_progress) {
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			this.abort_regeneration(true)
			return rt.call_function('__', [rt.new_string('Product attributes lookup table regeneration process has been aborted.'), rt.new_string('woocommerce')])
			}
		var_entry = rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Abort the product attributes lookup table regeneration'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [rt.new_string('This tool will abort the regenerate product attributes lookup table regeneration. After this is done the process can be either started over, or resumed to continue where it stopped.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'requires_refresh', val: true }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Abort'), rt.new_string('woocommerce')]) }])
		var_tools_array_mutated.array_set('abort_product_attributes_lookup_table_regeneration', var_entry.clone())
	} else if rt.is_true(var_generation_was_aborted) {
		mut var_processed_count := rt.call_function('get_option', [rt.new_string('woocommerce_attribute_lookup_processed_count'), rt.new_int(0)])
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			this.resume_regeneration(true)
			return rt.call_function('__', [rt.new_string('Product attributes lookup table regeneration process has been resumed.'), rt.new_string('woocommerce')])
			}
		var_entry = rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [rt.new_string('Resume the product attributes lookup table regeneration'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('This tool will resume the product attributes lookup table regeneration at the point in which it was aborted (%1$s products were already processed).'), rt.new_string('woocommerce')]), var_processed_count.clone()]) }, rt.ArrayItem{ key: 'requires_refresh', val: true }, rt.ArrayItem{ key: 'callback', val: rt.new_closure(closure_3_fn) }, rt.ArrayItem{ key: 'button', val: rt.call_function('__', [rt.new_string('Resume'), rt.new_string('woocommerce')]) }])
		var_tools_array_mutated.array_set('resume_product_attributes_lookup_table_regeneration', var_entry.clone())
	}
	return rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_array', []string{}, var_tools_array_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) initiate_regeneration_from_tools_page() {
	this.verify_tool_execution_nonce()
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('regenerate_product_attribute_lookup_data_product_id')) {
		mut var_product_id := rt.new_int((rt.get_superglobal('_REQUEST').array_get(rt.new_string('regenerate_product_attribute_lookup_data_product_id'))).to_i64())
		this.check_can_do_lookup_table_regeneration(var_product_id.clone())
		rt.call_method(this.data_store, 'create_data_for_product', [var_product_id.clone(), rt.call_method(this.data_store, 'optimized_data_access_is_enabled', []rt.PhpVal{})])
	} else {
		this.initiate_regeneration(false)
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) enable_or_disable_lookup_table_usage(var_enable rt.PhpVal) {
	if rt.is_true(rt.call_method(this.data_store, 'regeneration_is_in_progress', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception', []string{}, create_automattic_woocommerce_internal_productattributeslookup_exception(rt.new_string('Can\'t enable or disable the attributes lookup table usage while it\'s regenerating.'))))
	}
	rt.call_function('update_option', [rt.new_string('woocommerce_attribute_lookup_enabled'), rt.new_string((if rt.is_true(var_enable) { 'yes' } else { 'no' }).str())])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) check_can_do_lookup_table_regeneration(var_product_id rt.PhpVal) {
	mut var_product_id_mutated := var_product_id
	if rt.is_true(var_product_id_mutated) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_store, 'check_lookup_table_exists', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception', []string{}, create_automattic_woocommerce_internal_productattributeslookup_exception(rt.new_string('Can\'t do product attribute lookup data regeneration: lookup table doesn\'t exist'))))
	}
	if rt.is_true(rt.call_method(this.data_store, 'regeneration_is_in_progress', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception', []string{}, create_automattic_woocommerce_internal_productattributeslookup_exception(rt.new_string('Can\'t do product attribute lookup data regeneration: regeneration is already in progress'))))
	}
	if rt.is_true(var_product_id_mutated) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_get_product', [var_product_id_mutated.clone()]))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception', []string{}, create_automattic_woocommerce_internal_productattributeslookup_exception(rt.new_string('Can\'t do product attribute lookup data regeneration: product doesn\'t exist'))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) abort_regeneration(verify_nonce bool) {
	if var_verify_nonce {
		this.verify_tool_execution_nonce()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_store, 'check_lookup_table_exists', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception', []string{}, create_automattic_woocommerce_internal_productattributeslookup_exception(rt.new_string('Can\'t abort the product attribute lookup data regeneration process: lookup table doesn\'t exist'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_store, 'regeneration_is_in_progress', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception', []string{}, create_automattic_woocommerce_internal_productattributeslookup_exception(rt.new_string('Can\'t abort the product attribute lookup data regeneration process since it\'s not currently in progress'))))
	}
	this.cancel_regeneration_scheduled_action()
	rt.call_method(this.data_store, 'unset_regeneration_in_progress_flag', []rt.PhpVal{})
	rt.call_method(this.data_store, 'set_regeneration_aborted_flag', []rt.PhpVal{})
	this.enable_or_disable_lookup_table_usage(rt.new_bool(false))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) cancel_regeneration_scheduled_action() {
	mut var_queue := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'get_instance_of', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Queue.class()])
	rt.call_method(var_queue, 'cancel_all', [rt.new_string('woocommerce_run_product_attribute_lookup_regeneration_callback')])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) has_scheduled_action_for_regeneration_step() bool {
	mut var_queue := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'get_instance_of', [Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_WC_Queue.class()])
	mut var_actions := rt.call_method(var_queue, 'search', [rt.create_array([rt.ArrayItem{ key: 'hook', val: 'woocommerce_run_product_attribute_lookup_regeneration_callback' }, rt.ArrayItem{ key: 'status', val: Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_ActionScheduler_Store.status_pending() }]), rt.new_string('ids')])
	return !(!rt.is_true(var_actions))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) resume_regeneration(verify_nonce bool) {
	if var_verify_nonce {
		this.verify_tool_execution_nonce()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_store, 'check_lookup_table_exists', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception', []string{}, create_automattic_woocommerce_internal_productattributeslookup_exception(rt.new_string('Can\'t resume the product attribute lookup data regeneration process: lookup table doesn\'t exist'))))
	}
	if rt.is_true(rt.call_method(this.data_store, 'regeneration_is_in_progress', []rt.PhpVal{})) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception', []string{}, create_automattic_woocommerce_internal_productattributeslookup_exception(rt.new_string('Can\'t resume the product attribute lookup data regeneration process: regeneration is already in progress'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_store, 'regeneration_was_aborted', []rt.PhpVal{}))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception', []string{}, create_automattic_woocommerce_internal_productattributeslookup_exception(rt.new_string('Can\'t resume the product attribute lookup data regeneration process: no aborted regeneration process exists'))))
	}
	rt.call_method(this.data_store, 'unset_regeneration_aborted_flag', []rt.PhpVal{})
	rt.call_method(this.data_store, 'set_regeneration_in_progress_flag', []rt.PhpVal{})
	this.enqueue_regeneration_step_run()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) verify_tool_execution_nonce() {
	if !(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('_wpnonce'))) || rt.is_true(rt.identical(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('_wpnonce')), rt.new_string('debug_action')]), rt.new_bool(false))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception', []string{}, create_automattic_woocommerce_internal_productattributeslookup_exception(rt.new_string('Invalid nonce'))))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) get_lookup_table_name() rt.PhpVal {
	return this.lookup_table_name
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) get_table_creation_sql() string {
	mut var_wpdb := rt.new_null()
	mut var_collate := if rt.is_true(rt.call_method(var_wpdb, 'has_cap', [rt.new_string('collation')])) { rt.call_method(var_wpdb, 'get_charset_collate', []rt.PhpVal{}) } else { rt.new_string('') }
	return rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('CREATE TABLE '), this.lookup_table_name), rt.new_string(' (\n product_id bigint(20) NOT NULL,\n product_or_parent_id bigint(20) NOT NULL,\n taxonomy varchar(32) NOT NULL,\n term_id bigint(20) NOT NULL,\n is_variation_attribute tinyint(1) NOT NULL,\n in_stock tinyint(1) NOT NULL,\n INDEX is_variation_attribute_term_id (is_variation_attribute, term_id),\n PRIMARY KEY  ( `product_or_parent_id`, `term_id`, `product_id`, `taxonomy` ),\n KEY product_id (product_id)\n) ')), var_collate), rt.new_string(';'))
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) create_table_primary_index() {
	mut var_database_util := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_DatabaseUtil.class()])
	rt.call_method(var_database_util, 'create_primary_key', [this.lookup_table_name, rt.create_array([rt.ArrayItem{ key: none, val: 'product_or_parent_id' }, rt.ArrayItem{ key: none, val: 'term_id' }, rt.ArrayItem{ key: none, val: 'product_id' }, rt.ArrayItem{ key: none, val: 'taxonomy' }])])
	rt.call_method(var_database_util, 'drop_table_index', [this.lookup_table_name, rt.new_string('product_or_parent_id_term_id')])
	if !rt.is_true(rt.call_method(var_database_util, 'get_index_columns', [this.lookup_table_name])) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.concat(rt.concat(rt.new_string('The creation of the primary key for the '), this.lookup_table_name), rt.new_string(' table failed'))])
	}
	if !(!rt.is_true(rt.call_method(var_database_util, 'get_index_columns', [this.lookup_table_name, rt.new_string('product_or_parent_id_term_id')]))) {
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.concat(rt.concat(rt.new_string('Dropping the product_or_parent_id_term_id index from the '), this.lookup_table_name), rt.new_string(' table failed'))])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) run_woocommerce_installed_callback() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.data_store, 'check_lookup_table_exists', []rt.PhpVal{}))))) {
		return
	}
	if rt.is_true(rt.call_method(this.data_store, 'regeneration_is_in_progress', []rt.PhpVal{})) {
		return
	}
	if rt.is_true(rt.call_method(this.data_store, 'lookup_table_has_data', []rt.PhpVal{})) || rt.is_true(rt.new_bool(!(rt.is_true(this.get_last_existing_product_id())))) {
		mut var_must_enable := rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_option', [rt.new_string('woocommerce_attribute_lookup_enabled')]), rt.new_string('no'))))
		this.delete_all_attributes_lookup_data(false)
		rt.call_function('update_option', [rt.new_string('woocommerce_attribute_lookup_enabled'), rt.new_string((if rt.is_true(var_must_enable) { 'yes' } else { 'no' }).str())])
	} else {
		this.initiate_regeneration(false)
	}
}

struct Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productattributeslookup_dataregenerator() &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator{
		PhpObjectBase: rt.PhpObjectBase{}
		data_store: rt.new_null()
		lookup_table_name: rt.new_null()
		last_regeneration_step_failed: false
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_productattributeslookup_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_LookupDataStore](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_last_regeneration_step_failed' {
			return rt.new_bool(this.get_last_regeneration_step_failed())
		}
		'initiate_regeneration' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.initiate_regeneration(dispatch_arg_0))
		}
		'delete_all_attributes_lookup_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.delete_all_attributes_lookup_data(dispatch_arg_0)
			return rt.new_null()
		}
		'truncate_lookup_table' {
			this.truncate_lookup_table()
			return rt.new_null()
		}
		'initialize_table_and_data' {
			return rt.new_int(this.initialize_table_and_data())
		}
		'get_last_existing_product_id' {
			return rt.new_int(this.get_last_existing_product_id())
		}
		'run_regeneration_step_callback' {
			this.run_regeneration_step_callback()
			return rt.new_null()
		}
		'enqueue_regeneration_step_run' {
			this.enqueue_regeneration_step_run()
			return rt.new_null()
		}
		'do_regeneration_step' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_?int](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.do_regeneration_step(mut dispatch_arg_0, dispatch_arg_1))
		}
		'finalize_regeneration' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.finalize_regeneration(dispatch_arg_0)
			return rt.new_null()
		}
		'add_initiate_regeneration_entry_to_tools_array' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.add_initiate_regeneration_entry_to_tools_array(mut dispatch_arg_0)
		}
		'initiate_regeneration_from_tools_page' {
			this.initiate_regeneration_from_tools_page()
			return rt.new_null()
		}
		'enable_or_disable_lookup_table_usage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.enable_or_disable_lookup_table_usage(dispatch_arg_0)
			return rt.new_null()
		}
		'check_can_do_lookup_table_regeneration' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.check_can_do_lookup_table_regeneration(dispatch_arg_0)
			return rt.new_null()
		}
		'abort_regeneration' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.abort_regeneration(dispatch_arg_0)
			return rt.new_null()
		}
		'cancel_regeneration_scheduled_action' {
			this.cancel_regeneration_scheduled_action()
			return rt.new_null()
		}
		'has_scheduled_action_for_regeneration_step' {
			return rt.new_bool(this.has_scheduled_action_for_regeneration_step())
		}
		'resume_regeneration' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.resume_regeneration(dispatch_arg_0)
			return rt.new_null()
		}
		'verify_tool_execution_nonce' {
			this.verify_tool_execution_nonce()
			return rt.new_null()
		}
		'get_lookup_table_name' {
			return this.get_lookup_table_name()
		}
		'get_table_creation_sql' {
			return rt.new_string(this.get_table_creation_sql())
		}
		'create_table_primary_index' {
			this.create_table_primary_index()
			return rt.new_null()
		}
		'run_woocommerce_installed_callback' {
			this.run_woocommerce_installed_callback()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data_store' { return this.data_store }
		'lookup_table_name' { return this.lookup_table_name }
		'last_regeneration_step_failed' { return rt.new_bool(this.last_regeneration_step_failed) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_DataRegenerator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data_store' { this.data_store = val; return true }
		'lookup_table_name' { this.lookup_table_name = val; return true }
		'last_regeneration_step_failed' { this.last_regeneration_step_failed = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductAttributesLookup_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}
