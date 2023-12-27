import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import DataTable from "@/Theme/Components/DataTable/DataTable";
import { Fragment } from "react";
import { BiPlus } from "react-icons/bi";
import KelasAction from "./KelasAction";
import { AiOutlineBars } from "react-icons/ai";
import CellTemplateNamaGuru from "@/Theme/Components/DataTable/Cell/CellTemplateNamaGuru";

export default function KelasDataTable({
    collection,
    loadOptions,
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
            render: (row) => (
                <KelasAction row={row} loadOptions={loadOptions} />
            ),
        },
        {
            header: "Tingkat Kelas",
            searchable: false,
            field: "tingkat_kelas",
        },
        {
            header: "Nama Kelas",
            field: "nama",
        },
        {
            header: "Tahun Ajaran",
            render: (row) => <TemplateTahunAjaran row={row} />,
        },
        {
            header: "Wali Kelas",
            field: "wali_kelas",
            render: (row) => <CellTemplateNamaGuru row={row.guru} />,
        },
        {
            header: "Jumlah Siswa",
            field: "anggota_kelas",
            render: (row) => (
                <PrimaryButton>
                    <AiOutlineBars /> {row.siswa.length}
                </PrimaryButton>
            ),
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

const TemplateTahunAjaran = ({ row }) => {
    function getSemester() {
        if (row.tahun_ajaran.semester == 1) return "Ganjil";
        if (row.tahun_ajaran.semester == 2) return "Genap";
    }

    return (
        <p>
            {row.tahun_ajaran.tahun_ajaran} - {getSemester()}
        </p>
    );
};
