module module_probex

import vphp

import eventx
import httpx

#include "php_bridge.h"

__global C.vslim__compiler__moduleprobereadonlybox_ce &C.zend_class_entry
__global C.vslim__compiler__moduleprobebox_ce &C.zend_class_entry
__global C.vslim__compiler__moduleprobetypedconsts_ce &C.zend_class_entry
__global C.vslim__compiler__moduleprobewrapperbox_ce &C.zend_class_entry
__global C.vslim__dev__phpsignatureprobe_ce &C.zend_class_entry
__global C.vslim__debug__objectprobe_ce &C.zend_class_entry

@[export: 'vslim_module_probe_read_only_box_new_raw']
pub fn vslim_module_probe_read_only_box_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimModuleProbeReadOnlyBox]()
}
@[export: 'vslim_module_probe_read_only_box_free_raw']
pub fn vslim_module_probe_read_only_box_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimModuleProbeReadOnlyBox](ptr)
}
@[export: 'vslim_module_probe_read_only_box_cleanup_raw']
pub fn vslim_module_probe_read_only_box_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_module_probe_read_only_box_get_prop']
pub fn vslim_module_probe_read_only_box_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimModuleProbeReadOnlyBox(ptr)
        if name == 'title' {
            ret.v[string](obj.title)
            return
        }
        if name == 'value' {
            ret.v[i64](i64(obj.value))
            return
        }
    }
}
@[export: 'vslim_module_probe_read_only_box_set_prop']
pub fn vslim_module_probe_read_only_box_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_module_probe_read_only_box_sync_props']
pub fn vslim_module_probe_read_only_box_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimModuleProbeReadOnlyBox(ptr)
        out.add_property_string('title', obj.title)
        out.add_property_long('value', i64(obj.value))
    }
}
@[export: 'vslim_module_probe_read_only_box_handlers']
pub fn vslim_module_probe_read_only_box_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_module_probe_read_only_box_get_prop),
        write_handler: voidptr(vslim_module_probe_read_only_box_set_prop),
        sync_handler: voidptr(vslim_module_probe_read_only_box_sync_props),
        new_raw: voidptr(vslim_module_probe_read_only_box_new_raw),
        cleanup_raw: voidptr(vslim_module_probe_read_only_box_cleanup_raw),
        free_raw: voidptr(vslim_module_probe_read_only_box_free_raw)
    )
}
pub fn VSlimModuleProbeReadOnlyBox.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__compiler__moduleprobereadonlybox_ce)
}

pub fn VSlimModuleProbeReadOnlyBox.php_object_handlers() voidptr {
    return vslim_module_probe_read_only_box_handlers()
}

pub fn VSlimModuleProbeReadOnlyBox.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimModuleProbeReadOnlyBox](v_ptr, ownership)
}

pub fn (obj &VSlimModuleProbeReadOnlyBox) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimModuleProbeReadOnlyBox](obj)
}

pub fn (obj &VSlimModuleProbeReadOnlyBox) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimModuleProbeReadOnlyBox](obj)
}

pub fn (obj &VSlimModuleProbeReadOnlyBox) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimModuleProbeReadOnlyBox](obj)
}

pub fn (obj &VSlimModuleProbeReadOnlyBox) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimModuleProbeReadOnlyBox](obj)
}

pub fn (val VSlimModuleProbeReadOnlyBox) php_class_name() string {
    return 'VSlim\\Compiler\\ModuleProbeReadOnlyBox'
}

