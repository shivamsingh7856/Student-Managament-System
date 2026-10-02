package com.sms.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/EditServlet")
public class EditServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");
        if(idStr==null || idStr.trim().isEmpty()) {
            res.getWriter().println("ID required!");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            String name = req.getParameter("name");
            String mobile = req.getParameter("mobile");
            String stream = req.getParameter("stream");
            int attendance = Integer.parseInt(req.getParameter("attendance"));

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/student","root","Shiva@12345");

            PreparedStatement ps = con.prepareStatement(
                "UPDATE students SET name=?, mobile=?, stream=?, attendance=? WHERE id=?");
            ps.setString(1, name);
            ps.setString(2, mobile);
            ps.setString(3, stream);
            ps.setInt(4, attendance);
            ps.setInt(5, id);

            int updated = ps.executeUpdate();
            res.getWriter().println(updated>0 ? "Updated!" : "No student found!");
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
            res.getWriter().println("Error: " + e.getMessage());
        }
    }
}
