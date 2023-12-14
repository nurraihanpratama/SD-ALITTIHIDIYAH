import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import SiswaDataTable from "./Components/DataTable/SiswaDataTable";

export default function Index(props) {
    const { page, collection } = props;
    const { title } = page;

    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />

            <SiswaDataTable collection={collection} withNewButton />
        </ThemeLayout>
    );
}
