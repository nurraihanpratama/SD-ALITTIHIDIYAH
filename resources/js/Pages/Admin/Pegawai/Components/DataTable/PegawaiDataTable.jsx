
import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import { BiPlus } from "react-icons/bi";
import PegawaiAction from "./PegawaiAction"; 

export default function PegawaiDataTable({
    collection,
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
            render: (row) => <PegawaiAction row={row} />, 
        },
        {
            header: "Nama Pegawai",
            field: "nama_pegawai",
        },
        {
            header: "Jenis Kelamin",
            field: "jns_kelamin",
            render: (row) => (row.jns_kelamin === 'L') ? 'Laki-Laki' : 'Perempuan',
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
