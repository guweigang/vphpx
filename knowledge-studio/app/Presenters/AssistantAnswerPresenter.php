<?php
declare(strict_types=1);

namespace App\Presenters;

final class AssistantAnswerPresenter
{
    /**
     * @param array<string, mixed> $preview
     * @param array<string, string> $copy
     * @return array<string, mixed>
     */
    public function present(array $preview, array $copy): array
    {
        $citations = array_map(function (array $citation) use ($copy): array {
            $kind = (string) ($citation['kind'] ?? '');
            $kindLabel = match ($kind) {
                'faq' => (string) ($copy['kind_faq'] ?? 'FAQ'),
                'topic' => (string) ($copy['kind_topic'] ?? 'Topic'),
                'document' => (string) ($copy['kind_document'] ?? 'document'),
                default => $kind,
            };

            return [
                'title' => (string) ($citation['title'] ?? ''),
                'kind' => $kindLabel,
                'status' => (string) ($citation['status'] ?? ''),
                'coverage_focus' => (string) ($citation['coverage_focus'] ?? ''),
                'excerpt' => (string) ($citation['excerpt'] ?? ''),
                'score' => (string) ($citation['score'] ?? ''),
                'matched_terms' => (string) ($citation['matched_terms'] ?? ''),
                'source_detail' => (string) ($citation['source_detail'] ?? ''),
            ];
        }, is_array($preview['citations'] ?? null) ? $preview['citations'] : []);

        return [
            'question' => (string) ($preview['question'] ?? ''),
            'answer' => (string) ($preview['answer'] ?? ''),
            'citations' => $citations,
            'diagnostics' => [
                'citation_count' => (string) count($citations),
                'top_score' => (string) ($citations[0]['score'] ?? '0'),
                'documents_seen' => (string) (($preview['diagnostics']['documents_seen'] ?? '0')),
                'entries_seen' => (string) (($preview['diagnostics']['entries_seen'] ?? '0')),
                'documents_ranked' => (string) (($preview['diagnostics']['documents_ranked'] ?? '0')),
                'entries_ranked' => (string) (($preview['diagnostics']['entries_ranked'] ?? '0')),
                'published_filter_used' => (string) (($preview['diagnostics']['published_filter_used'] ?? '0')),
                'fallback_used' => (string) (($preview['diagnostics']['fallback_used'] ?? '0')),
            ],
        ];
    }
}
