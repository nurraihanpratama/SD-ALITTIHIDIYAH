import ApplicationLogo from "@/Components/ApplicationLogo";
import LogoSekolah from "@/Components/LogoSekolah";
import { Link } from "@inertiajs/react";

export default function Guest({ children }) {
    return (
        <div
            className="min-h-screen flex flex-col sm:justify-center items-center pt-6 sm:pt-0 bg-gray-100 dark:bg-[#0A1727]"
            // style={{
            //     backgroundImage: `url('/images/bg.png')`,
            //     backgroundPosition: "bottom",
            //     backgroundSize: "contain",
            //     backgroundRepeat: "no-repeat",
            // }}
        >
            <div>
                <Link href="/">
                    {/* <ApplicationLogo className="w-20 h-20 text-gray-500 fill-current" /> */}
                    <LogoSekolah />
                </Link>
            </div>

            <div className="w-full sm:max-w-md mt-6 px-6 py-4 bg-white dark:bg-[#091019]  shadow-md overflow-hidden sm:rounded-lg">
                {children}
            </div>
        </div>
    );
}
