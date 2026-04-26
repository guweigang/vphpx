--TEST--
PhpIterable wraps arrays and Traversable objects
--FILE--
<?php
echo v_php_iterable_api(['a' => 'one', 'b' => 'two']) . PHP_EOL;
echo v_php_iterable_api(new ArrayIterator(['x' => 'ten', 'y' => 'twenty'])) . PHP_EOL;
?>
--EXPECT--
iterable=true:false:2:a=one,b=two
iterable=false:true:2:x=ten,y=twenty
