import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import BeritaDataTable from "./Components/DataTable/BeritaDataTable";

export default function Index(props) {
    const { page,collection } = props;
    const { title } = page;
    
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} /> 
            <BeritaDataTable collection={collection} />
        </ThemeLayout>
    );
}

