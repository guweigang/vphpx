module cachex

import vphp
import vphp.object

#include "php_bridge.h"

__global C.vslim__psr16__cacheexception_ce &C.zend_class_entry
__global C.vslim__psr16__invalidargumentexception_ce &C.zend_class_entry
__global C.vslim__psr16__cache_ce &C.zend_class_entry
__global C.vslim__psr6__cacheexception_ce &C.zend_class_entry
__global C.vslim__psr6__invalidargumentexception_ce &C.zend_class_entry
__global C.vslim__psr6__cacheitem_ce &C.zend_class_entry
__global C.vslim__psr6__cacheitempool_ce &C.zend_class_entry

@[export: 'vslim_psr16_cache_exception_new_raw']
pub fn vslim_psr16_cache_exception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr16CacheException]()
}
@[export: 'vslim_psr16_cache_exception_free_raw']
pub fn vslim_psr16_cache_exception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr16CacheException](ptr)
}
@[export: 'vslim_psr16_cache_exception_cleanup_raw']
pub fn vslim_psr16_cache_exception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslim_psr16_cache_exception_load_from_php(php_obj vphp.ZendObject) VSlimPsr16CacheException {
    mut recv := VSlimPsr16CacheException{}
    if !php_obj.is_valid() {
        return recv
    }
    return recv
}
fn vslim_psr16_cache_exception_sync_to_php(php_obj vphp.ZendObject, recv VSlimPsr16CacheException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'vslim_psr16_cache_exception_get_prop']
pub fn vslim_psr16_cache_exception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_psr16_cache_exception_set_prop']
pub fn vslim_psr16_cache_exception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_psr16_cache_exception_sync_props']
pub fn vslim_psr16_cache_exception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vslim_psr16_cache_exception_handlers']
pub fn vslim_psr16_cache_exception_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_psr16_cache_exception_get_prop),
        write_handler: voidptr(vslim_psr16_cache_exception_set_prop),
        sync_handler: voidptr(vslim_psr16_cache_exception_sync_props),
        new_raw: voidptr(vslim_psr16_cache_exception_new_raw),
        cleanup_raw: voidptr(vslim_psr16_cache_exception_cleanup_raw),
        free_raw: voidptr(vslim_psr16_cache_exception_free_raw)
    )
}
pub fn VSlimPsr16CacheException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr16__cacheexception_ce)
}

pub fn VSlimPsr16CacheException.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_psr16_cache_exception_handlers())
}

pub fn VSlimPsr16CacheException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr16CacheException](v_ptr, ownership)
}

pub fn (obj &VSlimPsr16CacheException) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr16CacheException](obj)
}

pub fn (obj &VSlimPsr16CacheException) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr16CacheException](obj)
}

pub fn (obj &VSlimPsr16CacheException) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr16CacheException](obj)
}

pub fn (obj &VSlimPsr16CacheException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr16CacheException](obj)
}

pub fn (val VSlimPsr16CacheException) php_class_name() string {
    return 'VSlim\\Psr16\\CacheException'
}

@[export: 'vslim_psr16_invalid_argument_exception_new_raw']
pub fn vslim_psr16_invalid_argument_exception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr16InvalidArgumentException]()
}
@[export: 'vslim_psr16_invalid_argument_exception_free_raw']
pub fn vslim_psr16_invalid_argument_exception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr16InvalidArgumentException](ptr)
}
@[export: 'vslim_psr16_invalid_argument_exception_cleanup_raw']
pub fn vslim_psr16_invalid_argument_exception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslim_psr16_invalid_argument_exception_load_from_php(php_obj vphp.ZendObject) VSlimPsr16InvalidArgumentException {
    mut recv := VSlimPsr16InvalidArgumentException{}
    if !php_obj.is_valid() {
        return recv
    }
    return recv
}
fn vslim_psr16_invalid_argument_exception_sync_to_php(php_obj vphp.ZendObject, recv VSlimPsr16InvalidArgumentException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'vslim_psr16_invalid_argument_exception_get_prop']
pub fn vslim_psr16_invalid_argument_exception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_psr16_invalid_argument_exception_set_prop']
pub fn vslim_psr16_invalid_argument_exception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_psr16_invalid_argument_exception_sync_props']
pub fn vslim_psr16_invalid_argument_exception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vslim_psr16_invalid_argument_exception_handlers']
pub fn vslim_psr16_invalid_argument_exception_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_psr16_invalid_argument_exception_get_prop),
        write_handler: voidptr(vslim_psr16_invalid_argument_exception_set_prop),
        sync_handler: voidptr(vslim_psr16_invalid_argument_exception_sync_props),
        new_raw: voidptr(vslim_psr16_invalid_argument_exception_new_raw),
        cleanup_raw: voidptr(vslim_psr16_invalid_argument_exception_cleanup_raw),
        free_raw: voidptr(vslim_psr16_invalid_argument_exception_free_raw)
    )
}
pub fn VSlimPsr16InvalidArgumentException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr16__invalidargumentexception_ce)
}

