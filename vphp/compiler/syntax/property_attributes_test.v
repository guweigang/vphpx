module syntax

import v.parser
import v.pref

fn test_named_field_property() {
	mut preferences := pref.new_preferences()
	preferences.is_fmt = true
	mut reader := parser.Parser.new(preferences)
	tree := reader.parse_text('property_names.v', "
module main

import vphp

struct Properties {
mut:
	typed string @[vphp.PhpProperty(name: 'inputData')]
}
")
	mut table := Table{
		export_schemas: load_export_attribute_schemas() or { panic(err) }
	}
	file := decode_file(tree, mut table) or { panic(err) }
	decl := file.stmts[0] as StructDecl
	expected := Attr{ name: 'php_prop', arg: 'inputData', has_arg: true }
	assert find_attr(decl.fields[0].attrs, 'php_prop') or { panic('missing typed attribute') } == expected
}

fn test_property_attribute_positions_follow_the_schema() {
	schema := 'vphp.PhpDeclaredPropertyWithSetVisibility'
	fields := [
		ExportAttributeField{ name: 'php_type' },
		ExportAttributeField{ name: 'set_visibility', enum_values: ['.protected', '.private'] },
		ExportAttributeField{ name: 'name' },
	]
	attrs := decode_source_attrs([
		"alias.PhpDeclaredPropertyWithSetVisibility: 'array'",
		'alias.PhpDeclaredPropertyWithSetVisibility_1: .private',
		"alias.PhpDeclaredPropertyWithSetVisibility_name: 'example'",
		'deprecated',
	], {
		'alias': 'vphp'
	}, {
		schema: fields
	}) or { panic(err) }
	assert attrs == [
		Attr{
			name: schema
			args: {
				'php_type':       'array'
				'set_visibility': 'private'
				'name':           'example'
			}
		},
		Attr{ name: 'deprecated' },
	]
}

fn test_property_attribute_rejects_invalid_argument_binding() {
	schemas := load_export_attribute_schemas() or { panic(err) }
	schema := 'vphp.PhpDeclaredProperty'
	assert_invalid_property_attribute(["${schema}: 'id'", "${schema}_name: 'duplicate'"],
		'duplicate field `name`', schemas)
	assert_invalid_property_attribute(["${schema}: 'id'"], 'missing field `php_type`', schemas)
	assert_invalid_property_attribute(["${schema}: 'id'", "${schema}_1: 'int'", "${schema}_2: 'extra'"],
		'expects at most 2 positional arguments', schemas)
}

fn test_typed_attributes_reject_flattened_source_syntax() {
	schemas := load_export_attribute_schemas() or { panic(err) }
	for declaration, message in {
		"@[bridge.PhpProperty; bridge.PhpProperty_name: 'id']": 'separate attribute argument'
		"@[bridge.PhpProperty: 'id']":                          'colon syntax'
	} {
		validate_attribute_spelling(declaration, {
			'bridge': 'vphp'
		}, schemas) or {
			assert err.msg().contains(message)
			continue
		}
		assert false, 'accepted ' + declaration
	}
	validate_attribute_spelling("@[bridge.PhpProperty(name: 'id')]", {
		'bridge': 'vphp'
	},
		schemas) or { panic(err) }
}

fn assert_invalid_property_attribute(raw []string, expected string, schemas map[string][]ExportAttributeField) {
	decode_source_attrs(raw, {}, schemas) or {
		assert err.msg().contains(expected)
		return
	}
	assert false, 'accepted ' + raw.str()
}
