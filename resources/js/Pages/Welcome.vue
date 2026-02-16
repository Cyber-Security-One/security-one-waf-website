<template>
    <div class="app-wrapper">
        <!-- Login Button (Fixed Top Right) -->
        <a href="https://security-one-soc.vito1317.com" class="login-btn" target="_blank" rel="noopener noreferrer">
            <span class="login-icon">🔐</span>
            <span class="login-text">登入</span>
        </a>
        
        <!-- Loading Screen -->
        <LoadingScreen v-if="isLoading" @complete="onLoadingComplete" />
        
        <!-- Grid Background -->
        <div class="grid-background"></div>
        <div class="hex-pattern"></div>
        
        <!-- Particle Background -->
        <ParticleBackground />
        
        <!-- Hero Section (Fixed Parallax) -->
        <div class="hero-wrapper">
            <section class="hero hero-fixed" ref="heroRef" :style="heroStyle">
                <span class="hero-badge animate-pulse-border">
                    🛡️ AI-Powered Security Operations Center
                </span>
                <h1 class="hero-title text-gradient">
                    <span class="title-brand">Security One</span> <span class="title-product">SOC</span>
                </h1>
                <p class="hero-subtitle">
                    智能 統一安全平台，結合 AI 威脅偵測與 CVE 資料庫即時更新，為您的網站提供最先進的自動化防護
                </p>
                <div class="hero-cta">
                    <a href="mailto:service@cybersecureone.com?subject=Security One SOC 諮詢" class="btn btn-primary animate-glow">
                        <span>🚀</span> 聯絡我們
                    </a>
                </div>
                
                <!-- Scroll Indicator -->
                <div class="scroll-indicator" :style="{ opacity: 1 - scrollProgress }">
                    <span>向下滾動</span>
                    <div class="scroll-arrow">↓</div>
                </div>
            </section>
        </div>
        
        <!-- Features Section -->
        <section id="features" class="features">
            <h2 class="section-title text-gradient scroll-animate">核心功能</h2>
            <p class="section-subtitle scroll-animate">
                完整的 WAF 解決方案，從防護到監控一應俱全
            </p>
            
            <div class="features-grid">
                <FeatureCard
                    v-for="(feature, index) in features"
                    :key="index"
                    :icon="feature.icon"
                    :title="feature.title"
                    :description="feature.description"
                    :delay="index * 0.1"
                    @click="openModal(feature)"
                />
            </div>
        </section>

        <!-- Core Attack Protection Section -->
        <section class="attack-protection-section">
            <h2 class="section-title text-gradient scroll-animate">🛡️ 核心攻擊防護</h2>
            <p class="section-subtitle scroll-animate">
                13 種攻擊類型全方位防護，傳統規則引擎與 AI 雙重偵測
            </p>
            
            <div class="attack-types-grid">
                <div class="attack-type-card scroll-animate" v-for="(attack, index) in attackTypes" :key="index">
                    <div class="attack-icon">{{ attack.icon }}</div>
                    <h4 class="attack-name">{{ attack.name }}</h4>
                    <p class="attack-desc">{{ attack.desc }}</p>
                    <div class="attack-targets">
                        <span v-for="target in attack.targets" :key="target">{{ target }}</span>
                    </div>
                </div>
            </div>
        </section>

        <!-- IDS/IPS Distributed Defense Section -->
        <section class="ids-section">
            <h2 class="section-title text-gradient scroll-animate">🔗 IDS/IPS 分散式防禦</h2>
            <p class="section-subtitle scroll-animate">
                部署在後端伺服器的 Agent，形成縱深防禦架構
            </p>
            
            <div class="ids-architecture scroll-animate">
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
            
            <div class="ids-engines scroll-animate">
                <div class="engine-card" v-for="engine in idsEngines" :key="engine.name">
                    <div class="engine-icon">{{ engine.icon }}</div>
                    <h4>{{ engine.name }}</h4>
                    <p>{{ engine.desc }}</p>
                    <ul>
                        <li v-for="feature in engine.features" :key="feature">{{ feature }}</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- Traffic Control Section -->
        <section class="traffic-section">
            <h2 class="section-title text-gradient scroll-animate">⚡ 流量控制與防護</h2>
            <p class="section-subtitle scroll-animate">
                CC/DDoS 防護、自動封鎖、人機驗證多重機制
            </p>
            
            <div class="traffic-features scroll-animate">
                <div class="traffic-card" v-for="item in trafficFeatures" :key="item.title">
                    <div class="traffic-icon">{{ item.icon }}</div>
                    <h4>{{ item.title }}</h4>
                    <p>{{ item.desc }}</p>
                </div>
            </div>
        </section>

        <!-- Rule Management Section -->
        <section class="rules-section">
            <h2 class="section-title text-gradient scroll-animate">📋 規則管理</h2>
            <p class="section-subtitle scroll-animate">
                自訂規則、全域規則、CVE 自動生成規則
            </p>
            
            <div class="rules-flow scroll-animate">
                <div class="rule-type" v-for="rule in ruleTypes" :key="rule.name">
                    <div class="rule-icon">{{ rule.icon }}</div>
                    <h4>{{ rule.name }}</h4>
                    <p>{{ rule.desc }}</p>
                </div>
            </div>
        </section>
        
        <!-- Stats Section -->
        <section class="stats">
            <div class="stats-grid">
                <div class="stat-item scroll-animate animate-hover-scale" v-for="(stat, index) in stats" :key="index">
                    <AnimatedCounter :target="stat.value" :suffix="stat.suffix" />
                    <p class="stat-label">{{ stat.label }}</p>
                </div>
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
                        <img src="/images/attackmap.png" alt="Attack Map" />
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
            <h2 class="section-title text-gradient scroll-animate">🤖 AI 智能防禦</h2>
            <p class="section-subtitle scroll-animate">
                突破傳統規則限制，使用 AI 即時分析與偵測進階威脅
            </p>
            
            <div class="ai-features-grid">
                <div class="ai-feature-card scroll-animate" 
                     v-for="(feature, index) in aiFeatures" 
                     :key="index"
                     @click="openModal(feature)">
                    <div class="ai-feature-icon animate-float">{{ feature.icon }}</div>
                    <h3 class="ai-feature-title">{{ feature.title }}</h3>
                    <p class="ai-feature-desc">{{ feature.description }}</p>
                    <ul class="ai-feature-list">
                        <li v-for="(item, i) in feature.highlights.slice(0, 3)" :key="i">{{ item }}</li>
                    </ul>
                    <span class="view-more">查看詳情 →</span>
                </div>
            </div>
        </section>
        
        <!-- CVE Database Section -->
        <section class="cve-section">
            <h2 class="section-title text-gradient scroll-animate">📡 CVE 資料庫即時更新</h2>
            <p class="section-subtitle scroll-animate">
                自動同步 NVD 漏洞資料庫，AI 智能生成防護規則
            </p>
            
            <div class="cve-flow scroll-animate">
                <div class="cve-step animate-hover-lift" v-for="(step, index) in cveSteps" :key="index">
                    <div class="cve-step-icon">{{ step.icon }}</div>
                    <div class="cve-step-content">
                        <h4>{{ step.title }}</h4>
                        <p>{{ step.description }}</p>
                    </div>
                    <div v-if="index < cveSteps.length - 1" class="cve-arrow">→</div>
                </div>
            </div>
            
            <div class="cve-info-box scroll-animate">
                <h4>🔍 支援的情報來源</h4>
                <div class="cve-sources">
                    <span class="cve-source animate-pop" v-for="(source, i) in cveSources" :key="i" :style="{ animationDelay: i * 0.1 + 's' }">
                        {{ source }}
                    </span>
                </div>
            </div>
        </section>
        
        <!-- Attack Demo Section -->
        <section class="demo-section">
            <h2 class="section-title text-gradient scroll-animate">攻擊偵測流程</h2>
            <p class="section-subtitle scroll-animate">
                從攻擊發生到封鎖只需毫秒級反應
            </p>
            
            <div class="demo-timeline scroll-animate">
                <div class="timeline-item" v-for="(step, index) in attackFlow" :key="index">
                    <div class="timeline-time">{{ step.time }}</div>
                    <div class="timeline-dot" :class="step.type"></div>
                    <div class="timeline-content">
                        <h4>{{ step.title }}</h4>
                        <p>{{ step.desc }}</p>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- SOC Command Center Section -->
        <section class="soc-section">
            <div class="soc-bg-grid"></div>
            <h2 class="section-title text-gradient scroll-animate">👁️ SOC 戰情中心</h2>
            <p class="section-subtitle scroll-animate">
                專業級資安監控儀表板，全螢幕 3D 威脅視覺化
            </p>
            
            <div class="soc-dashboard scroll-animate">
                <div class="soc-screen">
                    <!-- Decor Elements -->
                    <div class="screen-overlay"></div>
                    <div class="corner-decor top-left"></div>
                    <div class="corner-decor top-right"></div>
                    <div class="corner-decor bottom-left"></div>
                    <div class="corner-decor bottom-right"></div>
                    
                    <div class="soc-header">
                        <div class="status-indicator">
                            <span class="status-dot"></span>
                            <span class="status-text">SYSTEM ONLINE</span>
                            <span class="status-ping">PING: 12ms</span>
                        </div>
                        <div class="soc-server-id">SERVER: HK-01-NODE</div>
                    </div>

                    <div class="soc-layout">
                        <!-- Left Panel: Radar & Resources -->
                        <div class="soc-panel left">
                            <div class="panel-box radar-container">
                                <h3>THREAT RADAR</h3>
                                <div class="radar-display">
                                    <div class="radar-circle c1"></div>
                                    <div class="radar-circle c2"></div>
                                    <div class="radar-circle c3"></div>
                                    <div class="radar-sweep"></div>
                                    <div class="radar-blip b1"></div>
                                    <div class="radar-blip b2"></div>
                                </div>
                            </div>
                            
                            <div class="panel-box resources">
                                <h3>SYSTEM RESOURCES</h3>
                                <div class="res-row">
                                    <span>CPU</span>
                                    <div class="res-bar"><div class="res-fill cpu-fill"></div></div>
                                    <span class="res-val">42%</span>
                                </div>
                                <div class="res-row">
                                    <span>RAM</span>
                                    <div class="res-bar"><div class="res-fill ram-fill"></div></div>
                                    <span class="res-val">68%</span>
                                </div>
                                <div class="res-row">
                                    <span>NET</span>
                                    <div class="res-bar"><div class="res-fill net-fill"></div></div>
                                    <span class="res-val">85%</span>
                                </div>
                            </div>
                        </div>

                        <!-- Center Panel: 3D Globe -->
                        <div class="soc-panel center">
                            <div class="globe-3d-container">
                                <Waf3DVisualizer />
                            </div>
                        </div>

                        <!-- Right Panel: Live Logs -->
                        <div class="soc-panel right">
                            <div class="panel-box log-container">
                                <h3>LIVE ATTACK FEED</h3>
                                <div class="log-list">
                                    <div class="log-item critical">
                                        <span class="log-time">10:42:05</span>
                                        <span class="log-ip">192.168.1.45</span>
                                        <span class="log-type">SQLI</span>
                                    </div>
                                    <div class="log-item warning">
                                        <span class="log-time">10:41:58</span>
                                        <span class="log-ip">10.0.5.122</span>
                                        <span class="log-type">XSS</span>
                                    </div>
                                    <div class="log-item info">
                                        <span class="log-time">10:41:42</span>
                                        <span class="log-ip">172.16.8.99</span>
                                        <span class="log-type">CRAWL</span>
                                    </div>
                                    <div class="log-item critical">
                                        <span class="log-time">10:41:15</span>
                                        <span class="log-ip">45.33.22.11</span>
                                        <span class="log-type">DDOS</span>
                                    </div>
                                    <div class="log-item info">
                                        <span class="log-time">10:40:55</span>
                                        <span class="log-ip">192.168.0.1</span>
                                        <span class="log-type">SCAN</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="panel-box ai-status">
                                <h3>AI SENTINEL</h3>
                                <div class="ai-core">
                                    <div class="core-ring"></div>
                                    <div class="core-center">99%</div>
                                </div>
                                <span class="ai-state">ACTIVE ANALYSIS</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Passkey Authentication Section -->
        <section class="passkey-section">
            <div class="passkey-container">
                <div class="passkey-text scroll-animate">
                    <h2 class="section-title text-gradient">🔐 零信任身份驗證</h2>
                    <p class="section-lead">無需修改後端程式碼，立即為您的網站啟用生物辨識登入</p>
                    <ul class="passkey-features">
                        <li>👆 支援 TouchID / FaceID</li>
                        <li>🔑 FIDO2 / WebAuthn 標準</li>
                        <li>🛡️ 站點級別存取控制</li>
                        <li>⚡ 毫秒級無密碼登入</li>
                    </ul>
                </div>
                <div class="passkey-visual scroll-animate">
                    <div class="fingerprint-scanner">
                        <div class="scan-line"></div>
                        <div class="fingerprint-icon">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2">
                                <path d="M12 11c0 3.517-1.009 6.799-2.753 9.571m-3.44-2.04l.054-.09A13.916 13.916 0 008 11a4 4 0 118 0c0 1.017-.07 2.019-.203 3m-2.118 6.844A21.88 21.88 0 0015.171 17m3.839 1.132c.645-2.266.99-4.659.99-7.132A8 8 0 008 4.07M3 15.364c.64-1.319 1-2.8 1-4.364 0-1.457.39-2.823 1.07-4"/>
                            </svg>
                        </div>
                        <div class="scanner-text">ACCESS GRANTED</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- AI Report Section -->
        <section class="report-section">
            <div class="report-container">
                <div class="report-visual scroll-animate">
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
                </div>
                <div class="report-text scroll-animate">
                    <h2 class="section-title text-gradient">📧 AI 智能安全報告</h2>
                    <p class="section-lead">每天早晨，您的安全摘要已準備就緒</p>
                    <p class="section-desc">Sentinel AI 自動分析昨日所有流量，識別潛在威脅模式，並將精簡報告直接發送至您的信箱。</p>
                </div>
            </div>
        </section>
        
        <!-- Load Balancer Section -->
        <section class="lb-section">
            <h2 class="section-title text-gradient scroll-animate">⚖️ 智能負載均衡</h2>
            <p class="section-subtitle scroll-animate">
                多後端伺服器流量分配，自動故障轉移確保高可用性
            </p>
            
            <!-- Animated Traffic Flow Diagram -->
            <div class="lb-diagram scroll-animate">
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
            <div class="lb-features scroll-animate">
                <div class="lb-feature-card" v-for="(item, i) in lbFeatures" :key="i">
                    <span class="lb-feature-icon">{{ item.icon }}</span>
                    <h4>{{ item.title }}</h4>
                    <p>{{ item.desc }}</p>
                </div>
            </div>
            
            <!-- Strategies -->
            <div class="lb-strategies scroll-animate">
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
        
        <!-- CDN Cache Acceleration Section -->
        <section class="cdn-section">
            <h2 class="section-title text-gradient scroll-animate">🚀 CDN 快取加速</h2>
            <p class="section-subtitle scroll-animate">
                內建 Nginx Proxy Cache，智能靜態資源加速，有效降低源站負載
            </p>
            
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

            <!-- CDN Global Nodes Map -->
            <div class="cdn-global-map scroll-animate">
                <h3 class="text-gradient">🌍 全球 CDN 節點</h3>
                <p class="map-subtitle">遍布全球的邊緣節點，確保用戶就近存取</p>
                
                <div class="world-map-container">
                    <svg viewBox="0 0 1000 500" class="world-map-svg">
                        <!-- Simplified world map outline -->
                        <defs>
                            <radialGradient id="nodeGlow" cx="50%" cy="50%" r="50%">
                                <stop offset="0%" stop-color="#00f0ff" stop-opacity="0.8"/>
                                <stop offset="100%" stop-color="#00f0ff" stop-opacity="0"/>
                            </radialGradient>
                            <radialGradient id="nodeGlowGreen" cx="50%" cy="50%" r="50%">
                                <stop offset="0%" stop-color="#00ff88" stop-opacity="0.8"/>
                                <stop offset="100%" stop-color="#00ff88" stop-opacity="0"/>
                            </radialGradient>
                            <filter id="glow">
                                <feGaussianBlur stdDeviation="3" result="blur"/>
                                <feMerge><feMergeNode in="blur"/><feMergeNode in="SourceGraphic"/></feMerge>
                            </filter>
                        </defs>
                        
                        <!-- Continent outlines (simplified) -->
                        <!-- North America -->
                        <path d="M 100 120 Q 150 80, 250 100 Q 280 120, 260 180 Q 240 220, 200 240 Q 160 220, 120 200 Q 90 170, 100 120" 
                              fill="rgba(255,255,255,0.03)" stroke="rgba(255,255,255,0.1)" stroke-width="1"/>
                        <!-- South America -->
                        <path d="M 220 260 Q 260 250, 280 280 Q 300 340, 280 400 Q 260 430, 240 420 Q 210 380, 200 320 Q 200 280, 220 260"
                              fill="rgba(255,255,255,0.03)" stroke="rgba(255,255,255,0.1)" stroke-width="1"/>
                        <!-- Europe -->
                        <path d="M 440 90 Q 480 80, 520 100 Q 540 120, 530 150 Q 510 170, 470 160 Q 440 140, 440 90"
                              fill="rgba(255,255,255,0.03)" stroke="rgba(255,255,255,0.1)" stroke-width="1"/>
                        <!-- Africa -->
                        <path d="M 460 180 Q 500 170, 540 200 Q 560 260, 540 330 Q 520 370, 490 360 Q 460 320, 450 260 Q 440 210, 460 180"
                              fill="rgba(255,255,255,0.03)" stroke="rgba(255,255,255,0.1)" stroke-width="1"/>
                        <!-- Asia -->
                        <path d="M 560 80 Q 650 60, 750 90 Q 800 120, 820 170 Q 810 220, 760 230 Q 700 220, 650 180 Q 600 150, 560 120 Q 550 100, 560 80"
                              fill="rgba(255,255,255,0.03)" stroke="rgba(255,255,255,0.1)" stroke-width="1"/>
                        <!-- Oceania -->
                        <path d="M 780 300 Q 830 280, 880 300 Q 910 330, 890 360 Q 860 380, 820 370 Q 780 350, 770 320 Q 770 310, 780 300"
                              fill="rgba(255,255,255,0.03)" stroke="rgba(255,255,255,0.1)" stroke-width="1"/>
                        
                        <!-- Connection lines between nodes -->
                        <g class="connection-lines" opacity="0.3">
                            <line x1="730" y1="155" x2="780" y2="120" stroke="#00d4ff" stroke-width="1" stroke-dasharray="4 4">
                                <animate attributeName="stroke-dashoffset" from="8" to="0" dur="1s" repeatCount="indefinite"/>
                            </line>
                            <line x1="730" y1="155" x2="680" y2="200" stroke="#00d4ff" stroke-width="1" stroke-dasharray="4 4">
                                <animate attributeName="stroke-dashoffset" from="8" to="0" dur="1.2s" repeatCount="indefinite"/>
                            </line>
                            <line x1="730" y1="155" x2="500" y2="115" stroke="#00d4ff" stroke-width="1" stroke-dasharray="4 4">
                                <animate attributeName="stroke-dashoffset" from="8" to="0" dur="1.5s" repeatCount="indefinite"/>
                            </line>
                            <line x1="500" y1="115" x2="200" y2="140" stroke="#00d4ff" stroke-width="1" stroke-dasharray="4 4">
                                <animate attributeName="stroke-dashoffset" from="8" to="0" dur="2s" repeatCount="indefinite"/>
                            </line>
                            <line x1="500" y1="115" x2="520" y2="240" stroke="#00d4ff" stroke-width="1" stroke-dasharray="4 4">
                                <animate attributeName="stroke-dashoffset" from="8" to="0" dur="1.4s" repeatCount="indefinite"/>
                            </line>
                            <line x1="200" y1="140" x2="240" y2="310" stroke="#00d4ff" stroke-width="1" stroke-dasharray="4 4">
                                <animate attributeName="stroke-dashoffset" from="8" to="0" dur="1.8s" repeatCount="indefinite"/>
                            </line>
                            <line x1="680" y1="200" x2="840" y2="320" stroke="#00d4ff" stroke-width="1" stroke-dasharray="4 4">
                                <animate attributeName="stroke-dashoffset" from="8" to="0" dur="1.6s" repeatCount="indefinite"/>
                            </line>
                        </g>
                        
                        <!-- CDN Nodes -->
                        <g v-for="(node, i) in cdnNodes" :key="'cdn-node-'+i" class="cdn-map-node">
                            <!-- Glow -->
                            <circle :cx="node.x" :cy="node.y" r="18" :fill="node.primary ? 'url(#nodeGlowGreen)' : 'url(#nodeGlow)'" class="node-glow-circle"/>
                            <!-- Pulse ring -->
                            <circle :cx="node.x" :cy="node.y" r="8" fill="none" :stroke="node.primary ? '#00ff88' : '#00f0ff'" stroke-width="1.5" opacity="0.6">
                                <animate attributeName="r" from="8" to="20" dur="2s" repeatCount="indefinite"/>
                                <animate attributeName="opacity" from="0.6" to="0" dur="2s" repeatCount="indefinite"/>
                            </circle>
                            <!-- Core dot -->
                            <circle :cx="node.x" :cy="node.y" :r="node.primary ? 6 : 4" :fill="node.primary ? '#00ff88' : '#00f0ff'" filter="url(#glow)"/>
                            <!-- Label -->
                            <text :x="node.x" :y="node.y - 14" text-anchor="middle" fill="white" font-size="11" font-weight="600">{{ node.name }}</text>
                            <text :x="node.x" :y="node.y + 24" text-anchor="middle" fill="rgba(255,255,255,0.5)" font-size="9">{{ node.latency }}</text>
                        </g>
                    </svg>
                </div>
                
                <!-- Node list -->
                <div class="cdn-nodes-list">
                    <div class="cdn-node-badge" v-for="(node, i) in cdnNodes" :key="'badge-'+i" :class="{ primary: node.primary }">
                        <span class="node-dot"></span>
                        <span class="node-name">{{ node.name }}</span>
                        <span class="node-latency-badge">{{ node.latency }}</span>
                    </div>
                </div>
            </div>
            
            <div class="cdn-features scroll-animate">
                <div class="cdn-feature-card" v-for="(item, i) in cdnFeatures" :key="i">
                    <span class="cdn-feature-icon">{{ item.icon }}</span>
                    <h4>{{ item.title }}</h4>
                    <p>{{ item.desc }}</p>
                </div>
            </div>
        </section>

        <!-- DDoS Scrubbing Section -->
        <section class="ddos-section">
            <h2 class="section-title text-gradient scroll-animate">🌊 DDoS 清洗中心</h2>
            <p class="section-subtitle scroll-animate">
                專業級流量清洗，多層防護機制抵禦大規模分散式攻擊
            </p>
            
            <div class="ddos-layers scroll-animate">
                <div class="ddos-layer" v-for="(layer, i) in ddosLayers" :key="i">
                    <div class="layer-shield">
                        <span class="layer-num">L{{ i + 1 }}</span>
                    </div>
                    <div class="layer-info">
                        <h4>{{ layer.name }}</h4>
                        <p>{{ layer.desc }}</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- GeoIP Smart Routing Section -->
        <section class="geoip-section">
            <h2 class="section-title text-gradient scroll-animate">🗺️ GeoIP 智能路由</h2>
            <p class="section-subtitle scroll-animate">
                基於地理位置的智能流量調度，就近接入最優節點
            </p>
            
            <div class="geoip-features scroll-animate">
                <div class="geoip-card" v-for="(item, i) in geoipFeatures" :key="i">
                    <div class="geoip-icon">{{ item.icon }}</div>
                    <h4>{{ item.title }}</h4>
                    <p>{{ item.desc }}</p>
                </div>
            </div>
        </section>

        <!-- Multi-Node Management Section -->
        <section class="multinode-section">
            <h2 class="section-title text-gradient scroll-animate">🏗️ 多節點分散式部署</h2>
            <p class="section-subtitle scroll-animate">
                全球多節點部署，集中管理與自動故障切換
            </p>
            
            <div class="node-grid scroll-animate">
                <div class="node-card" v-for="(node, i) in nodeExamples" :key="i" :class="node.status">
                    <div class="node-status-dot"></div>
                    <div class="node-icon">🛡️</div>
                    <h4>{{ node.name }}</h4>
                    <span class="node-region">{{ node.region }}</span>
                    <span class="node-latency">{{ node.latency }}</span>
                </div>
            </div>
        </section>

        <!-- ClamAV & Snort Integration Section -->
        <section class="security-engines-section">
            <h2 class="section-title text-gradient scroll-animate">🔬 進階安全引擎</h2>
            <p class="section-subtitle scroll-animate">
                整合 ClamAV 防毒掃描與 Snort 3 深度封包檢測
            </p>
            
            <div class="engines-grid scroll-animate">
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
                <div class="rbac-text scroll-animate">
                    <h2 class="section-title text-gradient">👥 角色權限管理</h2>
                    <p class="section-lead">精細化的 RBAC 存取控制，讓團隊協作更安全高效</p>
                    <ul class="rbac-features">
                        <li>🔐 角色型存取控制 (RBAC)</li>
                        <li>📋 站點級別權限分配</li>
                        <li>👁️ 操作日誌完整追蹤</li>
                        <li>🛡️ 最小權限原則</li>
                    </ul>
                </div>
                <div class="rbac-visual scroll-animate">
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
                </div>
            </div>
        </section>

        <!-- Architecture Section -->
        <section class="architecture">
            <h2 class="section-title text-gradient scroll-animate">技術架構</h2>
            <p class="section-subtitle scroll-animate">
                現代化技術堆疊，打造高效能防護系統
            </p>
            
            <div class="arch-diagram">
                <div class="arch-layer scroll-animate animate-hover-lift" v-for="(layer, index) in architecture" :key="index">
                    <span class="arch-layer-icon animate-float-slow">{{ layer.icon }}</span>
                    <div class="arch-layer-content">
                        <h4>{{ layer.title }}</h4>
                        <p>{{ layer.tech }}</p>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Why Choose Us Section -->
        <section class="comparison-section">
            <h2 class="section-title text-gradient scroll-animate">為什麼選擇 Security One SOC？</h2>
            <p class="section-subtitle scroll-animate">
                相較於傳統 WAF，我們提供更智能、更全面的防護
            </p>
            
            <div class="comparison-table scroll-animate">
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
            </div>
        </section>
        
        <!-- Deployment Section -->
        <section class="deploy-section">
            <h2 class="section-title text-gradient scroll-animate">快速部署</h2>
            <p class="section-subtitle scroll-animate">
                支援多種部署方式，5 分鐘即可上線
            </p>
            
            <div class="deploy-options scroll-animate">
                <div class="deploy-card" v-for="(option, index) in deployOptions" :key="index">
                    <div class="deploy-icon">{{ option.icon }}</div>
                    <h4>{{ option.title }}</h4>
                    <p>{{ option.desc }}</p>
                    <code>{{ option.command }}</code>
                </div>
            </div>
        </section>
        
        <!-- FAQ Section -->
        <section class="faq-section">
            <h2 class="section-title text-gradient scroll-animate">常見問題</h2>
            
            <div class="faq-list scroll-animate">
                <div class="faq-item" v-for="(faq, index) in faqs" :key="index" @click="toggleFaq(index)">
                    <div class="faq-question">
                        <span>{{ faq.q }}</span>
                        <span class="faq-toggle">{{ activeFaq === index ? '−' : '+' }}</span>
                    </div>
                    <Transition name="faq">
                        <div class="faq-answer" v-show="activeFaq === index">
                            {{ faq.a }}
                        </div>
                    </Transition>
                </div>
            </div>
        </section>
        
        <!-- CTA Section -->
        <section class="cta-section">
            <div class="cta-content scroll-animate">
                <h2 class="text-gradient">準備好保護您的網站了嗎？</h2>
                <p>立即聯繫我們，獲取專屬解決方案</p>
                <a href="mailto:service@cybersecureone.com?subject=Security One SOC 諮詢" class="btn btn-primary animate-glow">
                    📧 聯繫我們
                </a>
            </div>
        </section>
        
        <!-- Footer -->
        <footer class="footer">
            <div class="footer-logo text-gradient">Security One SOC</div>
            <p class="footer-text">個人版 統一安全平台</p>
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
const showcaseProgress = ref(0);
const currentSlide = ref(0);
const showcaseVisible = ref(false);
const slideProgress = ref(0);

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

