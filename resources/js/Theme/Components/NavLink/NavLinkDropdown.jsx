import Dropdown from "@/Components/Dropdown";

export default function NavLinkDropdown({ trigger, children }) {
    return (
        <Dropdown>
            <Dropdown.Trigger>{trigger}</Dropdown.Trigger>
            <Dropdown.Content>{children}</Dropdown.Content>
        </Dropdown>
    );
}
