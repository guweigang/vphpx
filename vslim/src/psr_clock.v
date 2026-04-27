module main

import vphp

@[php_method]
pub fn (mut clock VSlimPsr20Clock) construct() &VSlimPsr20Clock {
	return &clock
}

@[php_method]
@[php_return_type: 'DateTimeImmutable']
pub fn (clock &VSlimPsr20Clock) now() vphp.RequestOwnedZBox {
	_ = clock
	now := vphp.PhpClass.named('DateTimeImmutable').construct([])
	if !now.is_valid() || !now.is_object() {
		vphp.PhpException.raise_class('RuntimeException', 'failed to create DateTimeImmutable instance', 0)
		return vphp.RequestOwnedZBox.new_null()
	}
	return vphp.RequestOwnedZBox.of(now)
}

fn new_psr20_system_clock_ref() vphp.PersistentOwnedZBox {
	clock := vphp.PhpClass.named('VSlim\\Psr20\\Clock').construct([])
	if !clock.is_valid() || !clock.is_object() {
		return vphp.PersistentOwnedZBox.new_null()
	}
	return vphp.PersistentOwnedZBox.from_object_zval(clock)
}

fn psr20_is_clock(value vphp.ZVal) bool {
	return value.is_valid() && value.is_object()
		&& (value.is_instance_of('Psr\\Clock\\ClockInterface') || value.method_exists('now'))
}

fn psr20_now_datetime_or_throw(clock vphp.ZVal) !vphp.ZVal {
	if !psr20_is_clock(clock) {
		return error('clock must implement Psr\\Clock\\ClockInterface')
	}
	mut now := vphp.PhpObject.borrowed(clock).method_request_owned_box('now', []vphp.ZVal{})
	if !now.is_valid() || !now.is_object() || !now.to_zval().is_instance_of('DateTimeImmutable') {
		now.release()
		return error('clock::now() must return DateTimeImmutable')
	}
	return now.take_zval()
}

fn psr20_now_unix_or_throw(clock vphp.ZVal) !i64 {
	now := psr20_now_datetime_or_throw(clock)!
	return vphp.PhpObject.borrowed(now).with_method_result_zval('getTimestamp', []vphp.ZVal{}, fn (ts vphp.ZVal) i64 {
		return ts.to_i64()
	})
}

fn psr20_now_unix_milli_string_or_throw(clock vphp.ZVal) !string {
	now := psr20_now_datetime_or_throw(clock)!
	formatted := vphp.PhpObject.borrowed(now).with_method_result_zval('format', [vphp.RequestOwnedZBox.new_string('Uv').to_zval()], fn (out vphp.ZVal) string {
		return out.to_string().trim_space()
	})
	if formatted != '' {
		return formatted
	}
	return '${psr20_now_unix_or_throw(clock)! * i64(1000)}'
}
