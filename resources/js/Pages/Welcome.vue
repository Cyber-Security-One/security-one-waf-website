<template>
    <div class="app-wrapper" @mousemove="handleHeroMouse">
        <!-- Scroll Progress Bar -->
        <motion.div
            class="scroll-progress-bar"
            :style="{ scaleX }"
        />

        <!-- Login Button (Fixed Top Right) -->
        <motion.a
            href="https://security-one-soc.vito1317.com"
            class="login-btn"
            target="_blank"
            rel="noopener noreferrer"
            :initial="{ opacity: 0, x: 30 }"
            :animate="!isLoading ? { opacity: 1, x: 0 } : { opacity: 0, x: 30 }"
            :transition="{ type: 'spring', stiffness: 200, damping: 20, delay: 1.5 }"
            :whileHover="{ scale: 1.08, y: -2 }"
            :whilePress="{ scale: 0.95 }"
        >
            <span class="login-icon">🔐</span>
            <span class="login-text">登入</span>
        </motion.a>
        
        <!-- Loading Screen -->
        <LoadingScreen v-if="isLoading" @complete="onLoadingComplete" />
        
        <!-- Grid Background -->
        <div class="grid-background"></div>
        <div class="hex-pattern"></div>
        
        <!-- Particle Background -->
        <ParticleBackground />
        
        <!-- Hero Section (Fixed Parallax) -->
        <div class="hero-wrapper">
            <!-- Cursor Follow Gradient -->
            <motion.div class="hero-cursor-gradient" :style="{ background: heroGradient }" />

            <section class="hero hero-fixed" ref="heroRef" :style="heroStyle">
                <motion.span
                    class="hero-badge animate-pulse-border"
                    :initial="{ opacity: 0, y: -50, scale: 0.5 }"
                    :animate="!isLoading ? { opacity: 1, y: 0, scale: 1 } : { opacity: 0, y: -50, scale: 0.5 }"
                    :transition="{ type: 'spring', stiffness: 150, damping: 12, delay: 0.2 }"
                >
                    🛡️ AI-Powered Security Operations Center
                </motion.span>
                <motion.h1
                    class="hero-title text-gradient"
                    :initial="{ opacity: 0, scale: 0.3 }"
                    :animate="!isLoading ? { opacity: 1, scale: 1 } : { opacity: 0, scale: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 80, damping: 10, delay: 0.5 }"
                >
                    <span class="title-brand">Security One</span> <span class="title-product">SOC</span>
                </motion.h1>
                <motion.p
                    class="hero-subtitle"
                    :initial="{ opacity: 0, y: 60 }"
                    :animate="!isLoading ? { opacity: 1, y: 0 } : { opacity: 0, y: 60 }"
                    :transition="{ type: 'spring', stiffness: 60, damping: 12, delay: 0.9 }"
                >
                    智能 統一安全平台，結合 AI 威脅偵測與 CVE 資料庫即時更新，為您的網站提供最先進的自動化防護
                </motion.p>
                <motion.div
                    class="hero-cta"
                    :initial="{ opacity: 0, y: 40, scale: 0.5 }"
                    :animate="!isLoading ? { opacity: 1, y: 0, scale: 1 } : { opacity: 0, y: 40, scale: 0.5 }"
                    :transition="{ type: 'spring', stiffness: 120, damping: 8, delay: 1.2 }"
                >
                    <motion.a
                        href="mailto:service@cybersecureone.com?subject=Security One SOC 諮詢"
                        class="btn btn-primary animate-glow"
                        :whileHover="{ scale: 1.15, y: -8 }"
                        :whilePress="{ scale: 0.9 }"
                        :transition="{ type: 'spring', stiffness: 400, damping: 10 }"
                    >
                        <span>🚀</span> 聯絡我們
                    </motion.a>
                </motion.div>

                <!-- Scroll Indicator -->
                <motion.div
                    class="scroll-indicator"
                    :style="{ opacity: 1 - scrollProgress }"
                    :initial="{ opacity: 0, y: 20 }"
                    :animate="!isLoading ? { opacity: 1, y: [0, 12, 0] } : { opacity: 0 }"
                    :transition="{ opacity: { delay: 1.8, duration: 0.5 }, y: { repeat: Infinity, duration: 1.5, ease: 'easeInOut' } }"
                >
                    <span>向下滾動</span>
                    <div class="scroll-arrow">↓</div>
                </motion.div>
            </section>
        </div>
        
        <!-- Features Section -->
        <section id="features" class="features">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >核心功能</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                完整的 WAF 解決方案，從防護到監控一應俱全
            </motion.p>

            <div class="features-grid" :style="isMobile ? {} : { perspective: '1000px' }">
                <motion.div
                    v-for="(feature, index) in features"
                    :key="index"
                    :initial="isMobile ? { opacity: 0, y: 40, scale: 0.85 } : { opacity: 0, y: 80, scale: 0.6, rotateX: 45 }"
                    :whileInView="isMobile ? { opacity: 1, y: 0, scale: 1 } : { opacity: 1, y: 0, scale: 1, rotateX: 0 }"
                    :viewport="{ once: true, amount: 0.1 }"
                    :transition="{ type: 'spring', stiffness: 70, damping: 12, delay: (index % 4) * 0.1 }"
                    :whileHover="isMobile ? undefined : { scale: 1.08, y: -12, rotateY: 5 }"
                    :style="isMobile ? {} : { transformStyle: 'preserve-3d' }"
                >
                    <FeatureCard
                        :icon="feature.icon"
                        :title="feature.title"
                        :description="feature.description"
                        :delay="0"
                        @click="openModal(feature)"
                    />
                </motion.div>
            </div>
        </section>

        <!-- Core Attack Protection Section -->
        <section class="attack-protection-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >🛡️ 核心攻擊防護</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                18 種攻擊類型全方位防護，多層級安全等級控制
            </motion.p>

            <div class="waf-rules-container">
                <motion.div class="waf-category" v-for="(category, catIndex) in wafProtectionRules" :key="catIndex"
                    :initial="isMobile ? { opacity: 0, y: 30, scale: 0.95 } : { opacity: 0, x: -60, scale: 0.9 }"
                    :whileInView="isMobile ? { opacity: 1, y: 0, scale: 1 } : { opacity: 1, x: 0, scale: 1 }"
                    :viewport="{ once: true, amount: 0.1 }"
                    :transition="{ type: 'spring', stiffness: 60, damping: 12, delay: catIndex * 0.2 }"
                >
                    <div class="waf-category-header">
                        <span class="cat-icon">{{ category.icon }}</span>
                        <h3>{{ category.name }}</h3>
                    </div>
                    <div class="waf-rules-list">
                        <div class="waf-rule-item" v-for="(rule, ruleIndex) in category.rules" :key="ruleIndex">
                            <div class="rule-info">
                                <div class="rule-title-row">
                                    <span class="rule-name">{{ rule.name }}</span>
                                    <span class="rule-severity" :class="rule.severity">{{ rule.severity.toUpperCase() }}</span>
                                </div>
                                <p class="rule-desc">{{ rule.desc }}</p>
                            </div>
                            <div class="rule-levels">
                                <span class="level-btn" :class="{ inactive: true }">OFF</span>
                                <span class="level-btn" :class="{ inactive: true }">LOW</span>
                                <span class="level-btn" :class="{ inactive: true }">MED</span>
                                <span class="level-btn active high">HIGH</span>
                            </div>
                        </div>
                    </div>
                </motion.div>
            </div>
        </section>

        <!-- IDS/IPS Distributed Defense Section -->
        <section class="ids-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >🔗 IDS/IPS 分散式防禦</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                部署在後端伺服器的 Agent，形成縱深防禦架構
            </motion.p>
            
            <div class="ids-architecture scroll-animate scale-up">
                <div class="ids-hub">
                    <div class="hub-icon">🏢</div>
                    <span class="hub-label">SOC Hub</span>
                    <span class="hub-desc">中央控制中心</span>
                </div>
                
                <div class="ids-connections">
                    <svg viewBox="0 0 200 100" preserveAspectRatio="none">
                        <path d="M 20 50 Q 100 20, 180 30" stroke="url(#idsGrad)" stroke-width="2" fill="none" class="conn-path"/>
                        <path d="M 20 50 Q 100 50, 180 50" stroke="url(#idsGrad)" stroke-width="2" fill="none" class="conn-path"/>
                        <path d="M 20 50 Q 100 80, 180 70" stroke="url(#idsGrad)" stroke-width="2" fill="none" class="conn-path"/>
                        <defs>
                            <linearGradient id="idsGrad" x1="0%" y1="0%" x2="100%" y2="0%">
                                <stop offset="0%" stop-color="#00d4ff"/>
                                <stop offset="100%" stop-color="#8b5cf6"/>
                            </linearGradient>
                        </defs>
                    </svg>
                </div>
                
                <div class="ids-agents">
                    <div class="agent-node" v-for="(agent, i) in idsAgents" :key="i">
                        <div class="agent-icon">{{ agent.icon }}</div>
                        <span class="agent-label">{{ agent.name }}</span>
                    </div>
                </div>
            </div>
            
            <div class="ids-engines">
                <motion.div class="engine-card" v-for="(engine, ei) in idsEngines" :key="engine.name"
                    :initial="isMobile ? { opacity: 0, y: 30 } : { opacity: 0, y: 40, rotateX: 15 }"
                    :whileInView="isMobile ? { opacity: 1, y: 0 } : { opacity: 1, y: 0, rotateX: 0 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 80, damping: 15, delay: ei * 0.12 }"
                    :whileHover="isMobile ? undefined : { y: -12, scale: 1.08, rotateX: -5 }"
                >
                    <div class="engine-icon">{{ engine.icon }}</div>
                    <h4>{{ engine.name }}</h4>
                    <p>{{ engine.desc }}</p>
                    <ul>
                        <li v-for="feature in engine.features" :key="feature">{{ feature }}</li>
                    </ul>
                </motion.div>
            </div>
        </section>

        <!-- Traffic Control Section -->
        <section class="traffic-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >⚡ 流量控制與防護</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                CC/DDoS 防護、自動封鎖、人機驗證多重機制
            </motion.p>

            <div class="traffic-features">
                <motion.div class="traffic-card" v-for="(item, ti) in trafficFeatures" :key="item.title"
                    :initial="{ opacity: 0, y: 30, scale: 0.95 }"
                    :whileInView="{ opacity: 1, y: 0, scale: 1 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 100, damping: 15, delay: ti * 0.1 }"
                    :whileHover="{ y: -12, scale: 1.08 }"
                >
                    <div class="traffic-icon">{{ item.icon }}</div>
                    <h4>{{ item.title }}</h4>
                    <p>{{ item.desc }}</p>
                </motion.div>
            </div>
        </section>

        <!-- Rule Management Section -->
        <section class="rules-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >📋 規則管理</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                自訂規則、全域規則、CVE 自動生成規則
            </motion.p>

            <div class="rules-flow">
                <motion.div class="rule-type" v-for="(rule, ri) in ruleTypes" :key="rule.name"
                    :initial="{ opacity: 0, y: 30, scale: 0.9 }"
                    :whileInView="{ opacity: 1, y: 0, scale: 1 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 100, damping: 15, delay: ri * 0.12 }"
                    :whileHover="{ y: -12, scale: 1.1, rotate: 2 }"
                >
                    <div class="rule-icon">{{ rule.icon }}</div>
                    <h4>{{ rule.name }}</h4>
                    <p>{{ rule.desc }}</p>
                </motion.div>
            </div>
        </section>
        
        <!-- Stats Section -->
        <section class="stats">
            <div class="stats-grid">
                <motion.div
                    class="stat-item"
                    v-for="(stat, index) in stats"
                    :key="index"
                    :initial="{ opacity: 0, scale: 0, y: 60 }"
                    :whileInView="{ opacity: 1, scale: 1, y: 0 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 150, damping: 8, delay: index * 0.15 }"
                    :whileHover="{ scale: 1.15, y: -10 }"
                >
                    <AnimatedCounter :target="stat.value" :suffix="stat.suffix" />
                    <p class="stat-label">{{ stat.label }}</p>
                </motion.div>
            </div>
        </section>
        
        <!-- Product Showcase (Fixed Scroll Slideshow) -->
        <section class="product-showcase" ref="showcaseRef">
            <!-- Spacer for scroll distance -->
            <div class="showcase-spacer"></div>
            
            <!-- Fixed Container -->
            <div class="showcase-fixed-container" :style="{ opacity: showcaseVisible ? 1 : 0 }">
                <!-- Slide 1: Attack Map -->
                <div class="showcase-slide" :class="{ active: currentSlide === 0 }">
                    <h2 class="section-title text-gradient">🌍 即時攻擊地圖</h2>
                    <p class="section-subtitle">全球攻擊來源視覺化，即時掌握威脅動態</p>
                    
                    <div class="showcase-image-wrapper">
                        <img src="/images/attackmap.png?v=2" alt="Attack Map" />
                        <div class="image-glow blue"></div>
                    </div>
                    
                    <div class="showcase-tags">
                        <span class="tag"><span class="dot red"></span>即時攻擊軌跡</span>
                        <span class="tag"><span class="dot blue"></span>地理位置追蹤</span>
                        <span class="tag"><span class="dot green"></span>攻擊類型統計</span>
                    </div>
                </div>
                
                <!-- Slide 2: Attack Log -->
                <div class="showcase-slide" :class="{ active: currentSlide === 1 }">
                    <h2 class="section-title text-gradient">📋 攻擊日誌分析</h2>
                    <p class="section-subtitle">詳細記錄每次攻擊，完整追蹤安全事件</p>
                    
                    <div class="showcase-image-wrapper">
                        <img src="/images/attacklog.png" alt="Attack Log" />
                        <div class="image-glow purple"></div>
                    </div>
                    
                    <div class="showcase-tags">
                        <span class="tag"><span class="dot orange"></span>攻擊類型分類</span>
                        <span class="tag"><span class="dot cyan"></span>請求詳細資訊</span>
                        <span class="tag"><span class="dot pink"></span>一鍵封鎖 IP</span>
                    </div>
                </div>
                
                <!-- Slide Indicators -->
                <div class="slide-indicators">
                    <span class="indicator" :class="{ active: currentSlide === 0 }"></span>
                    <span class="indicator" :class="{ active: currentSlide === 1 }"></span>
                </div>
                
                <!-- Slide Progress -->
                <div class="slide-progress">
                    <div class="progress-bar" :style="{ width: slideProgress + '%' }"></div>
                </div>
            </div>
        </section>
        
        <!-- AI Features Highlight Section -->
        <section id="ai-features" class="ai-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >🤖 AI 智能防禦</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                突破傳統規則限制，使用 AI 即時分析與偵測進階威脅
            </motion.p>

            <div class="ai-features-grid">
                <motion.div
                    class="ai-feature-card"
                    v-for="(feature, index) in aiFeatures"
                    :key="index"
                    :initial="isMobile ? { opacity: 0, y: 40, scale: 0.9 } : { opacity: 0, y: 100, scale: 0.5, rotateY: -30 }"
                    :whileInView="isMobile ? { opacity: 1, y: 0, scale: 1 } : { opacity: 1, y: 0, scale: 1, rotateY: 0 }"
                    :viewport="{ once: true, amount: 0.1 }"
                    :transition="{ type: 'spring', stiffness: 60, damping: 10, delay: isMobile ? index * 0.1 : index * 0.25 }"
                    :whileHover="isMobile ? undefined : { y: -15, scale: 1.06, rotateY: 5 }"
                    @click="openModal(feature)"
                >
                    <div class="ai-feature-icon animate-float">{{ feature.icon }}</div>
                    <h3 class="ai-feature-title">{{ feature.title }}</h3>
                    <p class="ai-feature-desc">{{ feature.description }}</p>
                    <ul class="ai-feature-list">
                        <li v-for="(item, i) in feature.highlights.slice(0, 3)" :key="i">{{ item }}</li>
                    </ul>
                    <span class="view-more">查看詳情 →</span>
                </motion.div>
            </div>
        </section>
        
        <!-- CVE Database Section -->
        <section class="cve-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >📡 CVE 資料庫即時更新</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                自動同步 NVD 漏洞資料庫，AI 智能生成防護規則
            </motion.p>

            <div class="cve-flow">
                <motion.div class="cve-step" v-for="(step, index) in cveSteps" :key="index"
                    :initial="isMobile ? { opacity: 0, y: 20 } : { opacity: 0, x: -40 }"
                    :whileInView="isMobile ? { opacity: 1, y: 0 } : { opacity: 1, x: 0 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 80, damping: 15, delay: index * 0.15 }"
                    :whileHover="{ y: -5, scale: 1.05 }"
                >
                    <div class="cve-step-icon">{{ step.icon }}</div>
                    <div class="cve-step-content">
                        <h4>{{ step.title }}</h4>
                        <p>{{ step.description }}</p>
                    </div>
                    <div v-if="index < cveSteps.length - 1" class="cve-arrow">→</div>
                </motion.div>
            </div>
            
            <motion.div class="cve-info-box"
                :initial="{ opacity: 0, y: 20 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.5 }"
                :transition="{ type: 'spring', stiffness: 100, damping: 20, delay: 0.3 }"
            >
                <h4>🔍 支援的情報來源</h4>
                <div class="cve-sources">
                    <motion.span class="cve-source" v-for="(source, i) in cveSources" :key="i"
                        :initial="{ opacity: 0, scale: 0.5 }"
                        :whileInView="{ opacity: 1, scale: 1 }"
                        :viewport="{ once: true }"
                        :transition="{ type: 'spring', stiffness: 200, damping: 12, delay: 0.4 + i * 0.1 }"
                        :whileHover="{ scale: 1.1 }"
                    >
                        {{ source }}
                    </motion.span>
                </div>
            </motion.div>
        </section>
        
        <!-- Attack Demo Section -->
        <section class="demo-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >攻擊偵測流程</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                從攻擊發生到封鎖只需毫秒級反應
            </motion.p>

            <div class="demo-timeline">
                <motion.div class="timeline-item" v-for="(step, index) in attackFlow" :key="index"
                    :initial="{ opacity: 0, x: index % 2 === 0 ? -40 : 40 }"
                    :whileInView="{ opacity: 1, x: 0 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 80, damping: 15, delay: index * 0.15 }"
                >
                    <div class="timeline-time">{{ step.time }}</div>
                    <div class="timeline-dot" :class="step.type"></div>
                    <div class="timeline-content">
                        <h4>{{ step.title }}</h4>
                        <p>{{ step.desc }}</p>
                    </div>
                </motion.div>
            </div>
        </section>

        <!-- SOC Command Center Section -->
        <section class="soc-section">
            <div class="soc-bg-grid"></div>
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >👁️ SOC 戰情中心</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                專業級資安監控儀表板，全螢幕 3D 威脅視覺化
            </motion.p>

            <motion.div class="soc-dashboard"
                :initial="isMobile ? { opacity: 0, y: 30 } : { opacity: 0, scale: 0.6, y: 80 }"
                :whileInView="isMobile ? { opacity: 1, y: 0 } : { opacity: 1, scale: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.05 }"
                :transition="{ type: 'spring', stiffness: 40, damping: 12, delay: 0.2 }"
            >
                <div class="soc-screen">
                    <!-- Decor Elements -->
                    <div class="screen-overlay"></div>
                    <div class="corner-decor top-left"></div>
                    <div class="corner-decor top-right"></div>
                    <div class="corner-decor bottom-left"></div>
                    <div class="corner-decor bottom-right"></div>
                    
                    <!-- Header -->
                    <div class="soc-header">
                        <div class="status-indicator">
                            <span class="status-dot"></span>
                            <span class="status-text">SYSTEM ONLINE</span>
                            <span class="status-ping">PING: 12ms</span>
                        </div>
                        <div class="soc-header-right">
                            <span class="soc-server-id">SERVER: TW-01-NODE</span>
                            <span class="soc-btn">🖥️ FULLSCREEN</span>
                            <span class="soc-btn">🖥️ 系統狀態</span>
                            <span class="soc-btn accent-btn">🔐 返回儀表板</span>
                        </div>
                    </div>

                    <div class="soc-layout">
                        <!-- Left Panel -->
                        <div class="soc-panel left">
                            <div class="panel-box map-section">
                                <h3><span class="soc-accent">|</span> ATTACK MAP</h3>
                                <div class="mini-map-container">
                                    <!-- World map image background -->
                                    <img src="/images/world_map.png" class="mini-map-img" alt="World Map">
                                    <!-- SVG overlay -->
                                    <svg viewBox="0 0 1000 500" class="mini-map-svg" preserveAspectRatio="xMidYMid meet">
                                        <!-- Taiwan node marker -->
                                        <g>
                                            <circle cx="810" cy="220" r="5" class="target-dot">
                                                <animate attributeName="r" values="5;12;5" dur="2s" repeatCount="indefinite" />
                                                <animate attributeName="opacity" values="1;0.5;1" dur="2s" repeatCount="indefinite" />
                                            </circle>
                                            <circle cx="810" cy="220" r="15" class="target-ring">
                                                <animate attributeName="r" values="10;30" dur="2s" repeatCount="indefinite" />
                                                <animate attributeName="opacity" values="0.8;0" dur="2s" repeatCount="indefinite" />
                                            </circle>
                                            <text x="820" y="210" class="node-label">TW-01</text>
                                        </g>

                                        <!-- Attack line 1: US → TW (SQLI - red) -->
                                        <path d="M230,180 Q520,80 810,220" fill="none" stroke="#ef4444" stroke-width="2" stroke-dasharray="200" stroke-linecap="round" class="attack-path">
                                            <animate attributeName="stroke-dashoffset" values="200;0" dur="3s" repeatCount="indefinite" />
                                        </path>
                                        <circle cx="230" cy="180" r="5" fill="#ef4444">
                                            <animate attributeName="opacity" values="1;0.5;1" dur="2s" repeatCount="indefinite" />
                                        </circle>
                                        <text x="238" y="172" class="attack-label" fill="#ef4444">45.33.22.11</text>

                                        <!-- Attack line 2: EU → TW (DDoS - purple) -->
                                        <path d="M480,140 Q650,60 810,220" fill="none" stroke="#e040fb" stroke-width="3" stroke-dasharray="200" stroke-linecap="round" class="attack-path">
                                            <animate attributeName="stroke-dashoffset" values="200;0" dur="2s" repeatCount="indefinite" />
                                        </path>
                                        <!-- DDoS pulsing rings -->
                                        <circle cx="480" cy="140" r="5" fill="none" stroke="#e040fb" stroke-width="1.5">
                                            <animate attributeName="r" values="5;18" dur="1.5s" repeatCount="indefinite" />
                                            <animate attributeName="opacity" values="0.6;0" dur="1.5s" repeatCount="indefinite" />
                                        </circle>
                                        <circle cx="480" cy="140" r="6" fill="#e040fb">
                                            <animate attributeName="opacity" values="1;0.5;1" dur="1.5s" repeatCount="indefinite" />
                                        </circle>
                                        <text x="488" y="132" class="attack-label" fill="#e040fb" style="font-weight:700">⚡ 203.0.113.5</text>

                                        <!-- Attack line 3: Asia → TW (SCAN - cyan) -->
                                        <path d="M680,280 Q750,240 810,220" fill="none" stroke="#06b6d4" stroke-width="1.5" stroke-dasharray="200" stroke-linecap="round" class="attack-path">
                                            <animate attributeName="stroke-dashoffset" values="200;0" dur="4s" repeatCount="indefinite" />
                                        </path>
                                        <circle cx="680" cy="280" r="4" fill="#06b6d4">
                                            <animate attributeName="opacity" values="1;0.3;1" dur="3s" repeatCount="indefinite" />
                                        </circle>
                                        <text x="688" y="272" class="attack-label" fill="#06b6d4">172.16.8.99</text>

                                        <!-- Attack line 4: Russia → TW (blocked - red) -->
                                        <path d="M550,100 Q680,50 810,220" fill="none" stroke="#ef4444" stroke-width="1.5" stroke-dasharray="200" stroke-linecap="round" class="attack-path" opacity="0.6">
                                            <animate attributeName="stroke-dashoffset" values="200;0" dur="3.5s" repeatCount="indefinite" />
                                        </path>
                                        <circle cx="550" cy="100" r="4" fill="#ef4444" opacity="0.6">
                                            <animate attributeName="opacity" values="0.8;0.3;0.8" dur="2.5s" repeatCount="indefinite" />
                                        </circle>
                                        <text x="558" y="92" class="attack-label" fill="#ef4444">192.168.1.45</text>
                                    </svg>
                                </div>
                            </div>

                            <!-- AI Report -->
                            <div class="panel-box">
                                <h3><span class="soc-accent">|</span> AI 報告</h3>
                                <div class="soc-ai-status-row">✅ 正常運作</div>
                                <div class="soc-ai-content">
                                    <div class="soc-ai-text">系統運行穩定，偵測到少量掃描行為，已自動阻擋。建議持續監控。</div>
                                </div>
                                <div class="soc-ai-btns">
                                    <span class="soc-mini-btn">📊 生成</span>
                                    <span class="soc-mini-btn">📧 寄送</span>
                                </div>
                            </div>

                            <!-- System Metrics -->
                            <div class="panel-box">
                                <h3><span class="soc-accent">|</span> SYSTEM METRICS</h3>
                                <div class="soc-metrics">
                                    <div class="soc-metric-row"><span>BLOCK</span><div class="soc-bar"><div class="soc-bar-fill blue" style="width:15%"></div></div><span>15%</span></div>
                                    <div class="soc-metric-row"><span>LOAD</span><div class="soc-bar"><div class="soc-bar-fill green" style="width:32%"></div></div><span>32%</span></div>
                                    <div class="soc-metric-row"><span>THREAT</span><div class="soc-bar"><div class="soc-bar-fill orange" style="width:18%"></div></div><span>18%</span></div>
                                    <div class="soc-metric-row"><span>CONN</span><div class="soc-bar"><div class="soc-bar-fill purple" style="width:24%"></div></div><span>120</span></div>
                                    <div class="soc-metric-row"><span>QPS</span><div class="soc-bar"><div class="soc-bar-fill cyan" style="width:45%"></div></div><span>45</span></div>
                                </div>
                            </div>

                            <!-- Hardware -->
                            <div class="panel-box">
                                <h3><span class="soc-accent">|</span> HARDWARE</h3>
                                <div class="soc-hw-grid">
                                    <svg viewBox="0 0 80 80" class="soc-hw-gauge">
                                        <circle cx="40" cy="40" r="32" fill="none" stroke="rgba(255,255,255,0.06)" stroke-width="5"/>
                                        <circle cx="40" cy="40" r="32" fill="none" stroke="#22c55e" stroke-width="5" stroke-linecap="round" stroke-dasharray="201" stroke-dashoffset="117" transform="rotate(-90 40 40)"/>
                                        <text x="40" y="38" text-anchor="middle" dominant-baseline="middle" fill="white" font-size="14" font-weight="bold" font-family="monospace">42%</text>
                                        <text x="40" y="54" text-anchor="middle" fill="rgba(255,255,255,0.5)" font-size="9" font-family="monospace">CPU</text>
                                    </svg>
                                    <svg viewBox="0 0 80 80" class="soc-hw-gauge">
                                        <circle cx="40" cy="40" r="32" fill="none" stroke="rgba(255,255,255,0.06)" stroke-width="5"/>
                                        <circle cx="40" cy="40" r="32" fill="none" stroke="#eab308" stroke-width="5" stroke-linecap="round" stroke-dasharray="201" stroke-dashoffset="63" transform="rotate(-90 40 40)"/>
                                        <text x="40" y="38" text-anchor="middle" dominant-baseline="middle" fill="white" font-size="14" font-weight="bold" font-family="monospace">68%</text>
                                        <text x="40" y="54" text-anchor="middle" fill="rgba(255,255,255,0.5)" font-size="9" font-family="monospace">RAM</text>
                                    </svg>
                                    <svg viewBox="0 0 80 80" class="soc-hw-gauge">
                                        <circle cx="40" cy="40" r="32" fill="none" stroke="rgba(255,255,255,0.06)" stroke-width="5"/>
                                        <circle cx="40" cy="40" r="32" fill="none" stroke="#22c55e" stroke-width="5" stroke-linecap="round" stroke-dasharray="201" stroke-dashoffset="140" transform="rotate(-90 40 40)"/>
                                        <text x="40" y="38" text-anchor="middle" dominant-baseline="middle" fill="white" font-size="14" font-weight="bold" font-family="monospace">30%</text>
                                        <text x="40" y="54" text-anchor="middle" fill="rgba(255,255,255,0.5)" font-size="9" font-family="monospace">DISK</text>
                                    </svg>
                                    <svg viewBox="0 0 80 80" class="soc-hw-gauge">
                                        <circle cx="40" cy="40" r="32" fill="none" stroke="rgba(255,255,255,0.06)" stroke-width="5"/>
                                        <circle cx="40" cy="40" r="32" fill="none" stroke="#22c55e" stroke-width="5" stroke-linecap="round" stroke-dasharray="201" stroke-dashoffset="181" transform="rotate(-90 40 40)"/>
                                        <text x="40" y="38" text-anchor="middle" dominant-baseline="middle" fill="white" font-size="14" font-weight="bold" font-family="monospace">10%</text>
                                        <text x="40" y="54" text-anchor="middle" fill="rgba(255,255,255,0.5)" font-size="9" font-family="monospace">NET</text>
                                    </svg>
                                </div>
                                <div class="soc-net-detail">
                                    <span>↓ 1.2 MB/s</span>
                                    <span>↑ 456 KB/s</span>
                                </div>
                            </div>
                        </div>

                        <!-- Center Panel: 3D Globe -->
                        <div class="soc-panel center">
                            <div class="soc-globe-header">
                                <span class="status-dot green"></span>
                                <span>GLOBAL THREAT MONITOR</span>
                            </div>
                            <div class="globe-3d-container">
                                <Waf3DVisualizer />
                            </div>
                            <div class="soc-globe-legend">
                                <span><span class="legend-dot red"></span>BLOCKED</span>
                                <span><span class="legend-dot purple"></span>DDoS</span>
                                <span><span class="legend-dot orange"></span>IDS</span>
                                <span><span class="legend-dot green"></span>ALLOWED</span>
                            </div>
                        </div>

                        <!-- Right Panel -->
                        <div class="soc-panel right">
                            <!-- Live Attack Feed -->
                            <div class="panel-box">
                                <h3><span class="soc-accent">|</span> LIVE ATTACK FEED</h3>
                                <div class="log-list">
                                    <div class="log-item"><span class="log-time">14:42:05</span><span class="log-ip">192.168.1.45</span><span class="log-detail">cybersecure..</span><span class="log-type" style="color:#ef4444">SQLI</span></div>
                                    <div class="log-item"><span class="log-time">14:41:58</span><span class="log-ip">10.0.5.122</span><span class="log-detail">api/v1/user..</span><span class="log-type" style="color:#f97316">XSS</span></div>
                                    <div class="log-item"><span class="log-time">14:41:42</span><span class="log-ip">45.33.22.11</span><span class="log-detail">target-site</span><span class="log-type" style="color:#e040fb">DDoS</span><span class="log-severity high">高</span></div>
                                    <div class="log-item"><span class="log-time">14:41:15</span><span class="log-ip">172.16.8.99</span><span class="log-detail">scan /admin</span><span class="log-type" style="color:#06b6d4">SCAN</span></div>
                                    <div class="log-item"><span class="log-time">14:40:55</span><span class="log-ip">203.0.113.5</span><span class="log-detail">/wp-login</span><span class="log-type" style="color:#f43f5e">BRUTE</span></div>
                                    <div class="log-item"><span class="log-time">14:40:30</span><span class="log-ip">198.51.100.7</span><span class="log-detail">agent-srv01</span><span class="log-type" style="color:#10b981">IDS</span><span class="log-severity medium">中</span></div>
                                </div>
                            </div>

                            <!-- WAF Security Status -->
                            <div class="panel-box">
                                <h3><span class="soc-accent">|</span> WAF 安全狀態</h3>
                                <div class="soc-security-status">
                                    <div class="soc-security-circle">
                                        <svg viewBox="0 0 120 120">
                                            <circle cx="60" cy="60" r="54" fill="none" stroke="rgba(255,255,255,0.06)" stroke-width="4"/>
                                            <circle cx="60" cy="60" r="54" fill="none" stroke="#22c55e" stroke-width="4" stroke-linecap="round" stroke-dasharray="339.3" stroke-dashoffset="3.4" transform="rotate(-90 60 60)"/>
                                        </svg>
                                        <span class="soc-security-value">99%</span>
                                    </div>
                                    <span class="soc-security-label" style="color:#22c55e">安全</span>
                                </div>
                                <div class="soc-security-stats">
                                    <div class="soc-stat-row"><span>✅ 攻擊偵測</span><span style="color:#22c55e">正常運作</span></div>
                                    <div class="soc-stat-row"><span>總請求</span><span>5.2M</span></div>
                                    <div class="soc-stat-row"><span>已阻擋</span><span style="color:#ef4444">12.8k</span></div>
                                    <div class="soc-stat-row"><span>24h 請求</span><span style="color:#06b6d4">45.2k</span></div>
                                    <div class="soc-stat-row"><span>24h 阻擋</span><span style="color:#f97316">892</span></div>
                                </div>
                            </div>

                            <!-- IDS/IPS Status -->
                            <div class="panel-box">
                                <h3><span class="soc-accent">|</span> IDS/IPS 狀態</h3>
                                <div class="soc-ids-stats">
                                    <div class="soc-stat-row"><span>🛡️ IDS (偵測)</span><span style="color:#22c55e">啟用</span></div>
                                    <div class="soc-stat-row"><span>⚔️ IPS (防護)</span><span style="color:#f97316">啟用</span></div>
                                    <div class="soc-stat-row"><span>🤖 AI 偵測</span><span style="color:#a855f7">啟用</span></div>
                                    <div class="soc-stat-row"><span>📡 線上 Agent</span><span style="color:#06b6d4">3 / 5</span></div>
                                    <div class="soc-stat-row"><span>⚠️ 今日警報</span><span style="color:#ef4444">7</span></div>
                                </div>
                            </div>

                            <!-- Agent Status -->
                            <div class="panel-box">
                                <h3><span class="soc-accent">|</span> Agent 狀態</h3>
                                <div class="soc-agent-list">
                                    <div class="soc-agent-item"><span class="agent-dot online"></span><span>srv-web-01</span><span>🐧</span><span class="agent-ip-text">10.0.1.10</span></div>
                                    <div class="soc-agent-item"><span class="agent-dot online"></span><span>srv-db-01</span><span>🐧</span><span class="agent-ip-text">10.0.1.20</span></div>
                                    <div class="soc-agent-item"><span class="agent-dot offline"></span><span>srv-backup</span><span>💻</span><span class="agent-ip-text">10.0.1.30</span></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Footer -->
                    <div class="soc-footer-bar">
                        <span class="soc-footer-copy">Protected by <strong>Security One SOC</strong></span>
                        <span class="soc-footer-time">2026/02/18 14:42:05</span>
                    </div>
                </div>
            </motion.div>
        </section>

        <!-- WAF Protection Pipeline (Sticky Scroll) -->
        <section class="sticky-pipeline" ref="pipelineRef">
            <div class="sticky-spacer"></div>
            <div class="sticky-fixed-container" :style="{ opacity: pipelineVisible ? 1 : 0 }">
                <!-- Step 1: Request Interception -->
                <div class="sticky-slide" :class="{ active: pipelineSlide === 0 }">
                    <div class="sticky-slide-icon">🌐</div>
                    <h2 class="section-title text-gradient">Step 1：請求攔截</h2>
                    <p class="sticky-slide-desc">所有 HTTP/HTTPS 請求經由 Nginx 反向代理進入 WAF 層<br>自動解析 URL、Header、Body、Cookie 全部欄位</p>
                    <div class="sticky-slide-visual">
                        <div class="pipeline-flow">
                            <div class="pf-node client">👤 Client</div>
                            <div class="pf-arrow">→</div>
                            <div class="pf-node waf active-glow">🛡️ WAF Layer</div>
                            <div class="pf-arrow dim">→</div>
                            <div class="pf-node origin dim">🖥️ Origin</div>
                        </div>
                    </div>
                    <div class="sticky-slide-tags">
                        <span class="tag"><span class="dot blue"></span>TLS 終止</span>
                        <span class="tag"><span class="dot green"></span>請求解析</span>
                        <span class="tag"><span class="dot orange"></span>黑名單檢查</span>
                    </div>
                </div>

                <!-- Step 2: AI Analysis -->
                <div class="sticky-slide" :class="{ active: pipelineSlide === 1 }">
                    <div class="sticky-slide-icon">🤖</div>
                    <h2 class="section-title text-gradient">Step 2：智能分析</h2>
                    <p class="sticky-slide-desc">多引擎並行分析：規則引擎匹配已知攻擊模式<br>AI Sentinel 對未知威脅進行行為分析與威脅評分</p>
                    <div class="sticky-slide-visual">
                        <div class="analysis-engines">
                            <div class="engine-box">
                                <span class="engine-icon">🔎</span>
                                <span class="engine-label">規則引擎</span>
                                <span class="engine-check">✓ 3,200+ 規則</span>
                            </div>
                            <div class="engine-box highlight">
                                <span class="engine-icon">🧠</span>
                                <span class="engine-label">AI Sentinel</span>
                                <span class="engine-check">✓ 威脅評分 0-100</span>
                            </div>
                            <div class="engine-box">
                                <span class="engine-icon">📊</span>
                                <span class="engine-label">行為分析</span>
                                <span class="engine-check">✓ 異常偵測</span>
                            </div>
                        </div>
                    </div>
                    <div class="sticky-slide-tags">
                        <span class="tag"><span class="dot red"></span>SQL/XSS/RCE 偵測</span>
                        <span class="tag"><span class="dot cyan"></span>LLM 分析</span>
                        <span class="tag"><span class="dot pink"></span>0-Day 防護</span>
                    </div>
                </div>

                <!-- Step 3: Result Action -->
                <div class="sticky-slide" :class="{ active: pipelineSlide === 2 }">
                    <div class="sticky-slide-icon">⚡</div>
                    <h2 class="section-title text-gradient">Step 3：處置行動</h2>
                    <p class="sticky-slide-desc">根據威脅評分自動執行：放行、記錄、挑戰驗證或即時封鎖<br>所有事件即時記錄至 SOC 戰情中心</p>
                    <div class="sticky-slide-visual">
                        <div class="action-results">
                            <div class="action-card pass">
                                <span class="action-icon">✅</span>
                                <span class="action-label">放行</span>
                                <span class="action-score">Score &lt; 30</span>
                            </div>
                            <div class="action-card warn">
                                <span class="action-icon">⚠️</span>
                                <span class="action-label">記錄 & 監控</span>
                                <span class="action-score">Score 30-60</span>
                            </div>
                            <div class="action-card challenge">
                                <span class="action-icon">🔒</span>
                                <span class="action-label">人機驗證</span>
                                <span class="action-score">Score 60-80</span>
                            </div>
                            <div class="action-card block">
                                <span class="action-icon">🚫</span>
                                <span class="action-label">即時封鎖</span>
                                <span class="action-score">Score &gt; 80</span>
                            </div>
                        </div>
                    </div>
                    <div class="sticky-slide-tags">
                        <span class="tag"><span class="dot green"></span>自動處置</span>
                        <span class="tag"><span class="dot blue"></span>SOC 告警</span>
                        <span class="tag"><span class="dot red"></span>IP 封鎖</span>
                    </div>
                </div>

                <!-- Slide Indicators -->
                <div class="sticky-indicators">
                    <span class="sticky-ind" :class="{ active: pipelineSlide === 0 }">1</span>
                    <span class="sticky-ind" :class="{ active: pipelineSlide === 1 }">2</span>
                    <span class="sticky-ind" :class="{ active: pipelineSlide === 2 }">3</span>
                </div>

                <div class="slide-progress">
                    <div class="progress-bar" :style="{ width: pipelineProgress + '%' }"></div>
                </div>
            </div>
        </section>

        <!-- Passkey Authentication Section -->
        <section class="passkey-section">
            <div class="passkey-container">
                <motion.div class="passkey-text"
                    :initial="isMobile ? { opacity: 0, y: 30 } : { opacity: 0, x: -60 }"
                    :whileInView="isMobile ? { opacity: 1, y: 0 } : { opacity: 1, x: 0 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 70, damping: 18 }"
                >
                    <h2 class="section-title text-gradient">🔐 零信任身份驗證</h2>
                    <p class="section-lead">無需修改後端程式碼，立即為您的網站啟用生物辨識登入</p>
                    <ul class="passkey-features">
                        <li>👆 支援 TouchID / FaceID</li>
                        <li>🔑 FIDO2 / WebAuthn 標準</li>
                        <li>🛡️ 站點級別存取控制</li>
                        <li>⚡ 毫秒級無密碼登入</li>
                    </ul>
                </motion.div>
                <motion.div class="passkey-visual"
                    :initial="isMobile ? { opacity: 0, y: 30 } : { opacity: 0, x: 60, scale: 0.9 }"
                    :whileInView="isMobile ? { opacity: 1, y: 0 } : { opacity: 1, x: 0, scale: 1 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 70, damping: 18, delay: 0.2 }"
                >
                    <div class="fingerprint-scanner">
                        <div class="scan-line"></div>
                        <div class="fingerprint-icon">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2">
                                <path d="M12 11c0 3.517-1.009 6.799-2.753 9.571m-3.44-2.04l.054-.09A13.916 13.916 0 008 11a4 4 0 118 0c0 1.017-.07 2.019-.203 3m-2.118 6.844A21.88 21.88 0 0015.171 17m3.839 1.132c.645-2.266.99-4.659.99-7.132A8 8 0 008 4.07M3 15.364c.64-1.319 1-2.8 1-4.364 0-1.457.39-2.823 1.07-4"/>
                            </svg>
                        </div>
                        <div class="scanner-text">ACCESS GRANTED</div>
                    </div>
                </motion.div>
            </div>
        </section>

        <!-- AI Report Section -->
        <section class="report-section">
            <div class="report-container">
                <motion.div class="report-visual"
                    :initial="isMobile ? { opacity: 0, y: 30 } : { opacity: 0, x: -60, rotateY: 15 }"
                    :whileInView="isMobile ? { opacity: 1, y: 0 } : { opacity: 1, x: 0, rotateY: 0 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 70, damping: 18 }"
                >
                    <div class="email-mockup">
                        <div class="email-header">📧 Security Summary Report</div>
                        <div class="email-body">
                            <div class="email-chart"></div>
                            <div class="email-lines">
                                <div class="line"></div>
                                <div class="line"></div>
                                <div class="line short"></div>
                            </div>
                        </div>
                    </div>
                </motion.div>
                <motion.div class="report-text"
                    :initial="isMobile ? { opacity: 0, y: 30 } : { opacity: 0, x: 60 }"
                    :whileInView="isMobile ? { opacity: 1, y: 0 } : { opacity: 1, x: 0 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 70, damping: 18, delay: 0.2 }"
                >
                    <h2 class="section-title text-gradient">📧 AI 智能安全報告</h2>
                    <p class="section-lead">每天早晨，您的安全摘要已準備就緒</p>
                    <p class="section-desc">Sentinel AI 自動分析昨日所有流量，識別潛在威脅模式，並將精簡報告直接發送至您的信箱。</p>
                </motion.div>
            </div>
        </section>

        <!-- Load Balancer Section -->
        <section class="lb-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >⚖️ 智能負載均衡</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                多後端伺服器流量分配，自動故障轉移確保高可用性
            </motion.p>
            
            <!-- Animated Traffic Flow Diagram -->
            <div class="lb-diagram scroll-animate scale-up">
                <div class="lb-flow-container">
                    <!-- Users/Traffic -->
                    <div class="lb-source">
                        <div class="lb-icon-box users">
                            <span>👥</span>
                        </div>
                        <span class="lb-label">流量</span>
                    </div>
                    
                    <!-- Flow Lines -->
                    <svg class="lb-flow-lines" viewBox="0 0 120 160" preserveAspectRatio="none">
                        <defs>
                            <linearGradient id="flowGrad1" x1="0%" y1="0%" x2="100%" y2="0%">
                                <stop offset="0%" stop-color="#00d4ff" stop-opacity="0.8"/>
                                <stop offset="100%" stop-color="#00d4ff" stop-opacity="0.3"/>
                            </linearGradient>
                        </defs>
                        <!-- Flow to WAF -->
                        <path d="M 10 80 C 60 80, 60 80, 110 80" stroke="url(#flowGrad1)" stroke-width="3" fill="none"/>
                        <circle r="4" fill="#00f0ff">
                            <animateMotion dur="1.5s" repeatCount="indefinite" path="M 10 80 C 60 80, 60 80, 110 80"/>
                        </circle>
                    </svg>
                    
                    <!-- WAF Node -->
                    <div class="lb-waf-node">
                        <div class="lb-icon-box waf">
                            <span>🛡️</span>
                        </div>
                        <span class="lb-label">SOC</span>
                        <span class="lb-badge">負載均衡</span>
                    </div>
                    
                    <!-- Distribution Lines -->
                    <svg class="lb-dist-lines" viewBox="0 0 120 120" preserveAspectRatio="xMidYMid meet">
                        <defs>
                            <linearGradient id="distGrad" x1="0%" y1="0%" x2="100%" y2="0%">
                                <stop offset="0%" stop-color="#00d4ff" stop-opacity="0.9"/>
                                <stop offset="100%" stop-color="#00ff88" stop-opacity="0.7"/>
                            </linearGradient>
                            <linearGradient id="failGrad" x1="0%" y1="0%" x2="100%" y2="0%">
                                <stop offset="0%" stop-color="#ff6b6b" stop-opacity="0.6"/>
                                <stop offset="100%" stop-color="#ff6b6b" stop-opacity="0.3"/>
                            </linearGradient>
                        </defs>
                        <!-- To Server 1 (healthy - top, 40%) -->
                        <path d="M 0 60 C 40 60, 80 25, 120 25" stroke="url(#distGrad)" stroke-width="3" fill="none"/>
                        <circle r="4" fill="#00ff88">
                            <animateMotion dur="1.3s" repeatCount="indefinite" path="M 0 60 C 40 60, 80 25, 120 25"/>
                        </circle>
                        <!-- To Server 2 (healthy - middle, 60%) -->
                        <path d="M 0 60 C 40 55, 80 60, 120 60" stroke="url(#distGrad)" stroke-width="5" fill="none"/>
                        <circle r="5" fill="#00ff88">
                            <animateMotion dur="0.9s" repeatCount="indefinite" path="M 0 60 C 40 55, 80 60, 120 60"/>
                        </circle>
                        <!-- To Server 3 (failed - bottom, dashed) -->
                        <path d="M 0 60 C 40 60, 80 95, 120 95" stroke="url(#failGrad)" stroke-width="2" stroke-dasharray="6 4" fill="none"/>
                    </svg>
                    
                    <!-- Backend Servers -->
                    <div class="lb-servers">
                        <div class="lb-server healthy">
                            <span class="server-status"></span>
                            <span class="server-icon">🖥️</span>
                            <span class="server-label">Server 1</span>
                            <span class="server-weight">40%</span>
                        </div>
                        <div class="lb-server healthy">
                            <span class="server-status"></span>
                            <span class="server-icon">🖥️</span>
                            <span class="server-label">Server 2</span>
                            <span class="server-weight">60%</span>
                        </div>
                        <div class="lb-server failed">
                            <span class="server-status"></span>
                            <span class="server-icon">🖥️</span>
                            <span class="server-label">Server 3</span>
                            <span class="server-weight">故障</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Load Balancer Features -->
            <div class="lb-features">
                <motion.div class="lb-feature-card" v-for="(item, i) in lbFeatures" :key="i"
                    :initial="{ opacity: 0, y: 30, scale: 0.95 }"
                    :whileInView="{ opacity: 1, y: 0, scale: 1 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 100, damping: 15, delay: i * 0.1 }"
                    :whileHover="{ y: -12, scale: 1.08 }"
                >
                    <span class="lb-feature-icon">{{ item.icon }}</span>
                    <h4>{{ item.title }}</h4>
                    <p>{{ item.desc }}</p>
                </motion.div>
            </div>
            
            <!-- Strategies -->
            <div class="lb-strategies scroll-animate stagger-children">
                <h3 class="text-gradient">支援的負載均衡策略</h3>
                <div class="strategy-list">
                    <div class="strategy-item" v-for="(strategy, i) in lbStrategies" :key="i">
                        <span class="strategy-icon">{{ strategy.icon }}</span>
                        <div class="strategy-info">
                            <span class="strategy-name">{{ strategy.name }}</span>
                            <span class="strategy-desc">{{ strategy.desc }}</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Security Layers Sticky Scroll -->
        <section class="sticky-layers" ref="layersRef">
            <div class="sticky-spacer"></div>
            <div class="sticky-fixed-container" :style="{ opacity: layersVisible ? 1 : 0 }">
                <div class="layers-content">
                    <h2 class="section-title text-gradient">🏗️ 多層縱深防禦架構</h2>
                    <p class="layers-subtitle">每一層都是一道防線，逐層過濾惡意流量</p>
                    
                    <div class="defense-stack">
                        <div class="defense-layer" :class="{ revealed: layersProgress >= 0 }" style="--layer-color: #00d4ff;">
                            <div class="dl-num">L1</div>
                            <div class="dl-content">
                                <h3>邊緣防護層</h3>
                                <p>DDoS 清洗 · IP 黑名單 · 速率限制 · GeoIP 封鎖</p>
                            </div>
                            <div class="dl-stat">過濾 <strong>85%</strong> 惡意流量</div>
                        </div>
                        <div class="defense-layer" :class="{ revealed: layersProgress >= 25 }" style="--layer-color: #8b5cf6;">
                            <div class="dl-num">L2</div>
                            <div class="dl-content">
                                <h3>WAF 規則引擎</h3>
                                <p>SQL/XSS/RCE 偵測 · 3,200+ 規則 · CVE 自動更新</p>
                            </div>
                            <div class="dl-stat">攔截 <strong>12%</strong> 進階攻擊</div>
                        </div>
                        <div class="defense-layer" :class="{ revealed: layersProgress >= 50 }" style="--layer-color: #ff006e;">
                            <div class="dl-num">L3</div>
                            <div class="dl-content">
                                <h3>AI 智能分析</h3>
                                <p>LLM 威脅評分 · 行為分析 · 0-Day 偵測</p>
                            </div>
                            <div class="dl-stat">捕獲 <strong>2.5%</strong> 未知威脅</div>
                        </div>
                        <div class="defense-layer" :class="{ revealed: layersProgress >= 75 }" style="--layer-color: #00ff88;">
                            <div class="dl-num">L4</div>
                            <div class="dl-content">
                                <h3>IDS/IPS 後端監控</h3>
                                <p>伺服器 Agent 監控 · 文件完整性 · 入侵偵測</p>
                            </div>
                            <div class="dl-stat">最終 <strong>0.5%</strong> 深度防禦</div>
                        </div>
                    </div>
                    
                    <div class="layers-result" :class="{ show: layersProgress >= 90 }">
                        <span class="result-icon">✅</span>
                        <span class="result-text">合法流量安全到達 Origin Server</span>
                    </div>
                </div>

                <div class="slide-progress">
                    <div class="progress-bar" :style="{ width: layersProgressBar + '%' }"></div>
                </div>
            </div>
        </section>

        <!-- CDN Cache Acceleration Section -->
        <section class="cdn-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >🚀 CDN 全球加速網路</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                遍布全球 10+ 邊緣節點，整合 Nginx Proxy Cache 智能快取，讓您的用戶無論身處何地都能毫秒級存取
            </motion.p>

            <!-- CDN Stats Banner -->
            <div class="cdn-stats-banner scroll-animate">
                <div class="cdn-stat">
                    <span class="cdn-stat-value text-gradient">10+</span>
                    <span class="cdn-stat-label">全球節點</span>
                </div>
                <div class="cdn-stat">
                    <span class="cdn-stat-value text-gradient">99.99%</span>
                    <span class="cdn-stat-label">服務可用性</span>
                </div>
                <div class="cdn-stat">
                    <span class="cdn-stat-value text-gradient">&lt;50ms</span>
                    <span class="cdn-stat-label">全球平均延遲</span>
                </div>
                <div class="cdn-stat">
                    <span class="cdn-stat-value text-gradient">100Tbps</span>
                    <span class="cdn-stat-label">網路總容量</span>
                </div>
            </div>
            
            <div class="cdn-flow scroll-animate">
                <div class="cdn-node">
                    <div class="cdn-icon">👥</div>
                    <span>用戶請求</span>
                </div>
                <div class="cdn-arrow">→</div>
                <div class="cdn-node highlight">
                    <div class="cdn-icon">⚡</div>
                    <span>CDN 快取層</span>
                </div>
                <div class="cdn-arrow">→</div>
                <div class="cdn-node">
                    <div class="cdn-icon">🖥️</div>
                    <span>源站伺服器</span>
                </div>
            </div>

            <!-- CDN Global Nodes Map (Fixed Scroll - Progressive Reveal) -->
            <div class="cdn-map-spacer" ref="cdnMapRef"></div>
            <div class="cdn-map-fixed-container"
                 :style="{ opacity: cdnMapVisible ? 1 : 0, pointerEvents: cdnMapVisible ? 'auto' : 'none' }">
                <div class="cdn-global-map">
                    <h3 class="text-gradient">🌍 全球 CDN 節點</h3>
                    <p class="map-subtitle">往下捲動，逐一探索全球邊緣節點</p>
                    
                    <div class="world-map-container">
                        <div class="world-map-img-wrapper">
                            <img src="/images/world_map.png" alt="World Map" class="world-map-img" />
                            <!-- CDN Node markers - revealed progressively -->
                            <div v-for="(node, i) in cdnNodes" :key="'map-node-'+i"
                                 class="map-node-marker"
                                 :class="{ primary: node.primary, revealed: cdnRevealCount > i }"
                                 :style="{ left: node.left + '%', top: node.top + '%' }">
                                <div class="marker-pulse"></div>
                                <div class="marker-dot"></div>
                                <div class="marker-label">
                                    <span class="marker-name">{{ node.name }}</span>
                                    <span class="marker-latency">{{ node.latency }}</span>
                                </div>
                            </div>
                            <!-- Connection lines - revealed progressively -->
                            <svg class="map-lines-overlay" viewBox="0 0 100 100" preserveAspectRatio="none">
                                <line v-for="(line, i) in cdnConnections" :key="'line-'+i"
                                      :x1="line.x1" :y1="line.y1" :x2="line.x2" :y2="line.y2"
                                      stroke="#00d4ff" stroke-width="0.15" stroke-dasharray="0.8 0.8"
                                      :opacity="cdnRevealCount > i ? 0.5 : 0"
                                      :style="{ transition: 'opacity 0.6s ease ' + (i * 0.1) + 's' }">
                                    <animate attributeName="stroke-dashoffset" from="1.6" to="0" :dur="(1 + i * 0.2) + 's'" repeatCount="indefinite"/>
                                </line>
                            </svg>
                        </div>
                    </div>
                    
                    <!-- Reveal counter -->
                    <div class="cdn-reveal-counter">
                        <span class="crc-num">{{ cdnRevealCount }}</span>
                        <span class="crc-sep">/</span>
                        <span class="crc-total">{{ cdnNodes.length }}</span>
                        <span class="crc-label">節點已連線</span>
                    </div>
                </div>
            </div>
            
            <div class="cdn-features">
                <motion.div class="cdn-feature-card" v-for="(item, i) in cdnFeatures" :key="i"
                    :initial="{ opacity: 0, y: 30, scale: 0.95 }"
                    :whileInView="{ opacity: 1, y: 0, scale: 1 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 100, damping: 15, delay: i * 0.1 }"
                    :whileHover="{ y: -12, scale: 1.08 }"
                >
                    <span class="cdn-feature-icon">{{ item.icon }}</span>
                    <h4>{{ item.title }}</h4>
                    <p>{{ item.desc }}</p>
                </motion.div>
            </div>
        </section>

        <!-- DDoS Scrubbing Section -->
        <section class="ddos-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >🌊 DDoS 流量清洗中心</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                企業級 DDoS 防護，多層智能清洗引擎，即時偵測並過濾惡意流量，保障業務持續運行
            </motion.p>

            <!-- DDoS Stats Dashboard -->
            <div class="ddos-stats-dashboard">
                <motion.div class="ddos-stat-card"
                    :initial="{ opacity: 0, y: 50, scale: 0 }"
                    :whileInView="{ opacity: 1, y: 0, scale: 1 }"
                    :viewport="{ once: true, amount: 0.2 }"
                    :transition="{ type: 'spring', stiffness: 150, damping: 8 }"
                >
                    <div class="ddos-stat-value text-gradient">100<span class="unit">Tbps</span></div>
                    <div class="ddos-stat-label">清洗總容量</div>
                </motion.div>
                <motion.div class="ddos-stat-card"
                    :initial="{ opacity: 0, y: 30, scale: 0.9 }"
                    :whileInView="{ opacity: 1, y: 0, scale: 1 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 120, damping: 12, delay: 0.1 }"
                >
                    <div class="ddos-stat-value text-gradient">99.99<span class="unit">%</span></div>
                    <div class="ddos-stat-label">惡意流量過濾率</div>
                </motion.div>
                <motion.div class="ddos-stat-card"
                    :initial="{ opacity: 0, y: 30, scale: 0.9 }"
                    :whileInView="{ opacity: 1, y: 0, scale: 1 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 120, damping: 12, delay: 0.2 }"
                >
                    <div class="ddos-stat-value text-gradient">&lt;3<span class="unit">s</span></div>
                    <div class="ddos-stat-label">攻擊回應時間</div>
                </motion.div>
                <motion.div class="ddos-stat-card"
                    :initial="{ opacity: 0, y: 30, scale: 0.9 }"
                    :whileInView="{ opacity: 1, y: 0, scale: 1 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 120, damping: 12, delay: 0.3 }"
                >
                    <div class="ddos-stat-value text-gradient">24/7</div>
                    <div class="ddos-stat-label">全天候自動防護</div>
                </motion.div>
            </div>

            <!-- Live Traffic Visualization -->
            <div class="ddos-traffic-visual scroll-animate scale-up">
                <div class="traffic-header">
                    <span class="traffic-label">⚡ 即時流量清洗模擬</span>
                    <span class="traffic-status">
                        <span class="status-dot active"></span> 防護啟用中
                    </span>
                </div>
                <div class="traffic-bars">
                    <div class="traffic-row" v-for="(type, i) in ddosTrafficTypes" :key="'traffic-'+i">
                        <span class="traffic-type">{{ type.name }}</span>
                        <div class="traffic-bar-bg">
                            <div class="traffic-bar-fill malicious" :style="{ width: type.malicious + '%', animationDelay: (i * 0.3) + 's' }"></div>
                            <div class="traffic-bar-fill clean" :style="{ width: type.clean + '%', animationDelay: (i * 0.3 + 0.15) + 's' }"></div>
                        </div>
                        <span class="traffic-percent">{{ type.blocked }}% 攔截</span>
                    </div>
                </div>
                <div class="traffic-legend">
                    <span><span class="legend-dot malicious"></span>惡意流量</span>
                    <span><span class="legend-dot clean"></span>正常流量</span>
                </div>
            </div>
            
            <!-- Defense Layers -->
            <h3 class="ddos-layers-title text-gradient scroll-animate">🛡️ 五層縱深防禦架構</h3>
            <div class="ddos-layers">
                <motion.div class="ddos-layer" v-for="(layer, i) in ddosLayers" :key="i"
                    :initial="{ opacity: 0, x: -30 }"
                    :whileInView="{ opacity: 1, x: 0 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 80, damping: 15, delay: i * 0.12 }"
                >
                    <div class="layer-shield">
                        <span class="layer-num">L{{ i + 1 }}</span>
                    </div>
                    <div class="layer-info">
                        <h4>{{ layer.name }}</h4>
                        <p>{{ layer.desc }}</p>
                    </div>
                </motion.div>
            </div>
        </section>

        <!-- GeoIP Smart Routing Section -->
        <section class="geoip-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >🗺️ GeoIP 智能路由</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                基於地理位置的智能流量調度，就近接入最優節點
            </motion.p>

            <div class="geoip-features">
                <motion.div class="geoip-card" v-for="(item, i) in geoipFeatures" :key="i"
                    :initial="{ opacity: 0, y: 30, scale: 0.95 }"
                    :whileInView="{ opacity: 1, y: 0, scale: 1 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 100, damping: 15, delay: i * 0.1 }"
                    :whileHover="{ y: -12, scale: 1.08 }"
                >
                    <div class="geoip-icon">{{ item.icon }}</div>
                    <h4>{{ item.title }}</h4>
                    <p>{{ item.desc }}</p>
                </motion.div>
            </div>
        </section>

        <!-- Multi-Node Management Section -->
        <section class="multinode-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >🏗️ 多節點分散式部署</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                全球多節點部署，集中管理與自動故障切換
            </motion.p>

            <div class="node-grid">
                <motion.div class="node-card" v-for="(node, i) in nodeExamples" :key="i" :class="node.status"
                    :initial="{ opacity: 0, y: 30, scale: 0.9 }"
                    :whileInView="{ opacity: 1, y: 0, scale: 1 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 100, damping: 14, delay: i * 0.12 }"
                    :whileHover="{ y: -12, scale: 1.1 }"
                >
                    <div class="node-status-dot"></div>
                    <div class="node-icon">🛡️</div>
                    <h4>{{ node.name }}</h4>
                    <span class="node-region">{{ node.region }}</span>
                    <span class="node-latency">{{ node.latency }}</span>
                </motion.div>
            </div>
        </section>

        <!-- ClamAV & Snort Integration Section -->
        <section class="security-engines-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >🔬 進階安全引擎</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                整合 ClamAV 防毒掃描與 Snort 3 深度封包檢測
            </motion.p>

            <div class="engines-grid">
                <div class="engine-highlight-card">
                    <div class="engine-badge">🦠</div>
                    <h3>ClamAV 防毒引擎</h3>
                    <p>即時掃描上傳檔案，自動更新病毒庫</p>
                    <ul>
                        <li>✓ 檔案上傳即時掃描</li>
                        <li>✓ 病毒庫自動更新</li>
                        <li>✓ 隔離區管理</li>
                        <li>✓ 掃描報告產生</li>
                    </ul>
                </div>
                <div class="engine-highlight-card">
                    <div class="engine-badge">🐉</div>
                    <h3>Snort 3 規則引擎</h3>
                    <p>企業級 IDS 深度封包檢測引擎</p>
                    <ul>
                        <li>✓ Snort 3 原生支援</li>
                        <li>✓ 深度封包檢測 (DPI)</li>
                        <li>✓ 自訂 Snort 規則</li>
                        <li>✓ 告警即時整合</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- RBAC Section -->
        <section class="rbac-section">
            <div class="rbac-container">
                <motion.div class="rbac-text"
                    :initial="isMobile ? { opacity: 0, y: 20 } : { opacity: 0, x: -40 }"
                    :whileInView="isMobile ? { opacity: 1, y: 0 } : { opacity: 1, x: 0 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 70, damping: 18 }"
                >
                    <h2 class="section-title text-gradient">👥 角色權限管理</h2>
                    <p class="section-lead">精細化的 RBAC 存取控制，讓團隊協作更安全高效</p>
                    <ul class="rbac-features">
                        <li>🔐 角色型存取控制 (RBAC)</li>
                        <li>📋 站點級別權限分配</li>
                        <li>👁️ 操作日誌完整追蹤</li>
                        <li>🛡️ 最小權限原則</li>
                    </ul>
                </motion.div>
                <motion.div class="rbac-visual"
                    :initial="isMobile ? { opacity: 0, y: 20 } : { opacity: 0, x: 40, scale: 0.9 }"
                    :whileInView="isMobile ? { opacity: 1, y: 0 } : { opacity: 1, x: 0, scale: 1 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 70, damping: 18, delay: 0.2 }"
                >
                    <div class="rbac-diagram">
                        <div class="rbac-role admin">
                            <span class="role-icon">👑</span>
                            <span class="role-name">管理員</span>
                        </div>
                        <div class="rbac-role operator">
                            <span class="role-icon">⚙️</span>
                            <span class="role-name">操作員</span>
                        </div>
                        <div class="rbac-role viewer">
                            <span class="role-icon">👁️</span>
                            <span class="role-name">檢視者</span>
                        </div>
                    </div>
                </motion.div>
            </div>
        </section>

        <!-- Inline Sticky: Split Layout (left sticky, right scrolls) -->
        <section class="inline-sticky-split" ref="issRef">
            <div class="iss-container">
                <div class="iss-left">
                    <div class="iss-left-inner">
                        <span class="iss-badge">ALL-IN-ONE</span>
                        <h2 class="section-title text-gradient">一站式<br>安全解決方案</h2>
                        <p class="iss-desc">從邊緣防護到深度偵測，<br>所有安全需求一個平台搞定。</p>
                        <div class="iss-counter">
                            <span class="iss-count">8</span>
                            <span class="iss-count-label">核心防護模組</span>
                        </div>
                    </div>
                </div>
                <div class="iss-right">
                    <motion.div class="iss-card" v-for="(cap, i) in inlineStickyCapabilities" :key="i"
                        :initial="isMobile ? { opacity: 0, y: 20 } : { opacity: 0, x: 40 }"
                        :whileInView="isMobile ? { opacity: 1, y: 0 } : { opacity: 1, x: 0 }"
                        :viewport="{ once: true, amount: 0.3 }"
                        :transition="{ type: 'spring', stiffness: 80, damping: 18, delay: i * 0.1 }"
                        :whileHover="isMobile ? undefined : { scale: 1.02, x: -5 }"
                    >
                        <div class="iss-card-icon">{{ cap.icon }}</div>
                        <div class="iss-card-body">
                            <h3>{{ cap.title }}</h3>
                            <p>{{ cap.desc }}</p>
                            <div class="iss-card-stats">
                                <div class="iss-stat" v-for="(stat, j) in cap.stats" :key="j">
                                    <span class="iss-stat-val">{{ stat.val }}</span>
                                    <span class="iss-stat-lbl">{{ stat.label }}</span>
                                </div>
                            </div>
                        </div>
                    </motion.div>
                </div>
            </div>
        </section>

        <!-- ISS Fixed Header (mobile) -->
        <div class="iss-fixed-header" :style="{ opacity: issHeaderVisible ? 1 : 0, pointerEvents: issHeaderVisible ? 'auto' : 'none' }">
            <span class="iss-badge">ALL-IN-ONE</span>
            <h2 class="section-title text-gradient">一站式安全解決方案</h2>
            <div class="iss-counter">
                <span class="iss-count">8</span>
                <span class="iss-count-label">核心防護模組</span>
            </div>
        </div>

        <!-- Inline Sticky: Horizontal Timeline Progress -->
        <section class="inline-sticky-timeline" ref="timelineRef">
            <div class="ist-header scroll-animate">
                <h2 class="section-title text-gradient">🚀 從部署到防護，只需 5 分鐘</h2>
                <p class="section-subtitle">簡單四步驟，立即啟用企業級安全防護</p>
            </div>
            <div class="ist-container">
                <div class="ist-scroll-content">
                    <div class="ist-detail-card">
                        <div class="ist-detail-num">01</div>
                        <h3>聯絡我們</h3>
                        <p>透過官網表單或 Email 聯繫我們的專業團隊，我們將根據您的需求提供客製化的安全防護方案。</p>
                        <div class="ist-detail-time">⏱️ 隨時請聯繫</div>
                    </div>
                    <div class="ist-detail-card">
                        <div class="ist-detail-num">02</div>
                        <h3>建立帳號與設定</h3>
                        <p>我們將為您建立 Security One SOC 帳號，並協助配置您的防護規則。支援 Passkey 生物辨識登入。</p>
                        <div class="ist-detail-time">⏱️ 約 2 分鐘</div>
                    </div>
                    <div class="ist-detail-card">
                        <div class="ist-detail-num">03</div>
                        <h3>新增站點</h3>
                        <p>輸入網域名稱和源站 IP，系統自動配置反向代理和 SSL 證書。支援批量匯入。</p>
                        <div class="ist-detail-time">⏱️ 約 1 分鐘</div>
                    </div>
                    <div class="ist-detail-card">
                        <div class="ist-detail-num">04</div>
                        <h3>修改 NS 指向到 WAF ✅</h3>
                        <p>將您的網域 NS 記錄指向 WAF 節點，流量自動經過 WAF 過濾。即時查看攻擊地圖和日誌，享受全方位安全防護。</p>
                        <div class="ist-detail-time">🎉 防護啟用！</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Timeline Fixed Progress Bar -->
        <div class="ist-fixed-bar" :style="{ opacity: timelineBarVisible ? 1 : 0, pointerEvents: timelineBarVisible ? 'auto' : 'none' }">
            <div class="ist-progress-track">
                <div class="ist-progress-fill" :style="{ width: timelineProgress + '%' }"></div>
            </div>
            <div class="ist-steps">
                <div class="ist-step" :class="{ active: timelineProgress >= 0, done: timelineProgress >= 25 }">
                    <div class="ist-step-dot">1</div>
                    <span class="ist-step-label">聯絡我們</span>
                </div>
                <div class="ist-step" :class="{ active: timelineProgress >= 25, done: timelineProgress >= 50 }">
                    <div class="ist-step-dot">2</div>
                    <span class="ist-step-label">建立帳號</span>
                </div>
                <div class="ist-step" :class="{ active: timelineProgress >= 50, done: timelineProgress >= 75 }">
                    <div class="ist-step-dot">3</div>
                    <span class="ist-step-label">新增站點</span>
                </div>
                <div class="ist-step" :class="{ active: timelineProgress >= 75, done: timelineProgress >= 95 }">
                    <div class="ist-step-dot">4</div>
                    <span class="ist-step-label">NS 指向 WAF</span>
                </div>
            </div>
        </div>

        <!-- Why Choose Us Section -->
        <section class="comparison-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >為什麼選擇 Security One SOC？</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                相較於傳統 WAF，我們提供更智能、更全面的防護
            </motion.p>

            <motion.div class="comparison-table"
                :initial="{ opacity: 0, y: 60, scale: 0.9 }"
                :whileInView="{ opacity: 1, y: 0, scale: 1 }"
                :viewport="{ once: true, amount: 0.1 }"
                :transition="{ type: 'spring', stiffness: 60, damping: 12, delay: 0.2 }"
            >
                <div class="comparison-header">
                    <div class="comparison-feature">功能</div>
                    <div class="comparison-traditional">傳統 WAF</div>
                    <div class="comparison-vito">Security One SOC</div>
                </div>
                <div class="comparison-row" v-for="(item, index) in comparison" :key="index">
                    <div class="comparison-feature">{{ item.feature }}</div>
                    <div class="comparison-traditional">
                        <span :class="item.traditional ? 'check' : 'cross'">{{ item.traditional ? '✓' : '✗' }}</span>
                    </div>
                    <div class="comparison-vito">
                        <span class="check highlight">✓</span>
                    </div>
                </div>
            </motion.div>
        </section>

        <!-- FAQ Section -->
        <section class="faq-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >常見問題</motion.h2>

            <div class="faq-list">
                <motion.div
                    class="faq-item"
                    v-for="(faq, index) in faqs"
                    :key="index"
                    :initial="{ opacity: 0, y: 20 }"
                    :whileInView="{ opacity: 1, y: 0 }"
                    :viewport="{ once: true, amount: 0.3 }"
                    :transition="{ type: 'spring', stiffness: 100, damping: 18, delay: index * 0.08 }"
                    @click="toggleFaq(index)"
                >
                    <div class="faq-question">
                        <span>{{ faq.q }}</span>
                        <motion.span
                            class="faq-toggle"
                            :animate="{ rotate: activeFaq === index ? 45 : 0 }"
                            :transition="{ type: 'spring', stiffness: 300, damping: 20 }"
                        >+</motion.span>
                    </div>
                    <AnimatePresence>
                        <motion.div
                            v-if="activeFaq === index"
                            class="faq-answer"
                            :initial="{ opacity: 0, height: 0 }"
                            :animate="{ opacity: 1, height: 'auto' }"
                            :exit="{ opacity: 0, height: 0 }"
                            :transition="{ duration: 0.3, ease: 'easeInOut' }"
                            style="overflow: hidden"
                        >
                            {{ faq.a }}
                        </motion.div>
                    </AnimatePresence>
                </motion.div>
            </div>
        </section>
        
        <!-- WAF Security Test Results -->
        <section class="waf-test-section">
            <motion.h2
                class="section-title text-gradient"
                :initial="{ opacity: 0, y: 40 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 12 }"
            >📄 WAF 安全測試報告</motion.h2>
            <motion.p
                class="section-subtitle"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.15 }"
            >
                經過專業第三方工具 WAF-CHECKER.COM 完整測試，驗證防護效果
            </motion.p>
            <div class="waf-test-grid">
                <div class="waf-test-card">
                    <div class="waf-test-badge malicious">🛡️ 惡意流量測試</div>
                    <img src="/images/waf_malicious_test.png" alt="WAF Malicious Traffic Test" class="waf-test-img" />
                    <div class="waf-test-stats">
                        <div class="waf-test-stat">
                            <span class="stat-value text-gradient">99.94%</span>
                            <span class="stat-label">WAF 有效率</span>
                        </div>
                        <div class="waf-test-stat">
                            <span class="stat-value text-gradient">6,381</span>
                            <span class="stat-label">總測試數</span>
                        </div>
                        <div class="waf-test-stat">
                            <span class="stat-value text-gradient">4</span>
                            <span class="stat-label">Bypass</span>
                        </div>
                    </div>
                    <a href="/reports/waf_malicious_report.json" download class="report-download-btn">📥 下載完整報告 (JSON)</a>
                </div>
                <div class="waf-test-card">
                    <div class="waf-test-badge fp">✅ 誤報率測試 (FP)</div>
                    <img src="/images/waf_fp_test.png" alt="WAF False Positive Test" class="waf-test-img" />
                    <div class="waf-test-stats">
                        <div class="waf-test-stat">
                            <span class="stat-value text-gradient">99.94%</span>
                            <span class="stat-label">WAF 準確率</span>
                        </div>
                        <div class="waf-test-stat">
                            <span class="stat-value text-gradient">3,633</span>
                            <span class="stat-label">總測試數</span>
                        </div>
                        <div class="waf-test-stat">
                            <span class="stat-value text-gradient">2</span>
                            <span class="stat-label">誤報數</span>
                        </div>
                    </div>
                    <a href="/reports/waf_fp_report.json" download class="report-download-btn">📥 下載完整報告 (JSON)</a>
                </div>
            </div>

            <!-- WAF-Checker Detection Profile -->
            <motion.div
                class="waf-checker-profile"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 100, damping: 20, delay: 0.2 }"
            >
                <h3 class="waf-checker-title">🔍 WAF-Checker 檢測設檔</h3>
                <div class="waf-checker-features">
                    <div class="waf-feature-item">
                        <span class="feature-check">✅</span>
                        <span class="feature-text">Follow 3xx redirects</span>
                    </div>
                    <div class="waf-feature-item">
                        <span class="feature-check">✅</span>
                        <span class="feature-text">Advanced WAF Bypass Payloads</span>
                    </div>
                    <div class="waf-feature-item">
                        <span class="feature-check">✅</span>
                        <span class="feature-text">Auto-detect WAF before testing</span>
                    </div>
                    <div class="waf-feature-item">
                        <span class="feature-check">✅</span>
                        <span class="feature-text">Generate encoding variations</span>
                    </div>
                    <div class="waf-feature-item">
                        <span class="feature-check">✅</span>
                        <span class="feature-text">Enhanced Payloads (modern bypass)</span>
                    </div>
                    <div class="waf-feature-item">
                        <span class="feature-check">✅</span>
                        <span class="feature-text">HTTP Protocol Manipulation</span>
                    </div>
                    <div class="waf-feature-item">
                        <span class="feature-check">✅</span>
                        <span class="feature-text">False Positive Test</span>
                    </div>
                    <div class="waf-feature-item">
                        <span class="feature-check">✅</span>
                        <span class="feature-text">Case sensitive test</span>
                    </div>
                </div>
            </motion.div>

            <!-- Bypass Explanation -->
            <motion.div
                class="waf-bypass-explanation"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.3 }"
            >
                <h3 class="bypass-title">⚠️ Bypass 說明 — 架構限制，非安全漏洞</h3>
                <p class="bypass-desc">以下 4 項 Bypass 均為標準 HTTP 協定行為或測試工具本身的限制，屬於架構設計上無法避免的情況：</p>
                <div class="bypass-items">
                    <div class="bypass-item">
                        <span class="bypass-num">1</span>
                        <div class="bypass-content">
                            <span class="bypass-header-name">Cache-Control: no-cache</span>
                            <span class="bypass-reason">標準 HTTP header，所有瀏覽器都會發送此請求標頭，無法封鎖</span>
                        </div>
                    </div>
                    <div class="bypass-item">
                        <span class="bypass-num">2</span>
                        <div class="bypass-content">
                            <span class="bypass-header-name">X-Forwarded-Proto: https</span>
                            <span class="bypass-reason">標準 CDN / Reverse Proxy header，用於標識原始請求協定</span>
                        </div>
                    </div>
                    <div class="bypass-item">
                        <span class="bypass-num">3</span>
                        <div class="bypass-content">
                            <span class="bypass-header-name">X-Forwarded-Port: 443</span>
                            <span class="bypass-reason">標準 CDN / Reverse Proxy header，用於標識原始請求連接埠</span>
                        </div>
                    </div>
                    <div class="bypass-item">
                        <span class="bypass-num">4</span>
                        <div class="bypass-content">
                            <span class="bypass-header-name">Empty User-Agent</span>
                            <span class="bypass-reason">FP 掃描器本身不送 User-Agent，封鎖空 UA 會導致 False Positive 測試本身無法完成</span>
                        </div>
                    </div>
                </div>
            </motion.div>

            <!-- Category Analysis Tables -->
            <motion.div
                class="waf-category-analysis"
                :initial="{ opacity: 0, y: 30 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true, amount: 0.2 }"
                :transition="{ type: 'spring', stiffness: 80, damping: 14, delay: 0.2 }"
            >
                <h3 class="category-analysis-title">📊 分類分析報告</h3>
                <div class="category-tables-grid">
                    <!-- Malicious Test Categories -->
                    <div class="category-table-card">
                        <h4 class="table-card-title malicious">🛡️ 惡意流量測試 — 分類結果</h4>
                        <div class="category-table-wrap">
                            <table class="category-table">
                                <thead>
                                    <tr>
                                        <th>攻擊分類</th>
                                        <th>嚴重度</th>
                                        <th>分數</th>
                                        <th>Bypass 率</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr><td>Web Cache Poisoning</td><td><span class="severity low">Low</span></td><td>12/100</td><td class="bypass-rate warn">7.5%</td></tr>
                                    <tr><td>User-Agent</td><td><span class="severity low">Low</span></td><td>3/100</td><td class="bypass-rate warn">1.79%</td></tr>
                                    <tr><td>SQL Injection</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>XSS</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>Path Traversal</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>Command Injection</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>SSRF</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>NoSQL Injection</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>Local File Inclusion</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>LDAP Injection</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>HTTP Request Smuggling</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>Open Redirect</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>Sensitive Files</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>CRLF Injection</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>UTF8/Unicode Bypass</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>XXE</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>SSTI</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>HTTP Parameter Pollution</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>IP Bypass</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>SQL Injection - Advanced</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>XSS - Modern Bypasses</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>HTTP Header Injection</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>Path Traversal - Encoded</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>SSRF - Protocol Smuggling</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>XXE - Advanced</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>SSTI - Framework Specific</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>NoSQL Injection - Advanced</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>Command Injection - Encoded</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- FP Test Categories -->
                    <div class="category-table-card">
                        <h4 class="table-card-title fp">✅ 誤報率測試 — 分類結果</h4>
                        <div class="category-table-wrap">
                            <table class="category-table">
                                <thead>
                                    <tr>
                                        <th>測試分類</th>
                                        <th>嚴重度</th>
                                        <th>分數</th>
                                        <th>FP 率</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr><td>Sensitive Files</td><td><span class="severity low">Low</span></td><td>18/100</td><td class="bypass-rate warn">11.11%</td></tr>
                                    <tr><td>Web Cache Poisoning</td><td><span class="severity low">Low</span></td><td>4/100</td><td class="bypass-rate warn">2.5%</td></tr>
                                    <tr><td>SQL Injection</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>XSS</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>Path Traversal</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>Command Injection</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>SSRF</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>NoSQL Injection</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>LDAP Injection</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>HTTP Request Smuggling</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>Open Redirect</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>CRLF Injection</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>UTF8/Unicode Bypass</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>XXE</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>SSTI</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>HTTP Parameter Pollution</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>IP Bypass</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>User-Agent</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>SQL Injection - Advanced</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>XSS - Modern Bypasses</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>HTTP Header Injection</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>Path Traversal - Encoded</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>SSRF - Protocol Smuggling</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>XXE - Advanced</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>SSTI - Framework Specific</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>NoSQL Injection - Advanced</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                    <tr><td>Command Injection - Encoded</td><td><span class="severity low">Low</span></td><td>0/100</td><td class="bypass-rate safe">0%</td></tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <p class="report-timestamp">報告生成時間：2026/02/19 00:00 (UTC+8) — 由 WAF-CHECKER.COM 提供</p>
            </motion.div>
        </section>

        <!-- CTA Section -->
        <section class="cta-section">
            <motion.div class="cta-content"
                :initial="{ opacity: 0, y: 60, scale: 0.8 }"
                :whileInView="{ opacity: 1, y: 0, scale: 1 }"
                :viewport="{ once: true, amount: 0.3 }"
                :transition="{ type: 'spring', stiffness: 60, damping: 12 }"
            >
                <motion.h2 class="text-gradient"
                    :initial="{ opacity: 0, scale: 0.5 }"
                    :whileInView="{ opacity: 1, scale: 1 }"
                    :viewport="{ once: true }"
                    :transition="{ type: 'spring', stiffness: 80, damping: 10, delay: 0.2 }"
                >準備好保護您的網站了嗎？</motion.h2>
                <motion.p
                    :initial="{ opacity: 0, y: 20 }"
                    :whileInView="{ opacity: 1, y: 0 }"
                    :viewport="{ once: true }"
                    :transition="{ type: 'spring', stiffness: 100, damping: 15, delay: 0.4 }"
                >立即聯繫我們，獲取專屬解決方案</motion.p>
                <motion.a
                    href="mailto:service@cybersecureone.com?subject=Security One SOC 諮詢"
                    class="btn btn-primary animate-glow"
                    :initial="{ opacity: 0, scale: 0, y: 30 }"
                    :whileInView="{ opacity: 1, scale: 1, y: 0 }"
                    :viewport="{ once: true }"
                    :transition="{ type: 'spring', stiffness: 150, damping: 8, delay: 0.6 }"
                    :whileHover="{ scale: 1.2, y: -10 }"
                    :whilePress="{ scale: 0.85 }"
                >
                    📧 聯繫我們
                </motion.a>
            </motion.div>
        </section>
        
        <!-- Footer -->
        <footer class="footer">
            <motion.div class="footer-logo text-gradient"
                :initial="{ opacity: 0, y: 20 }"
                :whileInView="{ opacity: 1, y: 0 }"
                :viewport="{ once: true }"
                :transition="{ type: 'spring', stiffness: 100, damping: 20 }"
            >Security One SOC</motion.div>
            <p class="footer-text">商業版 統一安全平台</p>
            <div class="footer-links">
                <a href="mailto:service@cybersecureone.com?subject=Security One SOC 諮詢">聯絡我們</a>
                <a href="mailto:service@cybersecureone.com?subject=Security One SOC 文檔請求">文檔</a>
            </div>
            <p class="footer-text" style="margin-top: 2rem;">
                © {{ new Date().getFullYear() }} Security One SOC. MIT License.
            </p>
        </footer>
        
        <!-- Feature Modal -->
        <FeatureModal 
            :isOpen="modalOpen" 
            :feature="selectedFeature" 
            @close="closeModal" 
        />
    </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue';
