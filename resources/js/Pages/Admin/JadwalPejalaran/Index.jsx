import ThemeLayout from "@/Theme/ThemeLayout";

export default function Index(props) {
    const { page } = props;
    const { title } = page;

    return (
        <ThemeLayout title={title}>
            <div className="overflow-hidden rounded-md shadow-lg">
                <div className="px-4 py-2 bg-white dark:bg-[#162231]">
                    <p className="text-xl font-bold text-gray-700 dark:text-white">
                        {title}
                    </p>
                </div>
            </div>
        </ThemeLayout>
    );
}
