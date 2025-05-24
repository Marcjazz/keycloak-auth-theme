<#include "template.ftl" encoding="UTF-8">

<@layout.mainLayout active='identity' title=kcSanitize(msg("federatedIdentityPageTitle"))>

    <div class="space-y-8">
        <header class="pb-4 border-b border-gray-200 dark:border-gray-700">
            <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">
                ${kcSanitize(msg("federatedIdentityPageTitle"))?no_esc}
            </h1>
            <p class="mt-1 text-sm text-gray-600 dark:text-gray-400">
                ${kcSanitize(msg("federatedIdentityPageDescription"))?no_esc} <#-- Example: "Manage your linked accounts from external identity providers." -->
            </p>
        </header>

        <#-- Global messages are handled by template.ftl -->

        <#-- Linked Identities Section -->
        <section id="kc-linked-identities" aria-labelledby="kc-linked-identities-heading">
            <h2 id="kc-linked-identities-heading" class="text-xl font-semibold text-gray-900 dark:text-white mb-4">
                ${kcSanitize(msg("linkedFederatedIdentities"))?no_esc}
            </h2>
            <#if identity.identities?has_content && identity.identities?size gt 0>
                <ul class="space-y-4">
                    <#list identity.identities as linkedIdentity>
                        <li class="bg-white dark:bg-gray-800 shadow sm:rounded-lg p-4 sm:p-6">
                            <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between">
                                <div class="mb-3 sm:mb-0">
                                    <p class="text-base font-medium text-gray-900 dark:text-white">
                                        ${kcSanitize(linkedIdentity.displayName!"")?no_esc}
                                    </p>
                                    <p class="text-sm text-gray-500 dark:text-gray-400">
                                        ${kcSanitize(linkedIdentity.userName!"")?no_esc}
                                    </p>
                                </div>
                                <form action="${url.identityUrl}" method="post">
                                    <input type="hidden" name="stateChecker" value="${stateChecker}">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="providerId" value="${linkedIdentity.identityProviderAlias}">
                                    <button type="submit"
                                            class="w-full sm:w-auto px-3 py-1.5 text-xs font-medium text-red-600 dark:text-red-400 hover:text-red-800 dark:hover:text-red-300 hover:bg-red-100 dark:hover:bg-red-800 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-1 focus:ring-red-500 dark:focus:ring-offset-gray-800 transition-colors">
                                        ${kcSanitize(msg("doRemove"))?no_esc}
                                    </button>
                                </form>
                            </div>
                        </li>
                    </#list>
                </ul>
            <#else>
                <div class="text-center py-8 border-2 border-dashed border-gray-300 dark:border-gray-700 rounded-lg">
                    <svg class="mx-auto h-10 w-10 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.828 10.172a4 4 0 00-5.656 0l-4 4a4 4 0 105.656 5.656l1.102-1.101m-.758-4.899a4 4 0 005.656 0l4-4a4 4 0 00-5.656-5.656l-1.1 1.1" />
                    </svg>
                    <h3 class="mt-2 text-sm font-medium text-gray-900 dark:text-white">${kcSanitize(msg("noLinkedFederatedIdentities"))?no_esc}</h3>
                    <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">${kcSanitize(msg("noLinkedFederatedIdentitiesDescription"))?no_esc}</p> <#-- Example: "You have not linked any external accounts yet." -->
                </div>
            </#if>
        </section>

        <#-- Link with Social Providers Section -->
        <#if identity.socialProviders?has_content && identity.socialProviders?size gt 0>
            <section id="kc-link-social" aria-labelledby="kc-link-social-heading" class="pt-8 mt-8 border-t border-gray-200 dark:border-gray-700">
                <h2 id="kc-link-social-heading" class="text-xl font-semibold text-gray-900 dark:text-white mb-4">
                    ${kcSanitize(msg("linkWithSocialProvider"))?no_esc}
                </h2>
                <div class="grid grid-cols-1 gap-4 sm:grid-cols-2 md:grid-cols-3">
                    <#list identity.socialProviders as provider>
                        <#assign base_social_classes = "flex items-center justify-center w-full px-4 py-3 border rounded-lg shadow-sm transition-colors duration-150 ease-in-out focus:outline-none focus:ring-2 focus:ring-offset-2 dark:focus:ring-offset-gray-800 text-sm font-medium">
                        <#assign default_social_classes = base_social_classes + " border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-200 hover:bg-gray-50 dark:hover:bg-gray-700 focus:ring-blue-500">
                        <#assign google_social_classes = base_social_classes + " border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-200 hover:border-red-500 focus:border-red-500 dark:hover:border-red-400 dark:focus:border-red-400 hover:text-red-600 dark:hover:text-red-400 focus:ring-red-500 dark:focus:ring-red-400">
                        <#assign github_social_classes = base_social_classes + " border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-200 hover:border-gray-800 focus:border-gray-800 dark:hover:border-gray-400 dark:focus:border-gray-400 hover:text-gray-800 dark:hover:text-gray-300 focus:ring-gray-700 dark:focus:ring-gray-600">
                        
                        <#assign provider_button_classes = default_social_classes>
                        <#if provider.alias == 'google'>
                            <#assign provider_button_classes = google_social_classes>
                        <#elseif provider.alias == 'github'>
                            <#assign provider_button_classes = github_social_classes>
                        </#if>
                        
                        <a href="${provider.loginUrl}" id="social-${provider.alias}" class="${provider_button_classes}">
                            <#-- Placeholder for social provider icons - real icons would need more setup (SVG, font, or specific classes from Keycloak if available) -->
                            <#if provider.alias == 'google'>
                                <svg class="w-5 h-5 mr-2 -ml-1" aria-hidden="true" focusable="false" data-prefix="fab" data-icon="google" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 488 512"><path fill="currentColor" d="M488 261.8C488 403.3 391.1 504 248 504 110.8 504 0 393.2 0 256S110.8 8 248 8c66.8 0 123 24.5 166.3 64.9l-67.5 64.9C258.5 52.6 94.3 116.6 94.3 256c0 86.5 69.1 156.6 153.7 156.6 98.2 0 135-70.4 140.8-106.9H248v-85.3h236.1c2.3 12.7 3.9 24.9 3.9 41.4z"></path></svg>
                            <#elseif provider.alias == 'github'>
                                 <svg class="w-5 h-5 mr-2 -ml-1" aria-hidden="true" focusable="false" data-prefix="fab" data-icon="github" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 496 512"><path fill="currentColor" d="M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.3zm44.2 4.5c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3.3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.3zm-67.8 14.8c-3.1 0-5.5 2.3-5.5 5.3 0 3 2.4 5.3 5.5 5.3s5.5-2.3 5.5-5.3c0-3-2.4-5.3-5.5-5.3zm-25.3 1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.3zM496 256c0 137-111 248-248 248S0 393 0 256 111 8 248 8s248 111 248 248zm-119.3-65.1c-11.5-10.7-29.7-11.5-46.5-2.9-4.5 2.3-9.1 5.2-14.3 8.7-12.1 8.4-26.6 15.4-42.8 20.4-16.1 4.9-33.6 7.5-52.1 7.5-18.5 0-36-2.6-52.1-7.5-16.2-5-30.7-12.1-42.8-20.4-5.2-3.6-9.8-6.4-14.3-8.7-16.8-8.7-35-7.8-46.5 2.9C1.7 206.8-3.5 229.2.4 250.8c3.9 21.6 19.1 39 40.1 45.3 1.8 2.4 10.5 10.2 10.5 10.2V391c0 13.4 10.8 24.2 24.2 24.2h18.2V301h-24.2c-6.6 0-12-5.4-12-12V256c0-6.6 5.4-12 12-12h24.2v-24.2c0-32.1 20.8-50.3 47.7-50.3 14.1 0 25.7 1 25.7 1V201h-18.2c-11.9 0-21.7 7.8-21.7 20.4v24.2h40.1c16.2 0 29.7 1.7 29.7 1.7s11.2-11.9 11.2-24.2c0-10.9-2.6-24.2-2.6-24.2s29.7-1.7 40.1-1.7c16.2 0 40.1 20.4 40.1 50.3v24.2h20.4c6.6 0 12 5.4 12 12v33.1c0 6.6-5.4 12-12 12h-20.4v90.2h18.2c13.4 0 24.2-10.8 24.2-24.2v-15.7s8.7-7.8 10.5-10.2c21-6.3 36.2-23.7 40.1-45.3 3.8-21.6-3.6-44-15.2-58.9z"></path></svg>
                            </#if>
                            ${kcSanitize(provider.displayName!"")?no_esc}
                        </a>
                    </#list>
                </div>
            </section>
        <#else>
            <#-- No social providers configured for linking, this section can be omitted or show a message -->
            <#-- <p class="text-sm text-gray-600 dark:text-gray-400">${kcSanitize(msg("noSocialProvidersAvailable"))?no_esc}</p> -->
        </#if>
    </div>
</@layout.mainLayout>
