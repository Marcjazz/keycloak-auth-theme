<#ftl encoding='UTF-8'> <#-- THIS MUST BE LINE 1 -->
<#import "template.ftl" as layout>

<@layout.mainLayout active='account' title=msg("personalInfo")> <#-- kcSanitize removed from title -->

    <div class="space-y-6">
        <header class="pb-4 border-b border-gray-200 dark:border-gray-700">
            <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">
                ${kcSanitize(msg("personalInformation"))?no_esc} <#-- "personalInformation" is often more specific than "personalInfo" for a title -->
            </h1>
            <p class="mt-1 text-sm text-gray-600 dark:text-gray-400">
                ${kcSanitize(msg("personalInformationDescription"))?no_esc} <#-- Example: "View and manage your personal details." -->
            </p>
        </header>

        <div class="space-y-8">
            <#-- Personal Details Section -->
            <section aria-labelledby="personal-details-heading">
                <div class="bg-white dark:bg-gray-800 shadow sm:rounded-lg">
                    <div class="px-4 py-5 sm:px-6">
                        <h2 id="personal-details-heading" class="text-lg leading-6 font-medium text-gray-900 dark:text-white">
                            ${kcSanitize(msg("yourProfile"))?no_esc}
                        </h2>
                        <p class="mt-1 max-w-2xl text-sm text-gray-500 dark:text-gray-400">
                            ${kcSanitize(msg("yourProfileDescription"))?no_esc} <#-- Example: "Basic information associated with your account." -->
                        </p>
                    </div>
                    <div class="border-t border-gray-200 dark:border-gray-700 px-4 py-5 sm:p-0">
                        <dl class="sm:divide-y sm:divide-gray-200 dark:sm:divide-gray-700">
                            <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                    ${kcSanitize(msg("username"))?no_esc}
                                </dt>
                                <dd class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                                    ${kcSanitize(user.username!"")?no_esc}
                                </dd>
                            </div>

                            <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                    ${kcSanitize(msg("email"))?no_esc}
                                </dt>
                                <dd class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                                    ${kcSanitize(user.email!"-")?no_esc}
                                    <#if !(user.emailVerified?? && user.emailVerified)>
                                        <span class="ml-2 px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800 dark:bg-yellow-700 dark:text-yellow-100">
                                            ${kcSanitize(msg("emailNotVerified"))?no_esc}
                                        </span>
                                    </#if>
                                </dd>
                            </div>

                            <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                    ${kcSanitize(msg("firstName"))?no_esc}
                                </dt>
                                <dd class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                                    ${kcSanitize(user.firstName!"-")?no_esc}
                                </dd>
                            </div>

                            <div class="py-3 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                <dt class="text-sm font-medium text-gray-500 dark:text-gray-400">
                                    ${kcSanitize(msg("lastName"))?no_esc}
                                </dt>
                                <dd class="mt-1 text-sm text-gray-900 dark:text-white sm:mt-0 sm:col-span-2">
                                    ${kcSanitize(user.lastName!"-")?no_esc}
                                </dd>
                            </div>
                        </dl>
                    </div>
                </div>
            </section>

            <#-- Quick Actions Section (Optional) -->
            <section aria-labelledby="quick-actions-heading">
                 <div class="bg-white dark:bg-gray-800 shadow sm:rounded-lg">
                    <div class="px-4 py-5 sm:px-6">
                        <h2 id="quick-actions-heading" class="text-lg leading-6 font-medium text-gray-900 dark:text-white">
                            ${kcSanitize(msg("quickActions"))?no_esc}
                        </h2>
                        <p class="mt-1 max-w-2xl text-sm text-gray-500 dark:text-gray-400">
                            ${kcSanitize(msg("quickActionsDescription"))?no_esc} <#-- Example: "Common account management tasks." -->
                        </p>
                    </div>
                    <div class="border-t border-gray-200 dark:border-gray-700 px-4 py-5 sm:p-6">
                        <div class="grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-2 lg:grid-cols-3">
                            <#if url.passwordUrl?has_content>
                            <a href="${url.passwordUrl}" class="block p-4 text-center bg-gray-50 dark:bg-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 rounded-lg shadow-sm transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2 dark:focus:ring-offset-gray-800 focus:ring-blue-500">
                                <#-- Placeholder for an icon if you have an icon system -->
                                <div class="mb-2 flex justify-center items-center h-10 w-10 rounded-full bg-blue-100 dark:bg-blue-900 text-blue-600 dark:text-blue-300 mx-auto">
                                    <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" /></svg>
                                </div>
                                <p class="text-sm font-medium text-gray-900 dark:text-white">${kcSanitize(msg("changePassword"))?no_esc}</p>
                            </a>
                            </#if>

                            <#if url.totpUrl?has_content>
                            <a href="${url.totpUrl}" class="block p-4 text-center bg-gray-50 dark:bg-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 rounded-lg shadow-sm transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2 dark:focus:ring-offset-gray-800 focus:ring-blue-500">
                                <div class="mb-2 flex justify-center items-center h-10 w-10 rounded-full bg-blue-100 dark:bg-blue-900 text-blue-600 dark:text-blue-300 mx-auto">
                                   <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 18h.01M8 21h8a2 2 0 002-2V5a2 2 0 00-2-2H8a2 2 0 00-2 2v14a2 2 0 002 2z" /></svg>
                                </div>
                                <p class="text-sm font-medium text-gray-900 dark:text-white">${kcSanitize(msg("authenticatorApp"))?no_esc}</p>
                            </a>
                            </#if>
                            
                            <#if url.applicationsUrl?has_content>
                             <a href="${url.applicationsUrl}" class="block p-4 text-center bg-gray-50 dark:bg-gray-700 hover:bg-gray-100 dark:hover:bg-gray-600 rounded-lg shadow-sm transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2 dark:focus:ring-offset-gray-800 focus:ring-blue-500">
                                <div class="mb-2 flex justify-center items-center h-10 w-10 rounded-full bg-blue-100 dark:bg-blue-900 text-blue-600 dark:text-blue-300 mx-auto">
                                   <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" /></svg>
                                </div>
                                <p class="text-sm font-medium text-gray-900 dark:text-white">${kcSanitize(msg("applications"))?no_esc}</p>
                            </a>
                            </#if>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
</@layout.mainLayout>
