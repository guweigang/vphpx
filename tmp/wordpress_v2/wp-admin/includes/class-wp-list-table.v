import rt

struct Class_WP_List_Table {
	rt.PhpObjectBase
pub mut:
	items            rt.PhpVal = rt.new_null()
	_args            rt.PhpVal = rt.new_null()
	_pagination_args rt.PhpVal = rt.new_array()
	screen           rt.PhpVal = rt.new_null()
	_actions         rt.PhpVal = rt.new_null()
	_pagination      string
	modes            rt.PhpVal = rt.new_array()
	_column_headers  rt.PhpVal = rt.new_null()
	compat_fields    rt.PhpVal = rt.new_array()
	compat_methods   rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_List_Table) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'plural', val: '' },
			rt.ArrayItem{ key: 'singular', val: '' }, rt.ArrayItem{ key: 'ajax', val: false },
			rt.ArrayItem{ key: 'screen', val: rt.new_null() }])])
	this.screen = rt.call_function('convert_to_screen', [
		var_args_mutated.array_get(rt.new_string('screen')),
	])
	rt.call_function('add_filter', [
		rt.concat(rt.concat(rt.new_string('manage_'), rt.get_property(this.screen, 'id')),
			rt.new_string('_columns')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_List_Table', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'get_columns' },
		]),
		rt.new_int(0),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get(rt.new_string('plural')))))) {
		var_args_mutated.array_set('plural', rt.get_property(this.screen, 'base'))
	}
	var_args_mutated.array_set('plural', rt.call_function('sanitize_key', [
		var_args_mutated.array_get(rt.new_string('plural')),
	]))
	var_args_mutated.array_set('singular', rt.call_function('sanitize_key', [
		var_args_mutated.array_get(rt.new_string('singular')),
	]))
	this._args = var_args_mutated.clone()
	if rt.is_true(var_args_mutated.array_get(rt.new_string('ajax'))) {
		rt.call_function('add_action', [rt.new_string('admin_footer'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_List_Table', []string{}, &this) },
				rt.ArrayItem{ key: none, val: '_js_vars' },
			])])
	}
	if !rt.is_true(this.modes) {
		this.modes = rt.create_array([
			rt.ArrayItem{ key: 'list', val: rt.call_function('__', [
				rt.new_string('Compact view'),
			]) },
			rt.ArrayItem{ key: 'excerpt', val: rt.call_function('__', [
				rt.new_string('Extended view'),
			]) },
		])
	}
}

fn (mut this Class_WP_List_Table) magic_get(var_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('in_array',
		[var_name.clone(), this.compat_fields, rt.new_bool(true)]))
	{
		return rt.get_property(rt.new_object('WP_List_Table', []string{}, &this),
			'{"nodeType":"Expr_Variable","line":186,"name":"name"}')
	}
	rt.call_function('wp_trigger_error', [rt.new_string(@METHOD),
		rt.new_string(
			'The property `${var_name.to_string()}` is not declared. Getting a dynamic property is ' +
			'deprecated since version 6.4.0! Instead, declare the property on the class.'),
		rt.get_constant('E_USER_DEPRECATED')])
	return rt.new_null()
}

fn (mut this Class_WP_List_Table) magic_set(var_name rt.PhpVal, var_value rt.PhpVal) {
	if rt.is_true(rt.call_function('in_array',
		[var_name.clone(), this.compat_fields, rt.new_bool(true)]))
	{
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":209,"name":"name"}',
			var_value.clone())
		return
	}
	rt.call_function('wp_trigger_error', [rt.new_string(@METHOD),
		rt.new_string(
			'The property `${var_name.to_string()}` is not declared. Setting a dynamic property is ' +
			'deprecated since version 6.4.0! Instead, declare the property on the class.'),
		rt.get_constant('E_USER_DEPRECATED')])
}

fn (mut this Class_WP_List_Table) magic_isset(var_name rt.PhpVal) bool {
	if rt.is_true(rt.call_function('in_array',
		[var_name.clone(), this.compat_fields, rt.new_bool(true)]))
	{
		return (rt.new_bool(!(rt.get_property(rt.new_object('WP_List_Table', []string{}, &this),
			'{"nodeType":"Expr_Variable","line":232,"name":"name"}')).is_null())).to_bool()
	}
	rt.call_function('wp_trigger_error', [rt.new_string(@METHOD),
		rt.new_string(
			'The property `${var_name.to_string()}` is not declared. Checking `isset()` on a dynamic property ' +
			'is deprecated since version 6.4.0! Instead, declare the property on the class.'),
		rt.get_constant('E_USER_DEPRECATED')])
	return false
}

fn (mut this Class_WP_List_Table) magic_unset(var_name rt.PhpVal) {
	if rt.is_true(rt.call_function('in_array',
		[var_name.clone(), this.compat_fields, rt.new_bool(true)]))
	{
		rt.get_property(rt.new_object('WP_List_Table', []string{}, &this),
			'{"nodeType":"Expr_Variable","line":254,"name":"name"}') = rt.new_null()
		return
	}
	rt.call_function('wp_trigger_error', [rt.new_string(@METHOD),
		rt.new_string(
			'A property `${var_name.to_string()}` is not declared. Unsetting a dynamic property is ' +
			'deprecated since version 6.4.0! Instead, declare the property on the class.'),
		rt.get_constant('E_USER_DEPRECATED')])
}

fn (mut this Class_WP_List_Table) magic_call(var_name rt.PhpVal, var_arguments rt.PhpVal) bool {
	if rt.is_true(rt.call_function('in_array', [var_name.clone(), this.compat_methods,
		rt.new_bool(true)]))
	{
		return (rt.call_method(rt.new_object('WP_List_Table', []string{}, &this), var_name, [
			var_arguments.clone(),
		])).to_bool()
	}
	return false
}

fn (mut this Class_WP_List_Table) ajax_user_can() {
	fn () {
		print((rt.new_string('function WP_List_Table::ajax_user_can() must be overridden in a subclass.')).str())
		exit(0)
	}()
}

fn (mut this Class_WP_List_Table) prepare_items() {
	fn () {
		print((rt.new_string('function WP_List_Table::prepare_items() must be overridden in a subclass.')).str())
		exit(0)
	}()
}

fn (mut this Class_WP_List_Table) set_pagination_args(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'total_items', val: 0 },
			rt.ArrayItem{ key: 'total_pages', val: 0 }, rt.ArrayItem{ key: 'per_page', val: 0 }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get(rt.new_string('total_pages'))))))
		&& rt.is_true(rt.greater(var_args_mutated.array_get(rt.new_string('per_page')), rt.new_int(0))) {
		var_args_mutated.array_set('total_pages', rt.new_int((rt.call_function('ceil', [
			rt.div(var_args_mutated.array_get(rt.new_string('total_items')),
				var_args_mutated.array_get(rt.new_string('per_page'))),
		])).to_i64()))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{})))))
		&& rt.is_true(rt.greater(var_args_mutated.array_get(rt.new_string('total_pages')), rt.new_int(0)))
		&& rt.is_true(rt.greater(this.get_pagenum(), var_args_mutated.array_get(rt.new_string('total_pages')))) {
		rt.call_function('wp_redirect', [
			rt.call_function('add_query_arg', [rt.new_string('paged'),
				var_args_mutated.array_get(rt.new_string('total_pages'))]),
		])
		exit(0)
	}
	this._pagination_args = var_args_mutated.clone()
}

fn (mut this Class_WP_List_Table) get_pagination_arg(var_key rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('page'), var_key)) {
		return this.get_pagenum()
	}
	return if !(this._pagination_args.array_get(var_key)).is_null() {
		this._pagination_args.array_get(var_key)
	} else {
		rt.new_int(0)
	}
}

