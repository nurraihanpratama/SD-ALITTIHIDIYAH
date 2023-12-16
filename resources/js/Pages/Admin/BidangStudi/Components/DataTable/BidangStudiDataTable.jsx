// BidangStudiDataTable.php
import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import { BiPlus } from "react-icons/bi";
import BidangStudiAction from "./BidangStudiAction"; 

export default function BidangStudiDataTable({
    collection,
    withNewButton = false,
    onClickNew,
}) {
    const BidangStudiColumns = [
        {
            header: " ",
            field: "__actions",
            sortable: false,
            searchable: false,
            bodyAlignment: "center",
            render: (row) => <BidangStudiAction row={row} />, 
        },
        {
            header: "Nama Bidang Studi",
            field: "nama_mapel",
        },
    ];
    console.log(collection);
    return (
        <DataTable
            collection={collection}
            columns={BidangStudiColumns}
            ActionsButton={<ActionsButton onClickNew={onClickNew} />}
            withSearch
            withPagination
            resetRouteRedirect={route("admin.bidang-studi.index")}
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
