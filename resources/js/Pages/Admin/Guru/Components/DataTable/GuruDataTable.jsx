import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import { BiPlus } from "react-icons/bi";
import GuruAction from "./GuruAction"; 

export default function GuruDataTable({
    collection,
    loadOptions,
    withNewButton = false,
    onClickNew,
}) {
    const GuruColumns = [
        {
            header: " ",
            field: "__actions",
            sortable: false,
            searchable: false,
            bodyAlignment: "center",
            render: (row) => <GuruAction row={row} loadOptions={loadOptions} />, 
        },
        {
            header: "Nama Guru",
            field: "nama_guru",
        },
        {
            header: "Keterangan Guru",
            field: "ket_guru",
        },
        {
            header: "Status",
            field: "status_guru",
        },
    ];

    return (
        <DataTable
            collection={collection}
            columns={GuruColumns}
            ActionsButton={<ActionsButton onClickNew={onClickNew} />}
            withSearch
            withPagination
            resetRouteRedirect={route("admin.guru.index")}
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
