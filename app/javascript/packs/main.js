import $ from 'jquery'
import 'select2'

// DOMが構築されたら実行される。$(function(){〜});と同じ。
// DOMの構成を変える場合はこちら
$(document).ready(() => {
  $('.enable-select2').select2({
    dropdownAutoWidth: true,
    width: '40%'
  })
});

// 使用される画像やスタイルなどを含め、ページが完全に読み込まれたら実行される
// ブラウザに表示されている画像を操作したい場合などはこちら
$(window).on('load', () => {
  $("input[type=file]").change((e) => {
    $('#image_prev').removeClass('d-none');
    $('#image_present').remove();
    const files = e.currentTarget.files;
    if (files && files[0]) {
      const reader = new FileReader();
      reader.onload = (element) => {
        $('#image_prev').attr('src', element.target.result);
      }
      reader.readAsDataURL(files[0]);
    }
  });
});
