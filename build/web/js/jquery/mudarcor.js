/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function(){
    /*inicio index*/
    
    $("div#azul").hover(function(){
        $("div#barra").css("background-color","#115895");
        $("a").css("color","#fff");
    });
    $("div#amarelo").hover(function(){
        $("div#barra").css("background-color","#d08b2c");
        $("a").css("color","#fff");
    });
    $("div#vermelho").hover(function(){
        $("div#barra").css("background-color","#b7423d");
        $("a").css("color","#fff");
    });
    $("div#verde").hover(function(){
        $("div#barra").css("background-color","#4a974a");
        $("a").css("color","#fff");
    });
    
    $("div#atalhorow").hover(function(){
        $("#barra").css("background-color","#222");
        $("a").css("color","#cdcdcd");
    });
    
    /*fim index*/
});