fn (mut this Class_WP_List_Table) has_items() bool {
	return !(!rt.is_true(this.items))
}

fn (mut this Class_WP_List_Table) no_items() {
	rt.call_function('_e', [rt.new_string('No items found.')])
}

fn (mut this Class_WP_List_Table) search_box(var_text rt.PhpVal, var_input_id rt.PhpVal) {
	mut var_input_id_mutated := var_input_id
	if !rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('s')))
		&& !(this.has_items()) {
		return
	}
	var_input_id_mutated = rt.new_string(var_input_id_mutated.str() + '-search-input')
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')))) {
		if rt.is_true(rt.new_bool(rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')).is_array())) {
			mut iter_1 :=
				rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby')).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				print('<input type="hidden" name="orderby[' +
					(rt.call_function('esc_attr', [var_key.clone()])).str() + ']" value="' +
					(rt.call_function('esc_attr', [var_value.clone()])).str() + '" />')
			}
		} else {
			print('<input type="hidden" name="orderby" value="' +
				(rt.call_function('esc_attr', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('orderby'))])).str() +
				'" />')
		}
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('order')))) {
		print('<input type="hidden" name="order" value="' +
			(rt.call_function('esc_attr', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('order'))])).str() +
			'" />')
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_mime_type')))) {
		print('<input type="hidden" name="post_mime_type" value="' +
			(rt.call_function('esc_attr', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('post_mime_type'))])).str() +
			'" />')
	}
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('detached')))) {
		print('<input type="hidden" name="detached" value="' +
			(rt.call_function('esc_attr', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('detached'))])).str() +
			'" />')
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_input_id_mutated.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(var_text)
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_input_id_mutated.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_admin_search_query', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [var_text.clone(), rt.new_string(''),
		rt.new_string(''), rt.new_bool(false),
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: 'search-submit' },
		])])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_List_Table) get_views_links(var_link_data rt.PhpVal) rt.PhpVal {
	if !(var_link_data.clone().is_array()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The %s argument must be an array.'),
				]),
				rt.new_string('<code>$link_data</code>'),
			]),
			rt.new_string('6.1.0')])
		return rt.create_array([rt.ArrayItem{ key: none, val: '' }])
	}
	mut var_views_links := rt.new_array()
	mut iter_2 := var_link_data.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_link := item_2.val
		mut var_view := item_2.key
		if !rt.is_true(var_link.array_get(rt.new_string('url')))
			|| !(var_link.array_get(rt.new_string('url')).is_string())
			|| rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_link.array_get(rt.new_string('url')).to_string().trim_space()))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The %1$s argument must be a non-empty string for %2$s.'),
					]),
					rt.new_string('<code>url</code>'),
					rt.new_string('<code>' +
						(rt.call_function('esc_html', [var_view.clone()])).str() + '</code>'),
				]),
				rt.new_string('6.1.0')])
			continue
		}
		if !rt.is_true(var_link.array_get(rt.new_string('label')))
			|| !(var_link.array_get(rt.new_string('label')).is_string())
			|| rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_link.array_get(rt.new_string('label')).to_string().trim_space()))) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The %1$s argument must be a non-empty string for %2$s.'),
					]),
					rt.new_string('<code>label</code>'),
					rt.new_string('<code>' +
						(rt.call_function('esc_html', [var_view.clone()])).str() + '</code>'),
				]),
				rt.new_string('6.1.0')])
			continue
		}
		var_views_links.array_set(var_view, rt.call_function('sprintf', [
			rt.new_string('<a href="%s"%s>%s</a>'),
			rt.call_function('esc_url', [var_link.array_get(rt.new_string('url'))]),
			rt.new_string((if var_link.array_isset(rt.new_string('current'))
				&& rt.is_true(rt.identical(rt.new_bool(true), var_link.array_get(rt.new_string('current')))) {
				' class="current" aria-current="page"'
			} else {
				''
			}).str()),
			var_link.array_get(rt.new_string('label')),
		]))
	}
	return var_views_links.clone()
}

fn (mut this Class_WP_List_Table) get_views() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WP_List_Table) views() {
	mut var_views := this.get_views()
	var_views = rt.call_function('apply_filters', [
		rt.concat(rt.new_string('views_'), rt.get_property(this.screen, 'id')),
		var_views.clone(),
	])
	if !rt.is_true(var_views) {
		return
	}
	rt.call_method(this.screen, 'render_screen_reader_content', [
		rt.new_string('heading_views'),
	])
	print("<ul class='subsubsub'>\n")
	mut iter_3 := var_views.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_view := item_3.val
		mut var_class := item_3.key
		var_views.array_set(var_class,
			"\t<li class='${var_class.to_string()}'>${var_view.to_string()}")
	}
	print((rt.call_function('implode', [rt.new_string(' |</li>\n'), var_views.clone()])).str() +
		'</li>\n')
	print('</ul>')
}

fn (mut this Class_WP_List_Table) get_bulk_actions() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WP_List_Table) bulk_actions(which string) {
	if rt.is_true(rt.new_bool(this._actions.is_null())) {
		this._actions = this.get_bulk_actions()
		this._actions = rt.call_function('apply_filters', [
			rt.concat(rt.new_string('bulk_actions-'), rt.get_property(this.screen, 'id')),
			this._actions,
		])
		mut var_two := rt.new_string('')
	} else {
		var_two = rt.new_string('2')
	}
	if !rt.is_true(this._actions) {
		return
	}
	print('<label for="bulk-action-selector-' +
		(rt.call_function('esc_attr', [rt.new_string(which)])).str() +
		'" class="screen-reader-text">' +
		(rt.call_function('__', [rt.new_string('Select bulk action')])).str() + '</label>')
	print('<select name="action' + var_two.str() + '" id="bulk-action-selector-' +
		(rt.call_function('esc_attr', [rt.new_string(which)])).str() + '">\n')
	print('<option value="-1">' + (rt.call_function('__', [rt.new_string('Bulk actions')])).str() +
		'</option>\n')
	mut iter_4 := this._actions.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value := item_4.val
		mut var_key := item_4.key
		if rt.is_true(rt.new_bool(var_value.clone().is_array())) {
			print('\t' + '<optgroup label="' +
				(rt.call_function('esc_attr', [var_key.clone()])).str() + '">' + '\n')
			mut iter_5 := var_value.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_title := item_5.val
				mut var_name := item_5.key
				mut var_class := rt.new_string((if rt.is_true(rt.identical(rt.new_string('edit'),
					var_name))
				{
					' class="hide-if-no-js"'
				} else {
					''
				}).str())
				print('\t\t' + '<option value="' +
					(rt.call_function('esc_attr', [var_name.clone()])).str() + '"' +
					var_class.str() + '>' + var_title.str() + '</option>\n')
			}
			print('\t' + '</optgroup>\n')
		} else {
			mut var_class := rt.new_string((if rt.is_true(rt.identical(rt.new_string('edit'),
				var_key))
			{
				' class="hide-if-no-js"'
			} else {
				''
			}).str())
			print('\t' + '<option value="' +
				(rt.call_function('esc_attr', [var_key.clone()])).str() + '"' + var_class.str() +
				'>' + var_value.str() + '</option>\n')
		}
	}
	print('</select>\n')
	rt.call_function('submit_button', [rt.call_function('__', [
		rt.new_string('Apply')]),
		rt.new_string('action'), rt.new_string('bulk_action'),
		rt.new_bool(false),
		rt.create_array([rt.ArrayItem{
			key: 'id'
			val: 'doaction${var_two.to_string()}'
		}])])
	print('\n')
}

fn (mut this Class_WP_List_Table) current_action() bool {
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('filter_action'))
		&& !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('filter_action')))) {
		return false
	}
	if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('-1'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))))) {
		return (rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))).to_bool()
	}
	return false
}

