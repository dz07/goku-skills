# Awwwards-Level Design Patterns

## Evaluation Criteria (Site of the Day needs 8.5+ in all)
1. **Design** — visual aesthetics, composition, color, typography
2. **Usability** — navigation, accessibility, responsiveness
3. **Creativity** — innovation, uniqueness, memorable moments
4. **Content** — storytelling, relevance, engagement

## Scroll Animation Choreography

### Staggered Reveals
```javascript
gsap.from('.card', {
  opacity: 0, y: 60, duration: 0.8, stagger: 0.15, ease: 'power3.out',
  scrollTrigger: { trigger: '.cards-grid', start: 'top 75%' }
});
```

### Text Split Animation (character-by-character)
```javascript
// Split text into spans, then animate
gsap.from('.char', {
  opacity: 0, y: 50, rotationX: -90, stagger: 0.02, duration: 0.8,
  ease: 'back.out(1.7)',
  scrollTrigger: { trigger: '.headline', start: 'top 80%' }
});
```

### Horizontal Scroll Section
```javascript
const sections = gsap.utils.toArray('.panel');
gsap.to(sections, {
  xPercent: -100 * (sections.length - 1), ease: 'none',
  scrollTrigger: {
    trigger: '.horizontal-wrapper', pin: true, scrub: 1,
    end: () => '+=' + document.querySelector('.horizontal-wrapper').offsetWidth
  }
});
```

## Smooth Scrolling (Lenis)
```html
<script src="https://unpkg.com/lenis@1.1.18/dist/lenis.min.js"></script>
<script>
const lenis = new Lenis({ duration: 1.2, easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)) });
function raf(time) { lenis.raf(time); requestAnimationFrame(raf); }
requestAnimationFrame(raf);
</script>
```

## Custom Cursor
```css
.custom-cursor {
  width: 20px; height: 20px; border-radius: 50%;
  border: 2px solid var(--color-primary);
  position: fixed; pointer-events: none; z-index: 9999;
  transition: transform 0.15s ease;
}
.custom-cursor.hovering { transform: scale(2.5); background: rgba(0,0,0,0.1); }
```

## Magnetic Buttons
```javascript
document.querySelectorAll('.magnetic').forEach(btn => {
  btn.addEventListener('mousemove', (e) => {
    const rect = btn.getBoundingClientRect();
    const x = e.clientX - rect.left - rect.width/2;
    const y = e.clientY - rect.top - rect.height/2;
    btn.style.transform = `translate(${x*0.3}px, ${y*0.3}px)`;
  });
  btn.addEventListener('mouseleave', () => { btn.style.transform = ''; });
});
```

## Noise/Grain Texture Overlay
```css
.grain::after {
  content: ''; position: fixed; inset: 0; z-index: 9998; pointer-events: none;
  background-image: url("data:image/svg+xml,..."); /* SVG noise pattern */
  opacity: 0.04;
}
```

## Color Transitions on Scroll
```javascript
const sections = document.querySelectorAll('[data-bg]');
sections.forEach(sec => {
  ScrollTrigger.create({
    trigger: sec, start: 'top center',
    onEnter: () => gsap.to('body', { backgroundColor: sec.dataset.bg, duration: 0.8 }),
    onEnterBack: () => gsap.to('body', { backgroundColor: sec.dataset.bg, duration: 0.8 })
  });
});
```
