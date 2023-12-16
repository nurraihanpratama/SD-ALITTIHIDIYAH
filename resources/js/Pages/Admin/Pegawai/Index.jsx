import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import PegawaiDataTable from "./Components/DataTable/PegawaiDataTable";

export default function Index(props) {
    const { page,collection } = props;
    const { title } = page;
    console.log(collection);
    
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} /> 
            <PegawaiDataTable collection={collection} />
        </ThemeLayout>
    );
}

