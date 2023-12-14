import ThemeContext from "@/Context/ThemeContext";
// import { permissions } from "@/Helpers/authorization";
import { Link, usePage } from "@inertiajs/react";
import { useContext } from "react";

export default function NavLinkUnauthenticated({
    navRoute,
    components,
    label,
    method = "get",
    icon,
    ...props
}) {
    const { current_route } = usePage().props.app;

    const { theme, updateTheme } = useContext(ThemeContext);

    const isActive = components.includes(current_route);

    return (
        <Link
            method={method}
            href={navRoute}
            className={`relative flex-start gap-0 font-semibold text-gray-700 dark:text-white 
      ${isActive ? "text-white" : "hover:text-primary dark:hover:text-primary"}
      `}
            {...props}
        >
            <div
                className={`p-2 rounded-full z-50 ${
                    isActive ? "shadow-md bg-primary" : "text-xl"
                }`}
                title={label}
            >
                {icon}
                {/* <FiCodesandbox size={isActive ? 15 : 20} /> */}
            </div>
            {theme.sidebarOpen ? (
                <p
                    className={`absolute z-10 ml-4 px-4 rounded-full ${
                        isActive && "shadow-md bg-primary"
                    }`}
                >
                    &nbsp;&nbsp;
                    {label}
                </p>
            ) : (
                <p>&nbsp;</p>
            )}
        </Link>
    );
}
