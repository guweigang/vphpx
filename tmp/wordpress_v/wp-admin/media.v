import rt


fn main() {
	defer {
		rt.shutdown()
	}

	rt.include_file(@DIR + '/admin.php', '4')
	mut var_parent_file := 'upload.php'
	mut var_submenu_file := 'upload.php'
	mut var_action := if !(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('action'))) { rt.call_function('sanitize_text_field', [rt.get_superglobal('_REQUEST').array_get('action')]) } else { rt.new_string('') }
	mut switch_val_1 := var_action
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('editattachment'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('edit'))) {
		if !rt.is_true(rt.get_superglobal('_GET').array_get('attachment_id')) {
			rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('upload.php?error=deprecated')])])
			// unsupported expression: Expr_Exit
		}
		mut var_att_id := // unsupported expression: Expr_Cast_Int
		rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string("upload.php?item=${var_att_id.to_string()}&error=deprecated")])])
		// unsupported expression: Expr_Exit
	} else {
		rt.call_function('wp_redirect', [rt.call_function('admin_url', [rt.new_string('upload.php?error=deprecated')])])
		// unsupported expression: Expr_Exit
	}
}
