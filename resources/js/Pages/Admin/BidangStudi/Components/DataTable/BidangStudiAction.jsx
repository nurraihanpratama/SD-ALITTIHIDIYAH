import MenuDropdown from "@/Components/MenuDropdown";
import { Fragment, useState } from "react";
import { Menu } from "@headlessui/react";
import MenuItemButtonDropdown from "@/Components/MenuItemButtonDropdown";
import { FaEdit } from "react-icons/fa";
import Modal from "@/Theme/Components/Modal";
import BidangStudiForm from "../Form/BidangStudiForm";
export default function BidangStudiAction({ row, loadOptions }) {
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
                <BidangStudiForm
                    action="update"
                    row={row}
                    closeForm={() => setVisible(false)}
                    loadOptions={loadOptions}
                />
            </Modal>
        </Fragment>
    );
}
