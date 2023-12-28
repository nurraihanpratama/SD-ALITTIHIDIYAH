import MenuDropdown from "@/Components/MenuDropdown";
import MenuItemButtonDropdown from "@/Components/MenuItemButtonDropdown";
import Modal from "@/Theme/Components/Modal";
import { Menu } from "@headlessui/react";
import { Fragment, useEffect, useState } from "react";
import LaporanNilaiForm from "../Form/LaporanNilaiForm";
import { FaEdit } from "react-icons/fa";
import SingleSendNilaiForm from "../Form/SingleSendNilaiForm";
import { fetchErrorCatch } from "@/Helpers/helper";

export default function LaporanNilaiAction({ row }) {
    const [visible, setVisible] = useState(false);
    const [processing, setProcessing] = useState(false);

    const [loadOptions, setLoadOptions] = useState([]);

    function loadData() {
        setProcessing(true);

        const url = route("guru.laporan-nilai.create");

        axios
            .get(url)
            .then((response) => {
                setLoadOptions(response.data);
                setProcessing(false);
            })
            .catch((error) => console.log(error));
    }

    useEffect(() => {
        loadData();
    }, []);

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
                <SingleSendNilaiForm
                    action="update"
                    nilai={row}
                    closeForm={() => setVisible(false)}
                    loadOptions={loadOptions}
                />
            </Modal>
        </Fragment>
    );
}
