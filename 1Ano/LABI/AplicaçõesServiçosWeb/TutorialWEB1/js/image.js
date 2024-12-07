// Function to update photo upon file selection
function updatePhoto(event) {
    var reader = new FileReader();
    reader.onload = function(event) {
        // Create an image
        var img = new Image();
        img.onload = function() {
            // Show the image on the screen
            const canvas = document.getElementById("photo");
            // Using jQuery it is const canvas = $("#photo")[0];
            const ctx = canvas.getContext("2d");
            ctx.drawImage(img, 0, 0, img.width, img.height, 0, 0, 530, 400);
        }
        img.src = event.target.result;
    }
    // Get the file
    reader.readAsDataURL(event.target.files[0]);
    // Sending file
    sendFile(event.target.files[0]);
    // Free image resources (considering `picURL` is defined somewhere else)
    windowURL.revokeObjectURL(picURL);
}

// Function to send file data to the server
function sendFile(file) {
    var data = new FormData();
    data.append("myFile", file);
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "/upload");
    xhr.upload.addEventListener("progress", function(evt) {
        // Call updateProgress function passing xhr object
        updateProgress(xhr);
    }, false);
    xhr.send(data);
}

// Function to update progress
function updateProgress(xhr) {
    // When progress event is fired
    if (xhr.loaded == xhr.total) {
        // Alert when upload is completed
        alert("Upload completed!");
    }
}