@[export: 'vslim_module_probe_box_new_raw']
pub fn vslim_module_probe_box_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimModuleProbeBox]()
}
@[export: 'vslim_module_probe_box_free_raw']
pub fn vslim_module_probe_box_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimModuleProbeBox](ptr)
}
@[export: 'vslim_module_probe_box_cleanup_raw']
pub fn vslim_module_probe_box_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_module_probe_box_get_prop']
pub fn vslim_module_probe_box_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
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
@[export: 'vslim_module_probe_box_set_prop']
pub fn vslim_module_probe_box_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
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
@[export: 'vslim_module_probe_box_sync_props']
pub fn vslim_module_probe_box_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimModuleProbeBox(ptr)
        out.add_property_string('name', obj.name)
        out.add_property_long('count', i64(obj.count))
    }
}
@[export: 'vphp_wrap_vslim_module_probe_box_test_sumtype']
pub fn vphp_wrap_vslim_module_probe_box_test_sumtype(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimModuleProbeBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'val', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'val').as_v[module_probex.VSlimModuleProbeSum]()
    res := recv.test_sumtype(arg_0)
    ctx.return().v[module_probex.VSlimModuleProbeSum](res)
}
@[export: 'vphp_wrap_vslim_module_probe_box_test_enum_echo']
pub fn vphp_wrap_vslim_module_probe_box_test_enum_echo(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimModuleProbeBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'kind', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'kind').as_v[module_probex.VSlimModuleProbeKind]()
    res := recv.test_enum_echo(arg_0)
    ctx.return().v[module_probex.VSlimModuleProbeKind](res)
}
@[export: 'vphp_wrap_vslim_module_probe_box_test_sumtype_echo']
pub fn vphp_wrap_vslim_module_probe_box_test_sumtype_echo(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimModuleProbeBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'val', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'val').as_v[module_probex.VSlimModuleProbeSumType]()
    res := recv.test_sumtype_echo(arg_0)
    ctx.return().v[module_probex.VSlimModuleProbeSumType](res)
}
@[export: 'vphp_wrap_vslim_module_probe_box_test_variadic']
pub fn vphp_wrap_vslim_module_probe_box_test_variadic(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimModuleProbeBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'sep', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'args', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'sep').as_v[string]()
    arg_1 := php_args.as_variadic_v[string](1)
    res := recv.test_variadic(arg_0, ...arg_1)
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_module_probe_box_label']
pub fn vphp_wrap_vslim_module_probe_box_label(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimModuleProbeBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.label()
    ctx.return().v[string](res)
}
@[export: 'vphp_wrap_vslim_module_probe_box_static_label']
pub fn vphp_wrap_vslim_module_probe_box_static_label(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimModuleProbeBox.static_label()
    ctx.return().v[string](res)
}
@[export: 'vslim_module_probe_box_handlers']
pub fn vslim_module_probe_box_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_module_probe_box_get_prop),
        write_handler: voidptr(vslim_module_probe_box_set_prop),
        sync_handler: voidptr(vslim_module_probe_box_sync_props),
        new_raw: voidptr(vslim_module_probe_box_new_raw),
        cleanup_raw: voidptr(vslim_module_probe_box_cleanup_raw),
        free_raw: voidptr(vslim_module_probe_box_free_raw)
    )
}
pub fn VSlimModuleProbeBox.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__compiler__moduleprobebox_ce)
}

pub fn VSlimModuleProbeBox.php_object_handlers() voidptr {
    return vslim_module_probe_box_handlers()
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

pub fn (val VSlimModuleProbeBox) php_class_name() string {
    return 'VSlim\\Compiler\\ModuleProbeBox'
}

@[export: 'vslim_module_probe_typed_consts_new_raw']
pub fn vslim_module_probe_typed_consts_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimModuleProbeTypedConsts]()
}
@[export: 'vslim_module_probe_typed_consts_free_raw']
pub fn vslim_module_probe_typed_consts_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimModuleProbeTypedConsts](ptr)
}
@[export: 'vslim_module_probe_typed_consts_cleanup_raw']
pub fn vslim_module_probe_typed_consts_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_module_probe_typed_consts_get_prop']
pub fn vslim_module_probe_typed_consts_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_module_probe_typed_consts_set_prop']
pub fn vslim_module_probe_typed_consts_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_module_probe_typed_consts_sync_props']
pub fn vslim_module_probe_typed_consts_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
pub fn VSlimModuleProbeTypedConsts.consts() VSlimModuleProbeConsts {
    return vslim_module_probe_consts
}
@[export: 'vslim_module_probe_typed_consts_handlers']
pub fn vslim_module_probe_typed_consts_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_module_probe_typed_consts_get_prop),
        write_handler: voidptr(vslim_module_probe_typed_consts_set_prop),
        sync_handler: voidptr(vslim_module_probe_typed_consts_sync_props),
        new_raw: voidptr(vslim_module_probe_typed_consts_new_raw),
        cleanup_raw: voidptr(vslim_module_probe_typed_consts_cleanup_raw),
        free_raw: voidptr(vslim_module_probe_typed_consts_free_raw)
    )
}
pub fn VSlimModuleProbeTypedConsts.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__compiler__moduleprobetypedconsts_ce)
}

