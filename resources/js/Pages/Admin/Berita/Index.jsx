import ContentCard from "@/Theme/Components/ContentCard";
import ThemeLayout from "@/Theme/ThemeLayout";
import BeritaDataTable from "./Components/DataTable/BeritaDataTable"; // Sesuaikan dengan file yang sesuai untuk DataTable Berita
import { Fragment, useEffect, useState } from "react";
import ProcessingLoader from "@/Theme/Components/ProcessingLoader";
import BeritaForm from "./Components/Form/BeritaForm"; // Import form berita yang sudah dimodifikasi
import Modal from "@/Theme/Components/Modal";

export default function Index(props) {
  const { page, collection } = props;
  const { title } = page;

  const [processing, setProcessing] = useState(false);
  const [showCreateForm, setShowCreateForm] = useState(false);
  const [data, setData] = useState([]);

  const loadOptions = async () => {
    try {
      const response = await axios.get(route("admin.berita.create"));
      setData(response.data);
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  useEffect(() => {
    // Panggil loadOptions() saat komponen pertama kali dirender
    loadOptions();
  }, []);

  return (
    <ThemeLayout title={title}>
      <ContentCard title={title} />

      <BeritaDataTable
        collection={collection}
        loadOptions={data}
        onClickNew={() => setShowCreateForm(true)} // Ganti dengan aksi yang sesuai untuk form Berita
        withNewButton
      />

      <Fragment>
        <Modal visible={processing} setVisible={setProcessing} noescape>
          <ProcessingLoader visible={processing} />
        </Modal>
        <Modal visible={showCreateForm} setVisible={setShowCreateForm} noescape>
          <BeritaForm
            action="create"
            closeForm={() => setShowCreateForm(false)}
            loadOptions={data}
          />
        </Modal>
      </Fragment>
    </ThemeLayout>
  );
}
