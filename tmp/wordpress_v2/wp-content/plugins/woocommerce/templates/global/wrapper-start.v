import rt

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
	mut var_template := rt.call_function('wc_get_theme_slug_for_templates', []rt.PhpVal{})
	mut switch_val_1 := var_template
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('twentyten'))) {
		print('<div id="container"><div id="content" role="main">')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('twentyeleven'))) {
		print('<div id="primary"><div id="content" role="main" class="twentyeleven">')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('twentytwelve'))) {
		print('<div id="primary" class="site-content"><div id="content" role="main" class="twentytwelve">')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('twentythirteen'))) {
		print('<div id="primary" class="site-content"><div id="content" role="main" class="entry-content twentythirteen">')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('twentyfourteen'))) {
		print('<div id="primary" class="content-area"><div id="content" role="main" class="site-content twentyfourteen"><div class="tfwc">')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('twentyfifteen'))) {
		print('<div id="primary" role="main" class="content-area twentyfifteen"><div id="main" class="site-main t15wc">')
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('twentysixteen'))) {
		print('<div id="primary" class="content-area twentysixteen"><main id="main" class="site-main" role="main">')
	} else {
		print('<div id="primary" class="content-area"><main id="main" class="site-main" role="main">')
	}
}
