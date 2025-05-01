
<!DOCTYPE html>
<html>
  <head>
    <title>Update Password</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css" />
  </head>
  <body>
    <div class="container">
      <h1 class="title">Set a new password</h1>
      <form action="${url.loginAction}" method="post">
        <input type="password" name="password-new" placeholder="New password" />
        <input type="password" name="password-confirm" placeholder="Confirm new password" />
        <button type="submit">Update</button>
      </form>
    </div>
  </body>
</html>
