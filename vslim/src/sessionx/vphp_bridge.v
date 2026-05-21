module sessionx

import vphp

import containerx
import httpx

#include "php_bridge.h"

__global C.vslim__session__store_ce &C.zend_class_entry
__global C.vslim__auth__sessionguard_ce &C.zend_class_entry
__global C.vslim__session__startmiddleware_ce &C.zend_class_entry
__global C.vslim__auth__requireauthmiddleware_ce &C.zend_class_entry
__global C.vslim__auth__guestmiddleware_ce &C.zend_class_entry
__global C.vslim__auth__requireabilitymiddleware_ce &C.zend_class_entry

@[export: 'VSlimSessionStore_new_raw']
pub fn vslimsessionstore_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimSessionStore]()
}
@[export: 'VSlimSessionStore_free_raw']
pub fn vslimsessionstore_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimSessionStore](ptr)
}
@[export: 'VSlimSessionStore_cleanup_raw']
pub fn vslimsessionstore_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimSessionStore_get_prop']
pub fn vslimsessionstore_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimSessionStore_set_prop']
pub fn vslimsessionstore_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimSessionStore_sync_props']
pub fn vslimsessionstore_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimSessionStore_construct']
pub fn vphp_wrap_vslimsessionstore_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_set_cookie_name']
pub fn vphp_wrap_vslimsessionstore_set_cookie_name(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.set_cookie_name(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_cookie_name_value']
pub fn vphp_wrap_vslimsessionstore_cookie_name_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.cookie_name_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_set_secret']
pub fn vphp_wrap_vslimsessionstore_set_secret(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'secret', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'secret').as_v[string]()
    res := recv.set_secret(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_secret_value']
pub fn vphp_wrap_vslimsessionstore_secret_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.secret_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_set_ttl_seconds']
pub fn vphp_wrap_vslimsessionstore_set_ttl_seconds(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'ttlSeconds', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'ttlSeconds').as_v[int]()
    res := recv.set_ttl_seconds(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_ttl_seconds_value']
pub fn vphp_wrap_vslimsessionstore_ttl_seconds_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.ttl_seconds_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_set_path']
pub fn vphp_wrap_vslimsessionstore_set_path(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.set_path(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_path_value']
pub fn vphp_wrap_vslimsessionstore_path_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.path_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_set_domain']
pub fn vphp_wrap_vslimsessionstore_set_domain(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'domain', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'domain').as_v[string]()
    res := recv.set_domain(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_domain_value']
pub fn vphp_wrap_vslimsessionstore_domain_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.domain_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_set_secure']
pub fn vphp_wrap_vslimsessionstore_set_secure(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'secure', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'secure').as_v[bool]()
    res := recv.set_secure(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_secure_value']
pub fn vphp_wrap_vslimsessionstore_secure_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.secure_value()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_set_http_only']
pub fn vphp_wrap_vslimsessionstore_set_http_only(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'httpOnly', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'httpOnly').as_v[bool]()
    res := recv.set_http_only(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_http_only_value']
pub fn vphp_wrap_vslimsessionstore_http_only_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.http_only_value()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_set_same_site']
pub fn vphp_wrap_vslimsessionstore_set_same_site(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'sameSite', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'sameSite').as_v[string]()
    res := recv.set_same_site(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_same_site_value']
pub fn vphp_wrap_vslimsessionstore_same_site_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.same_site_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_load']
pub fn vphp_wrap_vslimsessionstore_load(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    res := recv.load(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_all']
pub fn vphp_wrap_vslimsessionstore_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.all()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_get']
pub fn vphp_wrap_vslimsessionstore_get(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'defaultValue') { php_args.at_named_or_index(1, 'defaultValue').as_v[string]() } else { '' }
    res := recv.get(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_pull']
pub fn vphp_wrap_vslimsessionstore_pull(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'defaultValue') { php_args.at_named_or_index(1, 'defaultValue').as_v[string]() } else { '' }
    res := recv.pull(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_flash']
pub fn vphp_wrap_vslimsessionstore_flash(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').as_v[string]()
    res := recv.flash(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_has_flash']
pub fn vphp_wrap_vslimsessionstore_has_flash(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.has_flash(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_get_flash']
pub fn vphp_wrap_vslimsessionstore_get_flash(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'defaultValue') { php_args.at_named_or_index(1, 'defaultValue').as_v[string]() } else { '' }
    res := recv.get_flash(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_pull_flash']
pub fn vphp_wrap_vslimsessionstore_pull_flash(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'defaultValue', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'defaultValue') { php_args.at_named_or_index(1, 'defaultValue').as_v[string]() } else { '' }
    res := recv.pull_flash(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_clear_flashes']
pub fn vphp_wrap_vslimsessionstore_clear_flashes(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_flashes()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_has']
pub fn vphp_wrap_vslimsessionstore_has(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.has(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_set']
pub fn vphp_wrap_vslimsessionstore_set(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'value').as_v[string]()
    res := recv.set(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_forget']
pub fn vphp_wrap_vslimsessionstore_forget(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'key', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'key').as_v[string]()
    res := recv.forget(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_clear']
pub fn vphp_wrap_vslimsessionstore_clear(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStore_destroy']
pub fn vphp_wrap_vslimsessionstore_destroy(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'response', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'response').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    res := recv.destroy(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_commit']
pub fn vphp_wrap_vslimsessionstore_commit(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'response', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'response').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    res := recv.commit(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimSessionStore_is_loaded']
pub fn vphp_wrap_vslimsessionstore_is_loaded(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.is_loaded()
    ctx.return().v[bool](res)
}
@[export: 'VSlimSessionStore_handlers']
pub fn vslimsessionstore_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimsessionstore_get_prop),
        write_handler: voidptr(vslimsessionstore_set_prop),
        sync_handler: voidptr(vslimsessionstore_sync_props),
        new_raw: voidptr(vslimsessionstore_new_raw),
        cleanup_raw: voidptr(vslimsessionstore_cleanup_raw),
        free_raw: voidptr(vslimsessionstore_free_raw)
    )
}
pub fn VSlimSessionStore.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__session__store_ce)
}

pub fn VSlimSessionStore.php_object_handlers() voidptr {
    return vslimsessionstore_handlers()
}

pub fn VSlimSessionStore.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimSessionStore](v_ptr, ownership)
}

pub fn (obj &VSlimSessionStore) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimSessionStore](obj)
}

pub fn (obj &VSlimSessionStore) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimSessionStore](obj)
}

pub fn (obj &VSlimSessionStore) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimSessionStore](obj)
}

pub fn (obj &VSlimSessionStore) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimSessionStore](obj)
}

@[export: 'VSlimAuthSessionGuard_new_raw']
pub fn vslimauthsessionguard_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimAuthSessionGuard]()
}
@[export: 'VSlimAuthSessionGuard_free_raw']
pub fn vslimauthsessionguard_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimAuthSessionGuard](ptr)
}
@[export: 'VSlimAuthSessionGuard_cleanup_raw']
pub fn vslimauthsessionguard_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimAuthSessionGuard_get_prop']
pub fn vslimauthsessionguard_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimAuthSessionGuard_set_prop']
pub fn vslimauthsessionguard_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimAuthSessionGuard_sync_props']
pub fn vslimauthsessionguard_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimAuthSessionGuard_construct']
pub fn vphp_wrap_vslimauthsessionguard_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthSessionGuard_set_store']
pub fn vphp_wrap_vslimauthsessionguard_set_store(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'store', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &sessionx.VSlimSessionStore(php_args.at_named_or_index(0, 'store').raw_obj()) }
    res := recv.set_store(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthSessionGuard_store']
pub fn vphp_wrap_vslimauthsessionguard_store(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.store()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthSessionGuard_set_user_key']
pub fn vphp_wrap_vslimauthsessionguard_set_user_key(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'userKey', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'userKey').as_v[string]()
    res := recv.set_user_key(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthSessionGuard_user_key_value']
pub fn vphp_wrap_vslimauthsessionguard_user_key_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.user_key_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimAuthSessionGuard_check']
pub fn vphp_wrap_vslimauthsessionguard_check(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.check()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimAuthSessionGuard_guest']
pub fn vphp_wrap_vslimauthsessionguard_guest(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.guest()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimAuthSessionGuard_id']
pub fn vphp_wrap_vslimauthsessionguard_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.id()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimAuthSessionGuard_user_id']
pub fn vphp_wrap_vslimauthsessionguard_user_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.user_id()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimAuthSessionGuard_login']
pub fn vphp_wrap_vslimauthsessionguard_login(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'userId', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'userId').as_v[string]()
    res := recv.login(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthSessionGuard_logout']
pub fn vphp_wrap_vslimauthsessionguard_logout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.logout()
    return voidptr(res)
}
@[export: 'VSlimAuthSessionGuard_handlers']
pub fn vslimauthsessionguard_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimauthsessionguard_get_prop),
        write_handler: voidptr(vslimauthsessionguard_set_prop),
        sync_handler: voidptr(vslimauthsessionguard_sync_props),
        new_raw: voidptr(vslimauthsessionguard_new_raw),
        cleanup_raw: voidptr(vslimauthsessionguard_cleanup_raw),
        free_raw: voidptr(vslimauthsessionguard_free_raw)
    )
}
pub fn VSlimAuthSessionGuard.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__auth__sessionguard_ce)
}

pub fn VSlimAuthSessionGuard.php_object_handlers() voidptr {
    return vslimauthsessionguard_handlers()
}

pub fn VSlimAuthSessionGuard.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimAuthSessionGuard](v_ptr, ownership)
}

pub fn (obj &VSlimAuthSessionGuard) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimAuthSessionGuard](obj)
}

pub fn (obj &VSlimAuthSessionGuard) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimAuthSessionGuard](obj)
}

pub fn (obj &VSlimAuthSessionGuard) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimAuthSessionGuard](obj)
}

pub fn (obj &VSlimAuthSessionGuard) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimAuthSessionGuard](obj)
}