fn (mut this Class_WP_List_Table) row_actions(var_actions rt.PhpVal, always_visible bool) string {
	mut always_visible_mutated := always_visible
	mut var_action_count := rt.new_int(var_actions.clone().array_count())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_action_count)))) {
		return ''
	}
	mut var_mode := rt.call_function('get_user_setting', [
		rt.new_string('posts_list_mode'),
		rt.new_string('list'),
	])
	if rt.is_true(rt.identical(rt.new_string('excerpt'), var_mode)) {
		always_visible_mutated = true
	}
	mut var_output := rt.new_string('<div class="' +
		if rt.is_true(rt.new_bool(always_visible_mutated)) { 'row-actions visible' } else { 'row-actions' } +
		'">')
	mut var_i := rt.new_int(0)
	mut iter_6 := var_actions.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_link := item_6.val
		mut var_action := item_6.key
		rt.pre_inc(var_i)
		mut var_separator := rt.new_string((if rt.is_true(rt.less(var_i, var_action_count)) {
			' | '
		} else {
			''
		}).str())
		var_output = rt.concat(var_output,
			rt.new_string("<span class='${var_action.to_string()}'>${var_link.to_string()}${var_separator.to_string()}</span>"))
	}
	var_output = rt.concat(var_output, rt.new_string('</div>'))
	var_output = rt.concat(var_output, rt.new_string(
		'<button type="button" class="toggle-row"><span class="screen-reader-text">' +
		(rt.call_function('__', [rt.new_string('Show more details')])).str() + '</span></button>'))
	return var_output.str()
}

fn (mut this Class_WP_List_Table) months_dropdown(var_post_type rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_wp_locale := rt.new_null()
	if rt.is_true(rt.call_function('apply_filters', [
		rt.new_string('disable_months_dropdown'),
		rt.new_bool(false),
		var_post_type.clone(),
	]))
	{
		return
	}
	mut var_months := rt.call_function('apply_filters', [
		rt.new_string('pre_months_dropdown_query'),
		rt.new_bool(false),
		var_post_type.clone(),
	])
	if !(var_months.clone().is_array()) {
		mut var_extra_checks := rt.new_string("AND post_status != 'auto-draft'")
		if !(rt.get_superglobal('_GET').array_isset(rt.new_string('post_status')))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('trash'), rt.get_superglobal('_GET').array_get(rt.new_string('post_status')))))) {
			var_extra_checks = rt.concat(var_extra_checks,
				rt.new_string(" AND post_status != 'trash'"))
		} else if rt.get_superglobal('_GET').array_isset(rt.new_string('post_status')) {
			var_extra_checks = rt.call_method(var_wpdb, 'prepare', [
				rt.new_string(' AND post_status = %s'),
				rt.get_superglobal('_GET').array_get(rt.new_string('post_status')),
			])
		}
		var_months = rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT DISTINCT YEAR( post_date ) AS year, MONTH( post_date ) AS month\n\t\t\t\t\tFROM '), rt.get_property(var_wpdb,
					'posts')), rt.new_string('\n\t\t\t\t\tWHERE post_type = %s\n\t\t\t\t\t')),
					var_extra_checks), rt.new_string('\n\t\t\t\t\tORDER BY post_date DESC')),
				var_post_type.clone(),
			]),
		])
	}
	var_months = rt.call_function('apply_filters', [
		rt.new_string('months_dropdown_results'),
		var_months.clone(),
		var_post_type.clone(),
	])
	mut var_month_count := rt.new_int(var_months.clone().array_count())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_month_count))))
		|| (rt.is_true(rt.identical(rt.new_int(1), var_month_count))
		&& 0 == rt.new_int((rt.get_property(var_months.array_get(rt.new_int(0)), 'month')).to_i64())) {
		return
	}
	mut var_selected_month := rt.new_int(if rt.get_superglobal('_GET').array_isset(rt.new_string('m')) {
		rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('m'))).to_i64())
	} else {
		0
	})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [
		var_post_type.clone(),
	]), 'labels'), 'filter_by_date'))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_selected_month.clone(),
		rt.new_int(0)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('All dates')])
	// unsupported statement: Stmt_InlineHTML
	mut iter_7 := var_months.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_arc_row := item_7.val
		if 0 == rt.new_int((rt.get_property(var_arc_row, 'year')).to_i64()) {
			continue
		}
		mut var_month := rt.call_function('zeroise', [
			rt.get_property(var_arc_row, 'month'),
			rt.new_int(2),
		])
		mut var_year := rt.get_property(var_arc_row, 'year')
		rt.call_function('printf', [
			rt.new_string("<option %s value='%s'>%s</option>\n"),
			rt.call_function('selected', [var_selected_month.clone(),
				rt.new_string(var_year.str() + var_month.str()),
				rt.new_bool(false)]),
			rt.call_function('esc_attr', [rt.new_string(var_year.str() + var_month.str())]),
			rt.call_function('esc_html', [
				rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s %2$d')]),
					rt.call_method(var_wp_locale, 'get_month', [
						var_month.clone()]),
					var_year.clone(),
				]),
			]),
		])
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_List_Table) view_switcher(var_current_mode rt.PhpVal) {
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_current_mode.clone()]))
	// unsupported statement: Stmt_InlineHTML
	mut iter_8 := this.modes.iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_title := item_8.val
		mut var_mode := item_8.key
		mut var_classes := rt.create_array([
			rt.ArrayItem{ key: none, val: 'view-' + var_mode.str() },
		])
		mut var_aria_current := rt.new_string('')
		if rt.is_true(rt.identical(var_current_mode, var_mode)) {
			var_classes.array_push('current')
			var_aria_current = rt.new_string(' aria-current="page"')
		}
		rt.call_function('printf', [
			rt.new_string(
				"<a href='%s' class='%s' id='view-switch-${var_mode.to_string()}'${var_aria_current.to_string()}>" +
				"<span class='screen-reader-text'>%s</span>" + '</a>\n'),
			rt.call_function('esc_url', [
				rt.call_function('remove_query_arg', [rt.new_string('attachment-filter'),
					rt.call_function('add_query_arg', [rt.new_string('mode'),
						var_mode.clone()])]),
			]),
			rt.call_function('implode', [
				rt.new_string(' '),
				var_classes.clone(),
			]),
			var_title.clone(),
		])
	}
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_List_Table) comments_bubble(var_post_id rt.PhpVal, var_pending_comments rt.PhpVal) bool {
	mut var_post_object := rt.call_function('get_post', [var_post_id.clone()])
	mut var_edit_post_cap := rt.new_string((if rt.is_true(var_post_object) {
		'edit_post'
	} else {
		'edit_posts'
	}).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [var_edit_post_cap.clone(), var_post_id.clone()])))))
		&& rt.is_true(rt.call_function('post_password_required', [var_post_id.clone()]))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), var_post_id.clone()]))))) {
		return false
	}
	mut var_approved_comments := rt.call_function('get_comments_number', []rt.PhpVal{})
	mut var_approved_comments_number := rt.call_function('number_format_i18n', [
		var_approved_comments.clone(),
	])
	mut var_pending_comments_number := rt.call_function('number_format_i18n', [
		var_pending_comments.clone(),
	])
	mut var_approved_only_phrase := rt.call_function('sprintf', [
		rt.call_function('_n', [rt.new_string('%s comment'), rt.new_string('%s comments'),
			var_approved_comments.clone()]),
		var_approved_comments_number.clone(),
	])
	mut var_approved_phrase := rt.call_function('sprintf', [
		rt.call_function('_n', [rt.new_string('%s approved comment'),
			rt.new_string('%s approved comments'), var_approved_comments.clone()]),
		var_approved_comments_number.clone(),
	])
	mut var_pending_phrase := rt.call_function('sprintf', [
		rt.call_function('_n', [rt.new_string('%s pending comment'),
			rt.new_string('%s pending comments'), var_pending_comments.clone()]),
		var_pending_comments_number.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_approved_comments))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_pending_comments)))) {
		rt.call_function('printf', [
			rt.new_string('<span aria-hidden="true">&#8212;</span>' +
				'<span class="screen-reader-text">%s</span>'),
			rt.call_function('__', [rt.new_string('No comments')]),
		])
	} else if rt.is_true(var_approved_comments)
		&& rt.is_true(rt.identical(rt.new_string('trash'), rt.call_function('get_post_status', [var_post_id.clone()]))) {
		rt.call_function('printf', [
			rt.new_string('<span class="post-com-count post-com-count-approved">' +
				'<span class="comment-count-approved" aria-hidden="true">%s</span>' +
				'<span class="screen-reader-text">%s</span>' + '</span>'),
			var_approved_comments_number.clone(),
			if rt.is_true(var_pending_comments) {
				var_approved_phrase
			} else {
				var_approved_only_phrase
			},
		])
	} else if rt.is_true(var_approved_comments) {
		rt.call_function('printf', [
			rt.new_string('<a href="%s" class="post-com-count post-com-count-approved">' +
				'<span class="comment-count-approved" aria-hidden="true">%s</span>' +
				'<span class="screen-reader-text">%s</span>' + '</a>'),
			rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [
					rt.create_array([rt.ArrayItem{ key: 'p', val: var_post_id },
						rt.ArrayItem{ key: 'comment_status', val: 'approved' }]),
					rt.call_function('admin_url', [rt.new_string('edit-comments.php')]),
				]),
			]),
			var_approved_comments_number.clone(),
			if rt.is_true(var_pending_comments) {
				var_approved_phrase
			} else {
				var_approved_only_phrase
			},
		])
	} else {
		rt.call_function('printf', [
			rt.new_string('<span class="post-com-count post-com-count-no-comments">' +
				'<span class="comment-count comment-count-no-comments" aria-hidden="true">%s</span>' +
				'<span class="screen-reader-text">%s</span>' + '</span>'),
			var_approved_comments_number.clone(),
			if rt.is_true(var_pending_comments) { rt.call_function('__', [
					rt.new_string('No approved comments'),
				]) } else { rt.call_function('__', [
					rt.new_string('No comments'),
				]) },
		])
	}
	if rt.is_true(var_pending_comments) {
		rt.call_function('printf', [
			rt.new_string('<a href="%s" class="post-com-count post-com-count-pending">' +
				'<span class="comment-count-pending" aria-hidden="true">%s</span>' +
				'<span class="screen-reader-text">%s</span>' + '</a>'),
			rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [
					rt.create_array([rt.ArrayItem{ key: 'p', val: var_post_id },
						rt.ArrayItem{ key: 'comment_status', val: 'moderated' }]),
					rt.call_function('admin_url', [rt.new_string('edit-comments.php')]),
				]),
			]),
			var_pending_comments_number.clone(),
			var_pending_phrase.clone(),
		])
	} else {
		rt.call_function('printf', [
			rt.new_string(
				'<span class="post-com-count post-com-count-pending post-com-count-no-pending">' +
				'<span class="comment-count comment-count-no-pending" aria-hidden="true">%s</span>' +
				'<span class="screen-reader-text">%s</span>' + '</span>'),
			var_pending_comments_number.clone(),
			if rt.is_true(var_approved_comments) { rt.call_function('__', [
					rt.new_string('No pending comments'),
				]) } else { rt.call_function('__', [
					rt.new_string('No comments'),
				]) },
		])
	}
	return false
}

