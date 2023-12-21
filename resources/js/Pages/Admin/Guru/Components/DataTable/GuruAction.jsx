import MenuDropdown from "@/Components/MenuDropdown";
import { Fragment, useState } from "react";
import { Menu } from "@headlessui/react";
import MenuItemButtonDropdown from "@/Components/MenuItemButtonDropdown";
import { FaEdit } from "react-icons/fa";
import Modal from "@/Theme/Components/Modal";
import GuruForm from "../Form/GuruForm";
import { FaTrash } from "react-icons/fa6";
import { onErrorFeedback } from "@/Helpers/formFeedback";
import toast from "react-hot-toast";

export default function GuruAction({ row, loadOptions }) {
    const [visible, setVisible] = useState(false);

    const submitDelete = async (e) => {
        e.preventDefault();

        if (confirm("Yakin Ingin Menghapus Data Guru " + row.nama_guru)) {
            try {
                const response = await axios.delete(
                    route("admin.guru.delete", row.id_guru),
                    {
                        // additional configurations
                    }
                );

                console.log(response);
                if (response.data.success) {
                    toast.success(response.data.message);
                    window.location.reload();
                    // Handle any additional actions you need on success
                } else {
                    toast.error(response.data.message);
                    // Handle any additional actions you need on failure
                }
            } catch (error) {
                onErrorFeedback;
            }
        }
    };
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
                <Menu.Item>
                    {({ active }) => (
                        <MenuItemButtonDropdown
                            icon={<FaTrash size={20} />}
                            label="Delete Data"
                            deleteAction={true}
                            onClick={submitDelete}
                        />
                    )}
                </Menu.Item>
            </MenuDropdown>
            <Modal visible={visible} setVisible={setVisible} noescape>
                <GuruForm
                    action="update"
                    row={row}
                    closeForm={() => setVisible(false)}
                    loadOptions={loadOptions}
                />
            </Modal>
        </Fragment>
    );
}