@[export: 'VSlimSessionStartMiddleware_new_raw']
pub fn vslimsessionstartmiddleware_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimSessionStartMiddleware]()
}
@[export: 'VSlimSessionStartMiddleware_free_raw']
pub fn vslimsessionstartmiddleware_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimSessionStartMiddleware](ptr)
}
@[export: 'VSlimSessionStartMiddleware_cleanup_raw']
pub fn vslimsessionstartmiddleware_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimSessionStartMiddleware_get_prop']
pub fn vslimsessionstartmiddleware_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimSessionStartMiddleware_set_prop']
pub fn vslimsessionstartmiddleware_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimSessionStartMiddleware_sync_props']
pub fn vslimsessionstartmiddleware_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimSessionStartMiddleware_construct']
pub fn vphp_wrap_vslimsessionstartmiddleware_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStartMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStartMiddleware_set_container']
pub fn vphp_wrap_vslimsessionstartmiddleware_set_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStartMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'container', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &containerx.VSlimContainer(php_args.at_named_or_index(0, 'container').raw_obj()) }
    res := recv.set_container(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStartMiddleware_set_app']
pub fn vphp_wrap_vslimsessionstartmiddleware_set_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStartMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'app', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'app').value
    res := recv.set_app(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimSessionStartMiddleware_process']
pub fn vphp_wrap_vslimsessionstartmiddleware_process(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStartMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    arg_1 := php_args.at_named_or_index(1, 'handler').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return unsafe { nil }
    }
    res := recv.process(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'VSlimSessionStartMiddleware_handlers']
pub fn vslimsessionstartmiddleware_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimsessionstartmiddleware_get_prop),
        write_handler: voidptr(vslimsessionstartmiddleware_set_prop),
        sync_handler: voidptr(vslimsessionstartmiddleware_sync_props),
        new_raw: voidptr(vslimsessionstartmiddleware_new_raw),
        cleanup_raw: voidptr(vslimsessionstartmiddleware_cleanup_raw),
        free_raw: voidptr(vslimsessionstartmiddleware_free_raw)
    )
}
pub fn VSlimSessionStartMiddleware.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__session__startmiddleware_ce)
}

