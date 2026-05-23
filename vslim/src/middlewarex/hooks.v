module middlewarex

import loggerx
import vphp

pub fn release_hooks(mut hooks []vphp.PhpValue) {
	for i in 0 .. hooks.len {
		hooks[i].release()
	}
	unsafe {
		hooks.free()
	}
}

pub fn clone_hooks(hooks []vphp.PhpValue) []vphp.PhpValue {
	mut out := []vphp.PhpValue{}
	for hook in hooks {
		out << hook.owned()
	}
	return out
}

pub fn clone_combined_hooks(base []vphp.PhpValue, extra []vphp.PhpValue) []vphp.PhpValue {
	mut out := clone_hooks(base)
	for hook in extra {
		out << hook.owned()
	}
	return out
}

pub fn clone_standard_hooks(base []vphp.PhpValue, extra []vphp.PhpValue) []vphp.PhpValue {
	mut out := []vphp.PhpValue{}
	for idx, hook in base {
		cloned := hook.owned()
		if idx == 0 {
			slot_addr := unsafe { usize(&base[idx]) }
			loggerx.cli_debug_log('middleware.collect app idx=${idx} slot=${slot_addr} src_kind=${hook.kind_name()} src_valid=${hook.is_valid()} src_null=${hook.is_null()} src_undef=${hook.is_undef()} clone_valid=${cloned.is_valid()} clone_null=${cloned.is_null()} clone_undef=${cloned.is_undef()}')
		}
		out << cloned
	}
	for hook in extra {
		out << hook.owned()
	}
	return out
}
