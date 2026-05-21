module module_probe

import vphp

import eventx
import httpx

#include "php_bridge.h"

__global C.vslim__compiler__moduleprobebox_ce &C.zend_class_entry
__global C.vslim__dev__phpsignatureprobe_ce &C.zend_class_entry
__global C.vslim__debug__objectprobe_ce &C.zend_class_entry

@[export: 'VSlimModuleProbeBox_new_raw']
pub fn vslimmoduleprobebox_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimModuleProbeBox]()
}
@[export: 'VSlimModuleProbeBox_free_raw']
pub fn vslimmoduleprobebox_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimModuleProbeBox](ptr)
}
@[export: 'VSlimModuleProbeBox_cleanup_raw']
pub fn vslimmoduleprobebox_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimModuleProbeBox_get_prop']
pub fn vslimmoduleprobebox_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimModuleProbeBox(ptr)
        if name == 'name' {
            ret.v[string](obj.name)
            return
        }
        if name == 'count' {
            ret.v[i64](i64(obj.count))
            return
        }
    }
}
@[export: 'VSlimModuleProbeBox_set_prop']
pub fn vslimmoduleprobebox_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimModuleProbeBox(ptr)
        if name == 'name' {
            obj.name = arg.get_string()
            return
        }
        if name == 'count' {
            obj.count = int(arg.get_int())
            return
        }
    }
}
@[export: 'VSlimModuleProbeBox_sync_props']
pub fn vslimmoduleprobebox_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimModuleProbeBox(ptr)
        out.add_property_string('name', obj.name)
        out.add_property_long('count', i64(obj.count))
    }
}
@[export: 'vphp_wrap_VSlimModuleProbeBox_label']
pub fn vphp_wrap_vslimmoduleprobebox_label(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimModuleProbeBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.label()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimModuleProbeBox_static_label']
pub fn vphp_wrap_vslimmoduleprobebox_static_label(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimModuleProbeBox.static_label()
    ctx.return().v[string](res)
}
@[export: 'VSlimModuleProbeBox_handlers']
pub fn vslimmoduleprobebox_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimmoduleprobebox_get_prop),
        write_handler: voidptr(vslimmoduleprobebox_set_prop),
        sync_handler: voidptr(vslimmoduleprobebox_sync_props),
        new_raw: voidptr(vslimmoduleprobebox_new_raw),
        cleanup_raw: voidptr(vslimmoduleprobebox_cleanup_raw),
        free_raw: voidptr(vslimmoduleprobebox_free_raw)
    )
}
pub fn VSlimModuleProbeBox.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__compiler__moduleprobebox_ce)
}

pub fn VSlimModuleProbeBox.php_object_handlers() voidptr {
    return vslimmoduleprobebox_handlers()
}

pub fn VSlimModuleProbeBox.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimModuleProbeBox](v_ptr, ownership)
}

pub fn (obj &VSlimModuleProbeBox) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimModuleProbeBox](obj)
}

pub fn (obj &VSlimModuleProbeBox) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimModuleProbeBox](obj)
}

pub fn (obj &VSlimModuleProbeBox) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimModuleProbeBox](obj)
}

pub fn (obj &VSlimModuleProbeBox) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimModuleProbeBox](obj)
}