import { motion, AnimatePresence, useScroll, useTransform, useMotionValue, useSpring, useMotionTemplate } from 'motion-v';
import LoadingScreen from '../Components/LoadingScreen.vue';
import ParticleBackground from '../Components/ParticleBackground.vue';
import FeatureCard from '../Components/FeatureCard.vue';
import AnimatedCounter from '../Components/AnimatedCounter.vue';
import FeatureModal from '../Components/FeatureModal.vue';
import Waf3DVisualizer from '../Components/Waf3DVisualizer.vue';

const isLoading = ref(true);
const modalOpen = ref(false);
const selectedFeature = ref({});
const heroRef = ref(null);
const showcaseRef = ref(null);
const scrollProgress = ref(0);

// Responsive animation detection - must be set BEFORE first render
const isMobile = ref(typeof window !== 'undefined' && window.innerWidth <= 768);
const checkMobile = () => { isMobile.value = window.innerWidth <= 768; };

// Motion-v scroll progress bar
const { scrollYProgress } = useScroll();
const scaleX = useSpring(scrollYProgress, { stiffness: 100, damping: 30, restDelta: 0.001 });

// Cursor follow gradient for hero
const cursorX = useMotionValue(0);
const cursorY = useMotionValue(0);
const cursorSpringX = useSpring(cursorX, { stiffness: 150, damping: 20 });
const cursorSpringY = useSpring(cursorY, { stiffness: 150, damping: 20 });
const heroGradient = useMotionTemplate`radial-gradient(600px circle at ${cursorSpringX}px ${cursorSpringY}px, rgba(0, 212, 255, 0.12), transparent 80%)`;

