import rt

struct Class_WP_List_Table {
	rt.PhpObjectBase
pub mut:
		items rt.PhpVal = rt.new_null()
		_args rt.PhpVal = rt.new_null()
		_pagination_args rt.PhpVal = rt.new_array()
		screen rt.PhpVal = rt.new_null()
		_actions rt.PhpVal = rt.new_null()
		_pagination string
		modes rt.PhpVal = rt.new_array()
		_column_headers rt.PhpVal = rt.new_null()
		compat_fields rt.PhpVal = rt.new_array()
		compat_methods rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_List_Table) construct(var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'plural', val: '' }, rt.ArrayItem{ key: 'singular', val: '' }, rt.ArrayItem{ key: 'ajax', val: false }, rt.ArrayItem{ key: 'screen', val: rt.new_null() }])])
	this.screen = rt.call_function('convert_to_screen', [var_args_mutated.array_get('screen')])
	rt.call_function('add_filter', [rt.concat(rt.concat(rt.new_string('manage_'), rt.get_property(this.screen, 'id')), rt.new_string('_columns')), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_List_Table', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_columns' }]), rt.new_int(0)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get('plural'))))) {
		var_args_mutated.array_set('plural', rt.get_property(this.screen, 'base'))
	}
	var_args_mutated.array_set('plural', rt.call_function('sanitize_key', [var_args_mutated.array_get('plural')]))
	var_args_mutated.array_set('singular', rt.call_function('sanitize_key', [var_args_mutated.array_get('singular')]))
	this._args = var_args_mutated.dup()
	if rt.is_true(var_args_mutated.array_get('ajax')) {
		rt.call_function('add_action', [rt.new_string('admin_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_List_Table', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_js_vars' }])])
	}
	if !rt.is_true(this.modes) {
		this.modes = rt.create_array([rt.ArrayItem{ key: 'list', val: rt.call_function('__', [rt.new_string('Compact view')]) }, rt.ArrayItem{ key: 'excerpt', val: rt.call_function('__', [rt.new_string('Extended view')]) }])
	}
}

fn (mut this Class_WP_List_Table) magic_get(var_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('in_array', [var_name.dup(), this.compat_fields, rt.new_bool(true)])) {
		return rt.get_property(rt.new_object('WP_List_Table', []string{}, &this), '{"nodeType":"Expr_Variable","line":186,"name":"name"}')
	}
	rt.call_function('wp_trigger_error', [rt.new_string(@METHOD), "The property `${var_name.to_string()}` is not declared. Getting a dynamic property is " + 'deprecated since version 6.4.0! Instead, declare the property on the class.', rt.get_constant('E_USER_DEPRECATED')])
	return rt.new_null()
}

fn (mut this Class_WP_List_Table) magic_set(var_name rt.PhpVal, var_value rt.PhpVal)  {
	if rt.is_true(rt.call_function('in_array', [var_name.dup(), this.compat_fields, rt.new_bool(true)])) {
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":209,"name":"name"}', var_value.dup())
		return rt.new_null()
	}
	rt.call_function('wp_trigger_error', [rt.new_string(@METHOD), "The property `${var_name.to_string()}` is not declared. Setting a dynamic property is " + 'deprecated since version 6.4.0! Instead, declare the property on the class.', rt.get_constant('E_USER_DEPRECATED')])
}

fn (mut this Class_WP_List_Table) magic_isset(var_name rt.PhpVal) bool {
	if rt.is_true(rt.call_function('in_array', [var_name.dup(), this.compat_fields, rt.new_bool(true)])) {
		return (rt.new_bool(!(rt.get_property(rt.new_object('WP_List_Table', []string{}, &this), '{"nodeType":"Expr_Variable","line":232,"name":"name"}')).is_null())).to_bool()
	}
	rt.call_function('wp_trigger_error', [rt.new_string(@METHOD), "The property `${var_name.to_string()}` is not declared. Checking `isset()` on a dynamic property " + 'is deprecated since version 6.4.0! Instead, declare the property on the class.', rt.get_constant('E_USER_DEPRECATED')])
	return false
}

fn (mut this Class_WP_List_Table) magic_unset(var_name rt.PhpVal)  {
	if rt.is_true(rt.call_function('in_array', [var_name.dup(), this.compat_fields, rt.new_bool(true)])) {
		rt.get_property(rt.new_object('WP_List_Table', []string{}, &this), '{"nodeType":"Expr_Variable","line":254,"name":"name"}') = rt.new_null()
		return rt.new_null()
	}
	rt.call_function('wp_trigger_error', [rt.new_string(@METHOD), "A property `${var_name.to_string()}` is not declared. Unsetting a dynamic property is " + 'deprecated since version 6.4.0! Instead, declare the property on the class.', rt.get_constant('E_USER_DEPRECATED')])
}

fn (mut this Class_WP_List_Table) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) bool {
	if rt.is_true(rt.call_function('in_array', [var_name.dup(), this.compat_methods, rt.new_bool(true)])) {
		return (rt.call_method(rt.new_object('WP_List_Table', []string{}, &this), var_name, [var_arguments.dup()])).to_bool()
	}
	return false
}