fn (mut this Class_WP_List_Table) get_pagenum() rt.PhpVal {
	mut var_pagenum := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('paged')) { rt.call_function('absint', [
			rt.get_superglobal('_REQUEST').array_get(rt.new_string('paged')),
		]) } else { rt.new_int(0) }
	if this._pagination_args.array_isset(rt.new_string('total_pages'))
		&& rt.is_true(rt.greater(var_pagenum, this._pagination_args.array_get(rt.new_string('total_pages')))) {
		var_pagenum = this._pagination_args.array_get(rt.new_string('total_pages'))
	}
	return rt.call_function('max', [rt.new_int(1), var_pagenum.clone()])
}

fn (mut this Class_WP_List_Table) get_items_per_page(var_option rt.PhpVal, default_value i64) i64 {
	mut var_per_page := rt.new_int((rt.call_function('get_user_option', [
		var_option.clone()])).to_i64())
	if !rt.is_true(var_per_page) || rt.is_true(rt.less(var_per_page, rt.new_int(1))) {
		var_per_page = rt.new_int(default_value)
	}
	return rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('${var_option.to_string()}'),
		var_per_page.clone(),
	])).to_i64())
}

fn (mut this Class_WP_List_Table) pagination(var_which rt.PhpVal) {
	if !rt.is_true(this._pagination_args.array_get(rt.new_string('total_items'))) {
		return
	}
	mut var_total_items := this._pagination_args.array_get(rt.new_string('total_items'))
	mut var_total_pages := this._pagination_args.array_get(rt.new_string('total_pages'))
	mut var_infinite_scroll := rt.new_bool(false)
	if this._pagination_args.array_isset(rt.new_string('infinite_scroll')) {
		var_infinite_scroll = this._pagination_args.array_get(rt.new_string('infinite_scroll'))
	}
	if rt.is_true(rt.identical(rt.new_string('top'), var_which))
		&& rt.is_true(rt.greater(var_total_pages, rt.new_int(1))) {
		rt.call_method(this.screen, 'render_screen_reader_content', [
			rt.new_string('heading_pagination'),
		])
	}
	mut var_output := rt.new_string('<span class="displaying-num">' +
		(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s item'), rt.new_string('%s items'), var_total_items.clone()]), rt.call_function('number_format_i18n', [var_total_items.clone()])])).str() +
		'</span>')
	mut var_current := this.get_pagenum()
	mut var_removable_query_args := rt.call_function('wp_removable_query_args', []rt.PhpVal{})
	mut var_current_url := rt.call_function('set_url_scheme', [
		rt.new_string('http://' +
			(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))).str() +
			(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).str()),
	])
	var_current_url = rt.call_function('remove_query_arg', [var_removable_query_args.clone(),
		var_current_url.clone()])
	mut var_page_links := rt.new_array()
	mut var_total_pages_before := rt.new_string('<span class="paging-input">')
	mut var_total_pages_after := rt.new_string('</span></span>')
	mut var_disable_first := rt.new_bool(false)
	mut var_disable_last := rt.new_bool(false)
	mut var_disable_prev := rt.new_bool(false)
	mut var_disable_next := rt.new_bool(false)
	if rt.is_true(rt.identical(rt.new_int(1), var_current)) {
		var_disable_first = rt.new_bool(true)
		var_disable_prev = rt.new_bool(true)
	}
	if rt.is_true(rt.identical(var_total_pages, var_current)) {
		var_disable_last = rt.new_bool(true)
		var_disable_next = rt.new_bool(true)
	}
	if rt.is_true(var_disable_first) {
		var_page_links << rt.new_string('<span class="tablenav-pages-navspan button disabled" aria-hidden="true">&laquo;</span>')
	} else {
		var_page_links << rt.call_function('sprintf', [
			rt.new_string("<a class='first-page button' href='%s'>" +
				"<span class='screen-reader-text'>%s</span>" +
				"<span aria-hidden='true'>%s</span>" + '</a>'),
			rt.call_function('esc_url', [
				rt.call_function('remove_query_arg', [rt.new_string('paged'),
					var_current_url.clone()]),
			]),
			rt.call_function('__', [
				rt.new_string('First page'),
			]),
			rt.new_string('&laquo;'),
		])
	}
	if rt.is_true(var_disable_prev) {
		var_page_links << rt.new_string('<span class="tablenav-pages-navspan button disabled" aria-hidden="true">&lsaquo;</span>')
	} else {
		var_page_links << rt.call_function('sprintf', [
			rt.new_string("<a class='prev-page button' href='%s'>" +
				"<span class='screen-reader-text'>%s</span>" +
				"<span aria-hidden='true'>%s</span>" + '</a>'),
			rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [rt.new_string('paged'),
					rt.call_function('max', [rt.new_int(1), rt.sub(var_current, rt.new_int(1))]),
					var_current_url.clone()]),
			]),
			rt.call_function('__', [
				rt.new_string('Previous page'),
			]),
			rt.new_string('&lsaquo;'),
		])
	}
	if rt.is_true(rt.identical(rt.new_string('bottom'), var_which)) {
		mut var_html_current_page := var_current.clone()
		var_total_pages_before = rt.call_function('sprintf', [
			rt.new_string('<span class="screen-reader-text">%s</span>' +
				'<span id="table-paging" class="paging-input">' +
				'<span class="tablenav-paging-text">'),
			rt.call_function('__', [rt.new_string('Current Page')]),
		])
	} else {
		var_html_current_page = rt.call_function('sprintf', [
			rt.new_string(
				'<label for="current-page-selector" class="screen-reader-text">%s</label>' +
				"<input class='current-page' id='current-page-selector' type='text'\n\t\t\t\t\tname='paged' value='%s' size='%d' aria-describedby='table-paging' />" +
				"<span class='tablenav-paging-text'>"),
			rt.call_function('__', [rt.new_string('Current Page')]),
			var_current.clone(),
			rt.new_int(var_total_pages.clone().to_string().len),
		])
	}
	mut var_html_total_pages := rt.call_function('sprintf', [
		rt.new_string("<span class='total-pages'>%s</span>"),
		rt.call_function('number_format_i18n', [var_total_pages.clone()]),
	])
	var_page_links << var_total_pages_before.str() +
		(rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('%1$s of %2$s'), rt.new_string('paging')]), var_html_current_page.clone(), var_html_total_pages.clone()])).str() +
		var_total_pages_after.str()
	if rt.is_true(var_disable_next) {
		var_page_links << rt.new_string('<span class="tablenav-pages-navspan button disabled" aria-hidden="true">&rsaquo;</span>')
	} else {
		var_page_links << rt.call_function('sprintf', [
			rt.new_string("<a class='next-page button' href='%s'>" +
				"<span class='screen-reader-text'>%s</span>" +
				"<span aria-hidden='true'>%s</span>" + '</a>'),
			rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [rt.new_string('paged'),
					rt.call_function('min', [var_total_pages.clone(),
						rt.add(var_current, rt.new_int(1))]),
					var_current_url.clone()]),
			]),
			rt.call_function('__', [
				rt.new_string('Next page'),
			]),
			rt.new_string('&rsaquo;'),
		])
	}
	if rt.is_true(var_disable_last) {
		var_page_links << rt.new_string('<span class="tablenav-pages-navspan button disabled" aria-hidden="true">&raquo;</span>')
	} else {
		var_page_links << rt.call_function('sprintf', [
			rt.new_string("<a class='last-page button' href='%s'>" +
				"<span class='screen-reader-text'>%s</span>" +
				"<span aria-hidden='true'>%s</span>" + '</a>'),
			rt.call_function('esc_url', [
				rt.call_function('add_query_arg', [rt.new_string('paged'),
					var_total_pages.clone(), var_current_url.clone()]),
			]),
			rt.call_function('__', [
				rt.new_string('Last page'),
			]),
			rt.new_string('&raquo;'),
		])
	}
	mut var_pagination_links_class := rt.new_string('pagination-links')
	if !(!rt.is_true(var_infinite_scroll)) {
		var_pagination_links_class = rt.concat(var_pagination_links_class,
			rt.new_string(' hide-if-js'))
	}
	var_output = rt.concat(var_output, rt.new_string(
		"\n<span class='${var_pagination_links_class.to_string()}'>" +
		(rt.call_function('implode', [rt.new_string('\n'), rt.create_array_from_list(var_page_links)])).str() +
		'</span>'))
	if rt.is_true(var_total_pages) {
		mut var_page_class := rt.new_string((if rt.is_true(rt.less(var_total_pages, rt.new_int(2))) {
			' one-page'
		} else {
			''
		}).str())
	} else {
		var_page_class = rt.new_string(' no-pages')
	}
	this._pagination = "<div class='tablenav-pages${var_page_class.to_string()}'>${var_output.to_string()}</div>"
	print(this._pagination)
}

