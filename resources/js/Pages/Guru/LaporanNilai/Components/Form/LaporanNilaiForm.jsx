import DataTable from "@/Theme/Components/DataTable/DataTable";
import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import FormTextInput from "@/Theme/Form/FormTextInput";
import { useForm } from "@inertiajs/react";
import TableInputNilai from "./Section/TableInputNilai";

export default function LaporanNilaiForm({ collection, closeForm }) {
    const form = useForm({
        nisn: "",
        jenis_nilai: "",
        id_mapel: "",
        id_guru: "",
    });
    console.log(collection);
    return (
        <StandardFormModalTemplate
            title={"Form Input Nilai"}
            closeForm={closeForm}
        >
            <TableInputNilai
                collection={collection}
                form={form}
                columns={inputColumns}
            />
        </StandardFormModalTemplate>
    );
}

const inputColumns = [
    {
        header: "Nama Siswa",
        field: "nama_siswa",
    },
    {
        header: "Ulangan Harian 1",
        render: (row, form) => (
            <FormTextInput
                value={form.data.jenis_nilai}
                ismobile
                onChange={(val) => form.setData("jenis_nilai", val)}
            />
        ),
    },
    {
        header: "Ulangan Harian 2",
    },
    {
        header: "Ulangan Harian 3",
    },
    {
        header: "Ulangan Tengah Semester",
    },
    {
        header: "Ulangan Akhir Semester",
    },
];
