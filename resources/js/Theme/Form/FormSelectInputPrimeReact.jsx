import InputError from "@/Components/InputError";
// import InputLabel from "@/Components/InputLabel";
import { Dropdown } from "primereact/dropdown";
import InputLabel from "../Components/InputLabel";

export default function FormSelectInputPrimeReact({
    name,
    label,
    value,
    onChange,
    options,
    optionLabel,
    placeholder,
    itemTemplate,
    valueTemplate,
    className,
    panelClassName,
    nolabel = false,
    isRequired = false,
    error,
    note,
    ...props
}) {
    return (
        <div className="block w-full ">
            {!nolabel && (
                <InputLabel
                    htmlFor={name}
                    value={label}
                    isRequired={isRequired}
                    className="whitespace-nowrap"
                />
            )}
            <Dropdown
                name={name}
                value={value}
                onChange={onChange}
                options={options}
                optionLabel={optionLabel}
                placeholder={placeholder}
                itemTemplate={itemTemplate}
                valueTemplate={valueTemplate}
                className={` text-start bg-white dark:bg-black/40 w-full mt-1 drop-shadow-md ${className}`}
                panelClassName={`bg-white ${panelClassName}`}
                {...props}
            />
            <p className="text-xs font-semibold text-blue-600 ">{note}</p>
            {error && <InputError message={error} className="mt-2" />}
        </div>
    );
}
