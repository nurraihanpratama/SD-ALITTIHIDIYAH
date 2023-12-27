import DataTable from "@/Theme/Components/DataTable/DataTable";
import Pill from "@/Theme/Components/Pill";

export default function UserDataTable({
    collection,
    withNewButton = false,
    onClickNew,
}) {
    const UserColumns = [
        {
            header: "",
            field: "__action",
            sortable: false,
            searchable: false,
        },
        {
            header: "Username",
            field: "username",
        },
        // {
        //     header: "Nama Lengkap",
        //     field: "nama_lengkap",
        // },
        {
            header: "Email",
            field: "email",
        },
        {
            header: "Role",
            field: "role",
        },
        {
            header: "Status",
            field: "status",
            render: (row) => (
                <Pill css={row.status.css} name={row.status.name} />
            ),
        },
    ];

    return (
        <DataTable
            collection={collection}
            columns={UserColumns}
            withSearch
            withPagination
            resetRouteRedirect={route("admin.user.index")}
        />
    );
}
