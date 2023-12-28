export default function PrimaryButton({
    type = "button",
    onClick,
    children,
    deleteAction = false,
    href,
}) {
    return (
        <button
            type={type}
            className={`flex-center gap-2 font-semibold px-4 py-1 rounded-md button-shadow text-gray-600 ${
                deleteAction
                    ? "hover:bg-red-500 hover:dark:bg-red-500"
                    : "hover:bg-primary hover:dark:bg-primary"
            } dark:text-white dark:bg-[#0B1727] hover:text-white hover:dark:bg-primary hover:dark:text-white`}
            onClick={onClick}
            href={href}
        >
            {children}
        </button>
    );
}
