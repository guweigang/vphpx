module vphp

import vphp.object

// Preserve V default field initialization for generated PHP classes.
pub fn generic_new_raw[T]() voidptr {
	// SAFETY: C interop block with valid pointer arguments
	unsafe {
		ptr := &T{}
		object.register_root(ptr)
		return ptr
	}
}

// Free generated PHP class payloads through V runtime semantics.
pub fn generic_free_raw[T](ptr voidptr) {
	if ptr == 0 {
		return
	}
	object.unregister_root(ptr)
	// SAFETY: C interop block with valid pointer arguments
	unsafe {
		mut obj := &T(ptr)
		generic_release_fields[T](mut obj)
		$if nongc ? {
			object.runtime_free(ptr)
		}
	}
}

// Generated descendants use this for their embedded parents. Only the
// outermost wrapper unregisters and frees the V allocation.
pub fn generic_release_fields[T](mut obj T) {
	unsafe {
		$for field in T.fields {
			$if field.typ is PersistentOwnedZBox || field.typ is PhpValue || field.typ is PhpArray || field.typ is PhpObject || field.typ is PhpCallable || field.typ is PhpClosure || field.typ is PhpIterable || field.typ is PhpIterator || field.typ is PhpIteratorAggregate || field.typ is PhpGenerator || field.typ is PhpFiber || field.typ is PhpDateInterval || field.typ is PhpDateTimeImmutable || field.typ is PhpDateTimeInterface || field.typ is PhpJsonSerializable || field.typ is PhpStringable || field.typ is PhpCountable || field.typ is PhpArrayAccess || field.typ is PhpWeakMap || field.typ is PhpWeakReference || field.typ is PhpResource || field.typ is PhpReference || field.typ is PhpNull || field.typ is PhpBool || field.typ is PhpInt || field.typ is PhpDouble || field.typ is PhpString || field.typ is PhpScalar || field.typ is PhpThrowable || field.typ is PhpEnumCase || field.typ is RetainedObject || field.typ is RetainedCallable {
				obj.$(field.name).release()
			} $else $if field.typ is []PersistentOwnedZBox || field.typ is []PhpValue || field.typ is []PhpObject || field.typ is []RetainedObject || field.typ is []RetainedCallable {
				for mut box in obj.$(field.name) {
					box.release()
				}
				$if nongc ? {
					obj.$(field.name).free()
				}
			} $else $if field.typ is map[string]PersistentOwnedZBox || field.typ is map[string]PhpValue || field.typ is map[string]RetainedObject || field.typ is map[string]PhpObject || field.typ is map[string]RetainedCallable || field.typ is map[string]PhpCallable {
				for _, mut box in obj.$(field.name) {
					box.release()
				}
				$if nongc ? {
					obj.$(field.name).free()
				}
			}
		}
	}
}
