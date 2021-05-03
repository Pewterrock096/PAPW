<%-- 
    Document   : carrito
    Created on : 19/10/2018, 04:52:58 AM
    Author     : axelg
--%>

<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="model.Product"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="model.User"%>
<%@page import="java.sql.Connection"%>
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
        <title>Carrito</title>
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
                                  int totalCarrito = 0;%>
               <div class="col-sm-10">
                   <div class="card">
                       <div class="card-header"><h1 class="display-4">Carrito</h1></div>
                       <div class="card-body">
                             <%if(request.getParameter("usuario") != null){%>
                                 <% 
                              Connection connection = Database.getConnection();
                             try {
                                
                                 
                                 CallableStatement stmt;
                                stmt = connection.prepareCall("{CALL CARRITO_Load(?)}");
                                stmt.setInt(1, Integer.parseInt(request.getParameter("usuario")));
                                 
                                  ResultSet rs = stmt.executeQuery();
                                while (rs.next()) {
                                    Product product = new Product();
                                    product.setCantidadEnCarrito(Integer.parseInt(rs.getString("cantidadCarrito")));
                                    product.setIdCarrito(Integer.parseInt(rs.getString("carrito.idCarrito")));
                                    product.setIdArticulo(Integer.parseInt(rs.getString("carrito.idArticulo")));
                                    product.setIdUsuario(Integer.parseInt(rs.getString("carrito.idUsuario")));
                                    product.setNombreArticulo(rs.getString("nombreArticulo"));
                                    //product.setDescripcionArticulo(rs.getString("descripcionArticulo"));
                                   // product.setCategoria1Articulo(rs.getString("categoria1Articulo"));
                                   // product.setCategoria2Articulo(rs.getString("categoria2Articulo"));
                                    //product.setCategoria3Articulo(rs.getString("categoria3Articulo"));
                                    product.setPrecioArticulo(Integer.parseInt(rs.getString("precioArticulo")));
                                    product.setUnidadesArticulo(Integer.parseInt(rs.getString("unidadesArticulo")));
                                    int totalArticulo = product.getCantidadEnCarrito() * product.getPrecioArticulo();
                                    totalCarrito = totalCarrito + totalArticulo;
                                    
                          %>
                           <div class="card">
                                                           
                                   <div class="card-body">
                                       
                                       <div class="row">
                                           <form class="form-inline" action="${pageContext.request.contextPath}/CartController" method="POST">
                                            <input class="form-control" name="action1" id="action1" type="hidden" value="update">
                                            <input class="form-control" name="param" id="param" type="hidden" value="<%out.println(product.getIdArticulo());%>">
                                            <input class="form-control" name="param2" id="param2" type="hidden" value="<%out.println(product.getIdCarrito());%>">
                                           <div class="col-sm-2">
                                           <a href="${pageContext.request.contextPath}/jsp/producto.jsp?product=<%out.println(product.getIdArticulo());%>"> <img src="${pageContext.request.contextPath}/jsp/imagen.jsp?id=<%out.println(product.getIdArticulo());%>&img=1" class="img-thumbnail" style="max-width: 100px;"  alt="Imagen"></a>
                                           </div>
                                            <div class="col-sm-3">
                                                <a href="${pageContext.request.contextPath}/jsp/producto.jsp?product=<%out.println(product.getIdArticulo());%>"><%out.println(product.getNombreArticulo());%></a>
                                                <h6>$<%out.println(product.getPrecioArticulo());%></h6>
                                                
                                            </div>
                                           <div class="col-sm-4">
                                               <div class="form-group">
                                                  <label for="cantidad">Cantidad</label>
                                                  <input type="number" class="form-control" id="cantidad" name="cantidad" value=<%out.println(product.getCantidadEnCarrito());%> min="0" max=<%out.println(product.getUnidadesArticulo());%>>
                                                </div>
                                           </div>
                                                     
                                           <div class="col-sm-1">
                                               
                                             
                                                <input class="form-control" name="action1" id="action1" type="hidden" value="update">
                                                
                                                <button type="submit" class="btn"><i class="fa fa-sync-alt"></i> Actualizar Cantidad</button>
                                           
                                               
                                           </div>
                                                
                                                </form>
                                           <div class="col-sm-1">
                                               
                                               <form class="form-inline" action="${pageContext.request.contextPath}/CartController" method="POST">
                                                   <input class="form-control" name="param2" id="param2" type="hidden" value="<%out.println(product.getIdCarrito());%>">
                                                <input class="form-control" name="action1" id="action1" type="hidden" value="delete">
                                                <button type="submit" class="btn"><i class="fa fa-trash-alt"></i> Eliminar</button>
                                           
                                               </form>
                                           </div>
                                       </div>  
                                       
                                   </div>
                                                
                            </div>
                                                      <%
                                                    }
                                   } catch (SQLException e) {
out.println(Integer.parseInt(request.getParameter("usuario")));
                                   e.printStackTrace();}
                                  }%>    
                            <!--     <div class="card-body">
                                       <div class="row">
                                           <div class="col-1">
                                           <a href="${pageContext.request.contextPath}/jsp/producto.jsp"> <img src="${pageContext.request.contextPath}/imgenes/imagen.png" class="img-thumbnail" alt="Imagen"></a>
                                           </div>
                                            <div class="col-6">
                                                <a href="${pageContext.request.contextPath}/jsp/producto.jsp">Nombre</a>
                                                <h6>Precio</h6>
                                                
                                            </div>
                                           <div class="col-1">
                                               <div class="form-group">
                                                  <label for="cantidad">Cantidad</label>
                                                  <input type="text" class="form-control" id="cantidad">
                                                </div>
                                           </div>
                                           <div class="col-2">
                                           <a href="#"><i class="fa fa-trash-alt"></i> Eliminar</a>
                                           </div>
                                       </div>                                     
                                   </div>

                            </div>
                                  <div class="card-body">
                                       <div class="row">
                                           <div class="col-1">
                                           <a href="${pageContext.request.contextPath}/jsp/producto.jsp"> <img src="${pageContext.request.contextPath}/imgenes/imagen.png" class="img-thumbnail" alt="Imagen"></a>
                                           </div>
                                            <div class="col-6">
                                                <a href="${pageContext.request.contextPath}/jsp/producto.jsp">Nombre</a>
                                                <h6>Precio</h6>
                                                
                                            </div>
                                           <div class="col-1">
                                               <div class="form-group">
                                                  <label for="cantidad">Cantidad</label>
                                                  <input type="text" class="form-control" id="cantidad">
                                                </div>
                                           </div>
                                           <div class="col-2">
                                           <a href="#"><i class="fa fa-trash-alt"></i> Eliminar</a>
                                           </div>
                                       </div>                                     
                                   </div>

                            </div>
                                <div class="card-body">
                                       <div class="row">
                                           <div class="col-1">
                                           <a href="${pageContext.request.contextPath}/jsp/producto.jsp"> <img src="${pageContext.request.contextPath}/imgenes/imagen.png" class="img-thumbnail" alt="Imagen"></a>
                                           </div>
                                            <div class="col-6">
                                                <a href="${pageContext.request.contextPath}/jsp/producto.jsp">Nombre</a>
                                                <h6>Precio</h6>
                                                
                                            </div>
                                           <div class="col-1">
                                               <div class="form-group">
                                                  <label for="cantidad">Cantidad</label>
                                                  <input type="text" class="form-control" id="cantidad">
                                                </div>
                                           </div>
                                           <div class="col-2">
                                           <a href="#"><i class="fa fa-trash-alt"></i> Eliminar</a>
                                           </div>
                                       </div>                                     
                                   </div> -->

                            </div>
                       </div>
                       <div class="card-footer">
                           <div class="clearfix">
                               <div class="float-left">
                                   <h4>Total:</h4>
                                   <br>
                                   <h6>$<%out.println(totalCarrito);%></h6>
                               </div>
                                <div class="float-right">
                                     <form class="form-inline" action="${pageContext.request.contextPath}/CartController" method="POST">
                                          <input class="form-control" name="action1" id="action1" type="hidden" value="empty">
                                   <button type="submit" class="btn btn-secondary"> Vaciar Carrito</button>
                                     </form>
                                    <form class="form-inline" action="${pageContext.request.contextPath}/CartController" method="POST">
                                        
                                         <input class="form-control" name="action1" id="action1" type="hidden" value="send">
                                          
                                   <button type="submit" class="btn btn-info">Terminar Compra</button>
                                    </form>
                                </div>
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