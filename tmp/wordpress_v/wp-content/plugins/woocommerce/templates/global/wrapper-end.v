import rt

pub fn init_wp_content_plugins_woocommerce_templates_global_wrapper_end_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		// unsupported expression: Expr_Exit
		// unsupported statement: Stmt_Nop
	}
	mut var_template := rt.call_function('wc_get_theme_slug_for_templates', []rt.PhpVal{})
	mut switch_val_1 := var_template
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('twentyten'))) {
		print('</div></div>')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('twentyeleven'))) {
		print('</div>')
		rt.call_function('get_sidebar', [rt.new_string('shop')])
		print('</div>')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('twentytwelve'))) {
		print('</div></div>')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('twentythirteen'))) {
		print('</div></div>')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('twentyfourteen'))) {
		print('</div></div></div>')
		rt.call_function('get_sidebar', [rt.new_string('content')])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('twentyfifteen'))) {
		print('</div></div>')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('twentysixteen'))) {
		print('</main></div>')
	} else {
		print('</main></div>')
	}
}
