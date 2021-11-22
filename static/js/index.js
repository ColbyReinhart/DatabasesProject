new_order_button = document.querySelector("#new-order-button");
employee_options_button = document.querySelector("#employee-options-button");

new_order_button.addEventListener("click", (e) => {
    window.location.href = "/new_order";
});

employee_options_button.addEventListener("click", (e) => {
    window.location.href = "/employee_options";
});