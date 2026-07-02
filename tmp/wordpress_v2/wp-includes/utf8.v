import rt

fn wp_is_valid_utf8(var_bytes rt.PhpVal) bool {
	return (rt.call_function('mb_check_encoding', [var_bytes.clone(),
		rt.new_string('UTF-8')])).to_bool()
}

fn wp_is_valid_utf8(string string) bool {
	mut var_string := string
	return (rt.call_function('_wp_is_valid_utf8_fallback', [rt.new_string(string)])).to_bool()
}

fn wp_scrub_utf8(var_text rt.PhpVal) rt.PhpVal {
	mut var_prev_replacement_character := rt.new_null()
	mut var_scrubbed := rt.new_null()
	var_prev_replacement_character = rt.call_function('mb_substitute_character', []rt.PhpVal{})
	rt.call_function('mb_substitute_character', [rt.new_int(65533)])
	var_scrubbed = rt.call_function('mb_scrub', [var_text.clone(),
		rt.new_string('UTF-8')])
	rt.call_function('mb_substitute_character', [var_prev_replacement_character.clone()])
	return var_scrubbed.clone()
}

fn wp_scrub_utf8(var_text rt.PhpVal) rt.PhpVal {
	return rt.call_function('_wp_scrub_utf8_fallback', [var_text.clone()])
}

fn wp_has_noncharacters(text string) bool {
	mut var_text := text
	return (rt.identical(rt.new_int(1), rt.call_function('preg_match', [
		rt.new_string('/[\\x{FDD0}-\\x{FDEF}\\x{FFFE}\\x{FFFF}\\x{1FFFE}\\x{1FFFF}\\x{2FFFE}\\x{2FFFF}\\x{3FFFE}\\x{3FFFF}\\x{4FFFE}\\x{4FFFF}\\x{5FFFE}\\x{5FFFF}\\x{6FFFE}\\x{6FFFF}\\x{7FFFE}\\x{7FFFF}\\x{8FFFE}\\x{8FFFF}\\x{9FFFE}\\x{9FFFF}\\x{AFFFE}\\x{AFFFF}\\x{BFFFE}\\x{BFFFF}\\x{CFFFE}\\x{CFFFF}\\x{DFFFE}\\x{DFFFF}\\x{EFFFE}\\x{EFFFF}\\x{FFFFE}\\x{FFFFF}\\x{10FFFE}\\x{10FFFF}]/u'),
		rt.new_string(text),
	]))).to_bool()
}

fn wp_has_noncharacters(text string) bool {
	mut var_text := text
	return (rt.call_function('_wp_has_noncharacters_fallback', [
		rt.new_string(text)])).to_bool()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('extension_loaded', [rt.new_string('mbstring')])) {
	} else {
	}
	if rt.is_true(rt.call_function('extension_loaded', [rt.new_string('mbstring')]))
		&& rt.is_true(rt.call_function('version_compare', [rt.get_constant('PHP_VERSION'), rt.new_string('8.1.6'), rt.new_string('>=')])) {
	} else {
	}
	if rt.is_true(rt.call_function('_wp_can_use_pcre_u', []rt.PhpVal{})) {
	} else {
	}
}
