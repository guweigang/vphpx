import rt

struct Class_WC_Product_CSV_Importer_Controller {
	rt.PhpObjectBase
pub mut:
	file               rt.PhpVal = rt.new_string('')
	step               rt.PhpVal = rt.new_string('')
	steps              rt.PhpVal = rt.new_array()
	errors             rt.PhpVal = rt.new_array()
	delimiter          rt.PhpVal = rt.new_string(',')
	map_preferences    rt.PhpVal = rt.new_bool(false)
	update_existing    rt.PhpVal = rt.new_bool(false)
	character_encoding rt.PhpVal = rt.new_string('UTF-8')
}

fn Class_WC_Product_CSV_Importer_Controller.get_importer(var_file rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
	mut var_args_mutated := var_args
	mut var_importer_class := rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_csv_importer_class'),
		rt.new_string('WC_Product_CSV_Importer'),
	])
	var_args_mutated = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_csv_importer_args'),
		var_args_mutated.clone(),
		var_importer_class.clone(),
	])
	return rt.new_object('', []string{}, rt.create_object_dynamically(var_importer_class, [
		var_file_mutated.clone(),
		var_args_mutated.clone(),
	]))
}

fn Class_WC_Product_CSV_Importer_Controller.is_file_valid_csv(var_file rt.PhpVal, check_path bool) rt.PhpVal {
	mut var_file_mutated := var_file
	return rt.call_function('wc_is_file_valid_csv', [var_file_mutated.clone(),
		rt.new_bool(check_path)])
}

fn Class_WC_Product_CSV_Importer_Controller.validate_file_path(path string) {
	mut path_mutated := path
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{}
	mut iife_result_0 := iife_temp_0.validate_upload_file_path(rt.new_string(path_mutated))
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
		mut var_e := var_e_1.clone()
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html__', [
			rt.new_string('File path provided for import is invalid.'),
			rt.new_string('woocommerce'),
		]))))
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
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_WC_Product_CSV_Importer_Controller.is_file_valid_csv(path_mutated))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html__', [
			rt.new_string('Invalid file type. The importer supports CSV and TXT file formats.'),
			rt.new_string('woocommerce'),
		]))))
	}
}