const handleHeroMouse = (e) => {
    cursorX.set(e.clientX);
    cursorY.set(e.clientY);
};
const showcaseProgress = ref(0);
const currentSlide = ref(0);
const showcaseVisible = ref(false);
const slideProgress = ref(0);

// Pipeline sticky scroll state
const pipelineRef = ref(null);
const pipelineSlide = ref(0);
const pipelineVisible = ref(false);
const pipelineProgress = ref(0);

// Layers sticky scroll state
const layersRef = ref(null);
const layersVisible = ref(false);
const layersProgress = ref(-1);
const layersProgressBar = ref(0);

// Timeline sticky scroll state
const timelineRef = ref(null);
const timelineProgress = ref(0);
const timelineBarVisible = ref(false);

// Inline sticky split state
const issRef = ref(null);
const issHeaderVisible = ref(false);

// CDN map progressive reveal state
const cdnMapRef = ref(null);
const cdnRevealCount = ref(0);
const cdnMapVisible = ref(false);

// Inline sticky capabilities data
const inlineStickyCapabilities = [
    {
        icon: '🛡️', title: 'WAF 防火牆',
        desc: '即時攔截 SQL 注入、XSS、RCE 等 18 種攻擊，3,200+ 規則全天候守護',
        stats: [{ val: '18', label: '攻擊類型' }, { val: '3,200+', label: '防護規則' }, { val: '<1ms', label: '攔截延遲' }]
    },
    {
        icon: '🤖', title: 'AI 智能分析',
        desc: 'LLM 驅動的威脅評分引擎，即時偵測未知攻擊和 0-Day 漏洞',
        stats: [{ val: '99%', label: '偵測率' }, { val: '0.01%', label: '誤報率' }, { val: '24/7', label: '即時監控' }]
    },
    {
        icon: '🚀', title: 'CDN 加速網路',
        desc: '全球邊緣節點快取，讓您的網站速度飛快，同時減輕源站負載',
        stats: [{ val: '50+', label: '全球節點' }, { val: '95%', label: '快取命中' }, { val: '50ms', label: '平均延遲' }]
    },
    {
        icon: '⚖️', title: '智能負載均衡',
        desc: '多後端流量分配、健康檢查、自動故障轉移，確保服務高可用',
        stats: [{ val: '99.99%', label: '可用性' }, { val: '6', label: '負載策略' }, { val: '即時', label: '故障切換' }]
    },
];

