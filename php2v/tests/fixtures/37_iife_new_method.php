<?php
// 测试：new ClassName()->method() 模式（IIFE）
// 源自 WordPress register_block_type 中 WP_Block_Type_Registry::get_instance()->register(...)

class Registry {
    private static $instance = null;
    public $items = [];

    public static function get_instance() {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function register($name, $args) {
        $this->items[$name] = $args;
        return true;
    }

    public function unregister($name) {
        unset($this->items[$name]);
        return true;
    }
}

function register_item($name, $args) {
    return Registry::get_instance()->register($name, $args);
}

function unregister_item($name) {
    return Registry::get_instance()->unregister($name);
}
