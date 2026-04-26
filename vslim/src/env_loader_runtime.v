module main

import os
import vphp

@[php_method]
pub fn VSlimEnvLoader.bootstrap(root string) map[string]string {
	return VSlimEnvLoader.load(os.join_path_single(root, '.env'))
}

@[php_method]
pub fn VSlimEnvLoader.load(path string) map[string]string {
	if path.trim_space() == '' || !os.is_file(path) {
		return map[string]string{}
	}
	lines := os.read_lines(path) or {
		vphp.throw_exception_class('InvalidArgumentException', 'env load failed: ${err.msg()}',
			0)
		return map[string]string{}
	}
	mut loaded := map[string]string{}
	for line in lines {
		trimmed := line.trim_space()
		if trimmed == '' || trimmed.starts_with('#') {
			continue
		}
		mut raw := trimmed
		if raw.starts_with('export ') {
			raw = raw.all_after('export ').trim_space()
		}
		idx := raw.index('=') or { continue }
		name := raw[..idx].trim_space()
		if name == '' {
			continue
		}
		has_current := vphp.with_php_call_result_zval('getenv', [
			vphp.RequestOwnedZBox.new_string(name).to_zval(),
		], fn (current vphp.ZVal) bool {
			return current.is_valid() && (!current.is_bool() || current.to_bool())
		})
		if has_current {
			continue
		}
		value := vslim_env_loader_normalize_value(raw[idx + 1..])
		os.setenv(name, value, true)
		vphp.with_php_call_result_zval('putenv', [
			vphp.RequestOwnedZBox.new_string('${name}=${value}').to_zval(),
		], fn (_ vphp.ZVal) bool {
			return true
		})
		vphp.set_env_superglobal(name, value)
		vphp.set_server_superglobal(name, value)
		loaded[name] = value
	}
	return loaded
}

fn vslim_env_loader_normalize_value(value string) string {
	trimmed := value.trim_space()
	if trimmed.len < 2 {
		return trimmed
	}
	first := trimmed[0]
	last := trimmed[trimmed.len - 1]
	if (first == `"` && last == `"`) || (first == `'` && last == `'`) {
		return trimmed[1..trimmed.len - 1]
	}
	return trimmed
}
