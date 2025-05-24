<#ftl encoding='UTF-8'> <#-- THIS MUST BE LINE 1 -->
<#import "template.ftl" as layout>

<@layout.mainLayout active='applications' title=msg("applications")> <#-- kcSanitize removed from title -->

    <div class="space-y-6">
        <header class="pb-4 border-b border-gray-200 dark:border-gray-700">
            <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">
                ${kcSanitize(msg("applicationsPageTitle"))?no_esc} <#-- Using "applicationsPageTitle" for clarity -->
            </h1>
            <p class="mt-1 text-sm text-gray-600 dark:text-gray-400">
                ${kcSanitize(msg("applicationsPageDescription"))?no_esc} <#-- Example: "Manage applications that have access to your account." -->
            </p>
        </header>

        <#-- Global messages are handled by template.ftl -->

        <section id="kc-applications-list" aria-labelledby="kc-applications-list-heading">
            <#if applications.applications?has_content && applications.applications?size gt 0>
                <h2 id="kc-applications-list-heading" class="sr-only">${kcSanitize(msg("grantedApplicationsList"))?no_esc}</h2>
                <div class="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
                    <#list applications.applications as app>
                        <div class="bg-white dark:bg-gray-800 shadow-lg rounded-lg flex flex-col">
                            <div class="p-6 flex-grow">
                                <div class="flex items-start justify-between">
                                    <div class="flex items-start">
                                        <#if app.client.attributes.logoUri?has_content>
                                            <img src="${app.client.attributes.logoUri}" alt="${kcSanitize(app.client.name!app.client.clientId)?no_esc} Logo" class="h-12 w-12 rounded-md mr-4 object-contain bg-gray-100 dark:bg-gray-700 p-1">
                                        <#else>
                                            <#-- Placeholder Icon -->
                                            <div class="h-12 w-12 rounded-md mr-4 bg-gray-200 dark:bg-gray-700 flex items-center justify-center text-gray-400 dark:text-gray-500">
                                                <svg class="h-8 w-8" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" />
                                                </svg>
                                            </div>
                                        </#if>
                                        <div>
                                            <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                                                ${kcSanitize(app.client.name!app.client.clientId)?no_esc}
                                            </h3>
                                            <#if app.client.baseUrl?has_content>
                                                <a href="${app.client.baseUrl}" target="_blank" rel="noopener noreferrer" class="text-xs text-blue-600 dark:text-blue-400 hover:underline break-all">
                                                    ${kcSanitize(app.client.baseUrl)?no_esc}
                                                </a>
                                            </#if>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-4 space-y-2">
                                    <#if app.grantedConsentScopes?has_content && app.grantedConsentScopes?size gt 0>
                                        <div>
                                            <h4 class="text-xs font-medium uppercase text-gray-500 dark:text-gray-400">${kcSanitize(msg("grantedPermissions"))?no_esc}</h4>
                                            <ul class="mt-1 text-sm list-disc list-inside space-y-0.5 text-gray-700 dark:text-gray-300">
                                                <#list app.grantedConsentScopes as scope>
                                                    <li>${kcSanitize(scope)?no_esc}</li>
                                                </#list>
                                            </ul>
                                        </div>
                                    </#if>
                                    <#if app.additionalGrants?has_content && app.additionalGrants?size gt 0>
                                        <div>
                                            <h4 class="text-xs font-medium uppercase text-gray-500 dark:text-gray-400">${kcSanitize(msg("additionalGrants"))?no_esc}</h4>
                                            <ul class="mt-1 text-sm list-disc list-inside space-y-0.5 text-gray-700 dark:text-gray-300">
                                                <#list app.additionalGrants as scope>
                                                    <li>${kcSanitize(scope)?no_esc}</li>
                                                </#list>
                                            </ul>
                                        </div>
                                    </#if>
                                </div>
                                <p class="mt-3 text-xs text-gray-500 dark:text-gray-400">
                                    ${kcSanitize(msg("accessGrantedOn"))?no_esc}: ${kcSanitize(app.createdDate?datetime?string.medium)!'-'}
                                </p>
                            </div>
                            <div class="bg-gray-50 dark:bg-gray-750 px-6 py-3 border-t border-gray-200 dark:border-gray-700">
                                <form action="${url.applicationsUrl}" method="post" class="flex justify-end">
                                    <input type="hidden" name="stateChecker" value="${stateChecker}">
                                    <input type="hidden" id="clientId" name="clientId" value="${app.client.clientId}">
                                    <button type="submit" name="action" value="REVOKE_GRANT"
                                            class="px-3 py-1.5 text-xs font-medium text-red-600 dark:text-red-400 hover:text-red-800 dark:hover:text-red-300 hover:bg-red-100 dark:hover:bg-red-800 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-1 focus:ring-red-500 dark:focus:ring-offset-gray-800 transition-colors">
                                        ${kcSanitize(msg("doRevoke"))?no_esc}
                                    </button>
                                </form>
                            </div>
                        </div>
                    </#list>
                </div>
            <#else>
                <div class="text-center py-12">
                    <svg class="mx-auto h-12 w-12 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    <h2 class="mt-2 text-lg font-medium text-gray-900 dark:text-white">${kcSanitize(msg("noApplicationsGranted"))?no_esc}</h2>
                    <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">${kcSanitize(msg("noApplicationsGrantedDescription"))?no_esc}</p> <#-- Example: "You have not granted access to any applications yet." -->
                </div>
            </#if>
        </section>
    </div>
</@layout.mainLayout>
