<#ftl encoding='UTF-8'> <#-- THIS MUST BE LINE 1 -->
<#import "template.ftl" as layout>

<@layout.mainLayout active='account' title=msg("editAccountProfilePageTitle")> <#-- kcSanitize removed from title -->

    <div class="space-y-6">
        <header class="pb-4 border-b border-gray-200 dark:border-gray-700">
            <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">
                ${kcSanitize(msg("editAccountProfilePageTitle"))?no_esc}
            </h1>
            <p class="mt-1 text-sm text-gray-600 dark:text-gray-400">
                ${kcSanitize(msg("editAccountProfilePageDescription"))?no_esc} <#-- Example: "Update your personal details and account information." -->
            </p>
        </header>

        <#-- Global messages are handled by template.ftl -->
        
        <form id="kc-profile-form" action="${url.accountUrl}" method="post" class="space-y-6">
            <input type="hidden" id="stateChecker" name="stateChecker" value="${stateChecker}">

            <#-- Username (Read-only) -->
            <div>
                <label for="username" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                    ${kcSanitize(msg("username"))?no_esc}
                </label>
                <input type="text" id="username" name="username" value="${kcSanitize(user.username!"")?no_esc}"
                       class="w-full px-4 py-2.5 border border-gray-300 dark:border-gray-600 rounded-lg shadow-sm bg-gray-100 dark:bg-gray-700 text-gray-500 dark:text-gray-400 cursor-not-allowed focus:outline-none focus:ring-0"
                       readonly disabled />
                <#if messagesPerField.existsError('username')> <#-- Usually username is not editable, but good practice -->
                    <p class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}</p>
                </#if>
            </div>

            <#-- Email -->
            <div>
                <label for="email" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                    ${kcSanitize(msg("email"))?no_esc} <#if profile.isEditEmailAllowed()><span class="text-red-500 dark:text-red-400">*</span></#if>
                </label>
                <input type="email" id="email" name="email" value="${kcSanitize(user.email!"")?no_esc}"
                       class="w-full px-4 py-2.5 border <#if messagesPerField.existsError('email')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                       <#if !profile.isEditEmailAllowed()>readonly disabled</#if> <#-- Check if email editing is allowed -->
                       aria-required="true" <#-- Email is typically always required -->
                       aria-invalid="${messagesPerField.existsError('email')?string('true','false')}"
                       <#if messagesPerField.existsError('email')>aria-describedby="email-error"</#if>
                       autocomplete="email" />
                <#if messagesPerField.existsError('email')>
                    <p id="email-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.getFirstError('email'))?no_esc}</p>
                </#if>
            </div>

            <#-- First Name -->
            <div>
                <label for="firstName" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                    ${kcSanitize(msg("firstName"))?no_esc} <#if profile.isEditFirstNameAllowed()><span class="text-red-500 dark:text-red-400">*</span></#if> <#-- Assuming a method to check if required -->
                </label>
                <input type="text" id="firstName" name="firstName" value="${kcSanitize(user.firstName!"")?no_esc}"
                       class="w-full px-4 py-2.5 border <#if messagesPerField.existsError('firstName')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                       <#if !profile.isEditFirstNameAllowed()>readonly disabled</#if> <#-- Check if first name editing is allowed -->
                       aria-required="<#if profile.isEditFirstNameAllowed()>true<#else>false</#if>" <#-- Adjust based on actual required logic -->
                       aria-invalid="${messagesPerField.existsError('firstName')?string('true','false')}"
                       <#if messagesPerField.existsError('firstName')>aria-describedby="firstName-error"</#if>
                       autocomplete="given-name" />
                <#if messagesPerField.existsError('firstName')>
                    <p id="firstName-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.getFirstError('firstName'))?no_esc}</p>
                </#if>
            </div>

            <#-- Last Name -->
            <div>
                <label for="lastName" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                    ${kcSanitize(msg("lastName"))?no_esc} <#if profile.isEditLastNameAllowed()><span class="text-red-500 dark:text-red-400">*</span></#if> <#-- Assuming a method to check if required -->
                </label>
                <input type="text" id="lastName" name="lastName" value="${kcSanitize(user.lastName!"")?no_esc}"
                       class="w-full px-4 py-2.5 border <#if messagesPerField.existsError('lastName')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                       <#if !profile.isEditLastNameAllowed()>readonly disabled</#if> <#-- Check if last name editing is allowed -->
                       aria-required="<#if profile.isEditLastNameAllowed()>true<#else>false</#if>" <#-- Adjust based on actual required logic -->
                       aria-invalid="${messagesPerField.existsError('lastName')?string('true','false')}"
                       <#if messagesPerField.existsError('lastName')>aria-describedby="lastName-error"</#if>
                       autocomplete="family-name" />
                <#if messagesPerField.existsError('lastName')>
                    <p id="lastName-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.getFirstError('lastName'))?no_esc}</p>
                </#if>
            </div>

            <#-- Custom User Attributes -->
            <#if profile.attributes?has_content>
                <#list profile.attributes as attribute>
                    <#if !attribute.rootAttribute && attribute.name != "username" && attribute.name != "email" && attribute.name != "firstName" && attribute.name != "lastName"> <#-- Exclude known attributes already handled -->
                        <div>
                            <label for="${attribute.name}" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                                ${kcSanitize(msg(attribute.displayName!attribute.name))?no_esc} <#if attribute.required><span class="text-red-500 dark:text-red-400">*</span></#if>
                            </label>
                            <#if attribute.readOnly>
                                <input type="text" id="${attribute.name}" name="user.attributes.${attribute.name}" value="${kcSanitize(attribute.value!"")?no_esc}"
                                       class="w-full px-4 py-2.5 border border-gray-300 dark:border-gray-600 rounded-lg shadow-sm bg-gray-100 dark:bg-gray-700 text-gray-500 dark:text-gray-400 cursor-not-allowed focus:outline-none focus:ring-0"
                                       readonly disabled />
                            <#else>
                                <#-- Basic input type handling. For select/multivalued, more complex rendering would be needed -->
                                <input type="text" id="${attribute.name}" name="user.attributes.${attribute.name}" value="${kcSanitize(attribute.value!"")?no_esc}"
                                       class="w-full px-4 py-2.5 border <#if messagesPerField.existsError("user.attributes." + attribute.name)>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                                       aria-required="${attribute.required?string('true','false')}"
                                       aria-invalid="${messagesPerField.existsError("user.attributes." + attribute.name)?string('true','false')}"
                                       <#if messagesPerField.existsError("user.attributes." + attribute.name)>aria-describedby="${attribute.name}-error"</#if> />
                            </#if>
                            <#if messagesPerField.existsError("user.attributes." + attribute.name)>
                                <p id="${attribute.name}-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">${kcSanitize(messagesPerField.getFirstError("user.attributes." + attribute.name))?no_esc}</p>
                            </#if>
                        </div>
                    </#if>
                </#list>
            </#if>

            <#-- Action Buttons -->
            <div class="flex flex-col sm:flex-row-reverse sm:items-center sm:justify-start gap-3 pt-4 border-t border-gray-200 dark:border-gray-700">
                <button type="submit" name="submitAction" value="UPDATE_PROFILE" <#-- Keycloak uses UPDATE_PROFILE for this form -->
                        class="w-full sm:w-auto py-2.5 px-6 bg-blue-600 text-white font-semibold rounded-lg shadow-sm hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:bg-blue-500 dark:hover:bg-blue-600 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
                    ${kcSanitize(msg("doSave"))?no_esc}
                </button>
                <a href="${url.accountUrl}" <#-- profile.cancelUrl might not always be available, accountUrl is safer -->
                   class="w-full sm:w-auto py-2.5 px-6 text-center border border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300 font-semibold rounded-lg shadow-sm hover:bg-gray-50 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
                    ${kcSanitize(msg("doCancel"))?no_esc}
                </a>
            </div>
        </form>
    </div>
</@layout.mainLayout>