// Parallax scroll effect for Hero (slowed down)
const heroStyle = computed(() => {
    const opacity = Math.max(0, 1 - scrollProgress.value * 0.8);
    const scale = Math.max(0.85, 1 - scrollProgress.value * 0.15);
    const blur = scrollProgress.value * 5;
    const translateY = scrollProgress.value * -30;
    
    return {
        opacity,
        transform: `scale(${scale}) translateY(${translateY}px)`,
        filter: `blur(${blur}px)`
    };
});

const handleScroll = () => {
    const scrollY = window.scrollY;
    const windowHeight = window.innerHeight;
    
    // Hero: track first 2 viewports (slower)
    scrollProgress.value = Math.min(1, scrollY / (windowHeight * 2));
    
    // Product Showcase: use actual element position for mobile compatibility
    if (showcaseRef.value) {
        const rect = showcaseRef.value.getBoundingClientRect();
        const sectionTop = scrollY + rect.top;
        const sectionHeight = showcaseRef.value.offsetHeight;
        
        // Start when section enters viewport, end when we've scrolled through the spacer
        const showcaseStart = sectionTop;
        const showcaseEnd = sectionTop + sectionHeight - windowHeight;
        const showcaseRange = showcaseEnd - showcaseStart;
        
        if (scrollY >= showcaseStart && scrollY <= showcaseEnd) {
            showcaseVisible.value = true;
            const localProgress = (scrollY - showcaseStart) / showcaseRange;
            slideProgress.value = localProgress * 100;
            
            // Switch slides at 50% progress
            currentSlide.value = localProgress < 0.5 ? 0 : 1;
        } else {
            showcaseVisible.value = false;
        }
    }
    
    // Pipeline sticky scroll
    if (pipelineRef.value) {
        const rect = pipelineRef.value.getBoundingClientRect();
        const sectionTop = scrollY + rect.top;
        const sectionHeight = pipelineRef.value.offsetHeight;
        const pipeStart = sectionTop;
        const pipeEnd = sectionTop + sectionHeight - windowHeight;
        const pipeRange = pipeEnd - pipeStart;
        
        if (scrollY >= pipeStart && scrollY <= pipeEnd) {
            pipelineVisible.value = true;
            const localProgress = (scrollY - pipeStart) / pipeRange;
            pipelineProgress.value = localProgress * 100;
            
            // 3 slides: 0-33%, 33-66%, 66-100%
            if (localProgress < 0.33) pipelineSlide.value = 0;
            else if (localProgress < 0.66) pipelineSlide.value = 1;
            else pipelineSlide.value = 2;
        } else {
            pipelineVisible.value = false;
        }
    }
    
    // Layers sticky scroll
    if (layersRef.value) {
        const rect = layersRef.value.getBoundingClientRect();
        const sectionTop = scrollY + rect.top;
        const sectionHeight = layersRef.value.offsetHeight;
        const layerStart = sectionTop;
        const layerEnd = sectionTop + sectionHeight - windowHeight;
        const layerRange = layerEnd - layerStart;
        
        if (scrollY >= layerStart && scrollY <= layerEnd) {
            layersVisible.value = true;
            const localProgress = (scrollY - layerStart) / layerRange;
            layersProgressBar.value = localProgress * 100;
            layersProgress.value = localProgress * 100;
        } else {
            layersVisible.value = false;
            if (scrollY < layerStart) layersProgress.value = -1;
        }
    }
    
    // ISS inline sticky split - fixed header on mobile
    if (issRef.value) {
        const rect = issRef.value.getBoundingClientRect();
        const sectionTop = scrollY + rect.top;
        const sectionHeight = issRef.value.offsetHeight;
        const issStart = sectionTop;
        const issEnd = sectionTop + sectionHeight - windowHeight;
        
        if (scrollY >= issStart && scrollY <= issEnd) {
            issHeaderVisible.value = true;
        } else {
            issHeaderVisible.value = false;
        }
    }
    
    // Timeline inline sticky scroll
    if (timelineRef.value) {
        const rect = timelineRef.value.getBoundingClientRect();
        const sectionTop = scrollY + rect.top;
        const sectionHeight = timelineRef.value.offsetHeight;
        const tlStart = sectionTop;
        const tlEnd = sectionTop + sectionHeight - windowHeight;
        const tlRange = tlEnd - tlStart;
        
        if (scrollY >= tlStart && scrollY <= tlEnd && tlRange > 0) {
            const localProgress = (scrollY - tlStart) / tlRange;
            timelineProgress.value = Math.min(100, localProgress * 100);
            timelineBarVisible.value = true;
        } else if (scrollY > tlEnd) {
            timelineProgress.value = 100;
            timelineBarVisible.value = false;
        } else {
            timelineProgress.value = 0;
            timelineBarVisible.value = false;
        }
    }
    
    // CDN map progressive reveal (fixed container approach)
    if (cdnMapRef.value) {
        const spacerRect = cdnMapRef.value.getBoundingClientRect();
        const spacerTop = scrollY + spacerRect.top;
        const spacerHeight = cdnMapRef.value.offsetHeight;
        const cdnStart = spacerTop;
        const cdnEnd = spacerTop + spacerHeight;
        
        if (scrollY >= cdnStart && scrollY <= cdnEnd) {
            cdnMapVisible.value = true;
            const cdnRange = cdnEnd - cdnStart - windowHeight;
            if (cdnRange > 0) {
                const localProgress = Math.max(0, Math.min(1, (scrollY - cdnStart) / cdnRange));
                cdnRevealCount.value = Math.min(10, Math.floor(localProgress * 11));
            }
        } else {
            cdnMapVisible.value = false;
            if (scrollY > cdnEnd) {
                cdnRevealCount.value = 10;
            } else {
                cdnRevealCount.value = 0;
            }
        }
    }
};
const openModal = (feature) => {
    selectedFeature.value = feature;
    modalOpen.value = true;
};

const closeModal = () => {
    modalOpen.value = false;
};

const aiFeatures = [
    {
        icon: '🧠',
        title: 'AI 即時分析',
        description: '使用 Ollama 本地大語言模型進行請求分析，在不影響效能的情況下提供智能威脅偵測',
        highlights: [
            '3 秒內完成威脅評估',
            '繞過傳統規則的攻擊偵測',
            '低/中/高三級敏感度設定',
            '所有判定記錄可追溯',
            '本地部署保護隱私'
        ],
        tech: ['Ollama', 'LLM', 'SSE Streaming', 'Real-time Analysis']
    },
    {
        icon: '🎯',
        title: 'CVE 漏洞防護',
        description: '自動從 NVD 同步最新 CVE，結合多來源情報，AI 生成專屬防護規則',
        highlights: [
            '即時同步 NVD 漏洞資料',
            '自動搜尋 Exploit-DB / GitHub PoC',
            'AI 分析攻擊向量生成規則',
            '人工審核後一鍵部署',
            'CVSS 評分優先排序'
        ],
        tech: ['NVD API', 'Exploit-DB', 'GitHub API', 'AI Rule Generation']
    },
    {
        icon: '💬',
        title: 'AI 安全助手',
        description: '智能對話式安全分析與操作建議，讓安全管理更直覺',
        highlights: [
            '即時攻擊分析與建議',
            '一鍵封鎖可疑 IP',
            '安全事件總結報告',
            'SSE 串流即時回應',
            '支援中文對話'
        ],
        tech: ['Chat Interface', 'SSE', 'Action Commands', 'Context-aware']
    }
];

const cveSteps = [
    { icon: '📥', title: '自動抓取', description: 'NVD API 同步最新 CVE' },
    { icon: '🔍', title: '情報蒐集', description: '搜尋 Exploit-DB、GitHub PoC' },
    { icon: '🤖', title: 'AI 生成', description: 'LLM 分析並生成 WAF 規則' },
    { icon: '👁️', title: '人工審核', description: '審核規則確保準確性' },
    { icon: '🚀', title: '一鍵部署', description: '套用至指定站點' }
];

const cveSources = ['NVD NIST', 'Exploit-DB', 'GitHub PoC', 'CVE References'];

// Load Balancer Features
const lbFeatures = [
    { icon: '🔄', title: '自動故障轉移', desc: '後端伺服器故障時自動重新路由流量，確保服務不中斷' },
    { icon: '⚖️', title: '權重分配', desc: '依據伺服器效能自訂流量權重，最佳化資源利用' },
    { icon: '💓', title: '健康檢查', desc: '定期監測後端伺服器狀態，即時感知異常' },
    { icon: '📊', title: '流量視覺化', desc: '即時展示流量分配狀況與後端伺服器健康狀態' }
];

const lbStrategies = [
    { icon: '🔁', name: '輪詢 (Round Robin)', desc: '依序分配請求到各後端伺服器' },
    { icon: '⚖️', name: '加權輪詢', desc: '依據設定權重比例分配流量' },
    { icon: '🎲', name: '隨機 (Random)', desc: '隨機選擇後端伺服器處理請求' },
    { icon: '#️⃣', name: 'IP 雜湊', desc: '同一來源 IP 固定導向相同伺服器' }
];

// CDN Global Nodes (positions match WAF Map.vue coordinate system)
// WAF formula: left% = (lon + 158) / 338 * 100, top% = (78 - lat) / 134 * 100
const cdnNodes = [
    { name: '台北主節點 (Origin)', left: 82.7, top: 39.5, latency: '<1ms', primary: true },
    { name: '新加坡', left: 77.5, top: 57.2, latency: '~2ms', primary: true },
    { name: '美西 (LA)', left: 11.8, top: 32.8, latency: '~3ms', primary: true },
    { name: '香港', left: 80.5, top: 41.6, latency: '~2ms', primary: false },
    { name: '東京', left: 88.1, top: 31.6, latency: '~3ms', primary: false },
    { name: '法蘭克福', left: 49.3, top: 20.8, latency: '~4ms', primary: false },
    { name: '美東 (NY)', left: 24.9, top: 27.8, latency: '~5ms', primary: false },
    { name: '聖保羅', left: 29.0, top: 75.7, latency: '~5ms', primary: false },
    { name: '約翰內斯堡', left: 55.0, top: 77.8, latency: '~4ms', primary: false },
    { name: '雪梨', left: 91.5, top: 83.5, latency: '~3ms', primary: false }
];

// Connection lines (from Taiwan origin to each node, as %)
const cdnConnections = [
    { x1: 82.7, y1: 39.5, x2: 77.5, y2: 57.2 },   // 台北→新加坡
    { x1: 82.7, y1: 39.5, x2: 80.5, y2: 41.6 },   // →香港
    { x1: 82.7, y1: 39.5, x2: 88.1, y2: 31.6 },   // →東京
    { x1: 82.7, y1: 39.5, x2: 49.3, y2: 20.8 },   // →法蘭克福
    { x1: 49.3, y1: 20.8, x2: 11.8, y2: 32.8 },   // 法蘭克福→美西
    { x1: 49.3, y1: 20.8, x2: 24.9, y2: 27.8 },   // 法蘭克福→美東
    { x1: 24.9, y1: 27.8, x2: 29.0, y2: 75.7 },   // 美東→聖保羅
    { x1: 49.3, y1: 20.8, x2: 55.0, y2: 77.8 },   // 法蘭克福→約翰內斯堡
    { x1: 77.5, y1: 57.2, x2: 91.5, y2: 83.5 },   // 新加坡→雪梨
];

// CDN Features Data
const cdnFeatures = [
    { icon: '⚡', title: '靜態資源加速', desc: '自動快取 CSS、JS、圖片等靜態資源' },
    { icon: '🎯', title: '智能快取策略', desc: '依副檔名、路徑自訂快取規則' },
    { icon: '🗑️', title: '一鍵清除快取', desc: '按路徑或全站快速清除快取' },
    { icon: '📊', title: '快取命中統計', desc: '即時監控快取命中率與效能' }
];

// DDoS Scrubbing Layers
const ddosLayers = [
    { name: '流量清洗', desc: '識別並過濾惡意流量，保留合法請求' },
    { name: 'SYN Flood 防護', desc: 'SYN Cookie 驗證，防止半連接攻擊' },
    { name: 'UDP Flood 過濾', desc: '丟棄異常 UDP 封包，保護頻寬' },
    { name: '速率限制', desc: '智能速率控制，防止資源耗盡' },
    { name: '黑洞路由', desc: '終極防線，將攻擊流量導向黑洞' }
];

// DDoS Traffic Types (for visualization)
const ddosTrafficTypes = [
    { name: 'SYN Flood', malicious: 85, clean: 15, blocked: 98 },
    { name: 'UDP Flood', malicious: 72, clean: 28, blocked: 96 },
    { name: 'HTTP Flood', malicious: 65, clean: 35, blocked: 94 },
    { name: 'DNS Amplification', malicious: 90, clean: 10, blocked: 99 },
    { name: 'Slowloris', malicious: 45, clean: 55, blocked: 97 }
];

// GeoIP Features
const geoipFeatures = [
    { icon: '🌍', title: 'Anycast 路由', desc: '全球任播，自動選擇最近節點' },
    { icon: '📍', title: '就近接入', desc: '基於 GeoIP 判斷，就近導向最優節點' },
    { icon: '🚧', title: '地理圍欄', desc: '按國家/地區封鎖或允許流量' },
    { icon: '🔄', title: '智能 DNS', desc: '結合延遲監測，動態調整解析結果' }
];

// Multi-Node Examples
const nodeExamples = [
    { name: 'HK-01', region: '香港', latency: '12ms', status: 'healthy' },
    { name: 'TW-01', region: '台灣', latency: '8ms', status: 'healthy' },
    { name: 'JP-01', region: '日本', latency: '25ms', status: 'healthy' },
    { name: 'US-01', region: '美國', latency: '180ms', status: 'warning' }
];

const features = [
    {
        icon: '🛡️',
        title: '站點管理',
        description: '管理反向代理網站和防護設定，輕鬆守護多個網站',
        highlights: ['多站點管理', '獨立防護設定', '域名綁定', '反向代理配置', 'SSL 證書管理'],
        tech: ['Nginx', 'Reverse Proxy', 'SSL/TLS']
    },
    {
        icon: '📊',
        title: '即時監控',
        description: '即時攻擊統計和 QPS 監控，掌握網站安全狀態',
        highlights: ['即時 QPS 監控', '攻擊類型統計', '地理位置分析', '趨勢圖表', '即時告警'],
        tech: ['Real-time Charts', 'WebSocket', 'Dashboard']
    },
    {
        icon: '🚫',
        title: '黑白名單',
        description: 'IP 黑白名單管理，支持 CIDR 格式精確控制',
        highlights: ['CIDR 格式支援', '臨時/永久封鎖', '白名單優先', '批量導入', '自動過期'],
        tech: ['IP Management', 'CIDR', 'Auto-expire']
    },
    {
        icon: '⚡',
        title: 'CC 防護',
        description: '配置請求限制和封鎖策略，防止惡意流量攻擊',
        highlights: ['請求頻率限制', '滑動窗口算法', '自動封鎖', '白名單例外', '自訂閾值'],
        tech: ['Rate Limiting', 'Sliding Window', 'Auto-block']
    },
    {
        icon: '🤖',
        title: 'AI 智能防禦',
        description: 'Ollama AI 即時分析可疑請求，偵測繞過規則的攻擊',
        highlights: ['本地 LLM 分析', '3秒超時設計', '三級敏感度', '完整日誌', '持續學習'],
        tech: ['Ollama', 'LLM', 'Real-time Analysis']
    },
    {
        icon: '📡',
        title: 'CVE 即時更新',
        description: '自動同步 NVD 漏洞資料庫，AI 生成防護規則',
        highlights: ['NVD 即時同步', 'Exploit-DB 整合', 'GitHub PoC 搜尋', 'AI 規則生成', '人工審核'],
        tech: ['NVD API', 'AI Generation', 'Rule Management']
    },
    {
        icon: '🔐',
        title: '人機驗證',
        description: '驗證碼保護配置，有效阻擋自動化攻擊',
        highlights: ['JavaScript 驗證', 'Cookie 驗證', '自訂觸發條件', '友好提示頁面', '白名單繞過'],
        tech: ['CAPTCHA', 'JavaScript Challenge', 'Cookie Auth']
    },
    {
        icon: '📝',
        title: '攻擊日誌',
        description: '詳細的攻擊記錄和分析，追蹤所有安全事件',
        highlights: ['完整請求記錄', '攻擊類型分類', '地理位置追蹤', '時間軸分析', '匯出功能'],
        tech: ['Logging', 'Analytics', 'Export']
    },
    {
        icon: '🌍',
        title: '地理封鎖',
        description: '基於地理位置的訪問控制，精準防護策略',
        highlights: ['國家/地區封鎖', 'IP 地理定位', '一鍵封鎖', '白名單例外', '即時更新'],
        tech: ['GeoIP', 'Country Block', 'IP Location']
    },
    {
        icon: '🔒',
        title: 'SSL 憑證',
        description: '整合 Let\'s Encrypt 的自動化 SSL 憑證管理',
        highlights: ['一鍵簽發', '自動驗證', '憑證監控', '到期提醒', '自動續期'],
        tech: ['Let\'s Encrypt', 'ACME', 'Auto-renew']
    },
    {
        icon: '💬',
        title: 'AI 助手 Sentinel',
        description: '對話式 AI 安全助手，智能分析與操作協助',
        highlights: ['自然語言對話', '攻擊分析', 'IP 封鎖操作', '報告生成', 'Function Calling'],
        tech: ['LLM', 'Chat Interface', 'Automation']
    },
    {
        icon: '⚙️',
        title: '系統日誌',
        description: '即時查看 Nginx 存取日誌與錯誤日誌',
        highlights: ['Access Log', 'Error Log', '即時滾動', '搜尋過濾', '日誌解析'],
        tech: ['Log Viewer', 'Real-time', 'Parsing']
    },
    {
        icon: '👁️',
        title: 'SOC 儀表板',
        description: '專業安全操作中心，3D 視覺化攻擊地圖',
        highlights: ['3D 地球視覺化', '即時統計', 'AI 威脅報告', '全螢幕模式', '報告郵件發送'],
        tech: ['Three.js', 'SSE', 'Real-time']
    },
    {
        icon: '🔗',
        title: 'IDS/IPS 整合',
        description: '分散式入侵偵測，後端伺服器縱深防禦',
        highlights: ['Agent 管理', '規則同步', '告警整合', '集中封鎖', 'AI 偵測'],
        tech: ['Distributed', 'Agent-based', 'Real-time']
    },
    {
        icon: '🚀',
        title: 'CDN 快取加速',
        description: 'Nginx Proxy Cache 加速靜態資源，降低源站負載',
        highlights: ['智能靜態快取', '自訂快取規則', '一鍵清除快取', '按站點管理', '快取命中統計'],
        tech: ['Nginx Proxy Cache', 'Cache Purge', 'CDN']
    },
    {
        icon: '🌊',
        title: 'DDoS 清洗中心',
        description: '專業 DDoS 流量清洗，過濾惡意流量保護源站',
        highlights: ['流量清洗策略', 'SYN Flood 防護', 'UDP Flood 防護', '黑洞路由', '清洗報告'],
        tech: ['Traffic Scrubbing', 'Rate Limiting', 'DDoS Mitigation']
    },
    {
        icon: '🗺️',
        title: 'GeoIP 智能路由',
        description: '基於地理位置的智能流量路由，就近接入最佳節點',
        highlights: ['Anycast 路由', '就近接入', '地理圍欄', '智能 DNS', '延遲優化'],
        tech: ['GeoIP', 'Anycast', 'Smart DNS']
    },
    {
        icon: '🏗️',
        title: '多節點管理',
        description: '分散式 WAF 節點部署與管理，全球覆蓋',
        highlights: ['節點狀態監控', '組態同步', '故障自動切換', '流量調度', '集中管理'],
        tech: ['Multi-Node', 'Distributed', 'Auto-failover']
    },
    {
        icon: '🦠',
        title: 'ClamAV 防毒掃描',
        description: 'IDS 整合 ClamAV 掃毒引擎，即時掃描上傳檔案',
        highlights: ['檔案上傳掃毒', '即時掃描', '病毒庫自動更新', '掃描報告', '隔離管理'],
        tech: ['ClamAV', 'Virus Scan', 'File Upload']
    },
    {
        icon: '🐉',
        title: 'Snort 規則引擎',
        description: '整合 Snort 3 IDS 規則引擎，企業級深度封包檢測',
        highlights: ['Snort 3 支援', '規則自動更新', '自訂 Snort 規則', '深度封包檢測', '告警整合'],
        tech: ['Snort 3', 'DPI', 'IDS Rules']
    },
    {
        icon: '👥',
        title: '角色權限管理',
        description: 'RBAC 角色型存取控制，多用戶權限分級管理',
        highlights: ['角色管理', '權限分級', '站點存取控制', '操作日誌', '多用戶支援'],
        tech: ['RBAC', 'Roles', 'Permissions']
    }
];

// Attack Types Data
const wafProtectionRules = [
    {
        icon: '💉',
        name: '注入攻擊防護',
        rules: [
            { name: 'SQL 注入防護', severity: 'high', desc: '攔截 SQL Injection 攻擊 (含進階繞過、時間盲注)' },
            { name: 'XSS 跨站腳本防護', severity: 'high', desc: '攔截 Cross-Site Scripting 攻擊 (含現代繞過向量)' },
            { name: 'NoSQL 注入防護', severity: 'high', desc: '攔截 NoSQL Injection 攻擊 (MongoDB $ne/$gt 等)' },
            { name: 'LDAP 注入防護', severity: 'high', desc: '攔截 LDAP Injection 攻擊' },
            { name: 'OGNL 注入防護', severity: 'high', desc: '攔截 Apache Struts2 OGNL Injection 攻擊' }
        ]
    },
    {
        icon: '⚡',
        name: '遠程執行防護',
        rules: [
            { name: 'RCE 遠程代碼執行防護', severity: 'high', desc: '攔截 Remote Code Execution 攻擊 (含編碼繞過)' },
            { name: 'SSTI 模板注入防護', severity: 'high', desc: '攔截 Server-Side Template Injection (含框架特定攻擊)' },
            { name: 'Java 反序列化防護', severity: 'high', desc: '攔截 Java Deserialization 漏洞攻擊' },
            { name: 'XXE 外部實體注入防護', severity: 'high', desc: '攔截 XML External Entity 攻擊 (含進階向量)' }
        ]
    },
    {
        icon: '🌐',
        name: '協議與重定向防護',
        rules: [
            { name: 'SSRF 伺服器端請求偽造防護', severity: 'high', desc: '攔截 Server-Side Request Forgery (含協議走私)' },
            { name: 'CRLF 注入防護', severity: 'high', desc: '攔截 HTTP Header CRLF Injection 攻擊' },
            { name: '開放重定向防護', severity: 'high', desc: '攔截 Open Redirect 攻擊嘗試' },
            { name: 'HTTP 請求走私防護', severity: 'high', desc: '攔截 HTTP Request Smuggling (CL/TE 衝突)' },
            { name: 'HTTP 標頭注入防護', severity: 'high', desc: '攔截 HTTP Header Injection 攻擊' }
        ]
    },
    {
        icon: '🔍',
        name: '偵測與存取防護',
        rules: [
            { name: '路徑遍歷防護', severity: 'high', desc: '攔截 Path Traversal 與編碼繞過嘗試' },
            { name: '本地文件包含防護', severity: 'high', desc: '攔截 Local File Inclusion (LFI) 攻擊' },
            { name: '敏感文件存取防護', severity: 'high', desc: '攔截 .env / .git / 設定檔等敏感文件存取' },
            { name: '掃描器偵測', severity: 'high', desc: '攔截常見漏洞掃描器 (SQLMap, Nikto, etc.) 與惡意 User-Agent' }
        ]
    }
];

// IDS Agents Data
const idsAgents = [
    { icon: '🖥️', name: 'Web Server 1' },
    { icon: '🖥️', name: 'Web Server 2' },
    { icon: '🖥️', name: 'API Server' }
];

// IDS Detection Engines
const idsEngines = [
    { 
        icon: '🔎', 
        name: '特徵偵測引擎', 
        desc: '基於已知攻擊特徵碼的規則匹配',
        features: ['正規表達式匹配', '資料庫與內建規則', 'Log4Shell / XXE / SSRF']
    },
    { 
        icon: '📊', 
        name: '異常偵測引擎', 
        desc: '基於基線偏離的異常行為偵測',
        features: ['高請求頻率偵測', '大請求體偵測', '非營業時段活動']
    },
    { 
        icon: '🎯', 
        name: '行為分析引擎', 
        desc: '分析請求行為模式，偵測惡意行為',
        features: ['掃描行為偵測', '暴力破解偵測', '爬蟲/Bot 識別']
    },
    { 
        icon: '🤖', 
        name: 'AI 智能偵測', 
        desc: '使用 LLM 分析 HTTP 請求模式',
        features: ['威脅評分 0-100', '自動攻擊分類', '分析理由說明']
    }
];

// Traffic Control Features
const trafficFeatures = [
    { icon: '🚫', title: 'CC/DDoS 防護', desc: '速率限制、突發限制、封鎖時間控制' },
    { icon: '🤖', title: '人機驗證', desc: '拼圖滑塊、點選驗證、Token 綁定' },
    { icon: '⚡', title: '自動封鎖', desc: '基於攻擊行為自動加入黑名單' },
    { icon: '📋', title: 'IP 名單管理', desc: '黑白名單、CIDR 支援、自動過期' }
];

// Rule Types
const ruleTypes = [
    { icon: '✏️', name: '自訂規則', desc: '針對特定站點的自訂偵測規則' },
    { icon: '🌐', name: '全域規則', desc: '套用至所有站點的通用規則' },
    { icon: '📡', name: 'CVE 規則', desc: 'AI 根據 CVE 自動生成防護規則' },
    { icon: '💡', name: 'AI 建議規則', desc: 'AI 分析攻擊模式建議的規則' }
];

const stats = [
    { value: 99.9, suffix: '%', label: '可用性' },
    { value: 10, suffix: 'ms', label: '平均延遲' },
    { value: 45, suffix: '+', label: '功能模組' },
    { value: 24, suffix: ' / 7', label: '全天候監控' }
];

const architecture = [
    { icon: '🌐', title: 'Nginx 反向代理', tech: '高效能負載均衡與流量處理' },
    { icon: '🔥', title: 'Lua WAF 模組', tech: '即時請求分析與攻擊偵測' },
    { icon: '🤖', title: 'AI 引擎', tech: 'Ollama 本地大語言模型 (3s 超時)' },
    { icon: '📡', title: 'CVE 同步', tech: 'NVD API + Exploit-DB + GitHub' },
    { icon: '⚡', title: 'Laravel 後端', tech: 'PHP 8.2 / Laravel 12' },
    { icon: '🎨', title: 'Vue 3 前端', tech: 'Inertia.js / Vite' },
    { icon: '🗄️', title: '資料存儲', tech: 'SQLite / MySQL' }
];

// Comparison data
const comparison = [
    { feature: 'AI 智能分析', traditional: false },
    { feature: 'CVE 即時同步', traditional: false },
    { feature: '本地 LLM 部署', traditional: false },
    { feature: 'SQL 注入防護', traditional: true },
    { feature: 'XSS 攻擊防護', traditional: true },
    { feature: '即時攻擊地圖', traditional: false },
    { feature: '一鍵規則部署', traditional: false },
    { feature: '中文介面', traditional: false },
    { feature: 'IDS/IPS 整合', traditional: false },
    { feature: '分散式 Agent', traditional: false },
    { feature: 'AI 威脅偵測', traditional: false },
    { feature: 'Passkey 驗證', traditional: false },
    { feature: 'CDN 快取加速', traditional: false },
    { feature: 'DDoS 清洗中心', traditional: false },
    { feature: 'GeoIP 智能路由', traditional: false },
    { feature: '多節點管理', traditional: false },
    { feature: 'ClamAV 防毒', traditional: false },
    { feature: 'Snort 規則引擎', traditional: false },
    { feature: 'RBAC 權限管理', traditional: false },
    { feature: 'SSRF / XXE / Log4Shell 防護', traditional: false }
];

