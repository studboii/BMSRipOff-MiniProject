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
  		.error{ color: white; font-size: 16px; align-content: left; }
  		.wrapper{ width:350px; padding: 20px }
  	</style>
  	<link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css">
  <link rel="stylesheet" type="text/css" href="l.css">
  <link rel="stylesheet" type="text/css" href="Hover-master/css/hover.css">
  <link rel="stylesheet" type="text/css" href="CSS Animations/animate.css">
  	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>


  	
  	<!-- <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <link rel="stylesheet" type="text/css" href="l.css">
  	<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script> -->
  	<!-- Move the styling to an external CSS later on ALSO ADD SESSION FOR FUTURE SCREENS -->
</head>

<body >
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
	    if(empty($_POST["uid"]))
	    {
	        $uiderr="* Please enter a valid User ID";
	        $boo = false;
	    }
	    else
	    {
	    	$uid=chngIP($_POST["uid"]);
	    }//UID
	    if(empty($_POST["pass"]))
	    {
	        $pswderr="* Please enter a Password";
	        $boo = false;
	    }
	    else
	    {
	    	$pswd=chngIP($_POST["pass"]);
	    }//password
	    if($boo)
	    {
	    	$qry = $sql = "SELECT `pass`, `Name` FROM `login` WHERE uid LIKE '".$uid."'";
	    	echo $qry."<br>";
	    	$res = $conn->query($qry);
	    	if ($res->num_rows > 0)
		    {
		    	$row = $res->fetch_assoc();
		    	$dbPass = $row["pass"];
		    	echo $dbPass."<br>";
		    	//echo password_hash($pswd, PASSWORD_BCRYPT)."<br>";
		    	// $someval = password_verify($pswd, $dbPass);
		    	// echo $someval."<br>";
		    	if(password_verify($pswd, $dbPass))
		    	{
		    		$_SESSION["user"] = $uid;
		    		$_SESSION["username"] = $row["Name"];
		    		header("Location: http://localhost:8080/DBMS/ViewMovie.php");
		    	}
		    	else
		    	{
		    		$btmerr = "Incorrect User or Pass. Access Declined";
		    		$boo =false;
		    	}
		    }
		    else
		    {
		    	$btmerr = "User or pass is incorrect.";
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
        <h1 style="color: white" class="fadeInDownBig animated">Sign in</h1></center><br>
        <div class="d-flex justify-content-center">
	        <div class="whi">

		        <form name="HenloFrens" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method = "post" >
		        	<div class="row"></div>
			        
			        	<div class="form-group">
			        		<!-- <label>User ID</label> -->
						<input class="form-control" type="text" name="uid" placeholder="User ID" size="50">
						
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
			       <a href="http://localhost:8080/DBMS/register.php" class="btn btn-info hvr-float">Click here to sign up</div></a>
			       <!-- <a class="butt" href="http://localhost:8080/DBMS/register.php">Click Here to Sign up</a> -->
			   </form>

	 		</div>
	 	</div>
 <!-- php ends there hopefully -->
</body>
</html>