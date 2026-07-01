import rt

struct Class_Bulk_Upgrader_Skin {
	rt.PhpObjectBase
pub mut:
	in_loop bool
	error   rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Bulk_Upgrader_Skin) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_defaults := {
		'url':   ''
		'nonce': ''
	}
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.dup(),
		var_defaults.dup()])
	this.Class_WP_Upgrader_Skin.construct(var_args_mutated.dup())
}

fn (mut this Class_Bulk_Upgrader_Skin) add_strings() {
	rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', [
		'WP_Upgrader_Skin',
	], &this), 'upgrader'), 'strings').array_set('skin_upgrade_start', rt.call_function('__', [
		rt.new_string('The update process is starting. This process may take a while on some hosts, so please be patient.'),
	]))
	rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', [
		'WP_Upgrader_Skin',
	], &this), 'upgrader'), 'strings').array_set('skin_update_failed_error', rt.call_function('__', [
		rt.new_string('An error occurred while updating %1$s: %2$s'),
	]))
	rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', [
		'WP_Upgrader_Skin',
	], &this), 'upgrader'), 'strings').array_set('skin_update_failed', rt.call_function('__', [
		rt.new_string('The update of %s failed.'),
	]))
	rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', [
		'WP_Upgrader_Skin',
	], &this), 'upgrader'), 'strings').array_set('skin_update_successful', rt.call_function('__', [
		rt.new_string('%s updated successfully.'),
	]))
	rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', [
		'WP_Upgrader_Skin',
	], &this), 'upgrader'), 'strings').array_set('skin_upgrade_end', rt.call_function('__', [
		rt.new_string('All updates have been completed.'),
	]))
}

fn (mut this Class_Bulk_Upgrader_Skin) feedback(var_feedback rt.PhpVal, var_args rt.PhpVal) {
	mut var_feedback_mutated := var_feedback
	mut var_args_mutated := var_args
	if rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', [
		'WP_Upgrader_Skin',
	], &this), 'upgrader'), 'strings').array_isset(var_feedback_mutated)
	{
		var_feedback_mutated = rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', [
			'WP_Upgrader_Skin',
		], &this), 'upgrader'), 'strings').array_get(var_feedback_mutated)
	}
	if rt.is_true(rt.call_function('str_contains', [var_feedback_mutated.dup(),
		rt.new_string('%')]))
	{
		if rt.is_true(var_args_mutated) {
			var_args_mutated = rt.call_function('array_map', [
				rt.new_string('strip_tags'),
				var_args_mutated.dup(),
			])
			var_args_mutated = rt.call_function('array_map', [
				rt.new_string('esc_html'), var_args_mutated.dup()])
			var_feedback_mutated = rt.call_function('vsprintf', [
				var_feedback_mutated.dup(), var_args_mutated.dup()])
		}
	}
	if !rt.is_true(var_feedback_mutated) {
		return rt.new_null()
	}
	if rt.is_true(this.in_loop) {
		print('${var_feedback.to_string()}<br />\n')
	} else {
		print('<p>${var_feedback.to_string()}</p>\n')
	}
}

fn (mut this Class_Bulk_Upgrader_Skin) header() {
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Bulk_Upgrader_Skin) footer() {
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_Bulk_Upgrader_Skin) error(var_errors rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_errors.dup().is_string()))
		&& rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'strings').array_isset(var_errors)))
	{
		this.error = rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', [
			'WP_Upgrader_Skin',
		], &this), 'upgrader'), 'strings').array_get(var_errors)
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_errors.dup()])) {
		mut var_messages := []rt.PhpVal{}
		{
			mut iter_1 := rt.call_method(var_errors, 'get_error_messages', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_emessage := item_1.val
				if rt.is_true(rt.new_bool(
					rt.is_true(rt.call_method(var_errors, 'get_error_data', []rt.PhpVal{}))
					&& rt.is_true(rt.new_bool(rt.call_method(var_errors, 'get_error_data', []rt.PhpVal{}).is_string()))))
				{
					var_messages << var_emessage.str() + ' ' +(rt.call_function('esc_html', [rt.call_function('strip_tags', [rt.call_method(var_errors, 'get_error_data', []rt.PhpVal{})])])).str()
				} else {
					var_messages << var_emessage.dup()
				}
			}
		}
		this.error = rt.call_function('implode', [rt.new_string(', '),
			var_messages.dup()])
	}
	print("<script>jQuery('.waiting-" +
		(rt.call_function('esc_js', [rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'update_current')])).str() +
		"').hide();</script>")
}

fn (mut this Class_Bulk_Upgrader_Skin) bulk_header() {
	this.feedback(rt.new_string('skin_upgrade_start'), rt.new_null())
}

fn (mut this Class_Bulk_Upgrader_Skin) bulk_footer() {
	this.feedback(rt.new_string('skin_upgrade_end'), rt.new_null())
}

