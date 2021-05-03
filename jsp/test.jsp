<%-- 
    Document   : test
    Created on : 19/10/2018, 12:21:44 PM
    Author     : axelg
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>

<html>
<head>
<title>JDBC Connection example</title>
</head>

<body>
<h1>JDBC Connection example</h1>

<%
  
  try {
    java.sql.Connection con;
    Class.forName("com.mysql.jdbc.Driver");
    
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/papw?useSSL=false&serverTimezone=UTC", "root", "");
    out.println ( "database successfully opened.");
  }
  catch(SQLException e) {
    out.println("SQLException caught: " +e.getMessage());
  }
%>

</body>
</html>


