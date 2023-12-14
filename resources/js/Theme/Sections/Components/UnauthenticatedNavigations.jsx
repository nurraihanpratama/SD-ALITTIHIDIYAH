import { Fragment } from "react";
import { FiCodesandbox } from "react-icons/fi";
import { usePage } from "@inertiajs/react";
import NavLinkUnauthenticated from "@/Theme/Components/NavLink/NavLinkUnauthenticated";

export default function UnauthenticatedNavigations() {
    return (
        <Fragment>
            {/* dashboard */}
            <NavLinkUnauthenticated
                navRoute={route("dashboard")}
                components={["dashboard"]}
                label="Dashboard"
                icon={<FiCodesandbox />}
            />
        </Fragment>
    );
}
