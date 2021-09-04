$(function () {
    $('.round').click(function (e) {
        e.preventDefault();
        e.stopPropagation();
        $('.arrow').toggleClass('bounceAlpha');
    });

    // tabPane商品列表的popup
    $('.cdListItem').bind({
        mouseenter: function () {
            $(this).children('.CdDetailPopup').addClass('myShow');
            $('.accordion-button').css('z-index', 1);
        },
        mouseleave: function () {
            $(this).children('.CdDetailPopup').removeClass('myShow');
        }
    });

    // 到貨狀況商品列表的popup
    $('.deliverCheckListItem').bind({
        mouseenter: function () {
            $(this).children('.RemarkPopup').addClass('myShow');
        },
        mouseleave: function () {
            $(this).children('.RemarkPopup').removeClass('myShow');
        }
    });
})