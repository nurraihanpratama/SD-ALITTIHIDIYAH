import ThemeContext from "@/Context/ThemeContext";
import { Fragment, useContext } from "react";
import { FaListUl } from "react-icons/fa6";
import { FiMenu } from "react-icons/fi";
import { LuLayoutList } from "react-icons/lu";

export default function SidebarToggler() {
    const { theme, updateTheme } = useContext(ThemeContext);
    const onClick = () => {
        updateTheme({
            ...theme,
            sidebarOpen: !theme.sidebarOpen,
        });
    };

    const toggleSidebarShow = () => {
        updateTheme({
            ...theme,
            sidebarShow: !theme.sidebarShow,
        });
    };

    return (
        <Fragment>
            <div className="hidden lg:flex">
                {theme.sidebarOpen ? (
                    <button
                        type="button"
                        onClick={() => onClick()}
                        className="text-gray-700 dark:text-white"
                    >
                        <FaListUl size={20} />
                    </button>
                ) : (
                    <button
                        type="button"
                        onClick={() => onClick()}
                        className="text-gray-700 dark:text-white"
                    >
                        <LuLayoutList size={20} />
                    </button>
                )}
            </div>
            <div className="lg:hidden">
                <button
                    type="button"
                    onClick={() => toggleSidebarShow()}
                    className="text-gray-700 dark:text-white"
                >
                    <FiMenu size={20} />
                </button>
            </div>
        </Fragment>
    );
}
