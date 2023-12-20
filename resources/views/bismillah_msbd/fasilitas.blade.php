<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="logosch.png">
    <link rel="stylesheet" href="assets/css/hlm_fasil.css">
    <!-- <link rel="stylesheet" href="assets/css/fasil1.css"> -->
    <title>SD AL-ITTIHADIYAH</title>
</head>
<body>
@include('bismillah_msbd.components.navbar_utama')

<div class="main-header_container">
   <div class="skewed skewed-left">
        <div class="image">
            <div>
            <img src="https://th.bing.com/th/id/R.b6218df7f7cc887080b3fb46eb776ea2?rik=%2fbC5yWh12XzjMA&riu=http%3a%2f%2fsmpn14kotabekasi.sch.id%2fassets%2fimages%2fgallery%2ffasilitas14-5.jpg&ehk=VojIE3JVEa9iaF6%2ffkJkQyDckefQFvHVNMTMooib8S4%3d&risl=&pid=ImgRaw&r=0"
            alt="img" />
            </div>
        </div>
        <div class="text">
            <small>SD AL-ITTIHADIYAH</small>
            <h1>Fasilitas Sekolah</h1>
            <p>
                SD AL-ITTIHADIYAH dilengkapi dengan beberapa fasilitas untuk menunjang efektifitas belajar siswa.
            </p>
             <a href="index.php">Beranda</a>
        </div>
   </div>
</div>

    <div class="card-text">
        <div class="card-text">
            <br><h1>Fasilitas</h1><br>
        </div>
    </div>
    <div class="card-container">
        <div class="card">
            <img src="assets/images/perpus.jpg" alt="Fasilitas 1" class="card-image">
            <div class="card-content">
                <h3>Perpustakaan</h3>
            </div>
        </div>
        <div class="card">
            <img src="assets/images/mushala.jpg" alt="Fasilitas 2" class="card-image">
            <div class="card-content">
                <h3>Mushala</h3>
            </div>
        </div>
        <div class="card">
            <img src="assets/images/kantinsehat.jpg" alt="Fasilitas 3" class="card-image">
            <div class="card-content">
                <h3>Kantin Sehat</h3>
            </div>
        </div>
        <div class="card">
            <img src="assets/images/lapangan.jpg" alt="Fasilitas 4" class="card-image">
            <div class="card-content">
                <h3>Lapangan Sekolah</h3>
            </div>
        </div>
        <div class="card">
            <img src="assets/images/uks.jpg" alt="Fasilitas 5" class="card-image">
            <div class="card-content">
                <h3>UKS</h3>
            </div>
        </div>
        <div class="card">
            <img src="assets/images/drumbband.jpg" alt="Fasilitas 4" class="card-image">
            <div class="card-content">
                <h3>Alat Drumband</h3>
            </div>
        </div>
    </div>

@include('bismillah_msbd.components.footer')

</body>
</html>
