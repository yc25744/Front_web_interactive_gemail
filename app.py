from flask import Flask, render_template, request
from flask_mail import Mail, Message
import config
import os

app = Flask(__name__)

#https://security.google.com/settings/security/apppasswords to get app passwords for the mail

app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT=465,
    MAIL_USE_SSL=True,
    MAIL_USERNAME=config.EMAIL,
    MAIL_PASSWORD=config.PASSWORD,
)
mail = Mail(app)


@app.route("/")
def index():
    return render_template('main.html')

@app.route("/send_email/", methods=['POST'])
def send_email():
    try:
        msg = Message("Hello {}, Here is SADA U 3 project".format(request.form['name']), sender=config.EMAIL, recipients= [request.form['email']])
        #mail.html is created by beefree template online service
        msg.html = render_template('mail.html')
        mail.send(msg)
    except:
        return render_template('main.html', success=False, error=True)

    return render_template('main.html', success=True, error=False)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT",8080)))
