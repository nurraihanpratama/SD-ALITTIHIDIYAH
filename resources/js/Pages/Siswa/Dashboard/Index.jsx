// my-dashboard/src/pages/dashboard/Index.jsx

import React from "react";
import ThemeLayout from "@/Theme/ThemeLayout";
import ContentCard from "@/Theme/Components/ContentCard";

const Index = (props) => {
    const { page, dashboardData } = props;
    const { title } = page;

    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />
            <div className="overflow-hidden rounded-md shadow-lg bg-white dark:bg-[#162231] p-4 text-gray-700 dark:text-white">
                <div className="w-full rounded-md">
                    <div className="w-1/3">
                        <p>test</p>
                    </div>
                </div>
                {/* Tampilkan jumlah data setiap tabel dalam bentuk kotak */}
            </div>
        </ThemeLayout>
    );
};

export default Index;
