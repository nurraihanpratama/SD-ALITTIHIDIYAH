import ThemeLayout from "@/Theme/ThemeLayout";
import Modal from "@/Theme/Components/Modal";
import { Fragment, useState } from "react";
import { useForm, usePage } from "@inertiajs/react";
import ContentCard from "@/Theme/Components/ContentCard";
import ProcessingLoader from "@/Theme/Components/ProcessingLoader";
import FormTextInput from "@/Theme/Form/FormTextInput";
import FormMobileInput from "@/Theme/Form/FormMobileInput";
import ActionButton from "@/Theme/Components/Buttons/ActionButton";
import { FaKey } from "react-icons/fa6";
import { FaSave } from "react-icons/fa";
import { onErrorFeedback, onSuccessFeedback } from "@/Helpers/formFeedback";
import MyProfileUpdatePasswordForm from "./MyProfileUpdatePasswordForm";

export default function Index() {
    const { page, auth } = usePage().props;

    const { user } = auth;

    const title = page.title;

    function getNama() {
        if (user?.role == "guru") return user?.guru.nama_guru;
        if (user?.role == "siswa") return user?.guru.nama_siswa;
    }

    const [processing, setProcessing] = useState(false);
    const [showUpdatePasswordForm, setShowUpdatePasswordForm] = useState(false);

    const form = useForm({
        nama: getNama() ?? "",
        email: user?.email ?? "",
    });

    const handleOnChange = (event) => {
        form.setData(event.target.name, event.target.value);
    };

    const update = (e) => {
        e.preventDefault();
        if (confirm("Yakin untuk update profile?")) {
            return form.post(route("my-profile.update", user.id), {
                preserveScroll: true,
                onSuccess: (response) => onSuccessFeedback(response),
                onError: onErrorFeedback,
            });
        }
    };

    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />

            <div className="w-fit rounded-lg px-4 py-4 bg-white dark:bg-[#162231]">
                <div className="max-w-md space-y-4 ">
                    {/* user_name */}
                    <FormTextInput
                        name="nama"
                        label="Nama"
                        value={form.data.nama}
                        onChange={handleOnChange}
                        error={form.errors.nama}
                    />

                    {/* email */}
                    <FormTextInput
                        name="email"
                        label="Email"
                        value={form.data.email}
                        onChange={handleOnChange}
                        error={form.errors.email}
                    />

                    {/* no_hp */}
                    {/* <FormMobileInput
                    name="no_hp"
                    label="Nomor HP/Kontak"
                    options={countrycodes}
                    codeValue={form.data.nohp_code}
                    onChangeCode={(val) => form.setData("nohp_code", val.id)}
                    value={form.data.no_hp}
                    onChange={handleOnChange}
                    error={form.errors.no_hp}
                    placeholder="Mohon isi nomor aktif"
                    maxLength={12}
                    required
                /> */}

                    <div className="gap-2 flex-end">
                        <ActionButton
                            label={
                                <div className="gap-1 flex-center">
                                    <FaKey />
                                    <p>Change Password</p>
                                </div>
                            }
                            action="delete"
                            onClick={() => setShowUpdatePasswordForm(true)}
                            disabled={processing}
                        />
                        <ActionButton
                            label={
                                <div className="gap-1 flex-center">
                                    <FaSave />
                                    <p>Update</p>
                                </div>
                            }
                            action="confirm"
                            onClick={update}
                            disabled={processing}
                        />
                    </div>
                </div>
            </div>

            <Fragment>
                <Modal visible={processing} setVisible={setProcessing} noescape>
                    <ProcessingLoader visible={processing} />
                </Modal>

                <Modal
                    visible={showUpdatePasswordForm}
                    setVisible={setShowUpdatePasswordForm}
                    noescape
                >
                    <MyProfileUpdatePasswordForm
                        action="update"
                        user={user}
                        closeForm={() => setShowUpdatePasswordForm(false)}
                    />
                </Modal>
            </Fragment>
        </ThemeLayout>
    );
}