pub fn VSlimSessionStartMiddleware.php_object_handlers() voidptr {
    return vslimsessionstartmiddleware_handlers()
}

pub fn VSlimSessionStartMiddleware.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimSessionStartMiddleware](v_ptr, ownership)
}

pub fn (obj &VSlimSessionStartMiddleware) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimSessionStartMiddleware](obj)
}

pub fn (obj &VSlimSessionStartMiddleware) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimSessionStartMiddleware](obj)
}

pub fn (obj &VSlimSessionStartMiddleware) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimSessionStartMiddleware](obj)
}

pub fn (obj &VSlimSessionStartMiddleware) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimSessionStartMiddleware](obj)
}

@[export: 'VSlimAuthRequireMiddleware_new_raw']
pub fn vslimauthrequiremiddleware_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimAuthRequireMiddleware]()
}
@[export: 'VSlimAuthRequireMiddleware_free_raw']
pub fn vslimauthrequiremiddleware_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimAuthRequireMiddleware](ptr)
}
@[export: 'VSlimAuthRequireMiddleware_cleanup_raw']
pub fn vslimauthrequiremiddleware_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimAuthRequireMiddleware_get_prop']
pub fn vslimauthrequiremiddleware_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimAuthRequireMiddleware_set_prop']
pub fn vslimauthrequiremiddleware_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimAuthRequireMiddleware_sync_props']
pub fn vslimauthrequiremiddleware_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimAuthRequireMiddleware_construct']
pub fn vphp_wrap_vslimauthrequiremiddleware_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthRequireMiddleware_set_container']
pub fn vphp_wrap_vslimauthrequiremiddleware_set_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'container', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &containerx.VSlimContainer(php_args.at_named_or_index(0, 'container').raw_obj()) }
    res := recv.set_container(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthRequireMiddleware_set_app']
pub fn vphp_wrap_vslimauthrequiremiddleware_set_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'app', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'app').value
    res := recv.set_app(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthRequireMiddleware_set_redirect_path']
pub fn vphp_wrap_vslimauthrequiremiddleware_set_redirect_path(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'redirectPath', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'redirectPath').as_v[string]()
    res := recv.set_redirect_path(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthRequireMiddleware_redirect_path_value']
pub fn vphp_wrap_vslimauthrequiremiddleware_redirect_path_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthRequireMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.redirect_path_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimAuthRequireMiddleware_process']
pub fn vphp_wrap_vslimauthrequiremiddleware_process(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    arg_1 := php_args.at_named_or_index(1, 'handler').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return unsafe { nil }
    }
    res := recv.process(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'VSlimAuthRequireMiddleware_handlers']
pub fn vslimauthrequiremiddleware_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimauthrequiremiddleware_get_prop),
        write_handler: voidptr(vslimauthrequiremiddleware_set_prop),
        sync_handler: voidptr(vslimauthrequiremiddleware_sync_props),
        new_raw: voidptr(vslimauthrequiremiddleware_new_raw),
        cleanup_raw: voidptr(vslimauthrequiremiddleware_cleanup_raw),
        free_raw: voidptr(vslimauthrequiremiddleware_free_raw)
    )
}
pub fn VSlimAuthRequireMiddleware.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__auth__requireauthmiddleware_ce)
}

