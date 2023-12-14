import { MdClose } from "react-icons/md";

export default function ModalCloseButton({ onClick, disabled }) {
    return (
        <button
            type="button"
            onClick={onClick}
            className="inline-block px-2 py-2 font-medium text-white bg-red-500 border border-none rounded-full shadow-md active:translate-y-1 hover:bg-red-700 "
            disabled={disabled}
        >
            <MdClose />
        </button>
    );
}
