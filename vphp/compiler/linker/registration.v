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
		name := registration_name(el)
		key := registration_key(name)
		if previous := by_name[key] {
			if is_native_trait(el) || is_native_trait(types[previous]) {
				return error('duplicate exported PHP type name `${name}` (already exported as `${registration_name(types[previous])}`)')
			}
		}
		by_name[key] = i
	}
	mut state := []RegistrationState{len: types.len}
	mut ordered := []repr.PhpRepr{cap: types.len}
	for i in 0 .. types.len {
		visit_registration(i, types, by_name, mut state, mut ordered)!
	}
	return ordered
}

fn is_native_trait(el repr.PhpRepr) bool {
	return el is repr.PhpClassRepr && el.is_native_trait
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
	for dependency in registration_dependencies(el) {
		if local := by_name[registration_key(dependency)] {
			visit_registration(local, types, by_name, mut state, mut ordered)!
		}
	}
	state[index] = .registered
	ordered << el
}

fn registration_dependencies(el repr.PhpRepr) []string {
	return match el {
		repr.PhpInterfaceRepr {
			el.extends
		}
		repr.PhpClassRepr {
			[el.parent, ...el.internal_implements, ...el.native_trait_uses]
		}
		repr.PhpEnumRepr {
			el.interfaces
		}
		else {
			[]string{}
		}
	}
}

pub fn link_type_versions(mut elements []repr.PhpRepr) !map[string]int {
	mut types := []repr.PhpRepr{}
	mut has_type_gate := false
	for el in elements {
		match el {
			repr.PhpClassRepr {
				if el.is_trait && !el.is_native_trait {
					continue
				}
				has_type_gate = has_type_gate || el.min_php_version > 0
			}
			repr.PhpEnumRepr, repr.PhpInterfaceRepr {
				has_type_gate = has_type_gate || type_version(el) > 0
			}
			else { continue }
		}
		types << el
	}
	if !has_type_gate {
		return map[string]int{}
	}
	mut versions := map[string]int{}
	for el in registration_order(types)! {
		mut version := type_version(el)
		for dependency in registration_dependencies(el) {
			required := versions[registration_key(dependency)]
			if required > version {
				version = required
			}
		}
		versions[registration_key(registration_name(el))] = version
	}
	for i, element in elements {
		mut el := element
		version := versions[registration_key(registration_name(el))]
		match mut el {
			repr.PhpClassRepr {
				el.min_php_version = version
				gate_case_aliases(mut el.constants, versions)
			}
			repr.PhpInterfaceRepr {
				el.min_php_version = version
				gate_case_aliases(mut el.constants, versions)
			}
			repr.PhpEnumRepr {
				el.min_php_version = version
				gate_case_aliases(mut el.constants, versions)
			}
			else { continue }
		}
		elements[i] = el
	}
	return versions
}

fn type_version(el repr.PhpRepr) int {
	return match el {
		repr.PhpClassRepr { el.min_php_version }
		repr.PhpInterfaceRepr { el.min_php_version }
		repr.PhpEnumRepr { el.min_php_version }
		else { 0 }
	}
}

fn gate_case_aliases(mut constants []repr.PhpClassConstRepr, versions map[string]int) {
	for i, constant in constants {
		if alias := constant.enum_alias {
			version := versions[registration_key(alias.php_enum)]
			if version > constant.min_php_version {
				constants[i] = repr.PhpClassConstRepr{
					...constant
					min_php_version: version
				}
			}
		}
	}
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
