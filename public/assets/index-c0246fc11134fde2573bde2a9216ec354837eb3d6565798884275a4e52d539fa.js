// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//makes visible the form for creating a new book within the book list table
$(function() {
  $('a#show_create_book_form').click(function(e){
    e.preventDefault();
    if( document.getElementById("hidden").style.display=='none' ){
      document.getElementById("hidden").style.display = '';
    }else{
      document.getElementById("hidden").style.display = 'none';
      }
    if($('.hidden-row').is(':hidden')){
      $('.hidden-row div').css('display','none');
      $('.hidden-row').css('display','table-row').find('div').slideDown(1000);
    }
    else{
      $('.hidden-row div').slideUp(1000, function(){$('.hidden-row').hide()});         
    }
    $('div.create_book_form').slideDown();
  });
});

//allows a start date to be chosen with pickadate
function book_start_date() {
  $("#book_start_date").pickadate()
}

//allows a end date to be chosen with pickadate
function book_end_date() {
    $("#book_end_date").pickadate()
}
