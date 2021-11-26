clock_in_button = document.querySelector("#clock-in");
clock_out_button = document.querySelector("#clock-out");
employee_id_input = document.querySelector("#employee-id-input");

let bad_flash = (elem) => {
    elem.classList.add("bad-flash");
    setTimeout(() => {
        elem.classList.remove("bad-flash");
    }, 1000);
}

clock_in_button.addEventListener("click", async (e) => {
    if (employee_id_input.value != "") {
        let res = await fetch("/api/clock", {
            method: 'POST',
            headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                clockType: "in",
                employeeID: employee_id_input.value
            })
        });
        employee_id_input.value = "";
    } else {
        bad_flash(employee_id_input);
    }
});

clock_out_button.addEventListener("click", async (e) => {
    if (employee_id_input.value != "") {
        let res = await fetch("/api/clock", {
            method: 'POST',
            headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                clockType: "out",
                employeeID: employee_id_input.value
            })
        });
        employee_id_input.value = "";
    } else {
        bad_flash(employee_id_input);
    }
});