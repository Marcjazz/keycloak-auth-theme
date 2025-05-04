<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <title>Sign Up</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />
</head>

<body class="flex items-center justify-center min-h-screen bg-white">
  <div class="w-full max-w-md p-8 bg-white border rounded-2xl shadow-sm">
    <div class="flex mb-6 text-center p-4">
      <img src="${url.resourcesPath}/img/logo.png" alt="${realm.displayName}" class="h-12 mx-auto mb-2">
      <h2 class="text-lg font-semibold text-gray-800">
        ${realm.displayName}
      </h2>
    </div>
    <h1 class="text-2xl font-bold mb-1">Create an account</h1>
    <p class="text-sm text-gray-500 mb-6">Enter your details below to create your account</p>
    <#if message?has_content>
      <div class="text-sm text-red-600 mb-4">
        ${kcSanitize(msg(message.summary))?no_esc}
      </div>
    </#if>
    <form action="${url.registrationAction}" method="post" class="space-y-4">
      <!-- First Name -->
      <div>
        <label for="firstName" class="block text-sm font-medium text-gray-700 mb-1">First Name</label>
        <input
          type="text"
          id="firstName"
          name="firstName"
          value="${(register.formData.firstName!'')}"
          class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-black focus:border-black"
          required />
      </div>
      <!-- Last Name -->
      <div>
        <label for="lastName" class="block text-sm font-medium text-gray-700 mb-1">Last Name</label>
        <input
          type="text"
          id="lastName"
          name="lastName"
          value="${(register.formData.lastName!'')}"
          class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-black focus:border-black"
          required />
      </div>
      <!-- Email -->
      <div>
        <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
        <input
          type="email"
          id="email"
          name="email"
          value="${(register.formData.email!'')}"
          class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-black focus:border-black"
          required />
      </div>
      <!-- Password -->
      <div>
        <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
        <input
          type="password"
          id="password"
          name="password"
          class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-black focus:border-black"
          required />
      </div>
      <!-- Confirm Password -->
      <div>
        <label for="password-confirm" class="block text-sm font-medium text-gray-700 mb-1">Confirm Password</label>
        <input
          type="password"
          id="password-confirm"
          name="password-confirm"
          class="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-black focus:border-black"
          required />
      </div>
      <button
        type="submit"
        class="w-full py-2 bg-black text-white rounded-md hover:bg-gray-900 transition-colors">
        Sign Up
      </button>
    </form>
    <div class="text-center text-sm mt-6">
      Already have an account?
      <a href="${url.loginUrl}" class="font-medium text-black hover:underline">Login</a>
    </div>
  </div>
</body>

</html>