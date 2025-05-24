<#ftl encoding='UTF-8'> <#-- THIS MUST BE LINE 1 -->
<#import "template.ftl" as layout>

<@layout.mainLayout 
    title=msg("loginTitle") <#-- kcSanitize removed -->
    header=(realm.displayNameHtml!(msg("loginTitle"))?no_esc) <#-- kcSanitize removed, ?no_esc kept for HTML var -->
>
    <#-- Main login form -->
    <form id="kc-login-form" action="${url.loginAction}" method="post" class="space-y-5">
      <div>
        <label for="username" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">${kcSanitize(msg("usernameOrEmail"))?no_esc}</label>
        <input
          type="text"
          id="username"
          name="username"
          value="${(login.username!'')}"
          placeholder="${kcSanitize(msg("usernameOrEmail"))?no_esc}"
          class="w-full px-4 py-2.5 border border-gray-300 dark:border-gray-600 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
          autofocus
          aria-required="true"
          aria-invalid="<#if message?has_content && message.type = 'error'>true<#else>false</#if>"
          <#if message?has_content && message.type = 'error'>aria-describedby="kc-feedback-message"</#if>
           />
      </div>
      
      <div>
        <div class="flex items-center justify-between mb-1.5">
          <label for="password" class="text-sm font-medium text-gray-700 dark:text-gray-300">${kcSanitize(msg("password"))?no_esc}</label>
          <#if realm.resetPasswordAllowed>
            <a href="${url.loginResetCredentialsUrl}" class="text-sm text-blue-600 hover:underline dark:text-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 rounded-sm">${kcSanitize(msg("doForgotPassword"))?no_esc}</a>
          </#if>
        </div>
        <input
          type="password"
          id="password"
          name="password"
          class="w-full px-4 py-2.5 border border-gray-300 dark:border-gray-600 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
          aria-required="true"
          aria-invalid="<#if message?has_content && message.type = 'error'>true<#else>false</#if>"
          <#if message?has_content && message.type = 'error'>aria-describedby="kc-feedback-message"</#if>
          />
      </div>

      <#if realm.rememberMe && !usernameHidden??>
        <div class="flex items-center justify-between">
          <div class="flex items-center">
            <input id="rememberMe" name="rememberMe" type="checkbox" <#if login.rememberMe??>checked</#if> 
                   class="h-4 w-4 text-blue-600 border-gray-300 dark:border-gray-600 rounded focus:ring-blue-500 dark:focus:ring-offset-gray-800 dark:bg-gray-700">
            <label for="rememberMe" class="ml-2 block text-sm text-gray-900 dark:text-gray-300">${kcSanitize(msg("doRememberMe"))?no_esc}</label>
          </div>
        </div>
      </#if>
      
      <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth?has_content && auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
      
      <button
        type="submit"
        name="login"
        id="kc-login"
        class="w-full py-2.5 px-4 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:bg-blue-500 dark:hover:bg-blue-600 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
        ${kcSanitize(msg("doLogIn"))?no_esc}
      </button>
    </form>

    <#-- Separator and Social Login / Registration Links -->
    <#if realm.registrationAllowed || (social.providers?? && social.providers?size > 0)>
    <div class="mt-6 pt-6 border-t border-gray-200 dark:border-gray-700 space-y-4">
      <#if social.providers?? && (social.providers?size > 0)>
        <div class="relative <#if realm.registrationAllowed>mb-4</#if>">
          <div class="absolute inset-0 flex items-center">
            <div class="w-full border-t border-gray-300 dark:border-gray-600"></div>
          </div>
          <div class="relative flex justify-center text-sm">
            <span class="px-2 bg-white dark:bg-gray-800 text-gray-500 dark:text-gray-400">${kcSanitize(msg("orContinueWith"))?no_esc}</span>
          </div>
        </div>

        <div id="kc-social-providers" class="space-y-3">
          <ul class="space-y-2">
            <#list social.providers as p>
              <li>
                <#assign base_social_classes = "flex items-center justify-center w-full px-4 py-2.5 border rounded-lg shadow-sm transition-colors duration-150 ease-in-out focus:outline-none focus:ring-2 focus:ring-offset-1 dark:focus:ring-offset-gray-800">
                <#assign default_social_classes = base_social_classes + " border-gray-300 dark:border-gray-600 hover:bg-gray-50 dark:hover:bg-gray-700 focus:ring-blue-500">
                <#assign google_social_classes = base_social_classes + " border-gray-300 dark:border-gray-600 hover:border-red-500 focus:border-red-500 dark:hover:border-red-400 dark:focus:border-red-400 hover:text-red-600 dark:hover:text-red-400 focus:ring-red-500 dark:focus:ring-red-400">
                <#assign github_social_classes = base_social_classes + " border-gray-300 dark:border-gray-600 hover:border-gray-800 focus:border-gray-800 dark:hover:border-gray-400 dark:focus:border-gray-400 hover:text-gray-800 dark:hover:text-gray-300 focus:ring-gray-700 dark:focus:ring-gray-600">
                
                <#assign provider_classes = default_social_classes>
                <#if p.alias == 'google'>
                    <#assign provider_classes = google_social_classes>
                <#elseif p.alias == 'github'>
                    <#assign provider_classes = github_social_classes>
                </#if>

                <a id="social-${p.alias}" href="${p.loginUrl}" class="${provider_classes}">
                  <#if p.iconClasses?has_content>
                    <i class="${properties.kcLogoClass!} ${p.iconClasses!} <#if p.iconHtmlClass?has_content>${p.iconHtmlClass!}</#if> text-lg" aria-hidden="true"></i>
                    <span class="ml-2.5 text-sm font-medium">${p.displayName}</span>
                  <#else>
                    <span class="text-sm font-medium">${p.displayName}</span>
                  </#if>
                </a>
              </li>
            </#list>
          </ul>
        </div>
      </#if>

      <#if realm.registrationAllowed>
        <div class="text-center text-sm text-gray-600 dark:text-gray-400 <#if social.providers?? && social.providers?size gt 0>mt-4 pt-4 border-t border-gray-200 dark:border-gray-700</#if>">
          ${kcSanitize(msg("noAccount"))?no_esc}
          <a href="${url.registrationUrl}" class="font-medium text-blue-600 hover:underline dark:text-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 rounded-sm">${kcSanitize(msg("doRegister"))?no_esc}</a>
        </div>
      </#if>
    </div>
    </#if>
</@layout.mainLayout>