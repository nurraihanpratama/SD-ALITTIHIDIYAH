import MenuDropdown from "@/Components/MenuDropdown";
import { Fragment, useState } from "react";
import { Menu } from "@headlessui/react";
import MenuItemButtonDropdown from "@/Components/MenuItemButtonDropdown";
import { FaEdit } from "react-icons/fa";
import Modal from "@/Theme/Components/Modal";
import KelasForm from "../Form/KelasForm";
export default function KelasAction({ row }) {
    const [visible, setVisible] = useState(false);
    return (
        <Fragment>
            <MenuDropdown>
                <Menu.Item>
                    {({ active }) => (
                        <MenuItemButtonDropdown
                            icon={<FaEdit size={20} />}
                            label="Update Data"
                            onClick={() => setVisible(true)}
                        />
                    )}
                </Menu.Item>
            </MenuDropdown>
            <Modal visible={visible} setVisible={setVisible} noescape>
                <KelasForm
                    action="update"
                    row={row}
                    closeForm={() => setVisible(false)}
                />
            </Modal>
        </Fragment>
    );
}