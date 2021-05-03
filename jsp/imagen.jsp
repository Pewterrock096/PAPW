<%-- 
    Document   : imagen
    Created on : 10/12/2018, 10:41:59 PM
    Author     : axelg
--%>

<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.CallableStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="util.Database" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            try{
                String imgn = "imagen1Articulo";
                 Connection connection;
        connection = Database.getConnection();
        CallableStatement stmt = connection.prepareCall("{CALL ARTICULO_SelectByProductID(?)}");
                if(request.getParameter("img").trim().equals("1")){
             imgn = "imagen1Articulo";
             stmt = connection.prepareCall("{CALL ARTICULO_SelectByProductID(?)}");
                }
         if(request.getParameter("img").trim().equals("2")){
               imgn = "imagen2Articulo";
               stmt = connection.prepareCall("{CALL ARTICULO_SelectByProductID(?)}");
           }
           if(request.getParameter("img").trim().equals("3")){
              imgn = "imagen3Articulo";
              stmt = connection.prepareCall("{CALL ARTICULO_SelectByProductID(?)}");
           }
            if(request.getParameter("img").trim().equals("4")){
              imgn = "portadaUsuario";
              stmt = connection.prepareCall("{CALL USUARIO_SelectByID(?)}");
           }
             if(request.getParameter("img").trim().equals("5")){
              imgn = "perfilUsuario";
              stmt = connection.prepareCall("{CALL USUARIO_SelectByID(?)}");
           }
           
        
        stmt.setInt(1, Integer.parseInt(request.getParameter("id").trim()));
        ResultSet rs = stmt.executeQuery();
        if(rs.next()){
           Blob  blob = rs.getBlob(imgn);
           
           byte byteArray[] = blob.getBytes(1, (int) blob.length());
           response.setContentType("image/gif");
           OutputStream os = response.getOutputStream();
           os.write(byteArray);
           os.flush();
           os.close();
           
        }else{out.println("No image found");}
            }catch(SQLException e){
                 out.println("An exception occurred: " + e.getMessage());
            }
        %>
        <h1>Hello World!</h1>
    </body>
</html>
