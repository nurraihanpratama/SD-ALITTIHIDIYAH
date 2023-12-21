import { useState } from "react";
import Modal from "../../Modal";
import ModalCloseButton from "../../Buttons/ModalCloseButton";

export default function CellImageTemplate({
    filename,
    path,
    alt = null,
    className = null,
}) {
    const [visible, setVisible] = useState(false);
    if (filename) {
        return (
            <div>
                <img
                    src={`${path}${filename}`}
                    alt={alt}
                    onClick={() => setVisible(true)}
                    className={`cursor-pointer object-contain ${className}`}
                    width={100}
                />
                <Modal visible={visible} setVisible={setVisible}>
                    <div className="flex-center flex-col gap-4">
                        <img
                            src={`${path}${filename}`}
                            alt="zoom"
                            width={300}
                        />
                        <div className="flex-center gap-2">
                            <ModalCloseButton
                                onClick={() => setVisible(false)}
                            />
                            <p className="font-bold text-red-500">Close</p>
                        </div>
                    </div>
                </Modal>
            </div>
        );
    }
}
