// PrestasiDataTable.php
import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import { BiPlus } from "react-icons/bi";
import PrestasiAction from "./PrestasiAction"; 

export default function PrestasiDataTable({
    collection,
    loadOptions,
    withNewButton = false,
    onClickNew,
}) {
    const PrestasiColumns = [
        {
            header: " ",
            field: "__actions",
            sortable: false,
            searchable: false,
            bodyAlignment: "center",
            render: (row) => <PrestasiAction row={row} loadOptions={loadOptions} />, 
        },
        {
            header: "Nama Prestasi",
            field: "nama_prestasi",
        },
        {
            header: "Deskripsi",
            field: "ket_Deskripsi",
        },
    ];

    return (
        <DataTable
            collection={collection}
            columns={PrestasiColumns}
            ActionsButton={<ActionsButton onClickNew={onClickNew} />}
            withSearch
            withPagination
            resetRouteRedirect={route("admin.prestasi.index")}
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
