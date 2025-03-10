import csv
import datetime
import pytz
import requests
import subprocess
import urllib
import uuid
import tkinter as tk

from flask import redirect, render_template, session
from functools import wraps
from PIL import ImageGrab



def apology(message, code=400):
    """Render message as an apology to user."""
    def escape(s):
        """
        Escape special characters.

        https://github.com/jacebrowning/memegen#special-characters
        """
        for old, new in [("-", "--"), (" ", "-"), ("_", "__"), ("?", "~q"),
                         ("%", "~p"), ("#", "~h"), ("/", "~s"), ("\"", "''")]:
            s = s.replace(old, new)
        return s
    return render_template("apology.html", top=code, bottom=escape(message)), code


def login_required(f):
    """
    Decorate routes to require login.

    http://flask.pocoo.org/docs/0.12/patterns/viewdecorators/
    """
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if session.get("user_id") is None:
            return redirect("/login")
        return f(*args, **kwargs)
    return decorated_function


def usd(value):
    """Format value as USD."""
    return f"${value:,.2f}"


def decimal(value):
    """Format value with 2 decimal places."""
    return f"{value:,.2f}"


def get_time():
    """Get current time in UTC"""
    return datetime.datetime.now(pytz.utc)


def get_date():
    """Get current date in UTC"""
    return datetime.datetime.now(pytz.utc).date()




