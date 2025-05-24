<#ftl encoding='UTF-8'>
    <#macro mainLayout title="" header="" bodyClass="" scripts=[]>
        <!DOCTYPE html>
        <html lang>

        <head>
            <meta charset="UTF-8" />
            <title>
                <#if realm.displayName?? && realm.displayName?has_content>
                    ${kcSanitize(realm.displayName)?no_esc}
                    <#else>Keycloak
                </#if> - ${kcSanitize(title)?no_esc}
            </title>
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
        <#-- Allow injecting additional scripts or links in head -->
        <#if scripts?has_content>
            <#list scripts as script>
                <#if script.type == "css">
                    <link href="${script.url}" rel="stylesheet" />
                <#elseif script.type == "javascript">
                    <script src="${script.url}" defer></script>
                </#if>
            </#list>
        </#if>
    </head>
    <body class="flex items-center justify-center min-h-screen bg-gray-50 dark:bg-gray-900 p-4">
        <div class="w-full max-w-md p-6 sm:p-8 space-y-6 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl shadow-xl">
            <header class="space-y-2 text-center">
                <#if properties.logoUrl?has_content>
                    <img src="${properties.logoUrl}" alt="${kcSanitize(realm.displayName!' Keycloak')?no_esc} Logo"
                    class="h-12 mx-auto" loading="lazy">
            </#if>
            <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">
                ${kcSanitize(header)?no_esc}
            </h1>
            </header>
            <#if message?has_content && message.summary?has_content>
                <div id="kc-feedback-message" class="p-3 rounded-md text-sm border 
                    <#if message.type == ' success'>bg-green-50 border-green-300 text-green-700 dark:bg-green-900 dark:border-green-700 dark:text-green-300
                    <#elseif message.type=='warning'>bg-yellow-50 border-yellow-300 text-yellow-700 dark:bg-yellow-900 dark:border-yellow-700 dark:text-yellow-300
                        <#elseif message.type=='error'>bg-red-50 border-red-300 text-red-700 dark:bg-red-900 dark:border-red-700 dark:text-red-300
                            <#else>bg-blue-50 border-blue-300 text-blue-700 dark:bg-blue-900 dark:border-blue-700 dark:text-blue-300
            </#if>" role="alert" <#if message.type=='error' || message.type=='warning'>aria-live="assertive"<#else>
                    aria-live="polite"
            </#if>>
            <p>
                ${kcSanitize(message.summary)?no_esc}
            </p>
            </div>
            </#if>
            <#-- Page specific content will be injected here -->
                <#nested>
                    </div>
                    <#-- Global JS for login theme, if any, would be linked here or in head. Currently, main.js is built
                        but not explicitly linked by default in this template. If needed: <script
                        src="${url.resourcesPath}/js/main.js" defer>
                        </script>
                        -->
                        </body>

        </html>
    </#macro>