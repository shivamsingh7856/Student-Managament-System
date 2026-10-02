package com.sms.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String stream = req.getParameter("stream");
        String name = req.getParameter("name");

        res.setContentType("text/html");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/student","root","Shiva@12345");

            String query = "SELECT * FROM students WHERE 1=1";
            if(stream!=null && !stream.trim().isEmpty()) query += " AND stream=?";
            if(name!=null && !name.trim().isEmpty()) query += " AND name LIKE ?";

            PreparedStatement ps = con.prepareStatement(query);
            int index=1;
            if(stream!=null && !stream.trim().isEmpty()) ps.setString(index++, stream);
            if(name!=null && !name.trim().isEmpty()) ps.setString(index++, "%"+name+"%");

            ResultSet rs = ps.executeQuery();

            res.getWriter().println("<table border='1'><tr><th>ID</th><th>Name</th><th>Mobile</th><th>Stream</th><th>Attendance</th></tr>");
            while(rs.next()){
                res.getWriter().println("<tr><td>"+rs.getInt("id")+"</td><td>"+rs.getString("name")+"</td><td>"+rs.getString("mobile")+"</td><td>"+rs.getString("stream")+"</td><td>"+rs.getInt("attendance")+"</td></tr>");
            }
            res.getWriter().println("</table>");
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
            res.getWriter().println("Error: " + e.getMessage());
        }
    }
}
