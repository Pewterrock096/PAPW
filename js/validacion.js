/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

 function validalogin(f){
     var textBox = document.getElementById("usuariologin");
var textLength = textBox.value.length;

var textBox2 = document.getElementById("contralogin");
var textLength2 = textBox.value.length;
     if (f.usuariologin.value == "" || f.contralogin.value == ""){
         alert('Debe llenar todos los campos');
         return false;
     }
 }
 
 function validaregistro(p){
    var textBox = document.getElementById("usuario");
var textLength = textBox.value.length;

var textBox2 = document.getElementById("contra");
var textLength2 = textBox.value.length;
     if (p.nombre.value == "" || p.apellido.value == "" || p.correo.value == "" || p.usuario.value == "" || p.contra.value == ""){
     alert('Debe llenar todos los campos');
     
     return false;
     }
     else{
         if (textLength < 6){
             alert('El usuario debe contener minimo 6 carácteres');         
     return false;
         }
         if (textLength2 < 8){
             alert('La contraseña debe tener minimo 8 carácteres');           
     return false;
         }
         else{
             if(requerimientos(p.contra.value) === false){
                 alert('La contraseña debe tener minimo 1 mayuscula, 1 minuscula y 1 numero');        
     return false;
             }
         }
     }
 }
 
 function validarnumero(j){
    j = (j) ? j : window.event;
    var charCode = (j.which) ? j.which : j.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;

 }
 
 function requerimientos(m){
    var regex = /([a-z]+)/g;
    var boleano = false;
    if (regex.test(m) === true){
        regex = /([A-Z]+)/g;
        if (regex.test(m) === true){
            regex = /([0-9]+)/g;
            if(regex.test(m) === true){
                boleano = true;
            }
        }
    }
    return boleano;
 }
 
 function validaproducto(a){
     if(a.nombrearticulo.value == "" || a.descripcionarticulo.value == "" || a.precioarticulo.value == "" || a.unidadesarticulo.value == "" || a.fotoarticulo1.value == "" || a.fotoarticulo2.value == "" || a.fotoarticulo3.value == "" || a.videoarticulo.value == "" ){
          alert('Debe llenar todos los campos');     
     return false;
     }
 }
 
 function validacomentario(b){
     var textBox = document.getElementById("Comentar");
     if(textBox.value==""){
           alert('Debe escribir un comentario primero');     
     return false;
     }
 }
 
 function validaimagen(c){
     if(c.fotoperfil.value == "" || c.fotoportada.value == ""){
         alert('Debe elegir 2 imagenes'); 
         return false;
     }
 }