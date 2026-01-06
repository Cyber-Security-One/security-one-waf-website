<template>
    <Transition name="fade">
        <div v-if="!isComplete" class="loading-screen">
            <div class="loading-content">
                <!-- Logo Animation -->
                <div class="logo-container">
                    <div class="logo-shield">
                        <svg viewBox="0 0 100 100" class="shield-svg">
                            <defs>
                                <linearGradient id="shieldGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                                    <stop offset="0%" style="stop-color:#00d4ff" />
                                    <stop offset="100%" style="stop-color:#8b5cf6" />
                                </linearGradient>
                            </defs>
                            <path 
                                d="M50 5 L90 20 L90 50 C90 75 70 90 50 95 C30 90 10 75 10 50 L10 20 Z" 
                                fill="none" 
                                stroke="url(#shieldGradient)" 
                                stroke-width="3"
                                class="shield-path"
                            />
                            <text x="50" y="60" text-anchor="middle" fill="url(#shieldGradient)" font-size="30" font-weight="bold" font-family="Orbitron">V</text>
                        </svg>
                    </div>
                </div>
                
                <h1 class="loading-logo">Security One WAF</h1>
                <p class="loading-text">正在載入安全系統...</p>
                
                <!-- Progress Bar -->
                <div class="loading-bar-container">
                    <div class="loading-bar" :style="{ width: progress + '%' }"></div>
                </div>
                <span class="loading-percent">{{ progress }}%</span>
            </div>
            
            <!-- Animated Circles -->
            <div class="loading-circles">
                <div class="circle circle-1"></div>
                <div class="circle circle-2"></div>
                <div class="circle circle-3"></div>
            </div>
        </div>
    </Transition>
</template>

<script setup>
import { ref, onMounted } from 'vue';

const emit = defineEmits(['complete']);

const isComplete = ref(false);
const progress = ref(0);

onMounted(() => {
    // Animate progress
    const duration = 2000;
    const startTime = Date.now();
    
    const animate = () => {
        const elapsed = Date.now() - startTime;
        const percent = Math.min((elapsed / duration) * 100, 100);
        progress.value = Math.round(percent);
        
        if (percent < 100) {
            requestAnimationFrame(animate);
        } else {
            setTimeout(() => {
                isComplete.value = true;
                emit('complete');
            }, 300);
        }
    };
    
    requestAnimationFrame(animate);
});
</script>

<style scoped>
.loading-screen {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: #0a0a0f;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    z-index: 9999;
}

.loading-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    z-index: 1;
}

.logo-container {
    margin-bottom: 1rem;
}

.logo-shield {
    width: 100px;
    height: 100px;
    animation: float 3s ease-in-out infinite;
}

.shield-svg {
    width: 100%;
    height: 100%;
    filter: drop-shadow(0 0 20px rgba(0, 212, 255, 0.5));
}

.shield-path {
    stroke-dasharray: 300;
    stroke-dashoffset: 300;
    animation: draw-shield 2s ease forwards;
}

@keyframes draw-shield {
    to {
        stroke-dashoffset: 0;
    }
}

@keyframes float {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
}

.loading-logo {
    font-family: 'Orbitron', sans-serif;
    font-size: 2.5rem;
    font-weight: 800;
    background: linear-gradient(135deg, #00d4ff, #8b5cf6);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    animation: pulse-glow 2s ease-in-out infinite;
}

.loading-text {
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.875rem;
    margin-top: 0.5rem;
    margin-bottom: 2rem;
}

.loading-bar-container {
    width: 250px;
    height: 6px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 3px;
    overflow: hidden;
}

.loading-bar {
    height: 100%;
    background: linear-gradient(135deg, #00d4ff, #8b5cf6);
    border-radius: 3px;
    transition: width 0.1s ease;
    box-shadow: 0 0 20px rgba(0, 212, 255, 0.5);
}

.loading-percent {
    color: #00d4ff;
    font-family: 'Orbitron', sans-serif;
    font-size: 0.875rem;
    margin-top: 0.75rem;
}

@keyframes pulse-glow {
    0%, 100% { 
        filter: drop-shadow(0 0 10px rgba(0, 212, 255, 0.5));
    }
    50% { 
        filter: drop-shadow(0 0 30px rgba(0, 212, 255, 0.8));
    }
}

/* Animated Circles */
.loading-circles {
    position: absolute;
    width: 100%;
    height: 100%;
    overflow: hidden;
    pointer-events: none;
}

.circle {
    position: absolute;
    border-radius: 50%;
    border: 1px solid rgba(0, 212, 255, 0.2);
    animation: expand 4s ease-out infinite;
}

.circle-1 {
    width: 100px;
    height: 100px;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    animation-delay: 0s;
}

.circle-2 {
    width: 200px;
    height: 200px;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    animation-delay: 1s;
}

.circle-3 {
    width: 300px;
    height: 300px;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    animation-delay: 2s;
}

@keyframes expand {
    0% {
        transform: translate(-50%, -50%) scale(1);
        opacity: 1;
    }
    100% {
        transform: translate(-50%, -50%) scale(4);
        opacity: 0;
    }
}

/* Fade Transition */
.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.5s ease;
}

.fade-enter-from,
.fade-leave-to {
    opacity: 0;
}
</style>