fn (mut this Class_WP_List_Table) get_columns() {
	fn () {
		print((rt.new_string('function WP_List_Table::get_columns() must be overridden in a subclass.')).str())
		exit(0)
	}()
}

fn (mut this Class_WP_List_Table) get_sortable_columns() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WP_List_Table) get_default_primary_column_name() rt.PhpVal {
	mut var_columns := this.get_columns()
	mut var_column := rt.new_string('')
	if !rt.is_true(var_columns) {
		return var_column.clone()
	}
	mut iter_9 := var_columns.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_column_name := item_9.val
		mut var_col := item_9.key
		if rt.is_true(rt.identical(rt.new_string('cb'), var_col)) {
			continue
		}
		var_column = var_col
		break
	}
	return var_column.clone()
}

fn (mut this Class_WP_List_Table) get_primary_column() rt.PhpVal {
	return this.get_primary_column_name()
}

fn (mut this Class_WP_List_Table) get_primary_column_name() rt.PhpVal {
	mut var_columns := rt.call_function('get_column_headers', [this.screen])
	mut var_default := this.get_default_primary_column_name()
	if !(var_columns.array_isset(var_default)) {
		mut iife_temp_0 := Class_WP_List_Table{}
		mut iife_result_0 := iife_temp_0.get_default_primary_column_name()
		var_default = iife_result_0
	}
	mut var_column := rt.call_function('apply_filters', [
		rt.new_string('list_table_primary_column'),
		var_default.clone(),
		rt.get_property(this.screen, 'id'),
	])
	if !rt.is_true(var_column) || !(var_columns.array_isset(var_column)) {
		var_column = var_default.clone()
	}
	return var_column.clone()
}

fn (mut this Class_WP_List_Table) get_column_info() rt.PhpVal {
	if !(this._column_headers).is_null() && this._column_headers.is_array() {
		if 4 == this._column_headers.array_count() {
			return this._column_headers
		}
		mut var_column_headers := rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_array() },
			rt.ArrayItem{ key: none, val: rt.new_array() },
			rt.ArrayItem{ key: none, val: rt.new_array() },
			rt.ArrayItem{ key: none, val: this.get_primary_column_name() },
		])
		mut iter_10 := this._column_headers.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_value := item_10.val
			mut var_key := item_10.key
			var_column_headers.array_set(var_key, var_value.clone())
		}
		this._column_headers = var_column_headers.clone()
		return this._column_headers
	}
	mut var_columns := rt.call_function('get_column_headers', [this.screen])
	mut var_hidden := rt.call_function('get_hidden_columns', [this.screen])
	mut var_sortable_columns := this.get_sortable_columns()
	mut var__sortable := rt.call_function('apply_filters', [
		rt.concat(rt.concat(rt.new_string('manage_'), rt.get_property(this.screen, 'id')),
			rt.new_string('_sortable_columns')),
		var_sortable_columns.clone(),
	])
	mut var_sortable := rt.new_array()
	mut iter_11 := var__sortable.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_data := item_11.val
		mut var_id := item_11.key
		if !rt.is_true(var_data) {
			continue
		}
		var_data = rt.cast_array(var_data)
		if !(var_data.array_isset(rt.new_int(1))) {
			var_data.array_set(1, false)
		}
		if !(var_data.array_isset(rt.new_int(2))) {
			var_data.array_set(2, '')
		}
		if !(var_data.array_isset(rt.new_int(3))) {
			var_data.array_set(3, false)
		}
		if !(var_data.array_isset(rt.new_int(4))) {
			var_data.array_set(4, false)
		}
		var_sortable.array_set(var_id, var_data.clone())
	}
	mut var_primary := this.get_primary_column_name()
	this._column_headers = rt.create_array([rt.ArrayItem{ key: none, val: var_columns },
		rt.ArrayItem{ key: none, val: var_hidden }, rt.ArrayItem{ key: none, val: var_sortable },
		rt.ArrayItem{ key: none, val: var_primary }])
	return this._column_headers
}

