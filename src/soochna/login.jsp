<!DOCTYPE html>

<html lang="en">

<!DOCTYPE html>

<html lang="en">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="Essential JS 2 TypeScript Components" />
	<link rel="shortcut icon" href="./images/cdac-tiny.png" type="image/x-icon" />
	<meta name="author" content="shekhar" />

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

	#container {
		max-width: 660px;
	margin: 0 auto;
	}
	.e-input-group .e-input-group-icon,
		.e-input-group.e-control-wrapper .e-input-group-icon,
		.e-input-group.e-control-wrapper:not(.e-disabled) .e-input-group-icon:hover {
	background: none;
		}

	.e-input-group:not(.e-disabled) .e-input-group-icon:active,
		.e-input-group.e-control-wrapper:not(.e-disabled) .e-input-group-icon:active {
	background: rgb(0, 120, 214);
	}

	</style>

	<script type="text/javascript">

		function printDate(){
			var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
			var today  = new Date();
			document.getElementById("date").innerHTML = "["+ today.toLocaleDateString("hi-IN", options)+" | "+today.toLocaleDateString("en-US", options)+"]";
		}

		function doLogin( ) {

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

				if( xmlhttp.readyState == 4 ){
					var obj = JSON.parse( xmlhttp.responseText );		
					if( obj.Create == "Successful"){		    	
					     list_notice();
					}							 
				}
			}

			xmlhttp.open("GET","./login", true);
			xmlhttp.send(null);
		}
	</script>
</head>

<body onload="printDate()">

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
					<p class="display-6">Soochna </p>
				</blockquote>
				<figcaption class="blockquote-footer">
					<cite title="Source Title">  from cdacmumbai  </cite>
				</figcaption>
			</figure>
		</div>
		<div style="float:left; margin: 2px 10px 0 0px;">
			<blockquote class="blockquote">
				<p class="display-19 .bg-gradient-warning" id="date"> </p> 
			</blockquote>
		</div>	
	</div>	
	<br>
	<form method="POST">
		<table class="table table-striped"> 
			<tr> 
				<th> Username </th>
				<th> <input type="text" name="uname" id="uname" class="uname"></th>
			</tr>
			<tr> 
				<th> Password </th>
				<th> <input type="password" name="pword" id="pword" class = "pword"> </td>
			</tr>
			<tr> 
				<td colspan = "2">  <input type="Submit" value="Log in" > </td>
			</tr>
		</table>	

	</form>	

	<div class="gradient_bottom">
		<div class="copyright"> <p style="color:#2C3E50 " >Copyright &#169; 2022 C-DAC, Mumbai</p> </div>
	</div>
</div>

</body>
</html>
