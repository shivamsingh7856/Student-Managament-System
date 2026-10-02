package com.sms.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateAttendanceServlet")
public class UpdateAttendanceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    private static final String URL =
            "jdbc:mysql://localhost:3306/student";

    private static final String USER =
            "root";

    private static final String PASSWORD =
            "Shiva@12345";


    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String idString =
                request.getParameter("id");

        String attendanceString =
                request.getParameter("attendance");


        try {

            int id =
                    Integer.parseInt(idString);

            int attendance =
                    Integer.parseInt(attendanceString);


            // Attendance range

            if (attendance < 0 || attendance > 100) {

                response.sendRedirect(
                        "adminHome.jsp?message=Attendance must be between 0 and 100"
                );

                return;
            }


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
                    "UPDATE students "
                    + "SET attendance = ? "
                    + "WHERE id = ?";


            PreparedStatement ps =
                    con.prepareStatement(sql);


            ps.setInt(1, attendance);

            ps.setInt(2, id);


            int result =
                    ps.executeUpdate();


            ps.close();

            con.close();


            if (result > 0) {

                response.sendRedirect(
                        "adminHome.jsp?message=Attendance updated successfully"
                );

            } else {

                response.sendRedirect(
                        "adminHome.jsp?message=Student not found"
                );
            }


        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "adminHome.jsp?message=Please enter valid attendance"
            );


        } catch (ClassNotFoundException e) {

            e.printStackTrace();

            response.sendRedirect(
                    "adminHome.jsp?message=MySQL Driver Not Found"
            );


        } catch (SQLException e) {

            e.printStackTrace();

            response.sendRedirect(
                    "adminHome.jsp?message=Database Error: "
                    + e.getMessage()
            );
        }
    }
}