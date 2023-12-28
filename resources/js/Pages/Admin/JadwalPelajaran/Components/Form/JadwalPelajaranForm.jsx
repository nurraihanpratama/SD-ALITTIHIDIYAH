import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import { useForm } from "@inertiajs/react";
import KelasSelection from "./KelasSelection";
import { useState } from "react";
import FormTextInput from "@/Theme/Form/FormTextInput";
import PrimaryButton from "@/Theme/Components/Buttons/PrimaryButton";
import { FaMinus, FaPlus } from "react-icons/fa6";
export default function JadwalPelajaranForm({ action, row = null, closeForm }) {
    const [inputCount, setInputCount] = useState(2);
    const [kelas, setKelas] = useState(null);

    const form = useForm({
        id_guru: row?.id_guru ?? "",
        id_mapel: row?.id_mapel ?? "",
    });

    function headerTitle() {
        if (action == "create") return "Tambah data Jadwal Pelajaran";
        if (action == "update") return "Ubah data Jadwal Pelajaran";
    }

    const handleAddInput = () => {
        setInputCount((prevCount) => prevCount + 1);
    };

    const handleRemoveInput = () => {
        if (inputCount > 0) {
            setInputCount((prevCount) => prevCount - 1);
        }
    };
    return (
        <StandardFormModalTemplate
            title={headerTitle()}
            closeForm={closeForm}
            processing={form.processing}
        >
            <div className="block py-4">
                <KelasSelection
                    title="Pilih Kelas"
                    form={form}
                    kelas={kelas}
                    setKelas={setKelas}
                />
                <hr className="my-4 border-gray-300 dark:border-gray-700" />
                {/* Membuat FormTextInput sebanyak inputCount */}
                <div className="flex flex-col gap-4">
                    {Array.from({ length: inputCount }, (_, index) => (
                        <div key={index} className="flex gap-4">
                            <FormTextInput
                                label="Pilih Mapel"
                                name={`id_mapel_${index}`}
                            />
                            <FormTextInput
                                label="Pilih Guru"
                                name={`id_guru_${index}`}
                            />
                        </div>
                    ))}
                </div>
                <div className="flex justify-end gap-2 py-4">
                    <PrimaryButton
                        onClick={handleRemoveInput}
                        deleteAction={true}
                    >
                        <FaMinus />
                    </PrimaryButton>
                    <PrimaryButton onClick={handleAddInput}>
                        <FaPlus />
                    </PrimaryButton>
                </div>
            </div>
        </StandardFormModalTemplate>
    );
}
