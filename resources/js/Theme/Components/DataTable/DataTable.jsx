import SearchBox from "@/Theme/Components/SearchBox";
import FullscreenToggler from "@/Theme/Components/FullscreenToggler";
import { useState } from "react";
import { FaSort, FaSortDown, FaSortUp } from "react-icons/fa6";
import { Link, router } from "@inertiajs/react";
import { getParameterFromUrl, urlModifier } from "@/Helpers/helper";
import { BiReset } from "react-icons/bi";
import {
    AiOutlineArrowLeft,
    AiOutlineArrowRight,
    AiOutlineDoubleLeft,
    AiOutlineDoubleRight,
} from "react-icons/ai";

export default function DataTable({
    collection,
    columns,
    ActionsButton,
    FilterButton,
    withSearch = false,
    withPagination = false,
    withRowSelection = false,
    onSelectRow,
    resetRouteRedirect = null,
    custom = false,
    children = null,
}) {
    return (
        <div className="w-full rounded-md shadow-lg overflow-auto bg-white dark:bg-[#121E2E]">
            <header className="gap-4 px-4 py-3 flex-start">
                {/* <FullscreenToggler /> */}

                {ActionsButton && (
                    <div className="flex-none">{ActionsButton}</div>
                )}

                {withSearch && (
                    <div className="flex-grow">
                        <SearchFunction
                            searchFields={columns.filter(
                                (c) =>
                                    c.searchable === undefined ||
                                    c.searchable === true
                            )}
                        />
                    </div>
                )}

                {resetRouteRedirect && (
                    <div className="flex-none">
                        <Link
                            href={resetRouteRedirect}
                            className="font-semibold px-4 py-1 rounded-md button-shadow text-gray-600 dark:text-white dark:bg-[#0B1727] hover:bg-rose-500 hover:text-white hover:dark:bg-rose-500 hover:dark:text-white flex-start gap-1"
                        >
                            <BiReset />
                            Reset
                        </Link>
                    </div>
                )}

                {FilterButton && (
                    <div className="flex-none">{FilterButton}</div>
                )}
            </header>

            <table className="w-full ">
                <thead className="text-gray-700 dark:text-white bg-[#EDF2F9] dark:bg-[#232E3C]">
                    <tr>
                        {columns.map((column, i) => {
                            return <TableHeader key={i} column={column} />;
                        })}
                    </tr>
                </thead>
                {children}
                {!custom && (
                    <tbody>
                        {collection.data?.map((row, i) => {
                            return (
                                <tr
                                    key={i}
                                    className={`hover:bg-gray-100 dark:hover:bg-black/25 ${
                                        row.deleted_at &&
                                        "bg-[#ffadad] dark:bg-[#410b0b] hover:bg-[#ffadad] dark:hover:bg-[#410b0b]"
                                    }`}
                                    onClick={() => {
                                        if (withRowSelection)
                                            return onSelectRow(row);
                                    }}
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
                                                align="center"
                                                key={i}
                                                className={`first:pl-4 last:pr-4 px-2 py-2 text-sm
                      border-b border-gray-200 
                      text-gray-700 dark:text-gray-300 dark:border-gray-700 
                      ${getBodyAlignment()}
                      ${withRowSelection && "cursor-pointer"}
                      `}
                                            >
                                                {col.render ? (
                                                    col.render(row)
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
                )}
            </table>
            {withPagination && (
                <Pagination meta={collection.meta} links={collection.links} />
            )}
        </div>
    );
}

const TableHeader = ({ column }) => {
    const parameterSortField = "sort[f]";
    const parameterSortDirection = "sort[d]";

    const sortField = getParameterFromUrl(parameterSortField);
    const sortDirection = getParameterFromUrl(parameterSortDirection);

    const sort = {
        f: sortField,
        d: sortDirection,
    };

    const aligment = () => {
        if (!column.headerAlignment || column.headerAlignment === "left")
            return "flex-start";
        if (column.headerAlignment === "center") return "flex-center";
        if (column.headerAlignment === "right") return "flex-end";
    };

    const canSort =
        column.sortable === undefined || column.sortable === true
            ? true
            : false;

    function onSort() {
        if (column.sortable === false) return;

        const nextDirection =
            sort?.f === column.field
                ? sort?.d === "asc"
                    ? "desc"
                    : "asc"
                : "asc";

        const resetPage = urlModifier(window.location.href, "page", 1);
        const addSortField = urlModifier(
            resetPage,
            parameterSortField,
            column.field
        );
        const fetchUrl = urlModifier(
            addSortField,
            parameterSortDirection,
            nextDirection
        );

        return router.get(fetchUrl, {}, { preserveScroll: true });
    }

    return (
        <th
            className={`first:pl-4 last:pr-4 px-2 py-2 text-left font-normal text-sm ${
                canSort &&
                "cursor-pointer hover:bg-primary dark:hover:bg-primary hover:text-white dark:hover:text-white"
            }`}
            onClick={onSort}
        >
            <div className={`${aligment()} gap-2`}>
                {canSort && (
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
                <p className="font-bold select-none not:hover:text-gray-700 dark:not:hover:text-white whitespace-nowrap">
                    {column.header}
                </p>
            </div>
        </th>
    );
};

const SearchFunction = ({ searchFields }) => {
    const [search, setSearch] = useState(
        getParameterFromUrl("search[v]") ?? ""
    );
    const [searchField, setSearchField] = useState(
        getParameterFromUrl("search[f]") ?? searchFields[0].field
    );

    function onSelectSearchField(e) {
        setSearchField(e.target.value);

        if (search) {
            const resetPage = urlModifier(window.location.href, "page", 1);

            const addSearchField = urlModifier(
                resetPage,
                "search[f]",
                e.target.value
            );

            const fetchUrl = urlModifier(addSearchField, "search[v]", search);

            return router.get(fetchUrl, {}, { preserveScroll: true });
        }
    }

    function onSearch(value) {
        setSearch(value);
        const resetPage = urlModifier(window.location.href, "page", 1);

        const addSearchField = urlModifier(resetPage, "search[f]", searchField);

        const fetchUrl = urlModifier(addSearchField, "search[v]", value);

        return router.get(fetchUrl, {}, { preserveScroll: true });
    }

    return (
        <SearchBox
            search={search}
            setSearch={onSearch}
            searchField={searchField}
            searchFields={searchFields}
            onSelectSearchField={onSelectSearchField}
            autoFocus
        />
    );
};

const Pagination = ({ meta, links }) => {
    if (meta.total > 0) {
        return (
            <div className="flex-center gap-4 py-4 text-gray-700 dark:text-white bg-[#EDF2F9] dark:bg-[#232E3C]">
                <div className="gap-2 flex-center">
                    <PageNavButton
                        icon={<AiOutlineDoubleLeft />}
                        href={links.first}
                        disabled={!links.prev}
                    />

                    <PageNavButton
                        icon={<AiOutlineArrowLeft />}
                        href={links.prev}
                        disabled={!links.prev}
                    />

                    <p className="text-sm flex-center gap-1 px-4 py-2 text-gray-700 dark:text-white dark:bg-[#0B1727]">
                        {`Page ${meta.current_page} / ${meta.last_page}. Records ${meta.from}-${meta.to} of ${meta.total}`}
                    </p>

                    <PageNavButton
                        icon={<AiOutlineArrowRight />}
                        href={links.next}
                        disabled={!links.next}
                    />

                    <PageNavButton
                        icon={<AiOutlineDoubleRight />}
                        href={links.last}
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

const PageNavButton = ({ href, disabled, icon }) => {
    return (
        <Link
            href={href}
            className="text-xl flex-center gap-1 px-4 py-2 text-gray-700 dark:text-white dark:bg-[#0B1727] disabled:dark:text-gray-500"
            as="button"
            disabled={disabled}
            preserveScroll
        >
            {icon}
        </Link>
    );
};
