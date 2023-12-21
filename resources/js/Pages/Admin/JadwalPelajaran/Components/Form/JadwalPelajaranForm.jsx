import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import { useForm } from "@inertiajs/react";
export default function JadwalPelajaranForm({ action, row = null, closeForm }) {
    const form = useForm({});

    function headerTitle() {
        if (action == "create") return "Tambah data Jadwal Pelajaran";
        if (action == "update") return "Ubah data Jadwal Pelajaran";
    }
    return (
        <StandardFormModalTemplate
            title={headerTitle()}
            closeForm={closeForm}
            processing={form.processing}
        >
            <div className="block w-full grid-cols-2 gap-4 space-y-4 text-gray-700 lg:space-y-0 lg:grid dark:text-white"></div>
        </StandardFormModalTemplate>
    );
}
