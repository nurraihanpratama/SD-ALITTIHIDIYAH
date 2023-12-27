import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import UserDataTable from "./Components/DataTable/UserDataTable";

export default function Index(props) {
    const { page, collection } = props;

    const { title } = page;

    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />

            <UserDataTable collection={collection} />
        </ThemeLayout>
    );
}
