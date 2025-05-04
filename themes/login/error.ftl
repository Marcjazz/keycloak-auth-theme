<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <title>Error</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="${url.resourcesPath}/css/style.css" rel="stylesheet" />
</head>

<body class="flex flex-col items-center justify-center min-h-screen bg-white">
    <div class="w-full max-w-md p-8 bg-white border rounded-2xl shadow-sm text-center">
        <div class="flex mb-6 text-center">
            <img src="${url.resourcesPath}/img/logo.png" alt="${realm.displayName}" class="h-12 mx-auto mb-2">
            <h2 class="text-lg font-semibold text-gray-800">
                ${realm.displayName}
            </h2>
        </div>
        <h1 class="text-2xl font-bold text-red-600 mb-4">An error occurred</h1>
        <#if message?has_content>
            <p class="text-sm text-gray-700 mb-6">
                ${kcSanitize(message.summary)?no_esc}
            </p>
        </#if>
        <a href="${url.loginUrl}" class="inline-block px-4 py-2 bg-black text-white rounded-md hover:bg-gray-900 transition-colors">
            Back to Login
        </a>
    </div>
</body>

</html>