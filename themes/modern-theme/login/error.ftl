<!DOCTYPE html>
<#ftl encoding='UTF-8'>
<#import "template.ftl" as layout> <#-- Standard Keycloak import -->
<html lang="${locale.currentLanguage}">

<head>
    <meta charset="UTF-8" />
    <title><#if realm.displayName??>${kcSanitize(realm.displayName)?no_esc}<#else>Keycloak</#if> - ${kcSanitize(msg("errorTitle"))?no_esc}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="robots" content="noindex, nofollow">
    <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />
    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
</head>

<body class="flex items-center justify-center min-h-screen bg-gray-50 dark:bg-gray-900 p-4">
    <div class="w-full max-w-md p-6 sm:p-8 space-y-6 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl shadow-xl text-center">

        <header class="space-y-2"> <#-- Removed text-center from header as div is already text-center -->
            <#if properties.logoUrl?has_content>
                <img src="${properties.logoUrl}" alt="${kcSanitize(realm.displayName)?no_esc} Logo" class="h-12 mx-auto" loading="lazy">
            <#else>
                <#-- <img src="${url.resourcesPath}/img/logo.png" alt="Logo" class="h-12 mx-auto" loading="lazy"> -->
            </#if>
            <h1 class="text-2xl sm:text-3xl font-bold text-red-600 dark:text-red-500"> <#-- Error title specifically in red -->
                ${kcSanitize(messageHeader!msg("errorTitle"))?no_esc} <#-- Use messageHeader if available, fallback to errorTitle -->
            </h1>
        </header>

        <#if message?has_content && message.summary?has_content>
            <div 
              id="kc-error-message"
              class="p-3 rounded-md text-sm border bg-red-50 border-red-300 text-red-700 dark:bg-red-900 dark:border-red-700 dark:text-red-300"
              role="alert" 
              aria-live="assertive"> <#-- Assertive for important errors -->
                <p>${kcSanitize(message.summary)?no_esc}</p>
            </div>
        <#else> <#-- Fallback if message.summary is not available, but still want to indicate an error -->
             <div 
              id="kc-error-message"
              class="p-3 rounded-md text-sm border bg-red-50 border-red-300 text-red-700 dark:bg-red-900 dark:border-red-700 dark:text-red-300"
              role="alert" 
              aria-live="assertive">
                <p>${kcSanitize(msg("unknownError"))?no_esc}</p>
            </div>
        </#if>
        
        <#if client?? && client.baseUrl?has_content>
            <a href="${client.baseUrl}" class="inline-block w-full py-2.5 px-4 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:bg-blue-500 dark:hover:bg-blue-600 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
                ${kcSanitize(msg("backToApplication"))?no_esc}
            </a>
        <#elseif skipLink??> <#-- Fallback to skipLink if client.baseUrl is not available -->
             <#-- This case might be rare for error.ftl, but good to have a generic fallback if needed -->
        <#else> <#-- Fallback to loginUrl if no other link is present -->
            <a href="${url.loginUrl}" class="inline-block w-full py-2.5 px-4 bg-gray-600 text-white font-semibold rounded-lg hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 dark:bg-gray-500 dark:hover:bg-gray-600 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
                ${kcSanitize(msg("backToLogin"))?no_esc}
            </a>
        </#if>
    </div>
</body>

</html>