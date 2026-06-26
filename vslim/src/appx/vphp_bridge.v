module appx

import vphp
import vphp.object

import cachex
import configx
import containerx
import databasex
import eventx
import httpx
import jobx
import loggerx
import mcpx
import routex
import sessionx
import testingx
import validationx
import viewx

#include "php_bridge.h"

__global C.vslim__app_ce &C.zend_class_entry

@[export: 'vslim_app_new_raw']
pub fn vslim_app_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimApp]()
}
@[export: 'vslim_app_free_raw']
pub fn vslim_app_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimApp](ptr)
}
@[export: 'vslim_app_cleanup_raw']
pub fn vslim_app_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    unsafe {
        mut obj := &VSlimApp(ptr)
        obj.cleanup()
    }
}
@[export: 'vslim_app_get_prop']
pub fn vslim_app_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_app_set_prop']
pub fn vslim_app_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_app_sync_props']
pub fn vslim_app_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_app_mount_module']
pub fn vphp_wrap_vslim_app_mount_module(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'modInput', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'modInput').value
    res := recv.mount_module(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_module_many']
pub fn vphp_wrap_vslim_app_module_many(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'modules', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'modules').iterable() or {
        vphp.throw_exception('argument 0 must be iterable', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.module_many(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_module_count']
pub fn vphp_wrap_vslim_app_module_count(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.module_count()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_app_has_module']
pub fn vphp_wrap_vslim_app_has_module(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'className', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'className').as_v[string]()
    res := recv.has_module(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_error_response']
pub fn vphp_wrap_vslim_app_error_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'status', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'message', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'errorCode', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'status').as_v[int]()
    arg_1 := php_args.at_named_or_index(1, 'message').as_v[string]()
    arg_2 := if php_args.has_named_or_index(2, 'errorCode') { php_args.at_named_or_index(2, 'errorCode').as_v[string]() } else { '' }
    res := recv.error_response(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_validation_error']
pub fn vphp_wrap_vslim_app_validation_error(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'errors', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'status', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'errors').value
    arg_1 := if php_args.has_named_or_index(1, 'status') { php_args.at_named_or_index(1, 'status').as_v[int]() } else { 422 }
    res := recv.validation_error(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_unauthorized_response']
pub fn vphp_wrap_vslim_app_unauthorized_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := if php_args.has_named_or_index(0, 'message') { php_args.at_named_or_index(0, 'message').as_v[string]() } else { 'Unauthorized' }
    res := recv.unauthorized_response(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_forbidden_response']
pub fn vphp_wrap_vslim_app_forbidden_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := if php_args.has_named_or_index(0, 'message') { php_args.at_named_or_index(0, 'message').as_v[string]() } else { 'Forbidden' }
    res := recv.forbidden_response(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_bad_request_response']
pub fn vphp_wrap_vslim_app_bad_request_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := if php_args.has_named_or_index(0, 'message') { php_args.at_named_or_index(0, 'message').as_v[string]() } else { 'Bad Request' }
    res := recv.bad_request_response(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_not_found_response_helper']
pub fn vphp_wrap_vslim_app_not_found_response_helper(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := if php_args.has_named_or_index(0, 'message') { php_args.at_named_or_index(0, 'message').as_v[string]() } else { 'Not Found' }
    res := recv.not_found_response_helper(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_conflict_response']
pub fn vphp_wrap_vslim_app_conflict_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := if php_args.has_named_or_index(0, 'message') { php_args.at_named_or_index(0, 'message').as_v[string]() } else { 'Conflict' }
    res := recv.conflict_response(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_service_unavailable_response']
pub fn vphp_wrap_vslim_app_service_unavailable_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'message', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := if php_args.has_named_or_index(0, 'message') { php_args.at_named_or_index(0, 'message').as_v[string]() } else { 'Service Unavailable' }
    res := recv.service_unavailable_response(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_exception_response']
pub fn vphp_wrap_vslim_app_exception_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'exception', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'fallbackStatus', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'exception').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_1 := if php_args.has_named_or_index(1, 'fallbackStatus') { php_args.at_named_or_index(1, 'fallbackStatus').as_v[int]() } else { 500 }
    res := recv.exception_response(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_doctor_report']
pub fn vphp_wrap_vslim_app_doctor_report(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.doctor_report()
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_vslim_app_url_for']
pub fn vphp_wrap_vslim_app_url_for(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    res := recv.url_for(arg_0, arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_app_url_for_query']
pub fn vphp_wrap_vslim_app_url_for_query(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'query', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    arg_2 := php_args.at_named_or_index(2, 'query').value
    res := recv.url_for_query(arg_0, arg_1, arg_2)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_app_url_for_abs']
pub fn vphp_wrap_vslim_app_url_for_abs(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'scheme', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'host', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    arg_2 := php_args.at_named_or_index(2, 'scheme').as_v[string]()
    arg_3 := php_args.at_named_or_index(3, 'host').as_v[string]()
    res := recv.url_for_abs(arg_0, arg_1, arg_2, arg_3)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_app_url_for_query_abs']
pub fn vphp_wrap_vslim_app_url_for_query_abs(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'query', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'scheme', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'host', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    arg_2 := php_args.at_named_or_index(2, 'query').value
    arg_3 := php_args.at_named_or_index(3, 'scheme').as_v[string]()
    arg_4 := php_args.at_named_or_index(4, 'host').as_v[string]()
    res := recv.url_for_query_abs(arg_0, arg_1, arg_2, arg_3, arg_4)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_app_redirect_to']
pub fn vphp_wrap_vslim_app_redirect_to(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    res := recv.redirect_to(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_redirect_to_query']
pub fn vphp_wrap_vslim_app_redirect_to_query(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'params', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'query', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'params').value
    arg_2 := php_args.at_named_or_index(2, 'query').value
    res := recv.redirect_to_query(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_group']
pub fn vphp_wrap_vslim_app_group(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'prefix').as_v[string]()
    res := recv.group(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_get']
pub fn vphp_wrap_vslim_app_get(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.get(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_post']
pub fn vphp_wrap_vslim_app_post(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.post(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_put']
pub fn vphp_wrap_vslim_app_put(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.put(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_head']
pub fn vphp_wrap_vslim_app_head(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.head(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_options']
pub fn vphp_wrap_vslim_app_options(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.options(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_patch']
pub fn vphp_wrap_vslim_app_patch(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.patch(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_delete']
pub fn vphp_wrap_vslim_app_delete(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.delete(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_any']
pub fn vphp_wrap_vslim_app_any(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.any(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_live']
pub fn vphp_wrap_vslim_app_live(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.live(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_live_ws']
pub fn vphp_wrap_vslim_app_live_ws(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'handler', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'frame', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'conn', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'handler').value
    arg_1 := php_args.at_named_or_index(1, 'frame').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return
    }
    arg_2 := php_args.at_named_or_index(2, 'conn').object() or {
        vphp.throw_exception('argument 2 must be object', 0)
        return
    }
    res := recv.live_ws(arg_0, arg_1, arg_2)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_app_websocket']
pub fn vphp_wrap_vslim_app_websocket(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'pattern').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.websocket(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_websocket_named']
pub fn vphp_wrap_vslim_app_websocket_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.websocket_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_map']
pub fn vphp_wrap_vslim_app_map(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'methods', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'methods').value
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.map(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_get_named']
pub fn vphp_wrap_vslim_app_get_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.get_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_post_named']
pub fn vphp_wrap_vslim_app_post_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.post_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_put_named']
pub fn vphp_wrap_vslim_app_put_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.put_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_head_named']
pub fn vphp_wrap_vslim_app_head_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.head_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_options_named']
pub fn vphp_wrap_vslim_app_options_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.options_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_patch_named']
pub fn vphp_wrap_vslim_app_patch_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.patch_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_delete_named']
pub fn vphp_wrap_vslim_app_delete_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.delete_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_any_named']
pub fn vphp_wrap_vslim_app_any_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'pattern').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'handler').value
    res := recv.any_named(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_map_named']
pub fn vphp_wrap_vslim_app_map_named(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'methods', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'pattern', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'methods').value
    arg_1 := php_args.at_named_or_index(1, 'name').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'pattern').as_v[string]()
    arg_3 := php_args.at_named_or_index(3, 'handler').value
    res := recv.map_named(arg_0, arg_1, arg_2, arg_3)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_middleware']
pub fn vphp_wrap_vslim_app_middleware(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'handler').value
    res := recv.middleware(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_before']
pub fn vphp_wrap_vslim_app_before(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'handler').value
    res := recv.before(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_after']
pub fn vphp_wrap_vslim_app_after(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'handler').value
    res := recv.after(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_set_not_found_handler']
pub fn vphp_wrap_vslim_app_set_not_found_handler(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'handler').callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.set_not_found_handler(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_set_error_handler']
pub fn vphp_wrap_vslim_app_set_error_handler(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'handler').callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.set_error_handler(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_error']
pub fn vphp_wrap_vslim_app_error(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'handler').callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.error(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_set_error_response_json']
pub fn vphp_wrap_vslim_app_set_error_response_json(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'enabled', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'enabled').as_v[bool]()
    res := recv.set_error_response_json(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_error_response_json_enabled']
pub fn vphp_wrap_vslim_app_error_response_json_enabled(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.error_response_json_enabled()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_has_mcp']
pub fn vphp_wrap_vslim_app_has_mcp(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_mcp()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_set_mcp']
pub fn vphp_wrap_vslim_app_set_mcp(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'server', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'server').to_v_ptr[mcpx.VSlimMcpApp]() or {
        vphp.throw_exception('argument 0 must be object bound to mcpx.VSlimMcpApp, got ' + php_args.at_named_or_index(0, 'server').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &mcpx.VSlimMcpApp(arg_0_ptr) }
    res := recv.set_mcp(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_mcp']
pub fn vphp_wrap_vslim_app_mcp(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.mcp()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_handle_mcp_dispatch']
pub fn vphp_wrap_vslim_app_handle_mcp_dispatch(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'frame', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'frame').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    res := recv.handle_mcp_dispatch(arg_0)
    ctx.return().v[vphp.PhpArray](res)
}
@[export: 'vphp_wrap_vslim_app_has_logger']
pub fn vphp_wrap_vslim_app_has_logger(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_logger()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_set_clock']
pub fn vphp_wrap_vslim_app_set_clock(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
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
@[export: 'vphp_wrap_vslim_app_clock']
pub fn vphp_wrap_vslim_app_clock(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clock()
    ctx.return().v[vphp.PhpObject](res)
}
@[export: 'vphp_wrap_vslim_app_set_logger']
pub fn vphp_wrap_vslim_app_set_logger(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'logWriter', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'logWriter').to_v_ptr[loggerx.VSlimLogger]() or {
        vphp.throw_exception('argument 0 must be object bound to loggerx.VSlimLogger, got ' + php_args.at_named_or_index(0, 'logWriter').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &loggerx.VSlimLogger(arg_0_ptr) }
    res := recv.set_logger(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_logger']
pub fn vphp_wrap_vslim_app_logger(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.logger()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_psr_logger']
pub fn vphp_wrap_vslim_app_psr_logger(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.psr_logger()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_set_listener_provider']
pub fn vphp_wrap_vslim_app_set_listener_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'provider', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'provider').to_v_ptr[eventx.VSlimPsr14ListenerProvider]() or {
        vphp.throw_exception('argument 0 must be object bound to eventx.VSlimPsr14ListenerProvider, got ' + php_args.at_named_or_index(0, 'provider').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &eventx.VSlimPsr14ListenerProvider(arg_0_ptr) }
    res := recv.set_listener_provider(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_listener_provider']
pub fn vphp_wrap_vslim_app_listener_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.listener_provider()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_set_dispatcher']
pub fn vphp_wrap_vslim_app_set_dispatcher(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'dispatcher', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'dispatcher').to_v_ptr[eventx.VSlimPsr14EventDispatcher]() or {
        vphp.throw_exception('argument 0 must be object bound to eventx.VSlimPsr14EventDispatcher, got ' + php_args.at_named_or_index(0, 'dispatcher').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &eventx.VSlimPsr14EventDispatcher(arg_0_ptr) }
    res := recv.set_dispatcher(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_dispatcher']
pub fn vphp_wrap_vslim_app_dispatcher(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.dispatcher()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_events']
pub fn vphp_wrap_vslim_app_events(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.events()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_set_cache']
pub fn vphp_wrap_vslim_app_set_cache(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'cache', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'cache').to_v_ptr[cachex.VSlimPsr16Cache]() or {
        vphp.throw_exception('argument 0 must be object bound to cachex.VSlimPsr16Cache, got ' + php_args.at_named_or_index(0, 'cache').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &cachex.VSlimPsr16Cache(arg_0_ptr) }
    res := recv.set_cache(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_cache']
pub fn vphp_wrap_vslim_app_cache(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.cache()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_set_cache_pool']
pub fn vphp_wrap_vslim_app_set_cache_pool(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'pool', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'pool').to_v_ptr[cachex.VSlimPsr6CacheItemPool]() or {
        vphp.throw_exception('argument 0 must be object bound to cachex.VSlimPsr6CacheItemPool, got ' + php_args.at_named_or_index(0, 'pool').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &cachex.VSlimPsr6CacheItemPool(arg_0_ptr) }
    res := recv.set_cache_pool(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_cache_pool']
pub fn vphp_wrap_vslim_app_cache_pool(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.cache_pool()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_set_http_client']
pub fn vphp_wrap_vslim_app_set_http_client(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'client', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'client').to_v_ptr[httpx.VSlimPsr18Client]() or {
        vphp.throw_exception('argument 0 must be object bound to httpx.VSlimPsr18Client, got ' + php_args.at_named_or_index(0, 'client').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &httpx.VSlimPsr18Client(arg_0_ptr) }
    res := recv.set_http_client(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_http_client']
pub fn vphp_wrap_vslim_app_http_client(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.http_client()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_has_database']
pub fn vphp_wrap_vslim_app_has_database(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_database()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_set_database']
pub fn vphp_wrap_vslim_app_set_database(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'database', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'database').to_v_ptr[databasex.VSlimDatabaseManager]() or {
        vphp.throw_exception('argument 0 must be object bound to databasex.VSlimDatabaseManager, got ' + php_args.at_named_or_index(0, 'database').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &databasex.VSlimDatabaseManager(arg_0_ptr) }
    res := recv.set_database(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_database']
pub fn vphp_wrap_vslim_app_database(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.database()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_db']
pub fn vphp_wrap_vslim_app_db(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.db()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_job_dispatcher']
pub fn vphp_wrap_vslim_app_job_dispatcher(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.job_dispatcher()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_job_worker']
pub fn vphp_wrap_vslim_app_job_worker(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.job_worker()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_has_migrator']
pub fn vphp_wrap_vslim_app_has_migrator(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_migrator()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_set_migrator']
pub fn vphp_wrap_vslim_app_set_migrator(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'migrator', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'migrator').to_v_ptr[databasex.VSlimDatabaseMigrator]() or {
        vphp.throw_exception('argument 0 must be object bound to databasex.VSlimDatabaseMigrator, got ' + php_args.at_named_or_index(0, 'migrator').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &databasex.VSlimDatabaseMigrator(arg_0_ptr) }
    res := recv.set_migrator(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_migrator']
pub fn vphp_wrap_vslim_app_migrator(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.migrator()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_resource']
pub fn vphp_wrap_vslim_app_resource(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    res := recv.resource(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_api_resource']
pub fn vphp_wrap_vslim_app_api_resource(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    res := recv.api_resource(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_singleton']
pub fn vphp_wrap_vslim_app_singleton(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    res := recv.singleton(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_api_singleton']
pub fn vphp_wrap_vslim_app_api_singleton(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    res := recv.api_singleton(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_resource_opts']
pub fn vphp_wrap_vslim_app_resource_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'options', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'options').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.resource_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_api_resource_opts']
pub fn vphp_wrap_vslim_app_api_resource_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'options', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'options').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.api_resource_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_singleton_opts']
pub fn vphp_wrap_vslim_app_singleton_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'options', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'options').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.singleton_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_api_singleton_opts']
pub fn vphp_wrap_vslim_app_api_singleton_opts(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resourcePath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'controller', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'options', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resourcePath').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'controller').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'options').array() or {
        vphp.throw_exception('argument 2 must be array', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.api_singleton_opts(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_handle_websocket']
pub fn vphp_wrap_vslim_app_handle_websocket(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'frame', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'conn', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'frame').array() or {
        vphp.throw_exception('argument 0 must be array', 0)
        return
    }
    arg_1 := php_args.at_named_or_index(1, 'conn').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return
    }
    res := recv.handle_websocket(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_app_route_count']
pub fn vphp_wrap_vslim_app_route_count(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.route_count()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_app_route_names']
pub fn vphp_wrap_vslim_app_route_names(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.route_names()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_app_has_route_name']
pub fn vphp_wrap_vslim_app_has_route_name(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    res := recv.has_route_name(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_route_manifest_lines']
pub fn vphp_wrap_vslim_app_route_manifest_lines(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.route_manifest_lines()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_app_route_conflict_keys']
pub fn vphp_wrap_vslim_app_route_conflict_keys(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.route_conflict_keys()
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_app_route_manifest']
pub fn vphp_wrap_vslim_app_route_manifest(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.route_manifest()
    ctx.return().v[[]map[string]string](res)
}
@[export: 'vphp_wrap_vslim_app_route_conflicts']
pub fn vphp_wrap_vslim_app_route_conflicts(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.route_conflicts()
    ctx.return().v[[]map[string]string](res)
}
@[export: 'vphp_wrap_vslim_app_allowed_methods_for']
pub fn vphp_wrap_vslim_app_allowed_methods_for(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'rawPath', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'rawPath').as_v[string]()
    res := recv.allowed_methods_for(arg_0)
    ctx.return().v[[]string](res)
}
@[export: 'vphp_wrap_vslim_app_bootstrap']
pub fn vphp_wrap_vslim_app_bootstrap(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'spec', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'spec').iterable() or {
        vphp.throw_exception('argument 0 must be iterable', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.bootstrap(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_bootstrap_file']
pub fn vphp_wrap_vslim_app_bootstrap_file(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.bootstrap_file(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_bootstrap_dir']
pub fn vphp_wrap_vslim_app_bootstrap_dir(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.bootstrap_dir(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_handle']
pub fn vphp_wrap_vslim_app_handle(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
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
    res := recv.handle(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_dispatch']
pub fn vphp_wrap_vslim_app_dispatch(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'method', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'rawPath', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'method').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'rawPath').as_v[string]()
    res := recv.dispatch(arg_0, arg_1)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_app_dispatch_body']
pub fn vphp_wrap_vslim_app_dispatch_body(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'method', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'rawPath', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'body', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'method').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'rawPath').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'body').as_v[string]()
    res := recv.dispatch_body(arg_0, arg_1, arg_2)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_app_dispatch_request']
pub fn vphp_wrap_vslim_app_dispatch_request(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'req', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'req').to_v_ptr[httpx.VSlimRequest]() or {
        vphp.throw_exception('argument 0 must be object bound to httpx.VSlimRequest, got ' + php_args.at_named_or_index(0, 'req').zval().type_name(), 0)
        return
    }
    arg_0 := unsafe { &httpx.VSlimRequest(arg_0_ptr) }
    res := recv.dispatch_request(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_app_dispatch_envelope']
pub fn vphp_wrap_vslim_app_dispatch_envelope(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'envelope', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'envelope').value
    res := recv.dispatch_envelope(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_app_dispatch_envelope_worker']
pub fn vphp_wrap_vslim_app_dispatch_envelope_worker(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'envelope', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'envelope').value
    res := recv.dispatch_envelope_worker(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_app_dispatch_envelope_map']
pub fn vphp_wrap_vslim_app_dispatch_envelope_map(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'envelope', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'envelope').value
    res := recv.dispatch_envelope_map(arg_0)
    ctx.return().v[map[string]string](res)
}
@[export: 'vphp_wrap_vslim_app_set_base_path']
pub fn vphp_wrap_vslim_app_set_base_path(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'basePath', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'basePath').as_v[string]()
    res := recv.set_base_path(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_has_container']
pub fn vphp_wrap_vslim_app_has_container(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_container()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_set_container']
pub fn vphp_wrap_vslim_app_set_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
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
@[export: 'vphp_wrap_vslim_app_container']
pub fn vphp_wrap_vslim_app_container(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.container()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_has_config']
pub fn vphp_wrap_vslim_app_has_config(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_config()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_set_config']
pub fn vphp_wrap_vslim_app_set_config(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'config', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_ptr := php_args.at_named_or_index(0, 'config').to_v_ptr[configx.VSlimConfig]() or {
        vphp.throw_exception('argument 0 must be object bound to configx.VSlimConfig, got ' + php_args.at_named_or_index(0, 'config').zval().type_name(), 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    arg_0 := unsafe { &configx.VSlimConfig(arg_0_ptr) }
    res := recv.set_config(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_config']
pub fn vphp_wrap_vslim_app_config(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.config()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_load_config']
pub fn vphp_wrap_vslim_app_load_config(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.load_config(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_load_config_text']
pub fn vphp_wrap_vslim_app_load_config_text(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'text', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'text').as_v[string]()
    res := recv.load_config_text(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_merge_config']
pub fn vphp_wrap_vslim_app_merge_config(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.merge_config(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_merge_config_text']
pub fn vphp_wrap_vslim_app_merge_config_text(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'text', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'text').as_v[string]()
    res := recv.merge_config_text(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_validate']
pub fn vphp_wrap_vslim_app_validate(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'data', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'rules', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'data').value
    arg_1 := php_args.at_named_or_index(1, 'rules').array() or {
        vphp.throw_exception('argument 1 must be array', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.validate(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_testing']
pub fn vphp_wrap_vslim_app_testing(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.testing()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_session']
pub fn vphp_wrap_vslim_app_session(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
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
    res := recv.session(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_auth']
pub fn vphp_wrap_vslim_app_auth(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
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
    res := recv.auth(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_set_auth_user_resolver']
pub fn vphp_wrap_vslim_app_set_auth_user_resolver(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resolver', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resolver').callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.set_auth_user_resolver(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_set_auth_user_provider']
pub fn vphp_wrap_vslim_app_set_auth_user_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'provider', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'provider').value
    res := recv.set_auth_user_provider(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_set_auth_gate_resolver']
pub fn vphp_wrap_vslim_app_set_auth_gate_resolver(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'resolver', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'resolver').callable() or {
        vphp.throw_exception('argument 0 must be callable', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.set_auth_gate_resolver(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_set_auth_redirect_path']
pub fn vphp_wrap_vslim_app_set_auth_redirect_path(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'path', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'path').as_v[string]()
    res := recv.set_auth_redirect_path(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_has_auth_user_provider']
pub fn vphp_wrap_vslim_app_has_auth_user_provider(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.has_auth_user_provider()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_auth_redirect_to']
pub fn vphp_wrap_vslim_app_auth_redirect_to(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.auth_redirect_to()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_app_resolve_auth_user']
pub fn vphp_wrap_vslim_app_resolve_auth_user(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'userId', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'userId').as_v[string]()
    res := recv.resolve_auth_user(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_app_auth_user']
pub fn vphp_wrap_vslim_app_auth_user(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    res := recv.auth_user(arg_0)
    ctx.return().v[vphp.PhpValue](res)
}
@[export: 'vphp_wrap_vslim_app_auth_check']
pub fn vphp_wrap_vslim_app_auth_check(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    res := recv.auth_check(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_auth_guest']
pub fn vphp_wrap_vslim_app_auth_guest(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    res := recv.auth_guest(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_auth_id']
pub fn vphp_wrap_vslim_app_auth_id(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    res := recv.auth_id(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_app_login']
pub fn vphp_wrap_vslim_app_login(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'response', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'userId', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    arg_1 := php_args.at_named_or_index(1, 'response').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return
    }
    arg_2 := php_args.at_named_or_index(2, 'userId').as_v[string]()
    res := recv.login(arg_0, arg_1, arg_2)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_logout']
pub fn vphp_wrap_vslim_app_logout(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'request', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'response', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'request').object() or {
        vphp.throw_exception('argument 0 must be object', 0)
        return
    }
    arg_1 := php_args.at_named_or_index(1, 'response').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return
    }
    res := recv.logout(arg_0, arg_1)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_can']
pub fn vphp_wrap_vslim_app_can(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'ability', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'ability').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'request').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return
    }
    res := recv.can(arg_0, arg_1)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_cannot']
pub fn vphp_wrap_vslim_app_cannot(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'ability', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'request', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'ability').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'request').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return
    }
    res := recv.cannot(arg_0, arg_1)
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_start_session_middleware']
pub fn vphp_wrap_vslim_app_start_session_middleware(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.start_session_middleware()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_auth_middleware']
pub fn vphp_wrap_vslim_app_auth_middleware(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.auth_middleware()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_guest_middleware']
pub fn vphp_wrap_vslim_app_guest_middleware(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.guest_middleware()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_ability_middleware']
pub fn vphp_wrap_vslim_app_ability_middleware(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'ability', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'ability').as_v[string]()
    res := recv.ability_middleware(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_set_view_base_path']
pub fn vphp_wrap_vslim_app_set_view_base_path(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'basePath', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'basePath').as_v[string]()
    res := recv.set_view_base_path(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_view_base_path']
pub fn vphp_wrap_vslim_app_view_base_path(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.view_base_path()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_app_set_assets_prefix']
pub fn vphp_wrap_vslim_app_set_assets_prefix(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'prefix').as_v[string]()
    res := recv.set_assets_prefix(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_assets_prefix']
pub fn vphp_wrap_vslim_app_assets_prefix(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.assets_prefix()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_app_set_view_cache']
pub fn vphp_wrap_vslim_app_set_view_cache(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'enabled', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'enabled').as_v[bool]()
    res := recv.set_view_cache(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_view_cache_enabled']
pub fn vphp_wrap_vslim_app_view_cache_enabled(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.view_cache_enabled()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_clear_view_cache']
pub fn vphp_wrap_vslim_app_clear_view_cache(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.clear_view_cache()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_helper']
pub fn vphp_wrap_vslim_app_helper(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'name', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'name').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').callable() or {
        vphp.throw_exception('argument 1 must be callable', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.helper(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_make_view']
pub fn vphp_wrap_vslim_app_make_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.make_view()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_view']
pub fn vphp_wrap_vslim_app_view(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'data', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'template').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'data').value
    res := recv.view(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_view_with_layout']
pub fn vphp_wrap_vslim_app_view_with_layout(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'template', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'layout', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'data', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'template').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'layout').as_v[string]()
    arg_2 := php_args.at_named_or_index(2, 'data').value
    res := recv.view_with_layout(arg_0, arg_1, arg_2)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_demo']
pub fn vphp_wrap_vslim_app_demo(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimApp.demo()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_group_middleware']
pub fn vphp_wrap_vslim_app_group_middleware(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'prefix').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.group_middleware(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_group_before']
pub fn vphp_wrap_vslim_app_group_before(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'prefix').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.group_before(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_group_after']
pub fn vphp_wrap_vslim_app_group_after(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'handler', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'prefix').as_v[string]()
    arg_1 := php_args.at_named_or_index(1, 'handler').value
    res := recv.group_after(arg_0, arg_1)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_register']
pub fn vphp_wrap_vslim_app_register(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'provider', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'provider').value
    res := recv.register(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_register_many']
pub fn vphp_wrap_vslim_app_register_many(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'providers', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'providers').iterable() or {
        vphp.throw_exception('argument 0 must be iterable', 0)
        return // SAFETY: nil literal in unsafe context
	unsafe { nil }
    }
    res := recv.register_many(arg_0)
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_boot']
pub fn vphp_wrap_vslim_app_boot(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.boot()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_app_is_booted']
pub fn vphp_wrap_vslim_app_is_booted(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.is_booted()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_app_provider_count']
pub fn vphp_wrap_vslim_app_provider_count(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.provider_count()
    ctx.return().v[int](res)
}
@[export: 'vphp_wrap_vslim_app_has_provider']
pub fn vphp_wrap_vslim_app_has_provider(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimApp(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'className', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'className').as_v[string]()
    res := recv.has_provider(arg_0)
    ctx.return().v[bool](res)
}
@[export: 'vslim_app_handlers']
pub fn vslim_app_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_app_get_prop),
        write_handler: voidptr(vslim_app_set_prop),
        sync_handler: voidptr(vslim_app_sync_props),
        new_raw: voidptr(vslim_app_new_raw),
        cleanup_raw: voidptr(vslim_app_cleanup_raw),
        free_raw: voidptr(vslim_app_free_raw)
    )
}
pub fn VSlimApp.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__app_ce)
}

pub fn VSlimApp.php_object_handlers() object.ObjectHandlers {
    return object.ObjectHandlers.from_ptr(vslim_app_handlers())
}

pub fn VSlimApp.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimApp](v_ptr, ownership)
}

pub fn (obj &VSlimApp) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimApp](obj)
}

pub fn (obj &VSlimApp) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimApp](obj)
}

pub fn (obj &VSlimApp) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimApp](obj)
}

pub fn (obj &VSlimApp) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimApp](obj)
}

pub fn (val VSlimApp) php_class_name() string {
    return 'VSlim\\App'
}

