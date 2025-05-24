<#ftl encoding='UTF-8'> <#-- THIS MUST BE LINE 1 -->
<#import "template.ftl" as layout>

<@layout.mainLayout active='account' title=msg("pageNotFoundTitle")> <#-- kcSanitize removed from title -->

    <div class="text-center py-12">
        <#-- Optional: SVG Icon for "Not Found" -->
        <div class="mb-4">
            <svg class="mx-auto h-16 w-16 text-red-500 dark:text-red-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0zM9 16h6" /> <#-- Simple "confused face" or "error" icon -->
            </svg>
        </div>

        <h1 class="text-4xl font-extrabold text-gray-900 dark:text-white sm:text-5xl">
            ${kcSanitize(msg("pageNotFoundTitle"))?no_esc} <#-- Example: "Page Not Found" -->
        </h1>
        <p class="mt-4 text-base text-gray-600 dark:text-gray-400">
            ${kcSanitize(msg("pageNotFoundMessage", url.accountUrl))?no_esc} <#-- Example: "Sorry, we couldn’t find the page you’re looking for." Keycloak's default pageNotFoundMessage often includes a link to account -->
        </p>
        
        <div class="mt-8">
            <a href="${url.accountUrl}" 
               class="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
                ${kcSanitize(msg("backToAccount"))?no_esc}
            </a>
        </div>
    </div>

</@layout.mainLayout>
