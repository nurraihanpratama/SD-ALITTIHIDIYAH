import { Dialog, Transition } from "@headlessui/react";
import { Fragment, useRef, useState } from "react";

export default function Modal({
    visible,
    setVisible,
    noescape = false,
    width = "w-full lg:w-fit",
    children,
}) {
    let _closeModal = useRef(null);

    function closeModal() {
        if (!noescape) {
            setVisible(false);
        }
    }

    function openModal() {
        setVisible(true);
    }

    return (
        <Transition appear show={visible} as={Fragment}>
            <Dialog
                as="div"
                className="relative z-10"
                onClose={closeModal}
                initialFocus={_closeModal}
            >
                <Transition.Child
                    as={Fragment}
                    enter="ease-out duration-100"
                    enterFrom="opacity-0"
                    enterTo="opacity-100"
                    leave="ease-in duration-100"
                    leaveFrom="opacity-100"
                    leaveTo="opacity-0"
                >
                    <div className="fixed inset-0 bg-black/80" />
                </Transition.Child>

                <div className="fixed inset-0 overflow-y-auto">
                    <div className="flex items-center justify-center min-h-full p-4 text-center">
                        <Transition.Child
                            as={Fragment}
                            enter="ease-out duration-100"
                            enterFrom="opacity-0 scale-95"
                            enterTo="opacity-100 scale-100"
                            leave="ease-in duration-100"
                            leaveFrom="opacity-100 scale-100"
                            leaveTo="opacity-0 scale-95"
                        >
                            <Dialog.Panel className={width}>
                                {/* <Dialog.Panel className="w-full lg:w-fit"> */}
                                {children}
                                <button
                                    hidden
                                    ref={_closeModal}
                                    onClick={() => {}}
                                />
                            </Dialog.Panel>
                        </Transition.Child>
                    </div>
                </div>
            </Dialog>
        </Transition>
    );
}
