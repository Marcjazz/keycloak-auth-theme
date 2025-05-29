<#ftl encoding='UTF-8'> <#-- THIS MUST BE LINE 1 -->
    <#import "template.ftl" as layout>

      <@layout.mainLayout title=msg("updatePasswordTitle") <#-- kcSanitize removed -->
        header=msg("updatePasswordTitle") <#-- kcSanitize removed -->
          >
          <#-- Display username if available -->
            <#if (user?? && user.username??) || (auth?? && auth.attemptedUsername??)>
              <div class="text-center text-sm text-gray-700 dark:text-gray-300 mb-4"> <#-- Added mb-4 for spacing -->
                  <p>${kcSanitize(msg("username"))?no_esc}: <span
                      class="font-medium">${kcSanitize(user.username!auth.attemptedUsername)?no_esc}</span></p>
              </div>
            </#if>

            <form id="kc-passwd-update-form" action="${url.loginAction}" method="post" class="space-y-5">
              <#if kcSanitize(authSession.client.clientId)??>
                <input type="hidden" id="client_id" name="client_id"
                  value="${kcSanitize(authSession.client.clientId)}" />
                <#elseif client.clientId??>
                  <input type="hidden" id="client_id" name="client_id" value="${client.clientId}" />
              </#if>
              <#if tabId??>
                <input type="hidden" name="tab_id" value="${tabId}" />
              </#if>

              <div>
                <label for="password-new" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                  ${kcSanitize(msg("passwordNew"))?no_esc} <span class="text-red-500 dark:text-red-400">*</span>
                </label>
                <input type="password" id="password-new" name="password-new"
                  class="w-full px-4 py-2.5 border <#if messagesPerField.existsError('password-new')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                  autofocus aria-required="true"
                  aria-invalid="${messagesPerField.existsError('password-new')?string('true','false')}" <#if
                  messagesPerField.existsError('password-new')>aria-describedby="password-new-error"<#elseif
                  passwordPoliciesView?has_content>aria-describedby="password-policies"</#if>
                  autocomplete="new-password"
                  />
                  <#if messagesPerField.existsError('password-new')>
                    <p id="password-new-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">
                      ${kcSanitize(messagesPerField.getFirstError('password-new'))?no_esc}</p>
                    <#elseif passwordPoliciesView?has_content>
                      <div id="password-policies" class="mt-1.5 text-xs text-gray-600 dark:text-gray-400 space-y-1">
                        <h4 class="font-medium text-gray-700 dark:text-gray-300">
                          ${kcSanitize(msg("passwordSubTitle"))?no_esc}</h4>
                        ${kcSanitize(passwordPoliciesView)?no_esc}
                      </div>
                  </#if>
              </div>

              <div>
                <label for="password-confirm" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                  ${kcSanitize(msg("passwordConfirm"))?no_esc} <span class="text-red-500 dark:text-red-400">*</span>
                </label>
                <input type="password" id="password-confirm" name="password-confirm"
                  class="w-full px-4 py-2.5 border <#if messagesPerField.existsError('password-confirm')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                  aria-required="true"
                  aria-invalid="${messagesPerField.existsError('password-confirm')?string('true','false')}" <#if
                  messagesPerField.existsError('password-confirm')>aria-describedby="password-confirm-error"</#if>
                autocomplete="new-password"
                />
                <#if messagesPerField.existsError('password-confirm')>
                  <p id="password-confirm-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">
                    ${kcSanitize(messagesPerField.getFirstError('password-confirm'))?no_esc}</p>
                </#if>
              </div>

              <button type="submit"
                class="w-full py-2.5 px-4 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:bg-blue-500 dark:hover:bg-blue-600 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
                ${kcSanitize(msg("doSubmit"))?no_esc}
              </button>
            </form>

            <#if url.loginUrl?has_content>
              <div class="mt-6 pt-6 border-t border-gray-200 dark:border-gray-700 text-center">
                <p class="text-sm text-gray-600 dark:text-gray-400">
                  <a href="${url.loginUrl}"
                    class="font-medium text-blue-600 hover:underline dark:text-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 rounded-sm">
                    ${kcSanitize(msg("backToLogin"))?no_esc}
                  </a>
                </p>
              </div>
            </#if>
      </@layout.mainLayout>