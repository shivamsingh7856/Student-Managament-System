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

<title>Admin Dashboard</title>

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<style>

.student-photo {
    width: 70px;
    height: 70px;
    object-fit: cover;
}

.attendance-input {
    width: 75px;
}

</style>

</head>


<body>


<div class="container-fluid mt-4">


<h1>Admin Dashboard</h1>


<!-- TOP BUTTONS -->

<div class="mb-3">

    <a href="registerStudent.jsp"
       class="btn btn-primary">

        Register Student

    </a>


    <a href="LogoutServlet"
       class="btn btn-secondary">

        Logout

    </a>

</div>


<!-- MESSAGE -->

<%

String message =
        request.getParameter("message");

if (message != null) {

%>

<div class="alert alert-info">

    <%= message %>

</div>

<%

}

%>


<!-- ========================= -->
<!-- SEARCH -->
<!-- ========================= -->

<form method="get"
      action="adminHome.jsp"
      class="mb-4">


<div class="form-row">


    <!-- NAME -->

    <div class="col-md-3">

        <input type="text"
               name="name"
               class="form-control"
               placeholder="Search by name"
               value="<%= request.getParameter("name") != null
                       ? request.getParameter("name")
                       : "" %>">

    </div>


    <!-- STREAM -->

    <div class="col-md-3">

        <select name="stream"
                class="form-control">

            <option value="">
                All Streams
            </option>

            <option value="CSE">
                CSE
            </option>

            <option value="CSE(AI)">
                CSE (AI)
            </option>

            <option value="CSE(Cyber Security)">
                CSE (Cyber Security)
            </option>

            <option value="ECE">
                ECE
            </option>

            <option value="EEE">
                EEE
            </option>

            <option value="Mechanical">
                Mechanical
            </option>

            <option value="Civil">
                Civil
            </option>

        </select>

    </div>


    <!-- BATCH -->

    <div class="col-md-2">

        <select name="batch"
                class="form-control">

            <option value="">
                All Batches
            </option>

            <option value="2024-2028">
                2024-2028
            </option>

            <option value="2025-2029">
                2025-2029
            </option>

            <option value="2026-2030">
                2026-2030
            </option>

            <option value="2027-2031">
                2027-2031
            </option>

            <option value="2028-2032">
                2028-2032
            </option>

        </select>

    </div>


    <!-- ATTENDANCE FILTER -->

    <div class="col-md-2">

        <select name="attendanceFilter"
                class="form-control">

            <option value="">
                All Attendance
            </option>

            <option value="below70">
                Below 70%
            </option>

            <option value="70plus">
                70% & Above
            </option>

        </select>

    </div>


    <!-- SEARCH -->

    <div class="col-md-2">

        <button type="submit"
                class="btn btn-primary">

            Search

        </button>


        <a href="adminHome.jsp"
           class="btn btn-secondary">

            Clear

        </a>

    </div>


</div>

</form>


<!-- ========================= -->
<!-- REPORT BUTTONS -->
<!-- ========================= -->

<div class="mb-4">


    <form action="ReportServlet"
          method="get"
          target="_blank"
          class="form-inline">


        <select name="stream"
                class="form-control mr-2">

            <option value="">
                All Streams
            </option>

            <option value="CSE">
                CSE
            </option>

            <option value="CSE(AI)">
                CSE (AI)
            </option>

            <option value="CSE(Cyber Security)">
                CSE (Cyber Security)
            </option>

            <option value="ECE">
                ECE
            </option>

            <option value="EEE">
                EEE
            </option>

            <option value="Mechanical">
                Mechanical
            </option>

            <option value="Civil">
                Civil
            </option>

        </select>


        <select name="batch"
                class="form-control mr-2">

            <option value="">
                All Batches
            </option>

            <option value="2024-2028">
                2024-2028
            </option>

            <option value="2025-2029">
                2025-2029
            </option>

            <option value="2026-2030">
                2026-2030
            </option>

            <option value="2027-2031">
                2027-2031
            </option>

            <option value="2028-2032">
                2028-2032
            </option>

        </select>


        <select name="attendanceFilter"
                class="form-control mr-2">

            <option value="">
                All Students
            </option>

            <option value="below70">
                Below 70%
            </option>

            <option value="70plus">
                70% & Above
            </option>

        </select>


        <button type="submit"
                class="btn btn-dark">

            Generate Report

        </button>


    </form>

