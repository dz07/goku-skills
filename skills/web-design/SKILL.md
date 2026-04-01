---
name: web-design
description: "Design and build modern, responsive websites and landing pages. Use when creating landing pages, marketing sites, product pages, portfolio sites, dashboards, or any web frontend. Covers layout, typography, color systems, responsive design, CSS animations, scroll animations, and component architecture. Triggers on: build a website, landing page, web design, responsive page, site layout, product page, portfolio site, redesign, homepage, marketing page, award-winning site. Not for backend APIs, databases, or server-side logic."
---

# Web Design

Build modern, responsive websites. HTML + CSS + vanilla JS (or lightweight CDN frameworks).

## Design System Foundation

### Typography (fluid scale)
```css
:root {
  --fs-xs: clamp(0.75rem, 0.7rem + 0.25vw, 0.875rem);
  --fs-sm: clamp(0.875rem, 0.8rem + 0.35vw, 1rem);
  --fs-base: clamp(1rem, 0.9rem + 0.5vw, 1.125rem);
  --fs-lg: clamp(1.25rem, 1rem + 1vw, 1.5rem);
  --fs-xl: clamp(1.5rem, 1.2rem + 1.5vw, 2rem);
  --fs-2xl: clamp(2rem, 1.5rem + 2.5vw, 3rem);
  --fs-hero: clamp(2.5rem, 2rem + 3vw, 4.5rem);
}
```

### Color System (semantic tokens)
```css
:root {
  --color-primary: #...;
  --color-accent: #...;
  --color-bg: #...;
  --color-surface: #...;
  --color-text: #...;
  --color-text-muted: #...;
}
```

### Spacing (8px grid)
`0.5rem, 1rem, 1.5rem, 2rem, 3rem, 4rem, 6rem, 8rem`

## Layout Patterns

```css
.page { display: grid; grid-template-rows: auto 1fr auto; min-height: 100vh; }
.container { width: min(90%, 1200px); margin-inline: auto; }
.grid-auto { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem; }
```

### Common Sections
1. **Hero** — full viewport, headline + CTA + visual
2. **Features/Cards** — auto-fit grid
3. **Split** — two-column text + image (stack on mobile)
4. **Stats** — counter row with icons
5. **Testimonials** — carousel or grid
6. **CTA Band** — contrasting bg, centered text + button
7. **Footer** — multi-column links + social

## Responsive Strategy (mobile-first)

```css
/* Mobile: default styles */
@media (min-width: 768px) { /* Tablet */ }
@media (min-width: 1024px) { /* Desktop */ }
@media (min-width: 1440px) { /* Wide */ }
```

- Stack on mobile, side-by-side on tablet+
- Touch targets min 44x44px
- Font sizes via `clamp()` for fluid scaling
- Images: `max-width: 100%; height: auto`

## Animation Patterns

### Scroll Reveal (IntersectionObserver)
```javascript
const observer = new IntersectionObserver((entries) => {
  entries.forEach(e => { if (e.isIntersecting) e.target.classList.add('visible'); });
}, { threshold: 0.1 });
document.querySelectorAll('.animate-in').forEach(el => observer.observe(el));
```
```css
.animate-in { opacity: 0; transform: translateY(30px); transition: all 0.6s ease; }
.animate-in.visible { opacity: 1; transform: translateY(0); }
```

### GSAP ScrollTrigger (for advanced animations)
```javascript
gsap.registerPlugin(ScrollTrigger);
gsap.from('.reveal', {
  opacity: 0, y: 100, duration: 1, ease: 'power3.out',
  scrollTrigger: { trigger: '.reveal', start: 'top 80%' }
});
```

### Hover Micro-interactions
```css
.card:hover { transform: translateY(-4px); box-shadow: 0 12px 24px rgba(0,0,0,0.1); }
.btn:hover { filter: brightness(1.1); transform: scale(1.02); }
```

### Smooth Scroll
```css
html { scroll-behavior: smooth; }
```

## Award-Winning Design Principles

From references/awwwards-patterns.md:
- **Intentional storytelling** — every scroll reveals part of a narrative
- **Choreographed motion** — animations communicate, not decorate
- **Sensory richness** — custom cursors, textures, gradients create atmosphere
- **Technical craft** — smooth 60fps, fast loads, graceful degradation
- **Break conventions intentionally** — know rules to break them with purpose

## RTL / Multilingual

- `<html lang="ar" dir="rtl">`
- CSS logical properties: `margin-inline-start` not `margin-left`
- Arabic fonts: Noto Sans Arabic, Amiri, Tajawal, Cairo

## Image Handling

- `loading="lazy"` on below-fold images
- WebP with JPEG fallback via `<picture>`
- Decorative → CSS background; content → `<img>` with alt text
- Responsive: `srcset` + `sizes` attributes

## Fonts (Google Fonts CDN)

**Display**: Playfair Display, Inter, Poppins, Montserrat
**Body**: Inter, Open Sans, Lato, Source Sans Pro
**Arabic**: Noto Sans Arabic, Amiri, Tajawal, Cairo

## Security Constraints

- No inline event handlers — use addEventListener
- No external tracking scripts unless explicitly requested
- HTTPS only for all CDN/resource URLs
- No sensitive data in HTML/JS
- CSP-compatible: no eval(), no document.write()

## Moroccan Dairy Context

For dairy brand projects, see references/moroccan-dairy.md for brand palettes, typography, and layout conventions (lait.ma, Chergui, Danone, Albane).

## Quality Checklist

- [ ] Responsive at 375px, 768px, 1024px, 1440px
- [ ] Lighthouse performance > 90
- [ ] All images have alt text
- [ ] Color contrast WCAG AA (4.5:1 body, 3:1 large)
- [ ] prefers-reduced-motion fallback
- [ ] No console errors
- [ ] Valid HTML
- [ ] All external resources HTTPS