pub fn VSlimAuthRequireMiddleware.php_object_handlers() voidptr {
    return vslimauthrequiremiddleware_handlers()
}

pub fn VSlimAuthRequireMiddleware.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimAuthRequireMiddleware](v_ptr, ownership)
}

pub fn (obj &VSlimAuthRequireMiddleware) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimAuthRequireMiddleware](obj)
}

pub fn (obj &VSlimAuthRequireMiddleware) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimAuthRequireMiddleware](obj)
}

pub fn (obj &VSlimAuthRequireMiddleware) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimAuthRequireMiddleware](obj)
}

pub fn (obj &VSlimAuthRequireMiddleware) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimAuthRequireMiddleware](obj)
}

@[export: 'VSlimAuthGuestMiddleware_new_raw']
pub fn vslimauthguestmiddleware_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimAuthGuestMiddleware]()
}
@[export: 'VSlimAuthGuestMiddleware_free_raw']
pub fn vslimauthguestmiddleware_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimAuthGuestMiddleware](ptr)
}
@[export: 'VSlimAuthGuestMiddleware_cleanup_raw']
pub fn vslimauthguestmiddleware_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimAuthGuestMiddleware_get_prop']
pub fn vslimauthguestmiddleware_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimAuthGuestMiddleware_set_prop']
pub fn vslimauthguestmiddleware_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimAuthGuestMiddleware_sync_props']
pub fn vslimauthguestmiddleware_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimAuthGuestMiddleware_construct']
pub fn vphp_wrap_vslimauthguestmiddleware_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthGuestMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthGuestMiddleware_set_container']
pub fn vphp_wrap_vslimauthguestmiddleware_set_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthGuestMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'container', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &containerx.VSlimContainer(php_args.at_named_or_index(0, 'container').raw_obj()) }
    res := recv.set_container(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthGuestMiddleware_set_app']
pub fn vphp_wrap_vslimauthguestmiddleware_set_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthGuestMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'app', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'app').value
    res := recv.set_app(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthGuestMiddleware_set_redirect_path']
pub fn vphp_wrap_vslimauthguestmiddleware_set_redirect_path(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthGuestMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'redirectPath', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'redirectPath').as_v[string]()
    res := recv.set_redirect_path(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthGuestMiddleware_redirect_path_value']
pub fn vphp_wrap_vslimauthguestmiddleware_redirect_path_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthGuestMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.redirect_path_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimAuthGuestMiddleware_process']
pub fn vphp_wrap_vslimauthguestmiddleware_process(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthGuestMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    arg_1 := php_args.at_named_or_index(1, 'handler').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return unsafe { nil }
    }
    res := recv.process(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'VSlimAuthGuestMiddleware_handlers']
pub fn vslimauthguestmiddleware_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimauthguestmiddleware_get_prop),
        write_handler: voidptr(vslimauthguestmiddleware_set_prop),
        sync_handler: voidptr(vslimauthguestmiddleware_sync_props),
        new_raw: voidptr(vslimauthguestmiddleware_new_raw),
        cleanup_raw: voidptr(vslimauthguestmiddleware_cleanup_raw),
        free_raw: voidptr(vslimauthguestmiddleware_free_raw)
    )
}
pub fn VSlimAuthGuestMiddleware.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__auth__guestmiddleware_ce)
}

