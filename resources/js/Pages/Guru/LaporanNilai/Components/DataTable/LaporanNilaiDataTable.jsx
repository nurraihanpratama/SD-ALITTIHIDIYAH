import PrimaryButton from "@/Components/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import { BiPlus } from "react-icons/bi";
import LaporanNilaiAction from "./LaporanNilaiAction";
import CellTemplateNilai from "@/Theme/Components/DataTable/Cell/CellTemplateNilai";

export default function LaporanNilaiDataTable({
    collection,
    loadOptions,
    withNewButton = false,
    onClickNew,
}) {
    const laporanNilaiColumns = [
        {
            header: " ",
            field: "__actions",
            sortable: false,
            searchable: false,
            bodyAlignment: "center",
            render: (row) => (
                <LaporanNilaiAction row={row} loadOptions={loadOptions} />
            ),
        },
        {
            header: "Nama siswa",
            field: "nama_siswa",
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
    ];

    return (
        <DataTable
            columns={laporanNilaiColumns}
            collection={collection}
            ActionsButton={<ActionsButton onClickNew={onClickNew} />}
            withSearch
            withPagination
            resetRouteRedirect={route("guru.laporan-nilai.index")}
        />
    );
}

const ActionsButton = ({ onClickNew }) => {
    return (
        <Fragment>
            <PrimaryButton onClick={() => onClickNew(true)}>
                <BiPlus />
                Input Nilai
            </PrimaryButton>
        </Fragment>
    );
};
