<!DOCTYPE html>

<html lang="en">
<head>
	<meta charset="utf-8" />
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script type="text/javascript">

	$(document).ready( function() {

	    // Browser support messages. (You might need Chrome 33.0 Beta)
	    if (!('speechSynthesis' in window)) {
	      alert("You don't have speechSynthesis");
	    }

	    $("#test").on('click', function(){

		var msg = new SpeechSynthesisUtterance();
		var voices = window.speechSynthesis.getVoices();
		msg.voice = voices[10]; // Note: some voices don't support altering params
		msg.voiceURI = 'native';
		msg.volume = 1; // 0 to 1
		msg.rate = 1; // 0.1 to 10
		msg.pitch = 2; //0 to 2
		msg.text = 'Hello World';
		msg.lang = 'en-US';

		msg.onend = function(e) {
		  console.log('Finished in ' + event.elapsedTime + ' seconds.');
		};

		speechSynthesis.speak(msg);

	    });
	});
	</script>
</head>
<body>
	<a id="test" href="#">click here if 'ready()' didn't work</a>
</body>
</html>

