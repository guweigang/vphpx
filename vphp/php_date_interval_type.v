module vphp

// PhpDateInterval wraps a native PHP DateInterval, including subclasses.
pub struct PhpDateInterval {
	PhpObject
}

pub fn PhpDateInterval.from_zval(z ZVal) ?PhpDateInterval {
	if !z.is_object() || !z.is_instance_of('DateInterval') {
		return none
	}
	return PhpDateInterval{ PhpObject: PhpObject.borrowed(z) }
}

pub fn PhpDateInterval.must_from_zval(z ZVal) !PhpDateInterval {
	return PhpDateInterval.from_zval(z) or { error('zval is not a PHP DateInterval') }
}

// parse returns an owned interval from an ISO 8601 duration.
pub fn PhpDateInterval.parse(spec string) !PhpDateInterval {
	mut input := PhpString.of(spec)
	defer {
		input.release()
	}
	return PhpDateInterval{ PhpObject: PhpClass.named('DateInterval').construct(input)! }
}

pub fn (interval PhpDateInterval) to_borrowed() PhpDateInterval {
	return PhpDateInterval{ PhpObject: interval.PhpObject.to_borrowed() }
}

pub fn (interval PhpDateInterval) borrowed() PhpDateInterval {
	return interval.to_borrowed()
}

pub fn (interval PhpDateInterval) to_request_owned() PhpDateInterval {
	return PhpDateInterval{ PhpObject: interval.PhpObject.to_request_owned() }
}

pub fn (interval PhpDateInterval) owned() PhpDateInterval {
	return interval.to_request_owned()
}

pub fn (interval PhpDateInterval) to_persistent_owned() PhpDateInterval {
	return PhpDateInterval{ PhpObject: interval.PhpObject.to_persistent_owned() }
}

pub fn (interval PhpDateInterval) retain() PhpDateInterval {
	return interval.to_persistent_owned()
}
