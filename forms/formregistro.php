 <?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "test1";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
//if ($conn->query($sql) === TRUE) {
//    echo "New record created successfully";
//    mail($_POST["correo"],"Bienvenido a trabi", "Muchas gracias por registrarse a trabi", "From: admin@trabi,com");
//} else {
//    echo "Error: " . $sql . "<br>" . $conn->error;
//}

echo "Connected successfully";

$conn->close();
?>
