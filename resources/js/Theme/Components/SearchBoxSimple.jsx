import { DebounceInput } from 'react-debounce-input'
import { FiSearch } from 'react-icons/fi'

export default function SearchBoxSimple({ search, setSearch }) {
  return (
    <div className="w-full relative">
      <DebounceInput
        type="search"
        name="searchbar"
        className="w-full rounded-full focus:ring-transparent appearance-none py-1 pl-10 pr-4 font-semibold border-2 border-gray-200 dark:border-gray-700 focus:dark:border-blue-500  bg-white dark:bg-black/40 placeholder-slate-600 dark:placeholder-slate-400 text-gray-700 dark:text-white"
        placeholder="Search..."
        spellCheck={false}
        minLength={1}
        debounceTimeout={500}
        value={search}
        onChange={(e) => setSearch(e.target.value)}
      />
      <button className="absolute inset-0 right-auto group cursor-default px-3 text-gray-700 dark:text-white">
        <FiSearch />
      </button>
    </div>
  )
}
