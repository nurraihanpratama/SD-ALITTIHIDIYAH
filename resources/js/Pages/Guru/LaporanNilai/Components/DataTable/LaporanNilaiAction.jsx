import MenuDropdown from "@/Components/MenuDropdown";
import MenuItemButtonDropdown from "@/Components/MenuItemButtonDropdown";
import Modal from "@/Theme/Components/Modal";
import { Menu } from "@headlessui/react";
import { Fragment, useState } from "react";
import LaporanNilaiForm from "../Form/LaporanNilaiForm";
import { FaEdit } from "react-icons/fa";

export default function LaporanNilaiAction({ row, loadOptions }) {
    const [visible, setVisible] = useState(false);
    return (
        <Fragment>
            <MenuDropdown>
                <Menu.Item>
                    {({ active }) => (
                        <MenuItemButtonDropdown
                            icon={<FaEdit size={20} />}
                            label="Input Data Nilai"
                            onClick={() => setVisible(true)}
                        />
                    )}
                </Menu.Item>
            </MenuDropdown>
            {/* Modal */}
            <Modal visible={visible} setVisible={setVisible} noescape>
                <LaporanNilaiForm
                    action="update"
                    row={row}
                    closeForm={() => setVisible(false)}
                    loadOptions={loadOptions}
                />
            </Modal>
        </Fragment>
    );
}
