

 $(document).ready(function(){
 	selectorSizes();
 	numberActions();
});


function selectorSizes() {
	$("#width_tmp").html($('.selector select option:selected, .selector_fixed2 select option:selected').text());
    $(".selector, .selector_fixed2").css("width", $("#width_tmp").outerWidth()+33+6+5);

    $('.selector select, .selector_fixed2 select').change(function(){
    	$("#width_tmp").html($('.selector select option:selected, .selector_fixed2 select option:selected').text());
    	$(".selector, .selector_fixed2").css("width", $("#width_tmp").outerWidth()+33+6+5);
 	});
}

function numberActions() {
	$('.plus').click(function(){
	var temp = parseInt($(this).siblings(":text").val());
	if ( $(this).parent().hasClass("above_zero") ){
			if ( temp < 20 ){
				$(this).siblings(":text").val((temp+1).toString());
			}
		}
		else{
			if ( (new Date).getFullYear()+10 > temp){
				$(this).siblings(":text").val((temp+1).toString());
			}
		}
 	});
 	
 	$('.minus').click(function(){
		var temp = parseInt($(this).siblings(":text").val());
		if ( $(this).parent().hasClass("above_zero") ){
			if ( temp > 1 ){
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


