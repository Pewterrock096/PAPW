<%-- 
    Document   : producto
    Created on : 19/10/2018, 04:53:21 AM
    Author     : axelg
--%>

<%@page import="java.sql.CallableStatement"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
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
        <link rel ="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/producto.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
        <title>Producto</title>
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
                           
                    <% if (request.getParameter("product") != null){ %>   
                         <% 
                              Connection connection = Database.getConnection();
                              
                             try {
                                 Product product = new Product();
                                 User user = new User();
                                 int numerin = 0;
                                 int cant = 0;
                                 int prom = 0;
                                 int dio = 0;
                                  int usuarioactual = 0;
                                 if(session.getAttribute("idUsuario") != null){
                                 usuarioactual = Integer.parseInt(String.valueOf(session.getAttribute("idUsuario")));
                                 }
                                boolean ya = false;
                               try{
                                     CallableStatement stmt4 = connection.prepareCall("{CALL CALIFICACION_Select(?)}");
                                 stmt4.setInt(1, Integer.parseInt(request.getParameter("product")));
                                 ResultSet rs4 = stmt4.executeQuery();
                                 while(rs4.next()){
                                  
                                     numerin = numerin + rs4.getInt("Calificacion");
                                     cant++;  
                                     if(rs4.getInt("idUsuario") == usuarioactual){
                                      ya = true;  
                                      dio = rs4.getInt("Calificacion");
                                     }
                                 }
                                 try{
                                     prom = numerin/cant;
                                 
                                 }catch(Exception e){
                                    prom = 0; 
                                 }
                               } catch(SQLException ex) {
                                   ex.printStackTrace();
                                 }
                                
                                 
                                CallableStatement stmt = connection.prepareCall("{CALL ARTICULO_Load(?)}");
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
                                    product.setCalificacionArticulo(prom);
                                    product.setVideo(rs.getString("videoArticulo"));
                                    user.setUsuarioUsuario(rs.getString("usuarioUsuario"));
                                    user.setIdUsuario(Integer.parseInt(rs.getString("idUsuario")));
                                    
                                    CallableStatement stmt3 = connection.prepareCall("{CALL ARTICULO_LoadCategorias(?)}");
                                    stmt3.setInt(1, product.getIdArticulo());
                                   
                          %>
                          
               <div class="col-sm-10">
                   <div class="container">
                       <div class="row">
                           
                           <div class="col-6">
                               <div id="imagenproducto" class="carousel slide" data-ride="carousel">
                                     <ul class="carousel-indicators">
                                        <li data-target="#imagenproducto" data-slide-to="0" class="active"></li>
                                        <li data-target="#imagenproducto" data-slide-to="1"></li>
                                        <li data-target="#imagenproducto" data-slide-to="2"></li>
                                        <li data-target="#imagenproducto" data-slide-to="3"></li>
                                      </ul>
                                   
                                     <div class="carousel-inner">
                                            <div class="carousel-item active">
                                              <img class="img-fluid d-block mx-auto" src="${pageContext.request.contextPath}/jsp/imagen.jsp?id=<%out.println(request.getParameter("product").trim());%>&img=1" style="width:640px;height:360px" alt="Imagen">
                                            </div>
                                         <div class="carousel-item">
                                             <img class="img-fluid d-block mx-auto" src="${pageContext.request.contextPath}/jsp/imagen.jsp?id=<%out.println(request.getParameter("product").trim());%>&img=2" style="width:640px;height:360px"alt="Imagen">
                                            </div>
                                         <div class="carousel-item">
                                              <img class="img-fluid d-block mx-auto" src="${pageContext.request.contextPath}/jsp/imagen.jsp?id=<%out.println(request.getParameter("product").trim());%>&img=3" style="width:640px;height:360px" alt="Imagen">
                                            </div>
                                         <div class="carousel-item">
                                             <video width="640" height="360"  style="width:640px;height:360px" controls preload><source src="${pageContext.request.contextPath}/videos/<%out.println(product.getVideo().trim());%>" type="video/mp4"></video>
                                            </div>
                                      </div>
                                   
                                     <a class="carousel-control-prev" href="#imagenproducto" data-slide="prev">
                                        <span class="carousel-control-prev-icon"></span>
                                      </a>
                                      <a class="carousel-control-next" href="#imagenproducto" data-slide="next">
                                        <span class="carousel-control-next-icon"></span>
                                      </a>
                               </div>
                           </div>
                           <div class="col-6">
                               <form id="registroform" name="registroform" action="${pageContext.request.contextPath}/ShopController" method="POST">
                                   <input class="form-control" name="action1" id="action1" type="hidden" value="addcart">
                                   <input class="form-control" name="param" id="param" type="hidden" value="<%out.println(request.getParameter("product").trim());%>">
                               <div class="card">
                                  <div class="card-header"><%out.println(product.getNombreArticulo());%></div>
                                  <div class="card-body">
                                      <div class="row">
                                          <div class="col-6">
                                              <h6>Precio</h6>
                                              <h6><%out.println(product.getPrecioArticulo());%></h6>
                                              <br>
                                          </div>
                                          <div class="col-6">
                                              <h6>Valoración</h6>
                                              <h6><%out.println(product.getCalificacionArticulo());%></h6>
                                              <%  CallableStatement stmt4 = connection.prepareCall("{CALL ARTICULO_Calificar(?, ?)}");
                                    stmt4.setInt(1, product.getCalificacionArticulo());
                                    stmt4.setInt(2, product.getIdArticulo());
                                    stmt4.executeQuery();%>
                                          </div>
                                          <br>
                                      </div>
                                      <div class="row">
                                          <div class="col-6">
                                              <h6>Vendedor</h6>
                                              <a href="${pageContext.request.contextPath}/jsp/perfil.jsp?usuario=<%out.println(user.getIdUsuario());%>"><%out.println(user.getUsuarioUsuario());%></a>
                                          </div>
                                          <br>
                                          <div class="col-6">
                                              <h6>Unidades Restantes</h6>
                                              <h6><%out.println(product.getUnidadesArticulo());%></h6>
                                          </div>
                                          <br>
                                      </div>
                                         
                                  </div>
                                  <div class="card-footer">
                                      <%if(product.getUnidadesArticulo() != 0){%>
                                      <%if(session.getAttribute("idUsuario") != null){%>
                                      <button type="submit" class="btn btn-block"><i class="fa fa-shopping-cart"></i> Añadir al Carrito</button>
                                      <%}else{%>
                                      <h5><b>Inicie sesión para comprar este articulo</b></h5>
                                      <%}
                                      } else{%>
                                       <h5><b>Producto Agotado</b></h5>
                                      <%}%>
                                  </div>
                                </div>
                               </form>
                                          
                                          <%if(session.getAttribute("idUsuario") != null){
                                              if(ya == false){%> 
                                             <form id="registroform" name="registroform" action="${pageContext.request.contextPath}/ShopController" method="POST">
                                                 <input class="form-control" name="action1" id="action1" type="hidden" value="calificar">
                                                  <input class="form-control" name="param" id="param" type="hidden" value="<%out.println(request.getParameter("product").trim());%>">
                                          <div class="row">
                                              <div class="col-6">
                                                  <br>
                                                  <h6>Calificar Producto</h6>
                                                  <input type="radio" name="calif" value="1"> 1
                                                  <input type="radio" name="calif" value="2"> 2
                                                  <input type="radio" name="calif" value="3" checked="checked"> 3
                                                  <input type="radio" name="calif" value="4"> 4
                                                  <input type="radio" name="calif" value="5"> 5
                                              </div>
                                              <div class="col-6">
                                                  <br>
                                                  <button type="submit" class="btn btn-block"><i class="fa fa-star-half-alt"></i> Calificar</button>
                                              </div>
                                          </div>
                                            </form>
                                          <%} else{%>
                                          
                                          <div class="col-6">
                                          <h6>Califico el Producto con <%out.println(dio);%></h6>
                                          </div>
                                          <%}
                                          }%>
                           </div>
                       </div>                
               </div>
                   <div class="container">
                       <div class="card">
                           <div class="card-header"><b>Categoria del Producto</b>
                              <br>
                              <%ResultSet rs3 = stmt3.executeQuery();
                              while (rs3.next()){
                                  out.println(rs3.getString("nombreCategoria"));
                              %>
                              <br>
                              <%}%>
                         
                          </div>
                          <div class="card-body"><b>Descripción del Producto</b>
                              <br>
                          <%out.println(product.getDescripcionArticulo());%>
                          </div>
                        </div>
                     </div>
                   <form class="form" action="${pageContext.request.contextPath}/CommentController" method="POST" onsubmit="return validacomentario(this)">
                   <div class="container">
                       <div class="card">
                           <div class="card-body">
                               <div class="form-group">
                                   <input class="form-control" name="param" id="param" type="hidden" value="<%out.println(request.getParameter("product").trim());%>">
                                  <label for="Comentar">Deja un Comentario:</label>
                                  <textarea class="form-control" rows="5" id="Comentar" name="Comentar"></textarea>
                                </div>
                               <button type="submit" class="btn btn-block"><i class="far fa-comment"></i> Comentar</button>
                           </div>
                        </div>
                   </div>
                   </form>
                                  <%CallableStatement stmt2;
                                stmt2 = connection.prepareCall("{CALL COMENTARIO_Load(?)}");
                                stmt2.setInt(1, Integer.parseInt(request.getParameter("product")));
                                 
                                  ResultSet rs2 = stmt2.executeQuery();
                                while (rs2.next()) {
                                    %>
                     <div class="container">
                       <div class="card">
                           <div class="card-header">
                               <h5><b><img src="${pageContext.request.contextPath}/jsp/imagen.jsp?id=<%out.println(rs2.getInt("comentario.idUsuario"));%>&img=5" style="max-width: 20px;" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/imgenes/usuario.png';" alt="Foto"><%out.println(rs2.getString("usuarioUsuario"));%></b></h5>
                           </div>
                           <div class="card-body">
                               <div class="form-group">
                                   <h5><%out.println(rs2.getString("comentarioComentario"));%></h5>
                                </div>
                               
                           </div>
                        </div>
                   </div>
                     <%}%>
                   </div>
                       <%}
                                     } catch (SQLException e) {
                                   e.printStackTrace();}
                                  }%>              
              </div>
            
            </div>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
        <script src="${pageContext.request.contextPath}/js/popper.js"></script>
        <script src="${pageContext.request.contextPath}/js/validacion.js"></script>
    </body>
</html>