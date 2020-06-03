$(function () {
  $('.item-image__operetion--delete-existing-image').on('click', function () {
    //削除を押されたプレビュー要素を取得
  var target_image = $(this).parent().parent()
  // 削除を押されたプレビューimageのfile名を取得
  var target_name = $(target_image).data('image')

  $.each(gon.existing_images, function(index,picture){
    // console.log(picture.id)
    //削除を押された要素と一致した時、index番号に基づいてdataBoxに格納された要素を削除する
    if(picture.image.url==target_name){
      $.ajax({
      type: 'GET',
      url: "/items/destroy_existing_image",
      data: picture,
      dataType: 'html'
      })
      .done(function(data){
      })
      .fail(function(){
        alert('error');
      })
      return
    
    };
  });
  $('#exhibition__first__image').css('display', 'block')

  target_image.remove()

  var num = $('.item-image').length
  $('#exhibition__first__image').show()
  $('#exhibition__first__image').attr('class', `item-num-${num}`)
  })
});