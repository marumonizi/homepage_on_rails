function checkBreakPoint() {
  w = $(window).width();
  if (w <= 600) {
    // スマホ向け（767px以下のとき）
    $('.main-content, .third-content').not('.slick-initialized').slick({
      //スライドさせる
      dots: true,
      centerMode: true,
      centerPadding: '20%',
      slidesToShow: 1
    });
  } else {
    // PC向け
    $('.main-content, .third-content').slick('unslick');
  }
}

// ウインドウがリサイズする度にチェック
$(function(){
  $(window).resize(function(){
  checkBreakPoint();
  });
  // 初回チェック
  checkBreakPoint();
});

$(document).ready(function(){
  $('.product_show-slide').slick({
    dots: true,
    slidesToShow: 1,
    slidesToScroll: 1
  });
});

