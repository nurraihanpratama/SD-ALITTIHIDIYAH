import { Fragment } from "react";
import { Listbox, Transition } from "@headlessui/react";
import { CheckIcon, ChevronUpDownIcon } from "@heroicons/react/20/solid";

export default function SelectInput({
    options,
    value,
    onChange,
    defaultLabel = "name",
    disabled = false,
}) {
    const selected = options.find((f) => f.id == value);
    return (
        <div className="relative w-full">
            <Listbox
                value={selected}
                by="id"
                onChange={onChange}
                disabled={disabled}
            >
                <div className="relative mt-1">
                    <Listbox.Button
                        className="relative w-full sm:text-sm cursor-pointer rounded-lg py-2 pl-3 pr-10 text-left shadow-md focus:outline-none focus:ring-2  
            bg-white dark:bg-black/40 text-gray-700 dark:text-white
            disabled:bg-gray-200 dark:disabled:bg-gray-700
            disabled:text-gray-700 dark:disabled:text-gray-300
            disabled:shadow-none
            "
                    >
                        <span className="block truncate">
                            {selected[defaultLabel]}
                        </span>
                        <span className="pointer-events-none absolute inset-y-0 right-0 flex items-center pr-2">
                            <ChevronUpDownIcon
                                className="h-5 w-5 text-gray-400"
                                aria-hidden="true"
                            />
                        </span>
                    </Listbox.Button>
                    <Transition
                        as={Fragment}
                        leave="transition ease-in duration-100"
                        leaveFrom="opacity-100"
                        leaveTo="opacity-0"
                    >
                        <Listbox.Options
                            className="absolute mt-1 max-h-60 w-full overflow-auto rounded-md py-1 text-base shadow-lg ring-1 ring-opacity-5 focus:outline-none sm:text-sm 
              text-gray-700 dark:text-white
            bg-white dark:bg-black
            ring-black z-50 
            "
                        >
                            {options.map((option, i) => (
                                <Listbox.Option
                                    key={i}
                                    className={({ active }) =>
                                        `relative text-left cursor-pointer select-none py-2 pl-10 pr-4 ${
                                            active
                                                ? "bg-amber-100 text-amber-900"
                                                : "text-gray-900 dark:text-white"
                                        }`
                                    }
                                    value={option}
                                >
                                    {({ selected }) => (
                                        <Fragment>
                                            <span
                                                className={`w-fit text-left ${
                                                    selected
                                                        ? "font-medium"
                                                        : "font-normal"
                                                }`}
                                            >
                                                {option[defaultLabel]}
                                            </span>
                                            {selected ? (
                                                <span className="absolute inset-y-0 left-0 flex items-center pl-3 text-amber-600">
                                                    <CheckIcon
                                                        className="h-5 w-5"
                                                        aria-hidden="true"
                                                    />
                                                </span>
                                            ) : null}
                                        </Fragment>
                                    )}
                                </Listbox.Option>
                            ))}
                        </Listbox.Options>
                    </Transition>
                </div>
            </Listbox>
        </div>
    );
}
