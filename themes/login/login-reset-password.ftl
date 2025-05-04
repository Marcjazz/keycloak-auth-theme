<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <title>Forgot Password</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />
</head>

<body class="flex items-center justify-center min-h-screen bg-white">
  <div class="w-full max-w-md p-8 bg-white border rounded-2xl shadow-sm">
    <div class="flex mb-6 text-center">
      <img src="${url.resourcesPath}/img/logo.png" alt="${realm.displayName}" class="h-12 mx-auto mb-2">
      <h2 class="text-lg font-semibold text-gray-800">
        ${realm.displayName}
      </h2>
    </div>
    <h1 class="text-2xl font-bold mb-1">Reset your password</h1>
    <p class="text-sm text-gray-500 mb-6">We'll send you an email with instructions</p>
    <#if message?has_content>
      <div class="text-sm text-red-600 mb-4">
        ${kcSanitize(msg(message.summary))?no_esc}
      </div>
    </#if>
    <form action="${url.loginAction}" method="post" class="space-y-4">
      <input type="hidden" name="client_id" value="${client.clientId}" />
      <#if tabId??>
        <input type="hidden" name="tab_id" value="${tabId}" />
      </#if>
      <div>
        <label for="username" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
        <input
          type="text"
          id="username"
          name="username"
          class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-black focus:border-black"
          autofocus
          required />
      </div>
      <div>
        <button type="submit" class="w-full py-2 bg-black text-white rounded-md hover:bg-gray-900 transition-colors">
          Send instructions
        </button>
      </div>
    </form>
    <div class="text-center text-sm mt-6">
      <a href="${url.loginUrl}" class="text-black hover:underline">Back to login</a>
    </div>
  </div>
</body>

</html>