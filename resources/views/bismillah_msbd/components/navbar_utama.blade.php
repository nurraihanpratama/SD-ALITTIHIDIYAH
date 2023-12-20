<link rel="stylesheet" href="./assets/css/navbar.css">

   <div class="top-header">
    <topheader header class="top-header">
        <img src="{{ asset('assets/images/home/logosch.png') }}" alt="Logo" class="logo">
        <div class="header-text">
            <h1>SD AL-ITTIHADIYAH</h1>
            <p>Taqwa, Cerdas, Berkarakter</p>
        </div>
        <div class="header-text">
        <ul style="align-items: right;">
            <li><a href="/home">Beranda</a></li>
            <li><a href="/facilitate">Fasilitas</a></li>
            <li><a href="/directory">Direktori</a></li>
            <li><a href="{{ route('login') }}" class="btn">Masuk</a></li>
            </ul>
        </div>
    </topheader>

   </div>
