import os
import csv
import sqlite3
import tkinter as tk

from cs50 import SQL
from flask import Flask, flash, redirect, render_template, request, session, url_for
from flask_session import Session
from flask import url_for
from flask import send_file
from werkzeug.security import check_password_hash, generate_password_hash
from werkzeug.datastructures import CombinedMultiDict, MultiDict
from datetime import date
from PIL import ImageGrab
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from helpers import apology, usd, decimal
from fpdf import FPDF
from io import BytesIO
from pathlib import Path

# Configure application
app = Flask(__name__)

# Custom filter
app.jinja_env.filters["usd"] = usd
app.jinja_env.filters["decimal"] = decimal

# Configure session to use filesystem (instead of signed cookies)
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Configure to use SQL database
db = SQL("mysql://mapatton72:Roar1990!@mapatton72.mysql.pythonanywhere-services.com/mapatton72$prices")


@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response


@app.route("/")
def index():
    """Dashboard"""
    tday = date.today()
    today=tday.ctime()
    return render_template("index.html", today=today)


@app.route("/allitem", methods=["GET", "POST"])
def allitem():
    """All Items in Database"""
    if request.method == "POST":
        return render_template("allitem.html")
    else:
        items=db.execute("SELECT * FROM items ORDER BY category ASC;")
        return render_template("allitem.html", items=items)


@app.route("/msearch", methods=["GET", "POST"])
def msearch():
    """Search for item to modify"""

     # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        # Get description of item to search for
        xdesc=request.form.get("description")
        results=db.execute("SELECT * FROM items WHERE description LIKE ?", ('%' +xdesc+ '%'))
        #Check to see if item exists
        if not results:
            flash("Item not found")
            return render_template("msearch.html")
        else:
            # Pass results to list
            return render_template("mlist.html", results=results)
    else:
        return render_template("msearch.html")


@app.route("/mlist", methods=["GET", "POST"])
def mlist():
    """Choose Action for Selected Item on List"""

   # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # Find which item was checked
        item_id = request.form.get("selection")

        # Check if item was selected
        if not item_id:
            flash("Please select an item")
            return render_template("msearch.html")

        # Get all data for item
        select = db.execute("SELECT * FROM items WHERE id=?", item_id)
        # Pass item id
        session["item_id"] = item_id

        catlist=db.execute("SELECT category FROM catlist")
        categories=[row["category"] for row in catlist]
        loclist=db.execute("SELECT location FROM loclist")
        locations=[row["location"] for row in loclist]

        # Increment ButtonPressed (or perform any other action)
        if request.form['option'] == 'remove':
            return render_template("remove.html", select=select, item_id=item_id)
        elif request.form['option'] == 'change':
            mitem=db.execute("Select * FROM items WHERE id=?", item_id)
            return render_template("change.html", select=select, item_id=item_id, mitem=mitem, categories=categories, locations=locations)
        else:
            return render_template("update.html", select=select)
    else:
        return render_template("mlist.html")


@app.route("/addcat", methods=["GET", "POST"])
def addcat():
    """Add Categories to Database"""

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        new_category=request.form.get("category").capitalize()
        # Ensure information was submitted
        if not new_category:
            flash("must provide category")
            return redirect("/")
        if db.execute("SELECT * FROM catlist WHERE category = ?", new_category):
            flash("category already exists")
            return redirect("/")
        # Update database
        db.execute("INSERT INTO catlist (category) VALUES (?)", new_category)
        flash("Category Added")
        return redirect("/")
    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("addcat.html")


@app.route("/addloc", methods=["GET", "POST"])
def addloc():
    """Add Location to Database"""

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        new_location=request.form.get("location").capitalize()
        # Ensure information was submitted
        if not new_location:
            flash("must provide location")
            return redirect("/")
        if db.execute("SELECT * FROM loclist WHERE location = ?", new_location):
            flash("location already exists")
            return redirect("/")
        # Update database
        db.execute("INSERT INTO loclist (location) VALUES (?)", new_location)
        flash("Location Added")
        return redirect("/")
    # User reached route via GET (as by clicking a link or via redirect)
    else:
        return render_template("addloc.html")


