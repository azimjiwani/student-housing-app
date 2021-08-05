from flask import Flask, jsonify, request
from flask_cors import CORS
import pymongo
import config
import json
from facebook_scraper import get_posts
from datetime import datetime
import requests
from bson.json_util import dumps

app = Flask(__name__)
app.config["DEBUG"] = True

# connection_url = 'mongodb+srv://{}:{}@cluster0.oz6gy.mongodb.net/test?retryWrites=true&w=majority'.format(config.username,config.password)

# connection_url = 'mongodb+srv://{}:{}@app-data.idcdy.mongodb.net/test?retryWrites=true&w=majority'.format(config.username,config.password)

# connection_url = 'mongodb+srv://{}:{}@app-data.nck60.mongodb.net/test?retryWrites=true&w=majority'.format(config.username,config.password)

connection_url = 'mongodb+srv://{}:{}@app-data.1cndm.mongodb.net/test?retryWrites=true&w=majority'.format(config.username,config.password)

client = pymongo.MongoClient(connection_url)
Database = client.get_database('fb_posts')

@app.route('/add-housing-posts/', methods=['POST'])
def add_housing_posts():
    fb_housing_posts = Database.fb_housing_posts
    content = request.get_json()
    post_data = fb_housing_posts.insert(content)
    return "success"

@app.route('/add-processed-posts/', methods=['POST'])
def add_processed_posts():
    fb_processed_posts = Database.fb_processed_posts
    content = request.get_json()
    post_data = fb_processed_posts.insert(content)
    return "success"

@app.route('/update-parsed-bool/', methods=['POST'])
def update_housing_posts():
    fb_housing_posts = Database.fb_housing_posts
    content = request.get_json()
    myquery = {"post_id": content['post_id']}
    newvalues = {"$set":{"parsed": content['parsed']}}
    fb_housing_posts.update_one(myquery,newvalues)
    return "success"

@app.route('/get-unprocessed-posts/', methods=['GET'])
def get_posts():
    fb_unprocessed_posts = Database.fb_housing_posts
    condition = {'parsed':False}
    output = []
    for post in fb_unprocessed_posts.find(condition):
        data = {
                key:post[key] if post[key] is not None else -1000
                    for key in [
                        'post_id','time','listing_title','listing_price','listing_location','post_text', 
                        'username','images_lowquality','available','post_url','parsed'
                    ]
                }
        output.append(data)
    return jsonify({'result' : output})

@app.route('/get-most-recent-post/', methods=['GET'])
def get_most_recent_post():
    fb_housing_posts = Database.fb_housing_posts
    latest = fb_housing_posts.find_one(sort=[( '_id', pymongo.DESCENDING )])
    if latest:
        data = {
                key:latest[key] if latest[key] is not None else -1000
                    for key in [
                        'post_id','time','listing_title','listing_price','listing_location','post_text', 
                        'username','images_lowquality','available','post_url','parsed'
                    ]
                }
        return json.dumps(data, indent = 4)
    else:
        data = {"post_id":None}
        return json.dumps(data, indent = 4)

@app.route('/display-latest-post/', methods=['GET'])
def display_latest_post():
    fb_processed_posts = Database.fb_processed_posts
    latest = fb_processed_posts.find_one(sort=[( '_id', pymongo.DESCENDING )])
    keys = list(latest)
    data = {
        key:latest[key] if latest[key] is not None else -1000
            for key in keys
         }
    return dumps(data, indent = 4)

@app.route('/get-search-results/', methods=['GET'])
def get_search_results():
    fb_processed_posts = Database.fb_processed_posts
    output = []

    for post in fb_processed_posts.find({
        "post_id":{"$exists":True},
        "listing_title":{"$exists":True},
        "price":{"$exists":True},
        "bed":{"$exists":True},
        "bath":{"$exists":True},
        "address":{"$exists":True},
        "post_url":{"$exists":True},
        "city" : {"$regex":"Waterloo, ON, Canada"}
        #"latitude":{"$exists":True},
        #"longitude":{"$exists":True}
        }):
        data = {
                key:post[key] if key in post else -1000
                    for key in [
                        'listing_title', 'price', 'bed', 'bath', 'address', 'post_text', 'post_url', 'lease', 'sublease',
                        'sublet', 'utilities', 'latitude', 'longitude', 'post_id','images_lowquality'
                    ]
                }
        output.append(data)
    return json.dumps(output, indent = 4)

@app.route('/get-all-processed-posts/', methods=['GET'])
def get_all_processed_posts():
    fb_processed_posts = Database.fb_processed_posts
    output = []
    for post in fb_processed_posts.find():
        data = {
                key:post[key] if key in post else -1000
                    for key in [
                        'listing_title', 'price', 'bed', 'bath', 'address', 'post_text', 'post_url', 'lease', 'sublease',
                        'sublet', 'utilities', 'latitude', 'longitude', 'post_id'
                    ]
                }
        output.append(data)
    return json.dumps(output, indent = 4)

if __name__ == '__main__':
    app.run()