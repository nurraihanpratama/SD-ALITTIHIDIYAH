import SelectionModalLayout from "@/Theme/Components/SelectionModalLayout";
import { Fragment, useState } from "react";
import KelasSelectionTable from "./Section/KelasSelectionTable";
import { LuSchool } from "react-icons/lu";

export default function KelasSelection({
    action,
    title,
    form,
    kelas,
    setKelas,
}) {
    const [visible, setVisible] = useState(false);

    const onSelectRow = (row) => {
        if (form.data.kelas_id == row.id_kelas)
            return alert("Item ini sudah dipilih, silahkan pilih item lainnya");

        form.setData("kelas_id", row.id_kelas);

        setKelas(row);
        setVisible(false);
    };

    return (
        <SelectionModalLayout
            form={form}
            title={title}
            icon={<LuSchool />}
            selectedItemView={<KelasSelected kelas={kelas} />}
            selectionAjaxTable={
                <KelasSelectionTable
                    onRowSelect={onSelectRow}
                    fetchRoute={"admin.jadwal-pelajaran.datatable"}
                />
            }
            visible={visible}
            setVisible={setVisible}
            withSelectionModal={action != "show"}
        />
    );
}

const KelasSelected = ({ kelas }) => {
    return (
        <Fragment>
            <div className="w-full overflow-auto text-gray-700 dark:text-white">
                <table className="w-full">
                    <tbody>
                        <Template
                            label="Tingkat Kelas"
                            value={kelas?.tingkat_kelas}
                        />
                        <Template label="Nama Kelas" value={kelas?.nama} />
                        <Template
                            label="Tahun Ajaran"
                            value={kelas?.tahun_ajaran_id}
                        />
                        <Template
                            label="Wali Kelas"
                            value={kelas?.wali_kelas}
                        />
                        {/* <Template label="Status" value={device?.dev_status} /> */}
                    </tbody>
                </table>
            </div>
        </Fragment>
    );
};

const Template = ({ label, value }) => {
    return (
        <tr>
            <td className="px-4 text-left">{label}</td>
            <td className="w-2">:</td>
            <td className="px-4 text-left">{value}</td>
        </tr>
    );
};
