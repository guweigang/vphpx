module linker

import compiler.repr
import compiler.builder
import strconv

pub type NativeTraitSignaturesMatch = fn (&repr.PhpClassRepr, &repr.PhpMethodRepr, &repr.PhpMethodRepr) bool

pub fn link_native_trait_uses(mut elements []repr.PhpRepr, signatures_match NativeTraitSignaturesMatch) ! {
	mut indices := map[string]int{}
	mut names_by_type := map[string]string{}
	for index, element in elements {
		if element is repr.PhpClassRepr {
			if !element.is_native_trait {
				continue
			}
			indices[registration_key(element.php_name)] = index
			names_by_type[native_trait_type_key(element)] = element.php_name
		}
	}
	mut traits := []repr.PhpRepr{cap: indices.len}
	for element in elements {
		if element is repr.PhpClassRepr && element.is_native_trait {
			mut trait := repr.PhpClassRepr{
				...element
				native_trait_uses: element.native_trait_uses.clone()
			}
			for v_type in trait.native_trait_use_types {
				php_name := names_by_type[v_type] or {
					return error('PHP trait ${trait.php_name}: `${v_type}` must be a native trait exported by this extension')
				}
				trait.native_trait_uses << php_name
			}
			traits << trait
		}
	}
	for entry in registration_order(traits)! {
		mut owner := match entry {
			repr.PhpClassRepr { entry }
			else { return error('unexpected registration type for native trait') }
		}
		mut uses := []string{}
		mut directly_used := map[string]repr.PhpClassRepr{}
		mut direct_types := map[string]string{}
		for name in owner.native_trait_uses {
			key := registration_key(name)
			index := indices[key] or {
				return error('PHP trait ${owner.php_name}: `${name}` must be a native trait exported by this extension')
			}
			source_entry := elements[index]
			source := match source_entry {
				repr.PhpClassRepr { source_entry }
				else { return error('invalid native trait registration: ${name}') }
			}
			if key !in directly_used {
				directly_used[key] = source
				direct_types[native_trait_type_key(source)] = key
				uses << source.php_name
			}
		}
		owner.native_trait_uses = uses
		for name in uses {
			compose_native_trait_storage(mut owner, directly_used[registration_key(name)])!
		}
		compose_native_trait_method_versions(mut owner, directly_used, direct_types,
			signatures_match)!
		elements[indices[registration_key(owner.php_name)]] = owner
	}
}

fn native_trait_type_key(trait repr.PhpClassRepr) string {
	return '${trait.module_name}.${trait.name}'
}

fn compose_native_trait_storage(mut owner repr.PhpClassRepr, source repr.PhpClassRepr) ! {
	for constant in source.constants {
		compose_native_trait_constant(mut owner, source.php_name, constant)!
	}
	for property in source.properties {
		index := owner.properties.map(it.name).index(property.name)
		if index < 0 {
			owner.properties << property
		} else {
			current := owner.properties[index]
			if !native_trait_property_types_match(current, property)
				|| current.visibility != property.visibility || current.is_static != property.is_static
				|| current.is_mut != property.is_mut || current.is_final != property.is_final
				|| current.set_visibility != property.set_visibility
				|| !native_trait_property_defaults_match(current, property) {
				return error('PHP trait ${owner.php_name}: incompatible property ${source.php_name}::${property.name}')
			}
			if property.min_php_version < current.min_php_version {
				owner.properties[index] = repr.PhpClassPropRepr{
					...current
					min_php_version: property.min_php_version
				}
			}
		}
	}
}

fn trait_method_is_available(method repr.PhpMethodRepr, version int) bool {
	return version >= method.min_php_version
		&& (method.max_php_version_exclusive == 0 || version < method.max_php_version_exclusive)
}

