import MenuDropdown from "@/Components/MenuDropdown";
import { Fragment, useState } from "react";
import { Menu } from "@headlessui/react";
import MenuItemButtonDropdown from "@/Components/MenuItemButtonDropdown";
import { FaEdit } from "react-icons/fa";
import Modal from "@/Theme/Components/Modal";
import FasilitasForm from "../Form/FasilitasForm";
import { FaTrash } from "react-icons/fa6";
import toast from "react-hot-toast";
import { onErrorFeedback } from "@/Helpers/formFeedback";

export default function FasilitasAction({ row, loadOptions }) {
    const [visible, setVisible] = useState(false);

    const submitDelete = async (e) => {
        e.preventDefault();

        if (
            confirm(
                "Yakin Ingin Menghapus Data fasilitas " + row.nama_fasilitas
            )
        ) {
            try {
                const response = await axios.delete(
                    route("admin.fasilitas.delete", row.id_fasilitas),
                    {
                        // additional configurations
                    }
                );

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
                            deleteAction
                            onClick={submitDelete}
                        />
                    )}
                </Menu.Item>
            </MenuDropdown>
            <Modal visible={visible} setVisible={setVisible} noescape>
                <FasilitasForm
                    action="update"
                    row={row}
                    closeForm={() => setVisible(false)}
                />
            </Modal>
        </Fragment>
    );
}