pub fn VSlimPsr16InvalidArgumentException.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_psr16_invalid_argument_exception_handlers())
}

pub fn VSlimPsr16InvalidArgumentException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr16InvalidArgumentException](v_ptr, ownership)
}

pub fn (obj &VSlimPsr16InvalidArgumentException) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr16InvalidArgumentException](obj)
}

pub fn (obj &VSlimPsr16InvalidArgumentException) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr16InvalidArgumentException](obj)
}

pub fn (obj &VSlimPsr16InvalidArgumentException) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr16InvalidArgumentException](obj)
}

pub fn (obj &VSlimPsr16InvalidArgumentException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr16InvalidArgumentException](obj)
}

pub fn (val VSlimPsr16InvalidArgumentException) php_class_name() string {
    return 'VSlim\\Psr16\\InvalidArgumentException'
}

@[export: 'vslim_psr16_cache_new_raw']
pub fn vslim_psr16_cache_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr16Cache]()
}
@[export: 'vslim_psr16_cache_free_raw']
pub fn vslim_psr16_cache_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr16Cache](ptr)
}
@[export: 'vslim_psr16_cache_cleanup_raw']
pub fn vslim_psr16_cache_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimPsr16Cache(ptr)
        obj.free()
    }
}
@[export: 'vslim_psr16_cache_get_prop']
pub fn vslim_psr16_cache_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_psr16_cache_set_prop']
pub fn vslim_psr16_cache_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_psr16_cache_sync_props']
pub fn vslim_psr16_cache_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_psr16_cache_construct']
pub fn vphp_wrap_vslim_psr16_cache_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr16_cache_set_namespace']
pub fn vphp_wrap_vslim_psr16_cache_set_namespace(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'prefix').as_v[string]()
    res := recv.set_namespace(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr16_cache_namespace']
pub fn vphp_wrap_vslim_psr16_cache_namespace(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.namespace()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_psr16_cache_set_default_ttl_seconds']
pub fn vphp_wrap_vslim_psr16_cache_set_default_ttl_seconds(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'seconds', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'seconds').as_v[int]()
    res := recv.set_default_ttl_seconds(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr16_cache_default_ttl_seconds_value']
pub fn vphp_wrap_vslim_psr16_cache_default_ttl_seconds_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.default_ttl_seconds_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_psr16_cache_set_clock']
pub fn vphp_wrap_vslim_psr16_cache_set_clock(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'clock', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'clock').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.set_clock(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr16_cache_clock']
pub fn vphp_wrap_vslim_psr16_cache_clock(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clock()
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'vphp_wrap_vslim_psr16_cache_get']
pub fn vphp_wrap_vslim_psr16_cache_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'defaultValue') { ?vphp.PhpValue(php_args.at_named_or_index(1, 'defaultValue').value) } else { none }
    res := recv.get(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_psr16_cache_set']
pub fn vphp_wrap_vslim_psr16_cache_set(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'ttl', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').value
    arg_2 := if php_args.has_named_or_index(2, 'ttl') { ?vphp.PhpValue(php_args.at_named_or_index(2, 'ttl').value) } else { none }
    res := recv.set(arg_0, arg_1, arg_2)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_psr16_cache_delete']
pub fn vphp_wrap_vslim_psr16_cache_delete(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.delete(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_psr16_cache_clear']
pub fn vphp_wrap_vslim_psr16_cache_clear(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_psr16_cache_get_multiple']
pub fn vphp_wrap_vslim_psr16_cache_get_multiple(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'keys', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'keys').iterable() or {
        vphp.throw_exception('argument 0 must be iterable', 0)
        return
    }
    arg_1 := if php_args.has_named_or_index(1, 'defaultValue') { ?vphp.PhpValue(php_args.at_named_or_index(1, 'defaultValue').value) } else { none }
    res := recv.get_multiple(arg_0, arg_1)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_psr16_cache_set_multiple']
pub fn vphp_wrap_vslim_psr16_cache_set_multiple(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'values', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'ttl', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'values').iterable() or {
        vphp.throw_exception('argument 0 must be iterable', 0)
        return
    }
    arg_1 := if php_args.has_named_or_index(1, 'ttl') { ?vphp.PhpValue(php_args.at_named_or_index(1, 'ttl').value) } else { none }
    res := recv.set_multiple(arg_0, arg_1)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_psr16_cache_delete_multiple']
pub fn vphp_wrap_vslim_psr16_cache_delete_multiple(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'keys', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'keys').iterable() or {
        vphp.throw_exception('argument 0 must be iterable', 0)
        return
    }
    res := recv.delete_multiple(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_psr16_cache_has']
pub fn vphp_wrap_vslim_psr16_cache_has(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr16Cache(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.has(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vslim_psr16_cache_handlers']
pub fn vslim_psr16_cache_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_psr16_cache_get_prop),
        write_handler: voidptr(vslim_psr16_cache_set_prop),
        sync_handler: voidptr(vslim_psr16_cache_sync_props),
        new_raw: voidptr(vslim_psr16_cache_new_raw),
        cleanup_raw: voidptr(vslim_psr16_cache_cleanup_raw),
        free_raw: voidptr(vslim_psr16_cache_free_raw)
    )
}
pub fn VSlimPsr16Cache.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr16__cache_ce)
}

pub fn VSlimPsr16Cache.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_psr16_cache_handlers())
}

pub fn VSlimPsr16Cache.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr16Cache](v_ptr, ownership)
}

pub fn (obj &VSlimPsr16Cache) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr16Cache](obj)
}

pub fn (obj &VSlimPsr16Cache) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr16Cache](obj)
}