fn compose_native_trait_method_versions(mut owner repr.PhpClassRepr, sources map[string]repr.PhpClassRepr, direct_types map[string]string, signatures_match NativeTraitSignaturesMatch) ! {
	own_methods := owner.methods.clone()
	mut boundaries := [0]
	mut methods := own_methods.clone()
	for source in sources.values() {
		methods << source.methods
	}
	for method in methods {
		for boundary in [method.min_php_version, method.max_php_version_exclusive] {
			if boundary !in boundaries {
				boundaries << boundary
			}
		}
	}
	boundaries.sort()
	for index, start in boundaries {
		end := if index + 1 < boundaries.len { boundaries[index + 1] } else { 0 }
		mut effective := repr.PhpClassRepr{
			...owner
			methods:                  own_methods.filter(trait_method_is_available(it, start))
			native_trait_aliases:     []
			native_trait_precedences: []
		}
		exclusions := bind_native_trait_precedences(mut effective, sources, direct_types,
			start)!
		aliases := resolve_native_trait_aliases(mut effective, sources, direct_types, start)!
		mut originals := map[string]repr.PhpTraitAlias{}
		for alias in effective.native_trait_aliases {
			if alias.alias == '' {
				originals[trait_method_key(alias.trait_name, alias.method)] = alias
			}
			owner.native_trait_aliases << repr.PhpTraitAlias{
				...alias
				min_php_version:           start
				max_php_version_exclusive: end
			}
		}
		for precedence in effective.native_trait_precedences {
			owner.native_trait_precedences << repr.PhpTraitPrecedence{
				...precedence
				min_php_version:           start
				max_php_version_exclusive: end
			}
		}
		for name in owner.native_trait_uses {
			key := registration_key(name)
			source := sources[key]
			for method in source.methods {
				if !trait_method_is_available(method, start)
					|| key in exclusions[method.php_name().to_lower()] {
					continue
				}
				adaptation := originals[trait_method_key(source.php_name, method.php_name())]
				borrowed := borrow_native_trait_method(source, method, adaptation,
					method.native_trait_alias)
				compose_native_trait_method(mut effective, source.php_name, borrowed,
					signatures_match)!
			}
		}
		for alias in aliases {
			compose_native_trait_method(mut effective, alias.source, alias.method,
				signatures_match)!
		}
		for method in effective.methods {
			if method.native_trait_source != '' {
				owner.methods << repr.PhpMethodRepr{
					...method
					min_php_version:           start
					max_php_version_exclusive: end
				}
			}
		}
	}
}

fn compose_native_trait_constant(mut owner repr.PhpClassRepr, source string, incoming repr.PhpClassConstRepr) ! {
	mut existing := owner.constants.filter(it.name == incoming.name)
	existing.sort(a.min_php_version < b.min_php_version)
	mut start := incoming.min_php_version
	end := constant_version_end(incoming)
	for current in existing {
		current_end := constant_version_end(current)
		if current_end <= start || current.min_php_version >= end {
			continue
		}
		if current.visibility != incoming.visibility || current.is_final != incoming.is_final
			|| !native_trait_constants_match(current, incoming) {
			return error('PHP trait ${owner.php_name}: incompatible constant ${source}::${incoming.name}')
		}
		// When both declarations are available, keep the existing metadata.
		if start < current.min_php_version {
			owner.constants << repr.PhpClassConstRepr{
				...incoming
				min_php_version:           start
				max_php_version_exclusive: current.min_php_version
			}
		}
		start = current_end
	}
	if start < end {
		owner.constants << repr.PhpClassConstRepr{
			...incoming
			min_php_version: start
		}
	}
}

fn constant_version_end(constant repr.PhpClassConstRepr) int {
	return if constant.max_php_version_exclusive > 0 {
		constant.max_php_version_exclusive
	} else {
		max_int
	}
}

fn native_trait_constants_match(left repr.PhpClassConstRepr, right repr.PhpClassConstRepr) bool {
	left_type := builder.class_constant_type(left.const_type, left.enum_alias)
	right_type := builder.class_constant_type(right.const_type, right.enum_alias)
	if !left_type.equivalent(right_type) {
		return false
	}
	if left_alias := left.enum_alias {
		right_alias := right.enum_alias or { return false }
		return left_alias.case_name == right_alias.case_name
	}
	return left.value == right.value
		|| (left_type.code == 'IS_DOUBLE' && float_literals_match(left.value, right.value))
}

fn native_trait_property_types_match(left repr.PhpClassPropRepr, right repr.PhpClassPropRepr) bool {
	left_type := builder.resolve_property_type(left.declaration_type(), left.is_property_only)
	right_type := builder.resolve_property_type(right.declaration_type(), right.is_property_only)
	if (!left_type.is_typed() && left_type.code == '') || (!right_type.is_typed()
		&& right_type.code == '') {
		return left.declaration_type() == right.declaration_type()
	}
	left_decl := left_type.declaration(left.explicit_mixed || left.set_visibility != none
		|| left.abstract_get || left.abstract_set)
	right_decl := right_type.declaration(right.explicit_mixed || right.set_visibility != none
		|| right.abstract_get || right.abstract_set)
	return left_decl.equivalent(right_decl)
}

