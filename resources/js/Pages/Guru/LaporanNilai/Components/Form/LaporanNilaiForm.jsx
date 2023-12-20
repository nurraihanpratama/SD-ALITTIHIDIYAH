import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";

export default function LaporanNilaiForm({ siswa }) {
    return (
        <StandardFormModalTemplate>
            <div className="w-full rounded-md shadow-lg overflow-auto bg-white dark:bg-[#121E2E]">
                <table className="w-full ">
                    <thead className="text-gray-700 dark:text-white bg-[#EDF2F9] dark:bg-[#232E3C]">
                        <tr>
                            <th>Nama Siswa</th>
                            <th>UH1</th>
                            <th>UH2</th>
                            <th>UH3</th>
                            <th>UTS</th>
                            <th>UAS</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </StandardFormModalTemplate>
    );
}