// CDN Global Nodes
const cdnNodes = [
    { name: '台灣 (Origin)', x: 730, y: 155, latency: '1ms', primary: true },
    { name: '香港', x: 700, y: 180, latency: '12ms', primary: false },
    { name: '東京', x: 780, y: 120, latency: '25ms', primary: false },
    { name: '新加坡', x: 680, y: 200, latency: '35ms', primary: false },
    { name: '法蘭克福', x: 500, y: 115, latency: '150ms', primary: false },
    { name: '美西', x: 150, y: 140, latency: '160ms', primary: false },
    { name: '美東', x: 230, y: 140, latency: '180ms', primary: false },
    { name: '聖保羅', x: 260, y: 310, latency: '280ms', primary: false },
    { name: '約翰內斯堡', x: 520, y: 310, latency: '220ms', primary: false },
    { name: '雪梨', x: 840, y: 340, latency: '120ms', primary: false }
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
const attackTypes = [
    { icon: '💉', name: 'SQL Injection', desc: 'SQL 關鍵字、函數、語法結構偵測', targets: ['URL', 'Body', 'Header'] },
    { icon: '📜', name: 'XSS', desc: 'Script 標籤、事件處理器、協議繞過', targets: ['URL', 'Body'] },
    { icon: '⚙️', name: 'RCE', desc: 'Shell 命令注入、反向 Shell 嘗試', targets: ['URL', 'Body'] },
    { icon: '📁', name: 'Path Traversal', desc: '目錄跳轉序列、敏感檔案存取', targets: ['URL'] },
    { icon: '🔍', name: 'Scanner', desc: '已知掃描器特徵、自動化工具識別', targets: ['User-Agent'] },
    { icon: '☕', name: 'OGNL Injection', desc: 'Struts2 相關漏洞特徵', targets: ['URL', 'Body'] },
    { icon: '📦', name: 'Java Deser', desc: '序列化魔術位元組、Gadget Chain', targets: ['Body', 'Header'] },
    { icon: '🌐', name: 'SSRF', desc: '內網 IP 存取、雲端元數據 URL 偵測', targets: ['URL', 'Body'] },
    { icon: '📄', name: 'XXE', desc: 'XML 外部實體注入、DTD 宣告偵測', targets: ['Body', 'Header'] },
    { icon: '🔥', name: 'Log4Shell', desc: 'JNDI 注入模式、Log4j 漏洞偵測', targets: ['URL', 'Body', 'Header'] },
    { icon: '🕷️', name: 'WebShell', desc: '後門特徵碼、惡意執行函數偵測', targets: ['URL', 'Body'] },
    { icon: '🐘', name: 'PHP Injection', desc: 'PHP 函數注入、include/require 偵測', targets: ['URL', 'Body'] },
    { icon: '🔨', name: 'Brute Force', desc: '登入失敗頻率、暴力破解行為偵測', targets: ['Behavior'] }
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
    { q: 'AI 防禦需要什麼硬體配置？', a: 'AI 防禦使用 Ollama 運行本地 LLM，建議至少 16GB VRAM。如果不使用 AI 功能，2GB RAM 即可運行基本 WAF。' },
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
});
</script>

