package com.sms.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RegisterUserServlet")
public class RegisterUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String role = req.getParameter("role");

        if(idStr==null || username==null || password==null || role==null ||
           idStr.trim().isEmpty() || username.trim().isEmpty() || password.trim().isEmpty()) {
            res.getWriter().println("All fields required!");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/student","root","Shiva@12345");

            // Check duplicate ID
            PreparedStatement check = con.prepareStatement("SELECT * FROM users WHERE id=?");
            check.setInt(1, id);
            ResultSet rsCheck = check.executeQuery();
            if(rsCheck.next()){
                res.getWriter().println("ID already exists! Choose another ID.");
                return;
            }

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users (id,username,password,role) VALUES (?,?,?,?)");
            ps.setInt(1, id);
            ps.setString(2, username);
            ps.setString(3, password);
            ps.setString(4, role);

            ps.executeUpdate();
            res.getWriter().println("Registration successful! <a href='register_login.jsp'>Go back</a>");
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
            res.getWriter().println("Error: " + e.getMessage());
        }
    }
}
