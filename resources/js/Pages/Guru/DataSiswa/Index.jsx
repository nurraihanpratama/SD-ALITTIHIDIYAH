import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import DataSiswaDataTable from "./DataTable/DataSiswaDataTable";

export default function Index(props) {
    const { page, collection } = props;
    const { title } = page;
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />

            <DataSiswaDataTable collection={collection} />
        </ThemeLayout>
    );
}
