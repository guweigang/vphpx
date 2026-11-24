module php_types

import arrays

// TypeDeclaration describes an emitted PHP type independently of member order.
pub struct TypeDeclaration {
pub:
	code          string
	mask          string
	names         []string
	intersections [][]string
	nullable      bool
}

pub fn (t TypeDeclaration) equivalent(other TypeDeclaration) bool {
	return t.members() == other.members()
}

pub fn (t TypeDeclaration) has_type() bool {
	return t.code != '' || t.mask != '' || t.names.len > 0 || t.intersections.len > 0 || t.nullable
}

fn (t TypeDeclaration) members() []string {
	mut members := []string{}
	if t.nullable {
		members << 'MAY_BE_NULL'
	}
	if t.code != '' {
		members << 'MAY_BE_' + t.code.trim_string_left('_').trim_string_left('IS_')
	}
	if t.mask != '' {
		members << t.mask.split('|')
	}
	members << t.names.map('class:' + class_lookup_name(it).to_lower())
	for intersection in t.intersections {
		names := intersection.map(class_lookup_name(it).to_lower()).sorted()
		members << '(' + names.join('&') + ')'
	}
	members.sort()
	return arrays.uniq(members)
}
