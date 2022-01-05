<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta name="description" content="Essential JS 2 TypeScript Components" />
	<meta name="author" content="shekhar" />

	<script type="text/javascript">

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
					var table = "<table border = \"1px\" ><tr> <td> Notice-Id </td> <td> Notice </td> <td> Start-Date </td> <td> End-Date</td> </tr>\n"
					for(var i = 0; i < obj.notice.length; i++) {
    						var notice = obj.notice[i];
						table += "<tr> <td>"+notice.noticeid+"</td><td> "+notice.notice+" </td> <td>"+notice.start_date+"</td> <td>"+notice.end_date+"</td> </tr>\n";
					}
					table += "\n</table>"
					//document.getElementById("noticelist").innerHTML= obj.notice;
					document.getElementById("noticelist").innerHTML= table;
				}
			}

			xmlhttp.open("GET","./noticelist", true);
			xmlhttp.send(null);
		}

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
        			formData.append(elements[i].name, elements[i].value);
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
					list_notice();
					var obj = JSON.parse( xmlhttp.responseText );		
					if( obj.Create == "Successful")		    	
						  document.getElementById("response").innerHTML = "<span style=\"color:GREEN\"> Adding Notice: "+ obj.Create+" </span>";
					else		    
						   document.getElementById("response").innerHTML = "<span style=\"color:RED\"> Adding Notice: "+ obj.Create+" </span>";

				}
			}
			xmlhttp.open("GET","./create?"+data, true);
			xmlhttp.send( null );
		}
	</script>

</head>

<body onload="list_notice();" >

<div id="container" align = 'centre' >

	<div id="noticelist"> 
	</div>	

	<form method="post" class="create">

		<table border = "1px">	
		<tr>
			<td> Notice </td>
			<td> Start Date-Time </td>
			<td> End Date-Time  </td>
		</tr>
		<tr>
			<td> <input class="formVal"  name = "notice" type="text"/> </td>
			<td> <input class="formVal" type="datetime-local" id="startdatetime" name="startdatetime"> </td>
			<td> <input class="formVal" type="datetime-local" id="enddatetime" name="enddatetime"> </td>
		</tr>

		<tr>
			<td colspan="3">  <input type="submit" value="save" onClick= "save_notice();return false;" > </td>
		</tr>
		</table>

		<div id="response"> </div>	
	</form>
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
