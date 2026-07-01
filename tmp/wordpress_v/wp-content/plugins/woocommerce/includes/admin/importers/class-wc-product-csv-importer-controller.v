import rt

struct Class_WC_Product_CSV_Importer_Controller {
	rt.PhpObjectBase
pub mut:
		file rt.PhpVal = rt.new_string('')
		step rt.PhpVal = rt.new_string('')
		steps rt.PhpVal = rt.new_array()
		errors rt.PhpVal = rt.new_array()
		delimiter rt.PhpVal = rt.new_string(',')
		map_preferences rt.PhpVal = rt.new_bool(false)
		update_existing rt.PhpVal = rt.new_bool(false)
		character_encoding rt.PhpVal = rt.new_string('UTF-8')
}

fn Class_WC_Product_CSV_Importer_Controller.get_importer(var_file rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
	mut var_args_mutated := var_args
	mut var_importer_class := rt.call_function('apply_filters', [rt.new_string('woocommerce_product_csv_importer_class'), rt.new_string('WC_Product_CSV_Importer')])
	var_args_mutated = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_csv_importer_args'), var_args_mutated.dup(), var_importer_class.dup()])
	return rt.create_object_dynamically(var_importer_class, [var_file_mutated.dup(), var_args_mutated.dup()])
}

fn Class_WC_Product_CSV_Importer_Controller.is_file_valid_csv(var_file rt.PhpVal, check_path bool) rt.PhpVal {
	mut var_file_mutated := var_file
	return rt.call_function('wc_is_file_valid_csv', [var_file_mutated.dup(), rt.new_bool(check_path)])
}

fn Class_WC_Product_CSV_Importer_Controller.validate_file_path(path string)  {
	mut path_mutated := path
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}; return temp.validate_upload_file_path(arg_0) }(rt.new_string(path_mutated))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html__', [rt.new_string('File path provided for import is invalid.'), rt.new_string('woocommerce')]))))
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Product_CSV_Importer_Controller.is_file_valid_csv(path_mutated))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html__', [rt.new_string('Invalid file type. The importer supports CSV and TXT file formats.'), rt.new_string('woocommerce')]))))
	}
}

