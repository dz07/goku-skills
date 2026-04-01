---
name: dairy-brand
description: "Build brand websites for dairy and milk companies, especially Moroccan dairy brands. Use when creating a dairy product landing page, milk brand site, Albane website, lait/chergui-style site, or any food/beverage brand page with product showcase. Triggers on: dairy website, milk brand, Albane, lait, chergui, dairy landing page, product showcase dairy, Moroccan dairy. Not for e-commerce checkout flows or backend inventory systems."
---

# Dairy Brand Website

Build premium dairy brand websites with product showcases, heritage storytelling, and trust-building design.

## Brand DNA — Dairy Industry

### Color Psychology
| Color | Meaning | Use |
|-------|---------|-----|
| Deep blue (#003399) | Trust, freshness, purity | Primary, nav, headers |
| Sky blue (#00AEEF) | Clean, cool, refreshing | Accents, CTAs, highlights |
| Gold (#C5A059) | Premium, quality, heritage | Badges, borders, premium tier |
| White (#FFFFFF) | Purity, cleanliness, milk | Backgrounds, space |
| Soft cream (#F0F7FF) | Warmth, natural, soft | Section alternating bg |
| Green (#2E7D32) | Natural, organic, fresh | Organic/bio product labels |

### Typography Pairing
- **Headlines (AR)**: Amiri — classic, premium, editorial
- **Headlines (FR/EN)**: Playfair Display — elegant serif
- **Body (AR)**: Noto Sans Arabic — clean, readable
- **Body (FR/EN)**: Inter or Open Sans — modern, neutral
- **Display/Logo**: Custom or Montserrat Bold

### Photography Style
- Bright, natural lighting — never dark/moody
- White/light backgrounds for product shots
- Green pastures, farms, cows for heritage sections
- Splashing milk, pouring cream for hero visuals
- Family/lifestyle shots for trust building

## Page Structure (dairy landing page)

### 1. Hero Section
- Full-viewport with product 3D render or high-quality photo
- Headline: brand promise (freshness, quality, heritage)
- Subtext: one-liner value prop
- CTA: "Discover Our Products" / "اكتشف منتجاتنا"
- Floating milk splash or droplet animations (CSS or Three.js)

### 2. Brand Story / Heritage
- Split layout: text left, image/illustration right
- Timeline or milestone markers (year founded, growth)
- Moroccan heritage connection (Atlas mountains, farms, tradition)
- "From Farm to Table" narrative

### 3. Product Showcase
- Grid of product cards (3-4 columns desktop)
- Each card: product photo, name, category tag, brief description
- Hover effect: slight lift + shadow + quick info expand
- Category filters: milk, yogurt, cheese, butter, cream
- 3D product viewer option for hero products

### 4. Quality / Certifications
- Icon row: ISO, HACCP, organic badges
- Stats: "X million liters daily", "X farms partnered"
- Animated counters on scroll

### 5. Sustainability / CSR
- Environmental commitment section
- Local farmer partnerships
- Infographic style with icons

### 6. News / Blog Preview
- 2-3 latest articles in card format
- Categories: recipes, news, health tips

### 7. Contact / Distribution
- Map of distribution zones (Morocco regions)
- Contact form or distributor locator
- Social media links

### 8. Footer
- Multi-column: products, about, contact, legal
- Newsletter signup
- Language switcher (AR/FR)

## Bilingual Strategy (Arabic + French)

- Default: Arabic (RTL) as primary
- Language toggle in navbar (AR | FR)
- Keep same layout structure — CSS handles RTL/LTR swap
- Use `lang` attribute per section if mixing
- Product names: Arabic primary, French subtitle
- Legal/fine print: both languages

## Moroccan Market Competitors (reference)

See references/competitors.md for detailed analysis of lait.ma (COPAG), Chergui, Danone Morocco, and Centrale Danone patterns.

## Copywriting Tone

- **Warm but professional** — not corporate, not casual
- **Heritage-forward** — "rooted in Moroccan tradition"
- **Quality emphasis** — "pure", "natural", "fresh daily"
- **Family-oriented** — "nourishing families since..."
- **Bilingual rhythm** — Arabic headlines feel poetic, French feels precise

### Example Headlines
- "حليب طبيعي، من قلب المغرب" (Natural milk, from the heart of Morocco)
- "Albane — La Pureté à Chaque Goutte" (Purity in every drop)
- "جودة تثق بها عائلتك" (Quality your family trusts)

## Security (same as web-design)
- No tracking/analytics unless requested
- HTTPS-only CDN resources
- No sensitive data in frontend
- CSP-compatible code
