<?php
declare(strict_types=1);

namespace App\Support;

final class MarkdownPreview
{
    public static function render(string $markdown): string
    {
        $source = str_replace(["\r\n", "\r"], "\n", trim($markdown));
        if ($source === '') {
            return '<p>暂无内容。</p>';
        }

        $lines = explode("\n", $source);
        $html = [];
        $paragraph = [];
        $listType = null;
        $listItems = [];
        $blockquote = [];

        $flushParagraph = static function () use (&$paragraph, &$html): void {
            if ($paragraph === []) {
                return;
            }
            $text = implode(' ', array_map('trim', $paragraph));
            $html[] = '<p>' . MarkdownPreview::renderInline($text) . '</p>';
            $paragraph = [];
        };

        $flushList = static function () use (&$listType, &$listItems, &$html): void {
            if ($listType === null || $listItems === []) {
                $listType = null;
                $listItems = [];
                return;
            }
            $items = array_map(
                static fn (string $item): string => '<li>' . MarkdownPreview::renderInline(trim($item)) . '</li>',
                $listItems
            );
            $html[] = '<' . $listType . '>' . implode('', $items) . '</' . $listType . '>';
            $listType = null;
            $listItems = [];
        };

        $flushQuote = static function () use (&$blockquote, &$html): void {
            if ($blockquote === []) {
                return;
            }
            $text = implode("\n", array_map('trim', $blockquote));
            $html[] = '<blockquote><p>' . nl2br(MarkdownPreview::renderInline($text)) . '</p></blockquote>';
            $blockquote = [];
        };

        foreach ($lines as $line) {
            $trimmed = trim($line);

            if ($trimmed === '') {
                $flushParagraph();
                $flushList();
                $flushQuote();
                continue;
            }

            if (preg_match('/^(#{1,3})\s+(.*)$/', $trimmed, $matches) === 1) {
                $flushParagraph();
                $flushList();
                $flushQuote();
                $level = strlen((string) $matches[1]);
                $html[] = '<h' . $level . '>' . self::renderInline((string) $matches[2]) . '</h' . $level . '>';
                continue;
            }

            if (preg_match('/^>\s?(.*)$/', $trimmed, $matches) === 1) {
                $flushParagraph();
                $flushList();
                $blockquote[] = (string) $matches[1];
                continue;
            }

            if (preg_match('/^[-*]\s+(.*)$/', $trimmed, $matches) === 1) {
                $flushParagraph();
                $flushQuote();
                if ($listType !== 'ul') {
                    $flushList();
                    $listType = 'ul';
                }
                $listItems[] = (string) $matches[1];
                continue;
            }

            if (preg_match('/^\d+\.\s+(.*)$/', $trimmed, $matches) === 1) {
                $flushParagraph();
                $flushQuote();
                if ($listType !== 'ol') {
                    $flushList();
                    $listType = 'ol';
                }
                $listItems[] = (string) $matches[1];
                continue;
            }

            $flushList();
            $flushQuote();
            $paragraph[] = $trimmed;
        }

        $flushParagraph();
        $flushList();
        $flushQuote();

        return implode("\n", $html);
    }

    private static function renderInline(string $text): string
    {
        $escaped = htmlspecialchars($text, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
        $escaped = preg_replace('/\*\*(.+?)\*\*/s', '<strong>$1</strong>', $escaped) ?? $escaped;
        $escaped = preg_replace('/`(.+?)`/s', '<code>$1</code>', $escaped) ?? $escaped;
        return $escaped;
    }
}
