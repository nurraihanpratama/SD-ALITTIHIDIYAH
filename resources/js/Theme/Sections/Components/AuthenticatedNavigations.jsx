import { Fragment } from "react";
import { FiCodesandbox, FiTag } from "react-icons/fi";
import {
    FaBook,
    FaBookAtlas,
    FaBookOpen,
    FaDoorOpen,
    FaServer,
    FaUsers,
} from "react-icons/fa6";
import { FaChalkboardTeacher, FaUserCircle, FaUsersCog } from "react-icons/fa";
import NavLink from "@/Theme/Components/NavLink/NavLink";
import { LuSchool } from "react-icons/lu";
import { PiStudentBold, PiUserFill } from "react-icons/pi";
import { AiOutlineSchedule } from "react-icons/ai";
import { MdLibraryBooks, MdOutlineSportsGymnastics } from "react-icons/md";
import { GiJeweledChalice } from "react-icons/gi";
import { BsHouses } from "react-icons/bs";
import { RiNewspaperLine } from "react-icons/ri";
import NavLinkTree from "@/Theme/Components/NavLink/NavLinkTree";

export default function AuthenticatedNavigations({ user }) {
    // const isAdmin = user.role == "Admin";

    function isAdmin() {
        return user?.role == "Admin";
    }
    function isGuru() {
        return user?.role == "Guru";
    }
    function isSiswa() {
        return user?.role == "Siswa";
    }

    return (
        <Fragment>
            {/* dashboard */}
            {isAdmin() && (
                <NavLink
                    navRoute={route("admin.dashboard.index")}
                    components={["admin.dashboard.index"]}
                    label="Dashboard"
                    icon={<FiCodesandbox />}
                />
            )}

            {isAdmin() && (
                <NavLinkTree
                    components={[
                        "admin.kelas.index",
                        "admin.guru.index",
                        "admin.siswa.index",
                        "admin.bidang-studi.index",
                        "admin.pegawai.index",
                        "admin.prestasi.index",
                        "admin.ekstrakurikuler.index",
                        "admin.fasilitas.index",
                        "admin.berita.index",
                    ]}
                    label="Data Master"
                    icon={<FaServer />}
                    childs={[
                        {
                            label: "Data Guru",
                            icon: <FaChalkboardTeacher />,
                        },
                    ]}
                />
            )}

            {/* Kelas */}
            {isAdmin() && (
                <NavLink
                    navRoute={route("admin.kelas.index")}
                    components={["admin.kelas.index"]}
                    label="Data Kelas"
                    icon={<LuSchool />}
                />
            )}

            {/* guru */}
            {isAdmin() && (
                <NavLink
                    navRoute={route("admin.guru.index")}
                    components={["admin.guru.index"]}
                    label="Data Guru"
                    icon={<FaChalkboardTeacher />}
                />
            )}

            {/* siswa */}
            {isAdmin() && (
                <NavLink
                    navRoute={route("admin.siswa.index")}
                    components={["admin.siswa.index"]}
                    label="Data Siswa"
                    icon={<PiStudentBold />}
                />
            )}

            {/* bidang studi */}
            {isAdmin() && (
                <NavLink
                    navRoute={route("admin.bidang-studi.index")}
                    components={["admin.bidang-studi.index"]}
                    label="Data Bidang Studi"
                    icon={<MdLibraryBooks />}
                />
            )}

            {/* jadwal pelajaran */}
            {isAdmin() && (
                <NavLink
                    navRoute={route("admin.jadwal-pelajaran.index")}
                    components={["admin.jadwal-pelajaran.index"]}
                    label="Data Jadwal Pelajaran"
                    icon={<AiOutlineSchedule />}
                />
            )}

            {/* pegawai */}
            {isAdmin() && (
                <NavLink
                    navRoute={route("admin.pegawai.index")}
                    components={["admin.pegawai.index"]}
                    label="Data Pegawai"
                    icon={<PiUserFill />}
                />
            )}

            {/* prestasi */}
            {isAdmin() && (
                <NavLink
                    navRoute={route("admin.prestasi.index")}
                    components={["admin.prestasi.index"]}
                    label="Data Prestasi"
                    icon={<GiJeweledChalice />}
                />
            )}

            {/* ekstrakurikuler */}
            {isAdmin() && (
                <NavLink
                    navRoute={route("admin.ekstrakurikuler.index")}
                    components={["admin.ekstrakurikuler.index"]}
                    label="Data Ekstrakurikuler"
                    icon={<MdOutlineSportsGymnastics />}
                />
            )}

            {/* fasilitas */}
            {isAdmin() && (
                <NavLink
                    navRoute={route("admin.fasilitas.index")}
                    components={["admin.fasilitas.index"]}
                    label="Data Fasilitas"
                    icon={<BsHouses />}
                />
            )}

            {/* berita */}
            {isAdmin() && (
                <NavLink
                    navRoute={route("admin.berita.index")}
                    components={["admin.berita.index"]}
                    label="Data Berita"
                    icon={<RiNewspaperLine />}
                />
            )}

            {isGuru() && (
                <NavLink
                    navRoute={route("guru.dashboard.index")}
                    components={["guru.dashboard.index"]}
                    label="Dashboard"
                    icon={<FiCodesandbox />}
                />
            )}

            {/* Data Siswa */}
            {isGuru() && (
                <NavLink
                    navRoute={route("guru.data-siswa.index")}
                    components={["guru.data-siswa.index"]}
                    label="Data Siswa"
                    icon={<FaUsers />}
                />
            )}

            {/* Laporan Nilai */}
            {isGuru() && (
                <NavLink
                    navRoute={route("guru.laporan-nilai.index")}
                    components={["guru.laporan-nilai.index"]}
                    label="Data Nilai"
                    icon={<FaBook />}
                />
            )}

            {/* Punya Siswa */}
            {isSiswa() && (
                <NavLink
                    navRoute={route("siswa.dashboard.index")}
                    components={["siswa.dashboard.index"]}
                    label="Dashboard"
                    icon={<FiCodesandbox />}
                />
            )}

            {isSiswa() && (
                <NavLink
                    navRoute={route("siswa.data-nilai.index")}
                    components={["siswa.data-nilai.index"]}
                    label="Data Nilai Siswa"
                    icon={<FaBookOpen />}
                />
            )}

            {/* {isSiswa() && (
                <NavLink
                    navRoute={route("siswa.mapel.index")}
                    components={["siswa.mapel.index"]}
                    label="Data Mapel Siswa"
                    icon={<FaBook />}
                />
            )} */}
            <NavLink
                navRoute={route("my-profile.index")}
                components={["my-profile.index"]}
                label="My Profile"
                icon={<FaUserCircle />}
            />

            {/* LOGOUT */}
            <NavLink
                navRoute={route("logout")}
                components={["logout"]}
                label="Logout"
                method="post"
                as="button"
                icon={<FaDoorOpen />}
            />
        </Fragment>
    );
}
