import AppContext from "./Context/AppContext";
import { useState } from "react";

export default function AppContextProvider({ children }) {
    const currentState = {
        fullscreen: false,
    };

    const [appState, setAppState] = useState(currentState);

    const updateState = (newValue) => {
        const newTheme = {
            ...appState,
            ...newValue,
        };
        setAppState(newTheme);
    };

    return (
        <AppContext.Provider value={{ appState, updateState }}>
            {children}
        </AppContext.Provider>
    );
}
