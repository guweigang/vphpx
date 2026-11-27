module vphp

// PhpIteratorAggregate binds to PHP's native IteratorAggregate interface.
pub struct PhpIteratorAggregate {
	PhpObject
}

pub fn PhpIteratorAggregate.from_zval(z ZVal) ?PhpIteratorAggregate {
	if !z.is_object() || !z.is_instance_of('IteratorAggregate') {
		return none
	}
	return PhpIteratorAggregate{ PhpObject: PhpObject.borrowed(z) }
}

pub fn PhpIteratorAggregate.must_from_zval(z ZVal) !PhpIteratorAggregate {
	return PhpIteratorAggregate.from_zval(z) or {
		error('zval does not implement PHP IteratorAggregate')
	}
}

// get_iterator calls the original PHP object and returns its owned Traversable.
pub fn (aggregate PhpIteratorAggregate) get_iterator() !PhpIterator {
	mut result := aggregate.call_method('getIterator')
	defer {
		result.release()
	}
	if has_exception() {
		return error('PHP IteratorAggregate::getIterator() threw an exception')
	}
	mut owned := RequestOwnedZBox.adopt_zval(result.take_zval())
	iterator := PhpIterator.from_request_owned_zbox(owned) or {
		owned.release()
		return error('PHP IteratorAggregate::getIterator() did not return Traversable')
	}
	return iterator
}

pub fn (aggregate PhpIteratorAggregate) to_borrowed() PhpIteratorAggregate {
	return PhpIteratorAggregate{ PhpObject: aggregate.PhpObject.to_borrowed() }
}

pub fn (aggregate PhpIteratorAggregate) borrowed() PhpIteratorAggregate {
	return aggregate.to_borrowed()
}

pub fn (aggregate PhpIteratorAggregate) to_request_owned() PhpIteratorAggregate {
	return PhpIteratorAggregate{ PhpObject: aggregate.PhpObject.to_request_owned() }
}

pub fn (aggregate PhpIteratorAggregate) owned() PhpIteratorAggregate {
	return aggregate.to_request_owned()
}

pub fn (aggregate PhpIteratorAggregate) to_persistent_owned() PhpIteratorAggregate {
	return PhpIteratorAggregate{ PhpObject: aggregate.PhpObject.to_persistent_owned() }
}

pub fn (aggregate PhpIteratorAggregate) retain() PhpIteratorAggregate {
	return aggregate.to_persistent_owned()
}
