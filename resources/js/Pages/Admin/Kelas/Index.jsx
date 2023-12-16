import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import KelasDataTable from "./Components/DataTable/KelasDataTable";

export default function Index(props) {
    const { page,collection } = props;
    const { title } = page;
    console.log(collection);
    
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} /> 
            <KelasDataTable collection={collection} />
        </ThemeLayout>
    );
}

