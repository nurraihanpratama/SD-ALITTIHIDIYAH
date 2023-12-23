import InputError from "@/Components/InputError";
import InputLabel from "@/Components/InputLabel";
import { Dropdown } from "primereact/dropdown";

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
    error,
    note,
    ...props
}) {
    return (
        <div className="relative w-full">
            <InputLabel htmlFor={name} value={label} />
            <Dropdown
                name={name}
                value={value}
                onChange={onChange}
                options={options}
                optionLabel={optionLabel}
                placeholder={placeholder}
                itemTemplate={itemTemplate}
                valueTemplate={valueTemplate}
                className={className}
                {...props}
            />
            <p className="text-xs font-semibold text-blue-600 ">{note}</p>
            {error && <InputError message={error} className="mt-2" />}
        </div>
    );
}
