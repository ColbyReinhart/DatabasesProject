let entrees_scroll = document.querySelector("#entrees-scroll");
let sides_scroll = document.querySelector("#sides-scroll");
let drinks_scroll = document.querySelector("#drinks-scroll");
let order_info_scroll = document.querySelector("#order-info-scroll");
let customer_name_input = document.querySelector("#customer-name")
let special_requests_input = document.querySelector("#special-requests")
let dine_in_order_button = document.querySelector("#dine-in-order");
let take_out_order_button = document.querySelector("#take-out-order");
let back_button = document.querySelector("#back");

let order;
let dishes, entrees, sides, drinks;
let current_order_id;

let initialize_page = () => {
    order = {
        items: {},
        price: 0
    }
    customer_name_input.value = "";
    special_requests_input.value = "";
}

initialize_page();

let update_order = () => {
    while (order_info_scroll.firstChild) {
        order_info_scroll.removeChild(order_info_scroll.firstChild);
    }
    for (let [item, info] of Object.entries(order.items)) {
        let node = document.createElement("h1");
        node.classList.add("medium");
        node.classList.add("outset");
        node.classList.add("card");
        let text = document.createTextNode(`${info.quantity}x ${item} $${info.price}`);
        node.appendChild(text);
        order_info_scroll.appendChild(node);
    }
}

let populate_scroll = (scroll, arr) => {
    for (let elem of arr) {
        let node = document.createElement("h1");
        node.classList.add("medium");
        node.classList.add("outset");
        node.classList.add("card");
        let name = document.createTextNode(`${elem.dishName}`);
        let br = document.createElement("br");
        let price = document.createTextNode(`$${elem.price}`);
        node.appendChild(name);
        node.appendChild(br);
        node.appendChild(price);
        if (elem.canMake) {
            node.classList.add("clickable");
            node.addEventListener("click", (e) => {
                if (order.items[elem.dishName] === undefined) {
                    order.items[elem.dishName] = {quantity: 1, price: elem.price};
                } else {
                    order.items[elem.dishName].quantity++;
                }
                order.price += parseFloat(elem.price);
                update_order();
            });
        } else {
            node.classList.add("disabled");
        }
        scroll.appendChild(node);
    }
}

let load_dishes = async () => {
    let res = await fetch("/api/dishes");
    dishes = await res.json();
    entrees = dishes.filter( (dish) => { return dish.dishType == "entree"; } );
    sides = dishes.filter( (dish) => { return dish.dishType == "side"; } );
    drinks = dishes.filter( (dish) => { return dish.dishType == "drink"; } );
    populate_scroll(entrees_scroll, entrees);
    populate_scroll(sides_scroll, sides);
    populate_scroll(drinks_scroll, drinks);
}

let get_dish_id = (dishName) => {
    return dishes.filter( (dish) => { return dish.dishName == dishName; } )[0].dishID;
}

load_dishes();

let create_order = async (orderType) => {
    let res = await fetch("/api/create_order", {
        method: 'POST',
        headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            orderType: orderType,
            totalPrice: order.price,
            customerName: customer_name_input.value,
            specialRequests: special_requests_input.value,
        })
    });
    let res_json = await res.json();
    return new Promise((resolve) => {
        resolve(res_json.orderID);
    });
}

let add_item_to_order = async (orderID, item, quantity) => {
    let res = await fetch("/api/add_dish", {
        method: 'POST',
        headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            orderID: orderID, 
            dishID: get_dish_id(item), 
            dishQuantity: quantity
        })
    });
}

let add_items_to_order = async (orderID, order) => {
    for (let [item, info] of Object.entries(order.items)) {
        console.log("adding ", item);
        await add_item_to_order(orderID, item, info.quantity);
    }
}

let bad_flash = (elem) => {
    elem.classList.add("bad-flash");
    setTimeout(() => {
        elem.classList.remove("bad-flash");
    }, 1000);
}

dine_in_order_button.addEventListener("click", async (e) => {
    if (customer_name_input.value != "") {
        current_order_id = await create_order("dine in");
        console.log("just created orderID: ", current_order_id);
        add_items_to_order(current_order_id, order);
        initialize_page();
        update_order();
    } else {
        bad_flash(customer_name_input);
    }
});

take_out_order_button.addEventListener("click", async (e) => {
    if (customer_name_input.value != "") {
        current_order_id = await create_order("take out");
        console.log("just created orderID: ", current_order_id);
        add_items_to_order(current_order_id, order);
        initialize_page();
        update_order();
    } else {
        bad_flash(customer_name_input);
    }
});

back_button.addEventListener("click", (e) => {
    window.location.href = "/";
});