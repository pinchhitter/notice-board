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
	</style>

	<script type="text/javascript">

		function printDate(){
			var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
			var today  = new Date();
			document.getElementById("date").innerHTML="["+ today.toLocaleDateString("hi-IN", options)+" | "+today.toLocaleDateString("en-US", options)+"]";
		}

		function QuoteOfTheDay(  quoteId ) {

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
					if( obj.Update == "Successful"){		    	
					  document.getElementById("response").innerHTML = "<span style=\"color:GREEN\">Quote of The day updated</span>";
					  list_quote();
					}							 
					else{		    
					   document.getElementById("response").innerHTML = "<span style=\"color:RED\">Quote of the Day update Failed</span>";
					}
				}
			}
			xmlhttp.open("GET","./quoteOfTheDay?quoteid="+quoteId, true);
			xmlhttp.send(null);
		}


		function list_quote() {

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

					if( obj.quotes != null ){
						var table = "<table class=\"table table-striped\"> <tr> <th> # </th> <th> Quote </th> <th> Author </th> <th> Created By </th> <th> </th> </tr>\n"		      	
						for(var i = 0; i < obj.quotes.length; i++) {
						    var quote = obj.quotes[i];
						    if( quote.QOD == "f")	
						    	table += "<tr> <td style='width: 2%'>"+(i+1)+"</td><td style='width: 55%'> "+quote.quote+" </td> <td>"+quote.author+"</td> <td>"+quote.createdBy+"</td> <td> <input type=\"button\" value=\"Make Quote OF the Day\" onclick=\"QuoteOfTheDay('"+quote.quoteid+"');\"> </td> </tr>\n";
						    else	
						    	table += "<tr> <td style='width: 2%'>"+(i+1)+"</td><td style='width: 55%'> "+quote.quote+" </td> <td>"+quote.author+"</td> <td>"+quote.createdBy+"</td> <td> <span style=\"color:GREEN\">  Quote of The Day </span> </td> </tr>\n";
						}
						table += "\n</table>" 
						document.getElementById("quotelist").innerHTML= table;
		  			}else{
						document.getElementById("quotelist").innerHTML= "";
				        }	
				printDate();							      
				}
			}
			xmlhttp.open("GET","./quotelist", true);
			xmlhttp.send(null);
		}

		function save_quote() {

			var xmlhttp;
			var elements = document.getElementsByClassName("formVal");
    			var formData = new FormData(); 
			var data = "";

			var quote = document.getElementById('quote').value;
			var author = document.getElementById('author').value;

			if( quote == "" || quote == null){
				document.getElementById('selecterror').innerText = "Please enter the quote";
				return false;
			}	

			if( author == "" || author == null){
				document.getElementById('selecterror').innerText = "Please enter the Author / Details";
				return false;
			}	

			document.getElementById('selecterror').innerText = "";

    			for(var i=0; i<elements.length; i++){

				if( i == 0)						    
					data = elements[i].name + "=" + elements[i].value;			    
				else			    
					data += "&"+ elements[i].name + "=" + elements[i].value;			    

        			formData.append( elements[i].name, elements[i].value );
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
				      if( obj.Create == "Successful"){		    	
					  document.getElementById("response").innerHTML = "<span style=\"color:GREEN\"> Adding Quote: "+ obj.Create+" </span>";
					  list_quote();
				      }else{		    
					   document.getElementById("response").innerHTML = "<span style=\"color:RED\"> Adding Quote: "+ obj.Create+" </span>";
				      }
				}
			}
			xmlhttp.open("GET","./createQuote?"+data, true);
			xmlhttp.send( null );
		}
	</script>
</head>

<body onload="list_quote();" >

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
		<div style="float:right; margin: 2px 10px 0 0px;">
                        <a href="./logout"> <cite title="Source Title"> Logout </cite> </a>
                </div>
                <div style="float:right; margin: 2px 10px 0 0px;">
                        <a href="./notice.jsp"> <cite title="Source Title"> View Notice </cite> </a> &nbsp;&nbsp; |
                </div>
                <div style="float:right; margin: 2px 10px 0 0px;">
                        <a href="./index.jsp"> <cite title="Source Title"> Create Notice </cite> </a> &nbsp;&nbsp; |
                </div>
	</div>	
	</br> </br> <hr> </br>

	<form method="POST" >
		<table class="table ">	
			<thead class="table-dark">
				<tr>
						<th colspan = "3" > Quote </th>
				</tr>
			</thead>
			 <tbody>	
				<tr>
					<td colspan = "3" >
						<textarea class="form-control formVal" name="quote" id="quote" rows="5" cols="80"></textarea>
					</td>
				</tr>
				<tr>
					<th colspan = "1"> Author / Details Of the Quote: </th>
					<th colspan = "2"> <input class="form-control formVal"  name="author" id="author">   </th>
				</tr>
				<tt>
					<th colspan = "3">
						<input type="submit" value="Add Quote" onClick= "save_quote();return false;" >
						<p class="text-left text-danger" id="selecterror"> </p> 
					</th>
				</tr>
			</tbody>
		</table>
	</form>
	<br> 
	<div id="response"> </div>	
	<div id="quotelist"> </div>	
	<div class="gradient_bottom">
		<div class="copyright"> <p style="color:#2C3E50 " >Copyright &#169; 2022 C-DAC, Mumbai</p> </div>
	</div>

</div>
<style>

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
</body>
</html>
