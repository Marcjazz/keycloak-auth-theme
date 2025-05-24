<#ftl encoding='UTF-8'> <#-- THIS MUST BE LINE 1 -->
<#import "template.ftl" as layout>

<@layout.mainLayout active='password' title=msg("changePassword")> <#-- kcSanitize removed from title -->

    <div class="space-y-6">
        <header class="pb-4 border-b border-gray-200 dark:border-gray-700">
            <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">
                ${kcSanitize(msg("changePassword"))?no_esc}
            </h1>
            <p class="mt-1 text-sm text-gray-600 dark:text-gray-400">
                ${kcSanitize(msg("changePasswordDescription"))?no_esc} <#-- Example: "Update your account password. Choose a strong and unique password." -->
            </p>
        </header>

        <#-- Global messages are handled by template.ftl, but if needed specifically here, uncomment and adjust -->
        <#-- <#if message?has_content && message.type = 'error'>
            <div id="kc-error-message" class="p-3 mb-4 rounded-md text-sm border bg-red-50 border-red-300 text-red-700 dark:bg-red-900 dark:border-red-700 dark:text-red-300" role="alert">
                <p>${kcSanitize(message.summary)?no_esc}</p>
            </div>
        </#if> -->
        
        <form id="kc-passwd-form" action="${url.passwordUrl}" method="post" class="space-y-6">
            <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">

            <#-- Current Password -->
            <#if !password.set> <#-- This condition is typical for Keycloak when current password is required -->
            <div>
                <label for="password" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                    ${kcSanitize(msg("password"))?no_esc} <span class="text-red-500 dark:text-red-400">*</span>
                </label>
                <input type="password" id="password" name="password"
                       class="w-full px-4 py-2.5 border <#if messagesPerField.existsError('password')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                       autofocus
                       aria-required="true"
                       aria-invalid="${messagesPerField.existsError('password')?string('true','false')}"
                       <#if messagesPerField.existsError('password')>aria-describedby="password-error"</#if>
                       autocomplete="current-password" />
                <#if messagesPerField.existsError('password')>
                    <p id="password-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}</p>
                </#if>
            </div>
            </#if>

            <#-- New Password -->
            <div>
                <label for="password-new" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                    ${kcSanitize(msg("passwordNew"))?no_esc} <span class="text-red-500 dark:text-red-400">*</span>
                </label>
                <input type="password" id="password-new" name="password-new"
                       class="w-full px-4 py-2.5 border <#if messagesPerField.existsError('password-new')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                       aria-required="true"
                       aria-invalid="${messagesPerField.existsError('password-new')?string('true','false')}"
                       <#if messagesPerField.existsError('password-new')>aria-describedby="password-new-error"<#elseif passwordPoliciesView?has_content>aria-describedby="password-policies-info"</#if>
                       autocomplete="new-password" />
                <#if messagesPerField.existsError('password-new')>
                    <p id="password-new-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.getFirstError('password-new'))?no_esc}</p>
                <#elseif passwordPoliciesView?has_content>
                    <div id="password-policies-info" class="mt-2 text-xs text-gray-600 dark:text-gray-400 space-y-1">
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
                <input type="password" id="password-confirm" name="password-confirm"
                       class="w-full px-4 py-2.5 border <#if messagesPerField.existsError('password-confirm')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                       aria-required="true"
                       aria-invalid="${messagesPerField.existsError('password-confirm')?string('true','false')}"
                       <#if messagesPerField.existsError('password-confirm')>aria-describedby="password-confirm-error"</#if>
                       autocomplete="new-password" />
                <#if messagesPerField.existsError('password-confirm')>
                    <p id="password-confirm-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}</p>
                </#if>
            </div>

            <#-- Action Buttons -->
            <div class="flex flex-col sm:flex-row-reverse sm:items-center sm:justify-start gap-3 pt-4 border-t border-gray-200 dark:border-gray-700">
                <button type="submit" name="submitAction" value="SAVE"
                        class="w-full sm:w-auto py-2.5 px-6 bg-blue-600 text-white font-semibold rounded-lg shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:bg-blue-500 dark:hover:bg-blue-600 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
                    ${kcSanitize(msg("doSave"))?no_esc}
                </button>
                <#if password.cancelUrl?has_content>
                    <a href="${password.cancelUrl}"
                       class="w-full sm:w-auto py-2.5 px-6 text-center border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 font-semibold rounded-lg shadow-sm hover:bg-gray-50 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
                        ${kcSanitize(msg("doCancel"))?no_esc}
                    </a>
                <#else>
                     <a href="${url.accountUrl}"
                       class="w-full sm:w-auto py-2.5 px-6 text-center border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 font-semibold rounded-lg shadow-sm hover:bg-gray-50 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
                        ${kcSanitize(msg("doCancel"))?no_esc}
                    </a>
                </#if>
            </div>
        </form>
    </div>
</@layout.mainLayout>
