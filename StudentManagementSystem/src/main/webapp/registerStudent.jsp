<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Register Student</title>

<link rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

</head>


<body>

<div class="container mt-5">

    <div class="card">

        <div class="card-header bg-primary text-white">

            <h3 class="mb-0">
                Register Student
            </h3>

        </div>


        <div class="card-body">


            <%
                String message =
                        request.getParameter("message");

                if (message != null) {
            %>

                <div class="alert alert-info">
                    <%= message %>
                </div>

            <%
                }
            %>


            <form action="RegisterStudentServlet"
                  method="post"
                  enctype="multipart/form-data">


                <!-- NAME -->

                <div class="form-group">

                    <label>
                        Student Name
                    </label>

                    <input type="text"
                           name="name"
                           class="form-control"
                           placeholder="Enter student name"
                           required>

                </div>


                <!-- HOBBY -->

                <div class="form-group">

                    <label>
                        Hobby
                    </label>

                    <input type="text"
                           name="hobby"
                           class="form-control"
                           placeholder="Enter hobby"
                           required>

                </div>


                <!-- STREAM -->

                <div class="form-group">

                    <label>
                        Stream / Branch
                    </label>

                    <select name="stream"
                            class="form-control"
                            required>

                        <option value="">
                            Select Stream
                        </option>

                        <option value="CSE">
                            CSE
                        </option>

                        <option value="CSE(AI)">
                            CSE (AI)
                        </option>

                        <option value="CSE(Cyber Security)">
                            CSE (Cyber Security)
                        </option>

                        <option value="ECE">
                            ECE
                        </option>

                        <option value="EEE">
                            EEE
                        </option>

                        <option value="Mechanical">
                            Mechanical
                        </option>

                        <option value="Civil">
                            Civil
                        </option>

                    </select>

                </div>


                <!-- BATCH -->

                <div class="form-group">

                    <label>
                        Batch
                    </label>

                    <select name="batch"
                            class="form-control"
                            required>

                        <option value="">
                            Select Batch
                        </option>

                        <option value="2024-2028">
                            2024-2028
                        </option>

                        <option value="2025-2029">
                            2025-2029
                        </option>

                        <option value="2026-2030">
                            2026-2030
                        </option>

                        <option value="2027-2031">
                            2027-2031
                        </option>

                        <option value="2028-2032">
                            2028-2032
                        </option>

                    </select>

                </div>


                <!-- ADDRESS -->

                <div class="form-group">

                    <label>
                        Address
                    </label>

                    <textarea name="address"
                              class="form-control"
                              rows="3"
                              placeholder="Enter address"
                              required></textarea>

                </div>


                <!-- MOBILE -->

                <div class="form-group">

                    <label>
                        Mobile Number
                    </label>

                    <input type="text"
                           name="mobile"
                           class="form-control"
                           placeholder="Enter mobile number"
                           maxlength="15"
                           required>

                </div>


                <!-- PHOTO -->

                <div class="form-group">

                    <label>
                        Student Photo
                    </label>

                    <input type="file"
                           name="photo"
                           class="form-control"
                           accept="image/*"
                           required>

                    <small class="text-muted">
                        Maximum file size: 10 MB
                    </small>

                </div>


                <!-- BUTTONS -->

                <button type="submit"
                        class="btn btn-success">

                    Register Student

                </button>


                <a href="adminHome.jsp"
                   class="btn btn-secondary">

                    Back to Dashboard

                </a>


            </form>

        </div>

    </div>

</div>

</body>

</html>