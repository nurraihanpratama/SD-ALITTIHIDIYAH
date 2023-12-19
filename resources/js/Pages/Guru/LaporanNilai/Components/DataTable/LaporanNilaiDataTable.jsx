import DataTable from "@/Theme/Components/DataTable/DataTable";

export default function LaporanNilaiDataTable({
    collection,
    loadOptions,
    withNewButton = false,
    onClickNew,
}) {
    const laporanNilaiColumns = [
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
            header: "Nama siswa",
            field: "siswa",
            render: (row) => row.siswa.nama_siswa,
        },
        {
            header: "Jenis Nilai",
            field: "jenis_nilai",
            render: (row) => row.jenis_nilai.name,
        },
        {
            header: "Mata Pelajaran",
            field: "id_mapel",
            render: (row) => row.mapel.nama_mapel,
        },
        {
            header: "Guru Mapel",
            field: "id_guru",
            render: (row) => row.guru.nama_guru,
        },
        {
            header: "Nilai Siswa",
            field: "nilai",
        },
    ];

    return (
        <DataTable
            columns={laporanNilaiColumns}
            collection={collection}
            withSearch
            withPagination
            resetRouteRedirect={route("guru.laporan-nilai.index")}
        />
    );
}
