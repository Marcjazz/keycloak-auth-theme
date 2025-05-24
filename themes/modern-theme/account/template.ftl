<#ftl encoding='UTF-8'>
<!DOCTYPE html>
<html lang="${locale.currentLanguage}" class="h-full">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="robots" content="noindex, nofollow">
    <title><#if realm.displayName??>${kcSanitize(realm.displayName)?no_esc}<#else>Keycloak</#if> - ${kcSanitize(title!msg("accountManagementTitle"))?no_esc}</title>
    <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />

    <#-- Favicon Configuration -->
    <#if properties.faviconUrl?has_content>
        <link rel="icon" href="${properties.faviconUrl}">
        <#-- Optional: Add other link types for different favicon sizes/formats if needed,
             e.g., <link rel="apple-touch-icon" href="${properties.appleTouchIconUrl}"> etc.
             For now, a single rel="icon" is sufficient. -->
    <#else>
        <#-- No specific theme favicon configured, browser will look for /favicon.ico at root,
             or Keycloak might provide its own default if any.
             Alternatively, a default bundled favicon could be linked here:
             <link rel="icon" href="${url.resourcesPath}/img/favicon.ico">
             For now, let's not assume a bundled default favicon exists yet. -->
    </#if>

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
</head>

<body class="bg-gray-100 dark:bg-gray-900 text-gray-900 dark:text-gray-100 h-full flex flex-col antialiased">

    <#-- Header -->
    <header class="bg-white dark:bg-gray-800 shadow-md sticky top-0 z-30">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-16">
                <div class="flex items-center">
                    <#if properties.logoUrl?has_content>
                        <img src="${properties.logoUrl}" alt="${kcSanitize(realm.displayName!'Keycloak')?no_esc} Logo" class="h-8 w-auto mr-3" loading="lazy">
                    </#if>
                    <a href="${url.accountUrl}" class="text-xl font-semibold text-gray-800 dark:text-white">
                        ${kcSanitize(realm.displayNameHtml!(msg("accountManagementTitle")))?no_esc}
                    </a>
                </div>
                <div class="flex items-center">
                    <#-- Mobile Menu Button -->
                    <button id="mobile-menu-button" type="button" class="lg:hidden inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-gray-500 hover:bg-gray-100 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-blue-500" aria-controls="mobile-menu" aria-expanded="false">
                        <span class="sr-only">${kcSanitize(msg("openMainNavigation"))?no_esc}</span>
                        <#-- Icon when menu is closed. Heroicon: menu -->
                        <svg class="block h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                        </svg>
                        <#-- Icon when menu is open. Heroicon: x -->
                        <svg class="hidden h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                    <a href="${url.logoutUrl}" class="hidden lg:inline-block ml-4 px-3 py-2 border border-transparent text-sm font-medium rounded-md text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                        ${kcSanitize(msg("doSignOut"))?no_esc}
                    </a>
                </div>
            </div>
        </div>
    </header>

    <div class="flex-grow container mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="lg:flex lg:space-x-6">
            <#-- Sidebar Navigation (Desktop) -->
            <aside class="hidden lg:block w-64">
                <nav class="space-y-1 sticky top-20"> <#-- sticky top-20 to account for header height -->
                    <#if navItems??>
                        <ul class="space-y-1">
                        <#list navItems as item>
                            <li>
                                <a href="${item.url}" class="flex items-center px-3 py-2.5 text-sm font-medium rounded-lg transition-colors
                                    <#if item.active>
                                        bg-blue-600 text-white shadow-sm
                                    <#else>
                                        text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700 hover:text-gray-900 dark:hover:text-white
                                    </#if>
                                    focus:outline-none focus:ring-2 focus:ring-blue-500"
                                   <#if item.active>aria-current="page"</#if>>
                                    ${kcSanitize(msg(item.label))?no_esc}
                                </a>
                            </li>
                        </#list>
                        </ul>
                    </#if>
                </nav>
            </aside>

            <#-- Main Content Area -->
            <main class="flex-1 min-w-0"> <#-- min-w-0 is important for flex item truncation -->
                <div class="bg-white dark:bg-gray-800 shadow-lg rounded-lg p-6 sm:p-8">
                    <#-- Feedback Messages -->
                    <#if message?has_content>
                        <div id="kc-feedback-message" class="mb-6 p-4 rounded-md text-sm border
                            <#if message.type = 'success'>bg-green-50 border-green-300 text-green-700 dark:bg-green-900 dark:border-green-700 dark:text-green-300</#if>
                            <#if message.type = 'warning'>bg-yellow-50 border-yellow-300 text-yellow-700 dark:bg-yellow-900 dark:border-yellow-700 dark:text-yellow-300</#if>
                            <#if message.type = 'error'>bg-red-50 border-red-300 text-red-700 dark:bg-red-900 dark:border-red-700 dark:text-red-300</#if>
                            <#if message.type = 'info'>bg-blue-50 border-blue-300 text-blue-700 dark:bg-blue-900 dark:border-blue-700 dark:text-blue-300</#if>"
                            role="alert">
                            <p>${kcSanitize(message.summary)?no_esc}</p>
                        </div>
                    </#if>
                    
                    <#-- Page specific content is injected here -->
                    <#nested>
                </div>
            </main>
        </div>
    </div>

    <#-- Mobile Menu (hidden by default, shown via JS) -->
    <div class="lg:hidden hidden" id="mobile-menu">
        <div class="fixed inset-0 bg-black bg-opacity-25 z-40" aria-hidden="true"></div>
        <div class="fixed inset-y-0 left-0 max-w-xs w-full bg-white dark:bg-gray-800 p-4 z-50 shadow-xl">
            <div class="flex items-center justify-between mb-4">
                <#if properties.logoUrl?has_content>
                    <img src="${properties.logoUrl}" alt="${kcSanitize(realm.displayName!'Keycloak')?no_esc} Logo" class="h-8 w-auto" loading="lazy">
                <#else>
                    <span class="text-lg font-semibold text-gray-800 dark:text-white">${kcSanitize(realm.displayNameHtml!(msg("accountManagementTitle")))?no_esc}</span>
                </#if>
                <button id="mobile-menu-close-button" type="button" class="p-1 rounded-md text-gray-400 hover:text-gray-500 hover:bg-gray-100 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <span class="sr-only">${kcSanitize(msg("closeMainNavigation"))?no_esc}</span>
                    <#-- Heroicon: x -->
                    <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                    </svg>
                </button>
            </div>
            <nav class="space-y-1">
                <#if navItems??>
                    <ul class="space-y-1">
                    <#list navItems as item>
                        <li>
                            <a href="${item.url}" class="block px-3 py-2.5 text-base font-medium rounded-lg
                                <#if item.active>
                                    bg-blue-600 text-white
                                <#else>
                                    text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700 hover:text-gray-900 dark:hover:text-white
                                </#if>
                                focus:outline-none focus:ring-2 focus:ring-blue-500"
                               <#if item.active>aria-current="page"</#if>>
                                ${kcSanitize(msg(item.label))?no_esc}
                            </a>
                        </li>
                    </#list>
                    </ul>
                </#if>
                <hr class="my-4 border-gray-200 dark:border-gray-700">
                <a href="${url.logoutUrl}" class="block w-full text-left px-3 py-2.5 text-base font-medium rounded-lg text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700 hover:text-gray-900 dark:hover:text-white focus:outline-none focus:ring-2 focus:ring-blue-500">
                    ${kcSanitize(msg("doSignOut"))?no_esc}
                </a>
            </nav>
        </div>
    </div>

    <#-- Simple Footer -->
    <footer class="bg-white dark:bg-gray-800 border-t border-gray-200 dark:border-gray-700 mt-auto">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8 py-4 text-center text-sm text-gray-500 dark:text-gray-400">
            &copy; ${(currentYear!"")} ${kcSanitize(realm.displayName!'Your Organization')?no_esc}. ${kcSanitize(msg("allRightsReserved"))?no_esc}
        </div>
    </footer>

    <script src="${url.resourcesPath}/js/main.js" defer></script>
</body>
</html>
