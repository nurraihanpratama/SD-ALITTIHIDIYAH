import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import TemplateTtl from "@/Theme/Components/DataTable/Cell/TemplateTtl";
import CellTemplateNilai from "@/Theme/Components/DataTable/Cell/CellTemplateNilai";

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
            field: "nama_mapel",
            // render: (row) => <p>Bahasa Indonesia</p>,
        },
        {
            header: "Ulangan Harian 1",
            field: "jenis_nilai",
            bodyAlignment: "center",
            render: (row) => <CellTemplateNilai row={row} jenis={"uh1"} />,
        },
        {
            header: "Ulangan Harian 2",
            field: "jenis_nilai",
            bodyAlignment: "center",
            render: (row) => <CellTemplateNilai row={row} jenis={"uh2"} />,
        },
        {
            header: "Ulangan Harian 3",
            field: "jenis_nilai",
            bodyAlignment: "center",
            render: (row) => <CellTemplateNilai row={row} jenis={"uh3"} />,
        },
        {
            header: "Ujian Tengah Semester",
            field: "jenis_nilai",
            bodyAlignment: "center",
            render: (row) => <CellTemplateNilai row={row} jenis={"uts"} />,
        },
        {
            header: "Ujian Akhir Semester",
            field: "jenis_nilai",
            bodyAlignment: "center",
            render: (row) => <CellTemplateNilai row={row} jenis={"uas"} />,
        },
        {
            header: "Rata - Rata Nilai",
            field: "status_siswa",
        },
    ];

    function getNilaiRata() {
        return collection.data?.reduce((n, row) => {
            return n + parseInt(row.nilais?.nilai);
        }, 0);
    }
    console.log(collection.data);
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
