module clockx

import vphp

@[php_method]
pub fn (mut clock VSlimPsr20Clock) construct() &VSlimPsr20Clock {
	return &clock
}

@[php_return_type: 'DateTimeImmutable']
@[php_method]
pub fn (clock &VSlimPsr20Clock) now() vphp.PhpObject {
	_ = clock
	now := vphp.PhpClass.named('DateTimeImmutable').construct() or {
		vphp.PhpException.raise_class('RuntimeException',
			'failed to create DateTimeImmutable instance', 0)
		return vphp.PhpObject.invalid()
	}
	return now.to_request_owned()
}

pub fn VSlimPsr20Clock.new_object() vphp.PhpObject {
	clock := vphp.PhpClass.named('VSlim\\Psr20\\Clock').construct() or {
		return vphp.PhpObject.invalid()
	}
	return clock
}

pub fn new_psr20_system_clock_ref() vphp.PhpObject {
	clock := VSlimPsr20Clock.new_object()
	return clock.retain()
}

pub fn psr20_is_clock(value vphp.PhpValue) bool {
	return value.is_valid() && value.is_object()
		&& (value.is_instance_of('Psr\\Clock\\ClockInterface') || value.method_exists('now'))
}

pub fn psr20_object_is_clock(clock vphp.PhpObject) bool {
	return clock.is_valid()
		&& (clock.is_instance_of('Psr\\Clock\\ClockInterface') || clock.method_exists('now'))
}

pub fn psr20_clock_is_valid(clock vphp.PhpObject) bool {
	return psr20_object_is_clock(clock)
}

pub fn psr20_clock_now_datetime_or_throw(clock vphp.PhpObject) !vphp.PhpObject {
	if !psr20_clock_is_valid(clock) {
		return error('clock must implement Psr\\Clock\\ClockInterface')
	}
	mut now := clock.call_method('now')
	if !now.is_valid() || !now.is_object() || !now.is_instance_of('DateTimeImmutable') {
		now.release()
		return error('clock::now() must return DateTimeImmutable')
	}
	out := now.as_object() or {
		now.release()
		return error('clock::now() must return DateTimeImmutable')
	}
	now.release()
	return out
}

pub fn psr20_clock_now_unix_or_throw(clock vphp.PhpObject) !i64 {
	mut now := psr20_clock_now_datetime_or_throw(clock)!
	defer {
		now.release()
	}
	return now.with_method_result[vphp.PhpInt, i64]('getTimestamp', fn (ts vphp.PhpInt) i64 {
		return ts.value()
	})!
}

pub fn psr20_clock_now_unix_milli_string_or_throw(clock vphp.PhpObject) !string {
	mut now := psr20_clock_now_datetime_or_throw(clock)!
	defer {
		now.release()
	}
	mut format_arg := vphp.PhpString.of('Uv')
	defer {
		format_arg.release()
	}
	formatted := now.with_method_result[vphp.PhpString, string]('format', fn (out vphp.PhpString) string {
		return out.value().trim_space()
	}, format_arg)!
	if formatted != '' {
		return formatted
	}
	return '${psr20_clock_now_unix_or_throw(clock)! * i64(1000)}'
}
