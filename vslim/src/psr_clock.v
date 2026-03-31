module main

import vphp

@[php_method]
pub fn (mut clock VSlimPsr20Clock) construct() &VSlimPsr20Clock {
	return &clock
}

@[php_method]
@[php_return_type: 'DateTimeImmutable']
pub fn (clock &VSlimPsr20Clock) now() vphp.Value {
	_ = clock
	now := vphp.php_class('DateTimeImmutable').construct([])
	if !now.is_valid() || !now.is_object() {
		vphp.throw_exception_class('RuntimeException', 'failed to create DateTimeImmutable instance', 0)
		return vphp.Value.new_null()
	}
	return vphp.Value.from_zval(now)
}

fn new_psr20_system_clock_ref() vphp.PersistentOwnedZVal {
	clock := vphp.php_class('VSlim\\Psr20\\Clock').construct([])
	if !clock.is_valid() || !clock.is_object() {
		return vphp.PersistentOwnedZVal.new_null()
	}
	return vphp.PersistentOwnedZVal.from_zval(clock)
}

fn psr20_is_clock(value vphp.ZVal) bool {
	return value.is_valid() && value.is_object()
		&& (value.is_instance_of('Psr\\Clock\\ClockInterface') || value.method_exists('now'))
}

fn psr20_now_datetime_or_throw(clock vphp.ZVal) !vphp.ZVal {
	if !psr20_is_clock(clock) {
		return error('clock must implement Psr\\Clock\\ClockInterface')
	}
	now := clock.method_owned_request('now', [])
	if !now.is_valid() || !now.is_object() || !now.is_instance_of('DateTimeImmutable') {
		return error('clock::now() must return DateTimeImmutable')
	}
	return now
}

fn psr20_now_unix_or_throw(clock vphp.ZVal) !i64 {
	now := psr20_now_datetime_or_throw(clock)!
	return now.method_owned_request('getTimestamp', []).to_i64()
}

fn psr20_now_unix_milli_string_or_throw(clock vphp.ZVal) !string {
	now := psr20_now_datetime_or_throw(clock)!
	formatted := now.method_owned_request('format', [vphp.RequestOwnedZVal.new_string('Uv').to_zval()]).to_string().trim_space()
	if formatted != '' {
		return formatted
	}
	return '${psr20_now_unix_or_throw(clock)! * i64(1000)}'
}
