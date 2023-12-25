import LogoImg from "@/../../resources/assets/images/logosch.png";
import NavLink from "@/Components/NavLink";
import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import { Link } from "@inertiajs/react";
import Footer from "./Section/Footer";

export default function HomepageLayout({ children }) {
    return (
        <div>
            <nav className=" fixed p-4 top-0 left-0 w-full bg-white flex justify-between items-center z-[999] drop-shadow-lg">
                <div className="flex items-center">
                    <img
                        src={LogoImg}
                        alt="Logo"
                        width={100}
                        class="max-w-[100px]"
                    />
                    <div class="font-extrabold text-[#005f5f] m-0">
                        <h1 className="text-2xl">SD AL-ITTIHADIYAH</h1>
                        <p className="text-sm">Taqwa, Cerdas, Berkarakter</p>
                    </div>
                </div>
                <div className="flex gap-6 items-center text-xl ">
                    <ul className="flex gap-4">
                        <li>
                            <Link className="" href="#visi">
                                Beranda
                            </Link>
                        </li>
                        <li>
                            <a href="#visi">Berita</a>
                        </li>
                        <li>
                            <a href="#visi">Fasilitas</a>
                        </li>
                        <li>
                            <a href={route("login")}>Direktori</a>
                        </li>
                    </ul>
                    <PrimaryButton href={route("login")}>Login</PrimaryButton>
                </div>
            </nav>
            <main>{children}</main>
            <footer>
                <Footer />
            </footer>
        </div>
    );
}
