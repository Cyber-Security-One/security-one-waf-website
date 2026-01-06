<template>
    <div class="stat-number" ref="counterRef">
        {{ displayValue }}{{ suffix }}
    </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue';

const props = defineProps({
    target: {
        type: Number,
        required: true
    },
    suffix: {
        type: String,
        default: ''
    },
    duration: {
        type: Number,
        default: 2000
    }
});

const displayValue = ref(0);
const counterRef = ref(null);
let hasAnimated = false;

const animateCounter = () => {
    if (hasAnimated) return;
    hasAnimated = true;
    
    const startTime = Date.now();
    const startValue = 0;
    const endValue = props.target;
    
    const animate = () => {
        const elapsed = Date.now() - startTime;
        const progress = Math.min(elapsed / props.duration, 1);
        
        // Easing function (ease-out-cubic)
        const easeProgress = 1 - Math.pow(1 - progress, 3);
        
        const currentValue = startValue + (endValue - startValue) * easeProgress;
        
        // Handle decimals
        if (Number.isInteger(endValue)) {
            displayValue.value = Math.round(currentValue);
        } else {
            displayValue.value = currentValue.toFixed(1);
        }
        
        if (progress < 1) {
            requestAnimationFrame(animate);
        }
    };
    
    requestAnimationFrame(animate);
};

onMounted(() => {
    const observer = new IntersectionObserver(
        (entries) => {
            entries.forEach((entry) => {
                if (entry.isIntersecting) {
                    animateCounter();
                    observer.disconnect();
                }
            });
        },
        { threshold: 0.5 }
    );
    
    if (counterRef.value) {
        observer.observe(counterRef.value);
    }
});
</script>

<style scoped>
.stat-number {
    font-family: 'Orbitron', sans-serif;
    font-size: clamp(2rem, 5vw, 3.5rem);
    font-weight: 800;
    background: linear-gradient(135deg, #00d4ff, #8b5cf6);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}
</style>
