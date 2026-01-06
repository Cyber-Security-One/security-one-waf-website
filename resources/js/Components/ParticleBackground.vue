<template>
    <canvas ref="canvas" class="particle-canvas"></canvas>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue';

const canvas = ref(null);
let ctx = null;
let particles = [];
let animationId = null;
let mouseX = 0;
let mouseY = 0;

class Particle {
    constructor(x, y) {
        this.x = x;
        this.y = y;
        this.size = Math.random() * 2 + 1;
        this.speedX = Math.random() * 1 - 0.5;
        this.speedY = Math.random() * 1 - 0.5;
        this.opacity = Math.random() * 0.5 + 0.2;
    }
    
    update(width, height) {
        this.x += this.speedX;
        this.y += this.speedY;
        
        // Mouse interaction
        const dx = mouseX - this.x;
        const dy = mouseY - this.y;
        const distance = Math.sqrt(dx * dx + dy * dy);
        
        if (distance < 100) {
            const force = (100 - distance) / 100;
            this.x -= dx * force * 0.02;
            this.y -= dy * force * 0.02;
        }
        
        // Boundary check
        if (this.x > width) this.x = 0;
        if (this.x < 0) this.x = width;
        if (this.y > height) this.y = 0;
        if (this.y < 0) this.y = height;
    }
    
    draw(ctx) {
        ctx.beginPath();
        ctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
        ctx.fillStyle = `rgba(0, 212, 255, ${this.opacity})`;
        ctx.fill();
    }
}

function drawConnections(ctx) {
    for (let i = 0; i < particles.length; i++) {
        for (let j = i + 1; j < particles.length; j++) {
            const dx = particles[i].x - particles[j].x;
            const dy = particles[i].y - particles[j].y;
            const distance = Math.sqrt(dx * dx + dy * dy);
            
            if (distance < 120) {
                ctx.beginPath();
                ctx.moveTo(particles[i].x, particles[i].y);
                ctx.lineTo(particles[j].x, particles[j].y);
                const opacity = (120 - distance) / 120 * 0.3;
                ctx.strokeStyle = `rgba(0, 212, 255, ${opacity})`;
                ctx.lineWidth = 0.5;
                ctx.stroke();
            }
        }
    }
}

function animate() {
    if (!canvas.value || !ctx) return;
    
    const width = canvas.value.width;
    const height = canvas.value.height;
    
    ctx.clearRect(0, 0, width, height);
    
    particles.forEach(particle => {
        particle.update(width, height);
        particle.draw(ctx);
    });
    
    drawConnections(ctx);
    
    animationId = requestAnimationFrame(animate);
}

function handleResize() {
    if (!canvas.value) return;
    canvas.value.width = window.innerWidth;
    canvas.value.height = window.innerHeight;
}

function handleMouseMove(e) {
    mouseX = e.clientX;
    mouseY = e.clientY;
}

onMounted(() => {
    if (!canvas.value) return;
    
    ctx = canvas.value.getContext('2d');
    handleResize();
    
    // Create particles
    const particleCount = Math.min(100, Math.floor((window.innerWidth * window.innerHeight) / 15000));
    for (let i = 0; i < particleCount; i++) {
        particles.push(new Particle(
            Math.random() * canvas.value.width,
            Math.random() * canvas.value.height
        ));
    }
    
    window.addEventListener('resize', handleResize);
    window.addEventListener('mousemove', handleMouseMove);
    
    animate();
});

onUnmounted(() => {
    if (animationId) {
        cancelAnimationFrame(animationId);
    }
    window.removeEventListener('resize', handleResize);
    window.removeEventListener('mousemove', handleMouseMove);
});
</script>

<style scoped>
.particle-canvas {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    z-index: 0;
}
</style>
