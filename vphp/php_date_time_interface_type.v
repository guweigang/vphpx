module vphp

// PhpDateTimeInterface wraps native PHP date-time objects, mutable or immutable.
pub struct PhpDateTimeInterface {
	PhpObject
}

pub fn PhpDateTimeInterface.from_zval(z ZVal) ?PhpDateTimeInterface {
	if !z.is_object() || !z.is_instance_of('DateTimeInterface') {
		return none
	}
	return PhpDateTimeInterface{ PhpObject: PhpObject.borrowed(z) }
}

pub fn PhpDateTimeInterface.must_from_zval(z ZVal) !PhpDateTimeInterface {
	return PhpDateTimeInterface.from_zval(z) or { error('zval does not implement PHP DateTimeInterface') }
}

pub fn (date PhpDateTimeInterface) unix_seconds() !i64 {
	return date.with_method_result[PhpInt, i64]('getTimestamp', fn (timestamp PhpInt) i64 {
		return timestamp.value()
	})
}

pub fn (date PhpDateTimeInterface) format(pattern string) !string {
	mut format := PhpString.of(pattern)
	defer {
		format.release()
	}
	return date.with_method_result[PhpString, string]('format', fn (text PhpString) string {
		return text.value()
	}, format)
}

pub fn (date PhpDateTimeInterface) to_borrowed() PhpDateTimeInterface {
	return PhpDateTimeInterface{ PhpObject: date.PhpObject.to_borrowed() }
}

pub fn (date PhpDateTimeInterface) borrowed() PhpDateTimeInterface {
	return date.to_borrowed()
}

pub fn (date PhpDateTimeInterface) to_request_owned() PhpDateTimeInterface {
	return PhpDateTimeInterface{ PhpObject: date.PhpObject.to_request_owned() }
}

pub fn (date PhpDateTimeInterface) owned() PhpDateTimeInterface {
	return date.to_request_owned()
}

pub fn (date PhpDateTimeInterface) to_persistent_owned() PhpDateTimeInterface {
	return PhpDateTimeInterface{ PhpObject: date.PhpObject.to_persistent_owned() }
}

pub fn (date PhpDateTimeInterface) retain() PhpDateTimeInterface {
	return date.to_persistent_owned()
}
