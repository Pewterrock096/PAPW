<%-- 
    Document   : vender
    Created on : 19/10/2018, 04:53:27 AM
    Author     : axelg
--%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="model.User"%>
<%@page import="model.Product"%>
<%@page import="util.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "UTF-8">
        <meta htttp-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width = device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel ="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/carrito.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <title>Vender</title>
    </head>
    <body>
           <nav class="navbar navbar-expand-lg navbar-dark bg-dark navbar-fixed-top">
            <div class="container-fluid">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/jsp/home.jsp"><img src="${pageContext.request.contextPath}/imgenes/logo.png" class="img-fluid" width="20%" alt="Logo"> Tienda</a>
              <form class="form-inline my-2 my-lg-0" action="${pageContext.request.contextPath}/SearchController" method="POST">
                  <input class="form-control" name="action1" id="action1" type="hidden" value="general">
                  <input class="form-control mr-sm-2" type="search" id="busqueda" name="busqueda" placeholder="Buscar..." aria-label="Search">
                  <button class="btn btn-outline-light my-2 my-sm-0" type="submit"><i class="fa fa-search"></i> Buscar</button>
                </form>
                 <div class="nav navbar-nav navbar-right btn-group">
                   <%if (session.getAttribute("usuarioUsuario") == null){%>
                     <button type="button" class="btn btn-outline-light" data-toggle="modal" data-target="#login"><span class="fa fa-sign-in-alt"></span> Iniciar Sesión</button>
                     <button type="button" class="btn btn-outline-light" data-toggle="modal" data-target="#registro"><span class="fa fa-user-plus"></span> Crea Una Cuenta </button>
                   <%} else{%>
                     <a href="${pageContext.request.contextPath}/jsp/perfil.jsp?usuario=${sessionScope.idUsuario}" class="btn btn-outline-light"><span>  <img src="${pageContext.request.contextPath}/jsp/imagen.jsp?id=${sessionScope.idUsuario}&img=5" style="max-width: 20px;" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/imgenes/usuario.png';" alt="Foto"></span> ${sessionScope.usuarioUsuario} </a>
                     <form id="registroform" action="${pageContext.request.contextPath}/UserController" method="POST" onsubmit="return validaregistro(this)">
                        <input class="form-control" name="action1" id="action1" type="hidden" value="cerrarSesion">
                         <button type="submit" id="logout" class="btn btn-outline-light"><span class="fa fa-sign-out-alt"></span> Log Out </button>
                     </form>
                         <a href="${pageContext.request.contextPath}/jsp/carrito.jsp?usuario=${sessionScope.idUsuario}" class="btn btn-outline-light"><span class="fa fa-shopping-cart"></span> Carrito </a>
                     <%}%>
                    
                </div>
    
                  <div class="modal fade" id="login">
                    <div class="modal-dialog">
                      <div class="modal-content">

                  
                        <div class="modal-header">
                            
                            <h4 class="modal-title">Iniciar Sesión</h4>
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                       
                          
                          
                        </div>

                  
                        <div class="modal-body">
                         <div class="row">
                            <div class="container-fluid text-center">
                                <form id="loginform" action="${pageContext.request.contextPath}/UserController" method="POST" onsubmit="return validalogin(this)">
                                        <div class="container">
                                            <input class="form-control" name="action1" id="action1" type="hidden" value="login">
                                        <input class="form-control" name="usuariologin" id="usuariologin" type="text"  placeholder="Usuario">                 
                                        <br>
                                        <input class="form-control" name="contralogin" id="contralogin" type="password" placeholder="Contraseña">
                                        <br>
                                        <div class="clearfix">
                                        <label class="float-left checkbox-inline"><input type="checkbox"> Recordarme</label>
                                        <button type="submit"  id="btnLogin" class="btn btn-info float-right"><i class="fa fa-sign-in-alt"></i> Iniciar Sesion</button>
                                        
                                        </div>
                               

                                </div>
                                         </form>
                            </div>
                        </div>
                        </div>

                      </div>
                    </div>
                  </div>
                
                <div class="modal fade" id="registro">
                    <div class="modal-dialog">
                      <div class="modal-content">

                  
                        <div class="modal-header">
                          <h4 class="modal-title">Registrate</h4>
                          <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>

                  
                        <div class="modal-body">
                         <div class="row">
                            <div class="container-fluid text-center">
                                <form id="registroform" action="${pageContext.request.contextPath}/UserController" method="POST" onsubmit="return validaregistro(this)" >
                                    <input class="form-control" name="action1" id="action1" type="hidden" value="registrar">
                                        <input class="form-control" name="nombre" id="nombre" type="text" placeholder="Nombre">                 
                                        <br>
                                        <input class="form-control" name="apellido" id="apellido" type="text" placeholder="Apellido">                 
                                        <br>
                                        <input class="form-control" name="correo" id="correo" type="mail" placeholder="Correo Electrónico">                 
                                        <br>
                                        <input class="form-control" name="usuario" id="usuario" type="text" placeholder="Nombre de Usuario">
                                        <h6 class="text-muted text-left"><small>*Minimo 6 caracteres</small></h6>
                                        <input class="form-control" name="contra" id="contra" type="password" placeholder="Contraseña">
                                        <h6 class="text-muted text-left"><small>*Minimo 8 caracteres,debe incluir una mayúsucula, una minúscula y un número</small></h6>
                                        <input class="form-control" name="telefono" id="telefono" type="text" onkeypress="return validarnumero(event)" placeholder="Teléfono (Opcional)">                 
                                        <br>
                                        <input class="form-control" name="direccion" id="dirección" type="text" placeholder="Dirección (Opcional)">                 
                                        <br>
                                        <div class="row text-muted">
                                            
                                        <!--    <p class="col-5"> Imagen de Perfil: </p>
                                            <input type="file" class="col-7" name="imagenusuario" id="imagenusuario">
                                            <br>                              
                                            <p class="col-5"> Imagen de Portada: </p>
                                            <input type="file" class="col-7" name="imagenportada" id="imagenportada">
                                            <br> -->
                                            
                                        </div>
                                    <button type="submit" id="btnRegistro" class="btn btn-info btn-block"><i class="fa fa-user-plus"></i> Registrarse</button>
                                    
                                </form>
                            </div>
                        </div>
                        </div>

                      </div>
                    </div>
                  </div>

            </div>
        </nav>
                                    <div class="container-fluid">    
              <div class="row content">
                <div class="col-sm-2 sidenav">
                    <div id="accordion">
                        
                        
                         <%if (session.getAttribute("usuarioUsuario") != null){%>
                        <div class="card">
                            <div class="card-header">
                              <a class="card-link" data-toggle="collapse" href="#Opciones">
                                Opciones de Usuario
                              </a>
                            </div>
                            <div id="Opciones" class="collapse show" data-parent="#accordion">
                              <div class="card-body">
                                  <p><a href="${pageContext.request.contextPath}/jsp/perfil.jsp?usuario=${sessionScope.idUsuario}">Perfil</a></p>
                                  <p><a href="${pageContext.request.contextPath}/jsp/vender.jsp">Publica un artículo</a></p>
                                  <p><a href="${pageContext.request.contextPath}/jsp/historial.jsp?usuario=${sessionScope.idUsuario}">Historial de Compras</a></p>
                              </div>
                            </div>
                          </div>
        <%}%>
        
                    </div>
                </div>
                               <% 
                            Connection connection = Database.getConnection();
                             try {
                                 Product product = new Product();
                                 User user = new User();
                               // CallableStatement stmt = connection.prepareCall("SELECT * FROM articulo JOIN usuario ON articulo.idUsuario = usuario.idUsuario WHERE idArticulo = ?");
                                CallableStatement stmt = connection.prepareCall("{CALL ARTICULO_SelectByProductID(?)}");

                                stmt.setString(1, request.getParameter("product"));
                                 //Statement statement = connection.createStatement();
                                  ResultSet rs = stmt.executeQuery();
                                
                                if (rs.next()) {
                                    product.setIdArticulo(Integer.parseInt(rs.getString("idArticulo")));
                                    product.setIdUsuario(Integer.parseInt(rs.getString("idUsuario")));
                                    product.setNombreArticulo(rs.getString("nombreArticulo"));
                                    product.setDescripcionArticulo(rs.getString("descripcionArticulo"));
                                    product.setCategoria1Articulo(rs.getInt("categoria1Articulo"));
                                    product.setCategoria2Articulo(rs.getInt("categoria2Articulo"));
                                    product.setCategoria3Articulo(rs.getInt("categoria3Articulo"));
                                    product.setPrecioArticulo(Integer.parseInt(rs.getString("precioArticulo")));
                                    product.setUnidadesArticulo(Integer.parseInt(rs.getString("unidadesArticulo")));
                                 //   user.setUsuarioUsuario(rs.getString("usuarioUsuario"));
                                   // user.setIdUsuario(Integer.parseInt(rs.getString("idUsuario")));
                                    
                                        %>
               <div class="col-sm-10">
                   <div class="card">
                      <div class="card-header">
                         
                          <h6 class="display-4">Publica un Artículo</h6>
                      </div>
                     
                       <form id="registroform" action="${pageContext.request.contextPath}/ProductoController" method="POST" enctype="multipart/form-data" onsubmit="return validaproducto(this)">
                       <div class="card-body">
                           <div class="form-group">
                               <%if(product.getIdArticulo() == Integer.parseInt(String.valueOf(request.getParameter("product"))) && product.getIdUsuario() == Integer.parseInt(String.valueOf(session.getAttribute("idUsuario")))){%>
                               <input class="form-control" name="action1" id="action1" type="hidden" value="modificar">
                               <input class="form-control" name="idproducto" id="idproducto" type="hidden" value="<%out.println(request.getParameter("product"));%>">
                               <%}else{%>
                                <input class="form-control" name="action1" id="action1" type="hidden" value="publicar">
                                
                                <%}%>
                                
                                <label for="nombrearticulo">Nombre del Articulo:</label>
                                <%if(product.getIdArticulo() == Integer.parseInt(String.valueOf(request.getParameter("product"))) && product.getIdUsuario() == Integer.parseInt(String.valueOf(session.getAttribute("idUsuario")))){%>
                                <input type="text" class="form-control" id="nombrearticulo" name="nombrearticulo" value="<%out.println(product.getNombreArticulo());%>">
                                <%}else{%>
                                <input type="text" class="form-control" id="nombrearticulo" name="nombrearticulo" >
                                <%}%>
                              </div>
                           <div class="form-group">
                                <label for="descripcionarticulo">Descripción del Articulo:</label>
                                <%if(product.getIdArticulo() == Integer.parseInt(String.valueOf(request.getParameter("product"))) && product.getIdUsuario() == Integer.parseInt(String.valueOf(session.getAttribute("idUsuario")))){%>
                                <textarea class="form-control" rows="5" id="descripcionarticulo" name="descripcionarticulo" value="<%out.println(product.getDescripcionArticulo());%>"><%out.println(product.getDescripcionArticulo());%></textarea>
                                <%}else{%>
                                <textarea class="form-control" rows="5" id="descripcionarticulo" name="descripcionarticulo" ></textarea>
                                <%}%>
                              </div>
                           <div class="form-group">
                                <label for="categoriaarticulo"> Categoría:</label>
                                <select class="form-control" id="categoriarticulo" name="categoriaarticulo">
                                  <% CallableStatement stmt2 = connection.prepareCall("{CALL CATEGORIA_Load}");
                                    ResultSet rs2 = stmt2.executeQuery();
                                    while(rs2.next()){ %>
                                    <option><%out.println(rs2.getString("nombreCategoria"));%></option>
                                    <%}%>
                                   
                                </select>
                              </div>
                           <div class="form-group">
                                <label for="categoriaarticulo2"> Categoría:</label>
                                <select class="form-control" id="categoriarticulo2" name="categoriaarticulo2">
                                     <% 
                                    ResultSet rs3 = stmt2.executeQuery();
                                    while(rs3.next()){ %>
                                    <option><%out.println(rs3.getString("nombreCategoria"));%></option>
                                    <%}%>
                                </select>
                              </div>
                           <div class="form-group">
                                <label for="categoriaarticulo3"> Categoría:</label>
                                <select class="form-control" id="categoriarticulo3" name="categoriaarticulo3">
                          <% 
                                    ResultSet rs4 = stmt2.executeQuery();
                                    while(rs4.next()){ %>
                                    <option><%out.println(rs4.getString("nombreCategoria"));%></option>
                                    <%}%>
                                </select>
                              </div>
                            
                             <div class="form-group">
                                <label for="precioarticulo">Precio:</label>
                                <%if(product.getIdArticulo() == Integer.parseInt(String.valueOf(request.getParameter("product"))) && product.getIdUsuario() == Integer.parseInt(String.valueOf(session.getAttribute("idUsuario")))){%>
                                <input type="text" class="form-control" id="precioarticulo" name="precioarticulo" value="<%out.println(product.getPrecioArticulo());%>" onkeypress="return validarnumero(event)">
                                <%}else{%>
                                <input type="text" class="form-control" id="precioarticulo" name="precioarticulo" onkeypress="return validarnumero(event)">
                                <%}%>
                              </div>
                             <div class="form-group">
                                <label for="unidadesarticulo">Cantidad de Unidades Disponibles:</label>
                                <%if(product.getIdArticulo() == Integer.parseInt(String.valueOf(request.getParameter("product"))) && product.getIdUsuario() == Integer.parseInt(String.valueOf(session.getAttribute("idUsuario")))){%>
                                <input type="text" class="form-control" id="unidadesarticulo" name="unidadesarticulo" value="<%out.println(product.getUnidadesArticulo());%>" onkeypress="return validarnumero(event)">
                                <%}else{%>
                                <input type="text" class="form-control" id="unidadesarticulo" name="unidadesarticulo" onkeypress="return validarnumero(event)">
                                <%}%>
                              </div>
                            <div class="form-goup">
                                            
                                            <label for="fotoarticulo"> Foto del Artículo: </label>
                                            <input type="file" class="col-7" name="fotoarticulo" id="fotoarticulo">
                                            
                            </div>
                           <div class="form-goup">
                                            
                                            <label for="fotoarticulo2"> Foto del Artículo: </label>
                                            <input type="file" class="col-7" name="fotoarticulo2" id="fotoarticulo2">
                                            
                            </div>
                           <div class="form-goup">
                                            
                                            <label for="fotoarticulo3"> Foto del Artículo: </label>
                                            <input type="file" class="col-7" name="fotoarticulo3" id="fotoarticulo3">
                                            
                            </div>
                           <div class="form-goup">
                                            
                                            <label for="videoarticulo"> Video del Artículo: </label>
                                            <input type="file" class="col-7" name="videoarticulo" id="videoarticulo">
                                            
                            </div>
                       </div>
                       <div class="card-footer">
                           <div class="clearfix">
                                <div class="float-right">
                           <button type="submit" class="btn btn-info">Publicar Artículo</button>
                               </div>
                           </div>
                       </div>
                     </form>
                    </div>
                   
                   </div>
                                <%}else{%> <div class="col-sm-10">
                   <div class="card">
                      <div class="card-header">
                         
                          <h6 class="display-4">Publica un Artículo</h6>
                      </div>
                     
                       <form id="registroform" action="${pageContext.request.contextPath}/ProductoController" method="POST" enctype="multipart/form-data" onsubmit="return validaproducto(this)">
                       <div class="card-body">
                           <div class="form-group">
                               
                                <input class="form-control" name="action1" id="action1" type="hidden" value="publicar">
                                
                            
                                
                                <label for="nombrearticulo">Nombre del Articulo:</label>
                                <input type="text" class="form-control" id="nombrearticulo" name="nombrearticulo">
                                
                              </div>
                           <div class="form-group">
                                <label for="descripcionarticulo">Descripción del Articulo:</label>
                                <textarea class="form-control" rows="5" id="descripcionarticulo" name="descripcionarticulo" ></textarea>
                               
                              </div>
                           <div class="form-group">
                                <label for="categoriaarticulo"> Categoría:</label>
                                <select class="form-control" id="categoriarticulo" name="categoriaarticulo">
                                    <% CallableStatement stmt2 = connection.prepareCall("{CALL CATEGORIA_Load}");
                                    ResultSet rs2 = stmt2.executeQuery();
                                    while(rs2.next()){ %>
                                    <option><%out.println(rs2.getString("nombreCategoria"));%></option>
                                    <%}%>
                                </select>
                              </div>
                           <div class="form-group">
                                <label for="categoriaarticulo2"> Categoría:</label>
                                <select class="form-control" id="categoriarticulo2" name="categoriaarticulo2">
                                    <% 
                                    ResultSet rs3 = stmt2.executeQuery();
                                    while(rs3.next()){ %>
                                    <option><%out.println(rs3.getString("nombreCategoria"));%></option>
                                    <%}%>
                                </select>
                              </div>
                           <div class="form-group">
                                <label for="categoriaarticulo3"> Categoría:</label>
                                <select class="form-control" id="categoriarticulo3" name="categoriaarticulo3">
                                    <% 
                                    ResultSet rs4 = stmt2.executeQuery();
                                    while(rs4.next()){ %>
                                    <option><%out.println(rs4.getString("nombreCategoria"));%></option>
                                    <%}%>
                                </select>
                              </div>
                            
                             <div class="form-group">
                                <label for="precioarticulo">Precio:</label>
                               
                                <input type="text" class="form-control" id="precioarticulo" name="precioarticulo" onkeypress="return validarnumero(event)">
                                
                              </div>
                             <div class="form-group">
                                <label for="unidadesarticulo">Cantidad de Unidades Disponibles:</label>
                               
                                <input type="text" class="form-control" id="unidadesarticulo" name="unidadesarticulo" onkeypress="return validarnumero(event)">
                              
                              </div>
                            <div class="form-goup">
                                            
                                            <label for="fotoarticulo"> Foto del Artículo: </label>
                                            <input type="file" class="col-7" name="fotoarticulo" id="fotoarticulo">
                                            
                            </div>
                           <div class="form-goup">
                                            
                                            <label for="fotoarticulo2"> Foto del Artículo: </label>
                                            <input type="file" class="col-7" name="fotoarticulo2" id="fotoarticulo2">
                                            
                            </div>
                           <div class="form-goup">
                                            
                                            <label for="fotoarticulo3"> Foto del Artículo: </label>
                                            <input type="file" class="col-7" name="fotoarticulo3" id="fotoarticulo3">
                                            
                            </div>
                           <div class="form-goup">
                                            
                                            <label for="videoarticulo"> Video del Artículo: </label>
                                            <input type="file" class="col-7" name="videoarticulo" id="videoarticulo">
                                            
                            </div>
                       </div>
                       <div class="card-footer">
                           <div class="clearfix">
                                <div class="float-right">
                           <button type="submit" class="btn btn-info">Publicar Artículo</button>
                               </div>
                           </div>
                       </div>
                     </form>
                    </div>
                   
                   </div><%}
                                     }catch (SQLException e) {
                                   e.printStackTrace();}
                                  %>  
              </div>
            
            </div>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
        <script src="${pageContext.request.contextPath}/js/popper.js"></script>
        <script src="${pageContext.request.contextPath}/js/validacion.js"></script>
    </body>
</html>
