import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import EkstrakurikulerDataTable from "./Components/DataTable/EkstrakurikulerDataTable";

export default function Index(props) {
    const { page,collection } = props;
    const { title } = page;
    
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} /> 
            <EkstrakurikulerDataTable collection={collection} />
        </ThemeLayout>
    );
}

