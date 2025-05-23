<#include "template.ftl" encoding="UTF-8">

<@layout.mainLayout active='totp' title=kcSanitize(msg("authenticatorApplication"))>

    <div class="space-y-6">
        <header class="pb-4 border-b border-gray-200 dark:border-gray-700">
            <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">
                ${kcSanitize(msg("authenticatorApplication"))?no_esc}
            </h1>
            <p class="mt-1 text-sm text-gray-600 dark:text-gray-400">
                <#if totp.enabled>
                    ${kcSanitize(msg("manageRegisteredAuthenticators"))?no_esc} <#-- Example: "Manage your registered authenticator applications." -->
                <#else>
                    ${kcSanitize(msg("setupAuthenticatorDescription"))?no_esc} <#-- Example: "Set up your authenticator application for an extra layer of security." -->
                </#if>
            </p>
        </header>

        <#-- Global messages are handled by template.ftl. -->
        <#-- Field specific errors will be handled below -->

        <#if totp.enabled>
            <#-- View/Manage Existing TOTP Devices -->
            <section id="kc-totp-view" aria-labelledby="kc-totp-view-heading">
                <h2 id="kc-totp-view-heading" class="text-lg font-medium text-gray-900 dark:text-white mb-3">
                    ${kcSanitize(msg("yourRegisteredDevices"))?no_esc}
                </h2>
                <#if totp.otpCredentials?has_content>
                    <ul class="space-y-4">
                        <#list totp.otpCredentials as credential>
                            <li class="bg-white dark:bg-gray-800 shadow sm:rounded-lg p-4 sm:p-6">
                                <div class="flex items-center justify-between">
                                    <div>
                                        <p class="text-sm font-medium text-gray-900 dark:text-white">
                                            ${kcSanitize(credential.userLabel!"")?no_esc}
                                        </p>
                                        <p class="text-xs text-gray-500 dark:text-gray-400">
                                            ${kcSanitize(msg("addedOn"))?no_esc}: ${credential.createdDate?datetime?string.medium} <#-- Adjust date format as needed -->
                                        </p>
                                    </div>
                                    <form action="${url.totpUrl}" method="post">
                                        <input type="hidden" name="stateChecker" value="${stateChecker}">
                                        <input type="hidden" name="credentialIdToRemove" value="${credential.id}">
                                        <button type="submit" name="submitAction" value="REMOVE_OTP"
                                                class="px-3 py-1.5 text-sm font-medium text-red-600 dark:text-red-400 hover:text-red-800 dark:hover:text-red-300 hover:bg-red-50 dark:hover:bg-red-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 dark:focus:ring-offset-gray-800 transition-colors">
                                            ${kcSanitize(msg("doRemove"))?no_esc}
                                        </button>
                                    </form>
                                </div>
                            </li>
                        </#list>
                    </ul>
                <#else>
                    <p class="text-sm text-gray-600 dark:text-gray-400">${kcSanitize(msg("noRegisteredDevices"))?no_esc}</p>
                </#if>
                
                <#-- Keycloak traditionally replaces, but if a flow supports adding another, this button would be different. -->
                <#-- For standard behavior, removing the existing one enables the setup view again. -->
                 <#if !totp.otpCredentials?has_content> <#-- Show setup button if no devices are registered -->
                    <div class="mt-6">
                         <a href="${url.totpUrl}" <#-- This might need specific parameters if it's not just refreshing the page -->
                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:focus:ring-offset-gray-800">
                            ${kcSanitize(msg("setupAuthenticatorButton"))?no_esc}
                        </a>
                    </div>
                </#if>
            </section>

        <#else>
            <#-- Setup New TOTP Device -->
            <section id="kc-totp-setup" aria-labelledby="kc-totp-setup-heading">
                <div class="bg-white dark:bg-gray-800 shadow sm:rounded-lg p-6 sm:p-8">
                    <h2 id="kc-totp-setup-heading" class="text-lg font-medium text-gray-900 dark:text-white mb-1">
                        ${kcSanitize(msg("setupAuthenticatorStep1"))?no_esc} <#-- Example: "1. Scan QR Code" -->
                    </h2>
                    <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">
                        ${kcSanitize(msg("totpStep1AuthenticatorDetails"))?no_esc}
                    </p>

                    <div class="flex flex-col items-center md:flex-row md:items-start gap-6 mb-6">
                        <div class="p-2 border border-gray-200 dark:border-gray-700 rounded-md inline-block bg-white">
                             <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.qrCode}" alt="QR Code" class="w-48 h-48 md:w-56 md:h-56 object-contain">
                        </div>

                        <div>
                            <h3 class="text-md font-medium text-gray-900 dark:text-white mb-2">
                                ${kcSanitize(msg("totpManualSetup"))?no_esc}
                            </h3>
                            <dl class="space-y-1 text-sm text-gray-700 dark:text-gray-300">
                                <div>
                                    <dt class="inline font-semibold">${kcSanitize(msg("totpSecret"))?no_esc}: </dt>
                                    <dd class="inline break-all font-mono bg-gray-100 dark:bg-gray-700 px-1 py-0.5 rounded">${kcSanitize(totp.totpSecret)?no_esc}</dd>
                                </div>
                                <div>
                                    <dt class="inline font-semibold">${kcSanitize(msg("totpType"))?no_esc}: </dt>
                                    <dd class="inline">${kcSanitize(totp.policy.type)?no_esc}</dd>
                                </div>
                                <div>
                                    <dt class="inline font-semibold">${kcSanitize(msg("totpAlgorithm"))?no_esc}: </dt>
                                    <dd class="inline">${kcSanitize(totp.policy.algorithm!"SHA1")?no_esc}</dd>
                                </div>
                                <div>
                                    <dt class="inline font-semibold">${kcSanitize(msg("totpDigits"))?no_esc}: </dt>
                                    <dd class="inline">${totp.policy.digits}</dd>
                                </div>
                                <div>
                                    <dt class="inline font-semibold">${kcSanitize(msg("totpInterval"))?no_esc}: </dt>
                                    <dd class="inline">${totp.policy.period}</dd>
                                </div>
                            </dl>
                        </div>
                    </div>

                    <hr class="my-6 border-gray-200 dark:border-gray-700">

                    <h2 class="text-lg font-medium text-gray-900 dark:text-white mb-1">
                        ${kcSanitize(msg("setupAuthenticatorStep2"))?no_esc} <#-- Example: "2. Verify Code" -->
                    </h2>
                     <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">
                        ${kcSanitize(msg("totpStep2AuthenticatorDetails"))?no_esc}
                    </p>

                    <form id="kc-totp-settings-form" action="${url.totpUrl}" method="post" class="space-y-6">
                        <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">
                        <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}">
                        
                        <div>
                            <label for="totpCode" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                                ${kcSanitize(msg("authenticatorCode"))?no_esc} (${kcSanitize(msg("totpDigits", totp.policy.digits))?no_esc}) <span class="text-red-500 dark:text-red-400">*</span>
                            </label>
                            <input type="text" id="totpCode" name="totp"
                                   class="w-full max-w-xs px-4 py-2.5 border <#if messagesPerField.existsError('totp')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                                   autofocus
                                   aria-required="true"
                                   aria-invalid="${messagesPerField.existsError('totp')?string('true','false')}"
                                   <#if messagesPerField.existsError('totp')>aria-describedby="totp-error"</#if>
                                   autocomplete="one-time-code" />
                            <#if messagesPerField.existsError('totp')>
                                <p id="totp-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.getFirstError('totp'))?no_esc}</p>
                            </#if>
                        </div>

                        <div>
                            <label for="userLabel" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                                ${kcSanitize(msg("otpDeviceName"))?no_esc} <span class="text-red-500 dark:text-red-400">*</span>
                            </label>
                            <input type="text" id="userLabel" name="userLabel"
                                   class="w-full max-w-xs px-4 py-2.5 border <#if messagesPerField.existsError('userLabel')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                                   aria-required="true"
                                   aria-invalid="${messagesPerField.existsError('userLabel')?string('true','false')}"
                                   <#if messagesPerField.existsError('userLabel')>aria-describedby="userLabel-error"</#if> />
                            <#if messagesPerField.existsError('userLabel')>
                                <p id="userLabel-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.getFirstError('userLabel'))?no_esc}</p>
                            </#if>
                        </div>

                        <div class="flex flex-col sm:flex-row items-center gap-3 pt-4">
                            <button type="submit" name="submitAction" value="Save"
                                    class="w-full sm:w-auto py-2.5 px-6 bg-blue-600 text-white font-semibold rounded-lg shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:bg-blue-500 dark:hover:bg-blue-600 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
                                ${kcSanitize(msg("doSave"))?no_esc}
                            </button>
                            <a href="${url.accountUrl}" <#-- Or url.totpUrl if cancel should just refresh/clear form -->
                               class="w-full sm:w-auto py-2.5 px-6 text-center border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 font-semibold rounded-lg shadow-sm hover:bg-gray-50 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
                                ${kcSanitize(msg("doCancel"))?no_esc}
                            </a>
                        </div>
                    </form>
                </div>
            </section>
        </#if>
    </div>
</@layout.mainLayout>
