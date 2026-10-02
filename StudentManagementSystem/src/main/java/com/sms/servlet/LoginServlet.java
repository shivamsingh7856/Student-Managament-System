package com.sms.servlet;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        String role = req.getParameter("role");

        if(user==null || pass==null || role==null ||
           user.trim().isEmpty() || pass.trim().isEmpty()) {
            res.getWriter().println("All fields required!");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/student","root","Shiva@12345");

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE username=? AND password=? AND role=?");
            ps.setString(1, user);
            ps.setString(2, pass);
            ps.setString(3, role);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = req.getSession();
                session.setAttribute("username", user);
                session.setAttribute("role", role);

                if ("admin".equals(role)) {
                    res.sendRedirect("adminHome.jsp");
                } else {
                    res.sendRedirect("studentHome.jsp?user=" + user);
                }
            } else {
                res.getWriter().println("Invalid login!");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("Error: " + e.getMessage());
        }
    }
}
