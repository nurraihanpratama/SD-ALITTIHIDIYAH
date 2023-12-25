import { AiOutlineArrowLeft, AiOutlineArrowRight } from "react-icons/ai";
import { useState } from "react";

export default function SimpleTable({
    title,
    collection,
    columns,
    rowsPerPage = 5,
    selectable = false,
    onSelect,
    tableFooter = null,
    withCopyHeaderToFooter = false,
}) {
    const [currentPage, setCurrentPage] = useState(1);

    const totalPages = Math.ceil(collection.length / rowsPerPage);

    const prevPage = () => {
        if (currentPage > 1) {
            setCurrentPage(currentPage - 1);
        }
    };

    const nextPage = () => {
        if (currentPage < totalPages) {
            setCurrentPage(currentPage + 1);
        }
    };

    const startIndex = (currentPage - 1) * rowsPerPage;
    const endIndex = startIndex + rowsPerPage;

    return (
        <div className="px-4 py-3 gap-4 w-full">
            <header className="flex-between mb-2">
                {title}
                {collection?.length > 0 && (
                    <div className="flex-end gap-2">
                        <PageNavButton
                            onClick={prevPage}
                            disabled={currentPage === 1}
                            icon={<AiOutlineArrowLeft />}
                        />
                        <PageNavButton
                            onClick={nextPage}
                            disabled={currentPage === totalPages}
                            icon={<AiOutlineArrowRight />}
                        />
                    </div>
                )}
            </header>
            <table className="w-full ">
                <thead className="text-gray-700 dark:text-white bg-[#EDF2F9] dark:bg-[#232E3C]">
                    <tr>
                        {columns.map((column, i) => {
                            const getHeaderAlignment = () => {
                                if (
                                    !column.headerAlignment ||
                                    column.headerAlignment === "left"
                                )
                                    return "flex-start";
                                if (column.headerAlignment === "center")
                                    return "flex-center";
                                if (column.headerAlignment === "right")
                                    return "flex-end";
                            };
                            return (
                                <th
                                    key={i}
                                    className="first:pl-4 last:pr-4 px-2 py-2 font-normal text-sm"
                                >
                                    <p
                                        className={`font-bold not:hover:text-gray-700 dark:not:hover:text-white select-none whitespace-nowrap ${getHeaderAlignment()} `}
                                    >
                                        {column.renderHeader
                                            ? column.renderHeader(column)
                                            : column.header}
                                    </p>
                                </th>
                            );
                        })}
                    </tr>
                </thead>
                <tbody>
                    {collection
                        ?.slice(startIndex, endIndex)
                        .map((row, rowIndex) => {
                            return (
                                <tr
                                    key={rowIndex}
                                    onClick={() =>
                                        selectable ? onSelect(row) : {}
                                    }
                                    className={`hover:bg-gray-100 dark:hover:bg-black/25 ${
                                        selectable && "cursor-pointer"
                                    } ${
                                        row.deleted_at &&
                                        "bg-[#ffadad] dark:bg-[#410b0b] hover:bg-[#ffadad] dark:hover:bg-[#410b0b]"
                                    }`}
                                >
                                    {columns.map((col, i) => {
                                        function getBodyAlignment() {
                                            if (
                                                !col.bodyAlignment ||
                                                col.bodyAlignment === "left"
                                            )
                                                return "text-start";
                                            if (col.bodyAlignment === "center")
                                                return "text-center";
                                            if (col.bodyAlignment === "right")
                                                return "text-end";
                                        }
                                        return (
                                            <td
                                                key={i}
                                                align="center"
                                                className={`first:pl-4 last:pr-4 px-2 py-2 text-sm border-b border-gray-200 text-gray-700 dark:text-gray-300 dark:border-gray-700 ${getBodyAlignment()}`}
                                            >
                                                {/* {col.rowIndex && <p>{rowIndex + 1}</p>} */}
                                                {col.render ? (
                                                    col.render(row, rowIndex)
                                                ) : (
                                                    <p>{row[col.field]}</p>
                                                )}
                                            </td>
                                        );
                                    })}
                                </tr>
                            );
                        })}
                </tbody>
                {tableFooter}
                {withCopyHeaderToFooter && (
                    <tfoot className="text-gray-700 dark:text-white bg-[#EDF2F9] dark:bg-[#232E3C]">
                        <tr>
                            {columns.map((column, i) => {
                                const getHeaderAlignment = () => {
                                    if (
                                        !column.headerAlignment ||
                                        column.headerAlignment === "left"
                                    )
                                        return "flex-start";
                                    if (column.headerAlignment === "center")
                                        return "flex-center";
                                    if (column.headerAlignment === "right")
                                        return "flex-end";
                                };
                                return (
                                    <th
                                        key={i}
                                        className="first:pl-4 last:pr-4 px-2 py-2 font-normal text-sm"
                                    >
                                        <p
                                            className={`font-bold not:hover:text-gray-700 dark:not:hover:text-white select-none whitespace-nowrap ${getHeaderAlignment()} `}
                                        >
                                            {column.renderHeader
                                                ? column.renderHeader(column)
                                                : column.header}
                                        </p>
                                    </th>
                                );
                            })}
                        </tr>
                    </tfoot>
                )}
            </table>
            {collection.length == 0 && (
                <p className="text-center text-gray-700 dark:text-white">
                    No data found...
                </p>
            )}
        </div>
    );
}

const PageNavButton = ({ onClick, disabled, icon }) => {
    return (
        <button
            type="button"
            onClick={onClick}
            disabled={disabled}
            className="text-xl flex-center gap-1 px-4 py-2 
      text-gray-700 dark:text-white 
      dark:bg-[#0B1727] 
      disabled:text-gray-400 disabled:dark:text-gray-500
      hover:text-primary hover:dark:text-primary
      "
        >
            {icon}
        </button>
    );
};
