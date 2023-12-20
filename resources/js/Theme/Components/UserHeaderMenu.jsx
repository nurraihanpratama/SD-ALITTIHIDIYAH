import Dropdown from "@/Components/Dropdown";
import { FaUserCircle } from "react-icons/fa";
import HeaderTogglerButtons from "@/Theme/Components/HeaderTogglerButtons";
import NavLinkDropdown from "./NavLink/NavLinkDropdown";

export default function UserHeaderMenu({ user }) {
    return (
        <NavLinkDropdown trigger={<Trigger user={user} />}>
            {/* Content */}
            <div className="p-4 md:hidden">
                <HeaderTogglerButtons className="flex md:hidden" />
            </div>
            {/* TODO NANTI DIBENARIN */}
            <div className="px-4 text-gray-700 dark:text-gray-800">
                <p>{user.nama}</p>
                <p className="text-xs">{user.email}</p>
            </div>
            {/* <Dropdown.Link href={route("profile.edit")}>Profile</Dropdown.Link> */}
            <Dropdown.Link href={route("logout")} method="post" as="button">
                Log Out
            </Dropdown.Link>
        </NavLinkDropdown>
    );
}

const Trigger = ({ user }) => {
    return (
        <span className="inline-flex rounded-md">
            <button
                type="button"
                className="inline-flex items-center px-3 py-2 text-sm font-medium leading-4 text-gray-700 transition duration-150 ease-in-out border border-transparent rounded-md dark:text-white hover:text-gray-700 focus:outline-none"
            >
                <p className="mr-2 capitalize">{user.user_name}</p>
                <FaUserCircle size={22} />
                <svg
                    className="ml-2 -mr-0.5 h-4 w-4"
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                >
                    <path
                        fillRule="evenodd"
                        d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                        clipRule="evenodd"
                    />
                </svg>
            </button>
        </span>
    );
};