pub fn (obj &VSlimPsr16Cache) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr16Cache](obj)
}

pub fn (obj &VSlimPsr16Cache) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr16Cache](obj)
}

pub fn (val VSlimPsr16Cache) php_class_name() string {
    return 'VSlim\\Psr16\\Cache'
}

@[export: 'vslim_psr6_cache_exception_new_raw']
pub fn vslim_psr6_cache_exception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr6CacheException]()
}
@[export: 'vslim_psr6_cache_exception_free_raw']
pub fn vslim_psr6_cache_exception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr6CacheException](ptr)
}
@[export: 'vslim_psr6_cache_exception_cleanup_raw']
pub fn vslim_psr6_cache_exception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslim_psr6_cache_exception_load_from_php(php_obj vphp.ZendObject) VSlimPsr6CacheException {
    mut recv := VSlimPsr6CacheException{}
    if !php_obj.is_valid() {
        return recv
    }
    return recv
}
fn vslim_psr6_cache_exception_sync_to_php(php_obj vphp.ZendObject, recv VSlimPsr6CacheException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'vslim_psr6_cache_exception_get_prop']
pub fn vslim_psr6_cache_exception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_psr6_cache_exception_set_prop']
pub fn vslim_psr6_cache_exception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_psr6_cache_exception_sync_props']
pub fn vslim_psr6_cache_exception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vslim_psr6_cache_exception_handlers']
pub fn vslim_psr6_cache_exception_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_psr6_cache_exception_get_prop),
        write_handler: voidptr(vslim_psr6_cache_exception_set_prop),
        sync_handler: voidptr(vslim_psr6_cache_exception_sync_props),
        new_raw: voidptr(vslim_psr6_cache_exception_new_raw),
        cleanup_raw: voidptr(vslim_psr6_cache_exception_cleanup_raw),
        free_raw: voidptr(vslim_psr6_cache_exception_free_raw)
    )
}
pub fn VSlimPsr6CacheException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr6__cacheexception_ce)
}

pub fn VSlimPsr6CacheException.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_psr6_cache_exception_handlers())
}

pub fn VSlimPsr6CacheException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr6CacheException](v_ptr, ownership)
}

pub fn (obj &VSlimPsr6CacheException) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr6CacheException](obj)
}

pub fn (obj &VSlimPsr6CacheException) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr6CacheException](obj)
}

pub fn (obj &VSlimPsr6CacheException) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr6CacheException](obj)
}

pub fn (obj &VSlimPsr6CacheException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr6CacheException](obj)
}

pub fn (val VSlimPsr6CacheException) php_class_name() string {
    return 'VSlim\\Psr6\\CacheException'
}

