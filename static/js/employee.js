let clocks_scroll = document.querySelector("#clocks-scroll");
let employees_scroll = document.querySelector("#employees-scroll");
let clock_in_button = document.querySelector("#clock-in");
let clock_out_button = document.querySelector("#clock-out");
let employee_id_input = document.querySelector("#employee-id-input");
let orders_scroll = document.querySelector("#orders-scroll");
let back_button = document.querySelector("#back");
let inventory_item_select = document.querySelector("#inventory-item");
let inventory_item_delta_input = document.querySelector("#delta-quantity");
let inventory_add_button = document.querySelector("#add-button");

let bad_flash = (elem) => {
    elem.classList.add("bad-flash");
    setTimeout(() => {
        elem.classList.remove("bad-flash");
    }, 1000);
}

let populate_employees_scroll = async () => {
    let employees_res = await fetch("/api/employee_list");
    let employees = await employees_res.json();
    for (let employee of employees) {
        let node = document.createElement("h1");
        node.classList.add("outset");
        node.classList.add("card");
        node.classList.add("left-aligned");
        let name_node = document.createElement("p");
        name_node.classList.add("medium");
        let name_node_text = document.createTextNode(`[${employee.employeeID}] ${employee.employeeName}`);
        name_node.appendChild(name_node_text);
        node.appendChild(name_node);
        let position_node = document.createElement("p");
        position_node.classList.add("small");
        let position_node_text = document.createTextNode(`${employee.employeePosition}`);
        position_node.appendChild(position_node_text);
        node.appendChild(position_node);
        employees_scroll.appendChild(node);
    }
}

populate_employees_scroll();

let populate_clocks_scroll = (scroll, arr) => {
    while (scroll.firstChild) {
        scroll.removeChild(scroll.firstChild);
    }
    for (let elem of arr) {
        let node = document.createElement("h1");
        node.classList.add("small");
        node.classList.add("outset");
        node.classList.add("card");
        let card = document.createTextNode(`[${elem.clockType.toUpperCase()}] ${elem.employeeName}, ${elem.clockTime}`);
        node.appendChild(card);
        scroll.appendChild(node);
    }
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
        load_clocks();
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
        load_clocks();
    } else {
        bad_flash(employee_id_input);
    }
});

let load_clocks = async () => {
    let res = await fetch("/api/clocks");
    let clockTimes = await res.json();
    populate_clocks_scroll(clocks_scroll, clockTimes);
}

load_clocks();

let orders = [];

let load_orders = async () => {
    let orders_res = await fetch("/api/orders");
    orders = await orders_res.json();
    for (let order of orders) {
        let title = document.createElement("h1");
        title.classList.add("medium");
        title.classList.add("outset");
        title.classList.add("card");
        let title_text = document.createTextNode(`${order.customerName}, $${order.totalPrice}, ${order.orderTime}`);
        title.appendChild(title_text);
        let scroll_div = document.createElement("div");
        scroll_div.classList.add("vertical-scroll-div");
        scroll_div.classList.add("hidden-scrollbar");
        scroll_div.classList.add("wrapped");
        scroll_div.classList.add("inset");
        scroll_div.classList.add("card");
        title.appendChild(scroll_div);
        let items_res = await fetch(`/api/orders?order_id=${order.orderID}`);
        items = await items_res.json();
        for (let item of items) {
            console.log(item);
            let item_title = document.createElement("h1");
            item_title.classList.add("small");
            item_title.classList.add("outset");
            item_title.classList.add("card");
            let item_title_text = document.createTextNode(`${item.dishQuantity}x ${item.dishName}`);
            item_title.appendChild(item_title_text);
            let ingredients_res = await fetch(`/api/ingredients?dish_name=${item.dishName}`);
            let ingredients = await ingredients_res.json();
            for (let ingredient of ingredients) {
                let ingredient_node = document.createElement("p");
                ingredient_node.classList.add("tiny");
                let ingredient_text = document.createTextNode(`${ingredient.ingredientQuantity}x ${ingredient.unit != "self" ? ingredient.unit : ""} ${ingredient.inventoryName}`);
                ingredient_node.appendChild(ingredient_text);
                item_title.appendChild(ingredient_node);
            }
            scroll_div.appendChild(item_title);
        }
        let sub_text = document.createTextNode(`${order.orderType}, ${order.specialRequests}`);
        title.appendChild(sub_text);
        let remove_button = document.createElement("h1");
        remove_button.classList.add("small");
        remove_button.classList.add("clickable");
        remove_button.classList.add("outset");
        remove_button.classList.add("card");
        remove_button.appendChild(document.createTextNode("Remove"));
        console.log(order.orderID);
        remove_button.addEventListener("click", async () => {
            await fetch("/api/remove_order", {
                method: 'POST',
                headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    order_id: order.orderID
                })
            });
            orders_scroll.removeChild(title);
        });
        title.appendChild(remove_button);
        orders_scroll.appendChild(title);
    }
}

load_orders();

let load_inventory = async () => {
    let inventory_res = await fetch("/api/inventory");
    inventory = await inventory_res.json();
    for (let item of inventory) {
        let option = document.createElement("option");
        option.setAttribute("value", item.inventoryName)
        option.appendChild(document.createTextNode(`${item.inventoryName}`));
        inventory_item_select.appendChild(option);
    }
}

load_inventory();

inventory_add_button.addEventListener("click", async () => {
    let res = await fetch("/api/inventory", {
        method: 'POST',
        headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            deltaQuantity: inventory_item_delta_input.value,
            inventoryName: inventory_item_select.value
        })
    });
    inventory_item_delta_input.value = 0;
});

back_button.addEventListener("click", (e) => {
    window.location.href = "/";
})