fn Class_WC_Product_CSV_Importer_Controller.get_valid_csv_filetypes() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_csv_product_import_valid_filetypes'), rt.create_array([rt.ArrayItem{ key: 'csv', val: 'text/csv' }, rt.ArrayItem{ key: 'txt', val: 'text/plain' }])])
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) construct()  {
	mut var_default_steps := { 'upload': { 'name': rt.call_function('__', [rt.new_string('Upload CSV file'), rt.new_string('woocommerce')]), 'view': map[string]rt.PhpVal{}, 'handler': map[string]rt.PhpVal{} }, 'mapping': { 'name': rt.call_function('__', [rt.new_string('Column mapping'), rt.new_string('woocommerce')]), 'view': map[string]rt.PhpVal{}, 'handler': rt.new_string('') }, 'import': { 'name': rt.call_function('__', [rt.new_string('Import'), rt.new_string('woocommerce')]), 'view': map[string]rt.PhpVal{}, 'handler': rt.new_string('') }, 'done': { 'name': rt.call_function('__', [rt.new_string('Done!'), rt.new_string('woocommerce')]), 'view': map[string]rt.PhpVal{}, 'handler': rt.new_string('') } }
	this.steps = rt.call_function('apply_filters', [rt.new_string('woocommerce_product_csv_importer_steps'), var_default_steps.dup()])
	this.step = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('step')) { rt.call_function('sanitize_key', [rt.get_superglobal('_REQUEST').array_get('step')]) } else { rt.call_function('current', [rt.func_array_keys(this.steps)]) }
	this.file = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('file')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('file')])]) } else { rt.new_string('') }
	this.update_existing = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('update_existing')) { // unsupported expression: Expr_Cast_Bool } else { rt.new_bool(false) }
	this.delimiter = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('delimiter'))) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('delimiter')])]) } else { rt.new_string(',') }
	this.map_preferences = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('map_preferences')) { // unsupported expression: Expr_Cast_Bool } else { rt.new_bool(false) }
	this.character_encoding = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('character_encoding')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('character_encoding')])]) } else { rt.new_string('UTF-8') }
	rt.include_file(@DIR + '/mappings/mappings.php', '2')
	if rt.is_true(this.map_preferences) {
		rt.call_function('add_filter', [rt.new_string('woocommerce_csv_product_import_mapped_columns'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer_Controller', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'auto_map_user_preferences' }]), rt.new_int(9999)])
	}
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) get_next_step_link(step string) string {
	mut step_mutated := step
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(step_mutated))))) {
		step_mutated = (this.step).str()
	}
	mut var_keys := rt.func_array_keys(this.steps)
	if rt.is_true(rt.identical(rt.call_function('end', [var_keys.dup()]), rt.new_string(step_mutated))) {
		return (rt.call_function('admin_url', []rt.PhpVal{})).str()
	}
	mut var_step_index := rt.call_function('array_search', [rt.new_string(step_mutated).dup(), var_keys.dup(), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_step_index)) {
		return ''
	}
	mut var_params := { 'step': var_keys.array_get(rt.add(var_step_index, rt.new_int(1))), 'file': rt.call_function('str_replace', [rt.get_constant('DIRECTORY_SEPARATOR'), rt.new_string('/'), this.file]), 'delimiter': this.delimiter, 'update_existing': this.update_existing, 'map_preferences': this.map_preferences, 'character_encoding': this.character_encoding, '_wpnonce': rt.call_function('wp_create_nonce', [rt.new_string('woocommerce-csv-importer')]) }
	return (rt.call_function('add_query_arg', [var_params.dup()])).str()
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) output_header()  {
	rt.include_file(@DIR + '/views/html-csv-import-header.php', '1')
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) output_steps()  {
	rt.include_file(@DIR + '/views/html-csv-import-steps.php', '1')
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) output_footer()  {
	rt.include_file(@DIR + '/views/html-csv-import-footer.php', '1')
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) add_error(var_message rt.PhpVal, var_actions rt.PhpVal)  {
	this.errors.array_push(rt.create_array([rt.ArrayItem{ key: 'message', val: var_message }, rt.ArrayItem{ key: 'actions', val: var_actions }]))
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) output_errors()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.errors)))) {
		return rt.new_null()
	}
	{
		mut iter_1 := this.errors.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_error := item_1.val
			print('<div class="error inline">')
			print('<p>' + (rt.call_function('esc_html', [var_error.array_get('message')])).str() + '</p>')
			if !(!rt.is_true(var_error.array_get('actions'))) {
				print('<p>')
				{
					mut iter_2 := var_error.array_get('actions').iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_action := item_2.val
						print('<a class="button button-primary" href="' + (rt.call_function('esc_url', [var_action.array_get('url')])).str() + '">' + (rt.call_function('esc_html', [var_action.array_get('label')])).str() + '</a> ')
					}
				}
				print('</p>')
			}
			print('</div>')
		}
	}
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) dispatch()  {
	mut var_output := rt.new_string(rt.new_string(''))
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get('save_step'))) && !(!rt.is_true(this.steps.array_get(this.step).array_get('handler'))) {
		if rt.is_true(rt.call_function('is_callable', [this.steps.array_get(this.step).array_get('handler')])) {
			rt.call_function('call_user_func', [this.steps.array_get(this.step).array_get('handler'), rt.new_object('WC_Product_CSV_Importer_Controller', []string{}, &this)])
			if rt.has_exception() { unsafe { goto catch_label_2 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	if rt.is_true(rt.call_function('is_callable', [this.steps.array_get(this.step).array_get('view')])) {
		rt.call_function('call_user_func', [this.steps.array_get(this.step).array_get('view'), rt.new_object('WC_Product_CSV_Importer_Controller', []string{}, &this)])
		if rt.has_exception() { unsafe { goto catch_label_2 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	var_output = rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.dup()
		this.add_error(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.new_null())
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	this.output_header()
	this.output_steps()
	this.output_errors()
	rt.echo_val(var_output)
	this.output_footer()
}

fn Class_WC_Product_CSV_Importer_Controller.dispatch_ajax()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_function('check_ajax_referer', [rt.new_string('wc-product-import'), rt.new_string('security')])
	mut var_file := rt.call_function('wc_clean', [rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get('file')).is_null() { rt.get_superglobal('_POST').array_get('file') } else { rt.new_string('') }])])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	Class_WC_Product_CSV_Importer_Controller.validate_file_path((var_file).str())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_params := { 'delimiter': if !(!rt.is_true(rt.get_superglobal('_POST').array_get('delimiter'))) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('delimiter')])]) } else { rt.new_string(',') }, 'start_pos': if rt.get_superglobal('_POST').array_isset(rt.new_string('position')) { rt.call_function('absint', [rt.get_superglobal('_POST').array_get('position')]) } else { rt.new_int(0) }, 'mapping': if rt.get_superglobal('_POST').array_isset(rt.new_string('mapping')) { rt.cast_array(rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('mapping')])])) } else { map[string]rt.PhpVal{} }, 'update_existing': if rt.get_superglobal('_POST').array_isset(rt.new_string('update_existing')) { // unsupported expression: Expr_Cast_Bool } else { rt.new_bool(false) }, 'character_encoding': if rt.get_superglobal('_POST').array_isset(rt.new_string('character_encoding')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('character_encoding')])]) } else { rt.new_string('') }, 'lines': rt.call_function('apply_filters', [rt.new_string('woocommerce_product_import_batch_size'), rt.new_int(30)]), 'parse': rt.new_bool(true) }
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_error_log := rt.call_function('array_filter', [rt.cast_array(rt.call_function('get_user_option', [rt.new_string('product_import_error_log')]))])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	} else {
		var_error_log = map[string]rt.PhpVal{}
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	rt.include_file((rt.get_constant('WC_ABSPATH')).str() + 'includes/import/class-wc-product-csv-importer.php', '2')
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_importer := Class_WC_Product_CSV_Importer_Controller.get_importer(var_file.dup(), var_params.dup())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_results := rt.call_method(var_importer, 'import', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	mut var_percent_complete := rt.call_method(var_importer, 'get_percent_complete', []rt.PhpVal{})
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	var_error_log = rt.call_function('array_merge', [var_error_log.dup(), var_results.array_get('failed'), var_results.array_get('skipped')])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	rt.call_function('update_user_option', [rt.call_function('get_current_user_id', []rt.PhpVal{}), rt.new_string('product_import_error_log'), var_error_log.dup()])
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	if rt.is_true(rt.identical(rt.new_int(100), var_percent_complete)) {
		rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'postmeta'), rt.create_array([rt.ArrayItem{ key: 'meta_key', val: '_original_id' }])])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'posts'), rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' }, rt.ArrayItem{ key: 'post_status', val: 'importing' }])])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'posts'), rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product_variation' }, rt.ArrayItem{ key: 'post_status', val: 'importing' }])])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tDELETE '), rt.get_property(var_wpdb, 'posts')), rt.new_string('.* FROM ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' wp ON wp.ID = ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_parent\n\t\t\t\t\tWHERE wp.ID IS NULL AND ')), rt.get_property(var_wpdb, 'posts')), rt.new_string('.post_type = \'product_variation\'\n\t\t\t\t'))])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tDELETE '), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.* FROM ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('\n\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' wp ON wp.ID = ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string('.post_id\n\t\t\t\t\tWHERE wp.ID IS NULL\n\t\t\t\t'))])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		rt.call_method(var_wpdb, 'query', [rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tDELETE tr.* FROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' tr\n\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' wp ON wp.ID = tr.object_id\n\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(' tt ON tr.term_taxonomy_id = tt.term_taxonomy_id\n\t\t\t\t\tWHERE wp.ID IS NULL\n\t\t\t\t\tAND tt.taxonomy IN ( \'')) + (rt.call_function('implode', [rt.new_string('\',\''), rt.call_function('array_map', [rt.new_string('esc_sql'), rt.call_function('get_object_taxonomies', [rt.new_string('product')])])])).str() + '\' )\n\t\t\t\t'])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
		rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'position', val: 'done' }, rt.ArrayItem{ key: 'percentage', val: 100 }, rt.ArrayItem{ key: 'url', val: rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [rt.new_string('woocommerce-csv-importer')]) }]), rt.call_function('admin_url', [rt.new_string('edit.php?post_type=product&page=product_importer&step=done')])]) }, rt.ArrayItem{ key: 'imported', val: if rt.is_true(rt.call_function('is_countable', [var_results.array_get('imported')])) { var_results.array_get('imported').array_count() } else { 0 } }, rt.ArrayItem{ key: 'imported_variations', val: if rt.is_true(rt.call_function('is_countable', [var_results.array_get('imported_variations')])) { var_results.array_get('imported_variations').array_count() } else { 0 } }, rt.ArrayItem{ key: 'failed', val: if rt.is_true(rt.call_function('is_countable', [var_results.array_get('failed')])) { var_results.array_get('failed').array_count() } else { 0 } }, rt.ArrayItem{ key: 'updated', val: if rt.is_true(rt.call_function('is_countable', [var_results.array_get('updated')])) { var_results.array_get('updated').array_count() } else { 0 } }, rt.ArrayItem{ key: 'skipped', val: if rt.is_true(rt.call_function('is_countable', [var_results.array_get('skipped')])) { var_results.array_get('skipped').array_count() } else { 0 } }])])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	} else {
		rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'position', val: rt.call_method(var_importer, 'get_file_position', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'percentage', val: var_percent_complete }, rt.ArrayItem{ key: 'imported', val: if rt.is_true(rt.call_function('is_countable', [var_results.array_get('imported')])) { var_results.array_get('imported').array_count() } else { 0 } }, rt.ArrayItem{ key: 'imported_variations', val: if rt.is_true(rt.call_function('is_countable', [var_results.array_get('imported_variations')])) { var_results.array_get('imported_variations').array_count() } else { 0 } }, rt.ArrayItem{ key: 'failed', val: if rt.is_true(rt.call_function('is_countable', [var_results.array_get('failed')])) { var_results.array_get('failed').array_count() } else { 0 } }, rt.ArrayItem{ key: 'updated', val: if rt.is_true(rt.call_function('is_countable', [var_results.array_get('updated')])) { var_results.array_get('updated').array_count() } else { 0 } }, rt.ArrayItem{ key: 'skipped', val: if rt.is_true(rt.call_function('is_countable', [var_results.array_get('skipped')])) { var_results.array_get('skipped').array_count() } else { 0 } }])])
		if rt.has_exception() { unsafe { goto catch_label_3 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.dup()
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage', []rt.PhpVal{}) }])])
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) upload_form()  {
	mut var_bytes := rt.call_function('apply_filters', [rt.new_string('import_upload_size_limit'), rt.call_function('wp_max_upload_size', []rt.PhpVal{})])
	mut var_size := rt.call_function('size_format', [var_bytes.dup()])
	mut var_upload_dir := rt.call_function('wp_upload_dir', []rt.PhpVal{})
	rt.include_file(@DIR + '/views/html-product-csv-import-form.php', '1')
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) upload_form_handler()  {
	rt.call_function('check_admin_referer', [rt.new_string('woocommerce-csv-importer')])
	mut var_file := this.handle_upload()
	if rt.is_true(rt.call_function('is_wp_error', [var_file.dup()])) {
		this.add_error(rt.call_method(var_file, 'get_error_message', []rt.PhpVal{}), rt.new_null())
		return rt.new_null()
	} else {
		this.file = var_file.dup()
	}
	rt.call_function('wp_redirect', [rt.call_function('esc_url_raw', [this.get_next_step_link('')])])
	// unsupported expression: Expr_Exit
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) handle_upload() rt.PhpVal {
	mut var_file_url := if rt.get_superglobal('_POST').array_isset(rt.new_string('file_url')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('file_url')])]) } else { rt.new_string('') }
	if !(!rt.is_true(var_file_url)) {
		mut var_path := rt.new_string(rt.concat(rt.get_constant('ABSPATH'), var_file_url))
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		Class_WC_Product_CSV_Importer_Controller.validate_file_path((var_path).str())
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	} else {
		mut var_csv_import_util := rt.call_method(, 'get', [])
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		mut var_upload := 
		if rt.has_exception() { unsafe { goto catch_label_4 } }
		
		if rt.has_exception() { unsafe { goto catch_label_4 } }
	}
	if rt.has_exception() { unsafe { goto catch_label_4 } }
	return .dup()
	unsafe { goto end_label_4 }

catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Exception') {
		mut var_e := var_e_4.dup()
		unsafe { goto end_label_4 }
	}
	else {
		rt.throw_exception(var_e_4)
		unsafe { goto end_label_4 }
	}

end_label_4:
	return rt.new_null()
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) mapping_form()  {
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) import()  {
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) done()  {
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) normalize_columns_names(var_columns rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) auto_map_columns(var_raw_headers rt.PhpVal, num_indexes bool) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) auto_map_user_preferences(var_headers rt.PhpVal) rt.PhpVal {
	mut var_headers_mutated := var_headers
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) sanitize_special_column_name_regex(var_value rt.PhpVal) string {
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) get_special_columns(var_columns rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) get_mapping_options(item string) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
}

struct Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

fn create_wc_product_csv_importer_controller() &Class_WC_Product_CSV_Importer_Controller {
	mut obj := &Class_WC_Product_CSV_Importer_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		file: rt.new_string('')
		step: rt.new_string('')
		steps: rt.new_array()
		errors: rt.new_array()
		delimiter: rt.new_string(',')
		map_preferences: rt.new_bool(false)
		update_existing: rt.new_bool(false)
		character_encoding: rt.new_string('UTF-8')
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_utilities_filesystemutil() &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_importer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Product_CSV_Importer_Controller.get_importer(dispatch_arg_0, dispatch_arg_1)
		}
		'is_file_valid_csv' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_WC_Product_CSV_Importer_Controller.is_file_valid_csv(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_file_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_WC_Product_CSV_Importer_Controller.validate_file_path(dispatch_arg_0)
			return rt.new_null()
		}
		'get_valid_csv_filetypes' {
			return Class_WC_Product_CSV_Importer_Controller.get_valid_csv_filetypes()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_next_step_link' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_next_step_link(dispatch_arg_0))
		}
		'output_header' {
			this.output_header()
			return rt.new_null()
		}
		'output_steps' {
			this.output_steps()
			return rt.new_null()
		}
		'output_footer' {
			this.output_footer()
			return rt.new_null()
		}
		'add_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.add_error(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'output_errors' {
			this.output_errors()
			return rt.new_null()
		}
		'dispatch' {
			this.dispatch()
			return rt.new_null()
		}
		'dispatch_ajax' {
			Class_WC_Product_CSV_Importer_Controller.dispatch_ajax()
			return rt.new_null()
		}
		'upload_form' {
			this.upload_form()
			return rt.new_null()
		}
		'upload_form_handler' {
			this.upload_form_handler()
			return rt.new_null()
		}
		'handle_upload' {
			return this.handle_upload()
		}
		'mapping_form' {
			this.mapping_form()
			return rt.new_null()
		}
		'import' {
			this.import()
			return rt.new_null()
		}
		'done' {
			this.done()
			return rt.new_null()
		}
		'normalize_columns_names' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.normalize_columns_names(dispatch_arg_0)
		}
		'auto_map_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.auto_map_columns(dispatch_arg_0, dispatch_arg_1)
		}
		'auto_map_user_preferences' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.auto_map_user_preferences(dispatch_arg_0)
		}
		'sanitize_special_column_name_regex' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.sanitize_special_column_name_regex(dispatch_arg_0))
		}
		'get_special_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_special_columns(dispatch_arg_0)
		}
		'get_mapping_options' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_mapping_options(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Product_CSV_Importer_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'file' { return this.file }
		'step' { return this.step }
		'steps' { return this.steps }
		'errors' { return this.errors }
		'delimiter' { return this.delimiter }
		'map_preferences' { return this.map_preferences }
		'update_existing' { return this.update_existing }
		'character_encoding' { return this.character_encoding }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'file' { this.file = val; return true }
		'step' { this.step = val; return true }
		'steps' { this.steps = val; return true }
		'errors' { this.errors = val; return true }
		'delimiter' { this.delimiter = val; return true }
		'map_preferences' { this.map_preferences = val; return true }
		'update_existing' { this.update_existing = val; return true }
		'character_encoding' { this.character_encoding = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
	rt.register_class_factory('WC_Product_CSV_Importer_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_csv_importer_controller()
		return rt.new_object('WC_Product_CSV_Importer_Controller', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Utilities_FilesystemUtil', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_utilities_filesystemutil()
		return rt.new_object('Automattic_WooCommerce_Internal_Utilities_FilesystemUtil', []string{}, obj)
	})
	rt.register_class_factory('Exception', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_exception(c_arg_0)
		return rt.new_object('Exception', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_admin_importers_class_wc_product_csv_importer_controller_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('WP_Importer')]))))) {
		return rt.new_null()
	}
}