@[export: 'vslim_psr6_invalid_argument_exception_new_raw']
pub fn vslim_psr6_invalid_argument_exception_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr6InvalidArgumentException]()
}
@[export: 'vslim_psr6_invalid_argument_exception_free_raw']
pub fn vslim_psr6_invalid_argument_exception_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr6InvalidArgumentException](ptr)
}
@[export: 'vslim_psr6_invalid_argument_exception_cleanup_raw']
pub fn vslim_psr6_invalid_argument_exception_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
fn vslim_psr6_invalid_argument_exception_load_from_php(php_obj vphp.ZendObject) VSlimPsr6InvalidArgumentException {
    mut recv := VSlimPsr6InvalidArgumentException{}
    if !php_obj.is_valid() {
        return recv
    }
    return recv
}
fn vslim_psr6_invalid_argument_exception_sync_to_php(php_obj vphp.ZendObject, recv VSlimPsr6InvalidArgumentException) {
    if !php_obj.is_valid() {
        return
    }
}
@[export: 'vslim_psr6_invalid_argument_exception_get_prop']
pub fn vslim_psr6_invalid_argument_exception_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_psr6_invalid_argument_exception_set_prop']
pub fn vslim_psr6_invalid_argument_exception_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_psr6_invalid_argument_exception_sync_props']
pub fn vslim_psr6_invalid_argument_exception_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vslim_psr6_invalid_argument_exception_handlers']
pub fn vslim_psr6_invalid_argument_exception_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_psr6_invalid_argument_exception_get_prop),
        write_handler: voidptr(vslim_psr6_invalid_argument_exception_set_prop),
        sync_handler: voidptr(vslim_psr6_invalid_argument_exception_sync_props),
        new_raw: voidptr(vslim_psr6_invalid_argument_exception_new_raw),
        cleanup_raw: voidptr(vslim_psr6_invalid_argument_exception_cleanup_raw),
        free_raw: voidptr(vslim_psr6_invalid_argument_exception_free_raw)
    )
}
pub fn VSlimPsr6InvalidArgumentException.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr6__invalidargumentexception_ce)
}

pub fn VSlimPsr6InvalidArgumentException.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_psr6_invalid_argument_exception_handlers())
}

pub fn VSlimPsr6InvalidArgumentException.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr6InvalidArgumentException](v_ptr, ownership)
}

pub fn (obj &VSlimPsr6InvalidArgumentException) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr6InvalidArgumentException](obj)
}

pub fn (obj &VSlimPsr6InvalidArgumentException) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr6InvalidArgumentException](obj)
}

pub fn (obj &VSlimPsr6InvalidArgumentException) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr6InvalidArgumentException](obj)
}

pub fn (obj &VSlimPsr6InvalidArgumentException) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr6InvalidArgumentException](obj)
}

pub fn (val VSlimPsr6InvalidArgumentException) php_class_name() string {
    return 'VSlim\\Psr6\\InvalidArgumentException'
}

@[export: 'vslim_psr6_cache_item_new_raw']
pub fn vslim_psr6_cache_item_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr6CacheItem]()
}
@[export: 'vslim_psr6_cache_item_free_raw']
pub fn vslim_psr6_cache_item_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr6CacheItem](ptr)
}
@[export: 'vslim_psr6_cache_item_cleanup_raw']
pub fn vslim_psr6_cache_item_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimPsr6CacheItem(ptr)
        obj.free()
    }
}
@[export: 'vslim_psr6_cache_item_get_prop']
pub fn vslim_psr6_cache_item_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_psr6_cache_item_set_prop']
pub fn vslim_psr6_cache_item_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_psr6_cache_item_sync_props']
pub fn vslim_psr6_cache_item_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_get_key']
pub fn vphp_wrap_vslim_psr6_cache_item_get_key(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItem(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get_key()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_get']
pub fn vphp_wrap_vslim_psr6_cache_item_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItem(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.get()
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_is_hit']
pub fn vphp_wrap_vslim_psr6_cache_item_is_hit(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItem(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.is_hit()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_set']
pub fn vphp_wrap_vslim_psr6_cache_item_set(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr6CacheItem(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'value').value
    res := recv.set(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_expires_at']
pub fn vphp_wrap_vslim_psr6_cache_item_expires_at(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr6CacheItem(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'expiration', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'expiration').value
    res := recv.expires_at(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_expires_after']
pub fn vphp_wrap_vslim_psr6_cache_item_expires_after(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr6CacheItem(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'timeValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'timeValue').value
    res := recv.expires_after(arg_0)
    return voidptr(res)
}
@[export: 'vslim_psr6_cache_item_handlers']
pub fn vslim_psr6_cache_item_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_psr6_cache_item_get_prop),
        write_handler: voidptr(vslim_psr6_cache_item_set_prop),
        sync_handler: voidptr(vslim_psr6_cache_item_sync_props),
        new_raw: voidptr(vslim_psr6_cache_item_new_raw),
        cleanup_raw: voidptr(vslim_psr6_cache_item_cleanup_raw),
        free_raw: voidptr(vslim_psr6_cache_item_free_raw)
    )
}
pub fn VSlimPsr6CacheItem.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr6__cacheitem_ce)
}

pub fn VSlimPsr6CacheItem.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_psr6_cache_item_handlers())
}

pub fn VSlimPsr6CacheItem.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr6CacheItem](v_ptr, ownership)
}

pub fn (obj &VSlimPsr6CacheItem) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr6CacheItem](obj)
}

