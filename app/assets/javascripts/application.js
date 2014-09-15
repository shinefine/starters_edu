// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require semantic-ui
//= require d3.v3
//= require nv.d3.min
//= require stream_layers



$(function(){
    $('.ui.dropdown').dropdown();

    $('div#login_button').on('click', function(event){
        alert("ajax submit");
//        $.ajax({
//            url: $(this).prop('action'),
//            dataType: 'json'
//        }).done(function(data) {
//            /* 本地逻辑 */
//        });

    })

    $(".login_link").on('click',function(){

            $('.test.modal').modal('show');

        }
    );
    var func_add_nestForm_field =function(event) {

        var time = new Date().getTime();
        var regexp = new RegExp($(this).data('id'), 'g');
        $(this).before($(this).data('fields').replace(regexp, time));
        event.preventDefault();
    };
    var func_remove_nestForm_field =function(event) {
        //把_destroy设置为1，并且隐藏fieldset

        $(this).prev('input[type=hidden]').val('1');
        $(this).closest('fieldset').hide();
        event.preventDefault();
    };
     //处理点击此类型链接的事件,把data-fields的信息，插入form中


    $('form .add_nest_form_field_link')
        .on('click', func_add_nestForm_field);

    $('form')
        .on('click','.remove_nest_form_field_link',  func_remove_nestForm_field);





    var func_mouse_enter= function() {
        $(this)
            .stop()
            .animate({
                width: '155px'
            }, 300, function() {
                $(this).find('.text').show();
            })
        ;
    };
    var func_mouse_leave= function(event) {
        $(this).find('.text').hide();
        $(this)
            .stop()
            .animate({
                width: '70px'
            }, 300)
        ;
    };
    $('.attached.launch.button')
        .on('mouseenter', func_mouse_enter)
        .on('mouseleave', func_mouse_leave);

    $('#menu').sidebar('attach events', '.launch.button, .launch.item');

    $('.left.sidebar').first().sidebar('attach events', '.toggle.button');
    $('.toggle.button').removeClass('disabled');

});


