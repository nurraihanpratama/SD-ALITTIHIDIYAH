import LogoImg from "../../../assets/images/LOGO-YKPI.png";

export default function Logo({ subname = null }) {
    return (
        <div className="gap-2 lg:flex-start">
            <div className="gap-2 flex-start">
                <img src={LogoImg} alt="Application Logo" width={200} />
                <div className="text-3xl font-bold flex-start font-caprasimo">
                    {/* <p className="text-gray-700 dark:text-white">SD</p> */}
                    {/* <p className="text-primary">ALITTIHAD</p> */}
                </div>
            </div>
            {subname && (
                <div className="gap-2 font-bold flex-start lg:text-3xl font-caprasimo">
                    <p className="hidden text-gray-700 lg:inline-block dark:text-white">
                        |
                    </p>
                    <p className="text-gray-700 dark:text-white whitespace-nowrap">
                        {subname}
                    </p>
                </div>
            )}
        </div>
    );
}
