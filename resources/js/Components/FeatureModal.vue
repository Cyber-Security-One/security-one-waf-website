<template>
    <Teleport to="body">
        <Transition name="modal">
            <div v-if="isOpen" class="modal-overlay" @click.self="close">
                <div class="modal-container">
                    <!-- Close Button -->
                    <button class="modal-close" @click="close">
                        <span>✕</span>
                    </button>
                    
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <div class="modal-icon-wrapper">
                            <span class="modal-icon">{{ feature.icon }}</span>
                            <div class="icon-ring"></div>
                            <div class="icon-ring ring-2"></div>
                        </div>
                        <h2 class="modal-title">{{ feature.title }}</h2>
                    </div>
                    
                    <!-- Modal Content -->
                    <div class="modal-content">
                        <p class="modal-description">{{ feature.description }}</p>
                        
                        <!-- Feature Highlights -->
                        <div class="modal-highlights" v-if="feature.highlights">
                            <h4>功能特色</h4>
                            <ul>
                                <li v-for="(item, index) in feature.highlights" :key="index" 
                                    class="highlight-item"
                                    :style="{ animationDelay: (index * 0.1) + 's' }">
                                    <span class="highlight-check">✓</span>
                                    {{ item }}
                                </li>
                            </ul>
                        </div>
                        
                        <!-- Technical Details -->
                        <div class="modal-tech" v-if="feature.tech">
                            <h4>技術細節</h4>
                            <div class="tech-tags">
                                <span v-for="(tag, index) in feature.tech" :key="index" 
                                      class="tech-tag"
                                      :style="{ animationDelay: (index * 0.05) + 's' }">
                                    {{ tag }}
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Modal Footer -->
                    <div class="modal-footer">
                        <a href="mailto:sales@securityone.com?subject=Security One SOC 諮詢" class="modal-btn primary">
                            🚀 了解更多
                        </a>
                        <button class="modal-btn secondary" @click="close">關閉</button>
                    </div>
                    
                    <!-- Decorative Elements -->
                    <div class="modal-glow"></div>
                    <div class="modal-scan-line"></div>
                </div>
            </div>
        </Transition>
    </Teleport>
</template>

<script setup>
import { watch } from 'vue';

const props = defineProps({
    isOpen: {
        type: Boolean,
        default: false
    },
    feature: {
        type: Object,
        default: () => ({
            icon: '',
            title: '',
            description: '',
            highlights: [],
            tech: []
        })
    }
});

const emit = defineEmits(['close']);

const close = () => {
    emit('close');
};

// Handle ESC key
watch(() => props.isOpen, (isOpen) => {
    if (isOpen) {
        document.addEventListener('keydown', handleEsc);
        document.body.style.overflow = 'hidden';
    } else {
        document.removeEventListener('keydown', handleEsc);
        document.body.style.overflow = '';
    }
});

const handleEsc = (e) => {
    if (e.key === 'Escape') {
        close();
    }
};
</script>

<style scoped>
.modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.85);
    backdrop-filter: blur(10px);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 9999;
    padding: 2rem;
}

.modal-container {
    position: relative;
    background: linear-gradient(135deg, rgba(15, 15, 30, 0.95), rgba(10, 10, 20, 0.98));
    border: 1px solid rgba(0, 212, 255, 0.3);
    border-radius: 20px;
    max-width: 600px;
    width: 100%;
    max-height: 80vh;
    overflow-y: auto;
    padding: 2.5rem;
    box-shadow: 
        0 0 60px rgba(0, 212, 255, 0.2),
        0 0 120px rgba(139, 92, 246, 0.1);
}

.modal-close {
    position: absolute;
    top: 1rem;
    right: 1rem;
    width: 40px;
    height: 40px;
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.05);
    color: rgba(255, 255, 255, 0.7);
    font-size: 1.25rem;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
}

.modal-close:hover {
    background: rgba(255, 0, 0, 0.2);
    border-color: rgba(255, 0, 0, 0.5);
    color: #ff6b6b;
    transform: rotate(90deg);
}

.modal-header {
    text-align: center;
    margin-bottom: 2rem;
}

.modal-icon-wrapper {
    position: relative;
    display: inline-block;
    margin-bottom: 1rem;
}

.modal-icon {
    font-size: 4rem;
    display: block;
    animation: float 3s ease-in-out infinite;
}

.icon-ring {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 100px;
    height: 100px;
    border: 2px solid rgba(0, 212, 255, 0.3);
    border-radius: 50%;
    animation: pulse-ring 2s ease-out infinite;
}