fn (mut this Class_WP_List_Table) get_column_count() i64 {
	mut var_columns := rt.new_null()
	mut list_tmp_1 := this.get_column_info()
	var_columns = list_tmp_1.array_get(0)
	mut var_hidden := list_tmp_1.array_get(1)
	var_hidden = rt.call_function('array_intersect', [
		rt.func_array_keys(var_columns.clone()),
		rt.call_function('array_filter', [var_hidden.clone()]),
	])
	return var_columns.clone().array_count() - var_hidden.clone().array_count()
}

fn (mut this Class_WP_List_Table) print_column_headers(with_id bool) {
	mut var_columns := rt.new_null()
	mut var_hidden := rt.new_null()
	mut var_sortable := rt.new_null()
	mut var_primary := rt.new_null()
	mut var_cb_counter := rt.new_null()
	mut list_tmp_2 := this.get_column_info()
	var_columns = list_tmp_2.array_get(0)
	var_hidden = list_tmp_2.array_get(1)
	var_sortable = list_tmp_2.array_get(2)
	var_primary = list_tmp_2.array_get(3)
	mut var_current_url := rt.call_function('set_url_scheme', [
		rt.new_string('http://' +
			(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_HOST'))).str() +
			(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))).str()),
	])
	var_current_url = rt.call_function('remove_query_arg', [rt.new_string('paged'),
		var_current_url.clone()])
	if rt.get_superglobal('_GET').array_isset(rt.new_string('orderby')) {
		mut var_current_orderby := rt.get_superglobal('_GET').array_get(rt.new_string('orderby'))
	} else {
		var_current_orderby = rt.new_string('')
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('order'))
		&& rt.is_true(rt.identical(rt.new_string('desc'), rt.get_superglobal('_GET').array_get(rt.new_string('order')))) {
		mut var_current_order := rt.new_string('desc')
	} else {
		var_current_order = rt.new_string('asc')
	}
	if !(!rt.is_true(var_columns.array_get(rt.new_string('cb')))) {
		var_columns.array_set('cb', '<input id="cb-select-all-' + var_cb_counter.str() +
			'" type="checkbox" />\n\t\t\t<label for="cb-select-all-' + var_cb_counter.str() + '">' +
			'<span class="screen-reader-text">' +
			(rt.call_function('__', [rt.new_string('Select All')])).str() + '</span>' + '</label>')
		rt.pre_inc(var_cb_counter)
	}
	mut iter_12 := var_columns.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_column_display_name := item_12.val
		mut var_column_key := item_12.key
		mut var_class := rt.create_array([
			rt.ArrayItem{ key: none, val: 'manage-column' },
			rt.ArrayItem{ key: none, val: 'column-${var_column_key.to_string()}' },
		])
		mut var_aria_sort_attr := rt.new_string('')
		mut var_abbr_attr := rt.new_string('')
		mut var_order_text := rt.new_string('')
		if rt.is_true(rt.call_function('in_array', [var_column_key.clone(),
			var_hidden.clone(), rt.new_bool(true)]))
		{
			var_class.array_push('hidden')
		}
		if rt.is_true(rt.identical(rt.new_string('cb'), var_column_key)) {
			var_class.array_push('check-column')
		} else if rt.is_true(rt.call_function('in_array', [var_column_key.clone(),
			rt.create_array([rt.ArrayItem{ key: none, val: 'posts' },
				rt.ArrayItem{ key: none, val: 'comments' }, rt.ArrayItem{ key: none, val: 'links' }]),
			rt.new_bool(true)]))
		{
			var_class.array_push('num')
		}
		if rt.is_true(rt.identical(var_column_key, var_primary)) {
			var_class.array_push('column-primary')
		}
		if var_sortable.array_isset(var_column_key) {
			mut var_orderby := if !(var_sortable.array_get(var_column_key).array_get(rt.new_int(0))).is_null() {
				var_sortable.array_get(var_column_key).array_get(rt.new_int(0))
			} else {
				rt.new_string('')
			}
			mut var_desc_first := if !(var_sortable.array_get(var_column_key).array_get(rt.new_int(1))).is_null() {
				var_sortable.array_get(var_column_key).array_get(rt.new_int(1))
			} else {
				rt.new_bool(false)
			}
			mut var_abbr := if !(var_sortable.array_get(var_column_key).array_get(rt.new_int(2))).is_null() {
				var_sortable.array_get(var_column_key).array_get(rt.new_int(2))
			} else {
				rt.new_string('')
			}
			mut var_orderby_text := if !(var_sortable.array_get(var_column_key).array_get(rt.new_int(3))).is_null() {
				var_sortable.array_get(var_column_key).array_get(rt.new_int(3))
			} else {
				rt.new_string('')
			}
			mut var_initial_order := if !(var_sortable.array_get(var_column_key).array_get(rt.new_int(4))).is_null() {
				var_sortable.array_get(var_column_key).array_get(rt.new_int(4))
			} else {
				rt.new_string('')
			}
			if rt.is_true(rt.identical(rt.new_string(''), var_current_orderby))
				&& rt.is_true(var_initial_order) {
				var_current_orderby = var_orderby.clone()
				var_current_order = var_initial_order.clone()
			}
			if rt.is_true(rt.identical(var_current_orderby, var_orderby)) {
				if rt.is_true(rt.identical(rt.new_string('asc'), var_current_order)) {
					mut var_order := rt.new_string('desc')
					var_aria_sort_attr = rt.new_string(' aria-sort="ascending"')
				} else {
					var_order = rt.new_string('asc')
					var_aria_sort_attr = rt.new_string(' aria-sort="descending"')
				}
				var_class.array_push('sorted')
				var_class.array_push(var_current_order.clone())
			} else {
				var_order = rt.new_string(var_desc_first.clone().to_string().to_lower())
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
					var_order.clone(),
					rt.create_array([rt.ArrayItem{ key: none, val: 'desc' },
						rt.ArrayItem{ key: none, val: 'asc' }]),
					rt.new_bool(true),
				])))))
				{
					var_order = rt.new_string((if rt.is_true(var_desc_first) {
						'desc'
					} else {
						'asc'
					}).str())
				}
				var_class.array_push('sortable')
				var_class.array_push(if rt.is_true(rt.identical(rt.new_string('desc'), var_order)) {
					'asc'
				} else {
					'desc'
				})
				mut var_asc_text := rt.call_function('__', [
					rt.new_string('Sort ascending.'),
				])
				mut var_desc_text := rt.call_function('__', [
					rt.new_string('Sort descending.'),
				])
				var_order_text = if rt.is_true(rt.identical(rt.new_string('asc'), var_order)) {
					var_asc_text
				} else {
					var_desc_text
				}
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_order_text)))) {
				var_order_text = rt.new_string(' <span class="screen-reader-text">' +
					var_order_text.str() + '</span>')
			}
			var_abbr_attr = rt.new_string((if rt.is_true(var_abbr) {
				' abbr="' + (rt.call_function('esc_attr', [var_abbr.clone()])).str() + '"'
			} else {
				''
			}).str())
			var_column_display_name = rt.call_function('sprintf', [
				rt.new_string('<a href="%1$s">' + '<span>%2$s</span>' +
					'<span class="sorting-indicators">' +
					'<span class="sorting-indicator asc" aria-hidden="true"></span>' +
					'<span class="sorting-indicator desc" aria-hidden="true"></span>' + '</span>' +
					'%3$s' + '</a>'),
				rt.call_function('esc_url', [
					rt.call_function('add_query_arg', [
						rt.call_function('compact', [rt.new_string('orderby'),
							rt.new_string('order')]),
						var_current_url.clone(),
					]),
				]),
				var_column_display_name.clone(),
				var_order_text.clone(),
			])
		}
		mut var_tag := rt.new_string((if rt.is_true(rt.identical(rt.new_string('cb'),
			var_column_key))
		{
			'td'
		} else {
			'th'
		}).str())
		mut var_scope := rt.new_string((if rt.is_true(rt.identical(rt.new_string('th'), var_tag)) {
			'scope="col"'
		} else {
			''
		}).str())
		mut var_id := rt.new_string((if var_with_id {
			"id='${var_column_key.to_string()}'"
		} else {
			''
		}).str())
		mut var_class_attr := rt.new_string("class='" +
			(rt.call_function('implode', [rt.new_string(' '), var_class.clone()])).str() + "'")
		print('<${var_tag.to_string()} ${var_scope.to_string()} ${var_id.to_string()} ${var_class_attr.to_string()} ${var_aria_sort_attr.to_string()} ${var_abbr_attr.to_string()}>${var_column_display_name.to_string()}</${var_tag.to_string()}>')
	}
}