fn (mut this Class_WP_List_Table) ajax_user_can()  {
	// unsupported expression: Expr_Exit
}

fn (mut this Class_WP_List_Table) prepare_items()  {
	// unsupported expression: Expr_Exit
}

fn (mut this Class_WP_List_Table) set_pagination_args(var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'total_items', val: 0 }, rt.ArrayItem{ key: 'total_pages', val: 0 }, rt.ArrayItem{ key: 'per_page', val: 0 }])])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get('total_pages'))))) && rt.is_true(rt.greater(var_args_mutated.array_get('per_page'), rt.new_int(0))))) {
		var_args_mutated.array_set('total_pages', // unsupported expression: Expr_Cast_Int)
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))))))) && rt.is_true(rt.greater(var_args_mutated.array_get('total_pages'), rt.new_int(0))))) && rt.is_true(rt.greater(this.get_pagenum(), var_args_mutated.array_get('total_pages'))))) {
		rt.call_function('wp_redirect', [rt.call_function('add_query_arg', [rt.new_string('paged'), var_args_mutated.array_get('total_pages')])])
		// unsupported expression: Expr_Exit
	}
	this._pagination_args = var_args_mutated.dup()
}

fn (mut this Class_WP_List_Table) get_pagination_arg(var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('page'), var_key)) {
		return this.get_pagenum()
	}
	return if !(this._pagination_args.array_get(var_key)).is_null() { this._pagination_args.array_get(var_key) } else { rt.new_int(0) }
}

fn (mut this Class_WP_List_Table) has_items() bool {
	return !(!rt.is_true(this.items))
}

fn (mut this Class_WP_List_Table) no_items()  {
	rt.call_function('_e', [rt.new_string('No items found.')])
}

fn (mut this Class_WP_List_Table) search_box(var_text rt.PhpVal, var_input_id rt.PhpVal)  {
	mut var_input_id_mutated := var_input_id
	if !rt.is_true(rt.get_superglobal('_REQUEST').array_get('s')) && !(this.has_items()) {
		return rt.new_null()
	}
	var_input_id_mutated = rt.new_string((var_input_id_mutated).str() + '-search-input')
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('orderby'))) {
		if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_get('orderby').is_array())) {
			{
				mut iter_1 := rt.get_superglobal('_REQUEST').array_get('orderby').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_value := item_1.val
					mut var_key := item_1.key
					print('<input type="hidden" name="orderby[' + (rt.call_function('esc_attr', [var_key.dup()])).str() + ']" value="' + (rt.call_function('esc_attr', [var_value.dup()])).str() + '" />')
				}
			}
		} else {
			print('<input type="hidden" name="orderby" value="' + (rt.call_function('esc_attr', [rt.get_superglobal('_REQUEST').array_get('orderby')])).str() + '" />')
		}
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('order'))) {
		print('<input type="hidden" name="order" value="' + (rt.call_function('esc_attr', [rt.get_superglobal('_REQUEST').array_get('order')])).str() + '" />')
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('post_mime_type'))) {
		print('<input type="hidden" name="post_mime_type" value="' + (rt.call_function('esc_attr', [rt.get_superglobal('_REQUEST').array_get('post_mime_type')])).str() + '" />')
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('detached'))) {
		print('<input type="hidden" name="detached" value="' + (rt.call_function('esc_attr', [rt.get_superglobal('_REQUEST').array_get('detached')])).str() + '" />')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_input_id_mutated.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_text)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_input_id_mutated.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_admin_search_query', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [var_text.dup(), rt.new_string(''), rt.new_string(''), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'id', val: 'search-submit' }])])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_List_Table) get_views_links(var_link_data rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_link_data.dup().is_array()))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s argument must be an array.')]), rt.new_string('<code>$link_data</code>')]), rt.new_string('6.1.0')])
		return rt.create_array([rt.ArrayItem{ key: none, val: '' }])
	}
	mut var_views_links := rt.new_array()
	{
		mut iter_1 := var_link_data.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_link := item_1.val
			mut var_view := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_link.array_get('url')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_link.array_get('url').is_string()))))))) || rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_link.array_get('url').to_string().trim_space()))))) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %1$s argument must be a non-empty string for %2$s.')]), rt.new_string('<code>url</code>'), '<code>' + (rt.call_function('esc_html', [var_view.dup()])).str() + '</code>']), rt.new_string('6.1.0')])
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_link.array_get('label')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_link.array_get('label').is_string()))))))) || rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_link.array_get('label').to_string().trim_space()))))) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %1$s argument must be a non-empty string for %2$s.')]), rt.new_string('<code>label</code>'), '<code>' + (rt.call_function('esc_html', [var_view.dup()])).str() + '</code>']), rt.new_string('6.1.0')])
				continue
			}
			var_views_links.array_set(var_view, rt.call_function('sprintf', [rt.new_string('<a href="%s"%s>%s</a>'), rt.call_function('esc_url', [var_link.array_get('url')]), if rt.is_true(rt.new_bool(var_link.array_isset(rt.new_string('current')) && rt.is_true(rt.identical(rt.new_bool(true), var_link.array_get('current'))))) { rt.new_string(' class="current" aria-current="page"') } else { rt.new_string('') }, var_link.array_get('label')]))
		}
	}
	return var_views_links.dup()
}

