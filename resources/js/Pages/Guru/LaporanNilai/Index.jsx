import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import LaporanNilaiDataTable from "./Components/DataTable/LaporanNilaiDataTable";

export default function Index(props) {
    const { page, collection } = props;

    const { title } = page;

    console.log(collection);
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />
            <LaporanNilaiDataTable collection={collection} />
        </ThemeLayout>
    );
}
