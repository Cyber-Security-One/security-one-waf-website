<template>
    <div 
        class="feature-card"
        role="button"
        tabindex="0"
        :aria-label="'查看 ' + title + ' 的詳細資訊'"
        :style="{ animationDelay: delay + 's' }"
        @mouseenter="onMouseEnter"
        @mouseleave="onMouseLeave"
        @focus="onMouseEnter"
        @blur="onMouseLeave"
        @click="$emit('click')"
        @keydown.enter.prevent="$emit('click')"
        @keydown.space.prevent="$emit('click')"
    >
        <!-- Icon with Animation -->
        <div class="feature-icon-wrapper">
            <span class="feature-icon" :class="{ 'icon-animate': isHovered }">{{ icon }}</span>
            <div class="icon-glow" :class="{ 'active': isHovered }"></div>
        </div>
        
        <h3 class="feature-title">{{ title }}</h3>
        <p class="feature-description">{{ description }}</p>
        
        <!-- Click Hint -->
        <div class="click-hint" :class="{ 'visible': isHovered }">
            <span>點擊查看詳情</span>
            <span class="hint-arrow">→</span>
        </div>
        
        <!-- Hover Effects -->
        <div class="card-border-glow" :class="{ 'active': isHovered }"></div>
        <div class="card-corner top-left"></div>
        <div class="card-corner top-right"></div>
        <div class="card-corner bottom-left"></div>
        <div class="card-corner bottom-right"></div>
    </div>
</template>

<script setup>
import { ref } from 'vue';

defineProps({
    icon: {
        type: String,
        required: true
    },
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    delay: {
        type: Number,
        default: 0
    }
});

defineEmits(['click']);

const isHovered = ref(false);

const onMouseEnter = () => {
    isHovered.value = true;
};

const onMouseLeave = () => {
    isHovered.value = false;
};
</script>

<style scoped>
.feature-card {
    background: rgba(15, 15, 30, 0.8);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 16px;
    padding: 2rem;
    position: relative;
    overflow: hidden;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    backdrop-filter: blur(10px);
    cursor: pointer;
}

.feature-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 2px;
    background: linear-gradient(90deg, transparent, #00d4ff, #8b5cf6, transparent);
    transform: scaleX(0);
    transition: transform 0.4s ease;
}

.feature-card:hover,
.feature-card:focus-visible {
    transform: translateY(-10px) perspective(1000px) rotateX(5deg);
    border-color: rgba(0, 212, 255, 0.5);
    box-shadow: 
        0 20px 40px rgba(0, 0, 0, 0.3),
        0 0 30px rgba(0, 212, 255, 0.2);
    outline: none;
}

.feature-card:focus-visible {
    border-color: #00d4ff;
    box-shadow:
        0 0 0 2px rgba(15, 15, 30, 0.8),
        0 0 0 4px #00d4ff;
}

.feature-card:hover::before,
.feature-card:focus-visible::before {
    transform: scaleX(1);
}

/* Icon Wrapper */
.feature-icon-wrapper {
    position: relative;
    display: inline-block;
    margin-bottom: 1rem;
}

.feature-icon {
    font-size: 3rem;
    display: block;
    transition: all 0.4s ease;
}

.icon-animate {
    animation: iconBounce 0.5s ease;
    transform: scale(1.1);
}

@keyframes iconBounce {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.3) rotate(10deg); }
}

.icon-glow {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 60px;
    height: 60px;
    background: radial-gradient(circle, rgba(0, 212, 255, 0.4) 0%, transparent 70%);
    border-radius: 50%;
    opacity: 0;
    transition: opacity 0.3s ease;
    pointer-events: none;
}

.icon-glow.active {
    opacity: 1;
    animation: iconPulse 1s ease-in-out infinite;
}

@keyframes iconPulse {
    0%, 100% { transform: translate(-50%, -50%) scale(1); opacity: 0.8; }
    50% { transform: translate(-50%, -50%) scale(1.5); opacity: 0.4; }
}

.feature-title {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.25rem;
    font-weight: 600;
    margin-bottom: 0.5rem;
    color: #ffffff;
    transition: color 0.3s ease;
}

.feature-card:hover .feature-title,
.feature-card:focus-visible .feature-title {
    color: #00d4ff;
}

.feature-description {
    color: rgba(255, 255, 255, 0.7);
    font-size: 0.9rem;
    line-height: 1.6;
}

/* Click Hint */
.click-hint {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    margin-top: 1rem;
    font-size: 0.75rem;
    color: #00d4ff;
    opacity: 0;
    transform: translateY(10px);
    transition: all 0.3s ease;
}

.click-hint.visible {
    opacity: 1;
    transform: translateY(0);
}

.hint-arrow {
    animation: arrowBounce 1s ease-in-out infinite;
}

@keyframes arrowBounce {
    0%, 100% { transform: translateX(0); }
    50% { transform: translateX(5px); }
}

/* Border Glow Effect */
.card-border-glow {
    position: absolute;
    top: -2px;
    left: -2px;
    right: -2px;
    bottom: -2px;
    background: linear-gradient(135deg, #00d4ff, #8b5cf6, #00ff88, #00d4ff);
    background-size: 300% 300%;
    border-radius: 18px;
    z-index: -1;
    opacity: 0;
    transition: opacity 0.4s ease;
}

.card-border-glow.active {
    opacity: 1;
    animation: gradientMove 3s ease infinite;
}

@keyframes gradientMove {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

/* Corner Decorations */
.card-corner {
    position: absolute;
    width: 20px;
    height: 20px;
    border-color: #00d4ff;
    border-style: solid;
    border-width: 0;
    opacity: 0;
    transition: all 0.3s ease;
}

.feature-card:hover .card-corner,
.feature-card:focus-visible .card-corner {
    opacity: 1;
}

.top-left {
    top: 8px;
    left: 8px;
    border-top-width: 2px;
    border-left-width: 2px;
}

.top-right {
    top: 8px;
    right: 8px;
    border-top-width: 2px;
    border-right-width: 2px;
}

.bottom-left {
    bottom: 8px;
    left: 8px;
    border-bottom-width: 2px;
    border-left-width: 2px;
}

.bottom-right {
    bottom: 8px;
    right: 8px;
    border-bottom-width: 2px;
    border-right-width: 2px;
}

@media (max-width: 768px) {
    .feature-card {
        padding: 1rem;
    }
    .feature-icon {
        font-size: 2rem;
    }
    .feature-icon-wrapper {
        margin-bottom: 0.4rem;
    }
    .feature-title {
        font-size: 1rem;
    }
    .feature-description {
        font-size: 0.8rem;
        line-height: 1.4;
    }
    .click-hint {
        display: none;
    }
}
</style>
