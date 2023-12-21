import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import BidangStudiDataTable from "./Components/DataTable/BidangStudiDataTable"; // Sesuaikan dengan file yang sesuai untuk DataTable Bidang Studi
import { Fragment, useEffect, useState } from "react";
import ProcessingLoader from "@/Theme/Components/ProcessingLoader";
import BidangStudiForm from "./Components/Form/BidangStudiForm"; // Import form Bidang Studi yang sudah dimodifikasi
import Modal from "@/Theme/Components/Modal";

export default function Index(props) {
    const { page, collection } = props;
    const { title } = page;

    const [processing, setProcessing] = useState(false);
    const [showCreateForm, setShowCreateForm] = useState(false);

    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />

            <BidangStudiDataTable
                collection={collection}
                onClickNew={() => setShowCreateForm(true)} // Ganti dengan aksi yang sesuai untuk form Bidang Studi
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
                    <BidangStudiForm
                        action="create"
                        closeForm={() => setShowCreateForm(false)}
                    />
                </Modal>
            </Fragment>
        </ThemeLayout>
    );
}
