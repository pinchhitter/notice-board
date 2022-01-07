<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="Essential JS 2 TypeScript Components" />
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

		function doDelete( noticeId ) {

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
					  document.getElementById("response").innerHTML = "<span style=\"color:GREEN\">Notice Deleted: "+ obj.Create+" </span>";
					  list_notice();
					}							 
					else		    
					   document.getElementById("response").innerHTML = "<span style=\"color:RED\">Notice Deleted: "+ obj.Create+" </span>";
				}
			}

			xmlhttp.open("GET","./deleteNotice?noticeId="+noticeId, true);
			xmlhttp.send(null);
		}


		function list_notice() {

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

					if( obj.notice != null ){
						var table = "<table class=\"table table-striped\"> <tr> <th> # </th> <th> Notice </th> <th> Start-Date </th> <th> End-Date</th> <th> </th> </tr>\n"		      	
						for(var i = 0; i < obj.notice.length; i++) {
						    var notice = obj.notice[i];
						    table += "<tr> <td>"+(i+1)+"</td><td> "+notice.notice+" </td> <td>"+notice.start_date+"</td> <td>"+notice.end_date+"</td> <td> <input type=\"button\" value=\"Delete\" onclick=\"doDelete('"+notice.noticeid+"');\"> </td> </tr>\n";
						}
						table += "\n</table>" 

						document.getElementById("noticelist").innerHTML= table;
																							  			}else{
						document.getElementById("noticelist").innerHTML= "";
																							  			}
																							  		      	if( obj.centers != null ){ 	
				        	var option = '<option value="-1">Select Center</option>';  
               			        	for (var i = 0; i < obj.centers.length; i++) {  
                   					option += '<option value="' + obj.centers[i].centerId + '">' + obj.centers[i].centerName +'</option>';  
               			        	}  
					  }else{
				        	var option = '<option value="ALL">All</option>';  
					  }
				       	  document.getElementById("center").innerHTML = option;
				}
			}

			xmlhttp.open("GET","./noticelist", true);
			xmlhttp.send(null);
		}


		/*
		$(document).ready(function () {

			$('#CreateNotice').click( function( event ) {

				event.preventDefault();
				var form = $('#create')[0];								      
				var data = new FormData(form);
				alert( data );				      
				$("#CreateNotice").prop("disabled", true);	
				$.ajax({
            				type: "POST",
            				enctype: 'multipart/form-data',
            				url: "./create",
            				data: data,
            				processData: false,
            				contentType: false,
            				cache: false,
            				timeout: 800000,
            				success: function ( data ) {
 
               					$("#response").text(data);
                				console.log("SUCCESS : ", data);
               	 				$("#CreateNotice").prop("disabled", false);

						list_notice();
 
            				},
            				error: function (e) {

                				$("#response").text( e.responseText );
                				console.log("ERROR : ", e);
                				$("#CreateNotice").prop("disabled", false);
 
            				}
        			});

			});
		});
		*/
		
		function save_notice() {

			var xmlhttp;
			var elements = document.getElementsByClassName("formVal");
    			var formData = new FormData(); 
			var data = "";

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
					  document.getElementById("response").innerHTML = "<span style=\"color:GREEN\"> Adding Notice: "+ obj.Create+" </span>";
					  list_notice();
				      }else{		    
					   document.getElementById("response").innerHTML = "<span style=\"color:RED\"> Adding Notice: "+ obj.Create+" </span>";
				      }
				}
			}
			xmlhttp.open("GET","./create?"+data, true);
			xmlhttp.send( null );
		}
	</script>
</head>

<body onload="list_notice();" >

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
                        <a href="./logout"> <cite title="Source Title"> Logout </cite> </a>
                </div>
                <div style="float:right; margin: 2px 10px 0 0px;">
                        <a href="./notice.jsp"> <cite title="Source Title"> notice </cite> </a>
                </div>
	</div>	

	<br>

	<form method="POST" >
		<table class="table table-striped">	
			<thead>
				<tr>
					<th> Notice </th>
					<th> Start Date-Time </th>
					<th> End Date-Time  </th>
					<th> Center  </th>
				</tr>
			 </thead>		
			 <tbody>	
				<tr>
					<td> <input class="formVal"  name = "notice" type="text"/> </td>
					<td> <input class="formVal" type="datetime-local" id="startdatetime" name="startdatetime"> </td>
					<td> <input class="formVal" type="datetime-local" id="enddatetime" name="enddatetime"> </td>
					<td> 
						<select class="formVal" name="center" id="center"> 
						</select>	
					</td>	
				</tr>
				<tr>
					<td colspan="4" align='left'>  <input type="submit" value="Create Notice" onClick= "save_notice();return false;" > </td> 
				</tr>
			</tbody>
		</table>
		<br>
		<div id="response"> </div>	
		<div id="noticelist"> </div>	
	</form>
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
