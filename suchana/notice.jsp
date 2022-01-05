<html>
<head>
<script type="text/javascript">
	
	var count = 0;
	var oldmessage = ""; 

	function ajaxFunction() {
		var xmlhttp;
		if (window.XMLHttpRequest){
 			 // code for IE7+, Firefox, Chrome, Opera, Safari
  			  xmlhttp=new XMLHttpRequest();
  		}
		else if (window.ActiveXObject){
  			// code for IE6, IE5
 			 xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		}
		else{
  			alert("Your browser does not support XMLHTTP!");
  		}

		xmlhttp.onreadystatechange=function(){

			if(xmlhttp.readyState==4){

				var obj = JSON.parse( xmlhttp.responseText );		
				var synth = window.speechSynthesis;

				var message = "";
				var forvoice = "";
				if( obj.notice.length > 0 ){

					var message = "<marquee width=\"50%\" direction=\"up\" height=\"180px\">"
					for(var i = 0; i < obj.notice.length; i++) {
						message += "<H1>"+ obj.notice[i].message+"</H1> </br> "
						forvoice += "   "+ obj.notice[i].message ;
					}			
					message += "\n</marquee>";

				}			
				var toSpeak = new SpeechSynthesisUtterance( forvoice );
				var voices = synth.getVoices();
				toSpeak.voice = voices[7];
				synth.speak( toSpeak );
				document.getElementById("screen").innerHTML = message;
				//document.getElementById("screen").innerHTML= obj.message;
  			}
		}

		xmlhttp.open("GET","./notice",true);
		xmlhttp.send(null);
		setTimeout("ajaxFunction()", 10000); 
	}

</script>
</head>
<body onload="ajaxFunction();">
<form name="display">
	<%
	try{
	%>
			<div align = 'center' >
				<H1> <div align = "center" id='screen'> </div> </H1>
			</div>
		
	<%

	}catch(Exception e){
		e.printStackTrace();
	}
	%>	
</form>
</center>
</body>
</html>
