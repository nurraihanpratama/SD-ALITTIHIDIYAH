import HomepageLayout from "./Layout/HomepageLayout";

export default function Index(props) {
    return (
        <HomepageLayout>
            <div class="background-image">
                <img src="assets/images/bg_index.png" alt="header image" />
            </div>
            <div className="py-8">
                <div className="m-10 text-center text-3xl font-extrabold text-primary ">
                    <h1>Berita</h1>
                </div>

                <div className=" px-20 w-1/3">
                    <div
                        className="bg-[#8cd4AB] flex flex-col justify-between p-6 h-full rounded-lg drop-shadow-lg"
                        id="berita1"
                    >
                        <img src="assets/images/ppdb_new.jpg" alt="**" />
                        <h1>PPDB SD AL-ITTIHADIYAH segera dibuka!</h1>
                        {/* <p>Jangan kelewatan<br>Simak alur pendaftarannya disini</p> */}
                        {/* <a href="/b1" class="btn berita2-btn">Selengkapnya</a> */}
                    </div>
                </div>
            </div>
        </HomepageLayout>
    );
}
