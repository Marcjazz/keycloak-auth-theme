<#ftl encoding='UTF-8'> <#-- THIS MUST BE LINE 1 -->
<#import "template.ftl" as layout>

<@layout.mainLayout 
    title=kcSanitize(msg("emailForgotTitle")) 
    header=kcSanitize(msg("emailForgotTitle"))
>
    <p class="text-sm text-center text-gray-600 dark:text-gray-400">
      ${kcSanitize(msg("emailInstruction"))?no_esc}
    </p>

    <form id="kc-reset-password-form" action="${url.loginAction}" method="post" class="space-y-5">
      <#if kcSanitize(authSession.client.clientId)??>
          <input type="hidden" id="client_id" name="client_id" value="${kcSanitize(authSession.client.clientId)}"/>
      <#elseif client.clientId??>
          <input type="hidden" id="client_id" name="client_id" value="${client.clientId}"/>
      </#if>
      <#if tabId??>
        <input type="hidden" name="tab_id" value="${tabId}" />
      </#if>
      
      <div>
        <label for="username" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
          <#if realm.editUsernameAllowed>${kcSanitize(msg("usernameOrEmail"))?no_esc}<#else>${kcSanitize(msg("email"))?no_esc}</#if>
        </label>
        <input
          type="text"
          id="username"
          name="username"
          value="${(auth.attemptedUsername!'')}"
          placeholder="<#if realm.editUsernameAllowed>${kcSanitize(msg("usernameOrEmail"))?no_esc}<#else>${kcSanitize(msg("email"))?no_esc}</#if>"
          class="w-full px-4 py-2.5 border <#if message?has_content && message.type = 'error'>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
          autofocus
          aria-required="true"
          aria-invalid="<#if message?has_content && message.type = 'error'>true<#else>false</#if>"
          <#if message?has_content && message.type = 'error'>aria-describedby="kc-feedback-message"</#if>
          <#if realm.editUsernameAllowed>autocomplete="username"<#else>autocomplete="email"</#if>
        />
      </div>
      
      <button
        type="submit"
        class="w-full py-2.5 px-4 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:bg-blue-500 dark:hover:bg-blue-600 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
        ${kcSanitize(msg("doSubmit"))?no_esc}
      </button>
    </form>

    <div class="mt-6 pt-6 border-t border-gray-200 dark:border-gray-700 text-center">
      <p class="text-sm text-gray-600 dark:text-gray-400">
        <a href="${url.loginUrl}" class="font-medium text-blue-600 hover:underline dark:text-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 rounded-sm">
          ${kcSanitize(msg("backToLogin"))?no_esc}
        </a>
      </p>
    </div>
</@layout.mainLayout>