fn (mut this Class_WP_List_Table) print_table_description() {
	mut var_columns := rt.new_null()
	mut var_hidden := rt.new_null()
	mut var_sortable := rt.new_null()
	mut list_tmp_3 := this.get_column_info()
	var_columns = list_tmp_3.array_get(0)
	var_hidden = list_tmp_3.array_get(1)
	var_sortable = list_tmp_3.array_get(2)
	if !rt.is_true(var_sortable) {
		return
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('orderby')) {
		mut var_current_orderby := rt.get_superglobal('_GET').array_get(rt.new_string('orderby'))
	} else {
		var_current_orderby = rt.new_string('')
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('order'))
		&& rt.is_true(rt.identical(rt.new_string('desc'), rt.get_superglobal('_GET').array_get(rt.new_string('order')))) {
		mut var_current_order := rt.new_string('desc')
	} else {
		var_current_order = rt.new_string('asc')
	}
	mut iter_13 := rt.func_array_keys(var_columns.clone()).iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_column_key := item_13.val
		if var_sortable.array_isset(var_column_key) {
			mut var_orderby := if !(var_sortable.array_get(var_column_key).array_get(rt.new_int(0))).is_null() {
				var_sortable.array_get(var_column_key).array_get(rt.new_int(0))
			} else {
				rt.new_string('')
			}
			mut var_desc_first := if !(var_sortable.array_get(var_column_key).array_get(rt.new_int(1))).is_null() {
				var_sortable.array_get(var_column_key).array_get(rt.new_int(1))
			} else {
				rt.new_bool(false)
			}
			mut var_abbr := if !(var_sortable.array_get(var_column_key).array_get(rt.new_int(2))).is_null() {
				var_sortable.array_get(var_column_key).array_get(rt.new_int(2))
			} else {
				rt.new_string('')
			}
			mut var_orderby_text := if !(var_sortable.array_get(var_column_key).array_get(rt.new_int(3))).is_null() {
				var_sortable.array_get(var_column_key).array_get(rt.new_int(3))
			} else {
				rt.new_string('')
			}
			mut var_initial_order := if !(var_sortable.array_get(var_column_key).array_get(rt.new_int(4))).is_null() {
				var_sortable.array_get(var_column_key).array_get(rt.new_int(4))
			} else {
				rt.new_string('')
			}
			if !(var_orderby_text.clone().is_string())
				|| rt.is_true(rt.identical(rt.new_string(''), var_orderby_text)) {
				return
			}
			if rt.is_true(rt.identical(rt.new_string(''), var_current_orderby))
				&& rt.is_true(var_initial_order) {
				var_current_orderby = var_orderby.clone()
				var_current_order = var_initial_order.clone()
			}
			if rt.is_true(rt.identical(var_current_orderby, var_orderby)) {
				mut var_asc_text := rt.call_function('__', [rt.new_string('Ascending.')])
				mut var_desc_text := rt.call_function('__', [
					rt.new_string('Descending.'),
				])
				mut var_order_text := if rt.is_true(rt.identical(rt.new_string('asc'),
					var_current_order))
				{
					var_asc_text
				} else {
					var_desc_text
				}
				print('<caption class="screen-reader-text">' + var_orderby_text.str() + ' ' +
					var_order_text.str() + '</caption>')
				return
			}
		}
	}
}

