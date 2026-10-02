package com.sms.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/RegisterStudentServlet")

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 20 * 1024 * 1024
)

public class RegisterStudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    // =========================
    // DATABASE
    // =========================

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

        request.setCharacterEncoding("UTF-8");


        // =========================
        // GET FORM VALUES
        // =========================

        String name =
                request.getParameter("name");

        String mobile =
                request.getParameter("mobile");

        String hobby =
                request.getParameter("hobby");

        String address =
                request.getParameter("address");

        String stream =
                request.getParameter("stream");

        String batch =
                request.getParameter("batch");


        // =========================
        // GET PHOTO
        // =========================

        Part photoPart =
                request.getPart("photo");


        // =========================
        // VALIDATION
        // =========================

        if (name == null || name.trim().isEmpty()
                || mobile == null || mobile.trim().isEmpty()
                || hobby == null || hobby.trim().isEmpty()
                || address == null || address.trim().isEmpty()
                || stream == null || stream.trim().isEmpty()
                || batch == null || batch.trim().isEmpty()
                || photoPart == null
                || photoPart.getSize() == 0) {

            response.sendRedirect(
                    "registerStudent.jsp?message=Please fill all fields"
            );

            return;
        }


        // =========================
        // FILE NAME
        // =========================

        String originalFileName =
                photoPart.getSubmittedFileName();


        if (originalFileName == null
                || originalFileName.trim().isEmpty()) {

            response.sendRedirect(
                    "registerStudent.jsp?message=Please select a photo"
            );

            return;
        }


        String cleanFileName =
                new File(originalFileName).getName();


        String fileName =
                System.currentTimeMillis()
                + "_"
                + cleanFileName;


        // =========================
        // UPLOAD DIRECTORY
        // =========================

        String uploadPath =
                getServletContext().getRealPath("")
                + File.separator
                + "uploads";


        File uploadDir =
                new File(uploadPath);


        if (!uploadDir.exists()) {

            uploadDir.mkdirs();

        }


        // =========================
        // SAVE PHOTO
        // =========================

        try {

            photoPart.write(
                    uploadPath
                    + File.separator
                    + fileName
            );

        } catch (IOException e) {

            e.printStackTrace();

            response.sendRedirect(
                    "registerStudent.jsp?message=Photo upload failed"
            );

            return;
        }


        String photoPath =
                "uploads/" + fileName;


        // =========================
        // SQL
        // =========================

        String sql =
                "INSERT INTO students "
                + "(name, mobile, hobby, address, stream, batch, photo) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";


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
                    con.prepareStatement(sql);


            ps.setString(1, name.trim());

            ps.setString(2, mobile.trim());

            ps.setString(3, hobby.trim());

            ps.setString(4, address.trim());

            ps.setString(5, stream.trim());

            ps.setString(6, batch.trim());

            ps.setString(7, photoPath);


            int result =
                    ps.executeUpdate();


            ps.close();

            con.close();


            if (result > 0) {

                response.sendRedirect(
                        "adminHome.jsp?message=Student Registered Successfully"
                );

            } else {

                response.sendRedirect(
                        "registerStudent.jsp?message=Registration Failed"
                );
            }


        } catch (ClassNotFoundException e) {

            e.printStackTrace();

            response.sendRedirect(
                    "registerStudent.jsp?message=MySQL Driver Not Found"
            );


        } catch (SQLException e) {

            e.printStackTrace();

            response.sendRedirect(
                    "registerStudent.jsp?message=Database Error: "
                    + e.getMessage()
            );
        }
    }
}