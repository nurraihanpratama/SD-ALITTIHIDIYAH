import ThemeContext from "@/Context/ThemeContext";
import { useContext } from "react";

export default function SidebarOverlay() {
    const { theme, updateTheme } = useContext(ThemeContext);

    const closeOverlay = () => {
        updateTheme({
            ...theme,
            sidebarShow: false,
        });
    };

    if (theme.sidebarShow)
        return (
            <div
                onClick={() => closeOverlay()}
                className="lg:hidden absolute z-[5] top-0 left-0 w-full h-full bg-black/60"
            ></div>
        );
}
