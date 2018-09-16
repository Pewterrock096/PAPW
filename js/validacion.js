/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

 function validalogin(f){
     if (f.usuariologin =="" || f.contraseñalogin==""){
         alert('Debe llenar todos los campos');
     }
     else{
     if(f.usuariologin.value < 6){
             alert('El usuario debe tener minimo 6 carácteres');
         }
         if (f.contraseñalogin.value < 8){
             alert('La contraseña debe contener minimo 8 carácteres');
         }
         else{
             if(requerimientos(f.contraseñalogin.value) === false){
                 alert('La contraseña debe tener minimo 1 mayuscula, 1 minuscula y 1 numero');
             }
         }
     }
 }
 
 function validaregistro(p){
     if (p.nombre.value == "" || p.apellido.value == "" || p.correo.value == "" || p.usuario.value == "" || p.contraseña.value == "" || p.imagenportada.value == "" || p.imagenusuario.value == ""){
     alert('Debe llenar todos los campos');
     }
     else{
         if (p.usuario.value < 6){
             alert('El usuario debe contener minimo 6 carácteres');
         }
         if (p.contraseña.value < 8){
             alert('La contraseña debe tener minimo 8 carácteres');
         }
         else{
             if(requerimientos(p.contraseña.value) === false){
                 alert('La contraseña debe tener minimo 1 mayuscula, 1 minuscula y 1 numero');
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