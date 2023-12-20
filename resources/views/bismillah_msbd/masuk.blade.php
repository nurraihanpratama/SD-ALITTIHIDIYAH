<?php
    //koneksi ke db
    require "includes/functions.php";
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Masuk</title>
    <link rel="stylesheet" type="text/css" href="assets/css/login.css">
    <link href="https://fonts.googleapis.com/css2?family=Jost:wght@500&display=swap" rel="stylesheet">
</head>
<body>
    
<div class="main">

    <div class="login">
        <form>
            <label for="chk" aria-hidden="true">Masuk</label>
            <input type="nim" name="nim" placeholder="NIS">
            <input type="password" name="pswd" placeholder="Password">
            <button> <a href="index.php"></a>Masuk</button>
        </form>
    </div>
</div>

</body>
</html>