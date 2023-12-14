import ThemeContext from "@/Context/ThemeContext";
import { Head } from "@inertiajs/react";
import { Toaster } from "react-hot-toast";
import Header from "./Sections/Header";
import Sidebar from "./Sections/Sidebar";
import { useState } from "react";
import FullscreenToggler from "./Components/FullscreenToggler";

export default function ThemeLayout({ title, children }) {
    const appDomain = import.meta.env.VITE_APP_NAME || "laravel";

    const currentTheme = JSON.parse(localStorage.getItem(appDomain)) || {
        darkMode: false,
        fluidMode: true,
        sidebarOpen: true,
        sidebarShow: false, // this one for small screen
        fullscreen: false,
    };

    const [theme, setTheme] = useState(currentTheme);

    const updateTheme = (newValue) => {
        const newTheme = {
            ...theme,
            ...newValue,
        };
        setTheme(newTheme);
        localStorage.setItem(appDomain, JSON.stringify(newTheme));
    };

    return (
        <ThemeContext.Provider value={{ theme, updateTheme }}>
            <Head title={title} />
            <Toaster />
            {currentTheme.fullscreen && <FullscreenToggler />}

            <div className="min-h-screen flex-center bg-[#EDF2F9] dark:bg-[#0A1727]">
                <div
                    className={`relative min-h-screen flex flex-col w-full ${
                        !theme.fluidMode
                            ? "md:w-full lg:w-3/4 xl:px-0"
                            : !theme.fullscreen
                            ? "lg:px-4"
                            : "lg:px-0"
                    }`}
                >
                    {!theme.fullscreen && <Header />}

                    {/* For mobile sidebar overlaying when open */}
                    {/* <SidebarOverlay /> */}

                    {/* body */}
                    <div className="flex flex-grow gap-1 overflow-auto">
                        {!theme.fullscreen && <Sidebar />}
                        <div
                            className={`w-full h-full p-4 space-y-4 ${
                                theme.sidebarOpen
                                    ? "lg:ml-60"
                                    : theme.fullscreen
                                    ? "ml-0"
                                    : "ml-8"
                            }`}
                        >
                            {children}
                        </div>
                    </div>
                </div>
            </div>
        </ThemeContext.Provider>
    );
}
