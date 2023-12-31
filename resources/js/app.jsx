import "./bootstrap";
import "../css/app.css";

import "primereact/resources/themes/lara-light-indigo/theme.css";
import "primereact/resources/primereact.min.css";
import "primeicons/primeicons.css";

import { createRoot } from "react-dom/client";
import { createInertiaApp } from "@inertiajs/react";
import { StrictMode } from "react";
import { resolvePageComponent } from "laravel-vite-plugin/inertia-helpers";
import AppContextProvider from "./AppContextProvider";

const appName = import.meta.env.VITE_APP_NAME || "Laravel";

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) =>
        resolvePageComponent(
            `./Pages/${name}.jsx`,
            import.meta.glob("./Pages/**/*.jsx")
        ),
    setup({ el, App, props }) {
        const root = createRoot(el);

        root.render(
            <StrictMode>
                <AppContextProvider>
                    <App {...props} />
                </AppContextProvider>
            </StrictMode>
        );
    },
    progress: {
        color: "#53ece2",
    },
});
