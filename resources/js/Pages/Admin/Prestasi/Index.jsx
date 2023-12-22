import React, { Fragment, useEffect, useState } from "react";
import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import PrestasiDataTable from "./Components/DataTable/PrestasiDataTable"; // Ganti dengan file yang sesuai untuk DataTable Prestasi
import ProcessingLoader from "@/Theme/Components/ProcessingLoader";
import PrestasiForm from "./Components/Form/PrestasiForm"; // Import form prestasi yang sudah dimodifikasi
import Modal from "@/Theme/Components/Modal";
import axios from "axios"; // Pastikan untuk mengimpor axios jika belum

export default function PrestasiIndex(props) {
    const { page, collection } = props;
    const { title } = page;

    const [processing, setProcessing] = useState(false);
    const [showCreateForm, setShowCreateForm] = useState(false);

    return (
        <ThemeLayout title={title}>
            <ContentCard title={title} />

            <PrestasiDataTable
                collection={collection}
                onClickNew={() => setShowCreateForm(true)} // Ganti dengan aksi yang sesuai untuk form Prestasi
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
                    <PrestasiForm
                        action="create"
                        closeForm={() => setShowCreateForm(false)}
                    />
                </Modal>
            </Fragment>
        </ThemeLayout>
    );
}
