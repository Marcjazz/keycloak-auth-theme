
<!DOCTYPE html>
<html>
  <head>
    <title>Login</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css" />
  </head>
  <body>
    <div class="container">
      <h1 class="title">Login to your account</h1>
      <#if message?has_content><div class="error">${message.summary}</div></#if>
      <form action="${url.loginAction}" method="post">
        <input type="text" name="username" placeholder="Email" value="${login.username}" />
        <input type="password" name="password" placeholder="Password" />
        <button type="submit">Login</button>
      </form>
      <div class="flex justify-between">
        <a href="${url.registrationUrl}">Sign Up</a>
        <a href="${url.forgotPasswordUrl}">Forgot password?</a>
      </div>
      <#if realm.identityProviders??>
        <div class="mt-4 idp-buttons">
          <#list realm.identityProviders as idp>
            <#if idp.alias == "google" || idp.alias == "github">
              <a href="${url.loginAction}?providerId=${idp.alias}">
                Login with ${idp.displayName}
              </a>
            </#if>
          </#list>
        </div>
      </#if>
    </div>
  </body>
</html>
