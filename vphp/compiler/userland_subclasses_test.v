module compiler

import compiler.repr

fn test_userland_subclasses_allow_autoloaded_parents_and_order_local_classes() {
	child := repr.PhpClassRepr{
		php_name:          'Bridge\\ChildMethods'
		is_native_trait:   true
		userland_subclass: repr.PhpUserlandSubclassRepr{ name: 'Bridge\\Child', parent: 'Bridge\\Base' }
	}
	base := repr.PhpClassRepr{
		php_name:          'Bridge\\BaseMethods'
		is_native_trait:   true
		min_php_version:   80500
		userland_subclass: repr.PhpUserlandSubclassRepr{ name: 'Bridge\\Base', parent: 'Vendor\\External' }
	}
	classes := collect_userland_subclasses([repr.PhpRepr(child), repr.PhpRepr(base)], {}) or {
		panic(err)
	}
	assert classes.map(it.name) == ['Bridge\\Base', 'Bridge\\Child']
	assert classes.map(it.min_version) == [80500, 80500]
	mut c := new([])
	c.userland_subclasses = classes
	assert c.userland_class_declarations().contains('class Child extends \\Bridge\\Base')
	assert c.userland_class_declarations().contains('use \\Bridge\\ChildMethods;')
}

fn test_userland_subclass_rejects_duplicate_php_names() {
	trait := repr.PhpClassRepr{
		php_name:          'Methods'
		is_native_trait:   true
		userland_subclass: repr.PhpUserlandSubclassRepr{ name: 'Duplicate', parent: 'Other' }
	}
	collect_userland_subclasses([repr.PhpRepr(trait), repr.PhpRepr(repr.PhpClassRepr{
		php_name: 'duplicate'
	})], {}) or {
		assert err.msg().contains('duplicate exported PHP type name')
		return
	}
	assert false, 'accepted a generated declaration whose name already exists in the extension'
}
