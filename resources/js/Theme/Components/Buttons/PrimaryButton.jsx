export default function PrimaryButton({ type = "button", onClick, children }) {
    return (
        <button
            type={type}
            className="flex-center gap-2 font-semibold px-4 py-1 rounded-md button-shadow text-gray-600 dark:text-white dark:bg-[#0B1727] hover:bg-primary hover:text-white hover:dark:bg-primary hover:dark:text-white"
            onClick={onClick}
        >
            {children}
        </button>
    );
}
