//
//= require jquery
//= require jquery.remotipart
//= require jquery_ujs
//= require bootstrap-sprockets
//= require toastr/toastr.min.js
//= require metisMenu/jquery.metisMenu.js
//= require pace/pace.min.js
//= require peity/jquery.peity.min.js
//= require slimscroll/jquery.slimscroll.min.js
//= require inspinia.js
//= require angular

$(document).ready(function(){
    var isopen="";
    $('#menu_button').click(function(){
        if (!open){
            $('.navbar-fixed-top').css('position','relative');
            $('html,body').animate({ scrollTop: 0 }, 'normal');
        }else{
            $('.navbar-fixed-top').css('position','fixed');
        }
        isopen=!isopen;
    });
});


