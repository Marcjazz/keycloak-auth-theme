<#ftl encoding='UTF-8'> <#-- THIS MUST BE LINE 1 -->
<#import "template.ftl" as layout>

<@layout.mainLayout active='log' title=msg("accountLogPageTitle")> <#-- kcSanitize removed from title -->

    <div class="space-y-6">
        <header class="pb-4 border-b border-gray-200 dark:border-gray-700">
            <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white">
                ${kcSanitize(msg("accountLogPageTitle"))?no_esc}
            </h1>
            <p class="mt-1 text-sm text-gray-600 dark:text-gray-400">
                ${kcSanitize(msg("accountLogPageDescription"))?no_esc} <#-- Example: "Review recent activity associated with your account." -->
            </p>
        </header>

        <#-- Global messages are handled by template.ftl -->

        <section id="kc-account-log" aria-labelledby="kc-account-log-heading">
            <h2 id="kc-account-log-heading" class="sr-only">${kcSanitize(msg("accountLogTableAccessibleName"))?no_esc}</h2> <#-- Example: "Detailed Account Activity Log" -->
            
            <#if log.events?has_content && log.events?size gt 0>
                <div class="overflow-x-auto bg-white dark:bg-gray-800 shadow sm:rounded-lg">
                    <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                        <thead class="bg-gray-50 dark:bg-gray-750">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                                    ${kcSanitize(msg("date"))?no_esc}
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                                    ${kcSanitize(msg("event"))?no_esc}
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                                    ${kcSanitize(msg("ipAddress"))?no_esc}
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                                    ${kcSanitize(msg("client"))?no_esc}
                                </th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-300 uppercase tracking-wider">
                                    ${kcSanitize(msg("details"))?no_esc}
                                </th>
                            </tr>
                        </thead>
                        <tbody class="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
                            <#list log.events as event>
                                <tr class="hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400">
                                        ${kcSanitize(event.date?datetime?string.medium)!'-'} <#-- Adjust date format as needed -->
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-gray-100">
                                        ${kcSanitize(msg("event." + event.event)!event.event)?no_esc}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400">
                                        ${kcSanitize(event.ipAddress!"-")?no_esc}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400">
                                        ${kcSanitize(event.clientId!"-")?no_esc}
                                    </td>
                                    <td class="px-6 py-4 text-sm text-gray-500 dark:text-gray-400 break-all"> <#-- break-all for long detail strings -->
                                        <#if event.details?has_content>
                                            <#list event.details?keys as key>
                                                <span class="font-medium">${kcSanitize(key)?no_esc}:</span> ${kcSanitize(event.details[key])?no_esc}<#if key_has_next>; </#if>
                                            </#list>
                                        <#else>
                                            -
                                        </#if>
                                    </td>
                                </tr>
                            </#list>
                        </tbody>
                    </table>
                </div>
            <#else>
                <div class="text-center py-12">
                    <svg class="mx-auto h-12 w-12 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                         <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M3 14h18m-9-4v8m-7 0h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" />
                    </svg>
                    <h2 class="mt-2 text-lg font-medium text-gray-900 dark:text-white">${kcSanitize(msg("accountLogNoEvents"))?no_esc}</h2>
                    <p class="mt-1 text-sm text-gray-500 dark:text-gray-400">${kcSanitize(msg("accountLogNoEventsDescription"))?no_esc}</p> <#-- Example: "There is no recent activity to display for your account." -->
                </div>
            </#if>
        </section>
    </div>
</@layout.mainLayout>
