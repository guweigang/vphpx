import rt

pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.post_type() string {
	return 'import_session'
}
pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.stage_initial() string {
	return 'initial'
}
pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.stage_finished() string {
	return 'finished'
}
pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.stages_in_order() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.stage_initial() }, rt.ArrayItem{ key: none, val: 'indexing' }, rt.ArrayItem{ key: none, val: 'preparing' }, rt.ArrayItem{ key: none, val: 'importing' }, rt.ArrayItem{ key: none, val: 'finalizing' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.stage_finished() }])
}
pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.event_success() string {
	return 'success'
}
pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.event_already_exists() string {
	return 'already_exists'
}
pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.event_failure() string {
	return 'failure'
}
pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.progress_entities() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'site_option' }, rt.ArrayItem{ key: none, val: 'user' }, rt.ArrayItem{ key: none, val: 'category' }, rt.ArrayItem{ key: none, val: 'tag' }, rt.ArrayItem{ key: none, val: 'term' }, rt.ArrayItem{ key: none, val: 'post' }, rt.ArrayItem{ key: none, val: 'post_meta' }, rt.ArrayItem{ key: none, val: 'comment' }, rt.ArrayItem{ key: none, val: 'comment_meta' }])
}
pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.frontload_status_awaiting_download() string {
	return 'awaiting_download'
}
pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.frontload_status_ignored() string {
	return 'ignored'
}
pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.frontload_status_error() string {
	return 'error'
}
pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.frontload_status_succeeded() string {
	return 'succeeded'
}
struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession {
	rt.PhpObjectBase
pub mut:
		post_id rt.PhpVal = rt.new_null()
		cached_stage rt.PhpVal = rt.new_null()
		cached_imported_counts rt.PhpVal = rt.new_array()
		cached_totals rt.PhpVal = rt.new_array()
}

fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.create(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut switch_val_1 := var_args_mutated.array_get('data_source')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('wxr_file'))) {
		if !rt.is_true(var_args_mutated.array_get('file_name')) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Exception', []string{}, create_automattic_woocommerce_internal_cli_migrator_lib_exception(rt.new_string('File name is required for WXR file imports'))))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wxr_url'))) {
		if !rt.is_true(var_args_mutated.array_get('source_url')) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Exception', []string{}, create_automattic_woocommerce_internal_cli_migrator_lib_exception(rt.new_string('Source URL is required for remote imports'))))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('markdown_zip'))) {
		if !rt.is_true(var_args_mutated.array_get('file_name')) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Exception', []string{}, create_automattic_woocommerce_internal_cli_migrator_lib_exception(rt.new_string('File name is required for Markdown ZIP imports'))))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('local_directory'))) {
		if !rt.is_true(var_args_mutated.array_get('file_name')) {
			rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Exception', []string{}, create_automattic_woocommerce_internal_cli_migrator_lib_exception(rt.new_string('Directory path is required for local directory imports'))))
		}
	}
	mut var_post_id := rt.call_function('wp_insert_post', [rt.create_array([rt.ArrayItem{ key: 'post_type', val: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.post_type() }, rt.ArrayItem{ key: 'post_status', val: 'publish' }, rt.ArrayItem{ key: 'post_title', val: rt.call_function('sprintf', [rt.new_string('Import from %s - %s'), var_args_mutated.array_get('data_source'), if !(var_args_mutated.array_get('file_name')).is_null() { var_args_mutated.array_get('file_name') } else { if !(var_args_mutated.array_get('source_url')).is_null() { var_args_mutated.array_get('source_url') } else { rt.new_string('Unknown source') } }]) }, rt.ArrayItem{ key: 'meta_input', val: rt.create_array([rt.ArrayItem{ key: 'data_source', val: var_args_mutated.array_get('data_source') }, rt.ArrayItem{ key: 'started_at', val: rt.call_function('time', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'file_name', val: if !(var_args_mutated.array_get('file_name')).is_null() { var_args_mutated.array_get('file_name') } else { rt.new_null() } }, rt.ArrayItem{ key: 'source_url', val: if !(var_args_mutated.array_get('source_url')).is_null() { var_args_mutated.array_get('source_url') } else { rt.new_null() } }, rt.ArrayItem{ key: 'attachment_id', val: if !(var_args_mutated.array_get('attachment_id')).is_null() { var_args_mutated.array_get('attachment_id') } else { rt.new_null() } }]) }]), rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.dup()])) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Exception', []string{}, create_automattic_woocommerce_internal_cli_migrator_lib_exception('Error creating an import session: ' + (rt.call_method(var_post_id, 'get_error_message', []rt.PhpVal{})).str())))
	}
	if !(!rt.is_true(var_args_mutated.array_get('attachment_id'))) {
		rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: var_post_id }, rt.ArrayItem{ key: 'post_parent', val: var_args_mutated.array_get('attachment_id') }])])
	}
	return create_automattic_woocommerce_internal_cli_migrator_lib_self(var_post_id.dup())
}

fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.by_id(var_post_id rt.PhpVal) bool {
	mut var_post_id_mutated := var_post_id
	mut var_post := rt.call_function('get_post', [var_post_id_mutated.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return false
	}
	return (create_automattic_woocommerce_internal_cli_migrator_lib_self(var_post_id_mutated.dup())).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.get_active() bool {
	mut var_posts := rt.call_function('get_posts', [rt.create_array([rt.ArrayItem{ key: 'post_type', val: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.post_type() }, rt.ArrayItem{ key: 'post_status', val: rt.create_array([rt.ArrayItem{ key: none, val: 'publish' }]) }, rt.ArrayItem{ key: 'posts_per_page', val: 1 }, rt.ArrayItem{ key: 'orderby', val: 'date' }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'meta_query', val: rt.new_array() }])])
	if !rt.is_true(var_posts) {
		return false
	}
	return (create_automattic_woocommerce_internal_cli_migrator_lib_self(rt.get_property(var_posts.array_get(0), 'ID'))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) construct(var_post_id rt.PhpVal)  {
	mut var_post_id_mutated := var_post_id
	this.post_id = var_post_id_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) get_id() rt.PhpVal {
	return this.post_id
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) get_metadata() rt.PhpVal {
	mut var_cursor := this.get_reentrancy_cursor()
	return rt.create_array([rt.ArrayItem{ key: 'post_id', val: this.post_id }, rt.ArrayItem{ key: 'cursor', val: if rt.is_true(var_cursor) { var_cursor } else { rt.new_null() } }, rt.ArrayItem{ key: 'data_source', val: rt.call_function('get_post_meta', [this.post_id, rt.new_string('data_source'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'source_url', val: rt.call_function('get_post_meta', [this.post_id, rt.new_string('source_url'), rt.new_bool(true)]) }, rt.ArrayItem{ key: 'attachment_id', val: rt.call_function('get_post_meta', [this.post_id, rt.new_string('attachment_id'), rt.new_bool(true)]) }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) get_data_source() rt.PhpVal {
	return rt.call_function('get_post_meta', [this.post_id, rt.new_string('data_source'), rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) get_human_readable_file_reference() string {
	mut switch_val_2 := this.get_data_source()
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('wxr_file'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('markdown_zip'))) {
		return (rt.call_function('get_post_meta', [this.post_id, rt.new_string('file_name'), rt.new_bool(true)])).str()
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('wxr_url'))) {
		return (rt.call_function('get_post_meta', [this.post_id, rt.new_string('source_url'), rt.new_bool(true)])).str()
	}
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) archive()  {
	rt.call_function('wp_update_post', [rt.create_array([rt.ArrayItem{ key: 'ID', val: this.post_id }, rt.ArrayItem{ key: 'post_status', val: 'archived' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) count_imported_entities() rt.PhpVal {
	mut var_progress := rt.new_array()
	{
		mut iter_1 := Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.progress_entities().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_entity := item_1.val
			var_progress.array_push(rt.create_array([rt.ArrayItem{ key: 'label', val: var_entity }, rt.ArrayItem{ key: 'imported', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'total', val: // unsupported expression: Expr_Cast_Int }]))
		}
	}
	return var_progress.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) count_all_imported_entities() rt.PhpVal {
	mut var_counts := this.count_imported_entities()
	return rt.call_function('array_sum', [rt.call_function('array_column', [var_counts.dup(), rt.new_string('imported')])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) count_all_total_entities() rt.PhpVal {
	mut var_counts := this.count_imported_entities()
	return rt.call_function('array_sum', [rt.call_function('array_column', [var_counts.dup(), rt.new_string('total')])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) count_remaining_entities() rt.PhpVal {
	mut var_counts := this.count_imported_entities()
	return rt.sub(rt.call_function('array_sum', [rt.call_function('array_column', [var_counts.dup(), rt.new_string('total')])]), rt.call_function('array_sum', [rt.call_function('array_column', [var_counts.dup(), rt.new_string('imported')])]))
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) bump_imported_entities_counts(var_newly_imported_entities rt.PhpVal)  {
	{
		mut iter_1 := var_newly_imported_entities.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_count := item_1.val
			mut var_field := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_field.dup(), Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_static.progress_entities(), rt.new_bool(true)]))))) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), 'Cannot bump imported entities count for unknown entity type: ' + (var_field).str(), rt.new_string('1.0.0')])
				continue
			}
			if !(this.cached_imported_counts.array_isset(var_field)) {
				this.cached_imported_counts.array_set(var_field, // unsupported expression: Expr_Cast_Int)
			}
			mut var_new_count := rt.add(this.cached_imported_counts.array_get(var_field), var_count)
			rt.call_function('update_post_meta', [this.post_id, 'imported_' + (var_field).str(), var_new_count.dup()])
			this.cached_imported_counts.array_set(var_field, var_new_count.dup())
			// unsupported statement: Stmt_Nop
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) count_awaiting_frontloading_stubs() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return // unsupported expression: Expr_Cast_Int
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) count_unfinished_frontloading_stubs() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return // unsupported expression: Expr_Cast_Int
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) mark_frontloading_errors_as_ignored()  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'), rt.create_array([rt.ArrayItem{ key: 'post_status', val: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.frontload_status_ignored() }]), rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'frontloading_stub' }])])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) get_frontloading_stubs(var_options rt.PhpVal) rt.PhpVal {
	mut var_query := create_wp_query(rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'frontloading_stub' }, rt.ArrayItem{ key: 'post_status', val: 'any' }, rt.ArrayItem{ key: 'post_parent', val: this.post_id }, rt.ArrayItem{ key: 'posts_per_page', val: if !(var_options.array_get('per_page')).is_null() { var_options.array_get('per_page') } else { rt.new_int(25) } }, rt.ArrayItem{ key: 'paged', val: if !(var_options.array_get('page')).is_null() { var_options.array_get('page') } else { rt.new_int(1) } }, rt.ArrayItem{ key: 'orderby', val: rt.create_array([rt.ArrayItem{ key: 'post_status', val: rt.create_array([rt.ArrayItem{ key: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.frontload_status_error(), val: 0 }, rt.ArrayItem{ key: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.frontload_status_awaiting_download(), val: 1 }, rt.ArrayItem{ key: 'any', val: 2 }]) }, rt.ArrayItem{ key: 'ID', val: 'ASC' }]) }]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_query.have_posts())))) {
		return rt.new_array()
	}
	mut var_posts := rt.get_property(var_query, 'posts')
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_post := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_post, 'ID')
	}
	mut var_post := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.get_property(var_post, 'ID')
	}
	mut var_ids := rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_posts.dup()])
	rt.call_function('update_meta_cache', [rt.new_string('post'), var_ids.dup()])
	{
		mut iter_1 := var_posts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post := item_1.val
			rt.set_property(var_post, 'meta', rt.call_function('get_all_post_meta_flat', [rt.get_property(var_post, 'ID')]))
		}
	}
	return var_posts.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) get_total_number_of_entities() rt.PhpVal {
	mut var_totals := rt.new_array()
	{
		mut iter_1 := Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_static.progress_entities().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			var_totals.array_set(var_field, // unsupported expression: Expr_Cast_Int)
		}
	}
	var_totals.array_set('download', this.get_total_number_of_assets())
	return var_totals.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) get_total_number_of_assets() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	return // unsupported expression: Expr_Cast_Int
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) get_frontloading_stub(var_url rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_url_mutated := var_url
	// unsupported statement: Stmt_Global
	mut var_id := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT p.ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' p\n\t\t\t\t INNER JOIN ')), rt.get_property(var_wpdb, 'postmeta')), rt.new_string(' pm ON p.ID = pm.post_id\n\t\t\t\t WHERE p.post_type = \'frontloading_stub\'\n\t\t\t\t AND p.post_parent = %d\n\t\t\t\t AND pm.meta_key = \'current_url\'\n\t\t\t\t AND pm.meta_value = %s\n\t\t\t\t LIMIT 1')), this.post_id, var_url_mutated.dup()])])
	return rt.call_function('get_post', [var_id.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) create_frontloading_stubs(var_urls rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	{
		mut iter_1 := var_urls.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var__ := item_1.val
			mut var_url := item_1.key
			mut var_exists := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string('\n\t\t\t\tWHERE post_type = \'frontloading_stub\'\n\t\t\t\tAND post_parent = %d\n\t\t\t\tAND guid = %s\n\t\t\t\tLIMIT 1')), this.post_id, var_url.dup()])])
			if rt.is_true(var_exists) {
				continue
			}
			mut var_post_data := rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'frontloading_stub' }, rt.ArrayItem{ key: 'post_parent', val: this.post_id }, rt.ArrayItem{ key: 'post_title', val: rt.call_function('basename', [var_url.dup()]) }, rt.ArrayItem{ key: 'post_status', val: Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.frontload_status_awaiting_download() }, rt.ArrayItem{ key: 'guid', val: var_url }, rt.ArrayItem{ key: 'meta_input', val: rt.create_array([rt.ArrayItem{ key: 'original_url', val: var_url }, rt.ArrayItem{ key: 'current_url', val: var_url }, rt.ArrayItem{ key: 'attempts', val: 0 }, rt.ArrayItem{ key: 'last_error', val: rt.new_null() }, rt.ArrayItem{ key: 'target_path', val: '' }]) }])
			mut var_insertion_result := rt.call_function('wp_insert_post', [var_post_data.dup()])
			if rt.is_true(rt.call_function('is_wp_error', [var_insertion_result.dup()])) {
				rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Exception', []string{}, create_automattic_woocommerce_internal_cli_migrator_lib_exception(rt.new_string('Failed to insert frontloading placeholder'))))
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) bump_total_number_of_entities(var_newly_indexed_entities rt.PhpVal)  {
	{
		mut iter_1 := var_newly_indexed_entities.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_count := item_1.val
			mut var_field := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_field.dup(), Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_static.progress_entities(), rt.new_bool(true)]))))) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), 'Cannot set total number of entities for unknown entity type: ' + (var_field).str(), rt.new_string('1.0.0')])
				continue
			}
			if !(this.cached_totals.array_isset(var_field)) {
				this.cached_totals.array_set(var_field, // unsupported expression: Expr_Cast_Int)
			}
			mut var_new_total := rt.add(this.cached_totals.array_get(var_field), var_count)
			rt.call_function('update_post_meta', [this.post_id, 'total_' + (var_field).str(), var_new_total.dup()])
			this.cached_totals.array_set(var_field, var_new_total.dup())
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) bump_frontloading_progress(var_frontloading_progress rt.PhpVal, var_events rt.PhpVal)  {
	rt.call_function('update_post_meta', [this.post_id, rt.new_string('frontloading_progress'), var_frontloading_progress.dup()])
	{
		mut iter_1 := var_events.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_event := item_1.val
			mut var_url := rt.get_property(var_event, 'resource_id')
			mut var_placeholder := this.get_frontloading_stub(var_url.dup())
			if rt.is_true(rt.new_bool(!(rt.is_true(var_placeholder)))) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), 'Frontloading placeholder post not found for URL: ' + (var_url).str(), rt.new_string('1.0.0')])
				continue
			}
			rt.call_function('update_post_meta', [rt.get_property(var_placeholder, 'ID'), rt.new_string('last_error'), rt.get_property(var_event, 'error')])
			mut var_attempts := rt.call_function('get_post_meta', [rt.get_property(var_placeholder, 'ID'), rt.new_string('attempts'), rt.new_bool(true)])
			mut var_new_attempts := var_attempts.dup()
			mut var_new_status := rt.get_property(, 'post_status')
			mut switch_val_3 := rt.get_property(, 'type')
			if rt.is_true(rt.equal(switch_val_3, Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.event_success())) {
				
			} else if rt.is_true(rt.equal(switch_val_3, )) {
			} else if rt.is_true(rt.equal(switch_val_3, )) {
			}
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) get_frontloading_progress() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) is_stage_completed(var_stage rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) get_stage() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) set_stage(var_stage rt.PhpVal)  {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) get_started_at() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) get_finished_at() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) is_finished() bool {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) get_reentrancy_cursor() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) set_reentrancy_cursor(var_cursor rt.PhpVal)  {
	mut var_cursor_mutated := var_cursor
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) set_original_arguments(mut var_args Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_array)  {
	mut var_args_mutated := var_args
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) get_original_arguments() rt.PhpVal {
}

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Exception {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_self {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_cli_migrator_lib_importsession(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession{
		PhpObjectBase: rt.PhpObjectBase{}
		post_id: rt.new_null()
		cached_stage: rt.new_null()
		cached_imported_counts: rt.new_array()
		cached_totals: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_internal_cli_migrator_lib_exception() &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Exception {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_cli_migrator_lib_self() &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.create(dispatch_arg_0)
		}
		'by_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.by_id(dispatch_arg_0))
		}
		'get_active' {
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession.get_active())
		}
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_id' {
			return this.get_id()
		}
		'get_metadata' {
			return this.get_metadata()
		}
		'get_data_source' {
			return this.get_data_source()
		}
		'get_human_readable_file_reference' {
			return rt.new_string(this.get_human_readable_file_reference())
		}
		'archive' {
			this.archive()
			return rt.new_null()
		}
		'count_imported_entities' {
			return this.count_imported_entities()
		}
		'count_all_imported_entities' {
			return this.count_all_imported_entities()
		}
		'count_all_total_entities' {
			return this.count_all_total_entities()
		}
		'count_remaining_entities' {
			return this.count_remaining_entities()
		}
		'bump_imported_entities_counts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.bump_imported_entities_counts(dispatch_arg_0)
			return rt.new_null()
		}
		'count_awaiting_frontloading_stubs' {
			return this.count_awaiting_frontloading_stubs()
		}
		'count_unfinished_frontloading_stubs' {
			return this.count_unfinished_frontloading_stubs()
		}
		'mark_frontloading_errors_as_ignored' {
			this.mark_frontloading_errors_as_ignored()
			return rt.new_null()
		}
		'get_frontloading_stubs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_frontloading_stubs(dispatch_arg_0)
		}
		'get_total_number_of_entities' {
			return this.get_total_number_of_entities()
		}
		'get_total_number_of_assets' {
			return this.get_total_number_of_assets()
		}
		'get_frontloading_stub' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_frontloading_stub(dispatch_arg_0)
		}
		'create_frontloading_stubs' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create_frontloading_stubs(dispatch_arg_0)
			return rt.new_null()
		}
		'bump_total_number_of_entities' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.bump_total_number_of_entities(dispatch_arg_0)
			return rt.new_null()
		}
		'bump_frontloading_progress' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.bump_frontloading_progress(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_frontloading_progress' {
			return this.get_frontloading_progress()
		}
		'is_stage_completed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_stage_completed(dispatch_arg_0)
		}
		'get_stage' {
			return this.get_stage()
		}
		'set_stage' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_stage(dispatch_arg_0)
			return rt.new_null()
		}
		'get_started_at' {
			return this.get_started_at()
		}
		'get_finished_at' {
			return this.get_finished_at()
		}
		'is_finished' {
			return rt.new_bool(this.is_finished())
		}
		'get_reentrancy_cursor' {
			return this.get_reentrancy_cursor()
		}
		'set_reentrancy_cursor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_reentrancy_cursor(dispatch_arg_0)
			return rt.new_null()
		}
		'set_original_arguments' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.set_original_arguments(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_original_arguments' {
			return this.get_original_arguments()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'post_id' { return this.post_id }
		'cached_stage' { return this.cached_stage }
		'cached_imported_counts' { return this.cached_imported_counts }
		'cached_totals' { return this.cached_totals }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_ImportSession) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'post_id' { this.post_id = val; return true }
		'cached_stage' { this.cached_stage = val; return true }
		'cached_imported_counts' { this.cached_imported_counts = val; return true }
		'cached_totals' { this.cached_totals = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Lib_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_cli_migrator_lib_importsession_php() {
}