@[export: 'VSlimPhpSignatureProbe_new_raw']
pub fn vslimphpsignatureprobe_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPhpSignatureProbe]()
}
@[export: 'VSlimPhpSignatureProbe_free_raw']
pub fn vslimphpsignatureprobe_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPhpSignatureProbe](ptr)
}
@[export: 'VSlimPhpSignatureProbe_cleanup_raw']
pub fn vslimphpsignatureprobe_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimPhpSignatureProbe_get_prop']
pub fn vslimphpsignatureprobe_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimPhpSignatureProbe_set_prop']
pub fn vslimphpsignatureprobe_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimPhpSignatureProbe_sync_props']
pub fn vslimphpsignatureprobe_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_construct']
pub fn vphp_wrap_vslimphpsignatureprobe_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_always_true']
pub fn vphp_wrap_vslimphpsignatureprobe_always_true(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.always_true()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_always_false']
pub fn vphp_wrap_vslimphpsignatureprobe_always_false(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.always_false()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_always_null']
pub fn vphp_wrap_vslimphpsignatureprobe_always_null(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.always_null()
    ctx.return().v[vphp.PhpNull](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_always_throw']
pub fn vphp_wrap_vslimphpsignatureprobe_always_throw(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.always_throw()
    ctx.return().v[vphp.PhpNull](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_accept_true']
pub fn vphp_wrap_vslimphpsignatureprobe_accept_true(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'flag', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'flag').bool_value() or {
        vphp.throw_exception('argument 0 must be bool', 0)
        return
    }
    res := recv.accept_true(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_accept_false']
pub fn vphp_wrap_vslimphpsignatureprobe_accept_false(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'flag', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'flag').bool_value() or {
        vphp.throw_exception('argument 0 must be bool', 0)
        return
    }
    res := recv.accept_false(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_accept_null']
pub fn vphp_wrap_vslimphpsignatureprobe_accept_null(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'value', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'value').null_value() or {
        vphp.throw_exception('argument 0 must be null', 0)
        return
    }
    res := recv.accept_null(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_accept_callable']
pub fn vphp_wrap_vslimphpsignatureprobe_accept_callable(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'cb', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'cb').callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return
    }
    res := recv.accept_callable(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_optional_tail']
pub fn vphp_wrap_vslimphpsignatureprobe_optional_tail(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'suffix', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'prefix').as_v[string]()
    arg_1 := if php_args.has_named_or_index(1, 'suffix') { php_args.at_named_or_index(1, 'suffix').as_v[string]() } else { '' }
    res := recv.optional_tail(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_make_psr_response']
pub fn vphp_wrap_vslimphpsignatureprobe_make_psr_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.make_psr_response()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_make_static_psr_response']
pub fn vphp_wrap_vslimphpsignatureprobe_make_static_psr_response(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimPhpSignatureProbe.make_static_psr_response()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_accept_psr_request']
pub fn vphp_wrap_vslimphpsignatureprobe_accept_psr_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    res := recv.accept_psr_request(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_accept_datetime_interface']
pub fn vphp_wrap_vslimphpsignatureprobe_accept_datetime_interface(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'expiration', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'expiration').value
    res := recv.accept_datetime_interface(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_set_provider']
pub fn vphp_wrap_vslimphpsignatureprobe_set_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'provider', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := unsafe { &eventx.VSlimPsr14ListenerProvider(php_args.at_named_or_index(0, 'provider').raw_obj()) }
    res := recv.set_provider(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider_alias()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_from_guard']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_from_guard(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider_from_guard()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_from_if_expr']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_from_if_expr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'useAlias').as_v[bool]()
    res := recv.borrowed_provider_from_if_expr(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_from_if_expr_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_from_if_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'useAlias').as_v[bool]()
    res := recv.borrowed_provider_from_if_expr_alias(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_from_match_expr']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_from_match_expr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'useAlias').as_v[bool]()
    res := recv.borrowed_provider_from_match_expr(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_from_match_expr_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_from_match_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'useAlias').as_v[bool]()
    res := recv.borrowed_provider_from_match_expr_alias(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_from_or_block']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_from_or_block(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider_from_or_block()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_borrowed_provider_from_or_block_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_borrowed_provider_from_or_block_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider_from_or_block_alias()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.fresh_provider()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.fresh_provider_alias()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider_from_if_expr']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider_from_if_expr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'useAlias').as_v[bool]()
    res := recv.fresh_provider_from_if_expr(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider_from_if_expr_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider_from_if_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'useAlias').as_v[bool]()
    res := recv.fresh_provider_from_if_expr_alias(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider_from_match_expr']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider_from_match_expr(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'useAlias').as_v[bool]()
    res := recv.fresh_provider_from_match_expr(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider_from_match_expr_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider_from_match_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'useAlias', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'useAlias').as_v[bool]()
    res := recv.fresh_provider_from_match_expr_alias(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider_from_or_block']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider_from_or_block(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.fresh_provider_from_or_block()
    return voidptr(res)
}
@[export: 'vphp_wrap_VSlimPhpSignatureProbe_fresh_provider_from_or_block_alias']
pub fn vphp_wrap_vslimphpsignatureprobe_fresh_provider_from_or_block_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.fresh_provider_from_or_block_alias()
    return voidptr(res)
}
@[export: 'VSlimPhpSignatureProbe_handlers']
pub fn vslimphpsignatureprobe_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimphpsignatureprobe_get_prop),
        write_handler: voidptr(vslimphpsignatureprobe_set_prop),
        sync_handler: voidptr(vslimphpsignatureprobe_sync_props),
        new_raw: voidptr(vslimphpsignatureprobe_new_raw),
        cleanup_raw: voidptr(vslimphpsignatureprobe_cleanup_raw),
        free_raw: voidptr(vslimphpsignatureprobe_free_raw)
    )
}
pub fn VSlimPhpSignatureProbe.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__dev__phpsignatureprobe_ce)
}

pub fn VSlimPhpSignatureProbe.php_object_handlers() voidptr {
    return vslimphpsignatureprobe_handlers()
}

pub fn VSlimPhpSignatureProbe.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimPhpSignatureProbe](v_ptr, ownership)
}

pub fn (obj &VSlimPhpSignatureProbe) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimPhpSignatureProbe](obj)
}

pub fn (obj &VSlimPhpSignatureProbe) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimPhpSignatureProbe](obj)
}

pub fn (obj &VSlimPhpSignatureProbe) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimPhpSignatureProbe](obj)
}