fn (mut this Class_WP_List_Table) display() {
	mut var_singular := this._args.array_get(rt.new_string('singular'))
	this.display_tablenav(rt.new_string('top'))
	rt.call_method(this.screen, 'render_screen_reader_content', [
		rt.new_string('heading_list'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('implode', [rt.new_string(' '),
		this.get_table_classes()]))
	// unsupported statement: Stmt_InlineHTML
	this.print_table_description()
	// unsupported statement: Stmt_InlineHTML
	this.print_column_headers(false)
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_singular) {
		print(" data-wp-lists='list:${var_singular.to_string()}'")
	}
	// unsupported statement: Stmt_InlineHTML
	this.display_rows_or_placeholder()
	// unsupported statement: Stmt_InlineHTML
	this.print_column_headers(false)
	// unsupported statement: Stmt_InlineHTML
	this.display_tablenav(rt.new_string('bottom'))
}

fn (mut this Class_WP_List_Table) get_table_classes() rt.PhpVal {
	mut var_mode := rt.call_function('get_user_setting', [
		rt.new_string('posts_list_mode'),
		rt.new_string('list'),
	])
	mut var_mode_class := rt.call_function('esc_attr', [
		rt.new_string('table-view-' + var_mode.str()),
	])
	return rt.create_array([rt.ArrayItem{ key: none, val: 'widefat' },
		rt.ArrayItem{ key: none, val: 'fixed' }, rt.ArrayItem{ key: none, val: 'striped' },
		rt.ArrayItem{ key: none, val: var_mode_class }, rt.ArrayItem{
			key: none
			val: this._args.array_get(rt.new_string('plural'))
		}])
}

fn (mut this Class_WP_List_Table) display_tablenav(var_which rt.PhpVal) {
	if rt.is_true(rt.identical(rt.new_string('bottom'), var_which)) && !(this.has_items()) {
		return
	}
	if rt.is_true(rt.identical(rt.new_string('top'), var_which)) {
		rt.call_function('wp_nonce_field', [
			rt.new_string('bulk-' + (this._args.array_get(rt.new_string('plural'))).str()),
		])
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_which.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if this.has_items() {
		// unsupported statement: Stmt_InlineHTML
		this.bulk_actions(var_which.str())
		// unsupported statement: Stmt_InlineHTML
	}
	this.extra_tablenav(var_which.clone())
	this.pagination(var_which.clone())
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_List_Table) extra_tablenav(var_which rt.PhpVal) {
}

fn (mut this Class_WP_List_Table) display_rows_or_placeholder() {
	if this.has_items() {
		this.display_rows()
	} else {
		print('<tr class="no-items"><td class="colspanchange" colspan="' +
			this.get_column_count().str() + '">')
		this.no_items()
		print('</td></tr>')
	}
}

fn (mut this Class_WP_List_Table) display_rows() {
	mut iter_14 := this.items.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_item := item_14.val
		this.single_row(var_item.clone())
	}
}

fn (mut this Class_WP_List_Table) single_row(var_item rt.PhpVal) {
	print('<tr>')
	this.single_row_columns(var_item.clone())
	print('</tr>')
}

fn (mut this Class_WP_List_Table) column_default(var_item rt.PhpVal, var_column_name rt.PhpVal) {
}

fn (mut this Class_WP_List_Table) column_cb(var_item rt.PhpVal) {
}

fn (mut this Class_WP_List_Table) single_row_columns(var_item rt.PhpVal) {
	mut var_columns := rt.new_null()
	mut var_hidden := rt.new_null()
	mut var_sortable := rt.new_null()
	mut var_primary := rt.new_null()
	mut list_tmp_4 := this.get_column_info()
	var_columns = list_tmp_4.array_get(0)
	var_hidden = list_tmp_4.array_get(1)
	var_sortable = list_tmp_4.array_get(2)
	var_primary = list_tmp_4.array_get(3)
	mut iter_15 := var_columns.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_column_display_name := item_15.val
		mut var_column_name := item_15.key
		mut var_classes :=
			rt.new_string('${var_column_name.to_string()} column-${var_column_name.to_string()}')
		if rt.is_true(rt.identical(var_primary, var_column_name)) {
			var_classes = rt.concat(var_classes, rt.new_string(' has-row-actions column-primary'))
		}
		if rt.is_true(rt.call_function('in_array', [var_column_name.clone(),
			var_hidden.clone(), rt.new_bool(true)]))
		{
			var_classes = rt.concat(var_classes, rt.new_string(' hidden'))
		}
		mut var_data := rt.new_string('data-colname="' +
			(rt.call_function('esc_attr', [rt.call_function('wp_strip_all_tags', [var_column_display_name.clone()])])).str() +
			'"')
		mut var_attributes :=
			rt.new_string("class='${var_classes.to_string()}' ${var_data.to_string()}")
		if rt.is_true(rt.identical(rt.new_string('cb'), var_column_name)) {
			print('<th scope="row" class="check-column">')
			rt.echo_val(this.column_cb(var_item.clone()))
			print('</th>')
		} else if rt.is_true(rt.call_function('method_exists', [
			rt.new_object('WP_List_Table', []string{}, &this),
			rt.new_string('_column_' + var_column_name.str()),
		]))
		{
			rt.echo_val(rt.call_function('call_user_func', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_List_Table', []string{}, &this) },
					rt.ArrayItem{ key: none, val: '_column_' + var_column_name.str() },
				]),
				var_item.clone(),
				var_classes.clone(),
				var_data.clone(),
				var_primary.clone(),
			]))
		} else if rt.is_true(rt.call_function('method_exists', [
			rt.new_object('WP_List_Table', []string{}, &this),
			rt.new_string('column_' + var_column_name.str()),
		]))
		{
			print('<td ${var_attributes.to_string()}>')
			rt.echo_val(rt.call_function('call_user_func', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_List_Table', []string{}, &this) },
					rt.ArrayItem{ key: none, val: 'column_' + var_column_name.str() },
				]),
				var_item.clone(),
			]))
			print(this.handle_row_actions(var_item.clone(), var_column_name.clone(),
				var_primary.clone()))
			print('</td>')
		} else {
			print('<td ${var_attributes.to_string()}>')
			rt.echo_val(this.column_default(var_item.clone(), var_column_name.clone()))
			print(this.handle_row_actions(var_item.clone(), var_column_name.clone(),
				var_primary.clone()))
			print('</td>')
		}
	}
}

fn (mut this Class_WP_List_Table) handle_row_actions(var_item rt.PhpVal, var_column_name rt.PhpVal, var_primary rt.PhpVal) string {
	mut var_primary_mutated := var_primary
	return if rt.is_true(rt.identical(var_column_name, var_primary_mutated)) {
		'<button type="button" class="toggle-row"><span class="screen-reader-text">' +
			(rt.call_function('__', [rt.new_string('Show more details')])).str() +
			'</span></button>'
	} else {
		''
	}
}

fn (mut this Class_WP_List_Table) ajax_response() {
	this.prepare_items()
	rt.call_function('ob_start', []rt.PhpVal{})
	if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get(rt.new_string('no_placeholder')))) {
		this.display_rows()
	} else {
		this.display_rows_or_placeholder()
	}
	mut var_rows := rt.call_function('ob_get_clean', []rt.PhpVal{})
	mut var_response := {
		'rows': var_rows
	}
	if this._pagination_args.array_isset(rt.new_string('total_items')) {
		var_response['total_items_i18n'] = rt.call_function('sprintf', [
			rt.call_function('_n', [rt.new_string('%s item'),
				rt.new_string('%s items'), this._pagination_args.array_get(rt.new_string('total_items'))]),
			rt.call_function('number_format_i18n',
				[this._pagination_args.array_get(rt.new_string('total_items'))]),
		])
	}
	if this._pagination_args.array_isset(rt.new_string('total_pages')) {
		var_response['total_pages'] = this._pagination_args.array_get(rt.new_string('total_pages'))
		var_response['total_pages_i18n'] = rt.call_function('number_format_i18n', [
			this._pagination_args.array_get(rt.new_string('total_pages')),
		])
	}
	fn () {
		print((rt.call_function('wp_json_encode', [
			rt.create_array_from_native_map(var_response),
		])).str())
		exit(0)
	}()
}

fn (mut this Class_WP_List_Table) _js_vars() {
	mut var_args := rt.create_array([
		rt.ArrayItem{ key: 'class', val: rt.call_function('get_class', [
			rt.new_object('WP_List_Table', []string{}, &this),
		]) },
		rt.ArrayItem{ key: 'screen', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.get_property(this.screen, 'id') },
			rt.ArrayItem{ key: 'base', val: rt.get_property(this.screen, 'base') },
		]) },
	])
	rt.call_function('printf', [rt.new_string('<script>list_args = %s;</script>\n'),
		rt.call_function('wp_json_encode', [var_args.clone(),
			rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'),
				rt.get_constant('JSON_UNESCAPED_SLASHES'))])])
}

fn create_wp_list_table(arg_0 rt.PhpVal) &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase:    rt.PhpObjectBase{}
		items:            rt.new_null()
		_args:            rt.new_null()
		_pagination_args: rt.new_array()
		screen:           rt.new_null()
		_actions:         rt.new_null()
		_pagination:      ''
		modes:            rt.new_array()
		_column_headers:  rt.new_null()
		compat_fields:    rt.new_array()
		compat_methods:   rt.new_array()
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
			return rt.new_int(this.get_items_per_page(dispatch_arg_0, dispatch_arg_1))
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
			return rt.new_string(this.handle_row_actions(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'ajax_response' {
			this.ajax_response()
			return rt.new_null()
		}
		'_js_vars' {
			this._js_vars()
			return rt.new_null()
		}
		else {
			return none
		}
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
		'items' {
			this.items = val
			return true
		}
		'_args' {
			this._args = val
			return true
		}
		'_pagination_args' {
			this._pagination_args = val
			return true
		}
		'screen' {
			this.screen = val
			return true
		}
		'_actions' {
			this._actions = val
			return true
		}
		'_pagination' {
			this._pagination = val.str()
			return true
		}
		'modes' {
			this.modes = val
			return true
		}
		'_column_headers' {
			this._column_headers = val
			return true
		}
		'compat_fields' {
			this.compat_fields = val
			return true
		}
		'compat_methods' {
			this.compat_methods = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}
