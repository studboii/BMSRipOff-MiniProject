<?php
session_start();
?>

<!DOCTYPE html>
<html>
<head>
	<title>Login Page</title>
	<meta charset="utf-8">
  	<meta name="viewport" content="width= device-width, initial-scale=1">
  	<style type="text/css">
  		.error{ color: red; font-size: 16px }
  	</style>
  	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css">
  <link rel="stylesheet" type="text/css" href="l1.css">
  <link rel="stylesheet" type="text/css" href="Hover-master/css/hover.css">
  <link rel="stylesheet" type="text/css" href="CSS Animations/animate.css">
  	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
  	<!-- Move the styling to an external CSS later on ALSO ADD SESSION FOR FUTURE SCREENS -->
</head>

<body>
	<?php
	$servername = "127.0.0.1";
	$username = "root";
	$db = "bmsripoff";
	$password = "";
	//Move config outside and integrate later
	// Create connection
	$conn = new mysqli($servername, $username, $password,$db);//creating a connection object

	// Check connection
	if ($conn->connect_error) {
	    die("Connection failed: " . $conn->connect_error);
	}
	//echo "Connected successfully <br>";
	$uiderr=$pswderr=$btmerr=$uid=$pswd="";
	$boo = true;

	if ($_SERVER["REQUEST_METHOD"] == "POST") 
	{
	    if(empty($_POST["adminid"]))
	    {
	        $uiderr="Please enter a valid User ID";
	        $boo = false;
	    }
	    else
	    {
	    	$uid=chngIP($_POST["adminid"]);
	    }//UID

	    if(empty($_POST["pass"]))
	    {
	        $pswderr="Please enter a Password";
	        $boo = false;
	    }
	    else
	    {
	    	$pswd=chngIP($_POST["pass"]);
	    }//password

	    if($boo)
	    {
	    	$qry = $sql = "SELECT `pass` FROM `Admin_log` WHERE `Admin` LIKE '".$uid."'";
	    	echo $qry."<br>";
	    	$res = $conn->query($qry);
	    	if ($res->num_rows > 0)
		    {
		    	$row = $res->fetch_assoc();
		    	$dbPass = $row["pass"];
		    	echo $dbPass."<br>";
		    	//echo password_hash($pswd, PASSWORD_BCRYPT)."<br>";
		    	//$someval = password_verify($pswd, $dbPass);
		    	// echo $someval."<br>";
		    	if(password_verify($pswd, $dbPass))
		    	{
		    		$_SESSION["adm"] = $uid;
		    		header("Location: http://localhost:8080/DBMS/AddMovie.php");
		    	}

		    	else
		    	{//adminid
		    		$btmerr = "Incorrect User or Pass. Access Declined";
		    		$boo =false;
		    	}
		    }
		    else
		    {
		    	$btmerr = "User or pass is incorrect. Outer else triggered";
		    	$boo = false;
		    }

	    }
	}

	function chngIP($data)
        {
            $data = trim($data);
            $data = stripslashes($data);
            $data = htmlspecialchars($data);
            return $data;

        }//Refer Register.php for documentation same modify input and delete any space stuff
        ?>
        <div class="container">
        <center>
        <h1 style="color: white" class="fadeInDownBig animated">Admin Login</h1></center><br>
        <div class="d-flex justify-content-center">
        	<div class="whi">
        <form name="HenloFrens" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method = "post" >
	        <div class="row"></div>
			        
			        	<div class="form-group">
			        		<!-- <label>User ID</label> -->
						<input class="form-control" type="text" name="adminid" placeholder="Admin ID" size="50">
						
						<div class="error"> <?php echo $uiderr;?> </div>
						</div>
						<br>
						<div class="form-group">
							<!-- <label>Password: </label> -->
			           <input class="form-control" type="password" placeholder="Enter Password"  name="pass">
			            <div class="error"> <?php echo $pswderr;?> </div> 	
			         </div>
			         <div class="error"> <?php echo $btmerr;?> </div>	
			       <br>
			        <center><button class="btn btn-primary hvr-grow" type="submit">Sign in</button></center>
			       <br>
	   </form>
 </div></div></div>
 <!-- php ends there hopefully -->
</body>
</html>