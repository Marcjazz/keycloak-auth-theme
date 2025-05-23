<!DOCTYPE html>
<#ftl encoding='UTF-8'>
<#import "template.ftl" as layout> <#-- Standard Keycloak import -->
<html lang="${locale.currentLanguage}">

<head>
  <meta charset="UTF-8" />
  <title><#if realm.displayName??>${kcSanitize(realm.displayName)?no_esc}<#else>Keycloak</#if> - ${kcSanitize(msg("updatePasswordTitle"))?no_esc}</title>
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
  <div class="w-full max-w-md p-6 sm:p-8 space-y-6 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-2xl shadow-xl">

    <header class="text-center space-y-2">
      <#if properties.logoUrl?has_content>
        <img src="${properties.logoUrl}" alt="${kcSanitize(realm.displayName)?no_esc} Logo" class="h-12 mx-auto" loading="lazy">
      <#else>
        <#-- <img src="${url.resourcesPath}/img/logo.png" alt="Logo" class="h-12 mx-auto" loading="lazy"> -->
      </#if>
      <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">
        ${kcSanitize(msg("updatePasswordTitle"))?no_esc}
      </h1>
    </header>
    
    <#-- Display username if available -->
    <#if user.username?? || auth.attemptedUsername??>
      <div class="text-center text-sm text-gray-700 dark:text-gray-300">
        <p>${kcSanitize(msg("username"))?no_esc}: <span class="font-medium">${kcSanitize(user.username!auth.attemptedUsername)?no_esc}</span></p>
      </div>
    </#if>
    
    <#-- General informational message / instructions from Keycloak for this page, if any outside the main message block -->
    <#-- For example, if there's a specific instruction like "You must update your password to continue." -->
    <#-- This often comes in message.summary for this page -->

    <#if message?has_content>
      <div 
        id="kc-error-message-area" <#-- General error area, can be referenced by aria-describedby -->
        class="p-3 rounded-md text-sm border
          <#if message.type = 'success'>bg-green-50 border-green-300 text-green-700 dark:bg-green-900 dark:border-green-700 dark:text-green-300</#if>
          <#if message.type = 'warning'>bg-yellow-50 border-yellow-300 text-yellow-700 dark:bg-yellow-900 dark:border-yellow-700 dark:text-yellow-300</#if>
          <#if message.type = 'error'>bg-red-50 border-red-300 text-red-700 dark:bg-red-900 dark:border-red-700 dark:text-red-300</#if>
          <#if message.type = 'info'>bg-blue-50 border-blue-300 text-blue-700 dark:bg-blue-900 dark:border-blue-700 dark:text-blue-300</#if>"
        aria-live="polite"
        role="alert">
        <p>${kcSanitize(message.summary)?no_esc}</p>
      </div>
    </#if>

    <form id="kc-passwd-update-form" action="${url.loginAction}" method="post" class="space-y-5">
      <#-- Keep existing hidden fields for Keycloak functionality -->
      <#if kcSanitize(authSession.client.clientId)??> <#-- Check if client_id is available from authSession -->
          <input type="hidden" id="client_id" name="client_id" value="${kcSanitize(authSession.client.clientId)}"/>
      <#elseif client.clientId??> <#-- Fallback to older client.clientId if still present -->
          <input type="hidden" id="client_id" name="client_id" value="${client.clientId}"/>
      </#if>
      <#if tabId??>
        <input type="hidden" name="tab_id" value="${tabId}" />
      </#if>

      <div>
        <label for="password-new" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          ${kcSanitize(msg("passwordNew"))?no_esc} <span class="text-red-500 dark:text-red-400">*</span>
        </label>
        <input
          type="password"
          id="password-new"
          name="password-new"
          class="w-full px-4 py-2.5 border <#if messagesPerField.existsError('password-new')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
          autofocus
          aria-required="true"
          aria-invalid="${messagesPerField.existsError('password-new')?string('true','false')}"
          <#if messagesPerField.existsError('password-new')>aria-describedby="password-new-error"<#elseif passwordPoliciesView?has_content>aria-describedby="password-policies"</#if>
          autocomplete="new-password"
        />
        <#if messagesPerField.existsError('password-new')>
          <p id="password-new-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.getFirstError('password-new'))?no_esc}</p>
        <#elseif passwordPoliciesView?has_content>
          <div id="password-policies" class="mt-1.5 text-xs text-gray-600 dark:text-gray-400 space-y-1">
             <h4 class="font-medium text-gray-700 dark:text-gray-300">${kcSanitize(msg("passwordSubTitle"))?no_esc}</h4>
            ${kcSanitize(passwordPoliciesView)?no_esc} <#-- Ensure this output is styled if it contains raw HTML -->
          </div>
        </#if>
      </div>

      <div>
        <label for="password-confirm" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          ${kcSanitize(msg("passwordConfirm"))?no_esc} <span class="text-red-500 dark:text-red-400">*</span>
        </label>
        <input
          type="password"
          id="password-confirm"
          name="password-confirm"
          class="w-full px-4 py-2.5 border <#if messagesPerField.existsError('password-confirm')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
          aria-required="true"
          aria-invalid="${messagesPerField.existsError('password-confirm')?string('true','false')}"
          <#if messagesPerField.existsError('password-confirm')>aria-describedby="password-confirm-error"</#if>
          autocomplete="new-password"
        />
        <#if messagesPerField.existsError('password-confirm')>
          <p id="password-confirm-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}</p>
        </#if>
      </div>
      
      <button
        type="submit"
        class="w-full py-2.5 px-4 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:bg-blue-500 dark:hover:bg-blue-600 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
        ${kcSanitize(msg("doSubmit"))?no_esc} <#-- "doSubmit" is often used for generic submit actions -->
      </button>
    </form>

    <#if url.loginUrl?has_content> <#-- Conditionally show "Back to Login" if URL is available -->
    <div class="mt-6 pt-6 border-t border-gray-200 dark:border-gray-700 text-center">
      <p class="text-sm text-gray-600 dark:text-gray-400">
        <a href="${url.loginUrl}" class="font-medium text-blue-600 hover:underline dark:text-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 rounded-sm">
          ${kcSanitize(msg("backToLogin"))?no_esc}
        </a>
      </p>
    </div>
    </#if>

  </div>
</body>

</html>