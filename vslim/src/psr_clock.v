module main

import vphp

@[php_method]
pub fn (mut clock VSlimPsr20Clock) construct() &VSlimPsr20Clock {
	return &clock
}

@[php_return_type: 'DateTimeImmutable']
@[php_method]
pub fn (clock &VSlimPsr20Clock) now() vphp.RequestOwnedZBox {
	_ = clock
	now := vphp.PhpClass.named('DateTimeImmutable').construct() or {
		vphp.PhpException.raise_class('RuntimeException', 'failed to create DateTimeImmutable instance',
			0)
		return vphp.RequestOwnedZBox.new_null()
	}
	return vphp.RequestOwnedZBox.of(now.to_zval())
}

fn new_psr20_system_clock_ref() vphp.PersistentOwnedZBox {
	clock := vphp.PhpClass.named('VSlim\\Psr20\\Clock').construct() or {
		return vphp.PersistentOwnedZBox.new_null()
	}
	return vphp.PersistentOwnedZBox.from_object_zval(clock.to_zval())
}

fn psr20_is_clock(value vphp.ZVal) bool {
	return value.is_valid() && value.is_object()
		&& (value.is_instance_of('Psr\\Clock\\ClockInterface') || value.method_exists('now'))
}

fn psr20_now_datetime_or_throw(clock vphp.ZVal) !vphp.ZVal {
	if !psr20_is_clock(clock) {
		return error('clock must implement Psr\\Clock\\ClockInterface')
	}
	mut now := vphp.PhpObject.borrowed(clock).method_request_owned('now')
	if !now.is_valid() || !now.is_object() || !now.to_zval().is_instance_of('DateTimeImmutable') {
		now.release()
		return error('clock::now() must return DateTimeImmutable')
	}
	return now.take_zval()
}

fn psr20_now_unix_or_throw(clock vphp.ZVal) !i64 {
	now := psr20_now_datetime_or_throw(clock)!
	return vphp.PhpObject.borrowed(now).with_method_result[vphp.PhpInt, i64]('getTimestamp',
		fn (ts vphp.PhpInt) i64 {
		return ts.value()
	})!
}

fn psr20_now_unix_milli_string_or_throw(clock vphp.ZVal) !string {
	now := psr20_now_datetime_or_throw(clock)!
	mut format_arg := vphp.PhpString.of('Uv')
	defer {
		format_arg.release()
	}
	formatted := vphp.PhpObject.borrowed(now).with_method_result[vphp.PhpString, string]('format',
		fn (out vphp.PhpString) string {
		return out.value().trim_space()
	}, format_arg)!
	if formatted != '' {
		return formatted
	}
	return '${psr20_now_unix_or_throw(clock)! * i64(1000)}'
}