pub fn (obj &VSlimPhpSignatureProbe) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimPhpSignatureProbe](obj)
}

@[export: 'VSlimDebugObjectProbe_new_raw']
pub fn vslimdebugobjectprobe_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDebugObjectProbe]()
}
@[export: 'VSlimDebugObjectProbe_free_raw']
pub fn vslimdebugobjectprobe_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDebugObjectProbe](ptr)
}
@[export: 'VSlimDebugObjectProbe_cleanup_raw']
pub fn vslimdebugobjectprobe_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'VSlimDebugObjectProbe_get_prop']
pub fn vslimdebugobjectprobe_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'VSlimDebugObjectProbe_set_prop']
pub fn vslimdebugobjectprobe_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'VSlimDebugObjectProbe_sync_props']
pub fn vslimdebugobjectprobe_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_VSlimDebugObjectProbe_probe']
pub fn vphp_wrap_vslimdebugobjectprobe_probe(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'obj', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'className', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'methodName', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'obj').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    arg_1 := php_args.at_named_or_index(1, 'className').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'methodName').as_v[string]()
    res := VSlimDebugObjectProbe.probe(arg_0, arg_1, arg_2)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_VSlimDebugObjectProbe_psr7_lifecycle_counters']
pub fn vphp_wrap_vslimdebugobjectprobe_psr7_lifecycle_counters(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'rounds', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'rounds').as_v[int]()
    res := VSlimDebugObjectProbe.psr7_lifecycle_counters(arg_0)
    ctx.return().v[string](res)
}
@[export: 'VSlimDebugObjectProbe_handlers']
pub fn vslimdebugobjectprobe_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslimdebugobjectprobe_get_prop),
        write_handler: voidptr(vslimdebugobjectprobe_set_prop),
        sync_handler: voidptr(vslimdebugobjectprobe_sync_props),
        new_raw: voidptr(vslimdebugobjectprobe_new_raw),
        cleanup_raw: voidptr(vslimdebugobjectprobe_cleanup_raw),
        free_raw: voidptr(vslimdebugobjectprobe_free_raw)
    )
}
pub fn VSlimDebugObjectProbe.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__debug__objectprobe_ce)
}

pub fn VSlimDebugObjectProbe.php_object_handlers() voidptr {
    return vslimdebugobjectprobe_handlers()
}

pub fn VSlimDebugObjectProbe.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimDebugObjectProbe](v_ptr, ownership)
}

pub fn (obj &VSlimDebugObjectProbe) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimDebugObjectProbe](obj)
}

pub fn (obj &VSlimDebugObjectProbe) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimDebugObjectProbe](obj)
}

pub fn (obj &VSlimDebugObjectProbe) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimDebugObjectProbe](obj)
}

pub fn (obj &VSlimDebugObjectProbe) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimDebugObjectProbe](obj)
}

