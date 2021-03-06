<%-- 
    Document   : home
    Created on : 19/10/2018, 04:29:57 AM
    Author     : axelg
--%>

<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="model.User"%>
<%@page import="model.Product"%>
<%@page import="util.Database"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset = "UTF-8">
        <meta htttp-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width = device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css" >
        <link rel ="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css" >
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <title>Inicio</title>
        <% Connection connection = Database.getConnection(); %>
    </head>
    <body>
        test
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

                      <!--    <div class="card">
                            <div class="card-header">
                              <a class="card-link" data-toggle="collapse" href="#TOP">
                                Los más...
                              </a>
                            </div>
                            <div id="TOP" class="collapse show" data-parent="#accordion">
                              <div class="card-body">
                                <p><a href="#">Vendidos</a></p>
                                <p><a href="#">Vistos</a></p>
                                <p><a href="#">Buscados</a></p>
                                <p><a href="#">Mejor Calificados</a></p>
                              </div>
                            </div>
                          </div>-->
                         
                         <div class="card">
                            <div class="card-header">
                              <a class="card-link" data-toggle="collapse" href="#top">
                                Lo más...
                              </a>
                            </div>
                            <div id="top" class="collapse show" data-parent="#accordion">
                              <div class="card-body">
                                     
                                    <p><a href="${pageContext.request.contextPath}/jsp/home.jsp?top=nuevo">Nuevo</a></p>
                                    <p><a href="${pageContext.request.contextPath}/jsp/home.jsp?top=calificado">Mejor Calificado</a></p>
          
                              </div>
                            </div>
                          </div>
                         <div class="card">
                            <div class="card-header">
                              <a class="card-link" data-toggle="collapse" href="#Categorias">
                                Categorias
                              </a>
                            </div>
                            <div id="Categorias" class="collapse" data-parent="#accordion">
                              <div class="card-body">
                                     <% CallableStatement stmt2 = connection.prepareCall("{CALL CATEGORIA_Load}");
                                    ResultSet rs2 = stmt2.executeQuery();
                                    while(rs2.next()){ %>
                                    <p><a href="${pageContext.request.contextPath}/jsp/home.jsp?category=<%out.println(rs2.getInt("idCategoria"));%>"><%out.println(rs2.getString("nombreCategoria"));%></a></p>
                                  
                                    <%}%>
                                   
                              </div>
                            </div>
                          </div>
                          <%if (session.getAttribute("usuarioUsuario") != null){%>
                        <div class="card">
                            <div class="card-header">
                              <a class="card-link" data-toggle="collapse" href="#Opciones">
                                Opciones de Usuario
                              </a>
                            </div>
                            <div id="Opciones" class="collapse" data-parent="#accordion">
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
               <div class="col-sm-10">
                   <div class="container">
                               <div id="carouselbanner" class="carousel slide" data-ride="carousel">
                                     <ul class="carousel-indicators">
                                        <li data-target="#carouselbanner" data-slide-to="0" class="active"></li>
                                        <li data-target="#carouselbanner" data-slide-to="1"></li>
                                        <li data-target="#carouselbanner" data-slide-to="2"></li>
                                      </ul>
                                   
                                     <div class="carousel-inner">
                                            <div class="carousel-item active">
                                              <img class="img-fluid" src="${pageContext.request.contextPath}/imgenes/banner.png" alt="Imagen">
                                            </div>
                                         <div class="carousel-item">
                                              <img class="img-fluid" src="${pageContext.request.contextPath}/imgenes/banner.png" alt="Imagen">
                                            </div>
                                         <div class="carousel-item">
                                              <img class="img-fluid" src="${pageContext.request.contextPath}/imgenes/banner.png" alt="Imagen">
                                            </div>
                                      </div>
                                   
                                     <a class="carousel-control-prev" href="#carouselbanner" data-slide="prev">
                                        <span class="carousel-control-prev-icon"></span>
                                      </a>
                                      <a class="carousel-control-next" href="#carouselbanner" data-slide="next">
                                        <span class="carousel-control-next-icon"></span>
                                      </a>
                               </div>                       
                   </div>
                <div class="container">   
                  <div class="row">
                      
                          <% 
                              
                             try {
                                 CallableStatement statement;
                                 statement = connection.prepareCall("{CALL ARTICULO_Select}");
                                 if(request.getParameter("top") != null){
                                     
                                     if(request.getParameter("top").trim().equals("nuevo")){
                                         statement = connection.prepareCall("{CALL ARTICULO_SortByID}");
                                         
                                     }
                                     if(request.getParameter("top").trim().equals("calificado")){
                                         statement = connection.prepareCall("{CALL ARTICULO_SortByAverage}");
                                     }
                                 }
                                if(request.getParameter("category") != null){
                                    statement = connection.prepareCall("{CALL ARTICULO_SelectCategoria(?)}");
                                    statement.setInt(1, Integer.parseInt(request.getParameter("category").trim()));
                                }
                                
                                ResultSet rs = statement.executeQuery();
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
                        <div class="card-body text-center"><img src="${pageContext.request.contextPath}/jsp/imagen.jsp?id=<%out.println(product.getIdArticulo());%>&img=1" " class="img-thumbnail" style="width:100%;" alt="Image"></div>
                        <div class="card-footer text-center">$<%out.println(product.getPrecioArticulo());%></div>
                          </a>
                      </div>
                    </div>
                          <%}
                                     } catch (SQLException e) {
                                   e.printStackTrace();
                             }%>
                    
                     <!-- <div class="col-sm-3">
                      <div class="card">
                          <a href="${pageContext.request.contextPath}/jsp/producto.jsp">
                        <div class="card-header text-center">Nombre del Producto</div>
                        <div class="card-body text-center"><img src="${pageContext.request.contextPath}/imgenes/imagen.png" class="img-thumbnail" style="width:100%" alt="Image"></div>
                        <div class="card-footer text-center">Precio</div>
                          </a>
                      </div>
                    </div>
                         <div class="col-sm-3">
                      <div class="card">
                          <a href="${pageContext.request.contextPath}/jsp/producto.jsp">
                        <div class="card-header text-center">Nombre del Producto</div>
                        <div class="card-body text-center"><img src="${pageContext.request.contextPath}/imgenes/imagen.png" class="img-thumbnail" style="width:100%" alt="Image"></div>
                        <div class="card-footer text-center">Precio</div>
                          </a>
                      </div>
                    </div>
                        <div class="col-sm-3">
                      <div class="card">
                          <a href="${pageContext.request.contextPath}/jsp/producto.jsp">
                        <div class="card-header text-center">Nombre del Producto</div>
                        <div class="card-body text-center"><img src="${pageContext.request.contextPath}/imgenes/imagen.png" class="img-thumbnail" style="width:100%" alt="Image"></div>
                        <div class="card-footer text-center">Precio</div>
                          </a>
                      </div>
                    </div> -->
                  </div>
                </div>

                   <!--                <div class="container">    
                  <div class="row">
                        <div class="col-sm-3">
                      <div class="card">
                          <a href="${pageContext.request.contextPath}/jsp/producto.jsp">
                        <div class="card-header text-center">Nombre del Producto</div>
                        <div class="card-body text-center"><img src="${pageContext.request.contextPath}/imgenes/imagen.png" class="img-thumbnail" style="width:100%" alt="Image"></div>
                        <div class="card-footer text-center">Precio</div>
                          </a>
                      </div>
                    </div>
                        <div class="col-sm-3">
                      <div class="card">
                          <a href="${pageContext.request.contextPath}/jsp/producto.jsp">
                        <div class="card-header text-center">Nombre del Producto</div>
                        <div class="card-body text-center"><img src="${pageContext.request.contextPath}/imgenes/imagen.png" class="img-thumbnail" style="width:100%" alt="Image"></div>
                        <div class="card-footer text-center">Precio</div>
                          </a>
                      </div>
                    </div>
                        <div class="col-sm-3">
                      <div class="card">
                          <a href="${pageContext.request.contextPath}/jsp/producto.jsp">
                        <div class="card-header text-center">Nombre del Producto</div>
                        <div class="card-body text-center"><img src="${pageContext.request.contextPath}/imgenes/imagen.png" class="img-thumbnail" style="width:100%" alt="Image"></div>
                        <div class="card-footer text-center">Precio</div>
                          </a>
                      </div>
                    </div>
                         <div class="col-sm-3">
                      <div class="card">
                          <a href="${pageContext.request.contextPath}/jsp/producto.jsp">
                        <div class="card-header text-center">Nombre del Producto</div>
                        <div class="card-body text-center"><img src="${pageContext.request.contextPath}/imgenes/imagen.png" class="img-thumbnail" style="width:100%" alt="Image"></div>
                        <div class="card-footer text-center">Precio</div>
                          </a>
                      </div>
                    </div> 
                  </div>
                </div>-->
                   
                     <ul class="pagination justify-content-center">
                      <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                      <li class="page-item active"><a class="page-link" href="#">1</a></li>
                      <li class="page-item"><a class="page-link" href="#">2</a></li>
                      <li class="page-item"><a class="page-link" href="#">3</a></li>
                      <li class="page-item"><a class="page-link" href="#">Next</a></li>
                    </ul> 
                   
               </div>
              </div>
            
            </div>
       
       
        <script src="${pageContext.request.contextPath}/js/validacion.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
        <script src="${pageContext.request.contextPath}/js/popper.js"></script>
    </body>
</html>