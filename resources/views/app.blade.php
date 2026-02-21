<!DOCTYPE html>
<html lang="zh-TW">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Primary Meta Tags -->
        <title inertia>{{ config('app.name', 'Security One SOC') }}</title>
        <meta name="description" content="Security One SOC — 商業版統一安全平台。整合 WAF、IDS/IPS、AI 威脅偵測、DDoS 防護、CDN 加速、GeoIP 路由，提供 99.94% 攻擊攔截率的次世代資安解決方案。">
        <meta name="keywords" content="WAF, Web Application Firewall, SOC, Security Operations Center, DDoS防護, CDN加速, AI威脅偵測, IDS/IPS, 資安, 網站防護, GeoIP, 負載均衡, Security One, cybersecureone">
        <meta name="author" content="vito1317">
        <meta name="robots" content="index, follow">
        <link rel="canonical" href="https://cybersecureone.com">

        <!-- Open Graph / Facebook / LINE -->
        <meta property="og:type" content="website">
        <meta property="og:url" content="https://cybersecureone.com">
        <meta property="og:title" content="Security One SOC — 次世代統一安全平台">
        <meta property="og:description" content="整合 WAF、AI 威脅偵測、DDoS 防護、CDN 加速於一體，99.94% 攻擊攔截率。開箱即用的商業版資安解決方案。">
        <meta property="og:site_name" content="Security One SOC">
        <meta property="og:locale" content="zh_TW">

        <!-- Twitter Card -->
        <meta name="twitter:card" content="summary_large_image">
        <meta name="twitter:title" content="Security One SOC — 次世代統一安全平台">
        <meta name="twitter:description" content="整合 WAF、AI 威脅偵測、DDoS 防護、CDN 加速於一體，99.94% 攻擊攔截率。">

        <!-- Structured Data / JSON-LD -->
        <script type="application/ld+json">
        @verbatim
        {
            "@context": "https://schema.org",
            "@type": "SoftwareApplication",
            "name": "Security One SOC",
            "url": "https://cybersecureone.com",
            "description": "商業版統一安全平台，整合 WAF、IDS/IPS、AI 威脅偵測、DDoS 防護、CDN 加速、GeoIP 路由於一體的次世代資安解決方案。",
            "applicationCategory": "SecurityApplication",
            "operatingSystem": "Cloud",
            "author": {
                "@type": "Person",
                "name": "vito1317",
                "url": "https://vito1317.com"
            }
        }
        @endverbatim
        </script>

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;600;700;800;900&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

        @vite(['resources/css/app.css', 'resources/js/app.js'])
        @inertiaHead
    </head>
    <body>
        @inertia
    </body>
</html>
