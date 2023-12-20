import DataTable from "@/Theme/Components/DataTable/DataTable";
import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import FormTextInput from "@/Theme/Form/FormTextInput";
import { useForm } from "@inertiajs/react";

export default function LaporanNilaiForm({ collection, closeForm }) {
    const form = useForm({
        nisn: "",
        jenis_nilai: "",
        id_mapel: "",
        id_guru: "",
    });
    return (
        <StandardFormModalTemplate
            title={"Form Input Nilai"}
            closeForm={closeForm}
        >
            <DataTable collection={collection} columns={TableInputColumns} />
        </StandardFormModalTemplate>
    );
}

const TableInputColumns = [
    {
        header: "Nama Siswa",
        sortable: false,
        searchable: false,
        render: (row) => row.nama_siswa,
    },
    {
        header: "UH1",
        sortable: false,
        searchable: false,
        render: () => <FormTextInput isMobile={true} />,
    },
    {
        header: "UH2",
        sortable: false,
        searchable: false,
        render: () => <FormTextInput isMobile={true} />,
    },
    {
        header: "UH3",
        sortable: false,
        searchable: false,
        render: () => <FormTextInput isMobile={true} />,
    },
    {
        header: "UTS",
        sortable: false,
        searchable: false,
        render: () => <FormTextInput isMobile={true} />,
    },
    {
        header: "UAS",
        sortable: false,
        searchable: false,
        render: () => <FormTextInput isMobile={true} />,
    },
];
