<?php
class MyIterator implements Iterator {
    private $items = ['apple', 'banana', 'cherry'];
    private $position = 0;

    public function rewind(): void {
        $this->position = 0;
    }

    public function current(): mixed {
        return $this->items[$this->position];
    }

    public function key(): mixed {
        return $this->position;
    }

    public function next(): void {
        ++$this->position;
    }

    public function valid(): bool {
        return $this->position < count($this->items);
    }
}

$iter = new MyIterator();
foreach ($iter as $k => $v) {
    echo $k . ": " . $v . "\n";
}
