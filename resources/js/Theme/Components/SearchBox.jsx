import { useRef } from "react";
import { DebounceInput } from "react-debounce-input";
import { FaRegTimesCircle } from "react-icons/fa";
import { FiSearch } from "react-icons/fi";

export default function SearchBox({
    search,
    setSearch,
    searchField,
    searchFields,
    onSelectSearchField,
    autoFocus,
}) {
    const ref = useRef(null);

    function onFocus(e) {
        ref.current?.classList.add("border-primary-700");
        ref.current?.classList.add("dark:border-primary-700");
    }
    function onBlur(e) {
        ref.current?.classList.remove("border-primary-700");
        ref.current?.classList.remove("dark:border-primary-700");
        ref.current?.classList.add("border-gray-300");
        ref.current?.classList.add("dark:border-gray-700");
    }

    return (
        <div
            ref={ref}
            className="w-full px-4 text-sm bg-white border-2 border-gray-300 rounded-full flex-start appearxance-none dark:border-gray-700 dark:bg-black"
        >
            {/*  */}
            <div className="flex-start">
                <FiSearch className="text-gray-700 txext-sm dark:text-white" />
                <select
                    className="text-sm font-bold text-gray-700 bg-white border-none cursor-pointer focus:border-none focus:ring-0 bg-trxansparent dark:bg-black dark:text-white"
                    value={searchField}
                    onChange={onSelectSearchField}
                >
                    {searchFields?.map((item, i) => {
                        return (
                            <option key={i} value={item.field}>
                                {item.header}
                            </option>
                        );
                    })}
                </select>
            </div>

            <p className="text-xl text-gray-300 dark:text-gray-600">|</p>
            <div className="w-full flex-between">
                <DebounceInput
                    type="search"
                    name="searchbar"
                    className="w-full text-sm text-gray-700 bg-transparent border-none dark:bg-transparent focus:border-none focus:ring-0 dark:text-white"
                    placeholder="Search..."
                    spellCheck={false}
                    minLength={1}
                    debounceTimeout={500}
                    value={search}
                    onChange={(e) => setSearch(e.target.value)}
                    onFocus={onFocus}
                    onBlur={onBlur}
                    autoFocus={autoFocus}
                />
                {search && (
                    <button
                        type="button"
                        className="text-gray-500 dark:text-white"
                        onClick={() => setSearch("")}
                    >
                        <FaRegTimesCircle />
                    </button>
                )}
            </div>
            {/*  */}
        </div>
    );
}
