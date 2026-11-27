module semantic

fn test_array_normalizes_php_numeric_string_keys() {
	mut arr := Array.new()
	arr.set_str('12', string_value('twelve'))
	arr.set_str('012', string_value('leading'))
	arr.push(int_value(99))

	assert arr.get_int(12).to_string() == 'twelve'
	assert arr.get_str('12').to_string() == 'twelve'
	assert arr.get_str('012').to_string() == 'leading'
	assert arr.get_int(13).to_i64() == 99
}

fn test_array_preserves_order_and_tombstones() {
	mut arr := Array.new()
	arr.push(string_value('a'))
	arr.set_str('name', string_value('neo'))
	arr.push(string_value('b'))
	arr.delete_int(0)

	mut it := arr.iter()
	first := it.next() or { panic('expected first item') }
	second := it.next() or { panic('expected second item') }
	assert it.next() == none

	assert first.key.to_string() == 'name'
	assert first.val.to_string() == 'neo'
	assert second.key.to_i64() == 1
	assert second.val.to_string() == 'b'
	assert arr.count() == 2
}

fn test_class_registry_checks_parent_chain() {
	mut registry := ClassRegistry.new()
	registry.register(ClassMeta{
		name:       'Animal'
		methods:    ['speak']
		properties: ['name']
	})
	registry.register(ClassMeta{
		name:    'Dog'
		parents: ['Animal']
		methods: ['bark']
	})

	assert registry.has_method('Dog', 'bark')
	assert registry.has_method('Dog', 'SPEAK')
	assert registry.has_property('Dog', 'name')
	assert registry.parent_name('Dog') or { '' } == 'Animal'
	assert registry.is_subclass_of('Dog', 'Animal')
	assert !registry.is_subclass_of('Animal', 'Dog')
}

fn test_static_store_clones_values() {
	mut store := StaticStore.new()
	mut arr := Array.new()
	arr.push(string_value('original'))

	store.init_prop('Cache', 'items', array_value(&arr))
	arr.set_int(0, string_value('changed'))

	stored := store.get('Cache', 'items')
	assert stored is ArrayValue
	if stored is ArrayValue {
		assert stored.value.get_int(0).to_string() == 'original'
	}
	store.set('Cache', 'count', int_value(3))
	assert store.get('Cache', 'count').to_i64() == 3
}

fn test_object_base_property_protocol() {
	mut base := ObjectBase.new()
	mut obj := Object.new('Box', [], base)

	assert obj.set_prop('name', string_value('semantic'))
	assert obj.get_prop('name').to_string() == 'semantic'
	assert obj.get_prop('missing').is_null()
	assert obj.has_property('name')
	assert !obj.has_method('unknown')
}
