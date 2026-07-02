import rt

var_is_IE = var_is_macIE || var_is_winIE
var_is_apache =
	rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')), rt.new_string('Apache')]))
	|| rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')), rt.new_string('LiteSpeed')]))
var_is_nginx = rt.call_function('str_contains', [
	rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')),
	rt.new_string('nginx'),
])
var_is_caddy =
	rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')), rt.new_string('Caddy')]))
	|| rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')), rt.new_string('FrankenPHP')]))
var_is_IIS = !var_is_apache
	&& rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')), rt.new_string('Microsoft-IIS')]))
	|| rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')), rt.new_string('ExpressionDevServer')]))
var_is_iis7 = var_is_IIS
	&& rt.new_int((rt.call_function('substr', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')), rt.add(rt.call_function('strpos', [rt.get_superglobal('_SERVER').array_get(rt.new_string('SERVER_SOFTWARE')), rt.new_string('Microsoft-IIS/')]), rt.new_int(14))])).to_i64()) >= 7
fn wp_is_mobile() rt.PhpVal {
	mut var_is_mobile := false
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_SEC_CH_UA_MOBILE')) {
		var_is_mobile = (rt.identical(rt.new_string('?1'),
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_SEC_CH_UA_MOBILE')))).to_bool()
	} else if !rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT'))) {
		var_is_mobile = false
	} else if
		rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('Mobile')]))
		|| rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('Android')]))
		|| rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('Silk/')]))
		|| rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('Kindle')]))
		|| rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('BlackBerry')]))
		|| rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('Opera Mini')]))
		|| rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('Opera Mobi')])) {
		var_is_mobile = true
	} else {
		var_is_mobile = false
	}
	return rt.call_function('apply_filters', [rt.new_string('wp_is_mobile'),
		rt.new_bool(var_is_mobile).clone()])
}

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_self_matches := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	mut var_pagenow := rt.get_superglobal('pagenow')
	mut var_is_lynx := rt.get_superglobal('is_lynx')
	mut var_is_gecko := rt.get_superglobal('is_gecko')
	mut var_is_winIE := rt.get_superglobal('is_winIE')
	mut var_is_macIE := rt.get_superglobal('is_macIE')
	mut var_is_opera := rt.get_superglobal('is_opera')
	mut var_is_NS4 := rt.get_superglobal('is_NS4')
	mut var_is_safari := rt.get_superglobal('is_safari')
	mut var_is_chrome := rt.get_superglobal('is_chrome')
	mut var_is_iphone := rt.get_superglobal('is_iphone')
	mut var_is_IE := rt.get_superglobal('is_IE')
	mut var_is_edge := rt.get_superglobal('is_edge')
	mut var_is_apache := rt.get_superglobal('is_apache')
	mut var_is_IIS := rt.get_superglobal('is_IIS')
	mut var_is_iis7 := rt.get_superglobal('is_iis7')
	mut var_is_nginx := rt.get_superglobal('is_nginx')
	mut var_is_caddy := rt.get_superglobal('is_caddy')
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) {
		if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
			rt.call_function('preg_match', [
				rt.new_string('#/wp-admin/network/?(.*?)$#i'),
				rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF')),
				rt.create_array_from_list(var_self_matches),
			])
		} else if rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{})) {
			rt.call_function('preg_match', [rt.new_string('#/wp-admin/user/?(.*?)$#i'),
				rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF')),
				rt.create_array_from_list(var_self_matches)])
		} else {
			rt.call_function('preg_match', [rt.new_string('#/wp-admin/?(.*?)$#i'),
				rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF')),
				rt.create_array_from_list(var_self_matches)])
		}
		var_pagenow = if !(!rt.is_true(var_self_matches[1])) {
			var_self_matches[1]
		} else {
			rt.new_string('')
		}
		var_pagenow = rt.new_string(var_pagenow.clone().to_string().trim_space())
		var_pagenow = rt.call_function('preg_replace', [rt.new_string('#\\?.*?$#'),
			rt.new_string(''), var_pagenow.clone()])
		if rt.is_true(rt.identical(rt.new_string(''), var_pagenow))
			|| rt.is_true(rt.identical(rt.new_string('index'), var_pagenow))
			|| rt.is_true(rt.identical(rt.new_string('index.php'), var_pagenow)) {
			var_pagenow = rt.new_string('index.php')
		} else {
			rt.call_function('preg_match', [rt.new_string('#(.*?)(/|$)#'),
				var_pagenow.clone(), rt.create_array_from_list(var_self_matches)])
			var_pagenow = rt.new_string(var_self_matches[1].to_string().to_lower())
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [
				var_pagenow.clone(),
				rt.new_string('.php'),
			])))))
			{
				var_pagenow = rt.concat(var_pagenow, rt.new_string('.php'))
			}
		}
	} else {
		if rt.is_true(rt.call_function('preg_match', [
			rt.new_string('#([^/]+\\.php)([?/].*?)?$#i'),
			rt.get_superglobal('_SERVER').array_get(rt.new_string('PHP_SELF')),
			rt.create_array_from_list(var_self_matches),
		]))
		{
			var_pagenow = rt.new_string(var_self_matches[1].to_string().to_lower())
		} else {
			var_pagenow = rt.new_string('index.php')
		}
	}
	var_self_matches = rt.new_null()
	var_is_lynx = false
	var_is_gecko = false
	var_is_winIE = false
	var_is_macIE = false
	var_is_opera = false
	var_is_NS4 = false
	var_is_safari = false
	var_is_chrome = rt.new_bool(false)
	var_is_iphone = false
	var_is_edge = false
	if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_USER_AGENT')) {
		if rt.is_true(rt.call_function('str_contains', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')),
			rt.new_string('Lynx'),
		]))
		{
			var_is_lynx = true
		} else if rt.is_true(rt.call_function('str_contains', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')),
			rt.new_string('Edg'),
		]))
		{
			var_is_edge = true
		} else if
			rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('Opera')]))
			|| rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('OPR/')])) {
			var_is_opera = true
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')),
			rt.new_string('chrome'),
		]), rt.new_bool(false)))))
		{
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [
				rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')),
				rt.new_string('chromeframe'),
			]), rt.new_bool(false)))))
			{
				mut var_is_admin := rt.call_function('is_admin', []rt.PhpVal{})
				var_is_chrome = rt.call_function('apply_filters', [
					rt.new_string('use_google_chrome_frame'),
					var_is_admin.clone(),
				])
				if rt.is_true(var_is_chrome) {
					rt.call_function('header', [
						rt.new_string('X-UA-Compatible: chrome=1'),
					])
				}
				var_is_winIE = !(rt.is_true(var_is_chrome))
			} else {
				var_is_chrome = rt.new_bool(true)
			}
		} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')),
			rt.new_string('safari'),
		]), rt.new_bool(false)))))
		{
			var_is_safari = true
		} else if
			rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('MSIE')]))
			|| rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('Trident')]))
			&& rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('Win')])) {
			var_is_winIE = true
		} else if
			rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('MSIE')]))
			&& rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('Mac')])) {
			var_is_macIE = true
		} else if rt.is_true(rt.call_function('str_contains', [
			rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')),
			rt.new_string('Gecko'),
		]))
		{
			var_is_gecko = true
		} else if
			rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('Nav')]))
			&& rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('Mozilla/4.')])) {
			var_is_NS4 = true
		}
	}
	if var_is_safari
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('stripos', [rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT')), rt.new_string('mobile')]), rt.new_bool(false))))) {
		var_is_iphone = true
	}
}
