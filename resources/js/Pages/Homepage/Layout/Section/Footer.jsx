export default function Footer() {
    return (
        <footer>
            <div className="bg-[#282432] text-white">
                <div className="px-24 flex gap-8">
                    <div className="flex flex-col justify-center text-orange-200">
                        <h1>Contact Us</h1>
                        <p>
                            Alamat: Jl. Mesjid No.21, Laut Dendang, Kec. Percut
                            Sei Tuan, Kabupaten Deli Serdang, Sumatera Utara
                            20371
                        </p>
                        <p>
                            Telp: <span>061-7381031</span>
                            Email:<span> alittihadiyahsds@yahoo.com</span>
                            <span>sdsalittihadiyah2@gmail.com</span>
                        </p>
                    </div>
                    <iframe
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3981.8459885500606!2d98.73326647406927!3d3.6226476500614235!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x303133e33eb7356d%3A0x2b48513a039730c2!2sMTs%20Al%20-%20Ittihadiyah%20Laut%20Dendang!5e0!3m2!1sid!2sid!4v1703068661256!5m2!1sid!2sid"
                        width="500"
                        height="350"
                        // style="border:0;"
                        // allowfullscreen=""
                        loading="lazy"
                        referrerpolicy="no-referrer-when-downgrade"
                    />
                </div>
                <p className="text-center py-4 text-orange-200">
                    &copy; SD AL-ITTIHADIYAH, 2023
                </p>
            </div>
        </footer>
    );
}