@app.route("/additem", methods=["GET", "POST"])
def additem():
    """Add Item to Database"""

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        category=request.form.get("category").capitalize()
        description=request.form.get("description").capitalize()
        unit=request.form.get("unit").capitalize()
        price=float(request.form.get("price", "0.00"))
        location=request.form.get("location").capitalize()

        # Ensure information was submitted
        if not category:
            flash("must provide category")
        if not description:
            flash("must provide description")
        if not unit:
            flash("must provide unit")
        if not price:
            flash("must provide unit price")
        if not location:
            flash("must provide location")

        # Ensure price is a number
        if type(price) != float:
            flash("Must Be A Number")

        # Update database
        db.execute("INSERT INTO items (category, description, unit, price, location) VALUES (UPPER(?, ?, ?, ?, ?))", category, description, unit, price, location)

        flash("Item Added")
        return redirect("/")

# User reached route via GET (as by clicking a link or via redirect)
    else:
        catlist=db.execute("SELECT category FROM catlist")
        categories=[row["category"] for row in catlist]
        loclist=db.execute("SELECT location FROM loclist")
        locations=[row["location"] for row in loclist]
        return render_template("additem.html", categories=categories, locations=locations)


@app.route("/isearch", methods=["GET", "POST"])
def isearch():
    """search for Item in Database using search bar"""

     # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        # Get description of item to search for
        xdesc=request.form.get("description")
        results=db.execute("SELECT * FROM items WHERE description LIKE ?", ('%' +xdesc+ '%'))
        #Check to see if item exists
        if not results:
            flash("Item not found")
            return render_template("isearch.html")
        else:
            # Pass results to list
            return render_template("ilist.html", results=results)
    else:
        return render_template("index.html")


@app.route("/ilist", methods=["GET", "POST"])
def ilist():
    """Choose Action for Selected Item on List"""

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        return render_template("ilist.html")
    else:
        return render_template("index.html")


@app.route("/search", methods=["GET", "POST"])
def search():
    """
     search for Item in Database"""

     # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        # Get description of item to search for
        xdesc=request.form.get("description")
        results=db.execute("SELECT * FROM items WHERE description LIKE ?", ('%' +xdesc+ '%'))
        #Check to see if item exists
        if not results:
            flash("Item not found")
            return render_template("search.html")
        else:
            # Pass results to list
            return render_template("xlist.html", results=results)
    else:
        return render_template("search.html")


@app.route("/xlist", methods=["GET", "POST"])
def xlist():
    """Choose Action for Selected Item on List"""

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        est_name = session["est_name"]

        # Find which item was checked
        item_id = request.form.get("selection")

        # Check if item was selected
        if not item_id:
            flash("Please select an item")
            return render_template("search.html")

        # Get all data for item
        select = db.execute("SELECT * FROM items WHERE id=?", item_id)
        # Pass item id
        session["item_id"] = item_id
        # Increment ButtonPressed (or perform any other action)
        if request.form['option'] == 'estimate':
            return render_template("estname.html", select=select, item_id=item_id, est_name=est_name)
        elif request.form['option'] == 'remove':
            return render_template("remove.html", select=select, item_id=item_id)
        elif request.form['option'] == 'change':
            return render_template("change.html", select=select, item_id=item_id)
        else:
            return render_template("update.html", select=select)

    else:
        return render_template("xlist.html")


@app.route("/update", methods=["GET", "POST"])
def update():
    """Update Unit Price in Database"""

     # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        item_id=session["item_id"]
        new_price=request.form.get("price")
        db.execute("UPDATE items SET price = ? WHERE id = ?", new_price, item_id)
        bid_data=db.execute("SELECT * FROM items;")
        return render_template("allitem.html", items=bid_data)
    else:
        return render_template("update.html")


@app.route("/change", methods=["GET", "POST"])
def change():
    """Change Description, Unit or Location Item from Database"""

     # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        item_id=session["item_id"]
        category=request.form.get("category")
        description=request.form.get("description")
        unit=request.form.get("unit")
        price=float(request.form.get("price", "0.00"))
        location=request.form.get("location")

        # Ensure information was submitted
        if not category:
            flash("must provide category")
        if not description:
            flash("must provide description")
        if not unit:
            flash("must provide unit")
        if not price:
            flash("must provide unit price")
        if not location:
            flash("must provide location")

        # Ensure price is a number
        if type(price) != float:
            flash("Must Be A Number")

        db.execute("UPDATE items SET category = ?, description = ?, unit = ?, location = ? WHERE id = ?", new_category, new_description, new_unit, new_location, item_id)
        bid_data=db.execute("SELECT * FROM items;")
        return render_template("change.html", items=bid_data)
    else:
        catlist=db.execute("SELECT category FROM catlist")
        categories=[row["category"] for row in catlist]
        loclist=db.execute("SELECT location FROM loclist")
        locations=[row["location"] for row in loclist]
        return render_template("change.html", categories=categories, locations=locations)

