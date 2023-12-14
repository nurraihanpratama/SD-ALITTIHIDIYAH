import defaultTheme from "tailwindcss/defaultTheme";
import forms from "@tailwindcss/forms";
const colors = require("tailwindcss/colors");

/** @type {import('tailwindcss').Config} */
export default {
    content: [
        "./vendor/laravel/framework/src/Illuminate/Pagination/resources/views/*.blade.php",
        "./storage/framework/views/*.php",
        "./resources/views/**/*.blade.php",
        "./resources/js/**/*.jsx",
    ],

    theme: {
        extend: {
            fontFamily: {
                sans: ["Figtree", ...defaultTheme.fontFamily.sans],
                mono: ["Roboto Mono", ...defaultTheme.fontFamily.mono],
                poppins: ["Poppins", ...defaultTheme.fontFamily.sans],
                dancing: ["Dancing Script", ...defaultTheme.fontFamily.sans],
                lobster: ["Lobster", ...defaultTheme.fontFamily.sans],
                caprasimo: ["caprasimo", ...defaultTheme.fontFamily.sans],
                dotgothic16: ["DotGothic16", ...defaultTheme.fontFamily.sans],
            },
            screens: {
                xs: "475px",
                mobile: "360px",
                "3xl": "1600px",
                ...defaultTheme.screens,
            },
            colors: {
                primary: { ...colors.lime, DEFAULT: colors.lime[600] },
                secondary: { ...colors.purple, DEFAULT: colors.purple[500] },
                info: { ...colors.teal, DEFAULT: colors.teal[500] },
                danger: { ...colors.rose, DEFAULT: colors.rose[500] },
                disabled: { ...colors.gray, DEFAULT: colors.gray[300] },
                "dark-mode": { ...colors.amber, DEFAULT: colors.amber[500] },
                "light-mode": { ...colors.amber, DEFAULT: colors.amber[500] },
            },
            screens: {
                print: { raw: "print" },
            },
        },
    },

    darkMode: "class",
    plugins: [forms],
};
