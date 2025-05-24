<#ftl encoding='UTF-8'> <#-- THIS MUST BE LINE 1 -->
<#import "template.ftl" as layout>

<@layout.mainLayout 
    title=msg("errorTitle") <#-- Removed kcSanitize -->
    header=(messageHeader!"") <#-- Pass messageHeader or empty string, template sanitizes -->
    bodyClass="flex items-center justify-center min-h-screen bg-gray-50 dark:bg-gray-900 p-4 text-center" 
>
    <#-- Override the header text provided by template.ftl if messageHeader is not desired, 
         or ensure template.ftl's header macro handles it. 
         For error.ftl, the title is often more prominent in the header.
         The provided template.ftl uses <#nested 'header'>, so we can pass it.
         Let's ensure the header text is the error title.
    -->
    <#assign pageHeader = kcSanitize(messageHeader!msg("errorTitle"))?no_esc> <#-- Default to errorTitle if messageHeader is not set -->
    <#-- The template.ftl already has <#nested 'header'>, so this will be used there.
         However, the template.ftl's header style is generic. For error.ftl, we want red text.
         The worker's previous error.ftl had specific red styling for the h1.
         We'll rely on the message display for error styling for now, or adjust template.ftl later if needed for header variants.
         The template.ftl header macro will use the 'header' parameter passed here.
    -->
    
    <#-- Error message display (already part of template.ftl, but error.ftl might have specific needs) -->
    <#-- The template.ftl handles global messages. If error.ftl needs additional specific formatting, 
         it can be added here. The existing template.ftl message block should cover it.
         If message.summary is empty, provide a fallback.
    -->
    <#if !(message?has_content && message.summary?has_content)>
         <div 
          id="kc-error-message-fallback"
          class="p-3 rounded-md text-sm border bg-red-50 border-red-300 text-red-700 dark:bg-red-900 dark:border-red-700 dark:text-red-300"
          role="alert" 
          aria-live="assertive">
            <p>${kcSanitize(msg("unknownError"))?no_esc}</p>
        </div>
    </#if>

    <#if client?? && client.baseUrl?has_content>
        <a href="${client.baseUrl}" class="inline-block w-full py-2.5 px-4 mt-4 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:bg-blue-500 dark:hover:bg-blue-600 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
            ${kcSanitize(msg("backToApplication"))?no_esc}
        </a>
    <#elseif skipLink??>
        <#-- No specific link for skipLink on error page usually -->
    <#else>
        <a href="${url.loginUrl}" class="inline-block w-full py-2.5 px-4 mt-4 bg-gray-600 text-white font-semibold rounded-lg hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 dark:bg-gray-500 dark:hover:bg-gray-600 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
            ${kcSanitize(msg("backToLogin"))?no_esc}
        </a>
    </#if>
</@layout.mainLayout>