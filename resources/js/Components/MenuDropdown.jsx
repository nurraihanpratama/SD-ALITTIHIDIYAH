import { useState, useRef, useEffect } from "react";
import { Menu, Transition } from "@headlessui/react";
import { Fragment } from "react";
import { BsThreeDots } from "react-icons/bs";

export default function MenuDropdown({ children }) {
    const [menuPosition, setMenuPosition] = useState({ top: 0, right: 0 });
    const menuButtonRef = useRef(null);

    useEffect(() => {
        function updateMenuPosition() {
            if (menuButtonRef.current) {
                const buttonRect =
                    menuButtonRef.current.getBoundingClientRect();
                const windowHeight = window.innerHeight;
                const right = window.innerWidth - buttonRect.right;

                let a = 0;

                if (buttonRect.y < 10) {
                    a = 100;
                } else if (windowHeight - buttonRect.bottom <= 200) {
                    a = 220;
                }

                const top = buttonRect.bottom - a;

                // console.log(buttonRect)
                // console.log(windowHeight)

                setMenuPosition({ top, right });
            }
        }

        updateMenuPosition(); // Initialize the position
    }, []);

    return (
        <Menu as="div">
            {({ open, close }) => {
                if (open) window.addEventListener("scroll", close);
                return (
                    <Fragment>
                        <Menu.Button
                            ref={menuButtonRef}
                            className="flex-center gap-2 font-semibold px-4 py-1 rounded-md button-shadow text-gray-600 dark:text-white dark:bg-[#0B1727]"
                        >
                            <BsThreeDots />
                        </Menu.Button>
                        <Transition
                            as={Fragment}
                            enter="transition ease-out duration-100"
                            enterFrom="transform opacity-0 scale-95"
                            enterTo="transform opacity-100 scale-100"
                            leave="transition ease-in duration-75"
                            leaveFrom="transform opacity-100 scale-100"
                            leaveTo="transform opacity-0 scale-95"
                        >
                            <Menu.Items className="absolute z-10 w-56 mt-0 text-white origin-top-right divide-y divide-gray-100 rounded-md shadow-lg righxt-0 ring-1 ring-black ring-opacity-5 focus:outline-none bg-slate-700 dark:bg-white dark:text-gray-700 ">
                                <div className="px-1 py-1 ">{children}</div>
                            </Menu.Items>
                            {/* <Menu.Items
                static
                // style={{
                //   top: `${menuPosition.top}px`,
                // }}
                className="absolute z-10 w-56 mt-2 text-white origin-top-right divide-y divide-gray-100 rounded-md shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none bg-slate-700 dark:bg-white dark:text-gray-700 "
              >
                <div className="px-1 py-1">{children}</div>
              </Menu.Items> */}
                        </Transition>
                    </Fragment>
                );
            }}
        </Menu>
    );
}
