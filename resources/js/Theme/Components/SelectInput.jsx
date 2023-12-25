// FormSelectInput.jsx
import { Fragment } from "react";
import { Listbox, Transition } from "@headlessui/react";
import { CheckIcon, ChevronUpDownIcon } from "@heroicons/react/20/solid";

export default function SelectInput({
    options,
    value,
    onChange,
    idKey = "id",
    nameKey = "name",
    disabled = false,
}) {
    const selected = options.find((f) => f[idKey] == value);

    return (
        <div className="relative w-full">
            <Listbox
                value={selected}
                by={idKey}
                onChange={onChange}
                disabled={disabled}
            >
                <div className="relative mt-1">
                    <Listbox.Button className="relative w-full py-2 pl-3 pr-10 text-left text-gray-700 bg-white rounded-lg shadow-md cursor-pointer sm:text-sm focus:outline-none focus:ring-2 dark:bg-black/40 dark:text-white disabled:bg-gray-200 dark:disabled:bg-gray-700 disabled:text-gray-700 dark:disabled:text-gray-300 disabled:shadow-none">
                        <span className="block truncate">
                            {selected[nameKey]}
                        </span>
                        <span className="absolute inset-y-0 right-0 flex items-center pr-2 pointer-events-none">
                            <ChevronUpDownIcon
                                className="w-5 h-5 text-gray-400"
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
                        <Listbox.Options className="absolute z-50 w-full py-1 mt-1 overflow-auto text-base text-gray-700 bg-white rounded-md shadow-lg max-h-60 ring-1 ring-opacity-5 focus:outline-none sm:text-sm dark:text-white dark:bg-black ring-black">
                            {options.map(
                                (option, i) => (
                                    console.log(option),
                                    (
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
                                                        {option[nameKey]}
                                                    </span>
                                                    {selected ? (
                                                        <span className="absolute inset-y-0 left-0 flex items-center pl-3 text-amber-600">
                                                            <CheckIcon
                                                                className="w-5 h-5"
                                                                aria-hidden="true"
                                                            />
                                                        </span>
                                                    ) : null}
                                                </Fragment>
                                            )}
                                        </Listbox.Option>
                                    )
                                )
                            )}
                        </Listbox.Options>
                    </Transition>
                </div>
            </Listbox>
        </div>
    );
}