// Attack flow timeline
const attackFlow = [
    { time: '0ms', title: '攻擊請求', desc: '惡意 SQL 注入請求進入', type: 'danger' },
    { time: '1ms', title: 'WAF 攔截', desc: 'Lua 模組即時分析請求', type: 'warning' },
    { time: '5ms', title: '規則比對', desc: '匹配已知攻擊特徵', type: 'info' },
    { time: '8ms', title: 'AI 分析', desc: 'LLM 深度威脅評估', type: 'info' },
    { time: '10ms', title: '封鎖攻擊', desc: '返回 403 並記錄日誌', type: 'success' }
];

// Deploy options
const deployOptions = [
    { icon: '🐳', title: 'Docker', desc: '推薦方式，一鍵啟動', command: 'docker-compose up -d' },
    { icon: '📦', title: '手動安裝', desc: '自訂配置，完全控制', command: 'composer install && npm run build' },
    { icon: '☁️', title: '雲端部署', desc: '支援各大雲平台', command: 'kubectl apply -f k8s/' }
];

// FAQ data
const faqs = [
    { q: '如何更新 CVE 規則？', a: '系統會自動從 NVD 同步最新 CVE 資料，您也可以手動觸發更新。AI 會自動分析並生成對應的防護規則供您審核。' },
    { q: '支援哪些攻擊類型？', a: '支援 13 種攻擊類型：SQL 注入、XSS、RCE、路徑遍歷、SSRF、XXE、Log4Shell、WebShell、PHP Injection、暴力破解、CC 攻擊、OGNL 注入、Java 反序列化等。' },
    { q: '可以與現有系統整合嗎？', a: '可以，Security One SOC 作為反向代理運行，可以保護任何 HTTP/HTTPS 服務，無需修改現有應用程式。' },
    { q: 'CDN 快取功能如何運作？', a: '系統內建 Nginx Proxy Cache，可針對每個站點配置靜態資源快取策略，支援按路徑或副檔名清除快取，有效降低源站負載。' },
    { q: '如何防護 DDoS 攻擊？', a: '系統提供 DDoS 清洗中心，結合速率限制、SYN Flood 防護、UDP Flood 過濾等多重機制，可自動識別並清洗惡意流量。' },
    { q: '支援多節點部署嗎？', a: '支援，您可以部署多個 WAF 節點，系統提供集中管理、組態同步、健康監控和故障自動切換功能，結合 GeoIP 智能路由實現全球覆蓋。' },
    { q: 'IDS Agent 支援哪些掃毒功能？', a: 'IDS Agent 整合 ClamAV 掃毒引擎，可即時掃描上傳檔案，自動更新病毒庫，並產生掃描報告。同時支援 Snort 3 深度封包檢測。' }
];

const activeFaq = ref(null);

const toggleFaq = (index) => {
    activeFaq.value = activeFaq.value === index ? null : index;
};

const onLoadingComplete = () => {
    isLoading.value = false;
};

onMounted(() => {
    // Mobile detection
    checkMobile();
    window.addEventListener('resize', checkMobile);

    // Parallax scroll listener
    window.addEventListener('scroll', handleScroll, { passive: true });
    handleScroll(); // Initial call

    // Scroll animation observer
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.scroll-animate').forEach(el => {
        observer.observe(el);
    });
});

onUnmounted(() => {
    window.removeEventListener('scroll', handleScroll);
    window.removeEventListener('resize', checkMobile);
});
</script>

