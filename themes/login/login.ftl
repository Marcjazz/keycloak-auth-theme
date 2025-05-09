<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <title>Login</title>
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
    <h1 class="text-2xl font-bold mb-1">Login</h1>
    <p class="text-sm text-gray-500 mb-6">Enter your email below to login to your account</p>
    <#if message?has_content>
      <div class="text-sm text-red-600 mb-4">
        ${kcSanitize(msg(message.summary))?no_esc}
      </div>
    </#if>
    <form action="${url.loginAction}" method="post" class="space-y-4">
      <div>
        <label for="username" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
        <input
          type="text"
          id="username"
          name="username"
          value="${(login.username!'')}"
          placeholder="m@example.com"
          class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-black focus:border-black"
          autofocus />
      </div>
      <div>
        <div class="flex items-center justify-between mb-1">
          <label for="password" class="text-sm font-medium text-gray-700">Password</label>
          <a href="${url.loginResetCredentialsUrl}" class="text-sm text-gray-500 hover:underline">Forgot your password?</a>
        </div>
        <input
          type="password"
          id="password"
          name="password"
          class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-black focus:border-black" />
      </div>
      <input type="hidden" name="credentialId" value="${login.credentialId!}" />
      <button
        type="submit"
        class="w-full py-2 bg-black text-white rounded-md hover:bg-gray-900 transition-colors">
        Login
      </button>
    </form>
    <div class="text-center text-sm mt-6">
      Don’t have an account?
      <a href="${url.registrationUrl}" class="font-medium text-black hover:underline">Sign up</a>
    </div>
  </div>
</body>

</html>