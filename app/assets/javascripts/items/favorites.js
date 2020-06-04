$(function (){
  $(document).on("click", ".show-main__contents__item-box__optional-area__like-btn-empty", function(){
    var item_id = $(".show-main__contents__item-box__optional-area__report-btn").data("item-id");
    $.ajax({
      type: 'POST',
      url: "/items/create_favorite",
      data: {id: item_id},
      dataType: 'html'
      })
      .done(function(data){
      })
      .fail(function(){
        alert('error');
      })
    var favorites = $(".show-main__contents__item-box__optional-area__like-btn-empty").data("num-favorites")
    $(".show-main__contents__item-box__optional-area__like-btn-empty").remove();
    $(".show-main__contents__item-box__optional-area__report-btn").before(
      `<div class="show-main__contents__item-box__optional-area__like-btn-fill" data-num-favorites="${favorites + 1}">
        <i class="fa fa-star">
        </i> お気に入り ${favorites + 1}
       </div>`);
  });

  $(document).on("click", ".show-main__contents__item-box__optional-area__like-btn-fill", function(){
    var item_id = $(".show-main__contents__item-box__optional-area__report-btn").data("item-id");
    $.ajax({
      type: 'POST',
      url: "/items/destroy_favorite",
      data: {id: item_id},
      dataType: 'html'
      })
      .done(function(data){
      })
      .fail(function(){
        alert('error');
      })
    var favorites = $(".show-main__contents__item-box__optional-area__like-btn-fill").data("num-favorites")
    $(".show-main__contents__item-box__optional-area__like-btn-fill").remove();
    $(".show-main__contents__item-box__optional-area__report-btn").before(
      `<div class="show-main__contents__item-box__optional-area__like-btn-empty" data-num-favorites="${favorites - 1}">
        <i class="fa fa-star">
        </i> お気に入り ${favorites - 1}
       </div>`);
  });
});