pub fn VSlimModuleProbeTypedConsts.php_object_handlers() voidptr {
    return vslim_module_probe_typed_consts_handlers()
}

pub fn VSlimModuleProbeTypedConsts.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimModuleProbeTypedConsts](v_ptr, ownership)
}

pub fn (obj &VSlimModuleProbeTypedConsts) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimModuleProbeTypedConsts](obj)
}

pub fn (obj &VSlimModuleProbeTypedConsts) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimModuleProbeTypedConsts](obj)
}

pub fn (obj &VSlimModuleProbeTypedConsts) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimModuleProbeTypedConsts](obj)
}

pub fn (obj &VSlimModuleProbeTypedConsts) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimModuleProbeTypedConsts](obj)
}

pub fn (val VSlimModuleProbeTypedConsts) php_class_name() string {
    return 'VSlim\\Compiler\\ModuleProbeTypedConsts'
}

@[export: 'vslim_module_probe_wrapper_box_new_raw']
pub fn vslim_module_probe_wrapper_box_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimModuleProbeWrapperBox]()
}
@[export: 'vslim_module_probe_wrapper_box_free_raw']
pub fn vslim_module_probe_wrapper_box_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimModuleProbeWrapperBox](ptr)
}
@[export: 'vslim_module_probe_wrapper_box_cleanup_raw']
pub fn vslim_module_probe_wrapper_box_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_module_probe_wrapper_box_get_prop']
pub fn vslim_module_probe_wrapper_box_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    ret := vphp.PhpObjectPropertyHandler.return_from_ptr(rv)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        obj := &VSlimModuleProbeWrapperBox(ptr)
        if name == 'val' {
            ret.v[vphp.PhpValue](obj.val)
            return
        }
        if name == 'obj' {
            ret.v[vphp.PhpObject](obj.obj)
            return
        }
        if name == 'str' {
            ret.v[vphp.PhpString](obj.str)
            return
        }
        if name == 'num' {
            ret.v[vphp.PhpInt](obj.num)
            return
        }
        if name == 'b' {
            ret.v[vphp.PhpBool](obj.b)
            return
        }
        if name == 'arr' {
            ret.v[vphp.PhpArray](obj.arr)
            return
        }
    }
}
@[export: 'vslim_module_probe_wrapper_box_set_prop']
pub fn vslim_module_probe_wrapper_box_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    arg := vphp.PhpObjectPropertyHandler.value_from_ptr(value)
    unsafe {
        name := vphp.PhpObjectPropertyHandler.name_from_ptr(name_ptr, name_len)
        mut obj := &VSlimModuleProbeWrapperBox(ptr)
        if name == 'val' {
            obj.val = vphp.PhpValue.from_zval(arg).retain()
            return
        }
        if name == 'obj' {
            obj.obj = (vphp.PhpObject.from_zval(arg) or { vphp.PhpObject.invalid() }).retain()
            return
        }
        if name == 'str' {
            obj.str = vphp.PhpString.coerce(arg).retain()
            return
        }
        if name == 'num' {
            obj.num = vphp.PhpInt.coerce(arg).retain()
            return
        }
        if name == 'b' {
            obj.b = vphp.PhpBool.coerce(arg).retain()
            return
        }
        if name == 'arr' {
            obj.arr = (vphp.PhpArray.from_zval(arg) or { vphp.PhpArray.empty() }).retain()
            return
        }
    }
}
@[export: 'vslim_module_probe_wrapper_box_sync_props']
pub fn vslim_module_probe_wrapper_box_sync_props(ptr voidptr, zv &C.zval) {
    out := vphp.PhpObjectPropertyHandler.value_from_ptr(zv)
    unsafe {
        obj := &VSlimModuleProbeWrapperBox(ptr)
        out.set_prop('val', obj.val.to_zval())
        out.set_prop('obj', obj.obj.to_zval())
        out.set_prop('str', obj.str.to_zval())
        out.set_prop('num', obj.num.to_zval())
        out.set_prop('b', obj.b.to_zval())
        out.set_prop('arr', obj.arr.to_zval())
    }
}
@[export: 'vphp_wrap_vslim_module_probe_wrapper_box_change_props']
pub fn vphp_wrap_vslim_module_probe_wrapper_box_change_props(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimModuleProbeWrapperBox(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'newVal', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'newObj', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 2, name: 'newStr', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 3, name: 'newNum', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 4, name: 'newB', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 5, name: 'newArr', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'newVal').value
    arg_1 := php_args.at_named_or_index(1, 'newObj').object() or {
        vphp.throw_exception('argument 1 must be object', 0)
        return
    }
    arg_2 := php_args.at_named_or_index(2, 'newStr').string_value() or {
        vphp.throw_exception('argument 2 must be string', 0)
        return
    }
    arg_3 := php_args.at_named_or_index(3, 'newNum').int_value() or {
        vphp.throw_exception('argument 3 must be int', 0)
        return
    }
    arg_4 := php_args.at_named_or_index(4, 'newB').bool_value() or {
        vphp.throw_exception('argument 4 must be bool', 0)
        return
    }
    arg_5 := php_args.at_named_or_index(5, 'newArr').array() or {
        vphp.throw_exception('argument 5 must be array', 0)
        return
    }
    recv.change_props(arg_0, arg_1, arg_2, arg_3, arg_4, arg_5)
}
@[export: 'vslim_module_probe_wrapper_box_handlers']
pub fn vslim_module_probe_wrapper_box_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_module_probe_wrapper_box_get_prop),
        write_handler: voidptr(vslim_module_probe_wrapper_box_set_prop),
        sync_handler: voidptr(vslim_module_probe_wrapper_box_sync_props),
        new_raw: voidptr(vslim_module_probe_wrapper_box_new_raw),
        cleanup_raw: voidptr(vslim_module_probe_wrapper_box_cleanup_raw),
        free_raw: voidptr(vslim_module_probe_wrapper_box_free_raw)
    )
}
pub fn VSlimModuleProbeWrapperBox.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__compiler__moduleprobewrapperbox_ce)
}

