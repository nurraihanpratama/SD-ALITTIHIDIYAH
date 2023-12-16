import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import { useForm } from "@inertiajs/react";
export default function PegawaiForm({ action, row = null, closeForm }) {
    const form = useForm({});
    return (
        <StandardFormModalTemplate
            title="Data Pegawai"
            closeForm={closeForm}
            processing={form.processing}
        >
            <div className="block w-full grid-cols-2 gap-4 space-y-4 text-gray-700 lg:space-y-0 lg:grid dark:text-white"></div>
        </StandardFormModalTemplate>
    );
}
