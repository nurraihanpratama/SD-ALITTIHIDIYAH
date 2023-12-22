import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import { BiPlus } from "react-icons/bi";
import PegawaiAction from "./PegawaiAction";

export default function PegawaiDataTable({
    collection,
    loadOptions,
    withNewButton = false,
    onClickNew,
}) {
    const PegawaiColumns = [
        {
            header: " ",
            field: "__actions",
            sortable: false,
            searchable: false,
            bodyAlignment: "center",
            render: (row) => (
                <PegawaiAction row={row} loadOptions={loadOptions} />
            ),
        },
        {
            header: "Nama Pegawai",
            field: "nama_pegawai",
        },
        {
            header: "Jenis Kelamin",
            field: "jk_pegawai",
            render: (row) =>
                row.jk_pegawai === "L" ? "Laki-Laki" : "Perempuan",
        },
        {
            header: "Keterangan",
            field: "ket_pegawai",
        },
        {
            header: "Status",
            field: "status_pegawai",
        },
    ];

    return (
        <DataTable
            collection={collection}
            columns={PegawaiColumns}
            ActionsButton={<ActionsButton onClickNew={onClickNew} />}
            withSearch
            withPagination
            resetRouteRedirect={route("admin.pegawai.index")}
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
