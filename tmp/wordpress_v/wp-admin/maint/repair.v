import rt

const global_const_wp_repairing = true

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_wpdb := rt.new_null()
	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR), rt.new_int(2)])).str() +
		'/wp-load.php', '4')
	rt.call_function('header', [rt.new_string('Content-Type: text/html; charset=utf-8')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('WordPress &rsaquo; Database Repair')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_admin_css', [rt.new_string('install'),
		rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('WordPress')])
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('WP_ALLOW_REPAIR')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('WP_ALLOW_REPAIR')))))))
	{
		print('<h1 class="screen-reader-text">' +
			(rt.call_function('__', [rt.new_string('Allow automatic database repair')])).str() +
			'</h1>')
		print('<p>')
		rt.call_function('printf', [
			rt.call_function('__', [
				rt.new_string('To allow use of this page to automatically repair database problems, please add the following line to your %s file. Once this line is added to your config, reload this page.'),
			]),
			rt.new_string('<code>wp-config.php</code>'),
		])
		print("</p><p><code>define('WP_ALLOW_REPAIR', true);</code></p>")
		mut var_default_keys := rt.call_function('array_unique', [
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'put your unique phrase here' },
				rt.ArrayItem{ key: none, val: rt.call_function('__', [
					rt.new_string('put your unique phrase here'),
				]) },
			]),
		])
		mut var_missing_key := false
		mut var_duplicated_keys := rt.new_array()
		{
			mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'AUTH_KEY' },
				rt.ArrayItem{ key: none, val: 'SECURE_AUTH_KEY' },
				rt.ArrayItem{ key: none, val: 'LOGGED_IN_KEY' },
				rt.ArrayItem{ key: none, val: 'NONCE_KEY' }, rt.ArrayItem{
					key: none
					val: 'AUTH_SALT'
				}, rt.ArrayItem{ key: none, val: 'SECURE_AUTH_SALT' },
				rt.ArrayItem{ key: none, val: 'LOGGED_IN_SALT' },
				rt.ArrayItem{ key: none, val: 'NONCE_SALT' }]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_key := item_1.val
				if rt.is_true(rt.call_function('defined', [var_key.dup()])) {
					var_duplicated_keys.array_set(rt.call_function('constant', [
						var_key.dup()]), rt.new_bool(var_duplicated_keys.array_isset(rt.call_function('constant', [
						var_key.dup(),
					]))))
				} else {
					var_missing_key = true
				}
			}
		}
		{
			mut iter_1 := var_default_keys.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_default_key := item_1.val
				if var_duplicated_keys.array_isset(var_default_key) {
					var_duplicated_keys.array_set(var_default_key, true)
				}
			}
		}
		var_duplicated_keys = rt.call_function('array_filter', [
			var_duplicated_keys.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(var_duplicated_keys) || var_missing_key)) {
			print('<h2 class="screen-reader-text">' +
				(rt.call_function('__', [rt.new_string('Check secret keys')])).str() + '</h2>')
			print('<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('While you are editing your %1$s file, take a moment to make sure you have all 8 keys and that they are unique. You can generate these using the <a href="%2$s">WordPress.org secret key service</a>.')]), rt.new_string('<code>wp-config.php</code>'), rt.new_string('https://api.wordpress.org/secret-key/1.1/salt/')])).str() +
				'</p>')
		}
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('repair')) {
		print('<h1 class="screen-reader-text">' +
			(rt.call_function('__', [rt.new_string('Database repair results')])).str() + '</h1>')
		mut var_optimize := rt.identical(rt.new_string('2'),
			rt.get_superglobal('_GET').array_get('repair'))
		mut var_okay := true
		mut var_problems := rt.new_array()
		mut var_tables := rt.call_method(var_wpdb, 'tables', []rt.PhpVal{})
		var_tables = rt.call_function('array_merge', [var_tables.dup(),
			rt.cast_array(rt.call_function('apply_filters', [
				rt.new_string('tables_to_repair'),
				rt.new_array(),
			]))])
		{
			mut iter_1 := var_tables.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_table := item_1.val
				mut var_check := rt.call_method(var_wpdb, 'get_row', [
					rt.call_method(var_wpdb, 'prepare', [rt.new_string('CHECK TABLE %i'),
						var_table.dup()]),
				])
				print('<p>')
				if rt.is_true(rt.identical(rt.new_string('OK'), rt.get_property(var_check,
					'Msg_text')))
				{
					rt.call_function('printf', [
						rt.call_function('__', [rt.new_string('The %s table is okay.')]),
						rt.new_string('<code>${var_table.to_string()}</code>'),
					])
				} else {
					rt.call_function('printf', [
						rt.call_function('__', [
							rt.new_string('The %1$s table is not okay. It is reporting the following error: %2$s. WordPress will attempt to repair this table&hellip;'),
						]),
						rt.new_string('<code>${var_table.to_string()}</code>'),
						rt.concat(rt.concat(rt.new_string('<code>'), rt.get_property(var_check,
							'Msg_text')), rt.new_string('</code>')),
					])
					mut var_repair := rt.call_method(var_wpdb, 'get_row', [
						rt.call_method(var_wpdb, 'prepare', [
							rt.new_string('REPAIR TABLE %i'),
							var_table.dup(),
						]),
					])
					print('<br />&nbsp;&nbsp;&nbsp;&nbsp;')
					if rt.is_true(rt.identical(rt.new_string('OK'), rt.get_property(var_repair,
						'Msg_text')))
					{
						rt.call_function('printf', [
							rt.call_function('__', [
								rt.new_string('Successfully repaired the %s table.'),
							]),
							rt.new_string('<code>${var_table.to_string()}</code>'),
						])
					} else {
							(rt.call_function('printf', [rt.call_function('__', [rt.new_string('Failed to repair the %1$s table. Error: %2$s')]), rt.new_string('<code>${var_table.to_string()}</code>'), rt.concat(rt.concat(rt.new_string('<code>'), rt.get_property(var_repair, 'Msg_text')), rt.new_string('</code>'))])).str() +
							'<br />'
						var_problems.array_set(var_table, rt.get_property(var_repair, 'Msg_text'))
						var_okay = false
					}
				}
				if rt.is_true(rt.new_bool(var_okay && rt.is_true(var_optimize))) {
					mut var_analyze := rt.call_method(var_wpdb, 'get_row', [
						rt.call_method(var_wpdb, 'prepare', [
							rt.new_string('ANALYZE TABLE %i'),
							var_table.dup(),
						]),
					])
					print('<br />&nbsp;&nbsp;&nbsp;&nbsp;')
					if rt.is_true(rt.identical(rt.new_string('Table is already up to date'), rt.get_property(var_analyze,
						'Msg_text')))
					{
						rt.call_function('printf', [
							rt.call_function('__', [
								rt.new_string('The %s table is already optimized.'),
							]),
							rt.new_string('<code>${var_table.to_string()}</code>'),
						])
					} else {
						var_optimize = rt.call_method(var_wpdb, 'get_row', [
							rt.call_method(var_wpdb, 'prepare', [
								rt.new_string('OPTIMIZE TABLE %i'),
								var_table.dup(),
							]),
						])
						print('<br />&nbsp;&nbsp;&nbsp;&nbsp;')
						if rt.is_true(rt.new_bool(
							rt.is_true(rt.identical(rt.new_string('OK'), rt.get_property(var_optimize, 'Msg_text')))
							|| rt.is_true(rt.identical(rt.new_string('Table is already up to date'), rt.get_property(var_optimize, 'Msg_text')))))
						{
							rt.call_function('printf', [
								rt.call_function('__', [
									rt.new_string('Successfully optimized the %s table.'),
								]),
								rt.new_string('<code>${var_table.to_string()}</code>'),
							])
						} else {
							rt.call_function('printf', [
								rt.call_function('__', [
									rt.new_string('Failed to optimize the %1$s table. Error: %2$s'),
								]),
								rt.new_string('<code>${var_table.to_string()}</code>'),
								rt.concat(rt.concat(rt.new_string('<code>'), rt.get_property(var_optimize,
									'Msg_text')), rt.new_string('</code>')),
							])
						}
					}
				}
				print('</p>')
			}
		}
		if rt.is_true(var_problems) {
			rt.call_function('printf', [
				'<p>' +
					(rt.call_function('__', [rt.new_string('Some database problems could not be repaired. Please copy-and-paste the following list of errors to the <a href="%s">WordPress support forums</a> to get additional assistance.')])).str() +
					'</p>',
				rt.call_function('__', [
					rt.new_string('https://wordpress.org/support/forum/how-to-and-troubleshooting'),
				]),
			])
			mut var_problem_output := ''
			{
				mut iter_1 := var_problems.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_problem := item_1.val
					mut var_table := item_1.key
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
			print('<p><textarea name="errors" id="errors" rows="20" cols="60">' +
				(rt.call_function('esc_textarea', [rt.new_string(var_problem_output).dup()])).str() +
				'</textarea></p>')
		} else {
			print('<p>' +
				(rt.call_function('__', [rt.new_string('Repairs complete. Please remove the following line from wp-config.php to prevent this page from being used by unauthorized users.')])).str() +
				"</p><p><code>define('WP_ALLOW_REPAIR', true);</code></p>")
		}
	} else {
		print('<h1 class="screen-reader-text">' +
			(rt.call_function('__', [rt.new_string('WordPress database repair')])).str() + '</h1>')
		if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('referrer'))
			&& rt.is_true(rt.identical(rt.new_string('is_blog_installed'), rt.get_superglobal('_GET').array_get('referrer')))))
		{
			print('<p>' +
				(rt.call_function('__', [rt.new_string('One or more database tables are unavailable. To allow WordPress to attempt to repair these tables, press the &#8220;Repair Database&#8221; button. Repairing can take a while, so please be patient.')])).str() +
				'</p>')
		} else {
			print('<p>' +
				(rt.call_function('__', [rt.new_string('WordPress can automatically look for some common database problems and repair them. Repairing can take a while, so please be patient.')])).str() +
				'</p>')
		}
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Repair Database')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [
			rt.new_string('WordPress can also attempt to optimize the database. This improves performance in some situations. Repairing and optimizing the database can take a long time and the database will be locked while optimizing.'),
		])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Repair and Optimize Database')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
}
