import AjaxTable from "@/Theme/Components/DataTable/AjaxTable";
import SearchBoxSimple from "@/Theme/Components/SearchBoxSimple";
import { useState } from "react";

export default function KelasSelectionTable({ fetchRoute, onRowSelect }) {
    const [search, setSearch] = useState("");
    const columns = [
        {
            header: "Tingkat Kelas",
            field: "tingkat_kelas",
        },
        {
            header: "Nama Kelas",
            field: "nama",
        },
        {
            header: "Tahun Ajaran",
            field: "nama",
        },
        {
            header: "Wali Kelas",
            field: "nama",
        },
    ];

    return (
        <div className="w-full overflow-auto">
            <div className="flex-grow p-4">
                <SearchBoxSimple search={search} setSearch={setSearch} />
            </div>
            <AjaxTable
                fetchRoute={route(fetchRoute)}
                columns={columns}
                search={search}
                pagination
                rowSelection
                onSelectRow={onRowSelect}
            />
        </div>
    );
}
