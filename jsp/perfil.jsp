<%-- 
    Document   : perfil
    Created on : 19/10/2018, 04:53:12 AM
    Author     : axelg
--%>

<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
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
        <link rel ="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/perfil.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <title>Perfil</title>
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
                              <%if(request.getParameter("usuario") != null){%>
                                 <% 
                              Connection connection = Database.getConnection();
                             try {
                                 User user = new User();
                                CallableStatement stmt = connection.prepareCall("{CALL USUARIO_SelectByID(?)}");
                                stmt.setString(1, request.getParameter("usuario"));
                               
                                  ResultSet rs = stmt.executeQuery();
                                
                                if (rs.next()) {
                                    user.setNombreUsuario(rs.getString("nombreUsuario"));
                                    user.setApellidoUsuario(rs.getString("apellidoUsuario"));
                                    user.setIdUsuario(Integer.parseInt(rs.getString("idUsuario")));
                                    user.setCorreoUsuario(rs.getString("correoUsuario"));
                                    user.setDireccionUsuario(rs.getString("direccionUsuario"));
                                    user.setTelefonoUsuario(Integer.parseInt(rs.getString("telefonoUsuario")));
                                    user.setUsuarioUsuario(rs.getString("usuarioUsuario"));
   
                                    
                                    
                          %>
                  <div class="col-sm-10">
                      <div class="container">
                          <div class="banner">
                              <%if(rs.getBlob("portadaUsuario") == null){%>
                              <img src="${pageContext.request.contextPath}/imgenes/banner.png" class="rounded" alt="Banner">
                              <%}else{%>
                              <img src="${pageContext.request.contextPath}/jsp/imagen.jsp?id=<%out.println(user.getIdUsuario());%>&img=4" style="max-width:1200px;height:480px" class="rounded" alt="Banner" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/imgenes/banner.png';">
                              <%}%>
                          </div>
                      </div>
                      <div class="container">
                          <div class="card">
                              <div class="card-body">
                                  <div class="row">
                                      <div class="col-4">
                                          <%if(rs.getBlob("portadaUsuario") == null){%>
                                          <img src="${pageContext.request.contextPath}/imgenes/usuario.png" class="rounded" alt="Foto">
                                          <%}else{%>
                                          <img src="${pageContext.request.contextPath}/jsp/imagen.jsp?id=<%out.println(user.getIdUsuario());%>&img=5" style="max-width: 300px; width:100%;" class="rounded" alt="Foto" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/imgenes/usuario.png';">
                                           <%}%>
                                            <%if(user.getIdUsuario() == Integer.parseInt(String.valueOf(session.getAttribute("idUsuario")))){%>
                                          <form class="form" action="${pageContext.request.contextPath}/ImageController" method="POST" enctype="multipart/form-data" onsubmit="return validaimagen(this)">
                                            <div class="form-goup">
                                                <br>
                                                <label for="fotoperfil"> Foto de Perfil: </label><br>
                                                <input type="file" class="col-7" name="fotoperfil" id="fotoperfil">
                                            
                                             </div>
                                             <div class="form-goup">
                                                 <br>
                                                <label for="fotoportada"> Foto de Portada: </label><br>
                                                <input type="file" class="col-7" name="fotoportada" id="fotoportada">
                                            
                                             </div>
                                            <br>
                                            <input class="form-control" name="id" id="id" type="hidden" value="<%out.println(user.getIdUsuario());%>">
                                             <button type="submit" class="btn btn-info btn-block">Cambiar Fotos</button>
                                           </form>
                                            <%}%>
                                      </div>
                                      <div class="col-8">
                                          <div class="card">
                                              <div class="card-body">
                                                   <%if(user.getIdUsuario() == Integer.parseInt(String.valueOf(session.getAttribute("idUsuario")))){%>
                                                     <form class="form" action="${pageContext.request.contextPath}/UserController" method="POST">
                                                  <input class="form-control" name="action1" id="action1" type="hidden" value="update">
                                                  <input class="form-control" name="iduser" id="iduser" type="hidden" value="<%out.println(user.getIdUsuario());%>">
                                         
                                
                                                   <input class="form-control" name="usuario" id="usuario" type="text" value="<%out.println(user.getUsuarioUsuario());%>">   
                                                   
                                                  <br>
                                                  <h6><b>Nombre:</b></h6>
                                                  <br>
                                                   <input class="form-control" name="nombre" id="nombre" type="text" value="<%out.println(user.getNombreUsuario());%>">   
                                                   <h6><b>Apellido:</b></h6>
                                                  <input class="form-control" name="apellido" id="apellido" type="text" value="<%out.println(user.getApellidoUsuario());%>">   
                                                  
                                                  <br>
                                                  <h6><b>Contacto:</b></h6>
                                                  <h6>Correo: <input class="form-control" name="correo" id="correo" type="text" value="<%out.println(user.getCorreoUsuario());%>">   </h6>
                                                  <h6>Telefono: <input class="form-control" name="telefono" id="telefono" type="text" value="<%out.println(user.getTelefonoUsuario());%>"></h6>
                                                  <h6>Direccion: <input class="form-control" name="direccion" id="direccion" type="text" value="<%out.println(user.getDireccionUsuario());%>"></h6>
                                                  
                                                  <br>
                                                   <h6><b>Contraseña:</b></h6>
                                                   <input class="form-control" name="contra" id="contra" type="text" placeholder="Ingrese una contraseña">
                                                   <button type="submit" class="btn btn-info btn-block"><i class="fa fa-trash-alt"></i> Modificar Informacion </button>
                                                  </form>
                                                   <%} else{%>
                                                  <h5><b><%out.println(user.getUsuarioUsuario());%></b></h5>
                                                  <br>
                                                  <h6><b>Nombre:</b></h6>
                                                  <br>
                                                  <h6><%out.println(user.getNombreUsuario());%><%out.println(user.getApellidoUsuario());%></h6>
                                                  <br>
                                                  <h6><b>Contacto:</b></h6>
                                                  <h6>Correo: <%out.println(user.getCorreoUsuario());%></h6>
                                                  <h6>Telefono: <%out.println(user.getTelefonoUsuario());%></h6>
                                                  <h6>Direccion: <%out.println(user.getDireccionUsuario());%></h6>
                                                  
                                                  <%}%>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                            </div>
                      </div>
                      <div class="container">
                          <h4>Publicaciones del Usuario:</h4>
              <div class="container">    
                  <div class="row">
                     <% }
                                 stmt = connection.prepareCall("{CALL ARTICULO_SelectByUserID(?)}");
                                stmt.setInt(1, user.getIdUsuario());
                                 
                                  rs = stmt.executeQuery();
                                while (rs.next()) {
                                    Product product = new Product();
                                    product.setIdArticulo(Integer.parseInt(rs.getString("idArticulo")));
                                    product.setIdUsuario(Integer.parseInt(rs.getString("idUsuario")));
                                    product.setNombreArticulo(rs.getString("nombreArticulo"));
                                    product.setDescripcionArticulo(rs.getString("descripcionArticulo"));
                                    product.setCategoria1Articulo(rs.getInt("categoria1Articulo"));
                                    product.setCategoria2Articulo(rs.getInt("categoria2Articulo"));
                                    product.setCategoria3Articulo(rs.getInt("categoria3Articulo"));
                                    product.setPrecioArticulo(Integer.parseInt(rs.getString("precioArticulo")));
                                    product.setUnidadesArticulo(Integer.parseInt(rs.getString("unidadesArticulo")));
                                    
                          %>
                  <div class="col-sm-3">
                      <div class="card">
                          <a href="${pageContext.request.contextPath}/jsp/producto.jsp?product=<%out.println(product.getIdArticulo());%>">
                        <div class="card-header text-center"><%out.println(product.getNombreArticulo());%></div>
                       <div class="card-body text-center"><img src="${pageContext.request.contextPath}/jsp/imagen.jsp?id=<%out.println(product.getIdArticulo());%>&img=1"  class="img-thumbnail" style="width:100%" alt="Image">$<%out.println(product.getPrecioArticulo());%></div>
                                               <!--  <div class="card-body text-center"><img src="${pageContext.request.contextPath}/imgenes/imagen.png" class="img-thumbnail" style="width:100%" alt="Image">$<%out.println(product.getPrecioArticulo());%></div>-->
                          </a>
                        <div class="card-footer text-center">
                            <%if(user.getIdUsuario() == Integer.parseInt(String.valueOf(session.getAttribute("idUsuario")))){%>
                            <a href="${pageContext.request.contextPath}/jsp/vender.jsp?product=<%out.println(product.getIdArticulo());%>"><button type="button" class="btn btn-info btn-block"><i class="fa fa-edit"></i> Editar Publicación </button></a>
                             <form class="form" action="${pageContext.request.contextPath}/ShopController" method="POST">
                                 <input class="form-control" name="action1" id="action1" type="hidden" value="borrar">
                                 <input class="form-control" name="articulo" id="articulo" type="hidden" value="<%out.println(product.getIdArticulo());%>">
                                <button type="submit" class="btn btn-danger btn-block"><i class="fa fa-trash-alt"></i> Eliminar Publicación </button>
                             </form>
                            <%}else{out.println(String.valueOf(user.getIdUsuario()));
                                out.println(session.getAttribute("idUsuario"));

                            }%>
                        </div>
                      </div>
                    </div>  
                      
                     <!--  <div class="col-sm-3">
                      <div class="card">
                          <a href="${pageContext.request.contextPath}/jsp/producto.jsp">
                        <div class="card-header text-center">Nombre del Producto</div>
                        <div class="card-body text-center"><img src="${pageContext.request.contextPath}/imgenes/imagen.png" class="img-thumbnail" style="width:100%" alt="Image">Precio</div>
                          </a>
                        <div class="card-footer text-center">
                            <a href="${pageContext.request.contextPath}/vender.jsp"><button type="button" class="btn btn-info btn-block"><i class="fa fa-edit"></i> Editar Publicación </button></a>
                        </div>
                      </div>
                    </div>  
                        
                    <div class="col-sm-3">
                      <div class="card">
                          <a href="${pageContext.request.contextPath}/jsp/producto.jsp">
                        <div class="card-header text-center">Nombre del Producto</div>
                        <div class="card-body text-center"><img src="${pageContext.request.contextPath}/imgenes/imagen.png" class="img-thumbnail" style="width:100%" alt="Image">Precio</div>
                          </a>
                        <div class="card-footer text-center">
                            <a href="${pageContext.request.contextPath}/vender.jsp"><button type="button" class="btn btn-info btn-block"><i class="fa fa-edit"></i> Editar Publicación </button></a>
                        </div>
                      </div>
                    </div>    
                      
                        <div class="col-sm-3">
                      <div class="card">
                          <a href="${pageContext.request.contextPath}/jsp/producto.jsp">
                        <div class="card-header text-center">Nombre del Producto</div>
                        <div class="card-body text-center"><img src="${pageContext.request.contextPath}/imgenes/imagen.png" class="img-thumbnail" style="width:100%" alt="Image">Precio</div>
                          </a>
                        <div class="card-footer text-center">
                            <a href="${pageContext.request.contextPath}/vender.jsp"><button type="button" class="btn btn-info btn-block"><i class="fa fa-edit"></i> Editar Publicación </button></a>
                        </div>
                      </div>
                    </div>  -->
                    <%
                                       }  
                                   } catch (SQLException e) {
                                   e.printStackTrace();}
                                  }%>   
                  </div>
                        
                </div>
                      </div>
                  </div>
                                       
              </div>
            
            </div>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
        <script src="${pageContext.request.contextPath}/js/popper.js"></script>
        <script src="${pageContext.request.contextPath}/js/validacion.js"></script>
    </body>
</html>