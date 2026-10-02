package com.sms.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String mobile = req.getParameter("mobile");
        String stream = req.getParameter("stream");
        String attendanceStr = req.getParameter("attendance");

        if(idStr==null || name==null || mobile==null || stream==null || attendanceStr==null ||
           idStr.trim().isEmpty() || name.trim().isEmpty() || mobile.trim().isEmpty() ||
           stream.trim().isEmpty() || attendanceStr.trim().isEmpty()) {
            res.getWriter().println("All fields are required!");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            int attendance = Integer.parseInt(attendanceStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/student","root","Shiva@12345");

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO students VALUES (?,?,?,?,?)");
            ps.setInt(1, id);
            ps.setString(2, name);
            ps.setString(3, mobile);
            ps.setString(4, stream);
            ps.setInt(5, attendance);

            ps.executeUpdate();
            res.getWriter().println("Student registered successfully!");
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
            res.getWriter().println("Error: " + e.getMessage());
        }
    }
}
