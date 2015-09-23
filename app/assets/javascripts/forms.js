$(document).ready(function(){
  $(window).load(function(){
     selectorSizes();
     numberActions();
  });
});


function selectorSizes() {
	$("#width_tmp").html($('.selector select option:selected').text());
    $(".selector").css("width", $("#width_tmp").outerWidth()+33+6+5);

    $('.selector select').change(function(){
    	$("#width_tmp").html($('.selector select option:selected').text());
    	$(".selector").css("width", $("#width_tmp").outerWidth()+33+6+5);
 	});
}

function numberActions() {
	$('.plus').click(function(){
	var temp = parseInt($(this).siblings(":text").val());
	$(this).siblings(":text").val((temp+1).toString());
 	});
 	
 	$('.minus').click(function(){
		var temp = parseInt($(this).siblings(":text").val());
		if ( $(this).parent().hasClass("above_zero") ){
			if ( temp > 0 ){
				$(this).siblings(":text").val((temp-1).toString());
			}
		}
		else{
			if ( (new Date).getFullYear() < temp){
				$(this).siblings(":text").val((temp-1).toString());
			}
		}
 	});
}


