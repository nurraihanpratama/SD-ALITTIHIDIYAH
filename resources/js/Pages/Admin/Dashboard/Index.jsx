// my-dashboard/src/pages/dashboard/Index.jsx

import React from 'react';
import ThemeLayout from "@/Theme/ThemeLayout";

const Index = (props) => {
  const { page, dashboardData } = props;
  const { title } = page;

  return (
    <ThemeLayout title={title}>
      <div className="overflow-hidden rounded-md shadow-lg bg-white dark:bg-[#162231] p-4 text-gray-700 dark:text-white">
        <p className="text-xl font-bold mb-4">
          {title}
        </p>

        {/* Tampilkan jumlah data setiap tabel dalam bentuk kotak */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          {Object.entries(dashboardData).map(([label, count], index) => (
            <div
              key={label}
              className="bg-primary-600 p-4 rounded-md shadow-md text-center" // Ganti nilai bg-green-500 dengan bg-green-400 atau bg-green-600
            >
              <p className="text-lg font-semibold text-white mb-2">
                {label}
              </p>
              <p className="text-2xl font-bold text-white">{count}</p>
            </div>
          ))}
        </div>
      </div>
    </ThemeLayout>
  );
};

export default Index;