<style scoped>
/* Scroll Progress Bar */
.scroll-progress-bar {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    height: 3px;
    background: linear-gradient(90deg, #00d4ff, #8b5cf6, #ff006e);
    transform-origin: left;
    z-index: 9999;
    box-shadow: 0 0 10px rgba(0, 212, 255, 0.5), 0 0 30px rgba(139, 92, 246, 0.3);
}

/* Hero Cursor Follow Gradient */
.hero-cursor-gradient {
    position: fixed;
    inset: 0;
    z-index: 0;
    pointer-events: none;
}

@media (max-width: 768px) {
    .hero-cursor-gradient {
        display: none;
    }
}

.app-wrapper {
    position: relative;
    min-height: 100vh;
    width: 100%;
    overflow-x: hidden;
}

/* Login Button - Fixed Top Right */
.login-btn {
    position: fixed;
    top: 1.5rem;
    right: 1.5rem;
    z-index: 1000;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 1.25rem;
    background: rgba(10, 15, 30, 0.7);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(0, 212, 255, 0.3);
    border-radius: 50px;
    color: #fff;
    text-decoration: none;
    font-weight: 500;
    font-size: 0.9rem;
    transition: all 0.3s ease;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}

.login-btn:hover {
    background: rgba(0, 212, 255, 0.15);
    border-color: rgba(0, 212, 255, 0.6);
    box-shadow: 0 4px 30px rgba(0, 212, 255, 0.3);
    transform: translateY(-2px);
}

.login-icon {
    font-size: 1rem;
}

.login-text {
    background: linear-gradient(135deg, #00d4ff, #8b5cf6);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

/* Hero Parallax Wrapper */
.hero-wrapper {
    height: 100vh;
    position: relative;
}

/* Hero Title Sizes */
.title-brand,
.title-product {
    background: inherit;
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.title-brand {
    font-size: 0.55em;
}

.title-product {
    font-size: 1em;
}

.hero-fixed {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100vh;
    z-index: 1;
    will-change: transform, opacity, filter;
    transition: none;
}

/* Scroll Indicator */
.scroll-indicator {
    position: absolute;
    bottom: 3rem;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
    color: rgba(255, 255, 255, 0.5);
    font-size: 0.875rem;
    transition: opacity 0.3s ease;
}

.scroll-arrow {
    animation: bounceDown 1.5s ease-in-out infinite;
    font-size: 1.5rem;
    color: #00d4ff;
}

@keyframes bounceDown {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(10px); }
}

/* Animation Classes */
.animate-float {
    animation: float 3s ease-in-out infinite;
}

.animate-float-slow {
    animation: float 4s ease-in-out infinite;
}

@keyframes float {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
}

.animate-pulse-border {
    animation: pulseBorder 2s ease-in-out infinite;
}

@keyframes pulseBorder {
    0%, 100% { box-shadow: 0 0 0 0 rgba(0, 212, 255, 0.4); }
    50% { box-shadow: 0 0 0 8px rgba(0, 212, 255, 0); }
}

.animate-glow {
    animation: glow 2s ease-in-out infinite alternate;
}

@keyframes glow {
    from { box-shadow: 0 0 20px rgba(0, 212, 255, 0.4); }
    to { box-shadow: 0 0 30px rgba(0, 212, 255, 0.6), 0 0 60px rgba(139, 92, 246, 0.3); }
}

.animate-hover-lift {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.animate-hover-lift:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.animate-hover-scale {
    transition: transform 0.3s ease;
}

.animate-hover-scale:hover {
    transform: scale(1.05);
}

.animate-pop {
    animation: popIn 0.5s ease forwards;
    opacity: 0;
}

@keyframes popIn {
    from { opacity: 0; transform: scale(0.8); }
    to { opacity: 1; transform: scale(1); }
}

/* Sticky Pipeline Section */
.sticky-pipeline {
    position: relative;
    z-index: 10;
}

.sticky-spacer {
    height: 500vh;
}

.sticky-fixed-container {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(180deg, #0a0a0f 0%, #0d0d1a 50%, #0a0a0f 100%);
    z-index: 100;
    transition: opacity 0.3s ease;
    pointer-events: none;
    overflow: hidden;
}

.sticky-slide {
    position: absolute;
    width: 100%;
    max-width: 900px;
    padding: 2rem;
    text-align: center;
    opacity: 0;
    transform: translateY(40px) scale(0.95);
    transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1);
    pointer-events: none;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.sticky-slide.active {
    opacity: 1;
    transform: translateY(0) scale(1);
}

.sticky-slide-icon {
    font-size: 4rem;
    margin-bottom: 1rem;
    animation: float 3s ease-in-out infinite;
}

@keyframes float {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
}

.sticky-slide-desc {
    font-size: 1.05rem;
    color: rgba(255, 255, 255, 0.65);
    line-height: 1.8;
    margin-bottom: 2rem;
    max-width: 600px;
}

.sticky-slide-visual {
    margin: 1.5rem 0;
    width: 100%;
    max-width: 700px;
}

.sticky-slide-tags {
    display: flex;
    justify-content: center;
    gap: 1.5rem;
    margin-top: 1.5rem;
    flex-wrap: wrap;
}

/* Pipeline Flow Diagram */
.pipeline-flow {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 1rem;
    flex-wrap: wrap;
}

.pf-node {
    padding: 1.2rem 2rem;
    background: rgba(15, 15, 30, 0.9);
    border: 1px solid rgba(255, 255, 255, 0.15);
    border-radius: 12px;
    font-size: 1.1rem;
    font-weight: 600;
    transition: all 0.3s ease;
}

.pf-node.active-glow {
    border-color: #00d4ff;
    box-shadow: 0 0 30px rgba(0, 212, 255, 0.3), 0 0 60px rgba(0, 212, 255, 0.1);
    color: #00d4ff;
}

.pf-node.dim {
    opacity: 0.35;
}

.pf-arrow {
    font-size: 2rem;
    color: #00d4ff;
    font-weight: bold;
}

.pf-arrow.dim {
    opacity: 0.25;
}

/* Analysis Engines */
.analysis-engines {
    display: flex;
    gap: 1.5rem;
    justify-content: center;
    flex-wrap: wrap;
}

.engine-box {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
    padding: 1.5rem 2rem;
    background: rgba(15, 15, 30, 0.9);
    border: 1px solid rgba(255, 255, 255, 0.12);
    border-radius: 16px;
    min-width: 160px;
    transition: all 0.3s ease;
}

.engine-box.highlight {
    border-color: #8b5cf6;
    box-shadow: 0 0 30px rgba(139, 92, 246, 0.2);
}

.engine-box .engine-icon {
    font-size: 2.5rem;
}

.engine-box .engine-label {
    font-weight: 700;
    font-size: 1rem;
    color: rgba(255, 255, 255, 0.9);
}

.engine-box .engine-check {
    font-size: 0.8rem;
    color: #00d4ff;
}

/* Action Results */
.action-results {
    display: flex;
    gap: 1rem;
    justify-content: center;
    flex-wrap: wrap;
}

.action-card {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.4rem;
    padding: 1.2rem 1.5rem;
    background: rgba(15, 15, 30, 0.9);
    border-radius: 14px;
    min-width: 130px;
    transition: all 0.3s ease;
}

.action-card.pass { border: 1px solid rgba(0, 255, 136, 0.3); }
.action-card.warn { border: 1px solid rgba(255, 165, 0, 0.3); }
.action-card.challenge { border: 1px solid rgba(139, 92, 246, 0.3); }
.action-card.block { border: 1px solid rgba(255, 59, 48, 0.3); box-shadow: 0 0 20px rgba(255, 59, 48, 0.1); }

.action-card .action-icon { font-size: 2rem; }
.action-card .action-label { font-weight: 700; font-size: 0.9rem; color: rgba(255, 255, 255, 0.9); }
.action-card .action-score { font-size: 0.75rem; color: rgba(255, 255, 255, 0.45); font-family: 'Orbitron', sans-serif; }

/* Sticky Indicators */
.sticky-indicators {
    position: absolute;
    right: 2rem;
    top: 50%;
    transform: translateY(-50%);
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.sticky-ind {
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    border: 2px solid rgba(255, 255, 255, 0.15);
    font-size: 0.75rem;
    font-weight: 700;
    color: rgba(255, 255, 255, 0.3);
    font-family: 'Orbitron', sans-serif;
    transition: all 0.3s ease;
}

.sticky-ind.active {
    border-color: #00d4ff;
    color: #00d4ff;
    box-shadow: 0 0 15px rgba(0, 212, 255, 0.3);
}

@media (max-width: 768px) {
    .pipeline-flow { flex-direction: column; }
    .pf-arrow { transform: rotate(90deg); }
    .analysis-engines { flex-direction: column; align-items: center; }
    .action-results { flex-direction: column; align-items: center; }
    .sticky-indicators { right: 1rem; }
    .sticky-slide { padding: 1.5rem 1rem; }
    .sticky-slide-icon { font-size: 3rem; }
    .sticky-slide-desc { font-size: 0.9rem; }
}

/* Defense Layers Sticky Scroll */
.sticky-layers {
    position: relative;
    z-index: 10;
}

.layers-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    max-width: 800px;
    padding: 2rem;
}

.layers-subtitle {
    color: rgba(255, 255, 255, 0.5);
    font-size: 1.05rem;
    margin-bottom: 2.5rem;
}

.defense-stack {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    width: 100%;
}

.defense-layer {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    padding: 1.2rem 1.5rem;
    background: rgba(15, 15, 30, 0.9);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-left: 4px solid var(--layer-color);
    border-radius: 12px;
    opacity: 0;
    transform: translateX(-60px);
    transition: all 0.6s cubic-bezier(0.16, 1, 0.3, 1);
}

.defense-layer.revealed {
    opacity: 1;
    transform: translateX(0);
    border-color: rgba(255, 255, 255, 0.08);
    border-left-color: var(--layer-color);
    box-shadow: 0 0 25px color-mix(in srgb, var(--layer-color) 15%, transparent);
}

.dl-num {
    font-size: 1.5rem;
    font-weight: 900;
    font-family: 'Orbitron', sans-serif;
    color: var(--layer-color);
    min-width: 50px;
    text-align: center;
}

.dl-content {
    flex: 1;
}

.dl-content h3 {
    font-size: 1.1rem;
    font-weight: 700;
    margin-bottom: 0.3rem;
    color: rgba(255, 255, 255, 0.95);
}

.dl-content p {
    font-size: 0.85rem;
    color: rgba(255, 255, 255, 0.45);
}

.dl-stat {
    font-size: 0.85rem;
    color: rgba(255, 255, 255, 0.5);
    white-space: nowrap;
}

.dl-stat strong {
    color: var(--layer-color);
    font-size: 1.1rem;
}

.layers-result {
    margin-top: 2rem;
    padding: 1rem 2rem;
    background: rgba(0, 255, 136, 0.08);
    border: 1px solid rgba(0, 255, 136, 0.25);
    border-radius: 12px;
    opacity: 0;
    transform: scale(0.9);
    transition: all 0.6s cubic-bezier(0.16, 1, 0.3, 1);
    display: flex;
    align-items: center;
    gap: 1rem;
}

.layers-result.show {
    opacity: 1;
    transform: scale(1);
}

.result-icon {
    font-size: 1.5rem;
}

.result-text {
    font-size: 1rem;
    font-weight: 600;
    color: #00ff88;
}

@media (max-width: 768px) {
    .layers-content { padding: 0.5rem; max-width: 100%; }
    .layers-content .section-title { font-size: 1.1rem; margin-bottom: 0.25rem; }
    .layers-subtitle { font-size: 0.8rem; margin-bottom: 0.5rem; }
    .defense-stack { gap: 0.4rem; }
    .defense-layer {
        flex-direction: row;
        text-align: left;
        gap: 0.4rem;
        padding: 0.5rem 0.6rem;
    }
    .defense-layer h3 { font-size: 0.8rem; margin-bottom: 0; }
    .defense-layer p { font-size: 0.65rem; margin: 0; line-height: 1.2; }
    .dl-num { font-size: 0.9rem; min-width: 30px; }
    .dl-content { flex: 1; }
    .dl-stat { font-size: 0.65rem; white-space: nowrap; }
    .layers-result { padding: 0.5rem; font-size: 0.8rem; gap: 0.3rem; }
    .sticky-fixed-container { 
        padding: 0 0.5rem; 
        overflow-y: auto !important;
        align-items: center;
    }
    .sticky-slide { 
        padding: 1rem 0.75rem; 
        gap: 0.5rem;
        max-height: none;
        padding-top: 2rem;
    }
    .sticky-slide-icon { font-size: 2rem; margin-bottom: 0; }
    .sticky-slide .section-title { font-size: 1.1rem; margin-bottom: 0.25rem; }
    .sticky-slide-desc { font-size: 0.8rem; margin-bottom: 0.5rem; }
    .sticky-slide-visual { margin: 0.25rem 0; }
    .sticky-slide-tags { gap: 0.3rem; margin-top: 0.25rem; }
    
    /* Action cards: 2x2 grid instead of vertical stack */
    .action-results {
        display: grid !important;
        grid-template-columns: repeat(2, 1fr) !important;
        gap: 0.5rem !important;
    }
    .action-card { padding: 0.5rem 0.75rem !important; }
    
    /* Engine boxes: horizontal row */
    .analysis-engines {
        display: grid !important;
        grid-template-columns: repeat(3, 1fr) !important;
        gap: 0.5rem !important;
    }
    .engine-box { padding: 0.5rem !important; font-size: 0.75rem; }
    .engine-icon { font-size: 1.2rem; }
    .engine-label { font-size: 0.7rem; }
    .engine-check { font-size: 0.65rem; }
    
    /* Pipeline flow: horizontal */
    .pipeline-flow {
        flex-direction: row !important;
        flex-wrap: wrap;
        justify-content: center;
        gap: 0.5rem !important;
    }
    .pf-node { padding: 0.4rem 0.6rem !important; font-size: 0.7rem; }
    .pf-arrow { font-size: 0.8rem !important; }
}

/* ========== INLINE STICKY: SPLIT LAYOUT ========== */
.inline-sticky-split {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
}

.iss-container {
    max-width: 1100px;
    margin: 0 auto;
    display: flex;
    gap: 3rem;
    align-items: flex-start;
}

.iss-left {
    flex: 0 0 340px;
    position: sticky;
    top: 20vh;
}

.iss-left-inner {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.iss-badge {
    display: inline-block;
    font-size: 0.7rem;
    font-weight: 800;
    letter-spacing: 0.15em;
    color: #00d4ff;
    background: rgba(0, 212, 255, 0.1);
    border: 1px solid rgba(0, 212, 255, 0.25);
    padding: 0.35rem 0.8rem;
    border-radius: 20px;
    width: fit-content;
    font-family: 'Orbitron', sans-serif;
}

.iss-desc {
    font-size: 1.05rem;
    color: rgba(255, 255, 255, 0.5);
    line-height: 1.8;
}

.iss-counter {
    display: flex;
    align-items: baseline;
    gap: 0.75rem;
    margin-top: 1rem;
}

.iss-count {
    font-size: 4rem;
    font-weight: 900;
    font-family: 'Orbitron', sans-serif;
    background: linear-gradient(135deg, #00d4ff, #8b5cf6);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.iss-count-label {
    font-size: 0.9rem;
    color: rgba(255, 255, 255, 0.4);
}

.iss-right {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 2rem;
}

.iss-card {
    display: flex;
    gap: 1.5rem;
    padding: 2rem;
    background: rgba(15, 15, 30, 0.8);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 16px;
    transition: all 0.3s ease;
}

.iss-card:hover {
    border-color: rgba(0, 212, 255, 0.25);
    transform: translateY(-4px);
    box-shadow: 0 12px 40px rgba(0, 0, 0, 0.3);
}

.iss-card-icon {
    font-size: 2.5rem;
    flex-shrink: 0;
}

.iss-card-body h3 {
    font-size: 1.2rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
    color: rgba(255, 255, 255, 0.95);
}

.iss-card-body p {
    font-size: 0.9rem;
    color: rgba(255, 255, 255, 0.5);
    line-height: 1.6;
    margin-bottom: 1rem;
}

.iss-card-stats {
    display: flex;
    gap: 1.5rem;
}

.iss-stat {
    display: flex;
    flex-direction: column;
}

.iss-stat-val {
    font-size: 1.1rem;
    font-weight: 800;
    font-family: 'Orbitron', sans-serif;
    color: #00d4ff;
}

.iss-stat-lbl {
    font-size: 0.7rem;
    color: rgba(255, 255, 255, 0.35);
    margin-top: 0.15rem;
}

@media (max-width: 768px) {
    .iss-container { flex-direction: column; gap: 2rem; }
    .iss-left { position: relative; top: auto; flex: none; text-align: center; }
    .iss-left-inner { align-items: center; }
    .iss-counter { justify-content: center; }
    .iss-card { flex-direction: column; text-align: center; align-items: center; }
    .iss-card-stats { justify-content: center; }
}

/* ISS Fixed Header - mobile only */
.iss-fixed-header {
    display: none;
}

@media (max-width: 768px) {
    .iss-fixed-header {
        display: flex;
        flex-direction: column;
        align-items: center;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        z-index: 150;
        background: linear-gradient(180deg, rgba(10, 10, 15, 0.98) 0%, rgba(10, 10, 15, 0.92) 80%, transparent 100%);
        padding: 1rem 1.5rem 1.5rem;
        text-align: center;
        transition: opacity 0.3s ease;
        gap: 0.3rem;
    }
    .iss-fixed-header .section-title { font-size: 1.2rem; margin-bottom: 0; }
    .iss-fixed-header .iss-badge { font-size: 0.7rem; }
    .iss-fixed-header .iss-counter { display: flex; align-items: center; gap: 0.5rem; }
    .iss-fixed-header .iss-count { font-size: 1.5rem; }
    .iss-fixed-header .iss-count-label { font-size: 0.75rem; }
}

/* ========== INLINE STICKY: HORIZONTAL TIMELINE ========== */
.inline-sticky-timeline {
    padding: 0;
    position: relative;
    z-index: 1;
}

.ist-header {
    text-align: center;
    padding: 4rem 2rem 2rem;
}

.ist-container {
    max-width: 900px;
    margin: 0 auto;
    padding: 0 2rem 4rem;
}

.ist-fixed-bar {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 150;
    background: linear-gradient(180deg, rgba(10, 10, 15, 0.98) 0%, rgba(10, 10, 15, 0.92) 80%, transparent 100%);
    padding: 1.5rem 2rem 2rem;
    transition: opacity 0.3s ease;
}

.ist-progress-track {
    width: 100%;
    height: 4px;
    background: rgba(255, 255, 255, 0.08);
    border-radius: 2px;
    overflow: hidden;
    margin-bottom: 1.5rem;
}

.ist-progress-fill {
    height: 100%;
    background: linear-gradient(90deg, #00d4ff, #8b5cf6);
    border-radius: 2px;
    transition: width 0.15s ease-out;
    box-shadow: 0 0 15px rgba(0, 212, 255, 0.5);
}

.ist-steps {
    display: flex;
    justify-content: space-between;
}

.ist-step {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
    opacity: 0.3;
    transition: all 0.3s ease;
}

.ist-step.active {
    opacity: 1;
}

.ist-step.done .ist-step-dot {
    background: #00d4ff;
    border-color: #00d4ff;
    color: #0a0a0f;
    box-shadow: 0 0 15px rgba(0, 212, 255, 0.4);
}

.ist-step-dot {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    border: 2px solid rgba(255, 255, 255, 0.2);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.8rem;
    font-weight: 800;
    font-family: 'Orbitron', sans-serif;
    color: rgba(255, 255, 255, 0.5);
    transition: all 0.3s ease;
}

.ist-step-label {
    font-size: 0.75rem;
    color: rgba(255, 255, 255, 0.6);
    font-weight: 600;
}

.ist-scroll-content {
    display: flex;
    flex-direction: column;
    gap: 2rem;
    padding-top: 1rem;
}

.ist-detail-card {
    padding: 2rem 2.5rem;
    background: rgba(15, 15, 30, 0.8);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 16px;
    transition: all 0.3s ease;
}

.ist-detail-card:hover {
    border-color: rgba(0, 212, 255, 0.2);
    transform: translateX(8px);
}

.ist-detail-num {
    font-size: 2.5rem;
    font-weight: 900;
    font-family: 'Orbitron', sans-serif;
    background: linear-gradient(135deg, #00d4ff, #8b5cf6);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-bottom: 0.5rem;
}

.ist-detail-card h3 {
    font-size: 1.2rem;
    font-weight: 700;
    margin-bottom: 0.75rem;
    color: rgba(255, 255, 255, 0.95);
}

.ist-detail-card p {
    font-size: 0.95rem;
    color: rgba(255, 255, 255, 0.5);
    line-height: 1.7;
    margin-bottom: 1rem;
}

.ist-detail-time {
    font-size: 0.8rem;
    color: #00d4ff;
    font-weight: 600;
}

@media (max-width: 768px) {
    .ist-sticky-bar { padding: 1.5rem 0 2rem; }
    .ist-step-label { font-size: 0.65rem; }
    .ist-step-dot { width: 28px; height: 28px; font-size: 0.7rem; }
    .ist-detail-card { padding: 1.5rem; }
    .ist-detail-num { font-size: 2rem; }
}

/* ========== COMPREHENSIVE RWD ========== */

/* Tablet: 769px - 1024px */
@media (max-width: 1024px) {
    .section-title { font-size: 1.8rem; }
    .features-grid { grid-template-columns: repeat(2, 1fr); }
    .waf-rules-container { grid-template-columns: 1fr; }
    .soc-layout { grid-template-columns: 1fr; gap: 1rem; }
    .soc-panel.left, .soc-panel.right, .soc-panel.center { width: 100%; }
    .passkey-container, .report-container { gap: 2rem; }
    .lb-flow-container { flex-direction: column; gap: 2rem; }
    .lb-flow-lines, .lb-dist-lines { display: none; }
    .cdn-features { grid-template-columns: repeat(2, 1fr); }
    .ddos-stats-dashboard { grid-template-columns: repeat(2, 1fr); }
    .geoip-features { grid-template-columns: repeat(2, 1fr); }
    .comparison-table { overflow-x: auto; }
    .showcase-spacer { height: 300vh; }
    .sticky-spacer { height: 400vh; }
}

/* Mobile: <= 768px */
@media (max-width: 768px) {
    /* Global - prevent any section from overflowing without breaking sticky */
    section { max-width: 100vw; padding-left: 1rem !important; padding-right: 1rem !important; }
    .section-title { font-size: 1.4rem; word-break: keep-all; }
    .section-subtitle { font-size: 0.9rem; padding: 0 0.5rem; }
    
    /* Hero */
    .hero-title { font-size: 2rem !important; }
    .hero-subtitle { font-size: 0.85rem; }
    .hero-cta { flex-direction: column; gap: 0.75rem; }
    .hero-stats { gap: 1.5rem; flex-wrap: wrap; justify-content: center; }
    
    /* Features */
    .features-grid { grid-template-columns: repeat(2, 1fr) !important; gap: 0.75rem !important; padding: 0 0.5rem !important; }
    
    /* WAF Rules */
    .waf-rules-container { grid-template-columns: 1fr !important; gap: 1rem !important; width: 100% !important; max-width: 100% !important; margin: 0 auto !important; }
    .waf-category { padding: 1rem; }
    .attack-protection-section { padding: 3rem 1rem !important; overflow-x: hidden !important; }
    .waf-rule-item { flex-direction: column; gap: 0.5rem; align-items: center; text-align: center; }
    .rule-levels { justify-content: flex-start; }
    
    /* IDS Architecture */
    .ids-architecture { flex-direction: column; gap: 1.5rem; }
    .ids-agents { flex-direction: column; align-items: center; gap: 1rem; }
    .ids-engines { grid-template-columns: 1fr; gap: 1rem; }
    
    /* Traffic Control */
    .traffic-features { grid-template-columns: 1fr; gap: 1rem; }
    
    /* Rule Management */
    .rules-flow { flex-direction: column; align-items: center; }
    .rule-arrow { transform: rotate(90deg); }
    
    /* Stats */
    .stats-grid { grid-template-columns: repeat(2, 1fr); gap: 1rem; }
    .stat-card .stat-number { font-size: 1.5rem; }
    
    /* Product Showcase */
    .showcase-spacer { height: 250vh; }
    .showcase-slide { padding: 0.5rem; }
    .showcase-image-wrapper { max-height: 50vh; width: 100%; }
    
    /* AI Features */
    .ai-features-grid { grid-template-columns: 1fr; gap: 1.5rem; }
    
    /* CVE Flow */
    .cve-flow { flex-direction: column; }
    .cve-arrow { transform: rotate(90deg); }
    
    /* Attack Timeline */
    .demo-timeline { padding-left: 1.5rem; }
    .timeline-time { width: 45px; font-size: 0.65rem; }
    
    /* SOC */
    .soc-dashboard { padding: 0.5rem; }
    .soc-screen { min-height: 300px; }
    .soc-layout { grid-template-columns: 1fr; }
    .soc-panel.left, .soc-panel.right, .soc-panel.center { width: 100%; min-height: auto; }
    .soc-panel.center { min-height: 200px; }
    .soc-content { flex-direction: column; }
    .soc-globe { min-height: 200px; }

    /* Sticky Scroll sections */
    .sticky-spacer { height: 350vh; }
    
    /* Login button - smaller and hide behind fixed overlays */
    .login-btn { 
        padding: 0.5rem 0.8rem; 
        font-size: 0.75rem; 
        top: 0.75rem; 
        right: 0.75rem; 
        z-index: 90;
    }
    
    /* Sticky indicators - hide on mobile to avoid overlap */
    .sticky-indicators { display: none; }

    /* Passkey & Report */
    .passkey-section, .report-section { padding: 3rem 1rem; }
    .passkey-container, .report-container {
        flex-direction: column;
        text-align: center;
        gap: 2rem;
        padding: 0 0.5rem;
    }
    .passkey-text, .report-text { padding: 0; }
    .passkey-features { text-align: left; }
    .report-features { text-align: left; }
    .section-lead { font-size: 0.95rem; padding: 0 0.5rem; }
    .section-desc { padding: 0 0.5rem; }
    .fingerprint-scanner { width: 150px; height: 150px; }
    .report-preview { max-width: 280px; margin: 0 auto; }
    
    /* Load Balancer */
    .lb-diagram { padding: 1rem; }
    .lb-flow-container { flex-direction: column; gap: 1.5rem; }
    .lb-flow-lines, .lb-dist-lines { display: none; }
    .lb-backends { flex-direction: column; align-items: center; }
    .lb-features { grid-template-columns: 1fr; }
    .strategy-list { grid-template-columns: 1fr; }
    
    /* CDN */
    .cdn-global-map { padding: 1rem; }
    .cdn-stats-banner { grid-template-columns: repeat(2, 1fr); gap: 0.75rem; }
    .cdn-features { grid-template-columns: 1fr; }
    .cdn-map-spacer { height: 180vh; }
    .cdn-map-fixed-container { padding: 1rem; }
    .cdn-reveal-counter { gap: 0.35rem; padding: 0.5rem 1rem; }
    .crc-num { font-size: 1.4rem; }
    
    /* DDoS */
    .ddos-stats-dashboard { grid-template-columns: repeat(2, 1fr); gap: 0.5rem; }
    .ddos-stat-card { padding: 1rem; }
    .ddos-stat-value { font-size: 1.5rem; }
    .ddos-traffic-visual { padding: 1rem; }
    .ddos-layers { gap: 0.75rem; }
    .ddos-layer { flex-direction: column; text-align: center; gap: 0.5rem; }
    
    /* GeoIP */
    .geoip-features { grid-template-columns: 1fr; }
    
    /* Multi-node */
    .multinode-section .section-title { font-size: 1.3rem; }
    
    /* ClamAV */
    .clamav-features { grid-template-columns: 1fr; }
    
    /* RBAC */
    .rbac-container { flex-direction: column; }
    .rbac-diagram { grid-template-columns: 1fr; }
    
    /* Architecture */
    .arch-layers { flex-direction: column; }
    
    /* Comparison Table */
    .comparison-table { max-width: 100%; }
    .comparison-header, .comparison-row { grid-template-columns: 2fr 1fr 1fr; gap: 0.5rem; }
    .comparison-feature, .comparison-traditional, .comparison-vito { font-size: 0.8rem; padding: 0.5rem; }
    
    /* Inline Sticky Split - stack vertically */
    .iss-container { flex-direction: column; gap: 1.5rem; }
    .iss-left { flex: none; width: 100%; position: relative; top: auto; }
    .iss-card { flex-direction: column; padding: 1.5rem; }
    .iss-card-stats { flex-wrap: wrap; gap: 0.75rem; }
    .iss-count { font-size: 2.5rem; }
    
    /* Inline Sticky Timeline - now uses fixed bar */
    .timeline-sticky-inner { padding: 0.5rem 1rem; }
    .tl-step { min-width: auto; font-size: 0.7rem; padding: 0.3rem 0.6rem; }
    .tl-step-num { width: 18px; height: 18px; font-size: 0.6rem; }
    .deploy-detail-card { padding: 1.5rem; }
    
    /* Deploy */
    .deploy-options { grid-template-columns: 1fr; }
    
    /* FAQ */
    .faq-list { padding: 0 0.5rem; }
    .faq-question { font-size: 0.95rem; padding: 1rem; }
    
    /* CTA */
    .cta-buttons { flex-direction: column; gap: 1rem; }
    
    /* Footer */
    .footer-content { flex-direction: column; text-align: center; gap: 1.5rem; }
}

/* Small mobile: <= 480px */
@media (max-width: 480px) {
    .section-title { font-size: 1.2rem; }
    .hero-title { font-size: 1.6rem !important; }
    .stats-grid { grid-template-columns: 1fr; }
    .ddos-stats-dashboard { grid-template-columns: 1fr; }
    .showcase-tags .tag { font-size: 0.7rem; }
    .sticky-slide-tags .tag { font-size: 0.7rem; }
    .defense-layer { padding: 0.75rem; }
    .dl-num { font-size: 1.2rem; min-width: 40px; }
    .engine-box { padding: 1rem; min-width: 130px; }
    .action-card { padding: 0.8rem 1rem; min-width: 100px; }
    .pf-node { padding: 0.8rem 1.2rem; font-size: 0.9rem; }

    /* Force all wide grids to single column */
    .ai-features-grid,
    .engines-grid,
    .deploy-options,
    .ids-features,
    .ddos-features,
    .waf-rules-grid,
    .cdn-features {
        grid-template-columns: 1fr !important;
    }
}

/* AI Section */
.ai-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, transparent 0%, rgba(139, 92, 246, 0.05) 50%, transparent 100%);
}

.ai-features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
    gap: 2rem;
    max-width: 1200px;
    margin: 0 auto;
    perspective: 1000px;
}

.ai-feature-card {
    background: rgba(139, 92, 246, 0.1);
    border: 1px solid rgba(139, 92, 246, 0.3);
    border-radius: 16px;
    padding: 2rem;
    transition: all 0.4s ease;
    cursor: pointer;
    position: relative;
    overflow: hidden;
}

.ai-feature-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(139, 92, 246, 0.2), transparent);
    transition: left 0.5s ease;
}

.ai-feature-card:hover::before {
    left: 100%;
}

.ai-feature-card:hover {
    transform: translateY(-5px);
    border-color: #8b5cf6;
    box-shadow: 0 0 30px rgba(139, 92, 246, 0.3);
}

.ai-feature-icon {
    font-size: 3rem;
    margin-bottom: 1rem;
}

.ai-feature-title {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.25rem;
    color: #8b5cf6;
    margin-bottom: 0.5rem;
}

.ai-feature-desc {
    color: rgba(255, 255, 255, 0.7);
    font-size: 0.9rem;
    margin-bottom: 1rem;
}

.ai-feature-list {
    list-style: none;
    padding: 0;
    margin-bottom: 1rem;
}

.ai-feature-list li {
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.85rem;
    padding: 0.25rem 0;
    padding-left: 1.5rem;
    position: relative;
}

.ai-feature-list li::before {
    content: '✓';
    position: absolute;
    left: 0;
    color: #00ff88;
}

.view-more {
    color: #8b5cf6;
    font-size: 0.85rem;
    opacity: 0;
    transform: translateY(10px);
    transition: all 0.3s ease;
}

.ai-feature-card:hover .view-more {
    opacity: 1;
    transform: translateY(0);
}

/* CVE Section */
.cve-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, transparent 0%, rgba(0, 212, 255, 0.05) 50%, transparent 100%);
}

.cve-flow {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    align-items: center;
    gap: 1rem;
    max-width: 1200px;
    margin: 0 auto 3rem;
}

.cve-step {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    background: rgba(0, 212, 255, 0.1);
    border: 1px solid rgba(0, 212, 255, 0.3);
    border-radius: 12px;
    padding: 1rem 1.5rem;
    transition: all 0.3s ease;
}

.cve-step:hover {
    border-color: #00d4ff;
    box-shadow: 0 0 20px rgba(0, 212, 255, 0.3);
}

.cve-step-icon {
    font-size: 1.5rem;
}

.cve-step-content h4 {
    font-family: 'Orbitron', sans-serif;
    font-size: 0.9rem;
    color: #00d4ff;
    margin-bottom: 0.25rem;
}

.cve-step-content p {
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.75rem;
}

.cve-arrow {
    color: #00d4ff;
    font-size: 1.5rem;
    animation: pulse-arrow 1.5s ease-in-out infinite;
}

@keyframes pulse-arrow {
    0%, 100% { opacity: 0.5; transform: translateX(0); }
    50% { opacity: 1; transform: translateX(5px); }
}

.cve-info-box {
    max-width: 600px;
    margin: 0 auto;
    background: rgba(15, 15, 30, 0.8);
    border: 1px solid rgba(0, 212, 255, 0.3);
    border-radius: 12px;
    padding: 1.5rem;
    text-align: center;
}

.cve-info-box h4 {
    font-family: 'Orbitron', sans-serif;
    color: #00d4ff;
    margin-bottom: 1rem;
}

.cve-sources {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 0.75rem;
}

.cve-source {
    background: rgba(0, 212, 255, 0.2);
    border: 1px solid rgba(0, 212, 255, 0.4);
    padding: 0.5rem 1rem;
    border-radius: 50px;
    font-size: 0.85rem;
    color: #00d4ff;
    transition: all 0.3s ease;
}

.cve-source:hover {
    background: rgba(0, 212, 255, 0.3);
    transform: scale(1.05);
}

@media (max-width: 768px) {
    .cve-flow {
        flex-direction: column;
    }
    
    .cve-arrow {
        transform: rotate(90deg);
    }
    
    @keyframes pulse-arrow {
        0%, 100% { opacity: 0.5; transform: rotate(90deg) translateX(0); }
        50% { opacity: 1; transform: rotate(90deg) translateX(5px); }
    }
}

/* Product Showcase (Fixed Slideshow) */
.product-showcase {
    position: relative;
    z-index: 10;
}

.showcase-spacer {
    height: 400vh; /* 4 viewports of scroll distance */
}

.showcase-fixed-container {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(180deg, #0a0a0f 0%, #0f0f18 50%, #0a0a0f 100%);
    z-index: 100;
    transition: opacity 0.3s ease;
    pointer-events: none;
    overflow: hidden;
}

.showcase-slide {
    position: absolute;
    width: 100%;
    max-width: 100%;
    max-height: 90vh;
    padding: 1.5rem;
    text-align: center;
    opacity: 0;
    transform: translateY(30px) scale(0.95);
    transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1);
    pointer-events: none;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.showcase-slide.active {
    opacity: 1;
    transform: translateY(0) scale(1);
}

.showcase-image-wrapper {
    position: relative;
    margin: 1rem auto;
    width: 100%;
    max-width: 100%;
    max-height: 60vh;
    border-radius: 12px;
    overflow: hidden;
}

.showcase-image-wrapper img {
    width: 100%;
    height: auto;
    max-height: 60vh;
    object-fit: contain;
    display: block;
    border-radius: 12px;
    border: 1px solid rgba(0, 212, 255, 0.3);
}

.image-glow {
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    pointer-events: none;
}

.image-glow.blue {
    background: radial-gradient(circle at center, rgba(0, 212, 255, 0.15) 0%, transparent 50%);
}

.image-glow.purple {
    background: radial-gradient(circle at center, rgba(139, 92, 246, 0.15) 0%, transparent 50%);
}

.showcase-tags {
    display: flex;
    justify-content: center;
    gap: 1.5rem;
    margin-top: 1.5rem;
    flex-wrap: wrap;
}

.showcase-tags .tag {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.5rem 1rem;
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 50px;
    font-size: 0.875rem;
    color: rgba(255, 255, 255, 0.8);
}

.showcase-tags .dot {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    animation: pulse-dot 2s infinite;
}

.dot.red { background: #ff6b6b; box-shadow: 0 0 8px rgba(255, 107, 107, 0.5); }
.dot.blue { background: #00d4ff; box-shadow: 0 0 8px rgba(0, 212, 255, 0.5); }
.dot.green { background: #00ff88; box-shadow: 0 0 8px rgba(0, 255, 136, 0.5); }
.dot.orange { background: #ffaa00; box-shadow: 0 0 8px rgba(255, 170, 0, 0.5); }
.dot.cyan { background: #00ffff; box-shadow: 0 0 8px rgba(0, 255, 255, 0.5); }
.dot.pink { background: #ff6bff; box-shadow: 0 0 8px rgba(255, 107, 255, 0.5); }

@keyframes pulse-dot {
    0%, 100% { opacity: 1; transform: scale(1); }
    50% { opacity: 0.7; transform: scale(1.2); }
}

.slide-indicators {
    position: absolute;
    bottom: 1.5rem;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 0.75rem;
    z-index: 10;
}

.indicator {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.2);
    transition: all 0.3s ease;
}

.indicator.active {
    background: #00d4ff;
    box-shadow: 0 0 15px rgba(0, 212, 255, 0.5);
    transform: scale(1.2);
}

.slide-progress {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 3px;
    background: rgba(255, 255, 255, 0.1);
}

.progress-bar {
    height: 100%;
    background: linear-gradient(90deg, #00d4ff, #8b5cf6);
    transition: width 0.1s ease;
}

@media (max-width: 768px) {
    .showcase-tags {
        gap: 0.75rem;
    }
    
    .showcase-tags .tag {
        font-size: 0.75rem;
        padding: 0.375rem 0.75rem;
    }
}

.showcase-image-container {
    position: relative;
    max-width: 900px;
    width: 100%;
    margin: 2rem 0;
    border-radius: 16px;
    overflow: hidden;
    border: 1px solid rgba(0, 212, 255, 0.3);
    box-shadow: 
        0 0 60px rgba(0, 212, 255, 0.2),
        inset 0 0 60px rgba(0, 0, 0, 0.5);
}

.showcase-image {
    width: 100%;
    height: auto;
    display: block;
}

.showcase-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(
        135deg,
        rgba(0, 212, 255, 0.1) 0%,
        transparent 50%,
        rgba(139, 92, 246, 0.1) 100%
    );
    pointer-events: none;
}

.showcase-scanline {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
    background: linear-gradient(90deg, transparent, #00d4ff, transparent);
    animation: scanDown 3s linear infinite;
    pointer-events: none;
}

@keyframes scanDown {
    0% { top: 0; opacity: 1; }
    100% { top: 100%; opacity: 0; }
}

.showcase-features {
    display: flex;
    gap: 3rem;
    margin-top: 1rem;
}

.showcase-feature {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: rgba(255, 255, 255, 0.8);
    font-size: 0.9rem;
}

.feature-dot {
    width: 12px;
    height: 12px;
    border-radius: 50%;
    animation: pulse-dot 2s ease-in-out infinite;
}

.feature-dot.red {
    background: #ff6b6b;
    box-shadow: 0 0 10px rgba(255, 107, 107, 0.5);
}

.feature-dot.blue {
    background: #00d4ff;
    box-shadow: 0 0 10px rgba(0, 212, 255, 0.5);
    animation-delay: 0.3s;
}

.feature-dot.green {
    background: #00ff88;
    box-shadow: 0 0 10px rgba(0, 255, 136, 0.5);
    animation-delay: 0.6s;
}

@keyframes pulse-dot {
    0%, 100% { transform: scale(1); opacity: 1; }
    50% { transform: scale(1.3); opacity: 0.7; }
}

@media (max-width: 768px) {
    .showcase-features {
        flex-direction: column;
        gap: 1rem;
        align-items: center;
    }
}

/* Comparison Section */
.comparison-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, transparent 0%, rgba(0, 255, 136, 0.03) 50%, transparent 100%);
}

.comparison-table {
    max-width: 800px;
    margin: 0 auto;
    background: rgba(15, 15, 30, 0.8);
    border: 1px solid rgba(0, 255, 136, 0.3);
    border-radius: 16px;
    overflow: hidden;
}

.comparison-header {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr;
    background: rgba(0, 255, 136, 0.1);
    padding: 1rem;
    font-family: 'Orbitron', sans-serif;
    font-size: 0.9rem;
    color: #00ff88;
}

.comparison-row {
    display: grid;
    grid-template-columns: 2fr 1fr 1fr;
    padding: 1rem;
    border-top: 1px solid rgba(255, 255, 255, 0.05);
    transition: background 0.3s ease;
}

.comparison-row:hover {
    background: rgba(0, 255, 136, 0.05);
}

.comparison-feature {
    color: rgba(255, 255, 255, 0.8);
}

.comparison-traditional, .comparison-vito {
    text-align: center;
}

.check { color: #00ff88; }
.cross { color: #ff6b6b; }
.highlight { font-size: 1.25rem; text-shadow: 0 0 10px rgba(0, 255, 136, 0.5); }

/* Demo Timeline Section */
.demo-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
}

.demo-timeline {
    max-width: 800px;
    margin: 0 auto;
    position: relative;
}

.demo-timeline::before {
    content: '';
    position: absolute;
    left: 80px;
    top: 0;
    bottom: 0;
    width: 2px;
    background: linear-gradient(180deg, #ff6b6b, #ffaa00, #00d4ff, #00ff88);
}

.timeline-item {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    padding: 1.5rem 0;
    position: relative;
}

.timeline-time {
    width: 60px;
    font-family: 'Orbitron', sans-serif;
    font-size: 0.875rem;
    color: #00d4ff;
    text-align: right;
}

.timeline-dot {
    width: 16px;
    height: 16px;
    border-radius: 50%;
    position: relative;
    z-index: 1;
}

.timeline-dot.danger { background: #ff6b6b; box-shadow: 0 0 15px rgba(255, 107, 107, 0.5); }
.timeline-dot.warning { background: #ffaa00; box-shadow: 0 0 15px rgba(255, 170, 0, 0.5); }
.timeline-dot.info { background: #00d4ff; box-shadow: 0 0 15px rgba(0, 212, 255, 0.5); }
.timeline-dot.success { background: #00ff88; box-shadow: 0 0 15px rgba(0, 255, 136, 0.5); }

.timeline-content {
    flex: 1;
    background: rgba(15, 15, 30, 0.8);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    padding: 1rem 1.5rem;
}

.timeline-content h4 {
    font-family: 'Orbitron', sans-serif;
    color: #fff;
    margin-bottom: 0.25rem;
}

.timeline-content p {
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.875rem;
}

/* Deploy Section */
.deploy-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, transparent 0%, rgba(139, 92, 246, 0.03) 50%, transparent 100%);
}

.deploy-options {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 2rem;
    max-width: 1000px;
    margin: 0 auto;
}

.deploy-card {
    background: rgba(139, 92, 246, 0.1);
    border: 1px solid rgba(139, 92, 246, 0.3);
    border-radius: 16px;
    padding: 2rem;
    text-align: center;
    transition: all 0.3s ease;
}

.deploy-card:hover {
    transform: translateY(-5px);
    border-color: #8b5cf6;
    box-shadow: 0 0 30px rgba(139, 92, 246, 0.3);
}

.deploy-icon {
    font-size: 3rem;
    margin-bottom: 1rem;
}

.deploy-card h4 {
    font-family: 'Orbitron', sans-serif;
    color: #8b5cf6;
    margin-bottom: 0.5rem;
}

.deploy-card p {
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.875rem;
    margin-bottom: 1rem;
}

.deploy-card code {
    display: block;
    background: rgba(0, 0, 0, 0.3);
    border: 1px solid rgba(139, 92, 246, 0.3);
    border-radius: 8px;
    padding: 0.75rem;
    font-size: 0.8rem;
    color: #00d4ff;
    font-family: monospace;
}

/* FAQ Section */
.faq-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
}

.faq-list {
    max-width: 800px;
    margin: 0 auto;
}

.faq-item {
    background: rgba(15, 15, 30, 0.8);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 12px;
    margin-bottom: 1rem;
    overflow: hidden;
    cursor: pointer;
    transition: all 0.3s ease;
}

.faq-item:hover {
    border-color: #00d4ff;
}

.faq-question {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1.25rem 1.5rem;
    font-weight: 500;
    color: #fff;
}

.faq-toggle {
    font-size: 1.5rem;
    color: #00d4ff;
    transition: transform 0.3s ease;
}

.faq-answer {
    padding: 0 1.5rem 1.25rem;
    color: rgba(255, 255, 255, 0.7);
    line-height: 1.6;
    border-top: 1px solid rgba(255, 255, 255, 0.05);
}

.faq-enter-active, .faq-leave-active {
    transition: all 0.3s ease;
}

.faq-enter-from, .faq-leave-to {
    opacity: 0;
    max-height: 0;
    padding-top: 0;
    padding-bottom: 0;
}

/* CDN Section */
.cdn-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
}

.cdn-flow {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 1rem;
    margin-bottom: 3rem;
    flex-wrap: wrap;
}

.cdn-node {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
    padding: 1.5rem 2rem;
    background: rgba(255, 255, 255, 0.03);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 16px;
    transition: all 0.3s ease;
}

.cdn-node.highlight {
    background: linear-gradient(135deg, rgba(0, 212, 255, 0.15), rgba(139, 92, 246, 0.15));
    border-color: rgba(0, 212, 255, 0.3);
    box-shadow: 0 0 30px rgba(0, 212, 255, 0.1);
}

.cdn-icon {
    font-size: 2rem;
}

.cdn-node span {
    font-size: 0.85rem;
    color: rgba(255, 255, 255, 0.7);
}

.cdn-arrow {
    font-size: 1.5rem;
    color: var(--primary);
    animation: pulse 2s infinite;
}

.cdn-features {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1.5rem;
    max-width: 1000px;
    margin: 0 auto;
}

.cdn-feature-card {
    text-align: center;
    padding: 1.5rem;
    background: rgba(255, 255, 255, 0.03);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 16px;
    transition: all 0.3s ease;
}

.cdn-feature-card:hover {
    border-color: rgba(0, 212, 255, 0.3);
    transform: translateY(-4px);
}

.cdn-feature-icon {
    font-size: 2rem;
    display: block;
    margin-bottom: 0.75rem;
}

.cdn-feature-card h4 {
    color: white;
    margin-bottom: 0.5rem;
    font-size: 1rem;
}

.cdn-feature-card p {
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.85rem;
}

/* CDN Global Map */
.cdn-global-map {
    margin: 3rem auto;
    max-width: 900px;
    text-align: center;
}

.cdn-global-map h3 {
    font-size: 1.5rem;
    margin-bottom: 0.5rem;
}

.map-subtitle {
    color: rgba(255, 255, 255, 0.5);
    font-size: 0.9rem;
    margin-bottom: 2rem;
}

.world-map-container {
    padding: 1.5rem;
    background: rgba(0, 0, 0, 0.3);
    border: 1px solid rgba(255, 255, 255, 0.06);
    border-radius: 20px;
    margin-bottom: 2rem;
}

.world-map-img-wrapper {
    position: relative;
    width: 100%;
}

.world-map-img {
    width: 100%;
    height: auto;
    opacity: 0.35;
    display: block;
}

.map-lines-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
}

/* CDN Map Fixed Container */
.cdn-map-spacer {
    height: 250vh;
}

.cdn-map-fixed-container {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(180deg, #0a0a0f 0%, #0d0d1a 50%, #0a0a0f 100%);
    z-index: 100;
    transition: opacity 0.3s ease;
    padding: 2rem;
    overflow: hidden;
}

.cdn-map-fixed-container .cdn-global-map {
    max-width: 900px;
    width: 100%;
}

.cdn-reveal-counter {
    display: flex;
    align-items: baseline;
    justify-content: center;
    gap: 0.5rem;
    margin-top: 1.5rem;
    padding: 0.75rem 1.5rem;
    background: rgba(0, 212, 255, 0.06);
    border: 1px solid rgba(0, 212, 255, 0.15);
    border-radius: 20px;
    width: fit-content;
    margin-left: auto;
    margin-right: auto;
}

.crc-num {
    font-size: 1.8rem;
    font-weight: 900;
    font-family: 'Orbitron', sans-serif;
    color: #00d4ff;
    transition: all 0.3s ease;
}

.crc-sep {
    font-size: 1.2rem;
    color: rgba(255, 255, 255, 0.2);
}

.crc-total {
    font-size: 1.2rem;
    font-weight: 700;
    font-family: 'Orbitron', sans-serif;
    color: rgba(255, 255, 255, 0.4);
}

.crc-label {
    font-size: 0.8rem;
    color: rgba(255, 255, 255, 0.35);
    margin-left: 0.5rem;
}

/* Map Node Markers */
.map-node-marker {
    position: absolute;
    transform: translate(-50%, -50%);
    z-index: 2;
    opacity: 0;
    pointer-events: none;
    transition: opacity 0.5s ease, transform 0.5s cubic-bezier(0.16, 1, 0.3, 1);
}

.map-node-marker.revealed {
    opacity: 1;
    pointer-events: auto;
}

.map-node-marker.revealed .marker-label {
    opacity: 1;
    transform: translateX(-50%) translateY(0);
}

.map-node-marker.revealed .marker-pulse {
    animation: markerPulse 2s ease-in-out infinite;
}

.marker-dot {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background: #00f0ff;
    box-shadow: 0 0 8px #00f0ff, 0 0 20px rgba(0, 240, 255, 0.3);
    position: relative;
    z-index: 2;
}

.map-node-marker.primary .marker-dot {
    width: 12px;
    height: 12px;
    background: #00ff88;
    box-shadow: 0 0 10px #00ff88, 0 0 25px rgba(0, 255, 136, 0.4);
}

.marker-pulse {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 10px;
    height: 10px;
    border-radius: 50%;
    border: 2px solid #00f0ff;
    animation: none;
}

.map-node-marker.primary .marker-pulse {
    border-color: #00ff88;
}

@keyframes markerPulse {
    0% { width: 10px; height: 10px; opacity: 0.8; }
    100% { width: 35px; height: 35px; opacity: 0; }
}

.marker-label {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    top: -30px;
    display: flex;
    flex-direction: column;
    align-items: center;
    white-space: nowrap;
    pointer-events: none;
}

.marker-name {
    color: white;
    font-size: 0.7rem;
    font-weight: 600;
    text-shadow: 0 1px 4px rgba(0,0,0,0.8);
}

.marker-latency {
    color: rgba(0, 240, 255, 0.8);
    font-size: 0.6rem;
    font-family: monospace;
}

.map-node-marker.primary .marker-latency {
    color: rgba(0, 255, 136, 0.8);
}

/* WAF Test Section */
.waf-test-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, transparent, rgba(0, 212, 255, 0.03), transparent);
}

.waf-test-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 2rem;
    max-width: 1100px;
    margin: 2rem auto;
}

.waf-test-card {
    background: rgba(255, 255, 255, 0.03);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 20px;
    overflow: hidden;
    transition: all 0.3s ease;
}

.waf-test-card:hover {
    border-color: rgba(0, 212, 255, 0.3);
    transform: translateY(-4px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.waf-test-badge {
    padding: 0.75rem 1.5rem;
    font-weight: 600;
    font-size: 0.95rem;
}

.waf-test-badge.malicious {
    background: rgba(255, 71, 87, 0.1);
    color: #ff6b81;
    border-bottom: 1px solid rgba(255, 71, 87, 0.2);
}

.waf-test-badge.fp {
    background: rgba(0, 255, 136, 0.1);
    color: #00ff88;
    border-bottom: 1px solid rgba(0, 255, 136, 0.2);
}

.waf-test-img {
    width: 100%;
    height: auto;
    display: block;
}

.waf-test-stats {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1rem;
    padding: 1.25rem;
    border-top: 1px solid rgba(255, 255, 255, 0.06);
}

.waf-test-stat {
    text-align: center;
}

.waf-test-stat .stat-value {
    font-size: 1.5rem;
    font-weight: 800;
    display: block;
}

.waf-test-stat .stat-label {
    color: rgba(255, 255, 255, 0.5);
    font-size: 0.75rem;
}

@media (max-width: 768px) {
    .waf-test-grid {
        grid-template-columns: 1fr;
    }
}

/* WAF-Checker Detection Profile */
.waf-checker-profile {
    max-width: 1100px;
    margin: 2.5rem auto 0;
    padding: 2rem;
    background: rgba(255, 255, 255, 0.02);
    border: 1px solid rgba(0, 212, 255, 0.15);
    border-radius: 16px;
    position: relative;
    overflow: hidden;
}
.waf-checker-profile::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 2px;
    background: linear-gradient(90deg, transparent, #06b6d4, transparent);
}
.waf-checker-title {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.1rem;
    color: #06b6d4;
    margin-bottom: 1.5rem;
    text-align: center;
}
.waf-checker-features {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 0.75rem 2rem;
}
.waf-feature-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.6rem 1rem;
    background: rgba(255, 255, 255, 0.02);
    border: 1px solid rgba(255, 255, 255, 0.05);
    border-radius: 8px;
    transition: all 0.2s ease;
}
.waf-feature-item:hover {
    border-color: rgba(0, 212, 255, 0.2);
    background: rgba(0, 212, 255, 0.03);
}
.feature-check {
    font-size: 1rem;
    flex-shrink: 0;
}
.feature-text {
    font-size: 0.9rem;
    color: rgba(255, 255, 255, 0.85);
    font-family: 'JetBrains Mono', monospace;
}
@media (max-width: 768px) {
    .waf-checker-features {
        grid-template-columns: 1fr;
    }
}

/* Bypass Explanation */
.waf-bypass-explanation {
    max-width: 1100px;
    margin: 1.5rem auto 0;
    padding: 1.5rem 2rem;
    background: rgba(245, 158, 11, 0.03);
    border: 1px solid rgba(245, 158, 11, 0.15);
    border-radius: 12px;
    position: relative;
}
.bypass-title {
    font-family: 'Orbitron', sans-serif;
    font-size: 1rem;
    color: #f59e0b;
    margin-bottom: 0.5rem;
}
.bypass-desc {
    font-size: 0.85rem;
    color: rgba(255, 255, 255, 0.6);
    margin-bottom: 1.2rem;
    line-height: 1.5;
}
.bypass-items {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}
.bypass-item {
    display: flex;
    align-items: flex-start;
    gap: 0.75rem;
    padding: 0.6rem 0.8rem;
    background: rgba(255, 255, 255, 0.02);
    border: 1px solid rgba(255, 255, 255, 0.05);
    border-radius: 8px;
}
.bypass-num {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 24px;
    height: 24px;
    min-width: 24px;
    border-radius: 50%;
    background: rgba(245, 158, 11, 0.15);
    color: #f59e0b;
    font-size: 0.75rem;
    font-weight: 700;
    font-family: 'JetBrains Mono', monospace;
}
.bypass-content {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}
.bypass-header-name {
    font-family: 'JetBrains Mono', monospace;
    font-size: 0.85rem;
    color: #f59e0b;
    font-weight: 600;
}
.bypass-reason {
    font-size: 0.8rem;
    color: rgba(255, 255, 255, 0.55);
    line-height: 1.4;
}

/* Report Download Button */
.report-download-btn {
    display: inline-block;
    margin-top: 0.75rem;
    padding: 0.5rem 1.2rem;
    background: rgba(0, 255, 255, 0.06);
    border: 1px solid rgba(0, 255, 255, 0.2);
    border-radius: 8px;
    color: #00e5ff;
    font-size: 0.8rem;
    font-family: 'JetBrains Mono', monospace;
    text-decoration: none;
    transition: all 0.2s ease;
    cursor: pointer;
}
.report-download-btn:hover {
    background: rgba(0, 255, 255, 0.12);
    border-color: rgba(0, 255, 255, 0.4);
    transform: translateY(-1px);
}

/* Category Analysis */
.waf-category-analysis {
    max-width: 1200px;
    margin: 2rem auto 0;
}
.category-analysis-title {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.1rem;
    color: #00e5ff;
    margin-bottom: 1.2rem;
    text-align: center;
}
.category-tables-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1.5rem;
}
.category-table-card {
    background: rgba(255, 255, 255, 0.02);
    border: 1px solid rgba(255, 255, 255, 0.06);
    border-radius: 12px;
    overflow: hidden;
}
.table-card-title {
    padding: 0.75rem 1rem;
    font-family: 'Orbitron', sans-serif;
    font-size: 0.85rem;
    margin: 0;
}
.table-card-title.malicious {
    background: rgba(0, 255, 255, 0.04);
    color: #00e5ff;
    border-bottom: 1px solid rgba(0, 255, 255, 0.1);
}
.table-card-title.fp {
    background: rgba(16, 185, 129, 0.04);
    color: #10b981;
    border-bottom: 1px solid rgba(16, 185, 129, 0.1);
}
.category-table-wrap {
    max-height: 500px;
    overflow-y: auto;
    scrollbar-width: thin;
    scrollbar-color: rgba(255,255,255,0.1) transparent;
}
.category-table {
    width: 100%;
    border-collapse: collapse;
    font-size: 0.78rem;
}
.category-table thead {
    position: sticky;
    top: 0;
    z-index: 1;
}
.category-table th {
    padding: 0.5rem 0.75rem;
    background: rgba(0, 0, 0, 0.5);
    color: rgba(255, 255, 255, 0.5);
    font-weight: 600;
    text-transform: uppercase;
    font-size: 0.65rem;
    letter-spacing: 0.05em;
    text-align: left;
    border-bottom: 1px solid rgba(255, 255, 255, 0.06);
}
.category-table td {
    padding: 0.45rem 0.75rem;
    border-bottom: 1px solid rgba(255, 255, 255, 0.03);
    color: rgba(255, 255, 255, 0.75);
}
.category-table tbody tr:hover {
    background: rgba(255, 255, 255, 0.02);
}
.severity {
    display: inline-block;
    padding: 0.15rem 0.5rem;
    border-radius: 4px;
    font-size: 0.7rem;
    font-weight: 600;
}
.severity.low {
    background: rgba(16, 185, 129, 0.15);
    color: #10b981;
}
.severity.medium {
    background: rgba(245, 158, 11, 0.15);
    color: #f59e0b;
}
.severity.high {
    background: rgba(239, 68, 68, 0.15);
    color: #ef4444;
}
.bypass-rate.safe {
    color: #10b981;
    font-weight: 600;
    font-family: 'JetBrains Mono', monospace;
}
.bypass-rate.warn {
    color: #f59e0b;
    font-weight: 700;
    font-family: 'JetBrains Mono', monospace;
}
.report-timestamp {
    text-align: center;
    font-size: 0.75rem;
    color: rgba(255, 255, 255, 0.35);
    margin-top: 1rem;
    font-style: italic;
}

@media (max-width: 768px) {
    .category-tables-grid {
        grid-template-columns: 1fr;
    }
    .category-table-wrap {
        max-height: 350px;
    }
}

.node-glow-circle {
    animation: pulse 3s ease-in-out infinite;
}

/* CDN Nodes List */
.cdn-nodes-list {
    display: flex;
    flex-wrap: wrap;
    gap: 0.75rem;
    justify-content: center;
    margin-bottom: 2rem;
}

.cdn-node-badge {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.4rem 1rem;
    background: rgba(255, 255, 255, 0.04);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 20px;
    font-size: 0.8rem;
    transition: all 0.3s ease;
}

.cdn-node-badge:hover {
    border-color: rgba(0, 212, 255, 0.3);
    transform: translateY(-2px);
}

.cdn-node-badge.primary {
    border-color: rgba(0, 255, 136, 0.3);
    background: rgba(0, 255, 136, 0.08);
}

.cdn-node-badge .node-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: #00f0ff;
    box-shadow: 0 0 6px #00f0ff;
}

.cdn-node-badge.primary .node-dot {
    background: #00ff88;
    box-shadow: 0 0 6px #00ff88;
}

.cdn-node-badge .node-name {
    color: rgba(255, 255, 255, 0.8);
}

.cdn-node-badge .node-latency-badge {
    color: rgba(255, 255, 255, 0.5);
    font-size: 0.7rem;
}

/* CDN Stats Banner */
.cdn-stats-banner {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 1.5rem;
    max-width: 800px;
    margin: 2rem auto 3rem;
}

.cdn-stat {
    text-align: center;
    padding: 1.5rem 1rem;
    background: rgba(0, 212, 255, 0.05);
    border: 1px solid rgba(0, 212, 255, 0.15);
    border-radius: 16px;
    transition: all 0.3s ease;
}

.cdn-stat:hover {
    border-color: rgba(0, 212, 255, 0.4);
    transform: translateY(-4px);
    box-shadow: 0 8px 25px rgba(0, 212, 255, 0.15);
}

.cdn-stat-value {
    font-size: 2rem;
    font-weight: 800;
    line-height: 1;
    margin-bottom: 0.5rem;
}

.cdn-stat-value .unit {
    font-size: 1rem;
    font-weight: 600;
}

.cdn-stat-label {
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.85rem;
}

/* DDoS Section */
.ddos-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, transparent, rgba(139, 92, 246, 0.05), transparent);
}

/* DDoS Stats Dashboard */
.ddos-stats-dashboard {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 1.5rem;
    max-width: 900px;
    margin: 2rem auto 3rem;
}

.ddos-stat-card {
    text-align: center;
    padding: 1.5rem 1rem;
    background: rgba(139, 92, 246, 0.08);
    border: 1px solid rgba(139, 92, 246, 0.2);
    border-radius: 16px;
    transition: all 0.3s ease;
}

.ddos-stat-card:hover {
    border-color: rgba(139, 92, 246, 0.5);
    transform: translateY(-4px);
    box-shadow: 0 8px 25px rgba(139, 92, 246, 0.15);
}

.ddos-stat-value {
    font-size: 2rem;
    font-weight: 800;
    line-height: 1;
    margin-bottom: 0.5rem;
}

.ddos-stat-value .unit {
    font-size: 1rem;
    font-weight: 600;
}

.ddos-stat-label {
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.85rem;
}

/* DDoS Traffic Visualization */
.ddos-traffic-visual {
    max-width: 750px;
    margin: 0 auto 3rem;
    padding: 2rem;
    background: rgba(0, 0, 0, 0.3);
    border: 1px solid rgba(255, 255, 255, 0.06);
    border-radius: 20px;
}

.traffic-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1.5rem;
}

.traffic-label {
    color: white;
    font-weight: 600;
    font-size: 1rem;
}

.traffic-status {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: #00ff88;
    font-size: 0.85rem;
}

.status-dot.active {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: #00ff88;
    box-shadow: 0 0 8px #00ff88;
    animation: pulse 2s ease-in-out infinite;
}

.traffic-bars {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.traffic-row {
    display: grid;
    grid-template-columns: 130px 1fr 80px;
    align-items: center;
    gap: 1rem;
}

.traffic-type {
    color: rgba(255, 255, 255, 0.7);
    font-size: 0.85rem;
    font-family: monospace;
}

.traffic-bar-bg {
    height: 20px;
    background: rgba(255, 255, 255, 0.05);
    border-radius: 10px;
    overflow: hidden;
    position: relative;
}

.traffic-bar-fill {
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
    border-radius: 10px;
    animation: barGrow 1.5s ease-out forwards;
    transform-origin: left;
}

.traffic-bar-fill.malicious {
    background: linear-gradient(90deg, #ff4757, #ff6b81);
    z-index: 1;
    opacity: 0.4;
}

.traffic-bar-fill.clean {
    background: linear-gradient(90deg, #00ff88, #00d4ff);
    z-index: 2;
}

@keyframes barGrow {
    from { transform: scaleX(0); }
    to { transform: scaleX(1); }
}

.traffic-percent {
    color: #00ff88;
    font-size: 0.8rem;
    font-weight: 600;
    text-align: right;
    font-family: monospace;
}

.traffic-legend {
    display: flex;
    gap: 2rem;
    justify-content: center;
    margin-top: 1.5rem;
    font-size: 0.8rem;
    color: rgba(255, 255, 255, 0.6);
}

.legend-dot {
    display: inline-block;
    width: 10px;
    height: 10px;
    border-radius: 50%;
    margin-right: 0.4rem;
    vertical-align: middle;
}

.legend-dot.malicious {
    background: #ff4757;
}

.legend-dot.clean {
    background: #00ff88;
}

.ddos-layers-title {
    text-align: center;
    font-size: 1.3rem;
    margin-bottom: 1.5rem;
}

@media (max-width: 768px) {
    .cdn-stats-banner,
    .ddos-stats-dashboard {
        grid-template-columns: repeat(2, 1fr);
    }
    
    .traffic-row {
        grid-template-columns: 100px 1fr 60px;
    }
}

.ddos-layers {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    max-width: 700px;
    margin: 0 auto;
}

.ddos-layer {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    padding: 1.25rem 2rem;
    background: rgba(255, 255, 255, 0.03);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 16px;
    transition: all 0.3s ease;
}

.ddos-layer:hover {
    border-color: rgba(139, 92, 246, 0.4);
    transform: translateX(8px);
}

.layer-shield {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    background: linear-gradient(135deg, rgba(139, 92, 246, 0.3), rgba(0, 212, 255, 0.3));
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
}

.layer-num {
    font-weight: 700;
    font-size: 0.85rem;
    color: white;
}

.layer-info h4 {
    color: white;
    margin-bottom: 0.25rem;
    font-size: 1rem;
}

.layer-info p {
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.85rem;
}

/* GeoIP Section */
.geoip-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
}

.geoip-features {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1.5rem;
    max-width: 1000px;
    margin: 0 auto;
}

.geoip-card {
    text-align: center;
    padding: 2rem 1.5rem;
    background: rgba(255, 255, 255, 0.03);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 16px;
    transition: all 0.3s ease;
}

.geoip-card:hover {
    border-color: rgba(0, 255, 136, 0.3);
    transform: translateY(-4px);
    box-shadow: 0 10px 30px rgba(0, 255, 136, 0.1);
}

.geoip-icon {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.geoip-card h4 {
    color: white;
    margin-bottom: 0.5rem;
    font-size: 1rem;
}

.geoip-card p {
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.85rem;
}

/* Multi-Node Section */
.multinode-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, transparent, rgba(0, 212, 255, 0.05), transparent);
}

.node-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 1.5rem;
    max-width: 900px;
    margin: 0 auto;
}

.node-card {
    text-align: center;
    padding: 2rem 1.5rem;
    background: rgba(255, 255, 255, 0.03);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 16px;
    position: relative;
    transition: all 0.3s ease;
}

.node-card:hover {
    transform: translateY(-4px);
}

.node-card.healthy {
    border-color: rgba(0, 255, 136, 0.2);
}

.node-card.healthy:hover {
    border-color: rgba(0, 255, 136, 0.4);
    box-shadow: 0 0 20px rgba(0, 255, 136, 0.1);
}

.node-card.warning {
    border-color: rgba(255, 214, 0, 0.2);
}

.node-card.warning:hover {
    border-color: rgba(255, 214, 0, 0.4);
}

.node-status-dot {
    position: absolute;
    top: 12px;
    right: 12px;
    width: 10px;
    height: 10px;
    border-radius: 50%;
    animation: pulse 2s ease-in-out infinite;
}

.node-card.healthy .node-status-dot {
    background: #00ff88;
    box-shadow: 0 0 8px #00ff88;
}

.node-card.warning .node-status-dot {
    background: #ffd600;
    box-shadow: 0 0 8px #ffd600;
}

.node-icon {
    font-size: 2rem;
    margin-bottom: 0.75rem;
}

.node-card h4 {
    color: white;
    font-size: 1.1rem;
    margin-bottom: 0.25rem;
}

.node-region {
    display: block;
    color: rgba(255, 255, 255, 0.5);
    font-size: 0.8rem;
    margin-bottom: 0.5rem;
}

.node-latency {
    display: inline-block;
    padding: 0.2rem 0.6rem;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
}

.node-card.healthy .node-latency {
    background: rgba(0, 255, 136, 0.15);
    color: #00ff88;
}

.node-card.warning .node-latency {
    background: rgba(255, 214, 0, 0.15);
    color: #ffd600;
}

/* Security Engines Section */
.security-engines-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
}

.engines-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
    max-width: 900px;
    margin: 0 auto;
}

