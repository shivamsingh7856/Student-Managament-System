<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>

<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Student Dashboard</title>


<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">


</head>


<body>


<div class="container mt-5">


<%

String user =
        request.getParameter("user");


if (user == null || user.trim().isEmpty()) {

    user = "Student";

}


String URL =
        "jdbc:mysql://localhost:3306/student";

String USER =
        "root";

String PASSWORD =
        "Shiva@12345";


String stream = "";

int attendance = 0;


try {


    Class.forName(
            "com.mysql.cj.jdbc.Driver"
    );


    Connection con =
            DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD
            );


    String sql =
            "SELECT stream, attendance "
            + "FROM students "
            + "WHERE name = ? "
            + "LIMIT 1";


    PreparedStatement ps =
            con.prepareStatement(sql);


    ps.setString(
            1,
            user
    );


    ResultSet rs =
            ps.executeQuery();


    if (rs.next()) {

        stream =
                rs.getString("stream");

        attendance =
                rs.getInt("attendance");

    }


    rs.close();

    ps.close();

    con.close();


%>


<h1>
    Welcome <%= user %>
</h1>


<p class="mt-3">

    <strong>Stream:</strong>

    <%= stream %>

</p>


<p>

    <strong>Attendance:</strong>

    <%= attendance %>%

</p>


<a href="LogoutServlet"
   class="btn btn-secondary">

    Logout

</a>


<%

} catch (Exception e) {

%>


<div class="alert alert-danger">

    Database Error:
    <%= e.getMessage() %>

</div>


<%

}

%>


</div>


</body>

</html>