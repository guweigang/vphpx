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
		vphp.PhpException.raise_class('InvalidArgumentException', 'env load failed: ${err.msg()}',
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
		mut name_arg := vphp.PhpString.of(name)
		defer {
			name_arg.release()
		}
		has_current := vphp.PhpFunction.named('getenv').with_result[vphp.PhpValue, bool](fn (current vphp.PhpValue) bool {
			return current.is_valid() && (!current.is_bool() || current.to_zval().to_bool())
		}, name_arg) or { false }
		if has_current {
			continue
		}
		value := vslim_env_loader_normalize_value(raw[idx + 1..])
		os.setenv(name, value, true)
		mut putenv_arg := vphp.PhpString.of('${name}=${value}')
		defer {
			putenv_arg.release()
		}
		_ = vphp.PhpFunction.named('putenv').result_bool(putenv_arg)
		vphp.PhpSuperglobals.set_env(name, value)
		vphp.PhpSuperglobals.set_server(name, value)
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