fn (mut this Class_WP_List_Table) get_views() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WP_List_Table) views()  {
	mut var_views := this.get_views()
	var_views = rt.call_function('apply_filters', [rt.concat(rt.new_string('views_'), rt.get_property(this.screen, 'id')), var_views.dup()])
	if !rt.is_true(var_views) {
		return rt.new_null()
	}
	rt.call_method(this.screen, 'render_screen_reader_content', [rt.new_string('heading_views')])
	print('<ul class=\'subsubsub\'>\n')
	{
		mut iter_1 := var_views.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_view := item_1.val
			mut var_class := item_1.key
			var_views.array_set(var_class, "\t<li class='${var_class.to_string()}'>${var_view.to_string()}")
		}
	}
	print((rt.call_function('implode', [rt.new_string(' |</li>\n'), var_views.dup()])).str() + '</li>\n')
	print('</ul>')
}

fn (mut this Class_WP_List_Table) get_bulk_actions() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WP_List_Table) bulk_actions(which string)  {
	if rt.is_true(rt.new_bool(this._actions.is_null())) {
		this._actions = this.get_bulk_actions()
		this._actions = rt.call_function('apply_filters', [rt.concat(rt.new_string('bulk_actions-'), rt.get_property(this.screen, 'id')), this._actions])
		mut var_two := rt.new_string(rt.new_string(''))
	} else {
		var_two = rt.new_string(rt.new_string('2'))
	}
	if !rt.is_true(this._actions) {
		return rt.new_null()
	}
	print('<label for="bulk-action-selector-' + (rt.call_function('esc_attr', [rt.new_string(which)])).str() + '" class="screen-reader-text">' + (rt.call_function('__', [rt.new_string('Select bulk action')])).str() + '</label>')
	print('<select name="action' + (var_two).str() + '" id="bulk-action-selector-' + (rt.call_function('esc_attr', [rt.new_string(which)])).str() + '">\n')
	print('<option value="-1">' + (rt.call_function('__', [rt.new_string('Bulk actions')])).str() + '</option>\n')
	{
		mut iter_1 := this._actions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
				print('\t' + '<optgroup label="' + (rt.call_function('esc_attr', [var_key.dup()])).str() + '">' + '\n')
				{
					mut iter_2 := var_value.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_title := item_2.val
						mut var_name := item_2.key
						mut var_class := rt.new_string(if rt.is_true(rt.identical(rt.new_string('edit'), var_name)) { rt.new_string(' class="hide-if-no-js"') } else { rt.new_string('') })
						print('\t\t' + '<option value="' + (rt.call_function('esc_attr', [var_name.dup()])).str() + '"' + (var_class).str() + '>' + (var_title).str() + '</option>\n')
					}
				}
				print('\t' + '</optgroup>\n')
			} else {
				mut var_class := rt.new_string(if rt.is_true(rt.identical(rt.new_string('edit'), var_key)) { rt.new_string(' class="hide-if-no-js"') } else { rt.new_string('') })
				print('\t' + '<option value="' + (rt.call_function('esc_attr', [var_key.dup()])).str() + '"' + (var_class).str() + '>' + (var_value).str() + '</option>\n')
			}
		}
	}
	print('</select>\n')
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Apply')]), rt.new_string('action'), rt.new_string('bulk_action'), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'id', val: "doaction${var_two.to_string()}" }])])
	print('\n')
}