<style scoped>
.app-wrapper {
    position: relative;
    min-height: 100vh;
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
    max-width: 950px;
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
    max-width: 800px;
    max-height: 55vh;
    border-radius: 12px;
    overflow: hidden;
}

.showcase-image-wrapper img {
    width: 100%;
    height: auto;
    max-height: 55vh;
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

.world-map-svg {
    width: 100%;
    height: auto;
}

.cdn-map-node {
    cursor: default;
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

/* DDoS Section */
.ddos-section {
    padding: 6rem 2rem;
    position: relative;
    z-index: 1;
    background: linear-gradient(180deg, transparent, rgba(139, 92, 246, 0.05), transparent);
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
    background: linear-gradient(180deg, transparent 0%, rgba(255, 107, 107, 0.03) 50%, transparent 100%);
}

.attack-types-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 1.5rem;
    max-width: 1200px;
    margin: 0 auto;
}

.attack-type-card {
    background: rgba(255, 107, 107, 0.1);
    border: 1px solid rgba(255, 107, 107, 0.3);
    border-radius: 12px;
    padding: 1.5rem;
    text-align: center;
    transition: all 0.3s ease;
}

.attack-type-card:hover {
    transform: translateY(-5px);
    border-color: #ff6b6b;
    box-shadow: 0 0 30px rgba(255, 107, 107, 0.2);
}

.attack-icon {
    font-size: 2.5rem;
    margin-bottom: 1rem;
}

.attack-name {
    font-family: 'Orbitron', sans-serif;
    font-size: 0.9rem;
    color: #ff6b6b;
    margin-bottom: 0.5rem;
}

.attack-desc {
    font-size: 0.75rem;
    color: rgba(255, 255, 255, 0.6);
    margin-bottom: 0.75rem;
}

.attack-targets {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    justify-content: center;
}

.attack-targets span {
    font-size: 0.65rem;
    padding: 0.25rem 0.5rem;
    background: rgba(255, 107, 107, 0.2);
    border-radius: 50px;
    color: #ff6b6b;
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
}

.soc-panel {
    display: flex;
    flex-direction: column;
    gap: 1rem;
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
</style>
