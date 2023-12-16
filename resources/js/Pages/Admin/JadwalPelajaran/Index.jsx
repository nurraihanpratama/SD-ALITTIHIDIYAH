import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import JadwalPelajaranDataTable from "./Components/DataTable/JadwalPelajaranDataTable";

export default function Index(props) {
    const { page,collection } = props;
    const { title } = page;
    console.log(collection);
    
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} /> 
            <JadwalPelajaranDataTable collection={collection} />
        </ThemeLayout>
    );
}

