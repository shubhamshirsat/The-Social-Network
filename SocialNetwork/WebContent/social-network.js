/**
 * 
 */



	
	
	
	function viewUser(userid)														// Called from searchFriend.jsp
	{
			document.getElementById('viewUserId').value = userid;
			document.getElementById('viewUserForm').submit();
	}
	
	
	function sendRequest(requestType, senderID, receiverID)
	{
			document.getElementById("requestType").value = requestType;
			document.getElementById("senderID").value = senderID;
			document.getElementById("receiverID").value = receiverID;
			document.getElementById('sendRequestForm').submit();
	}
	
	
	function processRequest(requestType, senderID, receiverID)
	{	
			document.getElementById("reqType").value = requestType;
			document.getElementById("send").value = senderID;
			document.getElementById("receive").value = receiverID;
			document.getElementById("requestForm").submit();
	}
	
	

	function hitLike(postUserid,postTimestamp,userid)								// Called from newsFeed.jsp
	{
		
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange= function()
			{
				if(xhttp.readyState == 4 && xhttp.status == 200)
				{
					document.getElementById("newsFeed").innerHTML = xhttp.responseText;
				}
			};
			
			xhttp.open("POST", "Activity", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send('activity='+2+'&postUserid='+postUserid+'&postTimestamp='+postTimestamp+'&userid='+userid);
	}	
	
	
	function sendMessage()															// Called From home.jsp
	{
		
			var message = document.getElementById("message").value;
			document.getElementById("message").value = "";
			
			var xhttp = new XMLHttpRequest();
		
			xhttp.onreadystatechange= function()
			{
				if(xhttp.readyState == 4 && xhttp.status == 200)
				{
					document.getElementById("messagePanel").innerHTML = xhttp.responseText;
					
					var div = document.getElementById("messagePanel");			// To get automatically scroll down.....
					div.scrollTop = div.scrollHeight;							
				}
			};
			
			xhttp.open("POST", "Chat", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.send('senderID='+senderID+'&receiverID='+receiverID+'&message='+message+'&activity=sendMessage');
	}
	
	
	
	function showImage(input)													// Called from home.jsp 
	{																		
		
			if (input.files && input.files[0]) 
			{
		        var reader = new FileReader();
		        reader.onload = function (e) 									// Displays selected image to be posted
		        {
		            $('#pic')
		                .attr('src', e.target.result);
		        };
		        reader.readAsDataURL(input.files[0]);
		    }
			
			document.getElementById('imageSection').style="display: block;";
			document.getElementById('imageSection').style="max-width: 100%;";
	}
	
	
	
	function post()
	{
		
			var postForm = document.getElementById('postForm');
			var formData = new FormData(postForm);
			var xhttp = new XMLHttpRequest();
			document.getElementById('imageSection').style="display: none;";
			document.getElementById('post').value = "";
			
			xhttp.onreadystatechange= function()
			{
				if(xhttp.readyState == 4 && xhttp.status == 200)
				{
					document.getElementById("newsFeed").innerHTML = xhttp.responseText;
				}
			};
			
			xhttp.open("POST", "Post", true);
			xhttp.send(formData);
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	