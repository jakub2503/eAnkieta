$(document).ready(function(){
  $(window).load(function(){
     selectorSizes();
  });
});


function selectorSizes() {
	$("#width_tmp").html($('select option:selected').text());
    $(".selector").css("width", $("#width_tmp").outerWidth()+33+6+5);

    $('.selector select').change(function(){
    	$("#width_tmp").html($('select option:selected').text());
    	$(".selector").css("width", $("#width_tmp").outerWidth()+33+6+5);
 	});
}

