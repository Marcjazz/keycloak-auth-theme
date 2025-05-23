<!DOCTYPE html>
<#ftl encoding='UTF-8'>
<#import "template.ftl" as layout> <#-- Standard Keycloak import -->
<html lang="${locale.currentLanguage}">

<head>
  <meta charset="UTF-8" />
  <title><#if realm.displayName??>${kcSanitize(realm.displayName)?no_esc}<#else>Keycloak</#if> - ${kcSanitize(msg("registerTitle"))?no_esc}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="robots" content="noindex, nofollow"> <#-- Good practice for registration pages -->
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
      <#-- Allow for realm logo or fallback to a generic one, consistent with login.ftl -->
      <#if properties.logoUrl?has_content>
        <img src="${properties.logoUrl}" alt="${kcSanitize(realm.displayName)?no_esc} Logo" class="h-12 mx-auto" loading="lazy">
      <#else>
        <#-- <img src="${url.resourcesPath}/img/logo.png" alt="Logo" class="h-12 mx-auto" loading="lazy"> -->
      </#if>
      <#if realm.displayNameHtml?? && realm.displayNameHtml?has_content> <#-- Use realm display name if available for context -->
        <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">
           ${kcSanitize(msg("registerTitle"))?no_esc}
        </h1>
         <p class="text-sm text-gray-600 dark:text-gray-400">${kcSanitize(realm.displayNameHtml)?no_esc}</p>
      <#else>
        <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">
          ${kcSanitize(msg("registerTitle"))?no_esc}
        </h1>
      </#if>
    </header>

    <#-- Global messages -->
    <#if message?has_content>
      <div 
        id="kc-error-message-area" <#-- ID for aria-describedby on fields if a general error relates to them -->
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

    <form id="kc-register-form" action="${url.registrationAction}" method="post" class="space-y-5">
      
      <#-- First Name -->
      <#if true> <#-- Assuming firstName is always part of the form unless explicitly configured otherwise in Keycloak -->
      <div>
        <label for="firstName" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          ${kcSanitize(msg("firstName"))?no_esc} 
          <#if свойства.requireFirstName!"false" == "true"> <#-- Hypothetical property to make it required, Keycloak usually manages this -->
            <span class="text-red-500 dark:text-red-400">*</span>
          </#if>
        </label>
        <input
          type="text"
          id="firstName"
          name="firstName"
          value="${(register.formData.firstName!'')}"
          placeholder="${kcSanitize(msg("firstName"))?no_esc}"
          class="w-full px-4 py-2.5 border <#if messagesPerField.exists('firstName')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
          aria-invalid="${messagesPerField.exists('firstName')?string('true','false')}"
          <#if messagesPerField.exists('firstName')>aria-describedby="firstName-error"</#if>
          <#if свойства.requireFirstName!"false" == "true">aria-required="true"</#if> 
        />
        <#if messagesPerField.exists('firstName')>
          <p id="firstName-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.get('firstName'))?no_esc}</p>
        </#if>
      </div>
      </#if>

      <#-- Last Name -->
      <#if true> <#-- Assuming lastName is always part of the form -->
      <div>
        <label for="lastName" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          ${kcSanitize(msg("lastName"))?no_esc}
           <#if свойства.requireLastName!"false" == "true"> <#-- Hypothetical property -->
            <span class="text-red-500 dark:text-red-400">*</span>
          </#if>
        </label>
        <input
          type="text"
          id="lastName"
          name="lastName"
          value="${(register.formData.lastName!'')}"
          placeholder="${kcSanitize(msg("lastName"))?no_esc}"
          class="w-full px-4 py-2.5 border <#if messagesPerField.exists('lastName')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
          aria-invalid="${messagesPerField.exists('lastName')?string('true','false')}"
          <#if messagesPerField.exists('lastName')>aria-describedby="lastName-error"</#if>
          <#if свойства.requireLastName!"false" == "true">aria-required="true"</#if>
        />
        <#if messagesPerField.exists('lastName')>
          <p id="lastName-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.get('lastName'))?no_esc}</p>
        </#if>
      </div>
      </#if>

      <#-- Email -->
      <div>
        <label for="email" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          ${kcSanitize(msg("email"))?no_esc} <span class="text-red-500 dark:text-red-400">*</span> <#-- Email is typically always required -->
        </label>
        <input
          type="email"
          id="email"
          name="email"
          value="${(register.formData.email!'')}"
          placeholder="${kcSanitize(msg("email"))?no_esc}"
          autocomplete="email"
          class="w-full px-4 py-2.5 border <#if messagesPerField.exists('email')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
          aria-required="true"
          aria-invalid="${messagesPerField.exists('email')?string('true','false')}"
          <#if messagesPerField.exists('email')>aria-describedby="email-error"</#if>
        />
        <#if messagesPerField.exists('email')>
          <p id="email-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.get('email'))?no_esc}</p>
        </#if>
      </div>

      <#-- Username -->
      <#if !(realm.registrationEmailAsUsername!) > <#-- Show if email is not used as username -->
      <div>
        <label for="username" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          ${kcSanitize(msg("username"))?no_esc} 
          <#if realm.registrationEmailAsUsername?has_content && !realm.registrationEmailAsUsername> <#-- Simplified: assume required if shown and not email -->
             <span class="text-red-500 dark:text-red-400">*</span>
          </#if>
        </label>
        <input
          type="text"
          id="username"
          name="username"
          value="${(register.formData.username!'')}"
          placeholder="${kcSanitize(msg("username"))?no_esc}"
          autocomplete="username"
          class="w-full px-4 py-2.5 border <#if messagesPerField.exists('username')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
          <#if realm.registrationEmailAsUsername?has_content && !realm.registrationEmailAsUsername>aria-required="true"</#if>
          aria-invalid="${messagesPerField.exists('username')?string('true','false')}"
          <#if messagesPerField.exists('username')>aria-describedby="username-error"</#if>
        />
        <#if messagesPerField.exists('username')>
          <p id="username-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.get('username'))?no_esc}</p>
        </#if>
      </div>
      </#if>
      
      
      <#-- Password -->
      <div>
        <label for="password" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          ${kcSanitize(msg("password"))?no_esc} <span class="text-red-500 dark:text-red-400">*</span>
        </label>
        <input
          type="password"
          id="password"
          name="password"
          autocomplete="new-password"
          class="w-full px-4 py-2.5 border <#if messagesPerField.exists('password')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
          aria-required="true"
          aria-invalid="${messagesPerField.exists('password')?string('true','false')}"
          <#if messagesPerField.exists('password')>aria-describedby="password-error"<#elseif passwordPoliciesView?has_content>aria-describedby="password-policies"</#if>
        />
        <#if messagesPerField.exists('password')>
          <p id="password-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.get('password'))?no_esc}</p>
        <#elseif passwordPoliciesView?has_content>
          <div id="password-policies" class="mt-1.5 text-xs text-gray-600 dark:text-gray-400 space-y-1">
            <h4 class="font-medium text-gray-700 dark:text-gray-300">${kcSanitize(msg("passwordSubTitle"))?no_esc}</h4>
            ${kcSanitize(passwordPoliciesView)?no_esc} <#-- Ensure this output is styled if it contains raw HTML (e.g. ul/li) -->
          </div>
        </#if>
      </div>

      <#-- Password Confirmation -->
      <div>
        <label for="password-confirm" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          ${kcSanitize(msg("passwordConfirm"))?no_esc} <span class="text-red-500 dark:text-red-400">*</span>
        </label>
        <input
          type="password"
          id="password-confirm"
          name="password-confirm"
          autocomplete="new-password"
          class="w-full px-4 py-2.5 border <#if messagesPerField.exists('password-confirm')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
          aria-required="true"
          aria-invalid="${messagesPerField.exists('password-confirm')?string('true','false')}"
          <#if messagesPerField.exists('password-confirm')>aria-describedby="password-confirm-error"</#if>
        />
        <#if messagesPerField.exists('password-confirm')>
          <p id="password-confirm-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</p>
        </#if>
      </div>
      
      <#-- Custom Profile Attributes -->
      <#if profile.attributes?has_content>
        <#list profile.attributes as attribute>
          <#if !(attribute.annotations.inputHidden?? && attribute.annotations.inputHidden?string('true','false') == 'true')> <#-- Check for hidden attribute annotation -->
            <div>
              <label for="${attribute.name}" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                ${kcSanitize(msg(attribute.displayName!attribute.name))?no_esc}
                <#if attribute.required><span class="text-red-500 dark:text-red-400">*</span></#if>
              </label>
              <#if attribute.annotations.inputType?? && attribute.annotations.inputType == 'textarea'>
                <textarea
                  id="${attribute.name}"
                  name="${attribute.name}"
                  class="w-full px-4 py-2.5 border <#if messagesPerField.existsError(attribute.name)>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors min-h-[80px]" <#-- Added min-h for textarea -->
                  <#if attribute.required>aria-required="true"</#if>
                  aria-invalid="${messagesPerField.existsError(attribute.name)?string('true','false')}"
                  <#if messagesPerField.existsError(attribute.name)>aria-describedby="${attribute.name}-error"</#if>
                >${(register.formData[attribute.name]!'')}</textarea>
              <#elseif attribute.annotations.inputType?? && attribute.annotations.inputType == 'select'>
                <select
                  id="${attribute.name}"
                  name="${attribute.name}"
                  class="w-full px-4 py-2.5 border <#if messagesPerField.existsError(attribute.name)>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 appearance-none pr-8 transition-colors" <#-- Added appearance-none and pr-8 for custom arrow overlay if needed -->
                  <#if attribute.required>aria-required="true"</#if>
                  aria-invalid="${messagesPerField.existsError(attribute.name)?string('true','false')}"
                  <#if messagesPerField.existsError(attribute.name)>aria-describedby="${attribute.name}-error"</#if>
                >
                  <#-- Add a default blank option if not required and no value selected, or as per desired UX -->
                  <#if !(attribute.required) && !(register.formData[attribute.name]?? && register.formData[attribute.name]?has_content) >
                    <option value="" selected disabled>${kcSanitize(msg("selectAnOption"))?no_esc}</option>
                  </#if>
                  <#if attribute.annotations.options?has_content>
                    <#list attribute.annotations.options?split('##') as optionValue>
                      <#assign actualOptionValue = optionValue?split('==')[0]> <#-- Allow for value==label format -->
                      <#assign displayOptionValue = kcSanitize(msg(optionValue?split('==')[1]!actualOptionValue))?no_esc >
                      <option value="${actualOptionValue}" <#if register.formData[attribute.name]!'_def_val_' == actualOptionValue>selected</#if>>${displayOptionValue}</option>
                    </#list>
                  </#if>
                </select>
              <#else> <#-- Default to text input, includes types like 'text', 'email', 'tel', etc. -->
                <input
                  type="${attribute.annotations.inputType!'text'}"
                  id="${attribute.name}"
                  name="${attribute.name}"
                  value="${(register.formData[attribute.name]!'')}"
                  class="w-full px-4 py-2.5 border <#if messagesPerField.existsError(attribute.name)>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                  <#if attribute.required>aria-required="true"</#if>
                  aria-invalid="${messagesPerField.existsError(attribute.name)?string('true','false')}"
                  <#if messagesPerField.existsError(attribute.name)>aria-describedby="${attribute.name}-error"</#if>
                />
              </#if>
              <#if messagesPerField.existsError(attribute.name)>
                <p id="${attribute.name}-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.getFirstError(attribute.name))?no_esc}</p>
              </#if>
            </div>
          </#if>
        </#list>
      </#if>

      <#-- reCAPTCHA -->
      <#if recaptchaRequired??>
        <div class="space-y-2"> <#-- Add some spacing for the reCAPTCHA element -->
          <div class="${properties.kcInputWrapperClass!}"> <#-- Standard Keycloak class, may not be strictly needed with Tailwind -->
            <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
            <#-- If there's a reCAPTCHA error, messagesPerField might contain it. -->
            <#if messagesPerField.exists('g-recaptcha-response')>
              <p id="g-recaptcha-response-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.get('g-recaptcha-response'))?no_esc}</p>
            </#if>
          </div>
        </div>
      </#if>
      
      <button
        type="submit"
        class="w-full py-2.5 px-4 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:bg-blue-500 dark:hover:bg-blue-600 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
        ${kcSanitize(msg("doRegister"))?no_esc}
      </button>
    </form>

    <div class="mt-6 pt-6 border-t border-gray-200 dark:border-gray-700 text-center">
      <p class="text-sm text-gray-600 dark:text-gray-400">
        ${kcSanitize(msg("alreadyHaveAccount"))?no_esc}
        <a href="${url.loginUrl}" class="font-medium text-blue-600 hover:underline dark:text-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 rounded-sm">
          ${kcSanitize(msg("doLogIn"))?no_esc}
        </a>
      </p>
    </div>

  </div>
</body>

</html>