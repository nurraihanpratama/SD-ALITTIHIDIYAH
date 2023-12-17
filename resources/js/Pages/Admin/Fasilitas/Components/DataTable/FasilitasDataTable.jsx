// FasilitasDataTable.php
import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import { BiPlus } from "react-icons/bi";
import FasilitasAction from "./FasilitasAction"; 

export default function FasilitasDataTable({
    collection,
    loadOptions,
    withNewButton = false,
    onClickNew,
}) {
    const FasilitasColumns = [
        {
            header: " ",
            field: "__actions",
            sortable: false,
            searchable: false,
            bodyAlignment: "center",
            render: (row) => <FasilitasAction row={row} loadOptions={loadOptions} />, 
        },
        {
            header: "Nama Fasilitas",
            field: "nama_fasilitas",
        },
        {
            header: "Foto",
            field: "foto_fasilitas",
        },
        {
            header: "Deskripsi",
            field: "deskripsi",
        },
    ];

    return (
        <DataTable
            collection={collection}
            columns={FasilitasColumns}
            ActionsButton={<ActionsButton onClickNew={onClickNew} />}
            withSearch
            withPagination
            resetRouteRedirect={route("admin.fasilitas.index")}
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
