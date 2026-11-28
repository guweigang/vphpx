module vphp

pub fn (v PhpValueZBox) with_request_zval[T](run fn (ZVal) T) T {
	match v.kind {
		.borrowed {
			z := (v.request_borrowed or { RequestBorrowedZBox.from_zval(invalid_zval()) }).to_zval()
			return run(z)
		}
		.request_owned {
			z := (v.request_owned or { RequestOwnedZBox.adopt_zval(invalid_zval()) }).to_zval()
			return run(z)
		}
		.persistent_owned {
			mut temp :=
				(v.persistent_owned or { PersistentOwnedZBox.new_null() }).clone_request_owned()
			defer {
				temp.release()
			}
			z := temp.to_zval()
			return run(z)
		}
	}
}

pub fn (v PhpValueZBox) with_request_value[T](run fn (PhpValue) T) T {
	match v.kind {
		.borrowed {
			z := (v.request_borrowed or { RequestBorrowedZBox.from_zval(invalid_zval()) }).to_zval()
			return run(PhpValue.from_zval(z))
		}
		.request_owned {
			z := (v.request_owned or { RequestOwnedZBox.adopt_zval(invalid_zval()) }).to_zval()
			return run(PhpValue.from_zval(z))
		}
		.persistent_owned {
			mut temp := (v.persistent_owned or { PersistentOwnedZBox.new_null() }).clone_request_owned()
			defer { temp.release() }
			return run(PhpValue.from_zval(temp.to_zval()))
		}
	}
}

pub fn (v PhpValueZBox) with_request_array[T](run fn (PhpArray) T) ?T {
	match v.kind {
		.borrowed {
			arr := PhpArray.from_zval((v.request_borrowed or {
				RequestBorrowedZBox.from_zval(invalid_zval())
			}).to_zval()) or { return none }
			return run(arr)
		}
		.request_owned {
			arr := PhpArray.from_zval((v.request_owned or {
				RequestOwnedZBox.adopt_zval(invalid_zval())
			}).to_zval()) or { return none }
			return run(arr)
		}
		.persistent_owned {
			mut temp :=
				(v.persistent_owned or { PersistentOwnedZBox.new_null() }).clone_request_owned()
			defer {
				temp.release()
			}
			arr := PhpArray.from_zval(temp.to_zval()) or { return none }
			return run(arr)
		}
	}
}

pub fn (v PhpValueZBox) with_request_object[T](run fn (PhpObject) T) ?T {
	match v.kind {
		.borrowed {
			obj := PhpObject.from_zval((v.request_borrowed or {
				RequestBorrowedZBox.from_zval(invalid_zval())
			}).to_zval()) or { return none }
			return run(obj)
		}
		.request_owned {
			obj := PhpObject.from_zval((v.request_owned or {
				RequestOwnedZBox.adopt_zval(invalid_zval())
			}).to_zval()) or { return none }
			return run(obj)
		}
		.persistent_owned {
			mut temp :=
				(v.persistent_owned or { PersistentOwnedZBox.new_null() }).clone_request_owned()
			defer {
				temp.release()
			}
			obj := PhpObject.from_zval(temp.to_zval()) or { return none }
			return run(obj)
		}
	}
}

pub fn (v PhpValueZBox) with_request_callable[T](run fn (PhpCallable) T) ?T {
	match v.kind {
		.borrowed {
			callable := PhpCallable.from_zval((v.request_borrowed or {
				RequestBorrowedZBox.from_zval(invalid_zval())
			}).to_zval()) or { return none }
			return run(callable)
		}
		.request_owned {
			callable := PhpCallable.from_zval((v.request_owned or {
				RequestOwnedZBox.adopt_zval(invalid_zval())
			}).to_zval()) or { return none }
			return run(callable)
		}
		.persistent_owned {
			mut temp :=
				(v.persistent_owned or { PersistentOwnedZBox.new_null() }).clone_request_owned()
			defer {
				temp.release()
			}
			callable := PhpCallable.from_zval(temp.to_zval()) or { return none }
			return run(callable)
		}
	}
}
