import { Fragment } from "react";
import { FiCodesandbox, FiTag } from "react-icons/fi";
import { FaDoorOpen } from "react-icons/fa6";
import { FaUserCircle, FaUsersCog } from "react-icons/fa";
import NavLink from "@/Theme/Components/NavLink/NavLink";
import { LuSchool } from "react-icons/lu";
import { PiStudentBold, PiUserFill } from "react-icons/pi";
import { AiOutlineSchedule } from "react-icons/ai";
import { MdLibraryBooks, MdOutlineSportsGymnastics } from "react-icons/md";
import { GiJeweledChalice } from "react-icons/gi";
import { BsHouses } from "react-icons/bs";
import { RiNewspaperLine } from "react-icons/ri";

export default function AuthenticatedNavigations({ user }) {
    return (
        <Fragment>
            {/* dashboard */}
            <NavLink
                navRoute={route("admin.dashboard.index")}
                components={["admin.dashboard.index"]}
                label="Dashboard"
                icon={<FiCodesandbox />}
            />

            {/* Kelas */}
            <NavLink
                navRoute={route("admin.kelas.index")}
                components={["admin.kelas.index"]}
                label="Data Kelas"
                icon={<LuSchool />}
            />
            {/* Kelas */}
            <NavLink
                navRoute={route("admin.siswa.index")}
                components={["admin.siswa.index"]}
                label="Data Siswa"
                icon={<PiStudentBold />}
            />
            {/* Kelas */}
            <NavLink
                navRoute={route("admin.bidang-studi.index")}
                components={["admin.bidang-studi.index"]}
                label="Data Bidang Studi"
                icon={<MdLibraryBooks />}
            />
            {/* Kelas */}
            <NavLink
                navRoute={route("admin.jadwal-pelajaran.index")}
                components={["admin.jadwal-pelajaran.index"]}
                label="Data Jadwal Pelajaran"
                icon={<AiOutlineSchedule />}
            />
            {/* Kelas */}
            <NavLink
                navRoute={route("admin.pegawai.index")}
                components={["admin.pegawai.index"]}
                label="Data Pegawai"
                icon={<PiUserFill />}
            />
            {/* Kelas */}
            <NavLink
                navRoute={route("admin.prestasi.index")}
                components={["admin.prestasi.index"]}
                label="Data Prestasi"
                icon={<GiJeweledChalice />}
            />
            {/* Kelas */}
            <NavLink
                navRoute={route("admin.ekstrakurikuler.index")}
                components={["admin.ekstrakurikuler.index"]}
                label="Data Ekstrakurikuler"
                icon={<MdOutlineSportsGymnastics />}
            />
            {/* Kelas */}
            <NavLink
                navRoute={route("admin.fasilitas.index")}
                components={["admin.fasilitas.index"]}
                label="Data Fasilitas"
                icon={<BsHouses />}
            />
            {/* Kelas */}
            <NavLink
                navRoute={route("admin.berita.index")}
                components={["admin.berita.index"]}
                label="Data Berita"
                icon={<RiNewspaperLine />}
            />

            {/* <NavLink
                navRoute={route("my-profile.index", team_slug)}
                components={["my-profile.index"]}
                label="My Profile"
                icon={<FaUserCircle />}
            /> */}

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
