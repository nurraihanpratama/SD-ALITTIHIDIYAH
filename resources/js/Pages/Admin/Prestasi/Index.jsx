import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import PrestasiDataTable from "./Components/DataTable/PrestasiDataTable";

export default function Index(props) {
    const { page,collection } = props;
    const { title } = page;
    console.log(collection);
    
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} /> 
            <PrestasiDataTable collection={collection} />
        </ThemeLayout>
    );
}

