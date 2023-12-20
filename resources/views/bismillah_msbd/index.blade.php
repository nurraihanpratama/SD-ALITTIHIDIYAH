<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="logosch.png">
  <title>SD AL-ITTIHADIYAH</title>
  <link rel="stylesheet" href="assets/css/utama.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>

    @include('bismillah_msbd.components.navbar_utama')

  <div class="background-image">
    <img src="assets/images/bg_index.png" alt="header image">
  </div>
  <div class="container">

    <div class="berita-top" id="news">
      <div class="berita-title">
        <h1>Berita</h1>
      </div>
      <div class="beritalist" id="beritalist">

        <div class="berita-container">
          <div class="berita-box" id="berita1">
            <img src="assets/images/ppdb_new.jpg" alt="**">
            <h1>PPDB SD AL-ITTIHADIYAH segera dibuka!</h1>
            <p>Jangan kelewatan<br>Simak alur pendaftarannya disini</p>
            <a href="/b1" class="btn berita2-btn">Selengkapnya</a>
          </div>
        </div>

        <div class="berita-container">
          <div class="berita-box" id="berita2">
            <img src="assets/images/prestasi_cvr.jpg" alt="**">
            <h1>Raih prestasi, Siswa/i SD AL-ITTIHADIYAH banggakan sekolah</h1>
            <p>Beberapa murid berhasil lolos<br> ke babak berikutnya dalam<br> perlombaan KSN tingkat kecamatan...</p>
            <a href="/b2" class="btn berita2-btn">Selengkapnya</a>
          </div>
        </div>

        <div class="berita-container">
          <div class="berita-box" id="berita3">
            <img src="assets/images/dokumentasi.jpg" alt="**">
            <h1>Dokumentasi Sekolah dirilis,  Kini bisa lihat Galeri Sekolah</h1>
            <p>Berikut merupakan beberapa <br> guru dan murid teladan...</p>
            <a href="/b3" class="btn berita2-btn">Selengkapnya</a>
          </div>
        </div>

      </div>
    </div>

    <a class="gotopbtn" href="#"><i class="fa-solid fa-angle-up"></i></a>

    @include('bismillah_msbd.components.footer')

  </div>

</body>
</html>
