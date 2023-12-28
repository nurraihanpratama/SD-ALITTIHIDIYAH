import axios from "axios";
import { usePage } from "@inertiajs/react";
import { Fragment, useEffect, useState } from "react";
import { FaSort, FaSortDown, FaSortUp } from "react-icons/fa6";
import { SlArrowLeft, SlArrowRight } from "react-icons/sl";
import {
    AiOutlineArrowLeft,
    AiOutlineArrowRight,
    AiOutlineDoubleLeft,
    AiOutlineDoubleRight,
} from "react-icons/ai";
import ProcessingLoader from "../ProcessingLoader";

export default function AjaxTable({
    fetchRoute,
    columns,
    search,
    pagination,
    rowSelection,
    onSelectRow,
}) {
    const token = usePage().props.alert?.token;

    const [data, setData] = useState([]);
    const [meta, setMeta] = useState(null);
    const [links, setLinks] = useState(null);

    const [loading, setLoading] = useState(true);
    const [sort, setSort] = useState(null);
    const [page, setPage] = useState(1);

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
                setData(response.data.data);
                setMeta(response.data.meta);
                setLinks(response.data.links);
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
            <div className="flex-col gap-8 px-10 py-20 bg-gray-100 flex-center md:flex-row dark:bg-gray-700">
                <span className="loader"></span>
                <span className="text-gray-700 dark:text-white">
                    Processing... Please Wait
                </span>
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
            {pagination && (
                <Pagination meta={meta} links={links} setPage={setPage} />
            )}
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
        if (sort?.f === column.field) {
            if (!sort) {
                setSort({
                    f: column.field,
                    d: "asc",
                });
            }

            if (sort?.d === "asc") {
                setSort({
                    d: "desc",
                    f: column.field,
                });
            }

            if (sort?.d === "desc") {
                setSort(null);
            }
        } else {
            setSort({
                d: "asc",
                f: column.field,
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
            className={`first:pl-4 last:pr-4 px-2 py-2 text-left font-normal text-sm whitespace-nowrap ${
                canSort() &&
                "cursor-pointer hover:bg-primary dark:hover:bg-primary hover:text-white dark:hover:text-white"
            }`}
            onClick={() => onSort()}
        >
            <div className={`${aligment()} gap-2`}>
                {canSort() && (
                    <div>
                        {sort?.f !== column.field && (
                            <FaSort className="text-gray-400 dark:text-gray-600" />
                        )}

                        {sort?.f === column.field && sort?.d === "asc" && (
                            <FaSortUp className="text-gray-700 dark:text-gray-100" />
                        )}

                        {sort?.f === column.field && sort?.d === "desc" && (
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

const Pagination = ({ meta, links, setPage = { setPage } }) => {
    function onClickNavButton(link) {
        const url = new URL(link);
        const search_params = url.searchParams;
        const pageValue = search_params.get("page");

        setPage(pageValue);
    }

    if (meta.total > 0) {
        return (
            <div className="flex-center gap-4 p-4 text-gray-700 dark:text-white bg-[#EDF2F9] dark:bg-[#232E3C]">
                <div className="gap-2 flex-center">
                    <PageNavButton
                        icon={<AiOutlineDoubleLeft />}
                        onClick={() => onClickNavButton(links.first)}
                        disabled={!links.prev}
                    />

                    <PageNavButton
                        icon={<AiOutlineArrowLeft />}
                        onClick={() => onClickNavButton(links.prev)}
                        disabled={!links.prev}
                    />

                    <p className="text-sm flex-center gap-1 px-4 py-2 text-gray-700 dark:text-white dark:bg-[#0B1727]">
                        {`Page ${meta.current_page} / ${meta.last_page}. Records ${meta.from}-${meta.to} of ${meta.total}`}
                    </p>

                    <PageNavButton
                        icon={<AiOutlineArrowRight />}
                        onClick={() => onClickNavButton(links.next)}
                        disabled={!links.next}
                    />

                    <PageNavButton
                        icon={<AiOutlineDoubleRight />}
                        onClick={() => onClickNavButton(links.last)}
                        disabled={!links.next}
                    />
                </div>
            </div>
        );
    } else {
        return (
            <p className="p-4 text-center text-gray-700 dark:text-white">
                No data found...
            </p>
        );
    }
};

const PageNavButton = ({ onClick, disabled, icon }) => {
    return (
        <button
            type="button"
            onClick={onClick}
            className="text-xl flex-center gap-1 px-4 py-2 text-gray-700 dark:text-white dark:bg-[#0B1727] disabled:dark:text-gray-500"
            as="button"
            disabled={disabled}
        >
            {icon}
        </button>
    );
};
