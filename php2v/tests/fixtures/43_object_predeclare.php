<?php
// 回归测试：类实例对象做局部变量时，应被前置预声明为 &Class_Xxx(unsafe { nil })，
// 以允许安全赋值原生指针，并在其上原生调用方法。

class WP_List_Util {
    public function filter($args) {
        return $args;
    }
}

function test_object_predeclare($args) {
    // $util 被推导为 WP_List_Util 实例类型
    // 在进入 test_object_predeclare 前应被预定义为 mut var_util := &Class_WP_List_Util(unsafe { nil })
    $util = new WP_List_Util();
    // 方法调用应原生生成为 var_util.filter(...)
    return $util->filter($args);
}