pub fn VSlimModuleProbeWrapperBox.php_object_handlers() voidptr {
    return vslim_module_probe_wrapper_box_handlers()
}

pub fn VSlimModuleProbeWrapperBox.php_object_zval(v_ptr voidptr, ownership vphp.OwnershipKind) vphp.ZVal {
    return vphp.bind_object_zval[VSlimModuleProbeWrapperBox](v_ptr, ownership)
}

pub fn (obj &VSlimModuleProbeWrapperBox) bind_php_object() vphp.ZVal {
    return vphp.bind_borrowed_object_zval[VSlimModuleProbeWrapperBox](obj)
}

pub fn (obj &VSlimModuleProbeWrapperBox) bind_php_object_value() vphp.PhpValue {
    return vphp.bind_borrowed_object_value[VSlimModuleProbeWrapperBox](obj)
}

pub fn (obj &VSlimModuleProbeWrapperBox) bind_owned_php_object() vphp.ZVal {
    return vphp.bind_owned_object_zval[VSlimModuleProbeWrapperBox](obj)
}

pub fn (obj &VSlimModuleProbeWrapperBox) bind_owned_php_object_value() vphp.PhpValue {
    return vphp.bind_owned_object_value[VSlimModuleProbeWrapperBox](obj)
}

pub fn (val VSlimModuleProbeWrapperBox) php_class_name() string {
    return 'VSlim\\Compiler\\ModuleProbeWrapperBox'
}

