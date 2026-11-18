module linker

import compiler.repr
import compiler.php_types

enum RegistrationState {
	pending
	visiting
	registered
}

// registration_order places locally exported dependencies before their users.
pub fn registration_order(types []repr.PhpRepr) ![]repr.PhpRepr {
	mut by_name := map[string]int{}
	for i, el in types {
		by_name[registration_key(registration_name(el))] = i
	}
	mut state := []RegistrationState{len: types.len}
	mut ordered := []repr.PhpRepr{cap: types.len}
	for i in 0 .. types.len {
		visit_registration(i, types, by_name, mut state, mut ordered)!
	}
	return ordered
}

fn visit_registration(index int, types []repr.PhpRepr, by_name map[string]int, mut state []RegistrationState, mut ordered []repr.PhpRepr) ! {
	if state[index] == .registered {
		return
	}
	el := types[index]
	if state[index] == .visiting {
		return error('cyclic PHP type registration dependency involving `${registration_name(el)}`')
	}
	state[index] = .visiting
	dependencies := match el {
		repr.PhpInterfaceRepr {
			el.extends
		}
		repr.PhpClassRepr {
			[el.parent, ...el.internal_implements]
		}
		else {
			[]string{}
		}
	}
	for dependency in dependencies {
		if local := by_name[registration_key(dependency)] {
			visit_registration(local, types, by_name, mut state, mut ordered)!
		}
	}
	state[index] = .registered
	ordered << el
}

fn registration_name(el repr.PhpRepr) string {
	return match el {
		repr.PhpInterfaceRepr { el.php_name }
		repr.PhpClassRepr { el.php_name }
		repr.PhpEnumRepr { el.php_name }
		else { '' }
	}
}

fn registration_key(name string) string {
	return php_types.class_lookup_name(name).to_lower()
}
