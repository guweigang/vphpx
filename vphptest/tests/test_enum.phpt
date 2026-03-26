--TEST--
test_enum: PHP 8.1 native backed enum support
--FILE--
<?php
// --- Basic: enum cases are objects, not integers ---
$draft = ArticleStatus::draft;
$review = ArticleStatus::review;
$published = ArticleStatus::published;

echo "draft.name=" . $draft->name . PHP_EOL;
echo "draft.value=" . $draft->value . PHP_EOL;
echo "review.name=" . $review->name . PHP_EOL;
echo "review.value=" . $review->value . PHP_EOL;
echo "published.name=" . $published->name . PHP_EOL;
echo "published.value=" . $published->value . PHP_EOL;

// --- instanceof checks ---
echo "isBackedEnum=" . ($draft instanceof \BackedEnum ? 'yes' : 'no') . PHP_EOL;
echo "isUnitEnum=" . ($draft instanceof \UnitEnum ? 'yes' : 'no') . PHP_EOL;

// --- from() and tryFrom() ---
$fromZero = ArticleStatus::from(0);
echo "from(0).name=" . $fromZero->name . PHP_EOL;
echo "from(0)==draft=" . ($fromZero === $draft ? 'yes' : 'no') . PHP_EOL;

$tryValid = ArticleStatus::tryFrom(2);
echo "tryFrom(2).name=" . $tryValid->name . PHP_EOL;

$tryInvalid = ArticleStatus::tryFrom(99);
echo "tryFrom(99)=null=" . (is_null($tryInvalid) ? 'yes' : 'no') . PHP_EOL;

// --- from() with invalid value throws ValueError ---
$caught = false;
try {
    ArticleStatus::from(99);
} catch (\ValueError $e) {
    $caught = true;
}
echo "from(99)_throws=" . ($caught ? 'yes' : 'no') . PHP_EOL;

// --- cases() ---
$cases = ArticleStatus::cases();
echo "cases_count=" . count($cases) . PHP_EOL;
echo "cases[0].name=" . $cases[0]->name . PHP_EOL;
echo "cases[1].name=" . $cases[1]->name . PHP_EOL;
echo "cases[2].name=" . $cases[2]->name . PHP_EOL;

// --- Reflection: it's an enum, not a class ---
$rc = new ReflectionEnum(ArticleStatus::class);
echo "isEnum=" . ($rc->isEnum() ? 'yes' : 'no') . PHP_EOL;
echo "isBacked=" . ($rc->isBacked() ? 'yes' : 'no') . PHP_EOL;
echo "backingType=" . $rc->getBackingType() . PHP_EOL;
?>
--EXPECT--
draft.name=draft
draft.value=0
review.name=review
review.value=1
published.name=published
published.value=2
isBackedEnum=yes
isUnitEnum=yes
from(0).name=draft
from(0)==draft=yes
tryFrom(2).name=published
tryFrom(99)=null=yes
from(99)_throws=yes
cases_count=3
cases[0].name=draft
cases[1].name=review
cases[2].name=published
isEnum=yes
isBacked=yes
backingType=int