.engine-highlight-card {
    padding: 2.5rem 2rem;
    background: rgba(255, 255, 255, 0.03);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 20px;
    transition: all 0.3s ease;
}

.engine-highlight-card:hover {
    border-color: rgba(0, 212, 255, 0.3);
    transform: translateY(-4px);
    box-shadow: 0 10px 30px rgba(0, 212, 255, 0.1);
}

.engine-badge {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.engine-highlight-card h3 {
    color: white;
    font-size: 1.3rem;
    margin-bottom: 0.75rem;
}

.engine-highlight-card > p {
    color: rgba(255, 255, 255, 0.6);
    font-size: 0.9rem;
    margin-bottom: 1.5rem;
}

.engine-highlight-card ul {
    list-style: none;
    padding: 0;
    display: flex;
    flex-direction: column;
    gap: 0.6rem;
}

.engine-highlight-card li {
    color: rgba(255, 255, 255, 0.7);
    font-size: 0.85rem;
    padding: 0.4rem 0;
    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
}

/* RBAC Section */
.rbac-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, transparent, rgba(139, 92, 246, 0.05), transparent);
}

.rbac-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 4rem;
    max-width: 1000px;
    margin: 0 auto;
    align-items: center;
}

.rbac-section .section-lead {
    color: rgba(255, 255, 255, 0.7);
    margin-bottom: 1.5rem;
    font-size: 1.1rem;
}

.rbac-features {
    list-style: none;
    padding: 0;
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.rbac-features li {
    color: rgba(255, 255, 255, 0.8);
    font-size: 0.95rem;
}

.rbac-diagram {
    display: flex;
    flex-direction: column;
    gap: 1rem;
    align-items: center;
}

.rbac-role {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 1rem 2rem;
    border-radius: 16px;
    width: 100%;
    max-width: 240px;
    transition: all 0.3s ease;
}

.rbac-role:hover {
    transform: translateX(8px);
}

.rbac-role.admin {
    background: linear-gradient(135deg, rgba(255, 215, 0, 0.15), rgba(255, 165, 0, 0.15));
    border: 1px solid rgba(255, 215, 0, 0.3);
}

.rbac-role.operator {
    background: linear-gradient(135deg, rgba(0, 212, 255, 0.15), rgba(139, 92, 246, 0.15));
    border: 1px solid rgba(0, 212, 255, 0.3);
}

.rbac-role.viewer {
    background: linear-gradient(135deg, rgba(0, 255, 136, 0.1), rgba(0, 212, 255, 0.1));
    border: 1px solid rgba(0, 255, 136, 0.2);
}

.role-icon {
    font-size: 1.5rem;
}

.role-name {
    color: white;
    font-weight: 600;
    font-size: 0.95rem;
}

@media (max-width: 768px) {
    .rbac-container {
        grid-template-columns: 1fr;
        gap: 2rem;
    }
    
    .cdn-flow {
        flex-direction: column;
    }
    
    .cdn-arrow {
        transform: rotate(90deg);
    }
    
    .engines-grid {
        grid-template-columns: 1fr;
    }
}

/* CTA Section */
.cta-section {
    padding: 8rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, transparent, rgba(0, 212, 255, 0.1), transparent);
}

.cta-content {
    text-align: center;
    max-width: 600px;
    margin: 0 auto;
}

.cta-content h2 {
    font-family: 'Orbitron', sans-serif;
    font-size: clamp(1.5rem, 4vw, 2.5rem);
    margin-bottom: 1rem;
}

.cta-content p {
    color: rgba(255, 255, 255, 0.7);
    margin-bottom: 2rem;
}

@media (max-width: 768px) {
    .comparison-header, .comparison-row {
        grid-template-columns: 1.5fr 1fr 1fr;
        font-size: 0.8rem;
    }
    
    .demo-timeline::before {
        left: 50px;
    }
    
    .timeline-time {
        width: 40px;
        font-size: 0.75rem;
    }
}

/* Load Balancer Section */
.lb-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, rgba(0, 212, 255, 0.03) 0%, rgba(0, 255, 136, 0.03) 100%);
}

.lb-diagram {
    max-width: 900px;
    margin: 3rem auto;
    padding: 2rem;
    background: rgba(15, 15, 30, 0.8);
    border: 1px solid rgba(0, 212, 255, 0.3);
    border-radius: 16px;
    overflow: hidden;
}

.lb-flow-container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 0;
}

.lb-source, .lb-waf-node {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.5rem;
}

.lb-icon-box {
    width: 60px;
    height: 60px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.75rem;
}

.lb-icon-box.users {
    background: linear-gradient(135deg, #8b5cf6, #6366f1);
    box-shadow: 0 0 25px rgba(139, 92, 246, 0.4);
}

.lb-icon-box.waf {
    background: linear-gradient(135deg, #00d4ff, #0099cc);
    box-shadow: 0 0 25px rgba(0, 212, 255, 0.4);
    animation: pulse-waf 2s ease-in-out infinite;
}

@keyframes pulse-waf {
    0%, 100% { box-shadow: 0 0 25px rgba(0, 212, 255, 0.4); }
    50% { box-shadow: 0 0 40px rgba(0, 212, 255, 0.6); }
}

.lb-label {
    font-size: 0.75rem;
    color: rgba(255, 255, 255, 0.7);
    text-transform: uppercase;
    letter-spacing: 1px;
}

.lb-badge {
    font-size: 0.65rem;
    padding: 0.2rem 0.6rem;
    background: rgba(0, 212, 255, 0.2);
    border: 1px solid rgba(0, 212, 255, 0.4);
    border-radius: 20px;
    color: #00d4ff;
}

.lb-flow-lines, .lb-dist-lines {
    width: 150px;
    height: 140px;
    flex-shrink: 0;
}

.lb-servers {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.lb-server {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    padding: 0.75rem 1rem;
    background: rgba(17, 24, 39, 0.95);
    border: 1px solid rgba(0, 255, 136, 0.3);
    border-radius: 10px;
    min-width: 140px;
}

.lb-server.healthy .server-status {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background: #00ff88;
    box-shadow: 0 0 10px #00ff88;
    animation: status-pulse 1.5s infinite;
}

@keyframes status-pulse {
    0%, 100% { box-shadow: 0 0 10px #00ff88; }
    50% { box-shadow: 0 0 20px #00ff88; }
}

.lb-server.failed {
    border-color: rgba(239, 68, 68, 0.5);
    opacity: 0.6;
}

.lb-server.failed .server-status {
    width: 10px;
    height: 10px;
    border-radius: 50%;
    background: #ef4444;
    animation: status-blink 1s infinite;
}

@keyframes status-blink {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.3; }
}

.server-icon {
    font-size: 1.25rem;
}

.server-label {
    flex: 1;
    font-size: 0.75rem;
    color: #e5e7eb;
}

.server-weight {
    font-size: 0.8rem;
    font-weight: 700;
    color: #00d4ff;
}

.lb-server.failed .server-weight {
    color: #ef4444;
}

/* LB Features Cards */
.lb-features {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1.5rem;
    max-width: 1000px;
    margin: 0 auto 3rem;
}

.lb-feature-card {
    background: rgba(15, 15, 30, 0.8);
    border: 1px solid rgba(0, 212, 255, 0.2);
    border-radius: 12px;
    padding: 1.5rem;
    text-align: center;
    transition: all 0.3s ease;
}

.lb-feature-card:hover {
    border-color: #00d4ff;
    transform: translateY(-5px);
    box-shadow: 0 0 30px rgba(0, 212, 255, 0.2);
}

.lb-feature-icon {
    font-size: 2rem;
    display: block;
    margin-bottom: 0.75rem;
}

.lb-feature-card h4 {
    font-family: 'Orbitron', sans-serif;
    color: #00d4ff;
    font-size: 0.95rem;
    margin-bottom: 0.5rem;
}

.lb-feature-card p {
    font-size: 0.8rem;
    color: rgba(255, 255, 255, 0.6);
    line-height: 1.5;
}

/* LB Strategies */
.lb-strategies {
    max-width: 800px;
    margin: 0 auto;
    text-align: center;
}

.lb-strategies h3 {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.1rem;
    margin-bottom: 1.5rem;
}

.strategy-list {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
}

.strategy-item {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 1rem;
    background: rgba(0, 255, 136, 0.05);
    border: 1px solid rgba(0, 255, 136, 0.2);
    border-radius: 10px;
    text-align: left;
    transition: all 0.3s ease;
}

.strategy-item:hover {
    border-color: #00ff88;
    background: rgba(0, 255, 136, 0.1);
}

.strategy-icon {
    font-size: 1.5rem;
}

.strategy-info {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}

.strategy-name {
    font-weight: 600;
    color: #00ff88;
    font-size: 0.85rem;
}

.strategy-desc {
    font-size: 0.75rem;
    color: rgba(255, 255, 255, 0.6);
}

@media (max-width: 768px) {
    .lb-flow-container {
        flex-direction: column;
        gap: 1rem;
    }
    
    .lb-flow-lines, .lb-dist-lines {
        width: 160px;
        height: 60px;
        transform: rotate(90deg);
    }
    
    .lb-servers {
        flex-direction: row;
        flex-wrap: wrap;
        justify-content: center;
    }
    
    .lb-server {
        min-width: 120px;
    }
}

/* Core Attack Protection Section */
.attack-protection-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    text-align: center;
    background: linear-gradient(180deg, transparent 0%, rgba(255, 107, 107, 0.03) 50%, transparent 100%);
}

.waf-rules-container {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 2rem;
    max-width: 1200px;
    margin: 0 auto;
}

.waf-category {
    background: rgba(15, 15, 30, 0.8);
    border: 1px solid rgba(255, 107, 107, 0.2);
    border-radius: 16px;
    overflow: hidden;
    transition: all 0.3s ease;
    text-align: left;
}

.waf-category:hover {
    border-color: rgba(255, 107, 107, 0.5);
    box-shadow: 0 0 30px rgba(255, 107, 107, 0.1);
}

.waf-category-header {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.75rem;
    padding: 1.25rem 1.5rem;
    background: rgba(255, 107, 107, 0.1);
    border-bottom: 1px solid rgba(255, 107, 107, 0.15);
}

.waf-category-header .cat-icon {
    font-size: 1.5rem;
}

.waf-category-header h3 {
    font-family: 'Inter', sans-serif;
    font-size: 1.05rem;
    font-weight: 700;
    color: #ff6b6b;
    margin: 0;
}

.waf-rules-list {
    padding: 0.5rem;
}

.waf-rule-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0.85rem 1rem;
    border-radius: 10px;
    transition: background 0.2s ease;
}

.waf-rule-item:hover {
    background: rgba(255, 255, 255, 0.03);
}

.rule-info {
    flex: 1;
    min-width: 0;
}

.rule-title-row {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 0.25rem;
}

.rule-name {
    font-size: 0.9rem;
    font-weight: 600;
    color: rgba(255, 255, 255, 0.95);
}

.rule-severity {
    font-size: 0.6rem;
    font-weight: 700;
    letter-spacing: 0.5px;
    padding: 0.15rem 0.5rem;
    border-radius: 50px;
    text-transform: uppercase;
}

.rule-severity.high {
    background: rgba(255, 59, 48, 0.2);
    color: #ff3b30;
    border: 1px solid rgba(255, 59, 48, 0.3);
}

.rule-desc {
    font-size: 0.75rem;
    color: rgba(255, 255, 255, 0.45);
    margin: 0;
    line-height: 1.4;
}

.rule-levels {
    display: flex;
    gap: 0.3rem;
    flex-shrink: 0;
    margin-left: 1rem;
}

.level-btn {
    font-size: 0.6rem;
    font-weight: 700;
    letter-spacing: 0.3px;
    padding: 0.3rem 0.55rem;
    border-radius: 6px;
    background: rgba(255, 255, 255, 0.05);
    color: rgba(255, 255, 255, 0.25);
    border: 1px solid rgba(255, 255, 255, 0.08);
    transition: all 0.2s ease;
}

.level-btn.inactive {
    opacity: 0.6;
}

.level-btn.active.high {
    background: rgba(0, 212, 255, 0.15);
    color: #00d4ff;
    border-color: rgba(0, 212, 255, 0.4);
    box-shadow: 0 0 10px rgba(0, 212, 255, 0.15);
}

@media (max-width: 768px) {
    .waf-rules-container {
        grid-template-columns: 1fr;
    }
    
    .waf-rule-item {
        flex-direction: column;
        align-items: flex-start;
        gap: 0.5rem;
    }
    
    .rule-levels {
        margin-left: 0;
    }
}

/* IDS/IPS Section */
.ids-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, transparent 0%, rgba(139, 92, 246, 0.05) 50%, transparent 100%);
}

.ids-architecture {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 2rem;
    max-width: 900px;
    margin: 0 auto 4rem;
    flex-wrap: wrap;
}

.ids-hub {
    text-align: center;
    padding: 2rem;
    background: rgba(139, 92, 246, 0.15);
    border: 2px solid rgba(139, 92, 246, 0.5);
    border-radius: 16px;
    min-width: 150px;
}

.hub-icon {
    font-size: 3rem;
    margin-bottom: 0.5rem;
}

.hub-label {
    display: block;
    font-family: 'Orbitron', sans-serif;
    font-size: 1rem;
    color: #8b5cf6;
    margin-bottom: 0.25rem;
}

.hub-desc {
    font-size: 0.75rem;
    color: rgba(255, 255, 255, 0.5);
}

.ids-connections {
    flex: 1;
    max-width: 200px;
    height: 100px;
}

.ids-connections svg {
    width: 100%;
    height: 100%;
}

.conn-path {
    stroke-dasharray: 5 5;
    animation: dash-flow 1s linear infinite;
}

@keyframes dash-flow {
    to { stroke-dashoffset: -10; }
}

