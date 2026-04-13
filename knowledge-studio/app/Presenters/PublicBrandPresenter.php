<?php
declare(strict_types=1);

namespace App\Presenters;

use App\Domain\PublicCatalog\SubscriptionOffer;
use App\Domain\PublicCatalog\WorkspacePublicSnapshot;
use App\Support\LocalizedUrlBuilder;

final class PublicBrandPresenter
{
    public function __construct(private LocalizedUrlBuilder $urls)
    {
    }

    /**
     * @param array<string, string> $copy
     * @return array<string, mixed>
     */
    public function present(WorkspacePublicSnapshot $snapshot, array $copy, string $locale): array
    {
        $slug = $snapshot->workspaceSlug();
        $assistantUrl = $slug !== '' ? $this->urls->assistant($slug, $locale) : '#';
        $publicPreview = $snapshot->publicPreview;
        $publicPreview['documents'] = array_map(function (array $item) use ($slug, $locale): array {
            $item['detail_url'] = $slug !== ''
                ? $this->urls->brandDocument($slug, (string) ($item['id'] ?? ''), $locale)
                : '#';
            return $item;
        }, is_array($publicPreview['documents'] ?? null) ? $publicPreview['documents'] : []);
        $publicPreview['entries'] = array_map(function (array $item) use ($slug, $locale): array {
            $item['detail_url'] = $slug !== ''
                ? $this->urls->brandEntry($slug, (string) ($item['id'] ?? ''), $locale)
                : '#';
            return $item;
        }, is_array($publicPreview['entries'] ?? null) ? $publicPreview['entries'] : []);

        return [
            'assistant_url' => $assistantUrl,
            'offers_title' => (string) ($copy['offers_title'] ?? ''),
            'offers_intro' => (string) ($copy['offers_intro'] ?? ''),
            'proof_title' => (string) ($copy['proof_title'] ?? ''),
            'proof_body' => (string) ($copy['proof_body'] ?? ''),
            'preview_documents_title' => (string) ($copy['preview_documents_title'] ?? ''),
            'preview_entries_title' => (string) ($copy['preview_entries_title'] ?? ''),
            'public_preview' => $publicPreview,
            'offers' => array_map(
                fn (SubscriptionOffer $offer): array => $this->offerCard($offer, $locale, $assistantUrl, $copy),
                $snapshot->offers,
            ),
        ];
    }

    /**
     * @param array<string, string> $copy
     * @return array<string, mixed>
     */
    private function offerCard(SubscriptionOffer $offer, string $locale, string $assistantUrl, array $copy): array
    {
        $isEnglish = $locale === 'en';
        $price = $offer->monthlyPrice > 0
            ? ($isEnglish ? '$' . $offer->monthlyPrice . '/mo' : '¥' . $offer->monthlyPrice . ' / 月')
            : ($isEnglish ? 'Custom' : '定制');
        $annual = $offer->annualPrice > 0
            ? ($isEnglish ? '$' . $offer->annualPrice . '/yr' : '¥' . $offer->annualPrice . ' / 年')
            : ($isEnglish ? 'Custom annual quote' : '年度定制报价');
        $seats = $offer->seatLimit > 0
            ? ($isEnglish ? $offer->seatLimit . ' editor seats' : $offer->seatLimit . ' 个知识席位')
            : ($isEnglish ? 'Flexible seat pool' : '灵活席位池');
        $questions = $offer->monthlyQuestions > 0
            ? ($isEnglish ? $offer->monthlyQuestions . ' subscriber questions / month' : $offer->monthlyQuestions . ' 次订阅提问 / 月')
            : ($isEnglish ? 'Custom usage envelope' : '按需配置调用额度');

        $features = [$seats, $questions];
        if ($offer->includesCitations) {
            $features[] = (string) ($copy['offer_feature_citations'] ?? '');
        }
        if ($offer->includesExports) {
            $features[] = (string) ($copy['offer_feature_exports'] ?? '');
        }
        if ($offer->includesPrioritySupport) {
            $features[] = (string) ($copy['offer_feature_support'] ?? '');
        }
        foreach ($offer->capabilities as $capability) {
            $key = 'offer_capability_' . $capability;
            $features[] = (string) ($copy[$key] ?? $capability);
        }

        $actionUrl = $assistantUrl;
        if ($assistantUrl !== '#') {
            $separator = str_contains($assistantUrl, '?') ? '&' : '?';
            $actionUrl .= $separator . 'plan=' . urlencode($offer->code);
        }

        return [
            'name' => (string) ($copy['offer_' . $offer->code . '_name'] ?? strtoupper($offer->code)),
            'summary' => (string) ($copy['offer_' . $offer->code . '_summary'] ?? ''),
            'price' => $price,
            'annual' => $annual,
            'featured' => $offer->featured ? '1' : '0',
            'featured_badge' => $offer->featured ? (string) ($copy['offer_featured_badge'] ?? '') : '',
            'cta_label' => (string) ($copy['offer_' . $offer->code . '_cta'] ?? $copy['assistant_cta'] ?? ''),
            'action_url' => $actionUrl,
            'feature_summary' => implode(' · ', array_values(array_filter(
                $features,
                static fn (string $value): bool => trim($value) !== ''
            ))),
        ];
    }
}