.icon-ring.ring-2 {
    width: 120px;
    height: 120px;
    animation-delay: 0.5s;
}

@keyframes float {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
}

@keyframes pulse-ring {
    0% { transform: translate(-50%, -50%) scale(1); opacity: 1; }
    100% { transform: translate(-50%, -50%) scale(1.5); opacity: 0; }
}

.modal-title {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.75rem;
    font-weight: 700;
    background: linear-gradient(135deg, #00d4ff, #8b5cf6);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.modal-content {
    margin-bottom: 2rem;
}

.modal-description {
    color: rgba(255, 255, 255, 0.8);
    font-size: 1rem;
    line-height: 1.8;
    text-align: center;
    margin-bottom: 2rem;
}

.modal-highlights h4,
.modal-tech h4 {
    font-family: 'Orbitron', sans-serif;
    font-size: 0.9rem;
    color: #00d4ff;
    margin-bottom: 1rem;
    text-transform: uppercase;
    letter-spacing: 0.1em;
}

.modal-highlights ul {
    list-style: none;
    padding: 0;
    margin-bottom: 1.5rem;
}

.highlight-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.75rem 1rem;
    background: rgba(0, 212, 255, 0.05);
    border-left: 3px solid #00d4ff;
    margin-bottom: 0.5rem;
    border-radius: 0 8px 8px 0;
    color: rgba(255, 255, 255, 0.8);
    font-size: 0.9rem;
    animation: slideInLeft 0.5s ease forwards;
    opacity: 0;
    transform: translateX(-20px);
}

@keyframes slideInLeft {
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.highlight-check {
    color: #00ff88;
    font-weight: bold;
}

.tech-tags {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
}

.tech-tag {
    background: linear-gradient(135deg, rgba(139, 92, 246, 0.2), rgba(139, 92, 246, 0.1));
    border: 1px solid rgba(139, 92, 246, 0.4);
    padding: 0.5rem 1rem;
    border-radius: 50px;
    font-size: 0.8rem;
    color: #8b5cf6;
    animation: popIn 0.3s ease forwards;
    opacity: 0;
    transform: scale(0.8);
}

@keyframes popIn {
    to {
        opacity: 1;
        transform: scale(1);
    }
}

.modal-footer {
    display: flex;
    gap: 1rem;
    justify-content: center;
}

.modal-btn {
    padding: 0.875rem 2rem;
    border-radius: 8px;
    font-family: 'Orbitron', sans-serif;
    font-size: 0.875rem;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    text-decoration: none;
    border: none;
}

.modal-btn.primary {
    background: linear-gradient(135deg, #00d4ff, #8b5cf6);
    color: #0a0a0f;
    box-shadow: 0 0 20px rgba(0, 212, 255, 0.4);
}

.modal-btn.primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 0 40px rgba(0, 212, 255, 0.6);
}

.modal-btn.secondary {
    background: transparent;
    border: 1px solid rgba(255, 255, 255, 0.3);
    color: rgba(255, 255, 255, 0.8);
}

.modal-btn.secondary:hover {
    border-color: #00d4ff;
    color: #00d4ff;
}

/* Decorative Elements */
.modal-glow {
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle at center, rgba(0, 212, 255, 0.1) 0%, transparent 50%);
    pointer-events: none;
    animation: rotate-glow 10s linear infinite;
}

@keyframes rotate-glow {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

.modal-scan-line {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 2px;
    background: linear-gradient(90deg, transparent, #00d4ff, transparent);
    animation: scan 3s linear infinite;
    pointer-events: none;
}

@keyframes scan {
    0% { top: 0; opacity: 1; }
    50% { opacity: 0.5; }
    100% { top: 100%; opacity: 0; }
}

/* Modal Transition */
.modal-enter-active {
    transition: all 0.4s ease;
}

.modal-leave-active {
    transition: all 0.3s ease;
}

.modal-enter-from {
    opacity: 0;
}

.modal-enter-from .modal-container {
    transform: scale(0.9) translateY(20px);
    opacity: 0;
}

.modal-leave-to {
    opacity: 0;
}

.modal-leave-to .modal-container {
    transform: scale(0.9) translateY(20px);
    opacity: 0;
}

.modal-enter-active .modal-container {
    transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
}

.modal-leave-active .modal-container {
    transition: all 0.3s ease;
}

@media (max-width: 640px) {
    .modal-container {
        padding: 1.5rem;
        margin: 1rem;
    }
    
    .modal-icon {
        font-size: 3rem;
    }
    
    .modal-title {
        font-size: 1.25rem;
    }
    
    .modal-footer {
        flex-direction: column;
    }
}
</style>