pub fn (obj &VSlimPsr6CacheItem) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr6CacheItem](obj)
}

pub fn (obj &VSlimPsr6CacheItem) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr6CacheItem](obj)
}

pub fn (obj &VSlimPsr6CacheItem) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr6CacheItem](obj)
}

pub fn (val VSlimPsr6CacheItem) php_class_name() string {
    return 'VSlim\\Psr6\\CacheItem'
}

@[export: 'vslim_psr6_cache_item_pool_new_raw']
pub fn vslim_psr6_cache_item_pool_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPsr6CacheItemPool]()
}
@[export: 'vslim_psr6_cache_item_pool_free_raw']
pub fn vslim_psr6_cache_item_pool_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPsr6CacheItemPool](ptr)
}
@[export: 'vslim_psr6_cache_item_pool_cleanup_raw']
pub fn vslim_psr6_cache_item_pool_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimPsr6CacheItemPool(ptr)
        obj.free()
    }
}
@[export: 'vslim_psr6_cache_item_pool_get_prop']
pub fn vslim_psr6_cache_item_pool_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_psr6_cache_item_pool_set_prop']
pub fn vslim_psr6_cache_item_pool_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_psr6_cache_item_pool_sync_props']
pub fn vslim_psr6_cache_item_pool_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_construct']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_set_namespace']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_set_namespace(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'prefix').as_v[string]()
    res := recv.set_namespace(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_namespace']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_namespace(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.namespace()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_set_default_ttl_seconds']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_set_default_ttl_seconds(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'seconds', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'seconds').as_v[int]()
    res := recv.set_default_ttl_seconds(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_default_ttl_seconds_value']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_default_ttl_seconds_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.default_ttl_seconds_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_set_clock']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_set_clock(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'clock', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'clock').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.set_clock(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_clock']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_clock(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clock()
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_get_item']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_get_item(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.get_item(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_get_items']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_get_items(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'keys', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'keys').value
    res := recv.get_items(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_has_item']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_has_item(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.has_item(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_clear']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_clear(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_delete_item']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_delete_item(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.delete_item(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_delete_items']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_delete_items(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'keys', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'keys').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    res := recv.delete_items(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_save']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_save(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'item', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'item').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    res := recv.save(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_save_deferred']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_save_deferred(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'item', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'item').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    res := recv.save_deferred(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_psr6_cache_item_pool_commit']
pub fn vphp_wrap_vslim_psr6_cache_item_pool_commit(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPsr6CacheItemPool(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.commit()
    ctx.return().v[bool](res)
}
@[export: 'vslim_psr6_cache_item_pool_handlers']
pub fn vslim_psr6_cache_item_pool_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_psr6_cache_item_pool_get_prop),
        write_handler: voidptr(vslim_psr6_cache_item_pool_set_prop),
        sync_handler: voidptr(vslim_psr6_cache_item_pool_sync_props),
        new_raw: voidptr(vslim_psr6_cache_item_pool_new_raw),
        cleanup_raw: voidptr(vslim_psr6_cache_item_pool_cleanup_raw),
        free_raw: voidptr(vslim_psr6_cache_item_pool_free_raw)
    )
}
pub fn VSlimPsr6CacheItemPool.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__psr6__cacheitempool_ce)
}

pub fn VSlimPsr6CacheItemPool.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_psr6_cache_item_pool_handlers())
}

pub fn VSlimPsr6CacheItemPool.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPsr6CacheItemPool](v_ptr, ownership)
}

pub fn (obj &VSlimPsr6CacheItemPool) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPsr6CacheItemPool](obj)
}

pub fn (obj &VSlimPsr6CacheItemPool) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPsr6CacheItemPool](obj)
}

pub fn (obj &VSlimPsr6CacheItemPool) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPsr6CacheItemPool](obj)
}

pub fn (obj &VSlimPsr6CacheItemPool) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPsr6CacheItemPool](obj)
}

pub fn (val VSlimPsr6CacheItemPool) php_class_name() string {
    return 'VSlim\\Psr6\\CacheItemPool'
}

