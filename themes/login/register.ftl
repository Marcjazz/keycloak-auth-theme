
<!DOCTYPE html>
<html>
  <head>
    <title>Sign Up</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css" />
  </head>
  <body>
    <div class="container">
      <h1 class="title">Create an account</h1>
      <form action="${url.registrationAction}" method="post">
        <input type="text" name="firstName" placeholder="First name" value="${user.firstName!}" />
        <input type="text" name="lastName" placeholder="Last name" value="${user.lastName!}" />
        <input type="text" name="email" placeholder="Email" value="${user.email!}" />
        <input type="password" name="password" placeholder="Password" />
        <button type="submit">Register</button>
      </form>
      <a href="${url.loginUrl}">Back to login</a>
    </div>
  </body>
</html>
