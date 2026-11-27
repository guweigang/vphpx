# Semantic Runtime

`vphp.semantic` is a legacy experimental detached PHP-like runtime model for V code.

It is intentionally separate from the existing Zend export compiler:

- `module vphp` remains the Zend binding, ownership, and PHP extension export layer.
- `module vphp.semantic` models PHP values, arrays, objects, class metadata, and static properties without registering Zend symbols.
- Semantic classes do not become `zend_class_entry` values unless a future explicit bridge exposes them.

This keeps existing `@[php_function]` and `@[php_class]` compile/export behavior stable while giving gateway-style runtimes a place to reuse PHP semantics without dragging every value through request-bound zvals.

## Current Pieces

- `Value`: detached scalar, array, object, and opaque Zend leaf values.
- `Array`: ordered PHP-style mixed-key array with integer keys, string keys, numeric-string normalization, tombstones, append index tracking, and iteration.
- `ClassRegistry`: legacy pure V class metadata for parent-chain method and property checks.
- `StaticStore`: legacy semantic static-property storage.
- `ObjectLike` / `ObjectBase` / `Object`: legacy V-native object dispatch protocol for method and property access.
- `semantic_to_php_value`: explicit bridge from detached semantic scalar/array values to request-owned `PhpValue`.
- `DynValue.array_`: the root `vphp` dynamic value now has an experimental PHP-style array container for values that must cross the Zend/V ownership boundary.

## Domain Boundary

The semantic layer should not implicitly participate in existing Zend export lookup.

Use separate domains:

- Zend export domain: real PHP functions/classes registered with Zend by the existing compiler.
- Semantic runtime domain: V-owned PHP-like objects and arrays used by gateway, workers, transpiled code, or hand-written hybrid runtime code.

Future bridge APIs should be explicit, for example:

- expose a semantic class as a Zend facade
- wrap a real Zend object as a semantic proxy
- materialize a semantic value into a request-owned zval
- adopt a zval into a semantic value with a clear ownership policy

The first bridge lives in root `module vphp`:

```v
import vphp
import vphp.semantic

mut arr := semantic.Array.new()
arr.set_int(5, semantic.string_value('sparse'))
arr.set_str('name', semantic.string_value('alice'))

php_value := vphp.semantic_to_php_value(semantic.array_value(&arr))!
```

Scalar and array values materialize to request-owned `PhpValue` instances. Semantic objects and opaque Zend leaves deliberately fail until a caller chooses an explicit facade/proxy/ownership policy.

## DynValue Direction

`semantic.Value` is no longer the target shared model. It remains only as an experimental compatibility island while php2v keeps its own runtime. New vphp runtime work should use `DynValue`, because it already understands request-owned values, persistent owned boxes, retained objects/callables, and zval materialization.

`DynValue.array_` is the bridge in that direction:

- arrays are V-owned ordered PHP-style containers
- nested scalar/array data can be fully detached
- object/callable/resource leaves are explicit runtime refs
- `has_runtime_refs()` / `is_fully_detached()` are the boundary checks before persistent storage or cross-request use

This means `DynValue` does not pretend every PHP value can detach from Zend. Instead, it makes partial detachment visible: the container can be detached while individual leaves remain Zend-backed refs.

## Object Direction

Objects split into two different concepts:

- Zend-backed objects: `DynValue.object_ref(...)` / `.persistent_object_ref(...)`
- V-native semantic objects: `semantic.Object` / `semantic.ObjectValue`

Zend-backed objects are never fully detached. They can be stored only by retaining
the Zend object handle:

```v
dyn := vphp.DynValue.object_ref(obj)
stored := dyn.retain_object_ref() or { return }
```

Use `dyn.is_zend_backed()` or `dyn.has_runtime_refs()` before crossing a request
boundary. `dyn.has_request_refs()` tells you whether the graph still points at
request-borrowed Zend values. `dyn.to_request_escapable()` is the storage
conversion: it recursively retains object/callable leaves and rejects resources.
After that conversion, `dyn.can_escape_request()` is the app-level storage check.
Use `with_object(...)` when code needs a temporary request-scoped `PhpObject`
view, regardless of whether the ref is request-borrowed or retained.

V-native semantic objects are detached from Zend, but they are not PHP objects
until an explicit facade/proxy bridge exists. `semantic_to_php_value()` therefore
still refuses `semantic.ObjectValue`.

Prefer these constructors for new runtime-boundary code:

```v
value := vphp.DynValue.empty_array()
from_list := vphp.DynValue.array_from_list([vphp.DynValue.of_string('a')])
from_map := vphp.DynValue.array_from_map({
	'name': vphp.DynValue.of_string('alice')
})
```

`DynValue.of_list()` and `DynValue.of_map()` remain as legacy V-native containers for compatibility. They should not be used for new PHP array semantics.

## Class Metadata Direction

Class metadata has moved to the root `vphp` runtime sidecar:

```v
mut registry := vphp.ClassRegistry.new()
registry.register(vphp.ClassMeta{
	name:       'Dog'
	parents:    ['Animal']
	methods:    ['bark']
	properties: ['name']
})!
```

`vphp.ClassRegistry`, `vphp.StaticStore`, `vphp.VNativeObjectLike`,
`vphp.VNativeObjectBase`, and `vphp.VNativeObject` use `DynValue` instead of
`semantic.Value`.

This sidecar does not participate in compile/export automatically:

- `@[php_class]` still owns real Zend class registration
- `ClassRegistry` owns gateway/runtime metadata
- exposing a V-native class to Zend must be a future explicit facade/proxy bridge

Static values are guarded by `DynValue.to_request_escapable()`: request
object/callable leaves are retained, while resources are rejected.
