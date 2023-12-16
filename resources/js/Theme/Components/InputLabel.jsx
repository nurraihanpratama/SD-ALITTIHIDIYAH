export default function InputLabel({
    value,
    className = "",
    children,
    isRequired,
    ...props
}) {
    return (
        <label
            {...props}
            className={
                `block w-fit font-medium text-sm text-gray-700 dark:text-white ` +
                className
            }
        >
            {value ? value : children}
            {isRequired && <span className="text-red-500"> *</span>}
        </label>
    );
}
