package com.sms.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ViewServlet")
public class ViewServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/student","root","Shiva@12345");

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM students");

            res.setContentType("text/html");
            res.getWriter().println("<table border='1'><tr><th>ID</th><th>Name</th><th>Mobile</th><th>Stream</th><th>Attendance</th></tr>");
            while(rs.next()) {
                res.getWriter().println("<tr><td>"+rs.getInt("id")+"</td><td>"+rs.getString("name")+"</td><td>"+rs.getString("mobile")+"</td><td>"+rs.getString("stream")+"</td><td>"+rs.getInt("attendance")+"</td></tr>");
            }
            res.getWriter().println("</table>");
            con.close();
        } catch(Exception e) {
            res.getWriter().println("Error: " + e.getMessage());
        }
    }
}