fn (mut this Class_WP_List_Table) current_action() bool {
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('filter_action')) && !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('filter_action'))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return (rt.get_superglobal('_REQUEST').array_get('action')).to_bool()
	}
	return false
}

fn (mut this Class_WP_List_Table) row_actions(var_actions rt.PhpVal, always_visible bool) string {
	mut always_visible_mutated := always_visible
	mut var_action_count := rt.new_int(rt.new_int(.dup().array_count()))
	if rt.is_true(rt.new_bool(!(rt.is_true()))) {
		return 
	}
	
}

fn (mut this Class_WP_List_Table) months_dropdown(var_post_type rt.PhpVal)  {
	mut var_wpdb := rt.new_null()
	mut var_wp_locale := rt.new_null()
}

fn (mut this Class_WP_List_Table) view_switcher(var_current_mode rt.PhpVal)  {
}

fn (mut this Class_WP_List_Table) comments_bubble(var_post_id rt.PhpVal, var_pending_comments rt.PhpVal) bool {
	return false
}

fn (mut this Class_WP_List_Table) get_pagenum() rt.PhpVal {
}

fn (mut this Class_WP_List_Table) get_items_per_page(var_option rt.PhpVal, default_value i64) rt.PhpVal {
}

fn (mut this Class_WP_List_Table) pagination(var_which rt.PhpVal)  {
}

fn (mut this Class_WP_List_Table) get_columns()  {
}

fn (mut this Class_WP_List_Table) get_sortable_columns() rt.PhpVal {
}

fn (mut this Class_WP_List_Table) get_default_primary_column_name() rt.PhpVal {
}

fn (mut this Class_WP_List_Table) get_primary_column() rt.PhpVal {
}

fn (mut this Class_WP_List_Table) get_primary_column_name() rt.PhpVal {
}

fn (mut this Class_WP_List_Table) get_column_info() rt.PhpVal {
}

fn (mut this Class_WP_List_Table) get_column_count() i64 {
	mut var_columns := rt.new_null()
}

fn (mut this Class_WP_List_Table) print_column_headers(with_id bool)  {
	mut var_columns := rt.new_null()
	mut var_hidden := rt.new_null()
	mut var_sortable := rt.new_null()
	mut var_primary := rt.new_null()
	mut var_cb_counter := rt.new_null()
}

fn (mut this Class_WP_List_Table) print_table_description()  {
	mut var_columns := rt.new_null()
	mut var_hidden := rt.new_null()
	mut var_sortable := rt.new_null()
}

fn (mut this Class_WP_List_Table) display()  {
}

fn (mut this Class_WP_List_Table) get_table_classes() rt.PhpVal {
}

fn (mut this Class_WP_List_Table) display_tablenav(var_which rt.PhpVal)  {
}

fn (mut this Class_WP_List_Table) extra_tablenav(var_which rt.PhpVal)  {
}

fn (mut this Class_WP_List_Table) display_rows_or_placeholder()  {
}

fn (mut this Class_WP_List_Table) display_rows()  {
}

fn (mut this Class_WP_List_Table) single_row(var_item rt.PhpVal)  {
}

fn (mut this Class_WP_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal)  {
}

fn (mut this Class_WP_List_Table) column_cb(var_item rt.PhpVal)  {
}

fn (mut this Class_WP_List_Table) single_row_columns(var_item rt.PhpVal)  {
	mut var_columns := rt.new_null()
	mut var_hidden := rt.new_null()
	mut var_sortable := rt.new_null()
	mut var_primary := rt.new_null()
}

fn (mut this Class_WP_List_Table) handle_row_actions(var_item rt.PhpVal, var_column_name rt.PhpVal, var_primary rt.PhpVal) string {
	mut var_primary_mutated := var_primary
}

fn (mut this Class_WP_List_Table) ajax_response()  {
}

fn (mut this Class_WP_List_Table) _js_vars()  {
}

