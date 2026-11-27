module vphp

// PhpDateTimeImmutable wraps a native PHP DateTimeImmutable, including subclasses.
pub struct PhpDateTimeImmutable {
	PhpObject
}

pub fn PhpDateTimeImmutable.invalid() PhpDateTimeImmutable {
	return PhpDateTimeImmutable{ PhpObject: PhpObject.invalid() }
}

pub fn PhpDateTimeImmutable.from_zval(z ZVal) ?PhpDateTimeImmutable {
	if !z.is_object() || !z.is_instance_of('DateTimeImmutable') {
		return none
	}
	return PhpDateTimeImmutable{ PhpObject: PhpObject.borrowed(z) }
}

pub fn PhpDateTimeImmutable.must_from_zval(z ZVal) !PhpDateTimeImmutable {
	return PhpDateTimeImmutable.from_zval(z) or { error('zval is not a PHP DateTimeImmutable') }
}

// parse returns an owned instance using PHP's date parser and timezone rules.
pub fn PhpDateTimeImmutable.parse(text string) !PhpDateTimeImmutable {
	mut input := PhpString.of(text)
	defer {
		input.release()
	}
	return PhpDateTimeImmutable{ PhpObject: PhpClass.named('DateTimeImmutable').construct(input)! }
}

pub fn PhpDateTimeImmutable.now() !PhpDateTimeImmutable {
	return PhpDateTimeImmutable.parse('now')
}

pub fn (date PhpDateTimeImmutable) format(pattern string) !string {
	return PhpDateTimeInterface{ PhpObject: date.PhpObject }.format(pattern)
}

pub fn (date PhpDateTimeImmutable) unix_seconds() !i64 {
	return PhpDateTimeInterface{ PhpObject: date.PhpObject }.unix_seconds()
}

// unix_milliseconds_string also covers timestamps whose milliseconds exceed i64.
pub fn (date PhpDateTimeImmutable) unix_milliseconds_string() !string {
	seconds := date.unix_seconds()!
	fraction := date.format('v')!.trim_space()
	if fraction != '' && (fraction.len != 3 || !fraction.bytes().all(it.is_digit())) {
		return error("DateTimeImmutable::format('v') must return three millisecond digits")
	}
	millis := fraction.int()
	if seconds == 0 {
		return millis.str()
	}
	if seconds > 0 || millis == 0 {
		return '${seconds}${millis:03d}'
	}
	// PHP returns a floor timestamp and a nonnegative fractional part.
	whole := -(seconds + 1)
	remainder := 1000 - millis
	return if whole == 0 { '-${remainder}' } else { '-${whole}${remainder:03d}' }
}

// add uses a PHP DateInterval and returns the new immutable date-time.
pub fn (date PhpDateTimeImmutable) add(interval PhpObject) !PhpDateTimeImmutable {
	mut result := date.call_method('add', interval)
	defer {
		result.release()
	}
	return result.as_date_time_immutable() or {
		error('DateTimeImmutable::add() did not return DateTimeImmutable')
	}
}

pub fn (date PhpDateTimeImmutable) to_borrowed() PhpDateTimeImmutable {
	return PhpDateTimeImmutable{ PhpObject: date.PhpObject.to_borrowed() }
}

pub fn (date PhpDateTimeImmutable) borrowed() PhpDateTimeImmutable {
	return date.to_borrowed()
}

pub fn (date PhpDateTimeImmutable) to_request_owned() PhpDateTimeImmutable {
	return PhpDateTimeImmutable{ PhpObject: date.PhpObject.to_request_owned() }
}

pub fn (date PhpDateTimeImmutable) owned() PhpDateTimeImmutable {
	return date.to_request_owned()
}

pub fn (date PhpDateTimeImmutable) to_persistent_owned() PhpDateTimeImmutable {
	return PhpDateTimeImmutable{ PhpObject: date.PhpObject.to_persistent_owned() }
}

pub fn (date PhpDateTimeImmutable) retain() PhpDateTimeImmutable {
	return date.to_persistent_owned()
}
