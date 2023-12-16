import InputError from "../Components/InputError";
import InputLabel from "../Components/InputLabel";
import TextArea from "../Components/TextArea";

export default function FormTextArea({
    name,
    label,
    value,
    onChange,
    isRequired = false,
    error,
    ...props
}) {
    return (
        <div className="block">
            <InputLabel htmlFor={name} value={label} isRequired={isRequired} />
            <TextArea
                id={name}
                name={name}
                value={value}
                onChange={onChange}
                spellCheck={false}
                {...props}
            />
            <InputError message={error} className="mt-2" />
        </div>
    );
}
