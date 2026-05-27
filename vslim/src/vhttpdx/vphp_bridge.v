module vhttpdx

import vphp

#include "php_bridge.h"

__global C.vslim__vhttpd__client_ce &C.zend_class_entry

@[export: 'vslim_vhttpd_client_new_raw']
pub fn vslim_vhttpd_client_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimVhttpdClient]()
}
@[export: 'vslim_vhttpd_client_free_raw']
pub fn vslim_vhttpd_client_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimVhttpdClient](ptr)
}
@[export: 'vslim_vhttpd_client_cleanup_raw']
pub fn vslim_vhttpd_client_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_vhttpd_client_get_prop']
pub fn vslim_vhttpd_client_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_vhttpd_client_set_prop']
pub fn vslim_vhttpd_client_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_vhttpd_client_sync_props']
pub fn vslim_vhttpd_client_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_vhttpd_client_construct']
pub fn vphp_wrap_vslim_vhttpd_client_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimVhttpdClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'socketPath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'connectTimeoutSeconds', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'socketPath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'connectTimeoutSeconds').as_v[f64]()
    res := recv.construct(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_vhttpd_client_socket_path']
pub fn vphp_wrap_vslim_vhttpd_client_socket_path(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimVhttpdClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.socket_path()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_vhttpd_client_connect_timeout_seconds']
pub fn vphp_wrap_vslim_vhttpd_client_connect_timeout_seconds(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimVhttpdClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.connect_timeout_seconds()
    ctx.return().v[f64](res)
}
@[export: 'vphp_wrap_vslim_vhttpd_client_request']
pub fn vphp_wrap_vslim_vhttpd_client_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimVhttpdClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'payload', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'payload').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    res := recv.request(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_vhttpd_client_request_frames']
pub fn vphp_wrap_vslim_vhttpd_client_request_frames(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimVhttpdClient(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'payload', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'frames', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'payload').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    arg_1 := php_args.at_named_or_index(1, 'frames').array()
    res := recv.request_frames(arg_0, arg_1)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vslim_vhttpd_client_handlers']
pub fn vslim_vhttpd_client_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_vhttpd_client_get_prop),
        write_handler: voidptr(vslim_vhttpd_client_set_prop),
        sync_handler: voidptr(vslim_vhttpd_client_sync_props),
        new_raw: voidptr(vslim_vhttpd_client_new_raw),
        cleanup_raw: voidptr(vslim_vhttpd_client_cleanup_raw),
        free_raw: voidptr(vslim_vhttpd_client_free_raw)
    )
}
pub fn VSlimVhttpdClient.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__vhttpd__client_ce)
}

pub fn VSlimVhttpdClient.php_object_handlers() voidptr {
    return vslim_vhttpd_client_handlers()
}

pub fn VSlimVhttpdClient.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimVhttpdClient](v_ptr, ownership)
}

pub fn (obj &VSlimVhttpdClient) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimVhttpdClient](obj)
}

pub fn (obj &VSlimVhttpdClient) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimVhttpdClient](obj)
}

pub fn (obj &VSlimVhttpdClient) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimVhttpdClient](obj)
}

pub fn (obj &VSlimVhttpdClient) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimVhttpdClient](obj)
}

pub fn (val VSlimVhttpdClient) php_class_name() string {
    return 'VSlim\\VHttpd\\Client'
}

