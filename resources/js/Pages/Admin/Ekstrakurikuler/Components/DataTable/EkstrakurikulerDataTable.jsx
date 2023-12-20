// EkstrakurikulerDataTable.php
import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import { BiPlus } from "react-icons/bi";
import EkstrakurikulerAction from "./EkstrakurikulerAction"; 

export default function EkstrakurikulerDataTable({
    collection,
    loadOptions,
    withNewButton = false,
    onClickNew,
}) {
    const EkstrakurikulerColumns = [
        {
            header: " ",
            field: "__actions",
            sortable: false,
            searchable: false,
            bodyAlignment: "center",
            render: (row) => <EkstrakurikulerAction row={row} loadOptions={loadOptions} />, 
        },
        {
            header: "Nama Ekstrakurikuler",
            field: "nama_ekstrakurikuler",
        },
        {
            header: "Pembina",
            field: "pembina_ekskul",
        },
        {
            header: "Ikon",
            field: "ikon",
        },
    ];

    return (
        <DataTable
            collection={collection}
            columns={EkstrakurikulerColumns}
            ActionsButton={<ActionsButton onClickNew={onClickNew} />}
            withSearch
            withPagination
            resetRouteRedirect={route("admin.ekstrakurikuler.index")}
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
