
<!DOCTYPE html>
<html>
  <head>
    <title>Forgot Password</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css" />
  </head>
  <body>
    <div class="container">
      <h1 class="title">Reset your password</h1>
      <form action="${url.loginAction}" method="post">
        <input type="text" name="username" placeholder="Email" />
        <button type="submit">Send reset instructions</button>
      </form>
      <a href="${url.loginUrl}">Back to login</a>
    </div>
  </body>
</html>
