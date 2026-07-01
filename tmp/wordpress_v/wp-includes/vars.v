import rt

fn wp_is_mobile() rt.PhpVal {
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_SEC_CH_UA_MOBILE')) {
		mut var_is_mobile := (rt.identical(rt.new_string('?1'), rt.get_superglobal('_SERVER').array_get('HTTP_SEC_CH_UA_MOBILE'))).to_bool()
	} else if !rt.is_true(rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT')) {
		var_is_mobile = false
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Mobile')])) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Android')])))) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Silk/')])))) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Kindle')])))) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('BlackBerry')])))) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Opera Mini')])))) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Opera Mobi')])))) {
		var_is_mobile = true
	} else {
		var_is_mobile = false
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_is_mobile'), rt.new_bool(var_is_mobile).dup()])
}



pub fn init_wp_includes_vars_php() {
	mut var_self_matches := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
			rt.call_function('preg_match', [rt.new_string('#/wp-admin/network/?(.*?)$#i'), rt.get_superglobal('_SERVER').array_get('PHP_SELF'), var_self_matches.dup()])
		} else if rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{})) {
			rt.call_function('preg_match', [rt.new_string('#/wp-admin/user/?(.*?)$#i'), rt.get_superglobal('_SERVER').array_get('PHP_SELF'), var_self_matches.dup()])
		} else {
			rt.call_function('preg_match', [rt.new_string('#/wp-admin/?(.*?)$#i'), rt.get_superglobal('_SERVER').array_get('PHP_SELF'), var_self_matches.dup()])
		}
		mut var_pagenow := if !(!rt.is_true(var_self_matches.array_get(1))) { var_self_matches.array_get(1) } else { rt.new_string('') }
		var_pagenow = rt.new_string(rt.new_string(var_pagenow.dup().to_string().trim_space()))
		var_pagenow = rt.call_function('preg_replace', [rt.new_string('#\\?.*?$#'), rt.new_string(''), var_pagenow.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_pagenow)) || rt.is_true(rt.identical(rt.new_string('index'), var_pagenow)))) || rt.is_true(rt.identical(rt.new_string('index.php'), var_pagenow)))) {
			var_pagenow = rt.new_string(rt.new_string('index.php'))
		} else {
			rt.call_function('preg_match', [rt.new_string('#(.*?)(/|$)#'), var_pagenow.dup(), var_self_matches.dup()])
			var_pagenow = rt.new_string(rt.new_string(var_self_matches.array_get(1).to_string().to_lower()))
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [var_pagenow.dup(), rt.new_string('.php')]))))) {
				// unsupported expression: Expr_AssignOp_Concat
				// unsupported statement: Stmt_Nop
			}
		}
	} else {
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('#([^/]+\\.php)([?/].*?)?$#i'), rt.get_superglobal('_SERVER').array_get('PHP_SELF'), var_self_matches.dup()])) {
			var_pagenow = rt.new_string(rt.new_string(var_self_matches.array_get(1).to_string().to_lower()))
		} else {
			var_pagenow = rt.new_string(rt.new_string('index.php'))
		}
	}
	var_self_matches = rt.new_null()
	mut var_is_lynx := false
	mut var_is_gecko := false
	mut var_is_winIE := false
	mut var_is_macIE := false
	mut var_is_opera := false
	mut var_is_NS4 := false
	mut var_is_safari := false
	mut var_is_chrome := rt.new_bool(rt.new_bool(false))
	mut var_is_iphone := false
	mut var_is_edge := false
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_USER_AGENT')) {
		if rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Lynx')])) {
			var_is_lynx = true
		} else if rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Edg')])) {
			var_is_edge = true
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Opera')])) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('OPR/')])))) {
			var_is_opera = true
		} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				mut var_is_admin := rt.call_function('is_admin', []rt.PhpVal{})
				var_is_chrome = rt.call_function('apply_filters', [rt.new_string('use_google_chrome_frame'), var_is_admin.dup()])
				if rt.is_true(var_is_chrome) {
					rt.call_function('header', [rt.new_string('X-UA-Compatible: chrome=1')])
				}
				var_is_winIE = !(rt.is_true(var_is_chrome))
			} else {
				var_is_chrome = rt.new_bool(rt.new_bool(true))
			}
		} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_is_safari = true
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('MSIE')])) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Trident')])))) && rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Win')])))) {
			var_is_winIE = true
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('MSIE')])) && rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Mac')])))) {
			var_is_macIE = true
		} else if rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Gecko')])) {
			var_is_gecko = true
		} else if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Nav')])) && rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('HTTP_USER_AGENT'), rt.new_string('Mozilla/4.')])))) {
			var_is_NS4 = true
		}
	}
	if rt.is_true(rt.new_bool(var_is_safari && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_is_iphone = true
	}
	mut var_is_IE := var_is_macIE || var_is_winIE
	mut var_is_apache := rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE'), rt.new_string('Apache')])) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE'), rt.new_string('LiteSpeed')]))
	mut var_is_nginx := rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE'), rt.new_string('nginx')])
	mut var_is_caddy := rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE'), rt.new_string('Caddy')])) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE'), rt.new_string('FrankenPHP')]))
	mut var_is_IIS := !(var_is_apache) && rt.is_true(rt.new_bool(rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE'), rt.new_string('Microsoft-IIS')])) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('SERVER_SOFTWARE'), rt.new_string('ExpressionDevServer')]))))
	mut var_is_iis7 := var_is_IIS && rt.is_true(rt.greater_equal(// unsupported expression: Expr_Cast_Int, rt.new_int(7)))
}
