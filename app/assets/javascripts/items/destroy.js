$(function () {
  $(".show-main__contents__edit-destroy__destroy-btn").click(function(){
    $("body").append('<div class="show-modal"></div>');
    $(".show-modal").fadeIn();
    $(".show-modal").click(function(){
      $(".show-modal").fadeOut();
    });
  });
});