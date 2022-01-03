$('.big_tab li').first().addClass("activeClass");
$(".best").not(':first').hide();

$('.big_tab li').on('click',function(){
    $(this).addClass("activeClass").siblings().removeClass("activeClass");
    var link = $(this).find("a").attr("href");
    var link_num = link.substr(link.length-1);
    $("select#tabmenu option").eq(link_num-1).prop("selected", "selected");
    $(".best").hide();
    $(link).show();
});

$("select#tabmenu").on("change",function(){
    var select_link = $("select#tabmenu").val();
    var select_num = $(this).prop('selectedIndex');
    $('.big_tab li').eq(select_num).addClass("activeClass").siblings().removeClass('activeClass');
    $(".best").hide();
    $(select_link).show();
    console.log(select_link);
});

/* tab2 */