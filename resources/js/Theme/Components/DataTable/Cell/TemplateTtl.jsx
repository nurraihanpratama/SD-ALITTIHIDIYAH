import { formatDate, localeDate } from "@/Helpers/helper";

export default function TemplateTtl({ row }) {
    return (
        <p className=" nowrap">
            {row.tempat_lahir}, {formatDate(row.tanggal_lahir, "DD MMMM YYYY")}
        </p>
    );
}
