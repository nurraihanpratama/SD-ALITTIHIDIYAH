import { forwardRef, useRef } from "react";
import { FaArrowRotateRight } from "react-icons/fa6";

export default forwardRef(function MenuItemButtonDropdown(
    {
        disabled,
        icon,
        label,
        onClick,
        deleteAction = false,
        processing = false,
    },
    ref
) {
    const input = ref ? ref : useRef();

    return (
        <button
            className={`group flex-between w-full items-center rounded-md px-2 py-2 text-sm  dark:hover:text-white gap-2 ${
                deleteAction ? "hover:bg-rose-500" : "hover:bg-primary"
            } disabled:hover:bg-gray-300 disabled:text-gray-400`}
            onClick={onClick}
            disabled={disabled}
        >
            <div className="gap-2 flex-start">
                {icon}
                {label}
            </div>
            {processing && <FaArrowRotateRight className="animate-spin" />}
        </button>
    );
});
