package com.sms.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    private static final String URL =
            "jdbc:mysql://localhost:3306/student";
    private static final String USER =
            "root";

    private static final String PASSWORD =
            "Shiva@12345";


    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {


        request.setCharacterEncoding("UTF-8");


        String stream =
                request.getParameter("stream");

        String batch =
                request.getParameter("batch");

        String attendanceFilter =
                request.getParameter("attendanceFilter");


        if (stream == null)
            stream = "";

        if (batch == null)
            batch = "";

        if (attendanceFilter == null)
            attendanceFilter = "";


        List<Student> students =
                new ArrayList<>();


        StringBuilder sql =
                new StringBuilder(
                    "SELECT id, name, mobile, hobby, "
                  + "address, stream, batch, photo, attendance "
                  + "FROM students "
                  + "WHERE stream LIKE ? "
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


        sql.append(
                "ORDER BY stream, batch, name"
        );


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
                    "%" + stream.trim() + "%"
            );


            ps.setString(
                    2,
                    "%" + batch.trim() + "%"
            );


            ResultSet rs =
                    ps.executeQuery();


            while (rs.next()) {


                Student student =
                        new Student();


                student.id =
                        rs.getInt("id");


                student.name =
                        rs.getString("name");


                student.mobile =
                        rs.getString("mobile");


                student.hobby =
                        rs.getString("hobby");


                student.address =
                        rs.getString("address");


                student.stream =
                        rs.getString("stream");


                student.batch =
                        rs.getString("batch");


                student.photo =
                        rs.getString("photo");


                student.attendance =
                        rs.getInt("attendance");


                students.add(student);

            }


            rs.close();

            ps.close();

            con.close();


        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    e.getMessage()
            );

        }


        request.setAttribute(
                "students",
                students
        );


        request.setAttribute(
                "selectedStream",
                stream
        );


        request.setAttribute(
                "selectedBatch",
                batch
        );


        request.setAttribute(
                "attendanceFilter",
                attendanceFilter
        );


        request.getRequestDispatcher(
                "report.jsp"
        ).forward(
                request,
                response
        );

    }


    // =========================
    // STUDENT CLASS
    // =========================

    public static class Student {

        int id;

        String name;

        String mobile;

        String hobby;

        String address;

        String stream;

        String batch;

        String photo;

        int attendance;

    }

}