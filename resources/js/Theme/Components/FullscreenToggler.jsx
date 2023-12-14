import AppContext from "@/Context/AppContext";
import ThemeContext from "@/Context/ThemeContext";
import { useContext } from "react";
import { BsArrowsFullscreen, BsFullscreenExit } from "react-icons/bs";

export default function FullscreenToggler() {
    const { appState, updateState } = useContext(AppContext);
    const { theme, updateTheme } = useContext(ThemeContext);

    const toggleFullscreen = () => {
        // updateState({
        //   ...appState,
        //   fullscreen: !appState.fullscreen,
        // })
        updateTheme({
            ...theme,
            fluidMode: true,
            sidebarOpen: false,
            fullscreen: !theme.fullscreen,
        });
    };

    return (
        <button
            type="button"
            onClick={() => toggleFullscreen()}
            className={`${
                theme.fullscreen
                    ? "absolute right-10 top-7 p-3 px-6 z-[99] flex-end gap-4 bg-black/50"
                    : "text-gray-700 dark:text-white"
            }`}
        >
            {theme.fullscreen && <p className="text-white">Exit Fullscreen</p>}
            {theme.fullscreen ? (
                <BsFullscreenExit className="font-bold text-white" />
            ) : (
                <BsArrowsFullscreen />
            )}
        </button>
    );
}
