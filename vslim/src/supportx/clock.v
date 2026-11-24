module supportx

import vphp

pub const service_clock = 'clock'
pub const service_psr_clock = 'Psr\\Clock\\ClockInterface'

@[vphp.PhpExternalInterface(name: 'Psr\\Clock\\ClockInterface')]
pub interface PsrClockContract {}

pub type PsrClock = vphp.PhpInterface[PsrClockContract]

@[vphp.PhpImplements(names: 'Psr\\Clock\\ClockInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr20\\Clock')]
@[heap]
pub struct VSlimPsr20Clock {}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut clock VSlimPsr20Clock) construct() &VSlimPsr20Clock {
	return &clock
}

@[vphp.PhpExportMethod(name: '')]
pub fn (clock &VSlimPsr20Clock) now() vphp.PhpDateTimeImmutable {
	_ = clock
	return vphp.PhpDateTimeImmutable.now() or {
		if !vphp.has_exception() {
			vphp.PhpException.raise_class('RuntimeException',
				'failed to create DateTimeImmutable instance', 0)
		}
		vphp.PhpDateTimeImmutable.invalid()
	}
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

pub fn psr20_clock_now_datetime_or_throw(clock vphp.PhpObject) !vphp.PhpDateTimeImmutable {
	if !psr20_clock_is_valid(clock) {
		return error('clock must implement Psr\\Clock\\ClockInterface')
	}
	mut now := clock.call_method('now')
	defer {
		now.release()
	}
	return now.as_date_time_immutable() or { error('clock::now() must return DateTimeImmutable') }
}

pub fn psr20_clock_now_unix_or_throw(clock vphp.PhpObject) !i64 {
	mut now := psr20_clock_now_datetime_or_throw(clock)!
	defer {
		now.release()
	}
	return now.unix_seconds()
}

pub fn psr20_clock_now_unix_milli_string_or_throw(clock vphp.PhpObject) !string {
	mut now := psr20_clock_now_datetime_or_throw(clock)!
	defer {
		now.release()
	}
	return now.unix_milliseconds_string()
}
