from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/new_order")
def new_order():
    return "new order page"

@app.route("/employee_options")
def employee_options():
    return "employee options page"

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
