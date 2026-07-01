import rt

fn hello_dolly_get_lyric() rt.PhpVal {
	mut var_lyrics := rt.new_string(rt.new_string('Hello, Dolly\nWell, hello, Dolly\nIt\'s so nice to have you back where you belong\nYou\'re lookin\' swell, Dolly\nI can tell, Dolly\nYou\'re still glowin\', you\'re still crowin\'\nYou\'re still goin\' strong\nI feel the room swayin\'\nWhile the band\'s playin\'\nOne of our old favorite songs from way back when\nSo, take her wrap, fellas\nDolly, never go away again\nHello, Dolly\nWell, hello, Dolly\nIt\'s so nice to have you back where you belong\nYou\'re lookin\' swell, Dolly\nI can tell, Dolly\nYou\'re still glowin\', you\'re still crowin\'\nYou\'re still goin\' strong\nI feel the room swayin\'\nWhile the band\'s playin\'\nOne of our old favorite songs from way back when\nSo, golly, gee, fellas\nHave a little faith in me, fellas\nDolly, never go away\nPromise, you\'ll never go away\nDolly\'ll never go away again'))
	var_lyrics = rt.call_function('explode', [rt.new_string('\n'), var_lyrics.dup()])
	return rt.call_function('wptexturize', [var_lyrics.array_get(rt.call_function('mt_rand', [rt.new_int(0), var_lyrics.dup().array_count() - 1]))])
}

fn hello_dolly() {
	mut var_chosen := hello_dolly_get_lyric()
	mut var_lang := ''
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_lang = ' lang="en"'
	}
	rt.call_function('printf', [rt.new_string('<p id="dolly"><span class="screen-reader-text">%s </span><span dir="ltr"%s>%s</span></p>'), rt.call_function('__', [rt.new_string('Quote from Hello Dolly song, by Jerry Herman:')]), rt.new_string(var_lang).dup(), var_chosen.dup()])
}

fn dolly_css() {
	print('\n\t<style type=\'text/css\'>\n\t#dolly {\n\t\tfloat: right;\n\t\tpadding: 5px 10px;\n\t\tmargin: 0;\n\t\tfont-size: 12px;\n\t\tline-height: 1.6666;\n\t}\n\t.rtl #dolly {\n\t\tfloat: left;\n\t}\n\t.block-editor-page #dolly {\n\t\tdisplay: none;\n\t}\n\t@media screen and (max-width: 782px) {\n\t\t#dolly,\n\t\t.rtl #dolly {\n\t\t\tfloat: none;\n\t\t\tpadding-left: 0;\n\t\t\tpadding-right: 0;\n\t\t}\n\t}\n\t</style>\n\t')
}



pub fn init_wp_content_plugins_hello_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.new_string('hello_dolly')])
	rt.call_function('add_action', [rt.new_string('admin_head'), rt.new_string('dolly_css')])
}
