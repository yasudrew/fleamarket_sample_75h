$(function(){
  var dataBox = new DataTransfer();
  var file_field = document.querySelector("input[type=file]")
  $('#img-file').change(function(){
    var files = $('input[type="file"]').prop('files')[0];
    $.each(this.files, function(i, file){
      var fileReader = new FileReader();
      dataBox.items.add(file)
      file_field.files = dataBox.files
      var num = $('.item-image').length + 1 + i
      fileReader.readAsDataURL(file);
     //画像が10枚になったら超えたらドロップボックスを削除する
      if (num == 5){
        $('#exhibition__first__image').css('display', 'none')
      }
      fileReader.onloadend = function() {
        var src = fileReader.result
        var html= `<div class='item-image' data-image="${file.name}">
                    <div class=' item-image__content'>
                      <div class='item-image__content--icon'>
                        <img src=${src} width="114" height="80" >
                      </div>
                    </div>
                    <div class='item-image__operetion'>
                      <div class='item-image__operetion--delete'>削除</div>
                    </div>
                   </div>`
        $('#exhibition__first__image').before(html);
      };
      $('#exhibition__first__image').attr('class', `item-num-${num}`)
    });
  });
//削除ボタンをクリックすると発火するイベント
$(document).on("click", '.item-image__operetion--delete', function(){
  //削除を押されたプレビュー要素を取得
  var target_image = $(this).parent().parent()
  //削除を押されたプレビューimageのfile名を取得
  var target_name = $(target_image).data('image')
  //プレビューがひとつだけの場合、file_fieldをクリア
  if(file_field.files.length==1){
    //inputタグに入ったファイルを削除
    $('input[type=file]').val(null)
    dataBox.clearData();
    console.log(dataBox)
  }else{
    //プレビューが複数の場合
    $.each(file_field.files, function(i,input){
      //削除を押された要素と一致した時、index番号に基づいてdataBoxに格納された要素を削除する
      if(input.name==target_name){
        dataBox.items.remove(i) 
      }
    })
    $('#exhibition__first__image').css('display', 'block')
    //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に再度代入
    file_field.files = dataBox.files
  }
  //プレビューを削除
  target_image.remove()
  //inputタグに入ったファイルを削除
  file_field.val("")
  var num = $('.item-image').length
  $('#exhibition__first__image').show()
  $('#exhibition__first__image').attr('class', `item-num-${num}`)
})
});