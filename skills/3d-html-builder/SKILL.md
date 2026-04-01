---
name: 3d-html-builder
description: "Build interactive 3D HTML pages with Three.js, CSS 3D transforms, GSAP animations, and WebGL effects. Use when creating 3D product showcases, hero sections with parallax/depth, animated landing pages, scroll-driven 3D scenes, or any HTML page with 3D visual effects. Triggers on: 3D page, Three.js site, 3D hero, interactive 3D, WebGL landing page, 3D product display, parallax 3D, floating elements, scroll 3D animation. Not for server-side rendering, backend APIs, or native 3D applications."
---

# 3D HTML Builder

Build single-file or multi-file 3D interactive HTML pages. CDN-loaded libraries, no build tools needed.

## Core Stack (CDN)

```html
<!-- Three.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
<!-- GSAP + ScrollTrigger -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/ScrollTrigger.min.js"></script>
<!-- OrbitControls (optional) -->
<script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/controls/OrbitControls.js"></script>
```

## Page Architecture

```html
<!DOCTYPE html>
<html lang="..." dir="...">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>...</title>
  <style>/* All CSS inline */</style>
</head>
<body>
  <!-- 1. Fixed 3D canvas layer (background, z-index: 0) -->
  <!-- 2. HTML content layers on top (z-index: 1+) -->
  <!-- 3. Scripts at end of body -->
</body>
</html>
```

## Three.js Essentials

### Setup Pattern
```javascript
const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
renderer.setSize(window.innerWidth, window.innerHeight);
renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2)); // cap at 2 for perf
renderer.setClearColor(0x000000, 0); // transparent for overlay on HTML
document.getElementById('canvas-container').appendChild(renderer.domElement);

const camera = new THREE.PerspectiveCamera(75, window.innerWidth/window.innerHeight, 0.1, 1000);
const scene = new THREE.Scene();
```

### Resource Cleanup (critical — Three.js never GCs GPU resources)
```javascript
// Always dispose before removing
mesh.geometry.dispose();
mesh.material.dispose();
if (mesh.material.map) mesh.material.map.dispose();
scene.remove(mesh);
```

### Responsive Resize
```javascript
window.addEventListener('resize', () => {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix(); // MUST call after aspect change
  renderer.setSize(window.innerWidth, window.innerHeight);
});
```

### Render Loop
```javascript
const clock = new THREE.Clock();
renderer.setAnimationLoop(() => {
  const delta = clock.getDelta(); // frame-independent timing
  // update animations with delta
  renderer.render(scene, camera);
});
```

### Lighting
- Use `MeshStandardMaterial` or `MeshPhongMaterial` (MeshBasicMaterial ignores lights)
- Always add ambient light as baseline: `new THREE.AmbientLight(0xffffff, 0.5)`
- HDR environment maps via PMREMGenerator for realistic reflections

## GSAP ScrollTrigger Patterns

### Scroll-Driven 3D Rotation
```javascript
gsap.registerPlugin(ScrollTrigger);
gsap.to(camera.position, {
  scrollTrigger: { trigger: '.section', scrub: true },
  z: 5, y: 2
});
```

### Pinned Section with Animation
```javascript
gsap.from('.reveal', {
  opacity: 0, y: 100, duration: 1, ease: 'power3.out',
  scrollTrigger: {
    trigger: '.reveal', start: 'top 80%', end: 'top 20%',
    toggleActions: 'play none none reverse'
  }
});
```

### Common Scroll Effects
- Camera fly-through scene on scroll
- Model rotation tied to scroll offset
- Exploded view animations (product showcase)
- Parallax layers at different speeds
- Color/material transitions on scroll progress

## CSS-Only 3D (no JS libraries)

```css
.scene { perspective: 1000px; }
.card {
  transform-style: preserve-3d;
  transition: transform 0.6s;
}
.card:hover { transform: rotateY(180deg); }

@keyframes float {
  0%, 100% { transform: translateY(0) rotate(0deg); }
  50% { transform: translateY(-20px) rotate(3deg); }
}
.floating { animation: float 6s ease-in-out infinite; }
```

## RTL Support (Arabic/Darija)

- `<html lang="ar" dir="rtl">`
- Font: `'Noto Sans Arabic', 'Amiri', sans-serif`
- 3D transforms are direction-neutral — work the same in RTL
- Flip layouts with CSS logical properties

## Performance Rules

1. Keep geometry simple — decorative, not game-level (under 100K polys)
2. `renderer.setPixelRatio(Math.min(devicePixelRatio, 2))` — above 2 kills perf
3. Use `InstancedMesh` for many identical objects (hundreds of draw calls become one)
4. Merge static geometries: `BufferGeometryUtils.mergeBufferGeometries()`
5. Add `prefers-reduced-motion` media query to disable animations
6. Provide static fallback for low-end mobile — test on real devices
7. Check `renderer.info` to debug draw calls and GPU memory
8. Ideal model size under 5MB; compress with Draco/gltf-transform

## Anti-Patterns to Avoid

- **3D for 3D's sake** — ask "would an image work?" If yes, skip 3D
- **Desktop-only 3D** — most traffic is mobile; reduce quality or provide fallback
- **No loading state** — 3D takes time; show progress indicator
- **Missing dispose()** — GPU memory leaks crash tabs on long sessions

## Security Constraints

- CDN only: HTTPS from trusted CDNs (cdnjs, jsdelivr, unpkg)
- No eval/innerHTML with dynamic data
- No external API calls — pages are self-contained
- No cookies/localStorage for sensitive data
- CSP-friendly: use addEventListener, not inline handlers

## Quality Checklist

- [ ] Mobile responsive (375px, 768px, 1440px)
- [ ] 60fps animations (no jank on scroll)
- [ ] RTL correct if Arabic content
- [ ] Accessible: alt text, color contrast, reduced-motion
- [ ] No console errors, no GPU memory leaks
- [ ] All CDN links use HTTPS
- [ ] Loading state for heavy 3D assets
- [ ] Static fallback for low-end devices
