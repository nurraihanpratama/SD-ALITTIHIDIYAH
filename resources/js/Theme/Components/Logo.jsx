import LogoImg from "../../../assets/images/logosch.png";

export default function Logo({ subname = null }) {
    return (
        <div className="gap-2 lg:flex-start">
            <div className="gap-2 flex-start">
                <img src={LogoImg} alt="Application Logo" width={40} />
                <div className="text-lg font-semibold flex-start font-caprasimo">
                    <p className="text-gray-700 dark:text-white">SD</p>
                    <p className="text-primary">ALITTIHADIYAH</p>
                </div>
            </div>
            {subname && (
                <div className="gap-2 font-bold flex-start lg:text-xl font-caprasimo">
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
