<#ftl encoding='UTF-8'>

<#macro mainLayout title="" active="" scripts=[] bodyClass=""> <#-- Ensure all needed params are here -->
    <!DOCTYPE html>
    <html lang="${locale.currentLanguage}" class="h-full">
    <head>
        <meta charset="UTF-8" />
        <title><#if realm.displayName?? && realm.displayName?has_content>${kcSanitize(realm.displayName)?no_esc}<#else>Keycloak</#if> - ${kcSanitize(title)?no_esc}</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="robots" content="noindex, nofollow">
        <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />
        <#if properties.meta?has_content>
            <#list properties.meta?split(' ') as meta>
                <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
            </#list>
        </#if>
        <#-- Favicon Configuration -->
        <#if properties.faviconUrl?has_content>
            <link rel="icon" href="${properties.faviconUrl}">
        </#if>
        <#-- Additional page-specific scripts/styles from macro parameter -->
        <#if scripts?has_content>
            <#list scripts as script>
                <#if script.type == "css">
                    <link href="${script.url}" rel="stylesheet" />
                <#elseif script.type == "javascript">
                    <script src="${script.url}" defer></script>
                </#if>
            </#list>
        </#if>
        <script src="${url.resourcesPath}/js/main.js" defer></script> <#-- Global JS for account theme -->
    </head>
    <#assign bodyClasses = bodyClass!"bg-gray-100 dark:bg-gray-900 text-gray-900 dark:text-white flex flex-col min-h-screen">
    <body class="${bodyClasses}">
        <#-- Combined Header (Desktop & Mobile Toggle) -->
        <header class="bg-white dark:bg-gray-800 shadow-md sticky top-0 z-30">
            <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex items-center justify-between h-16">
                    <div class="flex items-center">
                        <#if properties.logoUrl?has_content>
                            <img src="${properties.logoUrl}" alt="${kcSanitize(realm.displayName!'Keycloak')?no_esc} Logo" class="h-8 w-auto mr-3" loading="lazy">
                        <#else>
                             <#-- Fallback text if no logo, or a default SVG -->
                             <span class="font-semibold text-xl text-gray-800 dark:text-white">${kcSanitize(realm.displayName!'Account')?no_esc}</span>
                        </#if>
                        <#-- Desktop: Realm name or main title if logo is also present -->
                        <#if properties.logoUrl?has_content>
                             <a href="${url.accountUrl}" class="text-xl font-semibold text-gray-800 dark:text-white hidden lg:block">
                                ${kcSanitize(realm.displayNameHtml!(msg("accountManagementTitle")))?no_esc}
                            </a>
                        </#if>
                    </div>
                    <div class="flex items-center">
                        <button id="mobile-menu-button" type="button" class="lg:hidden inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-gray-500 hover:bg-gray-100 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-blue-500" aria-controls="mobile-menu" aria-expanded="false">
                            <span class="sr-only">${kcSanitize(msg("openMainNavigation"))?no_esc}</span>
                            <svg class="block h-6 w-6" id="menu-icon-open" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" /></svg>
                            <svg class="hidden h-6 w-6" id="menu-icon-close" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" /></svg>
                        </button>
                        <a href="${url.logoutUrl}" class="hidden lg:inline-block ml-4 px-3 py-2 border border-transparent text-sm font-medium rounded-md text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors">
                            ${kcSanitize(msg("doSignOut"))?no_esc}
                        </a>
                    </div>
                </div>
            </div>
        </header>

        <div class="flex-grow container mx-auto px-0 sm:px-6 lg:px-8"> <#-- Adjusted padding for full-width mobile menu -->
            <div class="lg:flex lg:space-x-6 py-8"> <#-- Added py-8 here -->
                <#-- Desktop Sidebar Navigation -->
                <aside id="desktop-sidebar" class="hidden lg:block w-64 flex-shrink-0">
                    <nav class="space-y-1 sticky top-24"> <#-- Adjusted top for sticky header -->
                        <#if navItems??>
                            <ul class="space-y-1">
                            <#list navItems as item>
                                <li>
                                    <a href="${item.url}" 
                                       class="flex items-center px-3 py-2.5 text-sm font-medium rounded-lg transition-colors
                                              <#if item.id == active>bg-blue-600 text-white dark:bg-blue-500 shadow-sm<#else>text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700 hover:text-gray-900 dark:hover:text-white</#if>
                                              focus:outline-none focus:ring-2 focus:ring-blue-500"
                                       aria-current="<#if item.id == active>page<#else>false</#if>">
                                        ${kcSanitize(msg(item.label))?no_esc}
                                    </a>
                                </li>
                            </#list>
                            </ul>
                        </#if>
                    </nav>
                </aside>

                <#-- Main Content Area -->
                <main class="flex-1 min-w-0">
                    <div class="bg-white dark:bg-gray-800 shadow-lg rounded-lg p-6 sm:p-8">
                        <#-- Global messages -->
                        <#if message?has_content && message.summary?has_content>
                            <div id="kc-feedback-message" class="mb-6 p-3 rounded-md text-sm border 
                                <#if message.type == 'success'>bg-green-50 border-green-300 text-green-700 dark:bg-green-900 dark:border-green-700 dark:text-green-300
                                <#elseif message.type == 'warning'>bg-yellow-50 border-yellow-300 text-yellow-700 dark:bg-yellow-900 dark:border-yellow-700 dark:text-yellow-300
                                <#elseif message.type == 'error'>bg-red-50 border-red-300 text-red-700 dark:bg-red-900 dark:border-red-700 dark:text-red-300
                                <#else>bg-blue-50 border-blue-300 text-blue-700 dark:bg-blue-900 dark:border-blue-700 dark:text-blue-300
                                </#if>"
                                role="alert" <#if message.type == 'error' || message.type == 'warning'>aria-live="assertive"<#else>aria-live="polite"</#if>>
                                <p>${kcSanitize(message.summary)?no_esc}</p>
                            </div>
                        </#if>
                        
                        <#-- Page specific content will be injected here -->
                        <#nested>
                    </div>
                </main>
            </div>
        </div>

        <#-- Mobile Menu (Overlay) -->
        <div id="mobile-menu" class="hidden fixed inset-0 z-40 lg:hidden" role="dialog" aria-modal="true">
            <div class="fixed inset-0 bg-black bg-opacity-50 transition-opacity" aria-hidden="true"></div> <#-- Overlay -->
            <div class="relative flex-1 flex flex-col max-w-xs w-full bg-white dark:bg-gray-800">
                <div class="absolute top-0 right-0 -mr-12 pt-2">
                    <button id="mobile-menu-close-button" type="button" class="ml-1 flex items-center justify-center h-10 w-10 rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white">
                        <span class="sr-only">${kcSanitize(msg("closeMenu"))?no_esc}</span>
                        <svg class="h-6 w-6 text-gray-600 dark:text-gray-300 group-hover:text-gray-800 dark:group-hover:text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" /></svg>
                    </button>
                </div>
                <div class="flex-1 h-0 pt-5 pb-4 overflow-y-auto">
                    <div class="flex-shrink-0 flex items-center px-4">
                         <#if properties.logoUrl?has_content>
                            <img src="${properties.logoUrl}" alt="${kcSanitize(realm.displayName!'Keycloak')?no_esc} Logo" class="h-8 w-auto" loading="lazy">
                        <#else>
                             <span class="font-semibold text-xl text-gray-800 dark:text-white">${kcSanitize(realm.displayName!'Account')?no_esc}</span>
                        </#if>
                    </div>
                    <nav class="mt-5 px-2 space-y-1">
                        <#if navItems??>
                            <#list navItems as item>
                                <a href="${item.url}" 
                                   class="block px-3 py-2 rounded-md text-base font-medium 
                                          <#if item.id == active>bg-blue-600 text-white dark:bg-blue-500<#else>text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 hover:text-gray-900 dark:hover:text-white</#if>"
                                   aria-current="<#if item.id == active>page<#else>false</#if>">
                                    ${kcSanitize(msg(item.label))?no_esc}
                                </a>
                            </#list>
                        </#if>
                        <hr class="my-3 border-gray-200 dark:border-gray-700">
                        <a href="${url.logoutUrl}" class="block px-3 py-2 rounded-md text-base font-medium text-gray-600 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700 hover:text-gray-900 dark:hover:text-white">${kcSanitize(msg("doSignOut"))?no_esc}</a>
                    </nav>
                </div>
            </div>
        </div>
        
        <footer class="py-4 px-4 sm:px-6 lg:px-8 border-t border-gray-200 dark:border-gray-700 bg-white dark:bg-gray-800 text-xs text-gray-500 dark:text-gray-400 text-center">
            &copy; ${(currentYear!"")} ${kcSanitize(realm.displayName!'Your Organization')?no_esc}. ${kcSanitize(msg("allRightsReserved"))?no_esc}
        </footer>
    </body>
    </html>
</#macro>
