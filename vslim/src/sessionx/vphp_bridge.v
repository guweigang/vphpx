module sessionx

import vphp
import vphp.object

import containerx
import httpx

#include "php_bridge.h"

__global C.vslim__session__store_ce &C.zend_class_entry
__global C.vslim__auth__sessionguard_ce &C.zend_class_entry
__global C.vslim__session__startmiddleware_ce &C.zend_class_entry
__global C.vslim__auth__requireauthmiddleware_ce &C.zend_class_entry
__global C.vslim__auth__guestmiddleware_ce &C.zend_class_entry
__global C.vslim__auth__requireabilitymiddleware_ce &C.zend_class_entry

@[export: 'vslim_session_store_new_raw']
pub fn vslim_session_store_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimSessionStore]()
}
@[export: 'vslim_session_store_free_raw']
pub fn vslim_session_store_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimSessionStore](ptr)
}
@[export: 'vslim_session_store_cleanup_raw']
pub fn vslim_session_store_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_session_store_get_prop']
pub fn vslim_session_store_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_session_store_set_prop']
pub fn vslim_session_store_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_session_store_sync_props']
pub fn vslim_session_store_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_session_store_construct']
pub fn vphp_wrap_vslim_session_store_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_session_store_set_cookie_name']
pub fn vphp_wrap_vslim_session_store_set_cookie_name(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_session_store_cookie_name_value']
pub fn vphp_wrap_vslim_session_store_cookie_name_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.cookie_name_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_session_store_set_secret']
pub fn vphp_wrap_vslim_session_store_set_secret(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_session_store_secret_value']
pub fn vphp_wrap_vslim_session_store_secret_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.secret_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_session_store_set_ttl_seconds']
pub fn vphp_wrap_vslim_session_store_set_ttl_seconds(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_session_store_ttl_seconds_value']
pub fn vphp_wrap_vslim_session_store_ttl_seconds_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.ttl_seconds_value()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_session_store_set_path']
pub fn vphp_wrap_vslim_session_store_set_path(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_session_store_path_value']
pub fn vphp_wrap_vslim_session_store_path_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.path_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_session_store_set_domain']
pub fn vphp_wrap_vslim_session_store_set_domain(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_session_store_domain_value']
pub fn vphp_wrap_vslim_session_store_domain_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.domain_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_session_store_set_secure']
pub fn vphp_wrap_vslim_session_store_set_secure(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_session_store_secure_value']
pub fn vphp_wrap_vslim_session_store_secure_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.secure_value()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_session_store_set_http_only']
pub fn vphp_wrap_vslim_session_store_set_http_only(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_session_store_http_only_value']
pub fn vphp_wrap_vslim_session_store_http_only_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.http_only_value()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_session_store_set_same_site']
pub fn vphp_wrap_vslim_session_store_set_same_site(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_session_store_same_site_value']
pub fn vphp_wrap_vslim_session_store_same_site_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.same_site_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_session_store_load']
pub fn vphp_wrap_vslim_session_store_load(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.load(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_session_store_all']
pub fn vphp_wrap_vslim_session_store_all(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.all()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_vslim_session_store_get']
pub fn vphp_wrap_vslim_session_store_get(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_session_store_pull']
pub fn vphp_wrap_vslim_session_store_pull(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_session_store_flash']
pub fn vphp_wrap_vslim_session_store_flash(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_session_store_has_flash']
pub fn vphp_wrap_vslim_session_store_has_flash(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_session_store_get_flash']
pub fn vphp_wrap_vslim_session_store_get_flash(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_session_store_pull_flash']
pub fn vphp_wrap_vslim_session_store_pull_flash(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_session_store_clear_flashes']
pub fn vphp_wrap_vslim_session_store_clear_flashes(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_flashes()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_session_store_has']
pub fn vphp_wrap_vslim_session_store_has(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_session_store_set']
pub fn vphp_wrap_vslim_session_store_set(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_session_store_forget']
pub fn vphp_wrap_vslim_session_store_forget(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_session_store_clear']
pub fn vphp_wrap_vslim_session_store_clear(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_session_store_destroy']
pub fn vphp_wrap_vslim_session_store_destroy(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_session_store_commit']
pub fn vphp_wrap_vslim_session_store_commit(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_session_store_is_loaded']
pub fn vphp_wrap_vslim_session_store_is_loaded(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimSessionStore(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.is_loaded()
    ctx.return().v[bool](res)
}
@[export: 'vslim_session_store_handlers']
pub fn vslim_session_store_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_session_store_get_prop),
        write_handler: voidptr(vslim_session_store_set_prop),
        sync_handler: voidptr(vslim_session_store_sync_props),
        new_raw: voidptr(vslim_session_store_new_raw),
        cleanup_raw: voidptr(vslim_session_store_cleanup_raw),
        free_raw: voidptr(vslim_session_store_free_raw)
    )
}
pub fn VSlimSessionStore.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__session__store_ce)
}

pub fn VSlimSessionStore.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_session_store_handlers())
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

pub fn (val VSlimSessionStore) php_class_name() string {
    return 'VSlim\\Session\\Store'
}

@[export: 'vslim_auth_session_guard_new_raw']
pub fn vslim_auth_session_guard_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimAuthSessionGuard]()
}
@[export: 'vslim_auth_session_guard_free_raw']
pub fn vslim_auth_session_guard_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimAuthSessionGuard](ptr)
}
@[export: 'vslim_auth_session_guard_cleanup_raw']
pub fn vslim_auth_session_guard_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_auth_session_guard_get_prop']
pub fn vslim_auth_session_guard_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_auth_session_guard_set_prop']
pub fn vslim_auth_session_guard_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_auth_session_guard_sync_props']
pub fn vslim_auth_session_guard_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_auth_session_guard_construct']
pub fn vphp_wrap_vslim_auth_session_guard_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_auth_session_guard_set_store']
pub fn vphp_wrap_vslim_auth_session_guard_set_store(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'store', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'store').to_v_ptr[sessionx.VSlimSessionStore]() or {
        vphp.throw_exception('argument 0 must be object bound to sessionx.VSlimSessionStore, got ' + php_args.at_named_or_index(0, 'store').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &sessionx.VSlimSessionStore(arg_0_ptr) }
    res := recv.set_store(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_auth_session_guard_store']
pub fn vphp_wrap_vslim_auth_session_guard_store(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.store()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_auth_session_guard_set_user_key']
pub fn vphp_wrap_vslim_auth_session_guard_set_user_key(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_auth_session_guard_user_key_value']
pub fn vphp_wrap_vslim_auth_session_guard_user_key_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.user_key_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_auth_session_guard_check']
pub fn vphp_wrap_vslim_auth_session_guard_check(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.check()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_auth_session_guard_guest']
pub fn vphp_wrap_vslim_auth_session_guard_guest(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.guest()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_auth_session_guard_id']
pub fn vphp_wrap_vslim_auth_session_guard_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.id()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_auth_session_guard_user_id']
pub fn vphp_wrap_vslim_auth_session_guard_user_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.user_id()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_auth_session_guard_login']
pub fn vphp_wrap_vslim_auth_session_guard_login(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_auth_session_guard_logout']
pub fn vphp_wrap_vslim_auth_session_guard_logout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthSessionGuard(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.logout()
    return voidptr(res)
}
@[export: 'vslim_auth_session_guard_handlers']
pub fn vslim_auth_session_guard_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_auth_session_guard_get_prop),
        write_handler: voidptr(vslim_auth_session_guard_set_prop),
        sync_handler: voidptr(vslim_auth_session_guard_sync_props),
        new_raw: voidptr(vslim_auth_session_guard_new_raw),
        cleanup_raw: voidptr(vslim_auth_session_guard_cleanup_raw),
        free_raw: voidptr(vslim_auth_session_guard_free_raw)
    )
}
pub fn VSlimAuthSessionGuard.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__auth__sessionguard_ce)
}

pub fn VSlimAuthSessionGuard.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_auth_session_guard_handlers())
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

pub fn (val VSlimAuthSessionGuard) php_class_name() string {
    return 'VSlim\\Auth\\SessionGuard'
}

@[export: 'vslim_session_start_middleware_new_raw']
pub fn vslim_session_start_middleware_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimSessionStartMiddleware]()
}
@[export: 'vslim_session_start_middleware_free_raw']
pub fn vslim_session_start_middleware_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimSessionStartMiddleware](ptr)
}
@[export: 'vslim_session_start_middleware_cleanup_raw']
pub fn vslim_session_start_middleware_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_session_start_middleware_get_prop']
pub fn vslim_session_start_middleware_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_session_start_middleware_set_prop']
pub fn vslim_session_start_middleware_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_session_start_middleware_sync_props']
pub fn vslim_session_start_middleware_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_session_start_middleware_construct']
pub fn vphp_wrap_vslim_session_start_middleware_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStartMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_session_start_middleware_set_container']
pub fn vphp_wrap_vslim_session_start_middleware_set_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStartMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'container', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'container').to_v_ptr[containerx.VSlimContainer]() or {
        vphp.throw_exception('argument 0 must be object bound to containerx.VSlimContainer, got ' + php_args.at_named_or_index(0, 'container').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &containerx.VSlimContainer(arg_0_ptr) }
    res := recv.set_container(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_session_start_middleware_set_app']
pub fn vphp_wrap_vslim_session_start_middleware_set_app(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_session_start_middleware_process']
pub fn vphp_wrap_vslim_session_start_middleware_process(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimSessionStartMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_1 := php_args.at_named_or_index(1, 'handler').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.process(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vslim_session_start_middleware_handlers']
pub fn vslim_session_start_middleware_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_session_start_middleware_get_prop),
        write_handler: voidptr(vslim_session_start_middleware_set_prop),
        sync_handler: voidptr(vslim_session_start_middleware_sync_props),
        new_raw: voidptr(vslim_session_start_middleware_new_raw),
        cleanup_raw: voidptr(vslim_session_start_middleware_cleanup_raw),
        free_raw: voidptr(vslim_session_start_middleware_free_raw)
    )
}
pub fn VSlimSessionStartMiddleware.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__session__startmiddleware_ce)
}

pub fn VSlimSessionStartMiddleware.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_session_start_middleware_handlers())
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

pub fn (val VSlimSessionStartMiddleware) php_class_name() string {
    return 'VSlim\\Session\\StartMiddleware'
}

@[export: 'vslim_auth_require_middleware_new_raw']
pub fn vslim_auth_require_middleware_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimAuthRequireMiddleware]()
}
@[export: 'vslim_auth_require_middleware_free_raw']
pub fn vslim_auth_require_middleware_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimAuthRequireMiddleware](ptr)
}
@[export: 'vslim_auth_require_middleware_cleanup_raw']
pub fn vslim_auth_require_middleware_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_auth_require_middleware_get_prop']
pub fn vslim_auth_require_middleware_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_auth_require_middleware_set_prop']
pub fn vslim_auth_require_middleware_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_auth_require_middleware_sync_props']
pub fn vslim_auth_require_middleware_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_auth_require_middleware_construct']
pub fn vphp_wrap_vslim_auth_require_middleware_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_auth_require_middleware_set_container']
pub fn vphp_wrap_vslim_auth_require_middleware_set_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'container', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'container').to_v_ptr[containerx.VSlimContainer]() or {
        vphp.throw_exception('argument 0 must be object bound to containerx.VSlimContainer, got ' + php_args.at_named_or_index(0, 'container').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &containerx.VSlimContainer(arg_0_ptr) }
    res := recv.set_container(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_auth_require_middleware_set_app']
pub fn vphp_wrap_vslim_auth_require_middleware_set_app(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_auth_require_middleware_set_redirect_path']
pub fn vphp_wrap_vslim_auth_require_middleware_set_redirect_path(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_auth_require_middleware_redirect_path_value']
pub fn vphp_wrap_vslim_auth_require_middleware_redirect_path_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthRequireMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.redirect_path_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_auth_require_middleware_process']
pub fn vphp_wrap_vslim_auth_require_middleware_process(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_1 := php_args.at_named_or_index(1, 'handler').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.process(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vslim_auth_require_middleware_handlers']
pub fn vslim_auth_require_middleware_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_auth_require_middleware_get_prop),
        write_handler: voidptr(vslim_auth_require_middleware_set_prop),
        sync_handler: voidptr(vslim_auth_require_middleware_sync_props),
        new_raw: voidptr(vslim_auth_require_middleware_new_raw),
        cleanup_raw: voidptr(vslim_auth_require_middleware_cleanup_raw),
        free_raw: voidptr(vslim_auth_require_middleware_free_raw)
    )
}
pub fn VSlimAuthRequireMiddleware.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__auth__requireauthmiddleware_ce)
}

pub fn VSlimAuthRequireMiddleware.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_auth_require_middleware_handlers())
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

pub fn (val VSlimAuthRequireMiddleware) php_class_name() string {
    return 'VSlim\\Auth\\RequireAuthMiddleware'
}

@[export: 'vslim_auth_guest_middleware_new_raw']
pub fn vslim_auth_guest_middleware_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimAuthGuestMiddleware]()
}
@[export: 'vslim_auth_guest_middleware_free_raw']
pub fn vslim_auth_guest_middleware_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimAuthGuestMiddleware](ptr)
}
@[export: 'vslim_auth_guest_middleware_cleanup_raw']
pub fn vslim_auth_guest_middleware_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_auth_guest_middleware_get_prop']
pub fn vslim_auth_guest_middleware_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_auth_guest_middleware_set_prop']
pub fn vslim_auth_guest_middleware_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_auth_guest_middleware_sync_props']
pub fn vslim_auth_guest_middleware_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_auth_guest_middleware_construct']
pub fn vphp_wrap_vslim_auth_guest_middleware_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthGuestMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_auth_guest_middleware_set_container']
pub fn vphp_wrap_vslim_auth_guest_middleware_set_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthGuestMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'container', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'container').to_v_ptr[containerx.VSlimContainer]() or {
        vphp.throw_exception('argument 0 must be object bound to containerx.VSlimContainer, got ' + php_args.at_named_or_index(0, 'container').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &containerx.VSlimContainer(arg_0_ptr) }
    res := recv.set_container(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_auth_guest_middleware_set_app']
pub fn vphp_wrap_vslim_auth_guest_middleware_set_app(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_auth_guest_middleware_set_redirect_path']
pub fn vphp_wrap_vslim_auth_guest_middleware_set_redirect_path(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_auth_guest_middleware_redirect_path_value']
pub fn vphp_wrap_vslim_auth_guest_middleware_redirect_path_value(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthGuestMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.redirect_path_value()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_auth_guest_middleware_process']
pub fn vphp_wrap_vslim_auth_guest_middleware_process(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthGuestMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_1 := php_args.at_named_or_index(1, 'handler').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.process(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vslim_auth_guest_middleware_handlers']
pub fn vslim_auth_guest_middleware_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_auth_guest_middleware_get_prop),
        write_handler: voidptr(vslim_auth_guest_middleware_set_prop),
        sync_handler: voidptr(vslim_auth_guest_middleware_sync_props),
        new_raw: voidptr(vslim_auth_guest_middleware_new_raw),
        cleanup_raw: voidptr(vslim_auth_guest_middleware_cleanup_raw),
        free_raw: voidptr(vslim_auth_guest_middleware_free_raw)
    )
}
pub fn VSlimAuthGuestMiddleware.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__auth__guestmiddleware_ce)
}

pub fn VSlimAuthGuestMiddleware.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_auth_guest_middleware_handlers())
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

pub fn (val VSlimAuthGuestMiddleware) php_class_name() string {
    return 'VSlim\\Auth\\GuestMiddleware'
}

@[export: 'vslim_auth_require_ability_middleware_new_raw']
pub fn vslim_auth_require_ability_middleware_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimAuthRequireAbilityMiddleware]()
}
@[export: 'vslim_auth_require_ability_middleware_free_raw']
pub fn vslim_auth_require_ability_middleware_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimAuthRequireAbilityMiddleware](ptr)
}
@[export: 'vslim_auth_require_ability_middleware_cleanup_raw']
pub fn vslim_auth_require_ability_middleware_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_auth_require_ability_middleware_get_prop']
pub fn vslim_auth_require_ability_middleware_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_auth_require_ability_middleware_set_prop']
pub fn vslim_auth_require_ability_middleware_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_auth_require_ability_middleware_sync_props']
pub fn vslim_auth_require_ability_middleware_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_auth_require_ability_middleware_construct']
pub fn vphp_wrap_vslim_auth_require_ability_middleware_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_auth_require_ability_middleware_set_container']
pub fn vphp_wrap_vslim_auth_require_ability_middleware_set_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'container', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'container').to_v_ptr[containerx.VSlimContainer]() or {
        vphp.throw_exception('argument 0 must be object bound to containerx.VSlimContainer, got ' + php_args.at_named_or_index(0, 'container').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &containerx.VSlimContainer(arg_0_ptr) }
    res := recv.set_container(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_auth_require_ability_middleware_set_app']
pub fn vphp_wrap_vslim_auth_require_ability_middleware_set_app(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_auth_require_ability_middleware_set_ability']
pub fn vphp_wrap_vslim_auth_require_ability_middleware_set_ability(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_auth_require_ability_middleware_ability']
pub fn vphp_wrap_vslim_auth_require_ability_middleware_ability(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.ability()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_auth_require_ability_middleware_set_status']
pub fn vphp_wrap_vslim_auth_require_ability_middleware_set_status(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_auth_require_ability_middleware_status']
pub fn vphp_wrap_vslim_auth_require_ability_middleware_status(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.status()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_auth_require_ability_middleware_set_message']
pub fn vphp_wrap_vslim_auth_require_ability_middleware_set_message(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_auth_require_ability_middleware_message']
pub fn vphp_wrap_vslim_auth_require_ability_middleware_message(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.message()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_auth_require_ability_middleware_process']
pub fn vphp_wrap_vslim_auth_require_ability_middleware_process(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimAuthRequireAbilityMiddleware(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_1 := php_args.at_named_or_index(1, 'handler').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.process(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vslim_auth_require_ability_middleware_handlers']
pub fn vslim_auth_require_ability_middleware_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_auth_require_ability_middleware_get_prop),
        write_handler: voidptr(vslim_auth_require_ability_middleware_set_prop),
        sync_handler: voidptr(vslim_auth_require_ability_middleware_sync_props),
        new_raw: voidptr(vslim_auth_require_ability_middleware_new_raw),
        cleanup_raw: voidptr(vslim_auth_require_ability_middleware_cleanup_raw),
        free_raw: voidptr(vslim_auth_require_ability_middleware_free_raw)
    )
}
pub fn VSlimAuthRequireAbilityMiddleware.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__auth__requireabilitymiddleware_ce)
}

pub fn VSlimAuthRequireAbilityMiddleware.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_auth_require_ability_middleware_handlers())
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

pub fn (val VSlimAuthRequireAbilityMiddleware) php_class_name() string {
    return 'VSlim\\Auth\\RequireAbilityMiddleware'
}

