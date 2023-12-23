export default function TableInputNilai({ collection, columns, form = null }) {
    return (
        <div className="w-full rounded-md shadow-lg overflow-auto bg-white dark:bg-[#121E2E]">
            <table className="w-full">
                <thead className="text-gray-700 dark:text-white bg-[#EDF2F9] dark:bg-[#232E3C]">
                    <tr>
                        {columns.map((column, i) => {
                            return <TableHeader key={i} column={column} />;
                        })}
                    </tr>
                </thead>
                <tbody>
                    {collection.data.map((row, i) => {
                        return (
                            <TableBody
                                row={row}
                                columns={columns}
                                form={form}
                                i={i}
                            />
                        );
                    })}
                </tbody>
            </table>
        </div>
    );
}

const TableHeader = ({ column }) => {
    return (
        <th
            className={`first:pl-4 last:pr-4 px-2 py-2 text-left font-normal text-sm cursor-pointer hover:bg-primary dark:hover:bg-primary hover:text-white dark:hover:text-white`}
        >
            <div className="gap-2">
                <p className="font-bold select-none not:hover:text-gray-700 dark:not:hover:text-white whitespace-nowrap">
                    {column.header}
                </p>
            </div>
        </th>
    );
};

const TableBody = ({ row, i, columns, form }) => {
    return (
        <tr
            key={i}
            className={`hover:bg-gray-100 dark:hover:bg-black/25`}
            // onClick={() => {
            //     if (withRowSelection) return onSelectRow(row);
            // }}
        >
            {columns.map((col, i) => {
                function getBodyAlignment() {
                    if (!col.bodyAlignment || col.bodyAlignment === "left")
                        return "text-start";
                    if (col.bodyAlignment === "center") return "text-center";
                    if (col.bodyAlignment === "right") return "text-end";
                }

                return (
                    <td
                        align="center"
                        key={i}
                        className={`first:pl-4 last:pr-4 px-2 py-2 text-sm
                                    border-b border-gray-200 
                                    text-gray-700 dark:text-gray-300 dark:border-gray-700 
                                    ${getBodyAlignment()}  
                                    
                                    `}
                    >
                        {col.render ? (
                            col.render(row, form)
                        ) : (
                            <p>{row[col.field]}</p>
                        )}
                    </td>
                );
            })}
        </tr>
    );
};