</div>


<!-- ========================= -->
<!-- STUDENT TABLE -->
<!-- ========================= -->

<div class="table-responsive">


<table class="table table-bordered table-hover">


<thead class="thead-light">

<tr>

    <th>ID</th>

    <th>Name</th>

    <th>Mobile</th>

    <th>Hobby</th>

    <th>Address</th>

    <th>Stream</th>

    <th>Batch</th>

    <th>Photo</th>

    <th>Attendance</th>

</tr>

</thead>


<tbody>


<%

String URL =
        "jdbc:mysql://localhost:3306/student";

String USER =
        "root";

String PASSWORD =
        "Shiva@12345";


String name =
        request.getParameter("name");

String stream =
        request.getParameter("stream");

String batch =
        request.getParameter("batch");

String attendanceFilter =
        request.getParameter("attendanceFilter");


if (name == null) name = "";

if (stream == null) stream = "";

if (batch == null) batch = "";

if (attendanceFilter == null)
    attendanceFilter = "";


StringBuilder sql =
        new StringBuilder(
            "SELECT id, name, mobile, hobby, "
          + "address, stream, batch, photo, attendance "
          + "FROM students "
          + "WHERE name LIKE ? "
          + "AND stream LIKE ? "
          + "AND batch LIKE ? "
        );


if ("below70".equals(attendanceFilter)) {

    sql.append(
        "AND attendance < 70 "
    );

}


if ("70plus".equals(attendanceFilter)) {

    sql.append(
        "AND attendance >= 70 "
    );

}


sql.append("ORDER BY id");


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


    PreparedStatement ps =
            con.prepareStatement(
                    sql.toString()
            );


    ps.setString(
            1,
            "%" + name.trim() + "%"
    );


    ps.setString(
            2,
            "%" + stream.trim() + "%"
    );


    ps.setString(
            3,
            "%" + batch.trim() + "%"
    );


    ResultSet rs =
            ps.executeQuery();


    boolean found = false;


    while (rs.next()) {

        found = true;

        int attendance =
                rs.getInt("attendance");

%>


<tr>


<td>
    <%= rs.getInt("id") %>
</td>


<td>
    <%= rs.getString("name") %>
</td>


<td>
    <%= rs.getString("mobile") %>
</td>


<td>
    <%= rs.getString("hobby") %>
</td>


<td>
    <%= rs.getString("address") %>
</td>


<td>
    <%= rs.getString("stream") %>
</td>


<td>
    <%= rs.getString("batch") %>
</td>


<td>

<%

String photo =
        rs.getString("photo");

if (photo != null
        && !photo.isEmpty()) {

%>

<img src="<%= photo %>"
     class="student-photo"
     alt="Student Photo">

<%

} else {

%>

No Photo

<%

}

%>

</td>


<td>


<form action="UpdateAttendanceServlet"
      method="post"
      class="form-inline">


<input type="number"
       name="attendance"
       class="form-control attendance-input mr-1"
       value="<%= attendance %>"
       min="0"
       max="100"
       required>


<input type="hidden"
       name="id"
       value="<%= rs.getInt("id") %>">


<button type="submit"
        class="btn btn-success btn-sm">

    Update

</button>


</form>


</td>


</tr>


<%

    }


    if (!found) {

%>


<tr>

<td colspan="9"
    class="text-center">

    No students found

</td>

</tr>


<%

    }


    rs.close();

    ps.close();

    con.close();


} catch (Exception e) {

%>


<tr>

<td colspan="9"
    class="text-danger">

    Database Error:
    <%= e.getMessage() %>

</td>

</tr>


<%

}

%>


</tbody>

</table>

</div>


</div>


</body>

</html>