pub fn VSlimAuthGuestMiddleware.php_object_handlers() voidptr {
    return vslimauthguestmiddleware_handlers()
}

pub fn VSlimAuthGuestMiddleware.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimAuthGuestMiddleware](v_ptr, ownership)
}

pub fn (obj &VSlimAuthGuestMiddleware) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimAuthGuestMiddleware](obj)
}

pub fn (obj &VSlimAuthGuestMiddleware) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimAuthGuestMiddleware](obj)
}

pub fn (obj &VSlimAuthGuestMiddleware) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimAuthGuestMiddleware](obj)
}

pub fn (obj &VSlimAuthGuestMiddleware) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimAuthGuestMiddleware](obj)
}

@[export: 'VSlimAuthRequireAbilityMiddleware_new_raw']
pub fn vslimauthrequireabilitymiddleware_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimAuthRequireAbilityMiddleware]()
}
@[export: 'VSlimAuthRequireAbilityMiddleware_free_raw']
pub fn vslimauthrequireabilitymiddleware_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimAuthRequireAbilityMiddleware](ptr)
}
@[export: 'VSlimAuthRequireAbilityMiddleware_cleanup_raw']
pub fn vslimauthrequireabilitymiddleware_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimAuthRequireAbilityMiddleware_get_prop']
pub fn vslimauthrequireabilitymiddleware_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimAuthRequireAbilityMiddleware_set_prop']
pub fn vslimauthrequireabilitymiddleware_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimAuthRequireAbilityMiddleware_sync_props']
pub fn vslimauthrequireabilitymiddleware_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimAuthRequireAbilityMiddleware_construct']
pub fn vphp_wrap_vslimauthrequireabilitymiddleware_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthRequireAbilityMiddleware_set_container']
pub fn vphp_wrap_vslimauthrequireabilitymiddleware_set_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'container', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &containerx.VSlimContainer(php_args.at_named_or_index(0, 'container').raw_obj()) }
    res := recv.set_container(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthRequireAbilityMiddleware_set_app']
pub fn vphp_wrap_vslimauthrequireabilitymiddleware_set_app(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'app', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'app').value
    res := recv.set_app(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthRequireAbilityMiddleware_set_ability']
pub fn vphp_wrap_vslimauthrequireabilitymiddleware_set_ability(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'ability', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'ability').as_v[string]()
    res := recv.set_ability(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthRequireAbilityMiddleware_ability']
pub fn vphp_wrap_vslimauthrequireabilitymiddleware_ability(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.ability()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimAuthRequireAbilityMiddleware_set_status']
pub fn vphp_wrap_vslimauthrequireabilitymiddleware_set_status(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'status', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'status').as_v[int]()
    res := recv.set_status(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthRequireAbilityMiddleware_status']
pub fn vphp_wrap_vslimauthrequireabilitymiddleware_status(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.status()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_VSlimAuthRequireAbilityMiddleware_set_message']
pub fn vphp_wrap_vslimauthrequireabilitymiddleware_set_message(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'message').as_v[string]()
    res := recv.set_message(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimAuthRequireAbilityMiddleware_message']
pub fn vphp_wrap_vslimauthrequireabilitymiddleware_message(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.message()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimAuthRequireAbilityMiddleware_process']
pub fn vphp_wrap_vslimauthrequireabilitymiddleware_process(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return unsafe { nil }
    }
    arg_1 := php_args.at_named_or_index(1, 'handler').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return unsafe { nil }
    }
    res := recv.process(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'VSlimAuthRequireAbilityMiddleware_handlers']
pub fn vslimauthrequireabilitymiddleware_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimauthrequireabilitymiddleware_get_prop),
        write_handler: voidptr(vslimauthrequireabilitymiddleware_set_prop),
        sync_handler: voidptr(vslimauthrequireabilitymiddleware_sync_props),
        new_raw: voidptr(vslimauthrequireabilitymiddleware_new_raw),
        cleanup_raw: voidptr(vslimauthrequireabilitymiddleware_cleanup_raw),
        free_raw: voidptr(vslimauthrequireabilitymiddleware_free_raw)
    )
}
pub fn VSlimAuthRequireAbilityMiddleware.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__auth__requireabilitymiddleware_ce)
}

pub fn VSlimAuthRequireAbilityMiddleware.php_object_handlers() voidptr {
    return vslimauthrequireabilitymiddleware_handlers()
}

pub fn VSlimAuthRequireAbilityMiddleware.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimAuthRequireAbilityMiddleware](v_ptr, ownership)
}

pub fn (obj &VSlimAuthRequireAbilityMiddleware) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimAuthRequireAbilityMiddleware](obj)
}

pub fn (obj &VSlimAuthRequireAbilityMiddleware) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimAuthRequireAbilityMiddleware](obj)
}

pub fn (obj &VSlimAuthRequireAbilityMiddleware) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimAuthRequireAbilityMiddleware](obj)
}

pub fn (obj &VSlimAuthRequireAbilityMiddleware) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimAuthRequireAbilityMiddleware](obj)
}

