// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require best_in_place
//= require jquery_ujs
//= require semantic-ui/dist/semantic
//= require slick-carousel/slick/slick

$(document).ready(function(){
  // message behavior
  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });
  // pop up card when click
  $('.card').popup({on: 'click'});
  // init best in place
  $('.best_in_place').best_in_place();
  // launch menu buttons
  $(".launch").click(function(){
    console.log("asdfasd")
    $("#sidebar").sidebar('toggle');
  });
  // slick.js
  $(".slick").slick({
    slidesToScroll: 1,
    autoplay: true,
    autoplaySpeed: 4000,
    fade: true,
    cssEase: 'linear'
  });
  $('.slick').on('afterChange', function(event, slick, currentSlide, nextSlide){
    var imageUrl = "assets/background-" + currentSlide + ".jpg";
    $('#kietnvt').css('background-image', 'url(' + imageUrl + ')');
  });
});