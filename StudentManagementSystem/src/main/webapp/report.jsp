<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Student Attendance Report</title>

<style>

body {
    font-family: Arial, sans-serif;
    background: #f5f6fa;
    margin: 0;
    padding: 20px;
}

.report-container {
    background: white;
    padding: 30px;
    max-width: 1400px;
    margin: auto;
    box-shadow: 0 0 10px rgba(0,0,0,0.15);
}

.report-header {
    text-align: center;
    margin-bottom: 25px;
}

.report-header h1 {
    margin-bottom: 5px;
}

.report-header h3 {
    margin-top: 5px;
    color: #555;
}

.filters {
    display: flex;
    gap: 10px;
    margin-bottom: 20px;
    flex-wrap: wrap;
}

.filters input,
.filters select {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

button {
    padding: 10px 18px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.search-btn {
    background: #0d6efd;
    color: white;
}

.print-btn {
    background: #198754;
    color: white;
    margin-bottom: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th,
td {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: center;
}

th {
    background: #212529;
    color: white;
}

.low-attendance {
    background: #ffdddd;
    color: #b00000;
    font-weight: bold;
}

.good-attendance {
    background: #ddffdd;
}

.student-photo {
    width: 60px;
    height: 70px;
    object-fit: cover;
}

.signature-section {
    margin-top: 60px;
    display: flex;
    justify-content: space-between;
}

.signature {
    text-align: center;
    width: 250px;
}

@media print {

    body {
        background: white;
        padding: 0;
    }

    .report-container {
        box-shadow: none;
        max-width: 100%;
    }

    .no-print {
        display: none !important;
    }

    table {
        font-size: 11px;
    }

    .student-photo {
        width: 50px;
        height: 60px;
    }

}

</style>

</head>

<body>

<div class="report-container">

    <div class="report-header">

        <h1>STUDENT ATTENDANCE REPORT</h1>

        <h3>Student Management System</h3>

        <p>
            Attendance Criteria:
            <strong>Below 70% = Low Attendance</strong>
        </p>

    </div>


    <!-- FILTERS -->

    <form method="get" action="report.jsp" class="filters no-print">

        <input
            type="text"
            name="name"
            placeholder="Search by Name"
            value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>"
        >

        <select name="stream">

            <option value="">All Streams</option>

            <option value="CSE"
                <%= "CSE".equals(request.getParameter("stream")) ? "selected" : "" %>>
                CSE
            </option>
            
            <option value="CSE(AI)"
                <%= "CSE(AI)".equals(request.getParameter("stream")) ? "selected" : "" %>>
                CSE(AI)
            </option>
            
            <option value="CSE(Cyber Security)"
                <%= "CSE(Cyber Security)".equals(request.getParameter("stream")) ? "selected" : "" %>>
                CSE(Cyber Security)
            </option>
            
            <option value="CSE"
                <%= "CSE".equals(request.getParameter("stream")) ? "selected" : "" %>>
                CSE
            </option>

            <option value="ECE"
                <%= "ECE".equals(request.getParameter("stream")) ? "selected" : "" %>>
                ECE
            </option>
            
            <option value="EEE"
                <%= "EEE".equals(request.getParameter("stream")) ? "selected" : "" %>>
                EEE
            </option>

            <option value="ME"
                <%= "ME".equals(request.getParameter("stream")) ? "selected" : "" %>>
                Mechanical
            </option>

            <option value="CE"
                <%= "CE".equals(request.getParameter("stream")) ? "selected" : "" %>>
                Civil
            </option>

        </select>


        <select name="batch">

            <option value="">All Batches</option>

            <option value="2024-2028"
                <%= "2024-2028".equals(request.getParameter("batch")) ? "selected" : "" %>>
                2024-2028
            </option>

            <option value="2025-2029"
                <%= "2025-2029".equals(request.getParameter("batch")) ? "selected" : "" %>>
                2025-2029
            </option>

            <option value="2026-2030"
                <%= "2026-2030".equals(request.getParameter("batch")) ? "selected" : "" %>>
                2026-2030
            </option>
            
            <option value="2026-2030"
                <%= "2026-2030".equals(request.getParameter("batch")) ? "selected" : "" %>>
                2027-2031
            </option>
            
            <option value="2026-2030"
                <%= "2026-2030".equals(request.getParameter("batch")) ? "selected" : "" %>>
                2028-2032
            </option>

        </select>


        <select name="attendance">

            <option value="">All Students</option>

            <option value="low"
                <%= "low".equals(request.getParameter("attendance")) ? "selected" : "" %>>
                Below 70%
            </option>

            <option value="good"
                <%= "good".equals(request.getParameter("attendance")) ? "selected" : "" %>>
                70% or Above
            </option>

        </select>


        <button type="submit" class="search-btn">
            Search
        </button>

    </form>


    <button
        onclick="window.print()"
        class="print-btn no-print">

        PRINT REPORT

    </button>


<%

String name = request.getParameter("name");
String stream = request.getParameter("stream");
String batch = request.getParameter("batch");
String attendanceFilter = request.getParameter("attendance");


Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;


try {

    Class.forName("com.mysql.cj.jdbc.Driver");


    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student",
        "root",
        "Shiva@12345"
    );


    StringBuilder sql = new StringBuilder();

    sql.append(
        "SELECT id, name, mobile, hobby, address, stream, batch, attendance, photo "
        + "FROM students WHERE 1=1"
    );


    if (name != null && !name.trim().isEmpty()) {

        sql.append(" AND name LIKE ?");

    }


    if (stream != null && !stream.trim().isEmpty()) {

        sql.append(" AND stream = ?");

    }


    if (batch != null && !batch.trim().isEmpty()) {

        sql.append(" AND batch = ?");

    }


    if ("low".equals(attendanceFilter)) {

        sql.append(" AND attendance < 70");

    }


    if ("good".equals(attendanceFilter)) {

        sql.append(" AND attendance >= 70");

    }


    sql.append(" ORDER BY stream, batch, name");


    ps = con.prepareStatement(sql.toString());


    int parameterIndex = 1;


    if (name != null && !name.trim().isEmpty()) {

        ps.setString(
            parameterIndex++,
            "%" + name.trim() + "%"
        );

    }


    if (stream != null && !stream.trim().isEmpty()) {

        ps.setString(
            parameterIndex++,
            stream
        );

    }


    if (batch != null && !batch.trim().isEmpty()) {

        ps.setString(
            parameterIndex++,
            batch
        );

    }


    rs = ps.executeQuery();


%>


<table>

<thead>

<tr>

<th>Sl. No.</th>
<th>ID</th>
<th>Name</th>
<th>Mobile</th>
<th>Hobby</th>
<th>Address</th>
<th>Stream</th>
<th>Batch</th>
<th>Attendance</th>
<th>Photo</th>

</tr>

</thead>


<tbody>


<%

int serialNumber = 1;

boolean recordsFound = false;


while (rs.next()) {

    recordsFound = true;


    int attendance = rs.getInt("attendance");


    String rowClass = "";

    if (attendance < 70) {

        rowClass = "low-attendance";

    } else {

        rowClass = "good-attendance";

    }


    String photo = rs.getString("photo");

%>


<tr class="<%= rowClass %>">

<td>
    <%= serialNumber++ %>
</td>


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

    <strong>
        <%= attendance %>%
    </strong>

    <% if (attendance < 70) { %>

        <br>

        <span style="color:red;">
            LOW
        </span>

    <% } %>

</td>


<td>

<%

if (photo != null && !photo.trim().isEmpty()) {

%>

<img
    src="<%= photo %>"
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


</tr>


<%

}


if (!recordsFound) {

%>


<tr>

<td colspan="10">

No student records found.

</td>

</tr>


<%

}


%>


</tbody>

</table>


<%

} catch (Exception e) {

%>


<div style="
    margin-top:20px;
    padding:15px;
    background:#ffdddd;
    color:#b00000;
">

<strong>Database Error:</strong>

<%= e.getMessage() %>

</div>


<%

} finally {


    try {

        if (rs != null)
            rs.close();

    } catch (SQLException e) {}


    try {

        if (ps != null)
            ps.close();

    } catch (SQLException e) {}


    try {

        if (con != null)
            con.close();

    } catch (SQLException e) {}

}

%>


<!-- SIGNATURE -->

<div class="signature-section">

    <div class="signature">

        __________________________

        <br>

        Class Teacher

    </div>


    <div class="signature">

        __________________________

        <br>

        HOD

    </div>


    <div class="signature">

        __________________________

        <br>

        Principal

    </div>

</div>


</div>

</body>

</html>