@app.route("/remove", methods=["GET", "POST"])
def remove():
    """Change Description, Unit or Location Item from Database"""

     # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        item_id=session["item_id"]
        db.execute("DELETE FROM items WHERE id = ?", item_id)
        bid_data=db.execute("SELECT * FROM items;")
        return render_template("allitem.html", items=bid_data)
    else:
        return render_template("remove.html")


@app.route("/estbuild", methods=["GET", "POST"])
def estbuild():
    """create new estimate"""

    if request.method == "POST":
        # Name new table for estimate
        est_name = request.form.get("estname")
        #Check to see if entered name
        if not est_name:
            flash("must provide estimate name")
            return render_template("estbuild.html")
        #Check to see if name already exists
        if db.execute("SELECT * FROM estnamelist WHERE estname = ?", est_name):
            flash("estimate name already exists")
            return render_template("estbuild.html")
        # Add name and date to list of estimates
        tday = date.today()
        est_created=tday.ctime()
        db.execute("INSERT INTO estnamelist (estname, created) VALUES (?, ?)", est_name, est_created)
        #pass estimate name
        session["est_name"]=est_name

        return render_template("search.html", est_name=est_name)
    else:
        return render_template("estbuild.html")


@app.route("/estname", methods=["GET", "POST"])
def estname():
    """add items to cost estimate"""

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        # Name of estimate to add item to
        item_id=session["item_id"]
        est_name = session["est_name"]
        # Get data from items table
        get_desc=db.execute("SELECT description FROM items WHERE id=?", item_id)
        item_desc=get_desc[0]["description"]
        get_unit=db.execute("SELECT unit FROM items WHERE id=?", item_id)
        item_unit=get_unit[0]["unit"]
        get_price=db.execute("SELECT price FROM items WHERE id=?", item_id)
        item_price=get_price[0]["price"]

        db.execute("INSERT INTO estlist (estname,description,unit, price) VALUES (?, ?, ?, ?)", est_name, item_desc, item_unit, item_price)
        est_list = db.execute("SELECT * FROM estlist WHERE estname = ?", est_name)
        #add update date to estnamelist
        tday = date.today()
        est_updated=tday.ctime()
        db.execute("UPDATE estnamelist SET updated = ? WHERE estname = ?", est_updated, est_name)

        return render_template("estcheck.html", est_name=est_name, est_list=est_list)
    else:
        est_name = db.execute("SELECT DISTINCT estname FROM estlist ORDER BY estname")
        return render_template("allest.html", est_name=est_name)


@app.route("/allest", methods=["GET", "POST"])
def allest():
    """View individual cost estimate selected from list"""

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        est_name = request.form.get("selection")
        est_list=db.execute("SELECT * FROM estlist WHERE estname=?", est_name)
        estcreated = db.execute("SELECT created FROM estnamelist WHERE estname = ?", est_name)
        est_created=estcreated[0]["created"]
        estupdated = db.execute("SELECT updated FROM estnamelist WHERE estname = ?", est_name)
        est_updated=estupdated[0]["updated"]
        esttotal = db.execute("SELECT SUM(cost) FROM estlist WHERE estname = ?", est_name)
        est_total = esttotal[0]["SUM(cost)"]
        session["est_name"]=est_name

        if est_total == None:
            flash("No quantities entered for estimate")
            return redirect("/")

        return render_template("estimate.html", est_total=est_total, est_list=est_list, est_name=est_name, est_created=est_created, est_updated=est_updated)
    else:
        all_est = db.execute("SELECT DISTINCT estname FROM estlist ORDER BY estname")
        return render_template("allest.html", all_est=all_est)