@[export: 'vslim_php_signature_probe_new_raw']
pub fn vslim_php_signature_probe_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimPhpSignatureProbe]()
}
@[export: 'vslim_php_signature_probe_free_raw']
pub fn vslim_php_signature_probe_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimPhpSignatureProbe](ptr)
}
@[export: 'vslim_php_signature_probe_cleanup_raw']
pub fn vslim_php_signature_probe_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_php_signature_probe_get_prop']
pub fn vslim_php_signature_probe_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_php_signature_probe_set_prop']
pub fn vslim_php_signature_probe_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_php_signature_probe_sync_props']
pub fn vslim_php_signature_probe_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_php_signature_probe_construct']
pub fn vphp_wrap_vslim_php_signature_probe_construct(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.construct()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_always_true']
pub fn vphp_wrap_vslim_php_signature_probe_always_true(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.always_true()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_always_false']
pub fn vphp_wrap_vslim_php_signature_probe_always_false(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.always_false()
    ctx.return().v[bool](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_always_null']
pub fn vphp_wrap_vslim_php_signature_probe_always_null(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.always_null()
    ctx.return().v[vphp.PhpNull](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_always_throw']
pub fn vphp_wrap_vslim_php_signature_probe_always_throw(ptr voidptr, ctx vphp.Context)  {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.always_throw()
    ctx.return().v[vphp.PhpNull](res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_accept_true']
pub fn vphp_wrap_vslim_php_signature_probe_accept_true(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_accept_false']
pub fn vphp_wrap_vslim_php_signature_probe_accept_false(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_accept_null']
pub fn vphp_wrap_vslim_php_signature_probe_accept_null(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_accept_callable']
pub fn vphp_wrap_vslim_php_signature_probe_accept_callable(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_optional_tail']
pub fn vphp_wrap_vslim_php_signature_probe_optional_tail(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_make_psr_response']
pub fn vphp_wrap_vslim_php_signature_probe_make_psr_response(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.make_psr_response()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_make_static_psr_response']
pub fn vphp_wrap_vslim_php_signature_probe_make_static_psr_response(ctx vphp.Context) voidptr {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := VSlimPhpSignatureProbe.make_static_psr_response()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_accept_psr_request']
pub fn vphp_wrap_vslim_php_signature_probe_accept_psr_request(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_accept_datetime_interface']
pub fn vphp_wrap_vslim_php_signature_probe_accept_datetime_interface(ptr voidptr, ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_set_provider']
pub fn vphp_wrap_vslim_php_signature_probe_set_provider(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_alias']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider_alias()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_guard']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_guard(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider_from_guard()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_if_expr']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_if_expr(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_if_expr_alias']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_if_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_match_expr']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_match_expr(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_match_expr_alias']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_match_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_or_block']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_or_block(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider_from_or_block()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_or_block_alias']
pub fn vphp_wrap_vslim_php_signature_probe_borrowed_provider_from_or_block_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.borrowed_provider_from_or_block_alias()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.fresh_provider()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider_alias']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.fresh_provider_alias()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider_from_if_expr']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider_from_if_expr(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider_from_if_expr_alias']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider_from_if_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider_from_match_expr']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider_from_match_expr(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider_from_match_expr_alias']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider_from_match_expr_alias(ptr voidptr, ctx vphp.Context) voidptr {
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
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider_from_or_block']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider_from_or_block(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.fresh_provider_from_or_block()
    return voidptr(res)
}
@[export: 'vphp_wrap_vslim_php_signature_probe_fresh_provider_from_or_block_alias']
pub fn vphp_wrap_vslim_php_signature_probe_fresh_provider_from_or_block_alias(ptr voidptr, ctx vphp.Context) voidptr {
    mut recv := unsafe { &VSlimPhpSignatureProbe(ptr) }
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := recv.fresh_provider_from_or_block_alias()
    return voidptr(res)
}
@[export: 'vslim_php_signature_probe_handlers']
pub fn vslim_php_signature_probe_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_php_signature_probe_get_prop),
        write_handler: voidptr(vslim_php_signature_probe_set_prop),
        sync_handler: voidptr(vslim_php_signature_probe_sync_props),
        new_raw: voidptr(vslim_php_signature_probe_new_raw),
        cleanup_raw: voidptr(vslim_php_signature_probe_cleanup_raw),
        free_raw: voidptr(vslim_php_signature_probe_free_raw)
    )
}
pub fn VSlimPhpSignatureProbe.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__dev__phpsignatureprobe_ce)
}

pub fn VSlimPhpSignatureProbe.php_object_handlers() voidptr {
    return vslim_php_signature_probe_handlers()
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

pub fn (val VSlimPhpSignatureProbe) php_class_name() string {
    return 'VSlim\\Dev\\PhpSignatureProbe'
}

@[export: 'vslim_debug_object_probe_new_raw']
pub fn vslim_debug_object_probe_new_raw() voidptr {
    return vphp.generic_new_raw[VSlimDebugObjectProbe]()
}
@[export: 'vslim_debug_object_probe_free_raw']
pub fn vslim_debug_object_probe_free_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
    vphp.generic_free_raw[VSlimDebugObjectProbe](ptr)
}
@[export: 'vslim_debug_object_probe_cleanup_raw']
pub fn vslim_debug_object_probe_cleanup_raw(ptr voidptr) {
    if ptr == 0 {
        return
    }
}
@[export: 'vslim_debug_object_probe_get_prop']
pub fn vslim_debug_object_probe_get_prop(ptr voidptr, name_ptr &char, name_len int, rv &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = rv
}
@[export: 'vslim_debug_object_probe_set_prop']
pub fn vslim_debug_object_probe_set_prop(ptr voidptr, name_ptr &char, name_len int, value &C.zval) {
    _ = ptr
    _ = name_ptr
    _ = name_len
    _ = value
}
@[export: 'vslim_debug_object_probe_sync_props']
pub fn vslim_debug_object_probe_sync_props(ptr voidptr, zv &C.zval) {
    _ = ptr
    _ = zv
}
@[export: 'vphp_wrap_vslim_debug_object_probe_probe']
pub fn vphp_wrap_vslim_debug_object_probe_probe(ctx vphp.Context)  {
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
@[export: 'vphp_wrap_vslim_debug_object_probe_psr7_lifecycle_counters']
pub fn vphp_wrap_vslim_debug_object_probe_psr7_lifecycle_counters(ctx vphp.Context)  {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'rounds', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.at_named_or_index(0, 'rounds').as_v[int]()
    res := VSlimDebugObjectProbe.psr7_lifecycle_counters(arg_0)
    ctx.return().v[string](res)
}
@[export: 'vslim_debug_object_probe_handlers']
pub fn vslim_debug_object_probe_handlers() voidptr {
    return vphp.ZendClassHandlers.new(
        prop_handler: voidptr(vslim_debug_object_probe_get_prop),
        write_handler: voidptr(vslim_debug_object_probe_set_prop),
        sync_handler: voidptr(vslim_debug_object_probe_sync_props),
        new_raw: voidptr(vslim_debug_object_probe_new_raw),
        cleanup_raw: voidptr(vslim_debug_object_probe_cleanup_raw),
        free_raw: voidptr(vslim_debug_object_probe_free_raw)
    )
}
pub fn VSlimDebugObjectProbe.php_class_entry() vphp.ZendClassEntry {
    return vphp.ZendClassEntry.from_ptr(C.vslim__debug__objectprobe_ce)
}

pub fn VSlimDebugObjectProbe.php_object_handlers() voidptr {
    return vslim_debug_object_probe_handlers()
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

pub fn (val VSlimDebugObjectProbe) php_class_name() string {
    return 'VSlim\\Debug\\ObjectProbe'
}

@[export: 'vphp_wrap_vslim_module_probe']
fn vphp_wrap_vslim_module_probe(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    res := module_probe_value()
    ctx.return().v[string](res)
}

@[export: 'vphp_wrap_vslim_module_probe_variadic']
fn vphp_wrap_vslim_module_probe_variadic(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'args', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0 := php_args.as_variadic_v[int](0)
    res := module_probe_variadic(...arg_0)
    ctx.return().v[int](res)
}

@[export: 'vphp_wrap_vslim_module_probe_options']
fn vphp_wrap_vslim_module_probe_options(ctx vphp.Context) {
    mut vphp_scope := vphp.PhpScope.once()
    defer { vphp_scope.close() }
    php_args := ctx.args_with_meta([
        vphp.PhpArgMeta{ index: 0, name: 'prefix', attributes: []vphp.PhpAttribute{} },
        vphp.PhpArgMeta{ index: 1, name: 'count', attributes: []vphp.PhpAttribute{} },
    ])
    arg_0_params_prefix := if php_args.has_named_or_index(0, 'prefix') { php_args.at_named_or_index(0, 'prefix').as_v[string]() } else { 'default' }
    arg_0_params_count := if php_args.has_named_or_index(1, 'count') { php_args.at_named_or_index(1, 'count').as_v[int]() } else { 3 }
    arg_0_params := module_probex.VSlimModuleProbeOptions{
        prefix: arg_0_params_prefix
        count: arg_0_params_count
    }
    res := module_probe_options(arg_0_params)
    ctx.return().v[string](res)
}

pub fn (val VSlimModuleProbeKind) php_class_name() string {
    return 'VSlim\\Compiler\\ModuleProbeKind'
}

