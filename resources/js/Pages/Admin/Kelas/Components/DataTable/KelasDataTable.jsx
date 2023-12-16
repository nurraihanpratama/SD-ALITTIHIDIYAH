import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import { BiPlus } from "react-icons/bi";
import KelasAction from "./KelasAction"; 

export default function KelasDataTable({
    collection,
    withNewButton = false,
    onClickNew,
}) {
    const KelasColumns = [
        {
            header: " ",
            field: "__actions",
            sortable: false,
            searchable: false,
            bodyAlignment: "center",
            render: (row) => <KelasAction row={row} />, 
        },
        {
            header: "Nama Kelas",
            field: "nama",
        },
        {
            header: "Wali Kelas",
            field: "wali_kelas",
            render: (row) => row.guru.nama_guru,
        },
    ];

    return (
        <DataTable
            collection={collection}
            columns={KelasColumns}
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
