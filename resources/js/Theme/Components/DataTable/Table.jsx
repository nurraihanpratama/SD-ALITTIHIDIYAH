import axios from "axios";
import { usePage } from "@inertiajs/react";
import { Fragment, useEffect, useState } from "react";
import { FaSort, FaSortDown, FaSortUp } from "react-icons/fa6";
import { SlArrowLeft, SlArrowRight } from "react-icons/sl";

export default function Table({
    fetchRoute,
    columns,
    search,
    pagination,
    rowSelection,
    onSelectRow,
}) {
    const token = usePage().props.alert?.token;

    const [data, setData] = useState([]);
    const [loading, setLoading] = useState(true);
    const [sort, setSort] = useState(null);
    const [page, setPage] = useState(1);

    const [meta, setMeta] = useState(null);

    const fetchData = () => {
        axios
            .get(fetchRoute, {
                params: {
                    page: page,
                    sort: sort,
                    search: search,
                    columns: columns.map((column) => ({
                        field: column.field,
                        searchable: column.searchable ?? true,
                        sortable: column.sortable ?? true,
                    })),
                },
            })
            .then((response) => {
                setData(response.data.collection.data);
                setMeta({
                    prev_page_url: response.data.collection.prev_page_url,
                    next_page_url: response.data.collection.next_page_url,
                    current_page: response.data.collection.current_page,
                    last_page: response.data.collection.last_page,
                    from: response.data.collection.from,
                    to: response.data.collection.to,
                    total: response.data.collection.total,
                });
                setLoading(false);
            })
            .catch((error) => {
                console.error("Error fetching data:", error);
            });
    };

    useEffect(() => {
        setLoading(true);
        fetchData();
    }, [page, search, sort, token]);

    if (loading)
        return (
            <div className="flex-col gap-8 px-10 py-20 bg-gray-700 flex-center md:flex-row">
                <span className="loader"></span>
                <span className="text-white">Processing... Please Wait</span>
            </div>
        );

    if (meta?.total === 0)
        return (
            <p className="p-4 text-center text-gray-700 dark:text-white">
                No data found...
            </p>
        );

    return (
        <Fragment>
            <table className="w-full">
                <thead className="text-gray-700 dark:text-white bg-[#EDF2F9] dark:bg-[#232E3C]">
                    <tr>
                        {columns.map((column, i) => {
                            return (
                                <TableHeader
                                    key={i}
                                    column={column}
                                    sort={sort}
                                    setSort={setSort}
                                />
                            );
                        })}
                    </tr>
                </thead>
                <tbody>
                    {data?.map((row, i) => {
                        const onClickRow = () => {
                            if (rowSelection) return onSelectRow(row);
                        };
                        return (
                            <tr
                                key={i}
                                className="hover:bg-gray-100 dark:hover:bg-black/25"
                                onClick={() => onClickRow()}
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
                                            className={`first:pl-4 last:pr-4 px-2 py-2 align-top 
                      border-b border-gray-200
                      text-gray-700 dark:text-gray-300 dark:border-gray-700 
                      ${getBodyAlignment()}
                      ${rowSelection && "cursor-pointer"}
                      `}
                                        >
                                            {col.render
                                                ? col.render(row)
                                                : row[col.field]}
                                        </td>
                                    );
                                })}
                            </tr>
                        );
                    })}
                </tbody>
            </table>
            {pagination && <Pagination meta={meta} setPage={setPage} />}
        </Fragment>
    );
}

const TableHeader = ({ column, sort, setSort }) => {
    const aligment = () => {
        if (!column.headerAlignment || column.headerAlignment === "left")
            return "flex-start";
        if (column.headerAlignment === "center") return "flex-center";
        if (column.headerAlignment === "right") return "flex-end";
    };

    const onSort = () => {
        if (column.sortable === false) return;
        if (sort?.field === column.field) {
            if (!sort) {
                setSort({
                    field: column.field,
                    direction: "asc",
                });
            }

            if (sort?.direction === "asc") {
                setSort({
                    direction: "desc",
                    field: column.field,
                });
            }

            if (sort?.direction === "desc") {
                setSort(null);
            }
        } else {
            setSort({
                direction: "asc",
                field: column.field,
            });
        }
    };

    function canSort() {
        return column.sortable === undefined || column.sortable === true
            ? true
            : false;
    }

    return (
        <th
            className={`first:pl-4 last:pr-4 px-2 py-2 text-left font-normal text-sm ${
                canSort() &&
                "cursor-pointer hover:bg-primary dark:hover:bg-primary hover:text-white dark:hover:text-white"
            }`}
            onClick={() => onSort()}
        >
            <div className={`${aligment()} gap-2`}>
                {canSort() && (
                    <div>
                        {sort?.field !== column.field && (
                            <FaSort className="text-gray-400 dark:text-gray-600" />
                        )}

                        {sort?.field === column.field &&
                            sort?.direction === "asc" && (
                                <FaSortUp className="text-gray-700 dark:text-gray-100" />
                            )}

                        {sort?.field === column.field &&
                            sort?.direction === "desc" && (
                                <FaSortDown className="text-gray-700 dark:text-gray-100" />
                            )}
                    </div>
                )}
                <p className="font-bold select-none not:hover:text-gray-700 dark:not:hover:text-white">
                    {column.header}
                </p>
            </div>
        </th>
    );
};

const Pagination = ({ meta, setPage }) => {
    const goPrevPage = () => {
        const url = new URL(meta.prev_page_url);
        const search_params = url.searchParams;
        const pageValue = search_params.get("page");

        setPage(pageValue);
    };

    const goNextPage = () => {
        const url = new URL(meta.next_page_url);
        const search_params = url.searchParams;
        const pageValue = search_params.get("page");

        setPage(pageValue);
    };

    return (
        <div className="gap-4 py-4 flex-center">
            <ButtonPageNav
                onClick={() => goPrevPage()}
                disabled={!meta.prev_page_url}
                icon={<SlArrowLeft size={15} />}
            />

            <div className="gap-1 text-sm text-gray-700 flex-center dark:text-white">
                <p>
                    Page {meta.current_page} / {meta.last_page}.
                </p>
                <p>Total Records {meta.total}</p>
            </div>

            <ButtonPageNav
                onClick={() => goNextPage()}
                disabled={!meta.next_page_url}
                icon={<SlArrowRight size={15} />}
            />
        </div>
    );
};

const ButtonPageNav = ({ onClick, disabled, icon }) => {
    return (
        <button
            type="button"
            className="font-bold px-4 py-2 rounded-md button-shadow text-gray-600 dark:text-white dark:bg-[#0B1727] disabled:text-gray-400 disabled:dark:text-gray-700
      hover:text-primary hover:dark:text-primary
      "
            onClick={onClick}
            disabled={disabled}
        >
            {icon}
        </button>
    );
};
