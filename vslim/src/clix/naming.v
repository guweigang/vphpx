module clix

import vphp

pub fn short_class_name(class_name string) string {
	clean := class_name.trim_space()
	last := clean.last_index('\\') or { -1 }
	if last >= 0 && last + 1 < clean.len {
		return clean[last + 1..]
	}
	return clean
}

pub fn command_name_from_short_name(short_name string) string {
	mut base := short_name.trim_space()
	if base.ends_with('Command') && base.len > 'Command'.len {
		base = base[..base.len - 'Command'.len]
	}
	mut out := []u8{}
	for idx, ch in base {
		is_upper := ch >= `A` && ch <= `Z`
		if idx > 0 && is_upper {
			prev := base[idx - 1]
			next_is_lower := idx + 1 < base.len && base[idx + 1] >= `a` && base[idx + 1] <= `z`
			if (prev >= `a` && prev <= `z`) || (prev >= `0` && prev <= `9`) || next_is_lower {
				out << `-`
			}
		}
		lower := if is_upper { u8(ch + 32) } else { ch }
		out << lower
	}
	return out.bytestr()
}

pub fn handler_string_is_function_callable(name string) bool {
	callable_name := name.trim_space()
	if callable_name == '' {
		return false
	}
	mut callable_arg := vphp.PhpString.of(callable_name)
	defer {
		callable_arg.release()
	}
	return vphp.PhpFunction.named('function_exists').result_bool(callable_arg)
}

pub fn derive_command_name_from_handler_name(raw_name string) !string {
	clean := raw_name.trim_space()
	source := if handler_string_is_function_callable(clean) {
		clean
	} else {
		short_class_name(clean)
	}
	name := command_name_from_short_name(source)
	if name == '' {
		return error('command name must not be empty')
	}
	return name
}

pub fn command_metadata_aliases(runtime vphp.PhpValue) []string {
	mut out := []string{}
	mut seen := map[string]bool{}
	if def := command_definition(runtime) {
		for alias in def.aliases {
			alias_name := alias.trim_space().clone()
			if alias_name == '' || alias_name in seen {
				continue
			}
			seen[alias_name] = true
			out << alias_name
		}
	}
	for alias in runtime_string_list_method(runtime, 'aliases') {
		alias_name := alias.trim_space().clone()
		if alias_name == '' || alias_name in seen {
			continue
		}
		seen[alias_name] = true
		out << alias_name
	}
	return out
}

pub fn command_metadata_hidden(runtime vphp.PhpValue) bool {
	if def := command_definition(runtime) {
		if def.hidden {
			return true
		}
	}
	return runtime_bool_method(runtime, 'hidden', false)
}
