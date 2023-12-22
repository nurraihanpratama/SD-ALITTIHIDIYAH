import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import EkstrakurikulerDataTable from "./Components/DataTable/EkstrakurikulerDataTable"; // Ganti dengan file yang sesuai untuk DataTable Ekstrakurikuler
import { Fragment, useEffect, useState } from "react";
import ProcessingLoader from "@/Theme/Components/ProcessingLoader";
import EkstrakurikulerForm from "./Components/Form/EkstrakurikulerForm"; // Import form Ekstrakurikuler yang sudah dimodifikasi
import Modal from "@/Theme/Components/Modal";

export default function Index(props) {
    const { page, collection } = props;
    const { title } = page;

    const [processing, setProcessing] = useState(false);
    const [showCreateForm, setShowCreateForm] = useState(false);

    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />

            <EkstrakurikulerDataTable
                collection={collection}
                onClickNew={() => setShowCreateForm(true)} // Ganti dengan aksi yang sesuai untuk form Ekstrakurikuler
                withNewButton
            />

            <Fragment>
                <Modal visible={processing} setVisible={setProcessing} noescape>
                    <ProcessingLoader visible={processing} />
                </Modal>
                <Modal
                    visible={showCreateForm}
                    setVisible={setShowCreateForm}
                    noescape
                >
                    <EkstrakurikulerForm
                        action="create"
                        closeForm={() => setShowCreateForm(false)}
                    />
                </Modal>
            </Fragment>
        </ThemeLayout>
    );
}
