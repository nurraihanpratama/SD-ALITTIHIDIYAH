import TemplateTtl from "@/Theme/Components/DataTable/Cell/TemplateTtl";
import DataTable from "@/Theme/Components/DataTable/DataTable";

export default function DataSiswaDataTable({ collection, loadOptions }) {
    const siswaColumns = [
        {
            header: " ",
            field: "__actions",
            sortable: false,
            searchable: false,
            bodyAlignment: "center",
            // render: (row) => (
            //     <SiswaAction row={row} loadOptions={loadOptions} />
            // ),
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
            render: (row) => <p>{row.kelas.nama}</p>,
        },
        {
            header: "TEMPAT TANGGAL LAHIR",
            field: "tanggal_lahir",
            render: (row) => <TemplateTtl row={row} />,
        },
        {
            header: "STATUS",
            field: "status_siswa",
        },
    ];
    return (
        <DataTable
            columns={siswaColumns}
            collection={collection}
            withPagination
            withSearch
            resetRouteRedirect={"guru.data-siswa.index"}
        />
    );
}
