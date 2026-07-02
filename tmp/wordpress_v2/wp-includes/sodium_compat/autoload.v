import rt

fn sodiumcompatautoloader(var_class rt.PhpVal) bool {
	mut var_namespace := ''
	mut var_len := i64(0)
	mut var_relative_class := rt.new_null()
	mut var_file := rt.new_null()
	var_namespace = 'ParagonIE_Sodium_'
	var_len = var_namespace.len
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strncmp', [
		rt.new_string(var_namespace.str()).clone(),
		var_class.clone(),
		rt.new_int(var_len).clone(),
	]), rt.new_int(0)))))
	{
		return false
	}
	var_relative_class = rt.call_function('substr', [var_class.clone(),
		rt.new_int(var_len).clone()])
	var_file = rt.new_string((rt.call_function('dirname', [rt.new_string(@FILE)])).str() + '/src/' +
		(rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('/'), var_relative_class.clone()])).str() +
		'.php')
	if rt.is_true(rt.call_function('file_exists', [var_file.clone()])) {
		rt.include_file(var_file.to_string(), '4')
		return true
	}
	return false
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(70000))) {
		if !(rt.call_function('is_callable', [rt.new_string('sodiumCompatAutoloader')])) {
			rt.call_function('spl_autoload_register', [
				rt.new_string('sodiumCompatAutoloader'),
			])
		}
	} else {
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/autoload-php7.php', '4')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_Compat'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/src/Compat.php', '4')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [
		rt.new_string('SodiumException'),
		rt.new_bool(false),
	])))))
	{
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/src/SodiumException.php', '4')
	}
	if rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(50300))) {
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/lib/namespaced.php', '4')
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/lib/sodium_compat.php', '4')
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
			rt.new_string('SODIUM_CRYPTO_AEAD_AEGIS128L_KEYBYTES'),
		])))))
		{
			rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
				'/lib/php84compat_const.php', '4')
		}
	} else {
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/src/PHP52/SplFixedArray.php', '4')
	}
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(70200)))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('sodium')]))))) {
		if rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(50300)))
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('SODIUM_CRYPTO_SCALARMULT_BYTES')]))))) {
			rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
				'/lib/php72compat_const.php', '4')
		}
		if rt.is_true(rt.greater_equal(rt.get_constant('PHP_VERSION_ID'), rt.new_int(70000))) {
			rt.call_function('assert', [
				rt.call_function('class_exists', [
					rt.new_string('ParagonIE_Sodium_Compat'),
				]),
				rt.new_string('Possible filesystem/autoloader bug?'),
			])
		} else {
			rt.call_function('assert', [
				rt.call_function('class_exists', [
					rt.new_string('ParagonIE_Sodium_Compat'),
				]),
			])
		}
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/lib/php72compat.php', '4')
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('sodium_crypto_stream_xchacha20_xor'),
	])))))
	{
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/lib/php72compat.php', '4')
	}
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(80400)))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('extension_loaded', [rt.new_string('sodium')]))))) {
		rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
			'/lib/php84compat.php', '4')
	}
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/lib/stream-xchacha20.php', '4')
	rt.include_file((rt.call_function('dirname', [rt.new_string(@FILE)])).str() +
		'/lib/ristretto255.php', '4')
}
