module builder

import compiler.php_types
import compiler.syntax as ast

fn (info ArgTypeInfo) declaration() php_types.TypeDeclaration {
	return php_types.TypeDeclaration{
		code:          info.code
		mask:          info.mask
		names:         if info.mask_obj_class == '' {
			info.named_members
		} else {
			[info.mask_obj_class]
		}
		intersections: info.intersections
		nullable:      info.allow_null
	}
}

fn (m ClassMethod) return_declaration(table &ast.Table) php_types.TypeDeclaration {
	name := if m.trait_method_name == '' { m.php_name } else { m.trait_method_name }
	if name == '__toString' {
		return php_types.TypeDeclaration{ code: 'IS_STRING' }
	}
	return m.return_spec.declaration(table)
}

fn (spec ReturnSpec) declaration(table &ast.Table) php_types.TypeDeclaration {
	raw := spec.resolved_type()
	info := arg_type_info(raw, table)
	if info.named_members.len > 0 || info.intersections.len > 0 {
		return info.declaration()
	}
	if info.mask == '' && is_class_literal_type(raw) {
		decl := parse_php_type_decl(raw)
		return php_types.TypeDeclaration{ names: [decl.clean], nullable: decl.allow_null }
	}
	class_name := spec.arginfo_obj_type()
	if class_name != '' {
		return php_types.TypeDeclaration{ names: [class_name] }
	}
	if info.code == 'IS_CALLABLE' {
		return php_types.TypeDeclaration{}
	}
	return info.declaration()
}

pub fn (b &FuncBuilder) signature_class_names() []string {
	mut declarations := []php_types.TypeDeclaration{}
	if !b.uses_context || b.return_spec.has_context_object_return() {
		declarations << b.return_spec.declaration(b.table)
	}
	if !b.uses_context {
		for arg in b.args {
			declarations << arg.declaration(b.table)
		}
	}
	mut names := []string{}
	for declaration in declarations {
		names << declaration.names
		for intersection in declaration.intersections {
			names << intersection
		}
	}
	return names
}

fn (arg ClassMethodArg) declaration(table &ast.Table) php_types.TypeDeclaration {
	raw := variadic_element_type(arg.arginfo_type(), arg.is_variadic)
	info := arg_type_info(raw, table)
	if info.mask == '' && info.named_members.len == 0 && info.intersections.len == 0
		&& is_class_literal_type(raw) {
		decl := parse_php_type_decl(raw)
		return php_types.TypeDeclaration{ names: [decl.clean], nullable: decl.allow_null }
	}
	return info.declaration()
}

pub fn (m ClassMethod) same_php_signature(other ClassMethod, table &ast.Table) bool {
	if m.uses_context != other.uses_context
		|| m.return_spec.arginfo_return_reference() != other.return_spec.arginfo_return_reference()
		|| !m.return_declaration(table).equivalent(other.return_declaration(table))
		|| m.args.len != other.args.len {
		return false
	}
	for i, arg in m.args {
		peer := other.args[i]
		if arg.is_optional != peer.is_optional || arg.is_variadic != peer.is_variadic
			|| php_types.is_reference_parameter(arg.type_, arg.is_variadic) != php_types.is_reference_parameter(peer.type_, peer.is_variadic)
			|| !arg.declaration(table).equivalent(peer.declaration(table)) {
			return false
		}
	}
	return true
}
