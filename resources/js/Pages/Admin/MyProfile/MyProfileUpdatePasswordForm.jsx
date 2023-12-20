import StandardFormModalTemplate from "@/Theme/Components/ModalTemplates/StandardFormModalTemplate";
import { useForm } from "@inertiajs/react";
import { onErrorFeedback, onSuccessFeedback } from "@/Helpers/formFeedback";
import FormTextInput from "@/Theme/Form/FormTextInput";

export default function MyProfileUpdatePasswordForm({
    action,
    user = null,
    closeForm,
}) {
    function getFormTitle() {
        if (action === "update") return "Update Password";
    }

    const form = useForm({
        current_password: "",
        password: "",
        password_confirmation: "",
    });

    const handleOnChange = (event) => {
        form.setData(event.target.name, event.target.value);
    };

    const submit = (e) => {
        e.preventDefault();

        // return console.log(form.data)

        if (action === "update")
            if (confirm("Yakin untuk update password?")) {
                return form.patch(
                    route("my-profile.update-password", user.id),
                    {
                        onSuccess: (response) =>
                            onSuccessFeedback(response, closeForm()),
                        onError: onErrorFeedback,
                    }
                );
            }
    };
    return (
        <StandardFormModalTemplate
            title={getFormTitle()}
            closeForm={closeForm}
            processing={form.processing}
            submit={submit}
            submitBtnLabel="Update"
            leftSideNote="Tanda * wajib diisi"
        >
            <div className="space-y-4 w-full text-left">
                <FormTextInput
                    name="current_password"
                    label="Password Saat Ini *"
                    value={form.data.current_password}
                    onChange={handleOnChange}
                    error={form.errors.current_password}
                    required
                />
                <FormTextInput
                    name="password"
                    label="Password Baru *"
                    value={form.data.password}
                    onChange={handleOnChange}
                    error={form.errors.password}
                    required
                />
                <FormTextInput
                    name="password_confirmation"
                    label="Konfirmasi Password Baru *"
                    value={form.data.password_confirmation}
                    onChange={handleOnChange}
                    error={form.errors.password_confirmation}
                    required
                />
            </div>
        </StandardFormModalTemplate>
    );
}
