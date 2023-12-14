import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import { BiPlus } from "react-icons/bi";
import SiswaAction from "./SIswaAction";

export default function SiswaDataTable({
    collection,
    withNewButton = false,
    onClickNew,
}) {
    const SiswaColumns = [
        {
            header: " ",
            field: "__actions",
            sortable: false,
            searchable: false,
            bodyAlignment: "center",
            render: (row) => <SiswaAction row={row} />,
        },
        {
            header: "NISN",
            field: "nisn",
        },
        {
            header: "NIPD",
            field: "nipd",
        },
        {
            header: "NAMA SISWA",
            field: "nama_siswa",
        },
        {
            header: "AGAMA",
            field: "agama_siswa",
        },
        {
            header: "KELAS",
            field: "id_kelas",
        },
        {
            header: "TEMPAT TANGGAL LAHIR",
            field: "tanggal_lahir",
        },
        {
            header: "STATUS",
            field: "status_siswa",
        },
    ];

    return (
        <DataTable
            collection={collection}
            columns={SiswaColumns}
            ActionsButton={<ActionsButton onClickNew={onClickNew} />}
            withSearch
            withPagination
            resetRouteRedirect={route("admin.siswa.index")}
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