fn create_wp_list_table(arg_0 rt.PhpVal) &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
		items: rt.new_null()
		_args: rt.new_null()
		_pagination_args: rt.new_array()
		screen: rt.new_null()
		_actions: rt.new_null()
		_pagination: ''
		modes: rt.new_array()
		_column_headers: rt.new_null()
		compat_fields: rt.new_array()
		compat_methods: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.magic_isset(dispatch_arg_0))
		}
		'__unset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.magic_unset(dispatch_arg_0)
			return rt.new_null()
		}
		'__call' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.magic_call(dispatch_arg_0, dispatch_arg_1))
		}
		'ajax_user_can' {
			this.ajax_user_can()
			return rt.new_null()
		}
		'prepare_items' {
			this.prepare_items()
			return rt.new_null()
		}
		'set_pagination_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_pagination_args(dispatch_arg_0)
			return rt.new_null()
		}
		'get_pagination_arg' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_pagination_arg(dispatch_arg_0)
		}
		'has_items' {
			return rt.new_bool(this.has_items())
		}
		'no_items' {
			this.no_items()
			return rt.new_null()
		}
		'search_box' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.search_box(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_views_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_views_links(dispatch_arg_0)
		}
		'get_views' {
			return this.get_views()
		}
		'views' {
			this.views()
			return rt.new_null()
		}
		'get_bulk_actions' {
			return this.get_bulk_actions()
		}
		'bulk_actions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.bulk_actions(dispatch_arg_0)
			return rt.new_null()
		}
		'current_action' {
			return rt.new_bool(this.current_action())
		}
		'row_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.row_actions(dispatch_arg_0, dispatch_arg_1))
		}
		'months_dropdown' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.months_dropdown(dispatch_arg_0)
			return rt.new_null()
		}
		'view_switcher' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.view_switcher(dispatch_arg_0)
			return rt.new_null()
		}
		'comments_bubble' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.comments_bubble(dispatch_arg_0, dispatch_arg_1))
		}
		'get_pagenum' {
			return this.get_pagenum()
		}
		'get_items_per_page' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return this.get_items_per_page(dispatch_arg_0, dispatch_arg_1)
		}
		'pagination' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.pagination(dispatch_arg_0)
			return rt.new_null()
		}
		'get_columns' {
			this.get_columns()
			return rt.new_null()
		}
		'get_sortable_columns' {
			return this.get_sortable_columns()
		}
		'get_default_primary_column_name' {
			return this.get_default_primary_column_name()
		}
		'get_primary_column' {
			return this.get_primary_column()
		}
		'get_primary_column_name' {
			return this.get_primary_column_name()
		}
		'get_column_info' {
			return this.get_column_info()
		}
		'get_column_count' {
			return rt.new_int(this.get_column_count())
		}
		'print_column_headers' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.print_column_headers(dispatch_arg_0)
			return rt.new_null()
		}
		'print_table_description' {
			this.print_table_description()
			return rt.new_null()
		}
		'display' {
			this.display()
			return rt.new_null()
		}
		'get_table_classes' {
			return this.get_table_classes()
		}
		'display_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.display_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'extra_tablenav' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.extra_tablenav(dispatch_arg_0)
			return rt.new_null()
		}
		'display_rows_or_placeholder' {
			this.display_rows_or_placeholder()
			return rt.new_null()
		}
		'display_rows' {
			this.display_rows()
			return rt.new_null()
		}
		'single_row' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.single_row(dispatch_arg_0)
			return rt.new_null()
		}
		'column_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.column_default(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'column_cb' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.column_cb(dispatch_arg_0)
			return rt.new_null()
		}
		'single_row_columns' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.single_row_columns(dispatch_arg_0)
			return rt.new_null()
		}
		'handle_row_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_string(this.handle_row_actions(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'ajax_response' {
			this.ajax_response()
			return rt.new_null()
		}
		'_js_vars' {
			this._js_vars()
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'items' { return this.items }
		'_args' { return this._args }
		'_pagination_args' { return this._pagination_args }
		'screen' { return this.screen }
		'_actions' { return this._actions }
		'_pagination' { return rt.new_string(this._pagination) }
		'modes' { return this.modes }
		'_column_headers' { return this._column_headers }
		'compat_fields' { return this.compat_fields }
		'compat_methods' { return this.compat_methods }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'items' { this.items = val; return true }
		'_args' { this._args = val; return true }
		'_pagination_args' { this._pagination_args = val; return true }
		'screen' { this.screen = val; return true }
		'_actions' { this._actions = val; return true }
		'_pagination' { this._pagination = (val).str(); return true }
		'modes' { this.modes = val; return true }
		'_column_headers' { this._column_headers = val; return true }
		'compat_fields' { this.compat_fields = val; return true }
		'compat_methods' { this.compat_methods = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_admin_includes_class_wp_list_table_php() {
}
