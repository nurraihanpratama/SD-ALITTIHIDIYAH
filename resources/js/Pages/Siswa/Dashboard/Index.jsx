import ThemeLayout from "@/Theme/ThemeLayout";
import ContentCard from "@/Theme/Components/ContentCard";
import Avatar from "react-avatar";

export default function Index(props) {
    const { page, dashboardData, auth } = props;
    const { user } = auth;
    const { title } = page;

    console.log(user);
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />
            <div className="overflow-hidden rounded-md shadow-lg bg-white dark:bg-[#162231] p-4 text-gray-700 dark:text-white">
                <div className="flex w-full gap-6 rounded-md">
                    <div className="w-1/3 ">
                        <div className="flex gap-4">
                            <Avatar name={user.nama} round size={100} />
                            <div className="flex flex-col justify-center">
                                <span className="text-xl font-bold">
                                    <p>{user.nama}</p>
                                </span>
                                <span className="text-sm font-thin">
                                    <p>{user.email}</p>
                                </span>
                            </div>
                        </div>
                        <hr className="my-2" />
                        <div className="flex flex-col items-center justify-center">
                            <h5>Personal Information</h5>
                        </div>
                        <div className="grid grid-cols-2 gap-2">
                            <p className="text-right">Nama Lengkap :</p>
                            <p>test</p>
                        </div>
                        <div className="grid grid-cols-2 gap-2">
                            <p className="text-right">Alamat :</p>
                            <p>test</p>
                        </div>
                        <div className="grid grid-cols-2 gap-2">
                            <p className="text-right">No. Hp :</p>
                            <p>test</p>
                        </div>
                    </div>
                    <div className="w-2/3">
                        <span className="flex items-center justify-center text-xl font-bold">
                            <p>Jadwal Pelajaran</p>
                        </span>
                        <hr className="my-2" />
                        <div className="w-full">
                            <table className="w-full">
                                <thead>
                                    <tr key="">
                                        <th>1</th>
                                        <th>2</th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </ThemeLayout>
    );
}