fn native_trait_property_defaults_match(left repr.PhpClassPropRepr, right repr.PhpClassPropRepr) bool {
	if left.default_value == right.default_value {
		return true
	}
	left_default := left.default_value or { return false }
	right_default := right.default_value or { return false }
	left_value := builder.resolve_property_type(left.declaration_type(), left.is_property_only).normalize_default(left_default)
	right_value := builder.resolve_property_type(right.declaration_type(), right.is_property_only).normalize_default(right_default)
	if left_value.kind != 'float' || right_value.kind != 'float' {
		return false
	}
	return float_literals_match(left_value.value, right_value.value)
}

fn float_literals_match(left string, right string) bool {
	left_float := strconv.atof64(left) or { return false }
	right_float := strconv.atof64(right) or { return false }
	return left_float == right_float
}

fn borrow_native_trait_method(source repr.PhpClassRepr, method repr.PhpMethodRepr, adaptation repr.PhpTraitAlias, name string) repr.PhpMethodRepr {
	return repr.PhpMethodRepr{
		...method
		native_trait_source:     if method.native_trait_source != '' {
			method.native_trait_source
		} else {
			source.c_name()
		}
		native_trait_alias:      name
		visibility:              if adaptation.visibility == '' {
			method.visibility
		} else {
			adaptation.visibility
		}
		has_explicit_visibility: method.has_explicit_visibility || adaptation.visibility != ''
		is_trait_final:          method.is_trait_final || adaptation.is_final
		args:                    method.args.clone()
	}
}

fn bind_native_trait_precedences(mut owner repr.PhpClassRepr, directly_used map[string]repr.PhpClassRepr, direct_types map[string]string, version int) !map[string][]string {
	mut exclusions := map[string][]string{}
	for spec in owner.native_trait_precedence_specs {
		source_key := direct_types[spec.source_v_type] or {
			return error('PHP trait ${owner.php_name}: precedence source `${spec.source_v_type}` must refer to a directly used trait')
		}
		source := directly_used[source_key]
		method_key := spec.method.to_lower()
		qualified_method := '${source.php_name}::${spec.method}'
		methods := source.methods.filter(it.php_name().to_lower() == method_key)
		if methods.len == 0 {
			return error('PHP trait ${owner.php_name}: unknown method `${qualified_method}` in precedence rule')
		}
		active := methods.filter(trait_method_is_available(it, version))
		if active.len == 0 {
			continue
		}
		mut excluded_traits := []string{}
		for v_type in spec.excluded_v_types {
			excluded_key := direct_types[v_type] or {
				return error('PHP trait ${owner.php_name}: excluded trait `${v_type}` must be directly used')
			}
			excluded := directly_used[excluded_key]
			if excluded_key == source_key {
				return error('PHP trait ${owner.php_name}: precedence rule for `${qualified_method}` excludes its selected trait')
			}
			if excluded_key in exclusions[method_key] {
				return error('PHP trait ${owner.php_name}: precedence rules exclude ${excluded.php_name} more than once for ${active[0].php_name()}')
			}
			exclusions[method_key] << excluded_key
			excluded_traits << excluded.php_name
		}
		owner.native_trait_precedences << repr.PhpTraitPrecedence{
			trait_name:      source.php_name
			method:          active[0].php_name()
			excluded_traits: excluded_traits
		}
	}
	return exclusions
}

struct NativeTraitAliasBinding {
	source string
	method repr.PhpMethodRepr
}

fn trait_method_key(trait_name string, method string) string {
	return '${registration_key(trait_name)}::${method.to_lower()}'
}

