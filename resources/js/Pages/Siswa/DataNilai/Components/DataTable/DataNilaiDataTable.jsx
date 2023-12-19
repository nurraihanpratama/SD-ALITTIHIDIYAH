import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import TemplateTtl from "@/Theme/Components/DataTable/Cell/TemplateTtl";

export default function DataNilaiDataTable({
    collection,
    loadOptions,
    withNewButton = false,
    onClickNew,
}) {
    const DataNilaiColumns = [
        {
            header: " ",
            field: "__actions",
            sortable: false,
            searchable: false,
            bodyAlignment: "center",
        },
        {
            header: "Mata Pelajaran",
            field: "nisn",
        },
        {
            header: "Ulangan Harian 1",
            field: "nipd",
        },
        {
            header: "Ulangan Harian 2",
            field: "nama_siswa",
        },
        {
            header: "Ulangan Harian 3",
            field: "agama_siswa",
        },
        {
            header: "Ujin Tengan Semester",
            field: "id_kelas",
        },
        {
            header: "Ujian Akhir Semester",
            field: "tanggal_lahir",
        },
        {
            header: "Rata - Rata Nilai",
            field: "status_siswa",
        },
    ];

    return (
        <DataTable
            collection={collection}
            columns={DataNilaiColumns}
            // withSearch
            withPagination
            resetRouteRedirect={route("siswa.data-nilai.index")}
        />
    );
}