@app.route("/estcheck", methods=["GET", "POST"])
def estcheck():
    """Get list of items for cost estimate"""

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        est_name=session["est_name"]

        # Check which button was pushed
        if request.form['option'] == 'additem':
            return render_template("search.html")
        else:
            i=0
            est_name=session["est_name"]
            est_list = db.execute("SELECT * FROM estlist WHERE estname = ?", est_name)
            est_len=len(est_list)
            # Get data for every column
            get_id = est_list[i]["id"]
            get_desc = est_list[i]["description"]
            get_unit = est_list[i]["unit"]
            get_price = est_list[i]["price"]
            get_qty = est_list[i]["quantity"]
            session["get_id"]=get_id
            session["i"]=i
            return render_template("estqty2.html", i=i, est_name=est_name, est_list=est_list, get_id=get_id, get_desc=get_desc, get_unit=get_unit, get_price=get_price, get_qty=get_qty)
    else:
        return render_template("index.html")


@app.route("/estqty", methods=["GET", "POST"])
def estqty():
    """Get quantities for cost estimate"""

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":

        i=session["i"]
        est_name=session["est_name"]
        est_list = db.execute("SELECT * FROM estlist WHERE estname = ?", est_name)
        est_len=len(est_list)
        # Get data for every column
        i=i+1
        get_id = est_list[i]["id"]
        get_desc = est_list[i]["description"]
        get_unit = est_list[i]["unit"]
        get_price = est_list[i]["price"]
        get_qty = est_list[i]["quantity"]
        session["get_id"]=get_id
        session["i"]=i
        return render_template("estqty2.html", i=i, est_name=est_name, est_list=est_list, get_id=get_id, get_desc=get_desc, get_unit=get_unit, get_price=get_price, get_qty=get_qty)
    else:
        i=session["i"]
        est_name=session["est_name"]
        est_list = db.execute("SELECT * FROM estlist WHERE estname = ?", est_name)
        est_len=len(est_list)
        # Get data for every column
        i=i+1
        get_id = est_list[i]["id"]
        get_desc = est_list[i]["description"]
        get_unit = est_list[i]["unit"]
        get_price = est_list[i]["price"]
        get_qty = est_list[i]["quantity"]
        session["get_id"]=get_id
        session["i"]=i
        return render_template("estqty2.html", i=i, est_name=est_name, est_list=est_list, get_id=get_id, get_desc=get_desc, get_unit=get_unit, get_price=get_price, get_qty=get_qty)


@app.route("/estqty2", methods=["GET", "POST"])
def estqty2():
    """Get and save quantity to database"""

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        est_name=session["est_name"]
        get_id=session["get_id"]
        i=session["i"]
        get_qty = request.form.get("quantity")
        # Add quantity and cost to table
        db.execute("UPDATE estlist SET quantity = ? WHERE id=?", get_qty, get_id)
        db.execute("UPDATE estlist SET cost = quantity * price WHERE id=?", get_id)
         #add update date to estnamelist
        tday = date.today()
        est_updated=tday.ctime()
        db.execute("UPDATE estnamelist SET updated = ? WHERE estname = ?", est_updated, est_name)
        #Count rows
        est_list = db.execute("SELECT * FROM estlist WHERE estname = ?", est_name)
        est_len=len(est_list)
        if i < est_len-1:
            return render_template("estqty.html", i=i, est_list=est_list)
        else:
            est_name=session["est_name"]
            esttotal = db.execute("SELECT SUM(cost) FROM estlist WHERE estname = ?", est_name)
            est_total = esttotal[0]["SUM(cost)"]
            return render_template("estimate.html", est_total=est_total, est_name=est_name, est_list=est_list)

    else:
        return render_template("index.html")


@app.route("/estimate", methods=["GET", "POST"])
def estimate():

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        est_name=session["est_name"]
        est_created = db.execute("SELECT created FROM estnamelist WHERE estname = ?", est_name)
        est_updated = db.execute("SELECT updated FROM estnamelist WHERE estname = ?", est_name)
        est_list = db.execute("SELECT * FROM estlist WHERE estname = ?", est_name)
        esttotal = db.execute("SELECT SUM(cost) FROM estlist WHERE estname = ?", est_name)
        est_total = esttotal[0]["SUM(cost)"]

         # Check which button was pushed
        if  request.form['option'] == 'pdf':
            est_name=session["est_name"]
            return redirect(url_for('.pdf', est_name=est_name))
        elif request.form['option'] == 'updateest':
            est_name=session["est_name"]
            return render_template("estcheck.html", est_name=est_name)
        else:
            est_name=session["est_name"]
            return render_template("removeest.html", est_name=est_name)
        return render_template("estimate.html", est_name=est_name, est_created=est_created, est_updated=est_updated, est_total=est_total, est_list=est_list)
    else:
        return render_template("index.html")


