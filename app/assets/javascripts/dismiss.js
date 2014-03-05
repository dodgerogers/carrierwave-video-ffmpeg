$(function(){
	$("#video-upload").on("click", "#modal-dismiss", function(){
		$(this).closest(".video-upload-info").html("");
	});
});