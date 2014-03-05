$(function(){
	$("#new_video").fileupload({
		dataType: "script",
		add: function(event, data){
       		var types = /(\.|\/)(ogg|ogv|3gp|mp4|m4v|webm|mov)$/i;
	    	var file = data.files[0];
	    	if (data.files[0].size < 5242880 && (types.test(file.type) || types.test(file.name))) {
				data.submit();
			} else {
	          $('#video-upload').modal('show');
	          $('#dropzone').show();
	          return $('.video-upload-info').html('').append("<b><red>Upload Failed</red></b><br><b>Filename:</b> " + data.files[0].name + " <br><b>Size:</b> " + (data.files[0].size / 1000000).toFixed(2) + " MB <br><br><b>File Exceeds the 5MB file size limit or is not a valid video format</b>");
	        }
		},
		send: function(e, data) {
	        $("#video-upload").modal('show');
	        $("#dropzone").fadeIn();
	        return $.each(data.files, function(index, file) {
				var loadingImage = "<img src='/assets/spinner.gif' class='mini_load'/>";
	          	return $('.video-upload-info').append(loadingImage + "<b>Transcoding</b> " + file.name + " <b>Size:</b> " + (file.size / 1000000).toFixed(2) + ' MB');
	        });
	    },
		fail: function(e, data) {
	        console.log("Uploading failed");
			return $("#dropzone").html("").append("<b>Upload failed, please try again <i class='icon-remove-sign red'></i><br></b>").fadeIn();
	    },
	});
});