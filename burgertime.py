from flask import Flask, render_template, jsonify, request
from flask.json import JSONEncoder
import mysql.connector
import datetime
from time import time

class CustomJSONEncoder(JSONEncoder):
    def default(self, obj):
        try:
            if isinstance(obj, datetime.datetime):
                return obj.strftime("%x %X %z")
            iterable = iter(obj)
        except TypeError:
            pass
        else:
            return list(iterable)
        return JSONEncoder.default(self, obj)

app = Flask(__name__)
app.json_encoder = CustomJSONEncoder

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/new_order")
def new_order():
    return render_template("order.html")

@app.route("/employee_options")
def employee_options():
    return render_template("employee.html")

@app.route("/api/clock", methods=["POST"])
def api_clock():
    res_json = request.json
    connection = mysql.connector.connect(host="burgertime.ejrobotics.com", database="burgertime", user="jt", password="Bungertime1")
    if connection.is_connected():
        cursor = connection.cursor(dictionary=True)
        vals = (res_json["employeeID"], res_json["clockType"])
        cursor.execute("INSERT INTO timeclock VALUES (%s, NOW(), %s);", vals)
        connection.commit()
        cursor.execute("SELECT MAX(orderID) AS orderID FROM customerOrder;")
        row = cursor.fetchone()
    return jsonify(row)

@app.route("/api/dishes")
def api_dishes():
    connection = mysql.connector.connect(host="burgertime.ejrobotics.com", database="burgertime", user="jt", password="Bungertime1")
    if connection.is_connected():
        cursor = connection.cursor(dictionary=True)
        cursor.execute("SELECT * FROM dishes WHERE canMakeDish(dishName);")
        dishes = cursor.fetchall()
    return jsonify(dishes)

@app.route("/api/create_order", methods=["POST"])
def api_create_order():
    res_json = request.json
    connection = mysql.connector.connect(host="burgertime.ejrobotics.com", database="burgertime", user="jt", password="Bungertime1")
    if connection.is_connected():
        cursor = connection.cursor(dictionary=True)
        vals = (res_json["orderType"], float(res_json["totalPrice"]), res_json["customerName"], res_json["specialRequests"])
        cursor.execute("INSERT INTO customerOrder (orderTime, orderType, totalPrice, customerName, specialRequests) VALUES (NOW(), %s, %s, %s, %s);", vals)
        connection.commit()
        cursor.execute("SELECT MAX(orderID) AS orderID FROM customerOrder;")
        row = cursor.fetchone()
    return jsonify(row)

@app.route("/api/clocks", methods=["GET"])
def api_clocks():
    connection = mysql.connector.connect(host="burgertime.ejrobotics.com", database="burgertime", user="jt", password="Bungertime1")
    if connection.is_connected():
        cursor = connection.cursor(dictionary=True)
        cursor.execute("SELECT employeeName, clockTime, clockType FROM staff NATURAL JOIN timeclock ORDER BY clockTime DESC;")
        clocks = cursor.fetchall()
    return jsonify(clocks)

@app.route("/api/add_dish", methods=["POST"])
def api_add_dish():
    res_json = request.json
    order_id = res_json["orderID"]
    dish_id = res_json["dishID"]
    dish_quantity = res_json["dishQuantity"]
    connection = mysql.connector.connect(host="burgertime.ejrobotics.com", database="burgertime", user="jt", password="Bungertime1")
    if connection.is_connected():
        cursor = connection.cursor(dictionary=True)
        vals = (order_id, dish_id, dish_quantity)
        cursor.execute("INSERT INTO orderItems (orderID, dishID, dishQuantity) VALUES (%s,%s,%s);", vals)
        connection.commit()
    return "200"

@app.route("/api/orders", methods=["GET"])
def api_orders():
    order_id = request.args.get("order_id")
    connection = mysql.connector.connect(host="burgertime.ejrobotics.com", database="burgertime", user="jt", password="Bungertime1")
    if connection.is_connected():
        cursor = connection.cursor(dictionary=True)
        if order_id is None:
            cursor.execute("SELECT * FROM customerOrder ORDER BY orderID DESC;")
            orders = cursor.fetchall()
            return jsonify(orders)
        else:
            cursor.execute("SELECT dishQuantity, dishName, dishType FROM orderItems NATURAL JOIN dishes WHERE orderID=%s ORDER BY dishType;", (order_id,))
            items = cursor.fetchall()
            return jsonify(items)
        
if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
