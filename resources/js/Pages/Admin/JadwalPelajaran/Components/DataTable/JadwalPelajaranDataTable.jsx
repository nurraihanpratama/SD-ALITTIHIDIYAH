import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import { BiPlus } from "react-icons/bi";
import JadwalPelajaranAction from "./JadwalPelajaranAction";

export default function JadwalPelajaranDataTable({
    collection,
    withNewButton = false,
    onClickNew,
}) {
    const JadwalPelajaranColumns = [
        {
            header: " ",
            field: "__actions",
            sortable: false,
            searchable: false,
            bodyAlignment: "center",
            render: (row) => <JadwalPelajaranAction row={row} />,
        },
        {
            header: "Kelas",
            searchable: false,
            sortable: false,
            field: "kelas",
            render: (row) => row.kelas.nama,
        },
        {
            header: "Mapel Guru",
            searchable: false,
            sortable: false,
            field: "mapel_guru",
            // render: (row) => console.log(row),
        },
        {
            header: "Hari",
            searchable: false,
            field: "hari",
        },
        {
            header: "Waktu Mulai",
            field: "waktu_mulai",
        },
        {
            header: "Waktu Selesai",
            field: "waktu_akhir",
        },
        {
            header: "Semerter",
            field: "semester_aktif",
        },

        {
            header: "Tahun Ajaran",
            field: "tahun_ajaran_aktif",
        },
    ];

    return (
        <DataTable
            collection={collection}
            columns={JadwalPelajaranColumns}
            ActionsButton={<ActionsButton onClickNew={onClickNew} />}
            withSearch
            withPagination
            resetRouteRedirect={route("admin.kelas.index")}
        />
    );
}

const ActionsButton = ({ onClickNew }) => {
    return (
        <Fragment>
            <PrimaryButton onClick={() => onClickNew(true)}>
                <BiPlus />
                New
            </PrimaryButton>
        </Fragment>
    );
};