.ids-agents {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.agent-node {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding: 0.75rem 1.25rem;
    background: rgba(0, 212, 255, 0.1);
    border: 1px solid rgba(0, 212, 255, 0.3);
    border-radius: 8px;
}

.agent-icon {
    font-size: 1.5rem;
}

.agent-label {
    font-size: 0.85rem;
    color: #00d4ff;
}

.ids-engines {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
    max-width: 1200px;
    margin: 0 auto;
}

.engine-card {
    background: rgba(15, 15, 30, 0.8);
    border: 1px solid rgba(139, 92, 246, 0.3);
    border-radius: 12px;
    padding: 1.5rem;
    transition: all 0.3s ease;
}

.engine-card:hover {
    border-color: #8b5cf6;
    box-shadow: 0 0 30px rgba(139, 92, 246, 0.2);
}

.engine-icon {
    font-size: 2rem;
    margin-bottom: 1rem;
}

.engine-card h4 {
    font-family: 'Orbitron', sans-serif;
    font-size: 1rem;
    color: #8b5cf6;
    margin-bottom: 0.5rem;
}

.engine-card p {
    font-size: 0.85rem;
    color: rgba(255, 255, 255, 0.6);
    margin-bottom: 1rem;
}

.engine-card ul {
    list-style: none;
    padding: 0;
}

.engine-card li {
    font-size: 0.8rem;
    color: rgba(255, 255, 255, 0.5);
    padding: 0.25rem 0;
    padding-left: 1.25rem;
    position: relative;
}

.engine-card li::before {
    content: '✓';
    position: absolute;
    left: 0;
    color: #00ff88;
}

/* Traffic Control Section */
.traffic-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, transparent 0%, rgba(0, 212, 255, 0.03) 50%, transparent 100%);
}

.traffic-features {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1.5rem;
    max-width: 1100px;
    margin: 0 auto;
}

.traffic-card {
    background: rgba(0, 212, 255, 0.1);
    border: 1px solid rgba(0, 212, 255, 0.3);
    border-radius: 12px;
    padding: 1.5rem;
    text-align: center;
    transition: all 0.3s ease;
}

.traffic-card:hover {
    transform: translateY(-5px);
    border-color: #00d4ff;
    box-shadow: 0 0 30px rgba(0, 212, 255, 0.2);
}

.traffic-icon {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.traffic-card h4 {
    font-family: 'Orbitron', sans-serif;
    font-size: 1rem;
    color: #00d4ff;
    margin-bottom: 0.5rem;
}

.traffic-card p {
    font-size: 0.85rem;
    color: rgba(255, 255, 255, 0.6);
}

/* Rules Management Section */
.rules-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, transparent 0%, rgba(0, 255, 136, 0.03) 50%, transparent 100%);
}

.rules-flow {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 1.5rem;
    max-width: 1000px;
    margin: 0 auto;
}

.rule-type {
    flex: 1;
    min-width: 200px;
    max-width: 240px;
    background: rgba(0, 255, 136, 0.1);
    border: 1px solid rgba(0, 255, 136, 0.3);
    border-radius: 12px;
    padding: 1.5rem;
    text-align: center;
    transition: all 0.3s ease;
}

.rule-type:hover {
    transform: translateY(-5px);
    border-color: #00ff88;
    box-shadow: 0 0 30px rgba(0, 255, 136, 0.2);
}

.rule-icon {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.rule-type h4 {
    font-family: 'Orbitron', sans-serif;
    font-size: 1rem;
    color: #00ff88;
    margin-bottom: 0.5rem;
}

.rule-type p {
    font-size: 0.85rem;
    color: rgba(255, 255, 255, 0.6);
}

/* SOC Command Center Section */
.soc-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: radial-gradient(circle at center, rgba(15, 23, 42, 0.8) 0%, #000 100%);
    overflow: hidden;
}

.soc-3d-wrapper {
    max-width: 1200px;
    margin: 2rem auto 0;
    border-radius: 1rem;
    overflow: hidden;
}

.soc-bg-grid {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: 
        linear-gradient(rgba(0, 212, 255, 0.05) 1px, transparent 1px),
        linear-gradient(90deg, rgba(0, 212, 255, 0.05) 1px, transparent 1px);
    background-size: 40px 40px;
    z-index: 0;
    transform: perspective(500px) rotateX(20deg) scale(1.5);
    opacity: 0.3;
}

.soc-dashboard {
    max-width: 1100px;
    margin: 0 auto;
    perspective: 1200px;
}

.soc-screen {
    background: rgba(8, 10, 20, 0.95);
    border: 1px solid rgba(0, 212, 255, 0.3);
    border-radius: 4px;
    padding: 1.5rem;
    position: relative;
    box-shadow: 
        0 0 50px rgba(0, 212, 255, 0.1),
        inset 0 0 100px rgba(0, 0, 0, 0.8);
    transform: rotateX(5deg);
    transition: transform 0.5s ease;
    backdrop-filter: blur(10px);
}

.soc-screen:hover {
    transform: rotateX(0deg);
}

/* Decorations */
.screen-overlay {
    position: absolute;
    top: 0; left: 0; width: 100%; height: 100%;
    background: linear-gradient(rgba(18, 16, 16, 0) 50%, rgba(0, 0, 0, 0.25) 50%), linear-gradient(90deg, rgba(255, 0, 0, 0.06), rgba(0, 255, 0, 0.02), rgba(0, 0, 255, 0.06));
    background-size: 100% 2px, 3px 100%;
    z-index: 10;
    pointer-events: none;
    opacity: 0.4;
}

.corner-decor {
    position: absolute;
    width: 20px;
    height: 20px;
    border: 2px solid #00d4ff;
    z-index: 5;
    transition: all 0.3s ease;
}

.top-left { top: -2px; left: -2px; border-right: none; border-bottom: none; }
.top-right { top: -2px; right: -2px; border-left: none; border-bottom: none; }
.bottom-left { bottom: -2px; left: -2px; border-right: none; border-top: none; }
.bottom-right { bottom: -2px; right: -2px; border-left: none; border-top: none; }

.soc-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid rgba(0, 212, 255, 0.2);
    padding-bottom: 0.5rem;
    margin-bottom: 1.5rem;
}

.status-indicator {
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.status-dot {
    width: 8px;
    height: 8px;
    background: #00ff88;
    border-radius: 50%;
    box-shadow: 0 0 10px #00ff88;
    animation: blink-fast 1s infinite;
}

.status-text {
    font-family: 'Orbitron', monospace;
    font-size: 0.9rem;
    color: #00ff88;
    letter-spacing: 1px;
}

.status-ping {
    font-family: monospace;
    font-size: 0.8rem;
    color: rgba(0, 212, 255, 0.7);
    margin-left: 1rem;
}

.soc-server-id {
    font-family: monospace;
    color: rgba(255, 255, 255, 0.5);
    font-size: 0.8rem;
}

/* Layout */
.soc-layout {
    display: grid;
    grid-template-columns: 250px 1fr 250px;
    gap: 1.5rem;
    min-height: 400px;
    flex: 1;
    overflow: hidden;
}

.soc-panel {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.soc-panel.left, .soc-panel.right {
    overflow-y: auto;
    max-height: 500px;
    scrollbar-width: thin;
    scrollbar-color: rgba(6,182,212,0.3) transparent;
}
.soc-panel.left::-webkit-scrollbar, .soc-panel.right::-webkit-scrollbar {
    width: 4px;
}
.soc-panel.left::-webkit-scrollbar-thumb, .soc-panel.right::-webkit-scrollbar-thumb {
    background: rgba(6,182,212,0.3);
    border-radius: 2px;
}
.soc-panel.left::-webkit-scrollbar-track, .soc-panel.right::-webkit-scrollbar-track {
    background: transparent;
}

.panel-box {
    background: rgba(0, 212, 255, 0.02);
    border: 1px solid rgba(0, 212, 255, 0.1);
    padding: 1rem;
    border-radius: 4px;
}

.panel-box h3 {
    font-family: 'Orbitron', sans-serif;
    font-size: 0.8rem;
    color: #00d4ff;
    margin-bottom: 1rem;
    border-left: 2px solid #00d4ff;
    padding-left: 0.5rem;
}

/* Real Mini Map */
.mini-map-container {
    position: relative;
    width: 100%;
    aspect-ratio: 2 / 1;
    border-radius: 6px;
    overflow: hidden;
    background: #0a0e17;
}
.mini-map-img {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: contain;
    opacity: 0.7;
    filter: brightness(1.2);
}
.mini-map-svg {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
}
.target-dot {
    fill: #06b6d4;
}
.target-ring {
    fill: none;
    stroke: #06b6d4;
    stroke-width: 1;
}
.node-label {
    fill: #06b6d4;
    font-size: 12px;
    font-family: monospace;
}
.attack-label {
    font-size: 10px;
    font-family: monospace;
}

/* Radar */
.radar-container {
    flex: 1;
}

.radar-display {
    width: 100%;
    aspect-ratio: 1;
    position: relative;
    border-radius: 50%;
    border: 1px solid rgba(0, 212, 255, 0.2);
    background:
        radial-gradient(circle, rgba(0, 212, 255, 0.1) 1px, transparent 1px),
        linear-gradient(rgba(0, 212, 255, 0.1) 1px, transparent 1px),
        linear-gradient(90deg, rgba(0, 212, 255, 0.1) 1px, transparent 1px);
    background-size: 20px 20px, 40px 40px, 40px 40px;
    background-position: center;
    overflow: hidden;
}

.radar-circle {
    position: absolute;
    top: 50%; left: 50%;
    transform: translate(-50%, -50%);
    border: 1px solid rgba(0, 212, 255, 0.1);
    border-radius: 50%;
}

.c1 { width: 33%; height: 33%; }
.c2 { width: 66%; height: 66%; }
.c3 { width: 100%; height: 100%; }

.radar-sweep {
    position: absolute;
    top: 50%; left: 50%;
    width: 50%; height: 2px;
    background: linear-gradient(90deg, rgba(0, 212, 255, 0.8), transparent);
    transform-origin: left center;
    animation: radar-spin 3s linear infinite;
    box-shadow: 0 0 10px #00d4ff;
}

.radar-sweep::after {
    content: '';
    position: absolute;
    top: 0; left: 0;
    width: 100%; height: 50px;
    background: linear-gradient(180deg, rgba(0, 212, 255, 0.2), transparent);
    transform-origin: top left;
    transform: skewX(-20deg);
}

.radar-blip {
    position: absolute;
    width: 6px; height: 6px;
    background: #ff6b6b;
    border-radius: 50%;
    box-shadow: 0 0 10px #ff6b6b;
    opacity: 0;
    animation: blip-fade 3s infinite;
}

.b1 { top: 30%; left: 60%; animation-delay: 0.5s; }
.b2 { top: 70%; left: 40%; animation-delay: 1.8s; }

/* Resources */
.resources {
    flex: 0;
}

.res-row {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 0.5rem;
    font-size: 0.75rem;
    color: rgba(255, 255, 255, 0.7);
    font-family: monospace;
}

.res-bar {
    flex: 1;
    height: 4px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 2px;
    overflow: hidden;
}

.res-fill {
    height: 100%;
    background: #00d4ff;
    position: relative;
}

.cpu-fill { width: 42%; animation: bar-fluctuate 2s ease infinite alternate; }
.ram-fill { width: 68%; background: #00ff88; }
.net-fill { width: 85%; background: #ffaa00; animation: bar-fluctuate 0.5s ease infinite alternate; }

/* Holo Map */
.soc-panel.center {
    justify-content: center;
    align-items: stretch;
    display: flex;
    flex-direction: column;
}

/* SOC Header Right */
.soc-header-right {
    display: flex;
    align-items: center;
    gap: 0.75rem;
}
.soc-btn {
    font-size: 0.55rem;
    padding: 0.2rem 0.5rem;
    background: rgba(255,255,255,0.06);
    border: 1px solid rgba(255,255,255,0.1);
    border-radius: 4px;
    color: rgba(255,255,255,0.7);
    cursor: pointer;
    font-family: monospace;
}
.soc-btn.accent-btn {
    border-color: rgba(6,182,212,0.3);
    color: #06b6d4;
}

/* SOC Accent */
.soc-accent {
    color: #06b6d4;
    font-weight: bold;
    margin-right: 0.25rem;
}

/* Attack Map */
.soc-map-container {
    width: 100%;
    aspect-ratio: 2/1;
    border-radius: 4px;
    overflow: hidden;
}
.soc-minimap {
    width: 100%;
    height: 100%;
}

/* AI Report */
.soc-ai-status-row {
    font-size: 0.65rem;
    color: #22c55e;
    margin-bottom: 0.3rem;
}
.soc-ai-content {
    background: rgba(255,255,255,0.03);
    border-radius: 4px;
    padding: 0.4rem;
    margin-bottom: 0.3rem;
}
.soc-ai-text {
    font-size: 0.55rem;
    color: rgba(255,255,255,0.6);
    line-height: 1.4;
}
.soc-ai-btns {
    display: flex;
    gap: 0.3rem;
}
.soc-mini-btn {
    font-size: 0.5rem;
    padding: 0.15rem 0.4rem;
    background: rgba(6,182,212,0.1);
    border: 1px solid rgba(6,182,212,0.3);
    border-radius: 3px;
    color: #06b6d4;
    font-family: monospace;
}

/* System Metrics */
.soc-metrics {
    display: flex;
    flex-direction: column;
    gap: 0.35rem;
}
.soc-metric-row {
    display: flex;
    align-items: center;
    gap: 0.3rem;
    font-size: 0.55rem;
    color: rgba(255,255,255,0.7);
    font-family: monospace;
}
.soc-metric-row > span:first-child {
    width: 40px;
    flex-shrink: 0;
}
.soc-metric-row > span:last-child {
    width: 30px;
    text-align: right;
    flex-shrink: 0;
}
.soc-bar {
    flex: 1;
    height: 4px;
    background: rgba(255,255,255,0.06);
    border-radius: 2px;
    overflow: hidden;
}
.soc-bar-fill {
    height: 100%;
    border-radius: 2px;
    transition: width 0.6s ease;
}
.soc-bar-fill.blue { background: #3b82f6; }
.soc-bar-fill.green { background: #22c55e; }
.soc-bar-fill.orange { background: #f97316; }
.soc-bar-fill.purple { background: #8b5cf6; }
.soc-bar-fill.cyan { background: #06b6d4; }

/* Hardware Gauges */
.soc-hw-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 0.25rem;
    justify-items: center;
}
.soc-hw-gauge {
    width: 50px;
    height: 50px;
}
.soc-net-detail {
    display: flex;
    justify-content: center;
    gap: 0.75rem;
    margin-top: 0.3rem;
    font-size: 0.5rem;
    color: rgba(255,255,255,0.5);
    font-family: monospace;
}

/* Globe Header & Legend */
.soc-globe-header {
    display: flex;
    align-items: center;
    gap: 0.4rem;
    font-size: 0.65rem;
    color: rgba(255,255,255,0.8);
    font-family: monospace;
    padding: 0.3rem 0;
}
.status-dot.green { background: #22c55e; box-shadow: 0 0 6px #22c55e; }
.soc-globe-legend {
    display: flex;
    justify-content: center;
    gap: 1rem;
    padding: 0.3rem 0;
    font-size: 0.55rem;
    color: rgba(255,255,255,0.6);
    font-family: monospace;
}
.legend-dot {
    display: inline-block;
    width: 6px;
    height: 6px;
    border-radius: 50%;
    margin-right: 0.25rem;
    vertical-align: middle;
}
.legend-dot.red { background: #ef4444; box-shadow: 0 0 4px #ef4444; }
.legend-dot.purple { background: #e040fb; box-shadow: 0 0 4px #e040fb; }
.legend-dot.orange { background: #f97316; box-shadow: 0 0 4px #f97316; }
.legend-dot.green { background: #22c55e; box-shadow: 0 0 4px #22c55e; }

/* Attack Feed - updated */
.log-item {
    display: flex;
    align-items: center;
    gap: 0.3rem;
}
.log-detail {
    flex: 1;
    font-size: 0.5rem;
    color: rgba(255,255,255,0.4);
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.log-severity {
    font-size: 0.45rem;
    padding: 0.05rem 0.2rem;
    border-radius: 2px;
    font-weight: bold;
}
.log-severity.high { background: rgba(239,68,68,0.2); color: #ef4444; }
.log-severity.medium { background: rgba(249,115,22,0.2); color: #f97316; }

/* WAF Security Status */
.soc-security-status {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.2rem;
    margin-bottom: 0.3rem;
}
.soc-security-circle {
    position: relative;
    width: 60px;
    height: 60px;
}
.soc-security-circle svg {
    width: 100%;
    height: 100%;
}
.soc-security-value {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    font-size: 0.85rem;
    font-weight: bold;
    color: #22c55e;
    font-family: monospace;
}
.soc-security-label {
    font-size: 0.65rem;
    font-weight: bold;
    font-family: monospace;
}
.soc-security-stats, .soc-ids-stats {
    display: flex;
    flex-direction: column;
    gap: 0.2rem;
}
.soc-stat-row {
    display: flex;
    justify-content: space-between;
    font-size: 0.55rem;
    color: rgba(255,255,255,0.7);
    font-family: monospace;
}

/* Agent Status */
.soc-agent-list {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}
.soc-agent-item {
    display: flex;
    align-items: center;
    gap: 0.3rem;
    font-size: 0.55rem;
    color: rgba(255,255,255,0.7);
    font-family: monospace;
}
.agent-dot {
    width: 6px;
    height: 6px;
    border-radius: 50%;
    flex-shrink: 0;
}
.agent-dot.online { background: #22c55e; box-shadow: 0 0 4px #22c55e; }
.agent-dot.offline { background: #6b7280; }
.agent-ip-text {
    margin-left: auto;
    color: rgba(255,255,255,0.4);
}

/* SOC Footer Bar */
.soc-footer-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.3rem 0.75rem;
    font-size: 0.5rem;
    color: rgba(255,255,255,0.4);
    font-family: monospace;
    border-top: 1px solid rgba(6,182,212,0.15);
    background: rgba(10,14,23,0.5);
}
.soc-footer-copy strong {
    color: #06b6d4;
}
.soc-footer-time {
    color: rgba(255,255,255,0.5);
}

.globe-3d-container {
    width: 100%;
    height: 400px;
    min-height: 400px;
    border-radius: 8px;
    overflow: hidden;
    border: 1px solid rgba(0, 212, 255, 0.2);
}

.globe-3d-container .waf-3d-container {
    height: 100% !important;
    min-height: 100% !important;
}

.holo-map-container {
    flex: 1;
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
}

.holo-map {
    width: 250px;
    height: 250px;
    position: relative;
}

.globe-svg {
    width: 100%;
    height: 100%;
    filter: drop-shadow(0 0 10px rgba(0, 212, 255, 0.3));
    animation: rotate-globe 20s linear infinite;
}

.globe-wire {
    stroke: rgba(0, 212, 255, 0.4);
    stroke-width: 1;
}

.map-dot {
    fill: #ff6b6b;
    animation: pulse-dot 1s infinite alternate;
}

.map-scan-ring {
    position: absolute;
    top: 50%; left: 50%;
    width: 120%; height: 40%;
    border: 1px solid rgba(0, 212, 255, 0.3);
    border-radius: 50%;
    transform: translate(-50%, -50%) rotateX(60deg);
    animation: scan-ring 3s ease-in-out infinite;
    box-shadow: 0 0 15px rgba(0, 212, 255, 0.2);
}

.main-alert {
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    background: rgba(255, 59, 59, 0.1);
    border: 1px solid rgba(255, 59, 59, 0.5);
    padding: 0.5rem 1rem;
    border-radius: 4px;
    display: flex;
    align-items: center;
    gap: 0.5rem;
    width: max-content;
    animation: alert-flash 1s infinite;
}

.alert-msg {
    color: #ff6b6b;
    font-family: monospace;
    font-weight: bold;
    font-size: 0.8rem;
}

.main-stats {
    display: flex;
    gap: 1rem;
}

.stat-block {
    flex: 1;
    background: rgba(0, 212, 255, 0.05);
    padding: 1rem;
    border-radius: 4px;
    border-top: 2px solid #00d4ff;
    text-align: center;
}

.stat-label {
    display: block;
    font-size: 0.7rem;
    color: rgba(255, 255, 255, 0.6);
    margin-bottom: 0.5rem;
}

.stat-val {
    font-family: 'Orbitron', sans-serif;
    font-size: 1.5rem;
    color: #fff;
}

.stat-val.critical { color: #ff6b6b; text-shadow: 0 0 10px #ff6b6b; }

/* Log Feed */
.log-container {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.log-list {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    overflow: hidden;
    position: relative;
}

.log-list::after {
    content: '';
    position: absolute;
    bottom: 0; left: 0; width: 100%; height: 50px;
    background: linear-gradient(transparent, rgba(8, 10, 20, 0.95));
}

.log-item {
    display: flex;
    justify-content: space-between;
    font-family: monospace;
    font-size: 0.7rem;
    padding: 0.4rem;
    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
}

.log-time { color: rgba(255, 255, 255, 0.5); }
.log-ip { color: #fff; }

.log-item.critical .log-type { color: #ff6b6b; }
.log-item.warning .log-type { color: #ffaa00; }
.log-item.info .log-type { color: #00d4ff; }

/* AI Core */
.ai-status {
    flex: 0;
    text-align: center;
}

.ai-core {
    width: 60px; height: 60px;
    margin: 0 auto 0.5rem;
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
}

.core-ring {
    position: absolute;
    width: 100%; height: 100%;
    border: 2px solid #00d4ff;
    border-radius: 50%;
    border-top-color: transparent;
    animation: spin 1s linear infinite;
}

.core-center {
    font-size: 0.9rem;
    font-weight: bold;
    color: #00ff88;
}

.ai-state {
    font-size: 0.7rem;
    color: #00ff88;
    letter-spacing: 1px;
}

/* Animations */
@keyframes blink-fast {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.5; }
}

@keyframes radar-spin {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

@keyframes blip-fade {
    0% { opacity: 1; transform: scale(1); }
    100% { opacity: 0; transform: scale(3); }
}

@keyframes rotate-globe {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}

@keyframes scan-ring {
    0%, 100% { transform: translate(-50%, -50%) rotateX(70deg) scale(1); opacity: 0.5; }
    50% { transform: translate(-50%, -50%) rotateX(70deg) scale(1.1); opacity: 0.8; }
}

@keyframes alert-flash {
    0%, 100% { background: rgba(255, 59, 59, 0.1); }
    50% { background: rgba(255, 59, 59, 0.3); }
}

@keyframes bar-fluctuate {
    0% { width: 40%; }
    100% { width: 55%; }
}

@media (max-width: 900px) {
    .soc-layout {
        grid-template-columns: 1fr;
        gap: 2rem;
    }
    
    .soc-panel.left, .soc-panel.right, .soc-panel.center {
        order: unset;
    }
    
    .soc-bg-grid {
        transform: perspective(500px) rotateX(0deg) scale(1);
        opacity: 0.1;
    }
}

/* Passkey Authentication Section */
.passkey-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, transparent 0%, rgba(139, 92, 246, 0.05) 50%, transparent 100%);
}

.passkey-container {
    max-width: 1100px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    gap: 4rem;
}

.passkey-text {
    flex: 1;
}

.section-lead {
    font-size: 1.1rem;
    color: rgba(255, 255, 255, 0.7);
    margin-bottom: 2rem;
}

.passkey-features {
    list-style: none;
    padding: 0;
}

.passkey-features li {
    padding: 0.75rem 0;
    font-size: 1.1rem;
    color: rgba(255, 255, 255, 0.8);
    border-bottom: 1px solid rgba(255, 255, 255, 0.05);
}

.passkey-visual {
    flex: 1;
    display: flex;
    justify-content: center;
}

.fingerprint-scanner {
    width: 200px;
    height: 250px;
    border: 2px solid rgba(139, 92, 246, 0.4);
    border-radius: 20px;
    background: rgba(0, 0, 0, 0.5);
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

.scan-line {
    position: absolute;
    width: 100%;
    height: 3px;
    background: linear-gradient(90deg, transparent, #00ff88, transparent);
    top: 10%;
    animation: fingerprint-scan 2s ease-in-out infinite;
    box-shadow: 0 0 20px #00ff88;
}

@keyframes fingerprint-scan {
    0%, 100% { top: 10%; opacity: 0; }
    50% { top: 80%; opacity: 1; }
}

.fingerprint-icon {
    width: 100px;
    height: 100px;
    color: rgba(139, 92, 246, 0.8);
    margin-bottom: 1rem;
    filter: drop-shadow(0 0 15px rgba(139, 92, 246, 0.5));
}

.fingerprint-icon svg {
    width: 100%;
    height: 100%;
    animation: fingerprint-pulse 2s ease-in-out infinite;
}

@keyframes fingerprint-pulse {
    0%, 100% { opacity: 0.6; transform: scale(1); }
    50% { opacity: 1; transform: scale(1.05); }
}

.scanner-text {
    font-family: 'Orbitron', sans-serif;
    font-size: 0.75rem;
    color: #00ff88;
    letter-spacing: 2px;
    opacity: 0;
    animation: scanner-text-fade 2s ease-in-out infinite;
    animation-delay: 1s;
}

@keyframes scanner-text-fade {
    0%, 60%, 100% { opacity: 0; }
    70%, 90% { opacity: 1; }
}

/* AI Report Section */
.report-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
}

.report-container {
    max-width: 1100px;
    margin: 0 auto;
    display: flex;
    align-items: center;
    gap: 4rem;
}

.report-visual {
    flex: 1;
}

.email-mockup {
    background: rgba(15, 15, 30, 0.9);
    border: 1px solid rgba(0, 212, 255, 0.3);
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.4);
    transition: transform 0.3s ease;
}

.email-mockup:hover {
    transform: translateY(-10px);
}

.email-header {
    background: linear-gradient(90deg, rgba(0, 212, 255, 0.2), rgba(139, 92, 246, 0.2));
    padding: 1rem 1.5rem;
    font-family: 'Orbitron', sans-serif;
    font-size: 0.9rem;
    color: #00d4ff;
    border-bottom: 1px solid rgba(0, 212, 255, 0.2);
}

.email-body {
    padding: 1.5rem;
}

.email-chart {
    height: 80px;
    background: linear-gradient(90deg, 
        rgba(0, 212, 255, 0.3) 0%, 
        rgba(0, 255, 136, 0.3) 25%, 
        rgba(139, 92, 246, 0.3) 50%,
        rgba(0, 212, 255, 0.3) 75%,
        rgba(255, 107, 107, 0.3) 100%
    );
    border-radius: 8px;
    margin-bottom: 1.5rem;
    position: relative;
    overflow: hidden;
}

.email-chart::after {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
    animation: shimmer 2s infinite;
}

@keyframes shimmer {
    100% { left: 100%; }
}

.email-lines .line {
    height: 12px;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 6px;
    margin-bottom: 0.75rem;
}

.email-lines .line.short {
    width: 60%;
}

.report-text {
    flex: 1;
}

.section-desc {
    color: rgba(255, 255, 255, 0.6);
    line-height: 1.8;
}

@media (max-width: 900px) {
    .passkey-container,
    .report-container {
        flex-direction: column;
        text-align: center;
    }
    
    .soc-content {
        flex-direction: column;
    }
    
    .soc-globe {
        min-height: 200px;
    }
}

/* ===== GLOBAL MOBILE OVERFLOW PREVENTION ===== */
/* Placed at END of file to win CSS source-order specificity */
@media (max-width: 768px) {
    /* Force ALL auto-fit grids to single column */
    .ai-features-grid,
    .engines-grid,
    .deploy-options,
    .ids-features,
    .ddos-features,
    .cdn-features,
    .waf-rules-container,
    .waf-rules-grid,
    .geoip-features {
        grid-template-columns: 1fr !important;
    }

    /* Force 3-4 column grids to 2 columns */
    .cdn-stats-banner,
    .ddos-stats-dashboard,
    .waf-test-stats,
    .stats-grid {
        grid-template-columns: repeat(2, 1fr) !important;
    }

    /* Constrain all sections and containers */
    .ai-section,
    .passkey-section,
    .report-section,
    .lb-section,
    .ids-section,
    .ddos-section,
    .waf-rules-section {
        padding-left: 1rem !important;
        padding-right: 1rem !important;
        overflow-x: hidden !important;
    }

    /* Prevent text overflow */
    .section-lead,
    .section-desc,
    .sticky-slide-desc,
    .passkey-features li,
    p {
        word-break: break-word;
        overflow-wrap: break-word;
    }

    /* Containers */
    .passkey-container,
    .report-container {
        max-width: 100% !important;
        padding: 0 !important;
    }

    /* Fingerprint and email mockup */
    .fingerprint-scanner {
        width: 150px !important;
        height: 150px !important;
    }
    .email-mockup {
        max-width: 100% !important;
    }

    /* SOC layout */
    .soc-layout {
        grid-template-columns: 1fr !important;
    }

    /* Showcase: keep fixed scroll, fix image sizing */
    .showcase-slide {
        max-width: 100% !important;
        padding: 1rem !important;
    }
    .showcase-image-wrapper {
        width: 100% !important;
        max-width: 100% !important;
        max-height: 50vh !important;
    }
    .showcase-image-wrapper img {
        width: 100% !important;
    }

    /* Other fixed containers */
    .sticky-fixed-container,
    .cdn-map-fixed-container {
        overflow-y: auto !important;
    }
}
</style>
