// my-dashboard/src/pages/dashboard/Index.jsx

import React from "react";
import ThemeLayout from "@/Theme/ThemeLayout";
import ContentCard from "@/Theme/Components/ContentCard";
import { FiUser } from "react-icons/fi";

const Index = (props) => {
    const { page, dashboardData } = props;
    const { title } = page;

    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />
            <div className="overflow-hidden rounded-md shadow-lg bg-white dark:bg-[#162231] p-4 text-gray-700 dark:text-white">
                {/* Tampilkan jumlah data setiap tabel dalam bentuk kotak */}
                <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
                    {Object.entries(dashboardData).map(
                        ([label, count], index) => (
                            <div
                                key={label}
                                className="w-full h-full p-4 overflow-hidden text-center rounded-md shadow-md h-fit bg-primary-600" // Ganti nilai bg-green-500 dengan bg-green-400 atau bg-green-600
                            >
                                <div className="flex">
                                    <span className="flex items-center h-fit rounded-xl p-3 bg-white dark:bg-[#162231]">
                                        <FiUser size={50} />
                                    </span>
                                    <span className="flex flex-col items-center w-full">
                                        <p className="mb-2 text-lg font-semibold text-white">
                                            {label}
                                        </p>
                                        <p className="text-2xl font-bold text-white">
                                            {count}
                                        </p>
                                    </span>
                                </div>
                            </div>
                        )
                    )}
                </div>
            </div>
        </ThemeLayout>
    );
};

export default Index;
