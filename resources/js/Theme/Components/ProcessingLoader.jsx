import { TbSettings } from "react-icons/tb";

export default function ProcessingLoader({ visible, className }) {
    if (visible)
        return (
            <div
                // className={`absolute w-full flex-center flex-col lg:flex-row space-y-8 gap-20 rounded-xl h-full text-white bg-black ${className}`}
                className={`absolute w-full flex-center flex-col lg:flex-row space-y-8 gap-20 rounded-xl h-full modal-overlay ${className}`}
                style={{ zIndex: 999999 }}
            >
                {/* Pakai animasi */}
                {/* <div className="loader"></div> */}
                <div className="gap-2 text-gray-700 flex-center dark:text-white whitespace-nowrap">
                    <TbSettings size={30} className="text-white animate-spin" />
                    <p className="text-white">Processing... Please Wait</p>
                </div>
            </div>
        );
}
