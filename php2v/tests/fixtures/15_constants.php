<?php
// 1. 测试魔术常量
echo "DIR: " . __DIR__ . "\n";
echo "FILE: " . __FILE__ . "\n";
echo "LINE: " . __LINE__ . "\n";

// 2. 测试 const 编译期常量
const APP_ENV = 'production';
echo "ENV: " . APP_ENV . "\n";

// 3. 测试运行时 define 函数常量
define('DB_PORT', 3306);
echo "PORT: " . DB_PORT . "\n";