fn Class_WC_Product_CSV_Importer_Controller.get_valid_csv_filetypes() rt.PhpVal {
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_csv_product_import_valid_filetypes'),
		rt.create_array([rt.ArrayItem{ key: 'csv', val: 'text/csv' },
			rt.ArrayItem{ key: 'txt', val: 'text/plain' }]),
	])
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) construct() {
	mut var_default_steps := {
		'upload':  {
			'name':    rt.call_function('__', [rt.new_string('Upload CSV file'),
				rt.new_string('woocommerce')])
			'view':    map[string]rt.PhpVal{}
			'handler': map[string]rt.PhpVal{}
		}
		'mapping': {
			'name':    rt.call_function('__', [rt.new_string('Column mapping'),
				rt.new_string('woocommerce')])
			'view':    map[string]rt.PhpVal{}
			'handler': rt.new_string('')
		}
		'import':  {
			'name':    rt.call_function('__', [rt.new_string('Import'),
				rt.new_string('woocommerce')])
			'view':    map[string]rt.PhpVal{}
			'handler': rt.new_string('')
		}
		'done':    {
			'name':    rt.call_function('__', [rt.new_string('Done!'),
				rt.new_string('woocommerce')])
			'view':    map[string]rt.PhpVal{}
			'handler': rt.new_string('')
		}
	}
	this.steps = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_product_csv_importer_steps'),
		rt.create_array_from_native_map(var_default_steps),
	])
	this.step = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('step')) { rt.call_function('sanitize_key', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('step')),
		]) } else { rt.call_function('current', [rt.func_array_keys(this.steps)]) }
	this.file = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('file')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('file'))]),
		]) } else { rt.new_string('') }
	this.update_existing = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('update_existing')) {
		(rt.get_superglobal('_REQUEST').array_get(rt.new_string('update_existing'))).to_bool()
	} else {
		false
	}
	this.delimiter = if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('delimiter')))) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('delimiter'))]),
		]) } else { rt.new_string(',') }
	this.map_preferences = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('map_preferences')) {
		(rt.get_superglobal('_REQUEST').array_get(rt.new_string('map_preferences'))).to_bool()
	} else {
		false
	}
	this.character_encoding = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('character_encoding')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('character_encoding')),
			]),
		]) } else { rt.new_string('UTF-8') }
	rt.include_file(@DIR + '/mappings/mappings.php', '2')
	if rt.is_true(this.map_preferences) {
		rt.call_function('add_filter', [
			rt.new_string('woocommerce_csv_product_import_mapped_columns'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_Product_CSV_Importer_Controller',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'auto_map_user_preferences' },
			]),
			rt.new_int(9999),
		])
	}
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) get_next_step_link(step string) string {
	mut step_mutated := step
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(step_mutated))))) {
		step_mutated = (this.step).str()
	}
	mut var_keys := rt.func_array_keys(this.steps)
	if rt.is_true(rt.identical(rt.call_function('end', [var_keys.clone()]),
		rt.new_string(step_mutated)))
	{
		return (rt.call_function('admin_url', []rt.PhpVal{})).str()
	}
	mut var_step_index := rt.call_function('array_search', [rt.new_string(step_mutated).clone(),
		var_keys.clone(), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), var_step_index)) {
		return ''
	}
	mut var_params := {
		'step':               var_keys.array_get(rt.add(var_step_index, rt.new_int(1)))
		'file':               rt.call_function('str_replace', [
			rt.get_constant('DIRECTORY_SEPARATOR'),
			rt.new_string('/'),
			this.file,
		])
		'delimiter':          this.delimiter
		'update_existing':    this.update_existing
		'map_preferences':    this.map_preferences
		'character_encoding': this.character_encoding
		'_wpnonce':           rt.call_function('wp_create_nonce', [
			rt.new_string('woocommerce-csv-importer'),
		])
	}
	return (rt.call_function('add_query_arg', [
		rt.create_array_from_native_map(var_params),
	])).str()
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) output_header() {
	rt.include_file(@DIR + '/views/html-csv-import-header.php', '1')
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) output_steps() {
	rt.include_file(@DIR + '/views/html-csv-import-steps.php', '1')
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) output_footer() {
	rt.include_file(@DIR + '/views/html-csv-import-footer.php', '1')
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) add_error(var_message rt.PhpVal, var_actions rt.PhpVal) {
	this.errors.array_push(rt.create_array([
		rt.ArrayItem{ key: 'message', val: var_message },
		rt.ArrayItem{ key: 'actions', val: var_actions },
	]))
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) output_errors() {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.errors)))) {
		return
	}
	mut iter_1 := this.errors.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_error := item_1.val
		print('<div class="error inline">')
		print('<p>' +
			(rt.call_function('esc_html', [var_error.array_get(rt.new_string('message'))])).str() +
			'</p>')
		if !(!rt.is_true(var_error.array_get(rt.new_string('actions')))) {
			print('<p>')
			mut iter_2 := var_error.array_get(rt.new_string('actions')).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_action := item_2.val
				print('<a class="button button-primary" href="' +
					(rt.call_function('esc_url', [var_action.array_get(rt.new_string('url'))])).str() +
					'">' +
					(rt.call_function('esc_html', [var_action.array_get(rt.new_string('label'))])).str() +
					'</a> ')
			}
			print('</p>')
		}
		print('</div>')
	}
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) dispatch() {
	mut var_output := rt.new_string('')
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('save_step'))))
		&& !(!rt.is_true(this.steps.array_get(this.step).array_get(rt.new_string('handler')))) {
		if rt.is_true(rt.call_function('is_callable', [
			this.steps.array_get(this.step).array_get(rt.new_string('handler')),
		]))
		{
			rt.call_function('call_user_func', [this.steps.array_get(this.step).array_get(rt.new_string('handler')),
				rt.new_object('WC_Product_CSV_Importer_Controller', []string{}, &this)])
			if rt.has_exception() {
				unsafe {
					goto catch_label_2
				}
			}
		}
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.call_function('is_callable',
		[this.steps.array_get(this.step).array_get(rt.new_string('view'))]))
	{
		rt.call_function('call_user_func', [this.steps.array_get(this.step).array_get(rt.new_string('view')),
			rt.new_object('WC_Product_CSV_Importer_Controller', []string{}, &this)])
		if rt.has_exception() {
			unsafe {
				goto catch_label_2
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	var_output = rt.call_function('ob_get_clean', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'Exception') {
		mut var_e := var_e_2.clone()
		this.add_error(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.new_null())
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	this.output_header()
	this.output_steps()
	this.output_errors()
	rt.echo_val(var_output)
	this.output_footer()
}

fn Class_WC_Product_CSV_Importer_Controller.dispatch_ajax() {
	mut var_wpdb := rt.new_null()
	rt.call_function('check_ajax_referer', [rt.new_string('wc-product-import'),
		rt.new_string('security')])
	mut var_file := rt.call_function('wc_clean', [
		rt.call_function('wp_unslash', [if !(rt.get_superglobal('_POST').array_get(rt.new_string('file'))).is_null() {
			rt.get_superglobal('_POST').array_get(rt.new_string('file'))
		} else {
			rt.new_string('')
		}]),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	Class_WC_Product_CSV_Importer_Controller.validate_file_path(var_file.str())
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	mut var_params := {
		'delimiter':          if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('delimiter')))) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('delimiter'))]),
			]) } else { rt.new_string(',') }
		'start_pos':          if rt.get_superglobal('_POST').array_isset(rt.new_string('position')) { rt.call_function('absint', [
				rt.get_superglobal('_POST').array_get(rt.new_string('position')),
			]) } else { rt.new_int(0) }
		'mapping':            if rt.get_superglobal('_POST').array_isset(rt.new_string('mapping')) {
			rt.cast_array(rt.call_function('wc_clean', [
				rt.call_function('wp_unslash',
					[rt.get_superglobal('_POST').array_get(rt.new_string('mapping'))]),
			]))
		} else {
			map[string]rt.PhpVal{}
		}
		'update_existing':    if rt.get_superglobal('_POST').array_isset(rt.new_string('update_existing')) {
			(rt.get_superglobal('_POST').array_get(rt.new_string('update_existing'))).to_bool()
		} else {
			false
		}
		'character_encoding': if rt.get_superglobal('_POST').array_isset(rt.new_string('character_encoding')) { rt.call_function('wc_clean', [
				rt.call_function('wp_unslash', [
					rt.get_superglobal('_POST').array_get(rt.new_string('character_encoding')),
				]),
			]) } else { rt.new_string('') }
		'lines':              rt.call_function('apply_filters', [
			rt.new_string('woocommerce_product_import_batch_size'),
			rt.new_int(30),
		])
		'parse':              rt.new_bool(true)
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_params['start_pos'])))) {
		mut var_error_log := rt.call_function('array_filter', [
			rt.cast_array(rt.call_function('get_user_option', [
				rt.new_string('product_import_error_log'),
			])),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
	} else {
		var_error_log = map[string]rt.PhpVal{}
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	rt.include_file(
		(rt.get_constant('WC_ABSPATH')).str() + 'includes/import/class-wc-product-csv-importer.php',
		'2')
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	mut var_importer := Class_WC_Product_CSV_Importer_Controller.get_importer(var_file.clone(),
		var_params.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	mut var_results := rt.call_method(var_importer, 'import', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	mut var_percent_complete := rt.call_method(var_importer, 'get_percent_complete', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	var_error_log = rt.call_function('array_merge', [var_error_log.clone(),
		var_results.array_get(rt.new_string('failed')), var_results.array_get(rt.new_string('skipped'))])
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	rt.call_function('update_user_option', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
		rt.new_string('product_import_error_log'),
		var_error_log.clone(),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	if rt.is_true(rt.identical(rt.new_int(100), var_percent_complete)) {
		rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'postmeta'),
			rt.create_array([rt.ArrayItem{ key: 'meta_key', val: '_original_id' }])])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'posts'),
			rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product' },
				rt.ArrayItem{ key: 'post_status', val: 'importing' }])])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		rt.call_method(var_wpdb, 'delete', [rt.get_property(var_wpdb, 'posts'),
			rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'product_variation' },
				rt.ArrayItem{ key: 'post_status', val: 'importing' }])])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tDELETE '), rt.get_property(var_wpdb,
				'posts')), rt.new_string('.* FROM ')), rt.get_property(var_wpdb, 'posts')),
				rt.new_string('\n\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'posts')),
				rt.new_string(' wp ON wp.ID = ')), rt.get_property(var_wpdb, 'posts')),
				rt.new_string('.post_parent\n\t\t\t\t\tWHERE wp.ID IS NULL AND ')), rt.get_property(var_wpdb,
				'posts')), rt.new_string(".post_type = 'product_variation'\n\t\t\t\t")),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		rt.call_method(var_wpdb, 'query', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tDELETE '), rt.get_property(var_wpdb,
				'postmeta')), rt.new_string('.* FROM ')), rt.get_property(var_wpdb, 'postmeta')),
				rt.new_string('\n\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'posts')),
				rt.new_string(' wp ON wp.ID = ')), rt.get_property(var_wpdb, 'postmeta')),
				rt.new_string('.post_id\n\t\t\t\t\tWHERE wp.ID IS NULL\n\t\t\t\t')),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		rt.call_method(var_wpdb, 'query', [
			rt.new_string((
				rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\t\t\tDELETE tr.* FROM '), rt.get_property(var_wpdb, 'term_relationships')), rt.new_string(' tr\n\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'posts')), rt.new_string(' wp ON wp.ID = tr.object_id\n\t\t\t\t\tLEFT JOIN ')), rt.get_property(var_wpdb, 'term_taxonomy')), rt.new_string(" tt ON tr.term_taxonomy_id = tt.term_taxonomy_id\n\t\t\t\t\tWHERE wp.ID IS NULL\n\t\t\t\t\tAND tt.taxonomy IN ( '")) +
				(rt.call_function('implode', [rt.new_string("','"), rt.call_function('array_map', [rt.new_string('esc_sql'), rt.call_function('get_object_taxonomies', [rt.new_string('product')])])])).str() +
				"' )\n\t\t\t\t").str()),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
		rt.call_function('wp_send_json_success', [
			rt.create_array([rt.ArrayItem{ key: 'position', val: 'done' },
				rt.ArrayItem{ key: 'percentage', val: 100 }, rt.ArrayItem{ key: 'url', val: rt.call_function('add_query_arg', [
					rt.create_array([
						rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [
							rt.new_string('woocommerce-csv-importer'),
						]) },
					]),
					rt.call_function('admin_url', [
						rt.new_string('edit.php?post_type=product&page=product_importer&step=done'),
					]),
				]) }, rt.ArrayItem{
					key: 'imported'
					val: if rt.call_function('is_countable', [
						var_results.array_get(rt.new_string('imported')),
					])
					{ var_results.array_get(rt.new_string('imported')).array_count() } else { 0 }
				}, rt.ArrayItem{
					key: 'imported_variations'
					val: if rt.call_function('is_countable', [
						var_results.array_get(rt.new_string('imported_variations')),
					])
					{
						var_results.array_get(rt.new_string('imported_variations')).array_count()
					} else {
						0
					}
				}, rt.ArrayItem{
					key: 'failed'
					val: if rt.call_function('is_countable', [
						var_results.array_get(rt.new_string('failed')),
					])
					{ var_results.array_get(rt.new_string('failed')).array_count() } else { 0 }
				}, rt.ArrayItem{
					key: 'updated'
					val: if rt.call_function('is_countable', [
						var_results.array_get(rt.new_string('updated')),
					])
					{ var_results.array_get(rt.new_string('updated')).array_count() } else { 0 }
				}, rt.ArrayItem{
					key: 'skipped'
					val: if rt.call_function('is_countable', [
						var_results.array_get(rt.new_string('skipped')),
					])
					{ var_results.array_get(rt.new_string('skipped')).array_count() } else { 0 }
				}]),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
	} else {
		rt.call_function('wp_send_json_success', [
			rt.create_array([
				rt.ArrayItem{ key: 'position', val: rt.call_method(var_importer,
					'get_file_position', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'percentage', val: var_percent_complete },
				rt.ArrayItem{
					key: 'imported'
					val: if rt.call_function('is_countable', [
						var_results.array_get(rt.new_string('imported')),
					])
					{ var_results.array_get(rt.new_string('imported')).array_count() } else { 0 }
				},
				rt.ArrayItem{
					key: 'imported_variations'
					val: if rt.call_function('is_countable', [
						var_results.array_get(rt.new_string('imported_variations')),
					])
					{
						var_results.array_get(rt.new_string('imported_variations')).array_count()
					} else {
						0
					}
				},
				rt.ArrayItem{
					key: 'failed'
					val: if rt.call_function('is_countable', [
						var_results.array_get(rt.new_string('failed')),
					])
					{ var_results.array_get(rt.new_string('failed')).array_count() } else { 0 }
				},
				rt.ArrayItem{
					key: 'updated'
					val: if rt.call_function('is_countable', [
						var_results.array_get(rt.new_string('updated')),
					])
					{ var_results.array_get(rt.new_string('updated')).array_count() } else { 0 }
				},
				rt.ArrayItem{
					key: 'skipped'
					val: if rt.call_function('is_countable', [
						var_results.array_get(rt.new_string('skipped')),
					])
					{ var_results.array_get(rt.new_string('skipped')).array_count() } else { 0 }
				},
			]),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_3
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'Exception') {
		mut var_e := var_e_3.clone()
		rt.call_function('wp_send_json_error', [
			rt.create_array([
				rt.ArrayItem{ key: 'message', val: rt.call_method(var_e, 'getMessage',
					[]rt.PhpVal{}) },
			]),
		])
		unsafe {
			goto end_label_3
		}
	} else {
		rt.throw_exception(var_e_3)
		unsafe {
			goto end_label_3
		}
	}

	end_label_3:
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) upload_form() {
	mut var_bytes := rt.call_function('apply_filters', [
		rt.new_string('import_upload_size_limit'),
		rt.call_function('wp_max_upload_size', []rt.PhpVal{}),
	])
	mut var_size := rt.call_function('size_format', [var_bytes.clone()])
	mut var_upload_dir := rt.call_function('wp_upload_dir', []rt.PhpVal{})
	rt.include_file(@DIR + '/views/html-product-csv-import-form.php', '1')
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) upload_form_handler() {
	rt.call_function('check_admin_referer', [rt.new_string('woocommerce-csv-importer')])
	mut var_file := this.handle_upload()
	if rt.is_true(rt.call_function('is_wp_error', [var_file.clone()])) {
		this.add_error(rt.call_method(var_file, 'get_error_message', []rt.PhpVal{}), rt.new_null())
		return
	} else {
		this.file = var_file.clone()
	}
	rt.call_function('wp_redirect', [
		rt.call_function('esc_url_raw', [rt.new_string(this.get_next_step_link(''))]),
	])
	exit(0)
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) handle_upload() rt.PhpVal {
	mut var_file_url := if rt.get_superglobal('_POST').array_isset(rt.new_string('file_url')) { rt.call_function('wc_clean', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('file_url'))]),
		]) } else { rt.new_string('') }
	if !(!rt.is_true(var_file_url)) {
		mut var_path := rt.new_string((rt.get_constant('ABSPATH')).str() + var_file_url.str())
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		Class_WC_Product_CSV_Importer_Controller.validate_file_path(var_path.str())
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
	} else {
		mut var_csv_import_util := rt.call_method(rt.call_function('wc_get_container',
			[]rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_Admin_ImportExport_CSVUploadHelper.class(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		mut var_upload := rt.call_method(var_csv_import_util, 'handle_csv_upload', [
			rt.new_string('product'),
			rt.new_string('import'),
			Class_WC_Product_CSV_Importer_Controller.get_valid_csv_filetypes(),
		])
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
		var_path = var_upload.array_get(rt.new_string('file'))
		if rt.has_exception() {
			unsafe {
				goto catch_label_4
			}
		}
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	return var_path.clone()
	unsafe {
		goto end_label_4
	}
	catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'Exception') {
		mut var_e := var_e_4.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_product_csv_importer_upload_invalid_file'), rt.call_method(var_e,
			'getMessage', []rt.PhpVal{})))
		unsafe {
			goto end_label_4
		}
	} else {
		rt.throw_exception(var_e_4)
		unsafe {
			goto end_label_4
		}
	}

	end_label_4:
	return rt.new_null()
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) mapping_form() {
	rt.call_function('check_admin_referer', [rt.new_string('woocommerce-csv-importer')])
	Class_WC_Product_CSV_Importer_Controller.validate_file_path((this.file).str())
	mut var_args := rt.create_array([rt.ArrayItem{ key: 'lines', val: 1 },
		rt.ArrayItem{ key: 'delimiter', val: this.delimiter },
		rt.ArrayItem{ key: 'character_encoding', val: this.character_encoding }])
	mut var_importer := Class_WC_Product_CSV_Importer_Controller.get_importer(this.file,
		var_args.clone())
	mut var_headers := rt.call_method(var_importer, 'get_raw_keys', []rt.PhpVal{})
	mut var_mapped_items := this.auto_map_columns(var_headers.clone(), false)
	mut var_sample := rt.call_function('current', [
		rt.call_method(var_importer, 'get_raw_data', []rt.PhpVal{}),
	])
	if !rt.is_true(var_sample) {
		this.add_error(rt.call_function('__', [
			rt.new_string('The file is empty or using a different encoding than UTF-8, please try again with a new file.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'url', val: rt.call_function('admin_url', [
					rt.new_string('edit.php?post_type=product&page=product_importer'),
				]) },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Upload a new file'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]))
		this.output_errors()
		return
	}
	rt.include_file(@DIR + '/views/html-csv-import-mapping.php', '2')
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) import() {
	rt.call_function('check_admin_referer', [rt.new_string('woocommerce-csv-importer')])
	Class_WC_Product_CSV_Importer_Controller.validate_file_path((this.file).str())
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('map_from'))))
		&& !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('map_to')))) {
		mut var_mapping_from := rt.call_function('wc_clean', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('map_from'))]),
		])
		mut var_mapping_to := rt.call_function('wc_clean', [
			rt.call_function('wp_unslash',
				[rt.get_superglobal('_POST').array_get(rt.new_string('map_to'))]),
		])
		rt.call_function('update_user_option', [
			rt.call_function('get_current_user_id', []rt.PhpVal{}),
			rt.new_string('woocommerce_product_import_mapping'),
			var_mapping_to.clone(),
		])
	} else {
		rt.call_function('wp_redirect', [
			rt.call_function('esc_url_raw', [
				rt.new_string(this.get_next_step_link('upload')),
			]),
		])
		exit(0)
	}
	rt.call_function('wp_localize_script', [rt.new_string('wc-product-import'),
		rt.new_string('wc_product_import_params'),
		rt.create_array([
			rt.ArrayItem{ key: 'import_nonce', val: rt.call_function('wp_create_nonce', [
				rt.new_string('wc-product-import'),
			]) },
			rt.ArrayItem{ key: 'mapping', val: rt.create_array([
				rt.ArrayItem{ key: 'from', val: var_mapping_from },
				rt.ArrayItem{ key: 'to', val: var_mapping_to },
			]) },
			rt.ArrayItem{ key: 'file', val: this.file },
			rt.ArrayItem{ key: 'update_existing', val: this.update_existing },
			rt.ArrayItem{ key: 'delimiter', val: this.delimiter },
			rt.ArrayItem{ key: 'character_encoding', val: this.character_encoding },
		])])
	rt.call_function('wp_enqueue_script', [rt.new_string('wc-product-import')])
	rt.include_file(@DIR + '/views/html-csv-import-progress.php', '2')
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) done() {
	rt.call_function('check_admin_referer', [rt.new_string('woocommerce-csv-importer')])
	mut var_imported := if rt.get_superglobal('_GET').array_isset(rt.new_string('products-imported')) { rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('products-imported')),
		]) } else { rt.new_int(0) }
	mut var_imported_variations := if rt.get_superglobal('_GET').array_isset(rt.new_string('products-imported-variations')) { rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('products-imported-variations')),
		]) } else { rt.new_int(0) }
	mut var_updated := if rt.get_superglobal('_GET').array_isset(rt.new_string('products-updated')) { rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('products-updated')),
		]) } else { rt.new_int(0) }
	mut var_failed := if rt.get_superglobal('_GET').array_isset(rt.new_string('products-failed')) { rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('products-failed')),
		]) } else { rt.new_int(0) }
	mut var_skipped := if rt.get_superglobal('_GET').array_isset(rt.new_string('products-skipped')) { rt.call_function('absint', [
			rt.get_superglobal('_GET').array_get(rt.new_string('products-skipped')),
		]) } else { rt.new_int(0) }
	mut var_file_name := if rt.get_superglobal('_GET').array_isset(rt.new_string('file-name')) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('file-name'))]),
		]) } else { rt.new_string('') }
	mut var_errors := rt.call_function('array_filter', [
		rt.cast_array(rt.call_function('get_user_option', [
			rt.new_string('product_import_error_log'),
		])),
	])
	rt.include_file(@DIR + '/views/html-csv-import-done.php', '2')
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) normalize_columns_names(var_columns rt.PhpVal) rt.PhpVal {
	mut var_normalized := map[string]rt.PhpVal{}
	mut iter_3 := var_columns.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		var_normalized[var_key.clone().to_string().to_lower()] = var_value.clone()
	}
	return var_normalized.clone()
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) auto_map_columns(var_raw_headers rt.PhpVal, num_indexes bool) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_1 := iife_temp_1.get_weight_unit_label(rt.call_function('get_option', [
		rt.new_string('woocommerce_weight_unit'),
		rt.new_string('kg'),
	]))
	mut var_weight_unit_label := iife_result_1
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_2 := iife_temp_2.get_dimensions_unit_label(rt.call_function('get_option', [
		rt.new_string('woocommerce_dimension_unit'),
		rt.new_string('cm'),
	]))
	mut var_dimension_unit_label := iife_result_2
	mut var_default_columns := rt.create_array([
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('ID'),
			rt.new_string('woocommerce')]), val: 'id' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Type'),
			rt.new_string('woocommerce')]), val: 'type' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('SKU'),
			rt.new_string('woocommerce')]), val: 'sku' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Name'),
			rt.new_string('woocommerce')]), val: 'name' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Published'),
			rt.new_string('woocommerce')]), val: 'published' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Is featured?'),
			rt.new_string('woocommerce')]), val: 'featured' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Visibility in catalog'),
			rt.new_string('woocommerce')]), val: 'catalog_visibility' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Short description'),
			rt.new_string('woocommerce')]), val: 'short_description' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Description'),
			rt.new_string('woocommerce')]), val: 'description' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Date sale price starts'),
			rt.new_string('woocommerce')]), val: 'date_on_sale_from' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Date sale price ends'),
			rt.new_string('woocommerce')]), val: 'date_on_sale_to' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Tax status'),
			rt.new_string('woocommerce')]), val: 'tax_status' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Tax class'),
			rt.new_string('woocommerce')]), val: 'tax_class' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('In stock?'),
			rt.new_string('woocommerce')]), val: 'stock_status' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Stock'),
			rt.new_string('woocommerce')]), val: 'stock_quantity' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Backorders allowed?'),
			rt.new_string('woocommerce')]), val: 'backorders' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Low stock amount'),
			rt.new_string('woocommerce')]), val: 'low_stock_amount' },
		rt.ArrayItem{ key: rt.call_function('__', [rt.new_string('Sold individually?'),
			rt.new_string('woocommerce')]), val: 'sold_individually' },
		rt.ArrayItem{ key: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Weight (%s)'),
				rt.new_string('woocommerce')]),
			var_weight_unit_label.clone(),
		]), val: 'weight' },
		rt.ArrayItem{ key: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Length (%s)'),
				rt.new_string('woocommerce')]),
			var_dimension_unit_label.clone(),
		]), val: 'length' },
		rt.ArrayItem{ key: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Width (%s)'),
				rt.new_string('woocommerce')]),
			var_dimension_unit_label.clone(),
		]), val: 'width' },
		rt.ArrayItem{ key: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Height (%s)'),
				rt.new_string('woocommerce')]),
			var_dimension_unit_label.clone(),
		]), val: 'height' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Allow customer reviews?'),
			rt.new_string('woocommerce'),
		]), val: 'reviews_allowed' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Purchase note'),
			rt.new_string('woocommerce'),
		]), val: 'purchase_note' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Sale price'),
			rt.new_string('woocommerce'),
		]), val: 'sale_price' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Regular price'),
			rt.new_string('woocommerce'),
		]), val: 'regular_price' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Categories'),
			rt.new_string('woocommerce'),
		]), val: 'category_ids' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Tags'),
			rt.new_string('woocommerce'),
		]), val: 'tag_ids' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Shipping class'),
			rt.new_string('woocommerce'),
		]), val: 'shipping_class_id' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Images'),
			rt.new_string('woocommerce'),
		]), val: 'images' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Download limit'),
			rt.new_string('woocommerce'),
		]), val: 'download_limit' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Download expiry days'),
			rt.new_string('woocommerce'),
		]), val: 'download_expiry' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Parent'),
			rt.new_string('woocommerce'),
		]), val: 'parent_id' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Upsells'),
			rt.new_string('woocommerce'),
		]), val: 'upsell_ids' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Cross-sells'),
			rt.new_string('woocommerce'),
		]), val: 'cross_sell_ids' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Grouped products'),
			rt.new_string('woocommerce'),
		]), val: 'grouped_products' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('External URL'),
			rt.new_string('woocommerce'),
		]), val: 'product_url' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Button text'),
			rt.new_string('woocommerce'),
		]), val: 'button_text' },
		rt.ArrayItem{ key: rt.call_function('__', [
			rt.new_string('Position'),
			rt.new_string('woocommerce'),
		]), val: 'menu_order' },
	])
	if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class(),
	]), 'feature_is_enabled', []rt.PhpVal{}))
	{
		var_default_columns.array_set(rt.call_function('__', [
			rt.new_string('Cost of goods'),
			rt.new_string('woocommerce'),
		]), 'cogs_value')
	}
	var_default_columns = this.normalize_columns_names(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_csv_product_import_mapping_default_columns'),
		var_default_columns.clone(),
		var_raw_headers.clone(),
	]))
	mut var_special_columns := this.get_special_columns(this.normalize_columns_names(rt.call_function('apply_filters', [
		rt.new_string('woocommerce_csv_product_import_mapping_special_columns'),
		rt.create_array([
			rt.ArrayItem{ key: rt.call_function('__', [
				rt.new_string('Attribute %d name'),
				rt.new_string('woocommerce'),
			]), val: 'attributes:name' },
			rt.ArrayItem{ key: rt.call_function('__', [
				rt.new_string('Attribute %d value(s)'),
				rt.new_string('woocommerce'),
			]), val: 'attributes:value' },
			rt.ArrayItem{ key: rt.call_function('__', [
				rt.new_string('Attribute %d visible'),
				rt.new_string('woocommerce'),
			]), val: 'attributes:visible' },
			rt.ArrayItem{ key: rt.call_function('__', [
				rt.new_string('Attribute %d global'),
				rt.new_string('woocommerce'),
			]), val: 'attributes:taxonomy' },
			rt.ArrayItem{ key: rt.call_function('__', [
				rt.new_string('Attribute %d default'),
				rt.new_string('woocommerce'),
			]), val: 'attributes:default' },
			rt.ArrayItem{ key: rt.call_function('__', [
				rt.new_string('Download %d ID'),
				rt.new_string('woocommerce'),
			]), val: 'downloads:id' },
			rt.ArrayItem{ key: rt.call_function('__', [
				rt.new_string('Download %d name'),
				rt.new_string('woocommerce'),
			]), val: 'downloads:name' },
			rt.ArrayItem{ key: rt.call_function('__', [
				rt.new_string('Download %d URL'),
				rt.new_string('woocommerce'),
			]), val: 'downloads:url' },
			rt.ArrayItem{ key: rt.call_function('__', [
				rt.new_string('Meta: %s'),
				rt.new_string('woocommerce'),
			]), val: 'meta:' },
		]),
		var_raw_headers.clone(),
	])))
	mut var_headers := map[string]rt.PhpVal{}
	mut iter_4 := var_raw_headers.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_field := item_4.val
		mut var_key := item_4.key
		mut var_normalized_field := rt.new_string(var_field.clone().to_string().to_lower())
		mut var_index := if var_num_indexes { var_key } else { var_field }
		var_headers.array_set(var_index, var_normalized_field.clone())
		if var_default_columns.array_isset(var_normalized_field) {
			var_headers.array_set(var_index, var_default_columns.array_get(var_normalized_field))
		} else {
			mut iter_5 := var_special_columns.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_special_key := item_5.val
				mut var_regex := item_5.key
				if rt.is_true(rt.call_function('preg_match', [
					var_regex.clone(), var_field.clone(), rt.create_array_from_list(var_matches)]))
				{
					var_headers.array_set(var_index, var_special_key.str() +
						(var_matches.array_get(rt.new_int(1))).str())
					break
				}
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_csv_product_import_mapped_columns'),
		var_headers.clone(),
		var_raw_headers.clone(),
	])
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) auto_map_user_preferences(var_headers rt.PhpVal) rt.PhpVal {
	mut var_headers_mutated := var_headers
	mut var_mapping_preferences := rt.call_function('get_user_option', [
		rt.new_string('woocommerce_product_import_mapping'),
	])
	if !(!rt.is_true(var_mapping_preferences)) && var_mapping_preferences.clone().is_array() {
		return var_mapping_preferences.clone()
	}
	return var_headers_mutated.clone()
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) sanitize_special_column_name_regex(var_value rt.PhpVal) string {
	return '/' +
		(rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{
		key: none
		val: '%d'
	}, rt.ArrayItem{ key: none, val: '%s' }]), rt.new_string('(.*)'), rt.new_string(rt.call_function('quotemeta', [var_value.clone()]).to_string().trim_space())])).str() +
		'/i'
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) get_special_columns(var_columns rt.PhpVal) rt.PhpVal {
	mut var_formatted := map[string]rt.PhpVal{}
	mut iter_6 := var_columns.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_value := item_6.val
		mut var_key := item_6.key
		mut var_regex := rt.new_string(this.sanitize_special_column_name_regex(var_key.clone()))
		var_formatted.array_set(var_regex, var_value.clone())
	}
	return var_formatted.clone()
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) get_mapping_options(item string) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	mut var_index := rt.new_string(item)
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/\\d+/'),
		rt.new_string(item), rt.create_array_from_list(var_matches)]))
	{
		var_index = var_matches.array_get(rt.new_int(0))
	}
	mut var_meta := rt.call_function('str_replace', [rt.new_string('meta:'),
		rt.new_string(''), rt.new_string(item)])
	mut iife_temp_3 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_3 := iife_temp_3.get_weight_unit_label(rt.call_function('get_option', [
		rt.new_string('woocommerce_weight_unit'),
		rt.new_string('kg'),
	]))
	mut var_weight_unit_label := iife_result_3
	mut iife_temp_4 := Class_Automattic_WooCommerce_Utilities_I18nUtil{}
	mut iife_result_4 := iife_temp_4.get_dimensions_unit_label(rt.call_function('get_option', [
		rt.new_string('woocommerce_dimension_unit'),
		rt.new_string('cm'),
	]))
	mut var_dimension_unit_label := iife_result_4
	mut var_options := rt.create_array([
		rt.ArrayItem{ key: 'id', val: rt.call_function('__', [
			rt.new_string('ID'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'type', val: rt.call_function('__', [
			rt.new_string('Type'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'sku', val: rt.call_function('__', [
			rt.new_string('SKU'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'global_unique_id', val: rt.call_function('__', [
			rt.new_string('GTIN, UPC, EAN, or ISBN'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Name'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'published', val: rt.call_function('__', [
			rt.new_string('Published'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'featured', val: rt.call_function('__', [
			rt.new_string('Is featured?'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'catalog_visibility', val: rt.call_function('__', [
			rt.new_string('Visibility in catalog'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'short_description', val: rt.call_function('__', [
			rt.new_string('Short description'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Description'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'price', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Price'),
			rt.new_string('woocommerce'),
		]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([
			rt.ArrayItem{ key: 'regular_price', val: rt.call_function('__', [
				rt.new_string('Regular price'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'sale_price', val: rt.call_function('__', [
				rt.new_string('Sale price'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'date_on_sale_from', val: rt.call_function('__', [
				rt.new_string('Date sale price starts'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'date_on_sale_to', val: rt.call_function('__', [
				rt.new_string('Date sale price ends'),
				rt.new_string('woocommerce'),
			]) },
		]) }]) },
		rt.ArrayItem{ key: 'tax_status', val: rt.call_function('__', [
			rt.new_string('Tax status'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'tax_class', val: rt.call_function('__', [
			rt.new_string('Tax class'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'stock_status', val: rt.call_function('__', [
			rt.new_string('In stock?'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'stock_quantity', val: rt.call_function('_x', [
			rt.new_string('Stock'), rt.new_string('Quantity in stock'),
			rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'backorders', val: rt.call_function('__', [
			rt.new_string('Backorders allowed?'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'low_stock_amount', val: rt.call_function('__', [
			rt.new_string('Low stock amount'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'sold_individually', val: rt.call_function('__', [
			rt.new_string('Sold individually?'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'weight', val: rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('Weight (%s)'),
				rt.new_string('woocommerce'),
			]),
			var_weight_unit_label.clone()]) },
		rt.ArrayItem{ key: 'dimensions', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Dimensions'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'length', val: rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Length (%s)'),
						rt.new_string('woocommerce')]),
					var_dimension_unit_label.clone(),
				]) },
				rt.ArrayItem{ key: 'width', val: rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Width (%s)'),
						rt.new_string('woocommerce')]),
					var_dimension_unit_label.clone(),
				]) },
				rt.ArrayItem{ key: 'height', val: rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('Height (%s)'),
						rt.new_string('woocommerce')]),
					var_dimension_unit_label.clone(),
				]) },
			]) }]) },
		rt.ArrayItem{ key: 'category_ids', val: rt.call_function('__', [
			rt.new_string('Categories'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'tag_ids', val: rt.call_function('__', [
			rt.new_string('Tags (comma separated)'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'tag_ids_spaces', val: rt.call_function('__', [
			rt.new_string('Tags (space separated)'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'shipping_class_id', val: rt.call_function('__', [
			rt.new_string('Shipping class'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'images', val: rt.call_function('__', [
			rt.new_string('Images'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'parent_id', val: rt.call_function('__', [
			rt.new_string('Parent'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'upsell_ids', val: rt.call_function('__', [
			rt.new_string('Upsells'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'cross_sell_ids', val: rt.call_function('__', [
			rt.new_string('Cross-sells'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'grouped_products', val: rt.call_function('__', [
			rt.new_string('Grouped products'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'external', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('External product'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'product_url', val: rt.call_function('__', [
					rt.new_string('External URL'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'button_text', val: rt.call_function('__', [
					rt.new_string('Button text'),
					rt.new_string('woocommerce'),
				]) },
			]) }]) },
		rt.ArrayItem{ key: 'downloads', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Downloads'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'downloads:id' + var_index.str(), val: rt.call_function('__', [
					rt.new_string('Download ID'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'downloads:name' + var_index.str(), val: rt.call_function('__', [
					rt.new_string('Download name'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'downloads:url' + var_index.str(), val: rt.call_function('__', [
					rt.new_string('Download URL'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'download_limit', val: rt.call_function('__', [
					rt.new_string('Download limit'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'download_expiry', val: rt.call_function('__', [
					rt.new_string('Download expiry days'),
					rt.new_string('woocommerce'),
				]) },
			]) }]) },
		rt.ArrayItem{ key: 'attributes', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
				rt.new_string('Attributes'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'attributes:name' + var_index.str(), val: rt.call_function('__', [
					rt.new_string('Attribute name'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'attributes:value' + var_index.str(), val: rt.call_function('__', [
					rt.new_string('Attribute value(s)'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'attributes:taxonomy' + var_index.str(), val: rt.call_function('__', [
					rt.new_string('Is a global attribute?'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'attributes:visible' + var_index.str(), val: rt.call_function('__', [
					rt.new_string('Attribute visibility'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'attributes:default' + var_index.str(), val: rt.call_function('__', [
					rt.new_string('Default attribute'),
					rt.new_string('woocommerce'),
				]) },
			]) }]) },
		rt.ArrayItem{ key: 'reviews_allowed', val: rt.call_function('__', [
			rt.new_string('Allow customer reviews?'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'purchase_note', val: rt.call_function('__', [
			rt.new_string('Purchase note'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'meta:' + var_meta.str(), val: rt.call_function('__', [
			rt.new_string('Import as meta data'), rt.new_string('woocommerce')]) },
		rt.ArrayItem{ key: 'menu_order', val: rt.call_function('__', [
			rt.new_string('Position'), rt.new_string('woocommerce')]) },
	])
	if rt.is_true(rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
		'get', [
		Class_Automattic_WooCommerce_Internal_CostOfGoodsSold_CostOfGoodsSoldController.class(),
	]), 'feature_is_enabled', []rt.PhpVal{}))
	{
		var_options.array_set('cogs_value', rt.call_function('__', [
			rt.new_string('Cost of goods'),
			rt.new_string('woocommerce'),
		]))
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_csv_product_import_mapping_options'),
		var_options.clone(),
		rt.new_string(item),
	])
}

struct Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_I18nUtil {
	rt.PhpObjectBase
}

fn create_wc_product_csv_importer_controller() &Class_WC_Product_CSV_Importer_Controller {
	mut obj := &Class_WC_Product_CSV_Importer_Controller{
		PhpObjectBase:      rt.PhpObjectBase{}
		file:               rt.new_string('')
		step:               rt.new_string('')
		steps:              rt.new_array()
		errors:             rt.new_array()
		delimiter:          rt.new_string(',')
		map_preferences:    rt.new_bool(false)
		update_existing:    rt.new_bool(false)
		character_encoding: rt.new_string('UTF-8')
	}
	obj.construct()
	return obj
}

fn create_automattic_woocommerce_internal_utilities_filesystemutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_FilesystemUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_i18nutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_I18nUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_I18nUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Product_CSV_Importer_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_importer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WC_Product_CSV_Importer_Controller.get_importer(dispatch_arg_0,
				dispatch_arg_1)
		}
		'is_file_valid_csv' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_WC_Product_CSV_Importer_Controller.is_file_valid_csv(dispatch_arg_0,
				dispatch_arg_1)
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
		else {
			return none
		}
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
		'file' {
			this.file = val
			return true
		}
		'step' {
			this.step = val
			return true
		}
		'steps' {
			this.steps = val
			return true
		}
		'errors' {
			this.errors = val
			return true
		}
		'delimiter' {
			this.delimiter = val
			return true
		}
		'map_preferences' {
			this.map_preferences = val
			return true
		}
		'update_existing' {
			this.update_existing = val
			return true
		}
		'character_encoding' {
			this.character_encoding = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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
		else {
			return none
		}
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
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_I18nUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('WC_Product_CSV_Importer_Controller', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wc_product_csv_importer_controller()
		return rt.new_object('WC_Product_CSV_Importer_Controller', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Internal_Utilities_FilesystemUtil', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_internal_utilities_filesystemutil()
		return rt.new_object('Automattic_WooCommerce_Internal_Utilities_FilesystemUtil',
			[]string{}, obj)
	})
	rt.register_class_factory('Exception', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_exception(c_arg_0)
		return rt.new_object('Exception', []string{}, obj)
	})
	rt.register_class_factory('WP_Error', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Utilities_I18nUtil', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_utilities_i18nutil()
		return rt.new_object('Automattic_WooCommerce_Utilities_I18nUtil', []string{}, obj)
	})
}

fn init() {
	init_registry()
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
		rt.new_string('WP_Importer'),
	])))))
	{
		return rt.new_null()
	}
}
