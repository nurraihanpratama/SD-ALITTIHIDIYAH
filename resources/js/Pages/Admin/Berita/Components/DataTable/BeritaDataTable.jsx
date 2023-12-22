// BeritaDataTable.php
import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import { BiPlus } from "react-icons/bi";
import BeritaAction from "./BeritaAction";
import CellImageTemplate from "@/Theme/Components/DataTable/Cell/CellImageTemplate";

export default function BeritaDataTable({
    collection,
    loadOptions,
    withNewButton = false,
    onClickNew,
}) {
    const BeritaColumns = [
        {
            header: " ",
            field: "__actions",
            sortable: false,
            searchable: false,
            bodyAlignment: "center",
            render: (row) => (
                <BeritaAction row={row} loadOptions={loadOptions} />
            ),
        },
        {
            header: "Nama Berita",
            field: "judul",
        },
        {
            header: "Foto",
            field: "foto",
            render: (row) =>
                row.foto_filename ? (
                    <CellImageTemplate
                        filename={row.proof_filename}
                        path={"/storage/upload/berita/foto/"}
                        alt="Foto Berita"
                        className="h-10"
                    />
                ) : null,
        },
        {
            header: "Deskripsi",
            field: "deskripsi",
        },
    ];

    return (
        <DataTable
            collection={collection}
            columns={BeritaColumns}
            ActionsButton={<ActionsButton onClickNew={onClickNew} />}
            withSearch
            withPagination
            resetRouteRedirect={route("admin.berita.index")}
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
