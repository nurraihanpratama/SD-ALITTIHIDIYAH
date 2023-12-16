import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import SiswaDataTable from "./Components/DataTable/SiswaDataTable";
import { Fragment, useState } from "react";
import ProcessingLoader from "@/Theme/Components/ProcessingLoader";
import SiswaForm from "./Components/Form/SiswaForm";
import Modal from "@/Theme/Components/Modal";

export default function Index(props) {
    const { page, collection } = props;
    const { title } = page;

    const [processing, setProcessing] = useState(false);
    const [showCreateForm, setShowCreateForm] = useState(false);

    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />

            <SiswaDataTable
                collection={collection}
                onClickNew={setShowCreateForm}
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
                    <SiswaForm
                        action="create"
                        closeForm={() => setShowCreateForm(false)}
                    />
                </Modal>
            </Fragment>
        </ThemeLayout>
    );
}