@app.route("/removeest", methods=["GET", "POST"])
def removeest():
    """Remove Item from Estimate"""

    # User reached route via POST (as by submitting a form via POST)
    if request.method == "POST":
        est_name=session["est_name"]
        db.execute("DELETE FROM estlist WHERE estname = ?", est_name)
        db.execute("DELETE FROM estnamelist WHERE estname = ?", est_name)
        all_est = db.execute("SELECT DISTINCT estname FROM estlist ORDER BY estname")
        return render_template("allest.html", all_est=all_est)
    else:
        return render_template("removeest.html")


@app.route("/upload", methods=["GET", "POST"])
def upload():
    """Upload CSV file to Database"""

    if request.method == "POST":
        # Check if the post request has the file part
        if 'file' not in request.files:
            flash("No file entered")
            return redirect(request.url)
        file = request.files['file']
        # If the user does not select a file, the browser submits an empty part without a filename.
        if file.filename == '':
            flash("No selected file")
            return redirect(request.url)

        if file:
            file.save(os.path.join("/home/mapatton72/estbid/uploads", file.filename))
            with open(os.path.join("/home/mapatton72/estbid/uploads", file.filename), "r") as file:
                reader = csv.reader(file)
                for row in reader:
                    db.execute("INSERT INTO items (category, description, unit, price, location) VALUES (?, ?, ?, ?, ?)", row[0], row[1], row[2], row[3], row[4])

            temp_cat = db.execute("SELECT DISTINCT category FROM items")
            categories = [row["category"] for row in temp_cat]
            for category in categories:
                db.execute("INSERT IGNORE INTO catlist (category) VALUES (?)", (category,))

            temp_loc = db.execute("SELECT DISTINCT location FROM items")
            locations = [row["location"] for row in temp_loc]
            for location in locations:
                db.execute("INSERT IGNORE INTO loclist (location) VALUES (?)", (location,))

            flash("File Uploaded")
            return redirect("/")
    else:
        return render_template("upload.html")


@app.route("/pdf", methods=["GET", "POST"])
def pdf():
    """Create PDF of Estimate"""
    if request.method == "GET":
        est_name = session["est_name"]
        est_list = db.execute("SELECT * FROM estlist WHERE estname = ?", est_name)
        est_total = db.execute("SELECT SUM(cost) FROM estlist WHERE estname = ?", est_name)[0]["SUM(cost)"]
        tday = date.today()
        pdf_date=tday.ctime()

        # Create PDF object
        pdf = FPDF()

        # Add a page
        pdf.add_page()

        # Set font and size
        pdf.add_font('Arial', '', '/home/mapatton72/estbid/.fonts/Arial.ttf', uni=True)

        pdf.set_font('Arial', '', 6)


        # Add title
        pdf.cell(0, 10, f"Estimate: {est_name}", ln=True, align="C")
        pdf.cell(0, 10, f"Date: {pdf_date}", ln=True, align="C")

        # Table header
        pdf.set_font("Arial", size=6)
        pdf.cell(100, 10, "Item", border=1)
        pdf.cell(20, 10, "Quantity", border=1)
        pdf.cell(20, 10, "Price", border=1)
        pdf.cell(20, 10, "Cost", border=1)
        pdf.ln(10)

        # Table rows
        for item in est_list:
            pdf.cell(100, 10, item['description'], border=1)
            pdf.cell(20, 10, str(item['quantity']), border=1)
            pdf.cell(20, 10, f"${item['price']:,.2f}", border=1)  # Format as USD
            pdf.cell(20, 10, f"${item['cost']:,.2f}", border=1)  # Format as USD
            pdf.ln(10)

        # Add total
        pdf.cell(0, 10, f"Total: ${est_total:,.2f}", ln=True)

        # Save PDF file with estimate name
        pdf.output(f"/home/mapatton72/estbid/{est_name}.pdf")
        pdf.output("estimate.pdf")

        # View PDF
        return send_file(f"{est_name}.pdf", as_attachment=True, download_name=f"{est_name}.pdf")

    else:
        return render_template("index.html")




