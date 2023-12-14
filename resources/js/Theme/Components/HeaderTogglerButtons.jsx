import Notification from "./Notification";
import FullscreenToggler from "./FullscreenToggler";
import ThemeToggler from "./ThemeToggler";

export default function HeaderTogglerButtons({ className }) {
    return (
        <div
            className={`flex-center px-4 py-0 gap-2 rounded-full border-2 border-gray-500 ${className}`}
        >
            <ThemeToggler />
            {/* <FluidToggler /> */}
        </div>
    );
}
