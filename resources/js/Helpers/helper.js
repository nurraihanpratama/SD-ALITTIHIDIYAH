import dayjs from "dayjs";
import "dayjs/locale/id"; // Import the desired locale

export const getParameterFromUrl = (field, current_url = null) => {
    // Get the URL of the current page
    const currentUrl = current_url ?? window.location.href;
    // Create a URLSearchParams object from the query parameters of the URL
    const searchParams = new URLSearchParams(new URL(currentUrl).search);
    // Get the 'search' parameter value
    const fieldValue = searchParams.get(field);

    return fieldValue;
};

export const urlModifier = (current_url, parameter, query) => {
    const url = new URL(current_url);
    const search_params = url.searchParams;
    search_params.set(parameter, query);
    url.search = search_params.toString();
    return url.toString();
};

export const capitalize = (words) => {
    if (words) {
        var separateWord = words.toLowerCase().split(" ");
        for (var i = 0; i < separateWord.length; i++) {
            separateWord[i] =
                separateWord[i].charAt(0).toUpperCase() +
                separateWord[i].substring(1);
        }
        return separateWord.join(" ");
    } else {
        return "";
    }
};

export const uppercase = (words) => {
    if (words) {
        return words.toUpperCase();
    } else {
        return "";
    }
};

export const fDate = (date, separator = "/") => {
    return dayjs(date).format(`DD${separator}MM${separator}YYYY`);
};

export const fInt = (integer) => {
    const total = parseInt(integer ?? 0);
    const number = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    return number;
};

export const fCurrency = (integer) => {
    return parseFloat(integer).toLocaleString("id-ID");
};

export const moneyFormatter = (integer) => {
    const total = parseInt(integer);
    const number = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    return number;
};

export const localeDate = (date) => {
    dayjs.locale("id");
    return dayjs(date).locale("id").format("dddd, D MMM YYYY");
};

export const fullDate = (date) => {
    return dayjs(date).format("dddd, D MMM YYYY HH:mm:ss");
};

export const getIdFromSelectOption = (data, array, check, fallback) => {
    return data
        ? array.find((dt) => {
              return check ? dt.id == data : dt.old_id == data;
          }).id
        : fallback;
};

export const countProrateDays = (start_date) => {
    const start = dayjs(start_date, "YYYY-MM-DD");
    const end = dayjs(start_date, "YYYY-MM-DD").endOf("month");
    const count = end.diff(start, "days") + 1;
    return count;
};

export const insertFieldAfterThisField = (
    array,
    fieldToInsertAfter,
    newObj
) => {
    const index = array.findIndex((item) => item.field === fieldToInsertAfter);
    if (index !== -1) {
        array.splice(index + 1, 0, newObj);
    }
};

export const getRecommendDateForAdjustment = (subscription) => {
    if (
        subscription.unpaid_invoices &&
        subscription.unpaid_invoices.length > 0
    ) {
        return dayjs(subscription.unpaid_invoices[0].inv_date).format(
            "YYYY-MM-DD"
        );
    } else if (
        subscription.finished_invoices &&
        subscription.finished_invoices.length > 0
    ) {
        const last_finished_invoice_date = dayjs(
            subscription.finished_invoices[0].inv_date
        );
        const recommend_date = last_finished_invoice_date
            .add(1, "month")
            .startOf("month");
        return dayjs(recommend_date).format("YYYY-MM-DD");
    } else {
        return null;
    }
};

export const strictNumberValidation = (number) => {
    const isValidInteger = /^0$|^[1-9]\d*$/.test(number);

    if (isNaN(parseInt(number)) || !isValidInteger) {
        return false;
    }
    return true;
};

export const getMaxWidth = (width) => {
    // Given examples
    const A1 = 400;
    const B1 = 115;
    const A2 = 580;
    const B2 = 280;

    // Calculate the slope (m)
    const m = (B2 - B1) / (A2 - A1);

    // Calculate the y-intercept (b)
    const b = B1 - m * A1;

    // Function to calculate B for a given A
    const calculateB = (A) => m * A + b;

    // Test with A = 450
    const A_test = window.innerWidth;
    return calculateB(A_test);
};

export const fetchErrorCatch = (error, callback = null) => {
    if (callback && typeof callback === "function") {
        setProcessing(false);
    }

    return error.response.status == 422
        ? alert(error.response.data.msg)
        : alert(import.meta.env.VITE_SYSTEM_ERROR_MESSAGE);
};
