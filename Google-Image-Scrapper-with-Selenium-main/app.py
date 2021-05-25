from flask import Flask, jsonify,request
import json
from selenium import webdriver
import time
import requests
import shutil
import os


app = Flask(__name__)


@app.route('/', methods=["POST"])
def query_strings():
    if request.method == "POST":
        ii={'url':[]}
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        name = request_data['name']
        value = request_data['value']
        user = os.getlogin()
        driver = webdriver.Chrome()
        directory = 'C:\\Users' + '\\' + user + '\Desktop'
        url = 'https://www.google.com/search?q=' + str(
            name) + '&source=lnms&tbm=isch&sa=X&ved=2ahUKEwie44_AnqLpAhUhBWMBHUFGD90Q_AUoAXoECBUQAw&biw=1920&bih=947'
        iterate =value
        driver.get(url)
        time.sleep(3)
        for j in range(1, iterate + 1):
            imgurl = driver.find_element_by_xpath(
                '//div//div//div//div//div//div//div//div//div//div[' + str(j) + ']//a[1]//div[1]//img[1]')
            imgurl.click()
            time.sleep(15)
            img = driver.find_element_by_xpath(
                '//body/div[2]/c-wiz/div[3]/div[2]/div[3]/div/div/div[3]/div[2]/c-wiz/div[1]/div[1]/div/div[2]/a/img').get_attribute(
                "src")
            try:
                filename = name + str(j) + '.jpg'
                response = requests.get(img, stream=True)
                image_path = os.path.join(directory, filename)
                ii['url'].append(str(img))

                #these two lines can be uncommented for storing images in system's desktop

                # with open(image_path, 'wb') as file:
                #     shutil.copyfileobj(response.raw, file)

            except Exception:
                pass
        driver.quit()
        return jsonify(json.dumps(ii))

if __name__ == '__main__':
    app.run('0.0.0.0',debug=True)