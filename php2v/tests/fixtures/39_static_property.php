<?php
// 测试：静态属性访问 ClassName::$prop
// 源自 WordPress 中大量使用的 static property fetch 模式

class Database {
    public static $connection = null;
    public static $config = ['host' => 'localhost'];
    
    public static function connect() {
        self::$connection = 'connected';
        return self::$connection;
    }
}

function get_connection() {
    return Database::$connection;
}

function get_config_value($key) {
    return Database::$config[$key] ?? 'default';
}