fn native_trait_alias_specs(owner repr.PhpClassRepr, directly_used map[string]repr.PhpClassRepr, direct_types map[string]string) ![]repr.PhpTraitAlias {
	mut specs := []repr.PhpTraitAlias{}
	for entry in owner.native_trait_alias_spec.split(',') {
		words := entry.fields()
		if words.len == 0 {
			continue
		}
		if words.len !in [3, 4] || words[1].to_lower() != 'as' || !words[0].contains('::') {
			return error('PHP trait ${owner.php_name}: expected Trait::method as alias or Trait::method as visibility [alias]')
		}
		modifier := words[2].to_lower()
		visibility := if modifier in ['public', 'protected', 'private'] { modifier } else { '' }
		if words.len == 4 && visibility == '' {
			return error('PHP trait ${owner.php_name}: method alias visibility must be public, protected or private')
		}
		specs << repr.PhpTraitAlias{
			trait_name: words[0].all_before_last('::')
			method:     words[0].all_after_last('::')
			alias:      if words.len == 4 {
				words[3]
			} else if visibility == '' {
				words[2]
			} else {
				''
			}
			visibility: visibility
		}
	}
	for adaptation in owner.native_trait_adaptations {
		key := direct_types[adaptation.source_v_type] or {
			return error('PHP trait ${owner.php_name}: `${adaptation.source_v_type}` must refer to a directly used native trait')
		}
		specs << repr.PhpTraitAlias{ ...adaptation.rule, trait_name: directly_used[key].php_name }
	}
	return specs
}

fn resolve_native_trait_aliases(mut owner repr.PhpClassRepr, directly_used map[string]repr.PhpClassRepr, direct_types map[string]string, version int) ![]NativeTraitAliasBinding {
	mut aliases := map[string]bool{}
	mut originals := map[string]int{}
	mut bindings := []NativeTraitAliasBinding{}
	for spec in native_trait_alias_specs(owner, directly_used, direct_types)! {
		source := directly_used[registration_key(spec.trait_name)] or {
			return error('PHP trait ${owner.php_name}: alias for `${spec.trait_name}::${spec.method}` must refer to a directly used trait')
		}
		method_key := spec.method.to_lower()
		methods := source.methods.filter(it.php_name().to_lower() == method_key)
		if methods.len == 0 {
			return error('PHP trait ${owner.php_name}: unknown method `${spec.trait_name}::${spec.method}` in alias')
		}
		active := methods.filter(trait_method_is_available(it, version))
		if active.len == 0 {
			continue
		}
		method := active[0]
		if spec.is_final && method.is_abstract {
			return error('PHP trait ${owner.php_name}: abstract method `${spec.trait_name}::${spec.method}` cannot be adapted as final')
		}
		adaptation := repr.PhpTraitAlias{
			...spec
			trait_name: source.php_name
			method:     method.php_name()
		}
		name := spec.alias
		if name != '' {
			if !valid_trait_method_alias(name) || (spec.visibility == ''
				&& name.to_lower() in ['final', 'public', 'protected', 'private']) {
				return error('PHP trait ${owner.php_name}: invalid method alias name `${name}`')
			}
			if name.to_lower() in aliases {
				return error('PHP trait ${owner.php_name}: duplicate method alias `${name}`')
			}
			aliases[name.to_lower()] = true
			bindings << NativeTraitAliasBinding{source.php_name, borrow_native_trait_method(source,
				method, adaptation, name)}
		} else {
			key := trait_method_key(source.php_name, method.php_name())
			if previous := originals[key] {
				owner.native_trait_aliases[previous] = adaptation
				continue
			}
			originals[key] = owner.native_trait_aliases.len
		}
		owner.native_trait_aliases << adaptation
	}
	return bindings
}

fn valid_trait_method_alias(name string) bool {
	return name != '' && !name[0].is_digit()
		&& name.bytes().all(it.is_alnum() || it == `_` || it >= 128)
}

fn compose_native_trait_method(mut owner repr.PhpClassRepr, source string, method repr.PhpMethodRepr, signatures_match NativeTraitSignaturesMatch) ! {
	key := method.php_name().to_lower()
	for index, current in owner.methods {
		if current.php_name().to_lower() != key {
			continue
		}
		if current.is_abstract || method.is_abstract {
			if !signatures_match(&owner, &current, &method) {
				return error('PHP trait ${owner.php_name}: incompatible abstract requirement for ${source}::${method.name}')
			}
			if current.is_abstract && current.native_trait_source != '' && !method.is_abstract {
				owner.methods[index] = method
			}
		} else if current.native_trait_source != '' && (current.handler_symbol('') != method.handler_symbol('')
			|| current.visibility != method.visibility) {
			return error('PHP trait ${owner.php_name}: conflicting method ${source}::${method.name}')
		}
		return
	}
	owner.methods << method
}
