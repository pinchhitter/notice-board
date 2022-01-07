<!DOCTYPE html>
<html lang="en">
<head>

	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

	<style>
	.gradient-header {
		margin: 5px 0px 0px 0px;
		padding: 0px;
		position: relative;
		height: 70px;

		background-image: linear-gradient(to left, #d7d2cc 0%, #304352 100%);
	}
	.gradient_bottom {
		height: 70px;
		background-image: linear-gradient(to right, #d7d2cc 0%, #304352 100%);
		border-top: 2px solid #E5E5E5;
		border-bottom: 1px solid #E5E5E5;
		margin: 5px 0px 0px 0px;
		padding: 10px;
		clear: both;
	}
	#header_left {
        	float: left;
        	padding: 4px 4px;
        	height: 60px;
        	width: 540px;
	}
	</style>

	<script type="text/javascript">
	
	var count = 0;
	var oldmessage = ""; 

	function loadCenter(){

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

		xmlhttp.onreadystatechange = function(){

			if( xmlhttp.readyState == 4 ){
				var obj = JSON.parse( xmlhttp.responseText );		
				var option = '<option value="-1">Select Center</option>';  

				for (var i = 0; i < obj.centers.length; i++) {  
					option += '<option value="' + obj.centers[i].centerId + '">' + obj.centers[i].centerName +'</option>';  
				}
							   
			        if( obj.centers == null || obj.centers.length == 0 ){ 
				    option = '<option value="ALL">All</option>';  
				}
				document.getElementById("center").innerHTML = option;
			}
	        }					      
		xmlhttp.open("GET","./center", true);
		xmlhttp.send( null );
        }

	function ajaxFunction() {

		
		var xmlhttp;
	        var elements = document.getElementsByClassName("formVal");
		var data = "";				      

    		for(var i=0; i<elements.length; i++){
			if( i == 0)						    
				data = elements[i].name + "=" + elements[i].value;			    
			else			    
				data += "&"+ elements[i].name + "=" + elements[i].value;			    
    		}

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
						      
				if( obj.notice != null ){
					message = ""
					//message = "<marquee width=\"50%\" direction=\"up\" height=\"180px\">"
					for(var i = 0; i < obj.notice.length; i++) {
						if( i == 0)	      
					        	message += "<H1>"+ obj.notice[i].message+"</H1> </br>"
						else	      
					        	message += "<hr> <H1>"+ obj.notice[i].message+"</H1> </br>"

						forvoice += " "+ obj.notice[i].message ;
					}			

					//message += "\n</marquee>";
							      //
					var toSpeak = new SpeechSynthesisUtterance( forvoice );
					var voices = synth.getVoices();
					toSpeak.voice = voices[7];
					//synth.speak( toSpeak );
					document.getElementById("screen").innerHTML = message;
			      }else{
				      document.getElementById("screen").innerHTML = "<H5> No Notice currently </H5>";
			      }
							    
			      if( obj.birthday != null ){

			      		var birthday = "<H3> C-DAC Mumbai family wishes </H3> <H2>";

					for(var i = 0; i < obj.birthday.length; i++) {
						if( i == 0)		    
						   birthday +=  obj.birthday[i].name+" ("+obj.birthday[i].group+")";
						else									      
						    birthday +=  " <br> "+obj.birthday[i].name+" ("+obj.birthday[i].group+")";
					}			
					birthday += "<H3>A Very Happy Birthday</H3 </br>";
					document.getElementById("birthday").innerHTML = birthday;
				}			
  			}
		}

		xmlhttp.open( "GET", "./notice?"+data, true);
		xmlhttp.send( null );
		setTimeout("ajaxFunction()", 10000); 
	}

	</script>
</head>

<body onload="ajaxFunction(); loadCenter(); ">

<div class="container-lg">
	<div class="gradient-header" align="center">
		<div id="header_left">
			<img src="./images/cdac-logo.png">
		</div>
	</div>
	<div id="header_bottom">
		<div style="float: left; margin: 2px 10px 0 0px;">
			<figure class="text-center">
				<blockquote class="blockquote">
					<p class="display-6">Soochna</p>
				</blockquote>
				<figcaption class="blockquote-footer">
					<cite title="Source Title">  from cdacmumbai</cite>
				</figcaption>
			</figure>
		</div>
		<div style="float:right; margin: 2px 10px 0 0px;">
			Select Center: 
			<select class="formVal" name="center" id="center" onChange="ajaxFunction();"> </select>	
		</div>	
	</div>	

	<div> <br> <br> <hr> <br> <br> </div>

	<div class="text-center" >
		<div class="alert alert-success" role="alert" id="birthday"> </div>		
		<div class="alert alert-danger" role="alert" id="screen"> </div> 
	</div>
	<div> <br> <hr> <br> </div>
	<div class="gradient_bottom">
		<div class="copyright"> <p style="color:#2C3E50 " >Copyright &#169; 2022 C-DAC, Mumbai</p> </div>
	</div>
</div>
</body>
</html>
