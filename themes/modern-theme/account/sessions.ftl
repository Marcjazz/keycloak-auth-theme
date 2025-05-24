<#ftl encoding='UTF-8'> <#-- THIS MUST BE LINE 1 -->
<#import "template.ftl" as layout>

<@layout.mainLayout active='sessions' title=msg("sessions")> <#-- kcSanitize removed from title -->

    <div class="space-y-6">
        <header class="pb-4 border-b border-gray-200 dark:border-gray-700 flex flex-col sm:flex-row justify-between sm:items-center">
            <div>
                <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">
                    ${kcSanitize(msg("sessionsPageTitle"))?no_esc} <#-- Using "sessionsPageTitle" for clarity -->
                </h1>
                <p class="mt-1 text-sm text-gray-600 dark:text-gray-400">
                    ${kcSanitize(msg("sessionsPageDescription"))?no_esc} <#-- Example: "View and manage your active login sessions." -->
                </p>
            </div>
            <#if url.logoutAllUrl?has_content>
                <form action="${url.logoutAllUrl}" method="post" class="mt-4 sm:mt-0">
                    <input type="hidden" name="stateChecker" value="${stateChecker}">
                    <button type="submit"
                            class="w-full sm:w-auto px-4 py-2 text-sm font-medium text-white bg-red-600 hover:bg-red-700 dark:bg-red-500 dark:hover:bg-red-600 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 dark:focus:ring-offset-gray-800 transition-colors">
                        ${kcSanitize(msg("doSignOutAllSessions"))?no_esc}
                    </button>
                </form>
            </#if>
        </header>

        <#-- Global messages are handled by template.ftl -->

        <section id="kc-sessions-list" aria-labelledby="kc-sessions-list-heading">
            <#if sessions.sessions?has_content && sessions.sessions?size gt 0>
                <h2 id="kc-sessions-list-heading" class="sr-only">${kcSanitize(msg("activeSessionsList"))?no_esc}</h2>
                <div class="space-y-4">
                    <#list sessions.sessions as session>
                        <div class="bg-white dark:bg-gray-800 shadow sm:rounded-lg">
                            <div class="px-4 py-5 sm:px-6">
                                <div class="flex flex-col sm:flex-row justify-between sm:items-start">
                                    <div>
                                        <h3 class="text-lg leading-6 font-medium text-gray-900 dark:text-white">
                                            ${kcSanitize(msg("ipAddress"))?no_esc}: ${kcSanitize(session.ipAddress)?no_esc}
                                            <#if session.current>
                                                <span class="ml-2 px-2.5 py-0.5 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800 dark:bg-green-700 dark:text-green-100">
                                                    ${kcSanitize(msg("currentSession"))?no_esc}
                                                </span>
                                            </#if>
                                        </h3>
                                        <p class="mt-1 max-w-2xl text-sm text-gray-500 dark:text-gray-400">
                                            ${kcSanitize(msg("sessionStarted"))?no_esc}: ${kcSanitize(session.started?datetime?string.medium)!'-'} &bull;
                                            ${kcSanitize(msg("sessionLastAccessed"))?no_esc}: ${kcSanitize(session.lastAccess?datetime?string.medium)!'-'}
                                        </p>
                                    </div>
                                    <#if !session.current>
                                        <form action="${url.sessionsUrl}" method="post" class="mt-3 sm:mt-0 sm:ml-4">
                                            <input type="hidden" name="stateChecker" value="${stateChecker}">
                                            <input type="hidden" name="sessionId" value="${session.id}">
                                            <button type="submit" name="action" value="logoutSession"
                                                    class="w-full sm:w-auto px-3 py-1.5 text-xs font-medium text-red-600 dark:text-red-400 hover:text-red-800 dark:hover:text-red-300 hover:bg-red-50 dark:hover:bg-red-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-1 focus:ring-red-500 dark:focus:ring-offset-gray-800 transition-colors">
                                                ${kcSanitize(msg("doSignOut"))?no_esc}
                                            </button>
                                        </form>
                                    </#if>
                                </div>
                            </div>
                            <#if session.clients?has_content && session.clients?size gt 0>
                                <div class="border-t border-gray-200 dark:border-gray-700 px-4 py-4 sm:px-6">
                                    <h4 class="text-xs font-medium uppercase text-gray-500 dark:text-gray-400 mb-2">${kcSanitize(msg("clients"))?no_esc}</h4>
                                    <ul class="text-sm space-y-1">
                                        <#list session.clients as client>
                                            <li class="text-gray-700 dark:text-gray-300 truncate" title="${kcSanitize(client.clientId)?no_esc}">
                                                ${kcSanitize(client.clientName!client.clientId)?no_esc} <#-- Display clientName if available, fallback to clientId -->
                                            </li>
                                        </#list>
                                    </ul>
                                </div>
                            </#if>
                        </div>
                    </#list>
                </div>
            <#else>
                <div class="text-center py-8">
                    <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                        <path vector-effect="non-scaling-stroke" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    </svg>
                    <h2 class="mt-2 text-lg font-medium text-gray-900 dark:text-white">${kcSanitize(msg("noOtherSessions"))?no_esc}</h2>
                    <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">${kcSanitize(msg("noOtherSessionsDescription"))?no_esc}</p> <#-- Example: "You are only signed in with your current browser session." -->
                </div>
            </#if>
        </section>
    </div>
</@layout.mainLayout>
