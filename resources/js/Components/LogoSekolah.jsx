import LogoImg from "@/../../resources/assets/images/logosch.png";

export default function LogoSekolah(props) {
    return (
        <div className="gap-2 lg:flex-start">
            <div className="flex-col items-center gap-2 flex-start drop-shadow">
                <img src={LogoImg} alt="Application Logo" width={120} />
                <div className="text-3xl font-bold flex-start font-caprasimo">
                    <p className="text-gray-700 dark:text-white">SD</p>
                    <p className="text-white-700 dark:text-white">-</p>
                    <p className="text-primary">ITTIHADIYAH</p>
                </div>
            </div>
        </div>
    );
}
