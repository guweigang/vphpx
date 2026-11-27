module linker

import compiler.repr

fn test_serializable_descendant_requires_compatible_payload_and_own_hooks() {
	hooks := [
		repr.PhpMethodRepr{ name: '__serialize', visibility: 'public' },
		repr.PhpMethodRepr{ name: '__unserialize', visibility: 'public' },
	]
	base := repr.PhpClassRepr{
		name:         'Base'
		php_name:     'Base'
		serializable: true
		methods:      hooks
	}
	child := repr.PhpClassRepr{
		name:         'Child'
		php_name:     'Child'
		parent:       'Base'
		embeds_v:     ['Base']
		serializable: true
		methods:      hooks
	}
	mut valid := [repr.PhpRepr(base), repr.PhpRepr(child)]
	link_object_copy_policies(mut valid) or { panic(err) }
	assert (valid[1] as repr.PhpClassRepr).copy_parent_embeds == ['Base']

	for i, message in [
		'requires a serializable VPHP parent',
		'must embed its V parent Base first',
		'must export a public __unserialize method',
	] {
		mut invalid_base := base
		mut invalid_child := child
		match i {
			0 { invalid_base.serializable = false }
			1 { invalid_child.embeds_v = ['Other', 'Base'] }
			else { invalid_child.methods = [hooks[0]] }
		}
		mut invalid := [repr.PhpRepr(invalid_base), repr.PhpRepr(invalid_child)]
		link_object_copy_policies(mut invalid) or {
			assert err.msg().contains(message)
			continue
		}
		assert false, 'expected serialization policy error: ${message}'
	}
}
