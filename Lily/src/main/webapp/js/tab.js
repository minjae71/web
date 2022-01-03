$('#votelist li').on('click', function(){
	$(":radio[name='voteName']").change(function(){
		var _tabBox = $('.pay');
		var _voteName = $(this).prop("checked",true).attr("id");
		_tabBox.removeClass('on');
		$('.'+_voteName).addClass('on');
	});
});
$(document).ready(function(){ 
 $(".resultArea > p").last().hide();
 var radioContent = $(".resultArea > p");
 $("input[type='radio']").click(function(){
  radioContent.hide();
  radioContent.eq($("input[type='radio']").index(this)).show();
 });
});

//var tabHeader = document.querySelector('.tabs')
/*
$(function () {
    $('.tab-header > div').on('click', function(){
        var tab = $(this).attr('data-tab');
        $('.tab-header > div').removeClass('active');
        $(this).addClass('active');
        $('.tab-body > div').removeClass('active');
        $('.tab-body > div#' + tab).addClass('active;')
    });
});
 */

/*
const tabs = document.querySelectorAll('.tab-header');
const contents = document.querySelectorAll('.tab-body');

tabs.forEach((tab) => {
    tab.addEventListener('click', () => {

        // To remove active class from previous tab
    tabs.forEach(tab => tab.classList.remove('active'));

        tab.classList.add('active');
    });
});
*/


/*
var tabs = document.querySelector('.tabs'),
    tabHeader = tabs.querySelector('.tab-header'),
    tabBody = tabs.querySelector('.tab-body'),
    //$tabIndicator = tabs.querySelectorAll('.tab-indicator'),
    tabHeaderNodes = tabs.querySelectorAll('.tab-header > div'),
    tabBodyNodes = tabs.querySelectorAll('.tab-body > div');

for (let i = 0; i < tabHeaderNodes.length; i++) {
    tabHeaderNodes[i].addEventListener('click', function(){
        tabHeader.querySelector('.active').classList.remove('active');
        tabHeaderNodes[i].classList.add('active');
        tabBody.querySelector('.active').classList.remove('active');
        tabBodyNodes[i].classList.add('active');

        //$tabIndicator.style.left = 'calc(calc(100% / 4) * ${i})';
    });
}*/
/* .css('left', '100px')

$(document).ready(function(){
	$(".resultArea > .pay").last().hide();	
	var radioContent = $(".resultArea > pay");
	$("input[type='radio']").click(function(){
		radioContent.hide();
		radioContent.eq($("input[type='radio']").index(this)).show();
	});
}); */