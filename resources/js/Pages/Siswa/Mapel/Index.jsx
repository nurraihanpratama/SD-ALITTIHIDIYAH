import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";

export default function Index(props) {
    const { page, collection } = props;
    const { title } = page;

    console.log(page);
    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />
        </ThemeLayout>
    );
}
