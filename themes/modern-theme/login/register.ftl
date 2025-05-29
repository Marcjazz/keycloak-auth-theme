<#ftl encoding='UTF-8'>
  <#-- THIS MUST BE LINE 1 -->
    <#import "template.ftl" as layout>
      <#-- Determine header text: Use realm display name if available and different from "Keycloak" , otherwise
        use "Register" -->
        <@layout.mainLayout
          title=msg("registerTitle") <#-- kcSanitize removed -->
          header=((realm.displayNameHtml!"") + " - " + (msg("registerTitle")!"")) <#-- registrationHeader is already sanitized before this call -->
            >
            <#-- Registration Form -->
              <form id="kc-register-form" action="${url.registrationAction}" method="post" class="space-y-5">
                <#-- First Name -->
                  <#if true>
                    <#-- Assuming firstName is always part of the form -->
                      <div>
                        <label for="firstName"
                          class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                          ${kcSanitize(msg("firstName"))?no_esc}
                          <#-- New condition for displaying asterisk -->
                            <#assign firstNameAttr=(profile.attributes?filter(attr -> attr.name ==
                              "firstName")?first)!{}>
                              <#if firstNameAttr.required?? && firstNameAttr.required>
                                <span class="text-red-500 dark:text-red-400">*</span>
                              </#if>
                        </label>
                        <input type="text" id="firstName" name="firstName" value="${(register.formData.firstName!'')}"
                          placeholder="${kcSanitize(msg("firstName"))?no_esc}"
                          class="w-full px-4 py-2.5 border <#if messagesPerField.exists('firstName')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                          autocomplete="given-name"
                          aria-invalid="${messagesPerField.exists('firstName')?string('true','false')}" <#if
                          messagesPerField.exists('firstName')>aria-describedby="firstName-error"
                  </#if>
                  <#-- New condition for aria-required. Using a slightly more direct check on the pre-assigned
                    attribute -->
                    <#if firstNameAttr.required?? && firstNameAttr.required>aria-required="true"</#if>
                    />
                    <#if messagesPerField.exists('firstName')>
                      <p id="firstName-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">
                        ${kcSanitize(messagesPerField.get('firstName'))?no_esc}
                      </p>
                    </#if>
                    </div>
                    </#if>
                    <#-- Last Name -->
                      <#if true>
                        <#-- Assuming lastName is always part of the form -->
                          <div>
                            <label for="lastName"
                              class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                              ${kcSanitize(msg("lastName"))?no_esc}
                              <#-- New condition for displaying asterisk for lastName -->
                                <#assign lastNameAttr=(profile.attributes?filter(attr -> attr.name ==
                                  "lastName")?first)!{}>
                                  <#if lastNameAttr.required?? && lastNameAttr.required>
                                    <span class="text-red-500 dark:text-red-400">*</span>
                                  </#if>
                            </label>
                            <input type="text" id="lastName" name="lastName"
                              value="${(register.formData.lastName!'')}" placeholder="${kcSanitize(msg("
                                lastName"))?no_esc}"
                              class="w-full px-4 py-2.5 border <#if messagesPerField.exists('lastName')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                              autocomplete="family-name"
                              aria-invalid="${messagesPerField.exists('lastName')?string('true','false')}" <#if
                              messagesPerField.exists('lastName')>aria-describedby="lastName-error"
                      </#if>
                      <#-- New condition for aria-required for lastName -->
                        <#if lastNameAttr.required?? && lastNameAttr.required>aria-required="true"</#if>
                        />
                        <#if messagesPerField.exists('lastName')>
                          <p id="lastName-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">
                            ${kcSanitize(messagesPerField.get('lastName'))?no_esc}
                          </p>
                        </#if>
                        </div>
                        </#if>
                        <#-- Email -->
                          <div>
                            <label for="email"
                              class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                              ${kcSanitize(msg("email"))?no_esc}
                              <span class="text-red-500 dark:text-red-400">*</span>
                            </label>
                            <input type="email" id="email" name="email" value="${(register.formData.email!'')}"
                              placeholder="${kcSanitize(msg(" email"))?no_esc}" autocomplete="email"
                              class="w-full px-4 py-2.5 border <#if messagesPerField.exists('email')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                              aria-required="true"
                              aria-invalid="${messagesPerField.exists('email')?string('true','false')}" <#if
                              messagesPerField.exists('email')>aria-describedby="email-error"</#if>
                            />
                            <#if messagesPerField.exists('email')>
                              <p id="email-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">
                                ${kcSanitize(messagesPerField.get('email'))?no_esc}
                              </p>
                            </#if>
                          </div>
                          <#-- Username -->
                            <#if !(realm.registrationEmailAsUsername!)>
                              <div>
                                <label for="username"
                                  class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                                  ${kcSanitize(msg("username"))?no_esc}
                                  <#if realm.registrationEmailAsUsername?has_content &&
                                    !realm.registrationEmailAsUsername>
                                    <span class="text-red-500 dark:text-red-400">*</span>
                                  </#if>
                                </label>
                                <input type="text" id="username" name="username"
                                  value="${(register.formData.username!'')}" placeholder="${kcSanitize(msg("
                                    username"))?no_esc}" autocomplete="username"
                                  class="w-full px-4 py-2.5 border <#if messagesPerField.exists('username')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                                  <#if realm.registrationEmailAsUsername?has_content &&
                                  !realm.registrationEmailAsUsername>aria-required="true"
                            </#if>
                            aria-invalid="${messagesPerField.exists('username')?string('true','false')}"
                            <#if messagesPerField.exists('username')>aria-describedby="username-error"</#if>
                            />
                            <#if messagesPerField.exists('username')>
                              <p id="username-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">
                                ${kcSanitize(messagesPerField.get('username'))?no_esc}
                              </p>
                            </#if>
                            </div>
                            </#if>
                            <#-- Password -->
                              <div>
                                <label for="password"
                                  class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                                  ${kcSanitize(msg("password"))?no_esc}
                                  <span class="text-red-500 dark:text-red-400">*</span>
                                </label>
                                <input type="password" id="password" name="password" autocomplete="new-password"
                                  class="w-full px-4 py-2.5 border <#if messagesPerField.exists('password')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                                  aria-required="true"
                                  aria-invalid="${messagesPerField.exists('password')?string('true','false')}" <#if
                                  messagesPerField.exists('password')>aria-describedby="password-error"<#elseif
                                  passwordPoliciesView?has_content>aria-describedby="password-policies"</#if>
                                  />
                                  <#if messagesPerField.exists('password')>
                                    <p id="password-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">
                                      ${kcSanitize(messagesPerField.get('password'))?no_esc}
                                    </p>
                                    <#elseif passwordPoliciesView?has_content>
                                      <div id="password-policies"
                                        class="mt-1.5 text-xs text-gray-600 dark:text-gray-400 space-y-1">
                                        <h4 class="font-medium text-gray-700 dark:text-gray-300">
                                          ${kcSanitize(msg("passwordSubTitle"))?no_esc}
                                        </h4>
                                        ${kcSanitize(passwordPoliciesView)?no_esc}
                                      </div>
                                  </#if>
                                  <div id="password-strength-feedback" class="mt-1 text-xs"></div>
                              </div>
                              <#-- Password Confirmation -->
                                <div>
                                  <label for="password-confirm"
                                    class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                                    ${kcSanitize(msg("passwordConfirm"))?no_esc}
                                    <span class="text-red-500 dark:text-red-400">*</span>
                                  </label>
                                  <input type="password" id="password-confirm" name="password-confirm"
                                    autocomplete="new-password"
                                    class="w-full px-4 py-2.5 border <#if messagesPerField.exists('password-confirm')>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:text-white dark:focus:ring-blue-400 dark:focus:border-blue-400 transition-colors"
                                    aria-required="true"
                                    aria-invalid="${messagesPerField.exists('password-confirm')?string('true','false')}"
                                    <#if
                                    messagesPerField.exists('password-confirm')>aria-describedby="password-confirm-error"
                                  </#if>
                                  />
                                  <#if messagesPerField.exists('password-confirm')>
                                    <p id="password-confirm-error"
                                      class="mt-1.5 text-xs text-red-600 dark:text-red-400">
                                      ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                                    </p>
                                  </#if>
                                </div>
                                <#assign filteredAttributes=[]>
                                  <#list profile.attributes as attribute>
                                    <#if !(["firstName", "lastName" , "email" , "username" , "password" , "password-confirm" ]?seq_contains(attribute.name))>
                                      <#assign filteredAttributes=filteredAttributes + [attribute]>
                                    </#if>
                                  </#list>
                                  <#if filteredAttributes?has_content>
                                    <h2 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
                                      Custom Profile Attributes
                                    </h2>
                                    <#list filteredAttributes as attribute>
                                      <#if !(attribute.annotations.inputHidden?? && attribute.annotations.inputHidden?string('true','false')=='true' )>
                                        <div>
                                          <label for="${attribute.name}" class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1.5">
                                            ${kcSanitize(msg(attribute.displayName!attribute.name))?no_esc}
                                            <#if attribute.required><span class="text-red-500 dark:text-red-400">*</span></#if>
                                          </label>
                                          <#-- Textarea -->
                                            <#if attribute.annotations.inputType?? && attribute.annotations.inputType=='textarea'>
                                              <textarea id="${attribute.name}" name="${attribute.name}"
                                                class="w-full px-4 py-2.5 border <#if messagesPerField.existsError(attribute.name)>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white transition-colors min-h-[80px]"
                                                <#if attribute.required>aria-required="true"
                                            </#if>
                                            aria-invalid="${messagesPerField.existsError(attribute.name)?string('true','false')}"
                                            <#if messagesPerField.existsError(attribute.name)>aria-describedby="${attribute.name}-error"</#if>
                                            >
                                            ${register.formData[attribute.name]!''}
                                            </textarea>
                                            <#-- Select -->
                                              <#elseif attribute.annotations.inputType=='select'>
                                                <select id="${attribute.name}" name="${attribute.name}"
                                                  class="w-full px-4 py-2.5 border <#if messagesPerField.existsError(attribute.name)>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white transition-colors appearance-none pr-8"
                                                  <#if attribute.required>aria-required="true"
                                      </#if>
                                      aria-invalid="${messagesPerField.existsError(attribute.name)?string('true','false')}"
                                      <#if messagesPerField.existsError(attribute.name)>aria-describedby="${attribute.name}-error"</#if>
                                      >
                                      <#if !(attribute.required) && !(register.formData[attribute.name]?? && register.formData[attribute.name]?has_content)>
                                        <option value="" selected disabled>
                                          ${kcSanitize(msg("selectAnOption"))?no_esc}
                                        </option>
                                      </#if>
                                      <#if attribute.annotations.options?has_content>
                                        <#list attribute.annotations.options?split('##') as optionValue>
                                          <#assign actualOptionValue=optionValue?split('==')[0]
                                            >
                                            <#assign displayOptionValue = kcSanitize(msg(optionValue?split('==')[1]!actualOptionValue))?no_esc>
                                            <option value="${actualOptionValue}" <#if register.formData[attribute.name]!'' == actualOptionValue>selected</#if>>
                                              ${displayOptionValue}
                                            </option>
                                          </#list>
                                        </#if>
                                      </select>
                                    <#-- Input (default) -->
                                    <#else>
                                      <input type="${attribute.annotations.inputType!'text'}"
                                        id="${attribute.name}" name="${attribute.name}"
                                        value="${register.formData[attribute.name]!''}"
                                        class="w-full px-4 py-2.5 border <#if messagesPerField.existsError(attribute.name)>border-red-500 dark:border-red-400<#else>border-gray-300 dark:border-gray-600</#if> rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white transition-colors"
                                        <#if attribute.required>aria-required="true"</#if>
                                        aria-invalid="${messagesPerField.existsError(attribute.name)?string('true','false')}"
                                        <#if messagesPerField.existsError(attribute.name)>aria-describedby="${attribute.name}-error"</#if>
                                      />
                                    </#if>
                                    <#-- Error message -->
                                    <#if messagesPerField.existsError(attribute.name)>
                                      <p id="${attribute.name}-error" class="mt-1.5 text-xs text-red-600 dark:text-red-400">
                                        ${kcSanitize(messagesPerField.getFirstError(attribute.name))?no_esc}
                                      </p>
                                    </#if>
                                  </div>
                                </#if>
                              </#list>
                            </#if>
                                  <#-- reCAPTCHA -->
                                    <#if recaptchaRequired??>
                                      <div class="space-y-2">
                                        <div class="${properties.kcInputWrapperClass!}">
                                          <div class="g-recaptcha" data-size="compact"
                                            data-sitekey="${recaptchaSiteKey}"></div>
                                          <#if messagesPerField.exists(' g-recaptcha-response')>
                                            <p id="g-recaptcha-response-error"
                                              class="mt-1.5 text-xs text-red-600 dark:text-red-400">
                                              ${kcSanitize(messagesPerField.get('g-recaptcha-response'))?no_esc}
                                            </p>
                                      </#if>
                                      </div>
                                      </div>
                                  </#if>
                                  <button type="submit"
                                    class="w-full py-2.5 px-4 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 dark:bg-blue-500 dark:hover:bg-blue-600 dark:focus:ring-offset-gray-800 transition-colors duration-150 ease-in-out">
                                    ${kcSanitize(msg("doRegister"))?no_esc}
                                  </button>
              </form>
              <div class="mt-6 pt-6 border-t border-gray-200 dark:border-gray-700 text-center">
                <p class="text-sm text-gray-600 dark:text-gray-400">
                  ${kcSanitize(msg("alreadyHaveAccount"))?no_esc}
                  <a href="${url.loginUrl}"
                    class="font-medium text-blue-600 hover:underline dark:text-blue-400 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 rounded-sm">
                    ${kcSanitize(msg("doLogIn"))?no_esc}
                  </a>
                </p>
              </div>
        </@layout.mainLayout>