fn (mut this Class_Bulk_Upgrader_Skin) before(title string) {
	this.in_loop = true
	rt.call_function('printf', [
		'<h2>' +
			(rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'strings').array_get('skin_before_update_header')).str() +
			' <span class="spinner waiting-' +
			(rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'update_current')).str() +
			'"></span></h2>',
		rt.new_string(title),
		rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', [
			'WP_Upgrader_Skin',
		], &this), 'upgrader'), 'update_current'),
		rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', [
			'WP_Upgrader_Skin',
		], &this), 'upgrader'), 'update_count'),
	])
	print("<script>jQuery('.waiting-" +
		(rt.call_function('esc_js', [rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'update_current')])).str() +
		'\').css("display", "inline-block");</script>')
	print('<div class="update-messages hide-if-js" id="progress-' +
		(rt.call_function('esc_attr', [rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'update_current')])).str() +
		'"><p>')
	this.flush_output()
}

fn (mut this Class_Bulk_Upgrader_Skin) after(title string) {
	print('</p></div>')
	if rt.is_true(rt.new_bool(rt.is_true(this.error)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'result')))))))
	{
		if rt.is_true(this.error) {
			mut var_after_error_message := rt.call_function('sprintf', [
				rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', [
					'WP_Upgrader_Skin',
				], &this), 'upgrader'), 'strings').array_get('skin_update_failed_error'),
				rt.new_string(title),
				'<strong>' + (this.error).str() + '</strong>',
			])
		} else {
			var_after_error_message = rt.call_function('sprintf', [
				rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', [
					'WP_Upgrader_Skin',
				], &this), 'upgrader'), 'strings').array_get('skin_update_failed'),
				rt.new_string(title),
			])
		}
		rt.call_function('wp_admin_notice', [var_after_error_message.dup(),
			rt.create_array([
				rt.ArrayItem{ key: 'additional_classes', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'error' },
				]) },
			])])
		print("<script>jQuery('#progress-" +
			(rt.call_function('esc_js', [rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'update_current')])).str() +
			"').show();</script>")
	}
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'result'))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [rt.get_property(rt.new_object('Bulk_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'result')])))))))
	{
		if rt.is_true(rt.new_bool(!(rt.is_true(this.error)))) {
			print('<div class="updated js-update-details" data-update-details="progress-' +
				(rt.call_function('esc_attr', [rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'update_current')])).str() +
				'">' + '<p>' +
				(rt.call_function('sprintf', [rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'strings').array_get('skin_update_successful'), rt.new_string(title)])).str() +
				' <button type="button" class="hide-if-no-js button-link js-update-details-toggle" aria-expanded="false">' +
				(rt.call_function('__', [rt.new_string('More details.')])).str() +
				'<span class="dashicons dashicons-arrow-down" aria-hidden="true"></span></button>' +
				'</p></div>')
		}
		print("<script>jQuery('.waiting-" +
			(rt.call_function('esc_js', [rt.get_property(rt.get_property(rt.new_object('Bulk_Upgrader_Skin', ['WP_Upgrader_Skin'], &this), 'upgrader'), 'update_current')])).str() +
			"').hide();</script>")
	}
	this.reset()
	this.flush_output()
}

fn (mut this Class_Bulk_Upgrader_Skin) reset() {
	this.in_loop = false
	this.error = rt.new_bool(false)
}

fn (mut this Class_Bulk_Upgrader_Skin) flush_output() {
	rt.call_function('wp_ob_end_flush_all', []rt.PhpVal{})
	rt.call_function('flush', []rt.PhpVal{})
}

struct Class_WP_Upgrader_Skin {
	rt.PhpObjectBase
}

fn create_bulk_upgrader_skin(arg_0 rt.PhpVal) &Class_Bulk_Upgrader_Skin {
	mut obj := &Class_Bulk_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
		in_loop:       false
		error:         rt.new_bool(false)
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_upgrader_skin() &Class_WP_Upgrader_Skin {
	mut obj := &Class_WP_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Bulk_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'add_strings' {
			this.add_strings()
			return rt.new_null()
		}
		'feedback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.feedback(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'header' {
			this.header()
			return rt.new_null()
		}
		'footer' {
			this.footer()
			return rt.new_null()
		}
		'error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.error(dispatch_arg_0)
			return rt.new_null()
		}
		'bulk_header' {
			this.bulk_header()
			return rt.new_null()
		}
		'bulk_footer' {
			this.bulk_footer()
			return rt.new_null()
		}
		'before' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.before(dispatch_arg_0)
			return rt.new_null()
		}
		'after' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.after(dispatch_arg_0)
			return rt.new_null()
		}
		'reset' {
			this.reset()
			return rt.new_null()
		}
		'flush_output' {
			this.flush_output()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Bulk_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'in_loop' { return rt.new_bool(this.in_loop) }
		'error' { return this.error }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Bulk_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'in_loop' {
			this.in_loop = val.to_bool()
			return true
		}
		'error' {
			this.error = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_admin_includes_class_bulk_upgrader_skin_php() {
}
