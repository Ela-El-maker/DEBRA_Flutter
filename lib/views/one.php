<?php

require 'connect.php';

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

$response = array(
    'success' => 0,
    'message' => 'Invalid request'
);

if(isset($_GET['username'], $_GET['password'])) {
    $username = $_GET['username'];
    $password = $_GET['password'];

    if(!empty($username) && !empty($password)) {
        
        $encryptedPassword = md5($password);

        
        $query = "SELECT * FROM Users WHERE username = '$username' AND password = '$encryptedPassword' LIMIT 1";
        $result = mysqli_query($conn, $query);

        if($result) {
            if(mysqli_num_rows($result) == 1) {
                $response['success'] = 1;
                $response['message'] = 'Login successful';

                $response['userdata'] = array();

                while($row = mysqli_fetch_assoc($result)) {
                    $response['userdata'][] = $row;
                }
            } else {
                $response['message'] = 'Invalid username or password';
            }
            mysqli_free_result($result);
        } else {
            $response['message'] = 'Query Naexecution failed';
        }
    } else {
        $response['message'] = 'Username and password are required';
    }
}

header('Content-Type: application/json');

echo json_encode($response);

// Close database connection
mysqli_close($conn);
?>
