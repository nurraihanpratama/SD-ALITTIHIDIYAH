import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import FasilitasDataTable from "./Components/DataTable/FasilitasDataTable";

export default function Index(props) {
    const { page,collection } = props;
    const { title } = page;
    
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} /> 
            <FasilitasDataTable collection={collection} />
        </ThemeLayout>
    );
}

