<!DOCTYPE html>
<html>
<head>
    <title>Register / Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-4">

<h2 class="mb-3">Register</h2>
<form action="RegisterUserServlet" method="post" class="mb-4">
    <div class="mb-2"><input class="form-control" type="number" name="id" placeholder="ID (Enter manually)" required></div>
    <div class="mb-2"><input class="form-control" type="text" name="username" placeholder="Username" required></div>
    <div class="mb-2"><input class="form-control" type="password" name="password" placeholder="Password" required></div>
    <div class="mb-2">
        <select class="form-control" name="role" required>
            <option value="student">Register as Student</option>
            <option value="admin">Register as Admin</option>
        </select>
    </div>
    <button class="btn btn-success" type="submit">Register</button>
</form>

<hr>

<h2 class="mb-3">Login</h2>
<form action="LoginServlet" method="post">
    <div class="mb-2"><input class="form-control" type="text" name="username" placeholder="Username" required></div>
    <div class="mb-2"><input class="form-control" type="password" name="password" placeholder="Password" required></div>
    <div class="mb-2">
        <select class="form-control" name="role" required>
            <option value="student">Login as Student</option>
            <option value="admin">Login as Admin</option>
        </select>
    </div>
    <button class="btn btn-primary" type="submit">Login</button>
</form>

</body>
</html>
