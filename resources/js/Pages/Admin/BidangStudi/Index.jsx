import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import BidangStudiDataTable from "./Components/DataTable/BidangStudiDataTable";

export default function Index(props) {
    const { page,collection } = props;
    const { title } = page;
    
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} /> 
            <BidangStudiDataTable collection={collection} />
        </ThemeLayout>
    );
}

