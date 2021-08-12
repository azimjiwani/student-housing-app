import re
import pymongo
import jsonify
import requests
import urllib.parse
import types
import config

url = "http://localhost:5000/get-unprocessed-posts/"
data = requests.get(url = url).json()

for post in data:
    post_id = post['post_id']
    parsed_dict = {}

    if ("looking to sublet" in post['post_text']) or ("looking to lease" in post['post_text']) or ("looking for" in post['post_text']) or ("Looking to sublet" in post['post_text']) or ("Looking to lease" in post['post_text']) or ("Looking for" in post['post_text']):
        continue

    if ("looking to sublet" in post['listing_title']) or ("looking to lease" in post['listing_title']) or ("looking for" in post['listing_title']) or ("Looking to sublet" in post['listing_title']) or ("Looking to lease" in post['listing_title']) or ("Looking for" in post['listing_title']):
        continue

    title_dict = {
         'bed': re.compile(r'\d+(?=\s+bed)|$',re.IGNORECASE),
         'bed1' : re.compile(r'\w+(?=/)|$',re.IGNORECASE),
         'rooms':re.compile(r'(\w+(?=\s+rooms))|$',re. IGNORECASE),
         'bath': re.compile(r'\d+(?=\s+bath)|$',re.IGNORECASE),
         'baths': re.compile(r'\d+(?=\s+baths)|$',re.IGNORECASE),
         'title_price': re.compile(r'[\d,\.]+|$'),
         'address': re.compile(r'\d+\s[A-z]+\s+(?:Avenue|Crescent|Lane|Road|Boulevard|Drive|Street|Ave|Cr|Dr|Rd|Blvd|Ln|St)\.?\b|$',re.IGNORECASE),
         'sublet': re.compile(r'(\w*sublet\w*)|$',re.IGNORECASE),
         'lease': re.compile(r'(\w*lease\w*)|$',re.IGNORECASE),
         'sublease': re.compile(r'(\w*sublease\w*)|$',re.IGNORECASE)

     }

    body_dict = {
        'utilities': re.compile(r'(?<=\butilities are\s)(\w+).group()|$',re.IGNORECASE),
        'address1': re.compile(r'\d+\s[A-z]+\s+(?:Avenue|Crescent|Lane|Road|Boulevard|Drive|Street|Ave|Cr|Dr|Rd|Blvd|Ln|St)\.?\b|$',re.IGNORECASE),
        'sublet1': re.compile(r'(\w*sublet\w*)|$',re.IGNORECASE),
        'lease1': re.compile(r'(\w*lease\w*)|$',re.IGNORECASE),
        'sublease1': re.compile(r'(\w*sublease\w*)|$',re.IGNORECASE)
    }

    for key, rx in title_dict.items():
        match = rx.search(post['listing_title'])
        if match is not None:
            if type(match) != re.Pattern:
                title_dict[key] = match.group()

    parsed_dict['listing_location'] = post['listing_location']


    match = re.compile(r'([\d\,\.]+)').search(post['listing_price'])
    if match is not None:
        if type(match) != re.Pattern:
            parsed_dict['price'] = match.group()

            try:
                if "," in parsed_dict['price']:
                    parsed_dict['price'] = parsed_dict['price'].replace(",","")
                    parsed_dict['price'] = float(parsed_dict['price'].replace("$",""))
                else:
                    parsed_dict['price'] = float(parsed_dict['price'].replace("$",""))
            except ValueError:
              print("didnt work")
              #continue

    for key, rx in body_dict.items():
        match = rx.search(post['post_text'])
        if match is not None:
            if type(match) != re.Pattern:
                body_dict[key] = match.group()

    for key in title_dict:
        if title_dict[key] != '':
            parsed_dict[key] = title_dict[key]

    for key in body_dict:
        if body_dict[key] != '':
            parsed_dict[key] = body_dict[key]

    for key in post:
        parsed_dict[key] = post[key]

    if ('title_price' in parsed_dict) and ('price' in parsed_dict):
        res = isinstance(parsed_dict['price'], float)
        if res:
            try:
                if "," in parsed_dict['title_price']:
                    parsed_dict['title_price'] = parsed_dict['title_price'].replace(",","")
                    parsed_dict['title_price'] = float(parsed_dict['title_price'].replace("$",""))
                else:
                    parsed_dict['title_price'] = float(parsed_dict['title_price'].replace("$",""))
            except ValueError:
              print("didnt work")

            try:
                if (parsed_dict['title_price'] <= parsed_dict['price']):
                    del parsed_dict['title_price']
                else:
                    parsed_dict['price'] = parsed_dict['title_price']
                    del parsed_dict['title_price']
            except TypeError:
              print("didnt work here")
              continue
        else:
            continue

    parsed_dict['listing_title'] = parsed_dict['listing_title'].title()

    if 'beds' in parsed_dict:
        if parsed_dict['bed']!= '' and parsed_dict['beds']:
            del parsed_dict['beds']
    if 'bed' in parsed_dict:
        parsed_dict['bed'] = float(parsed_dict['bed'])
    
    if 'baths' in parsed_dict:
        if parsed_dict['bath']!= '' and parsed_dict['baths']:
            del parsed_dict['baths']

    if 'bath' in parsed_dict:
        parsed_dict['bath'] = float(parsed_dict['bath'])

    if ('address' in parsed_dict) and ('address1' in parsed_dict):
        if (parsed_dict['address']!= '') and (parsed_dict['address'] != parsed_dict['address1']):
            del parsed_dict['address1']
    
    if ('address' not in parsed_dict) and ('address1' in parsed_dict):
        parsed_dict['address'] = parsed_dict.pop('address1')

    if 'address' in parsed_dict:
        parsed_dict['address'] = parsed_dict['address'].title()
        parsed_dict['address'] = str(parsed_dict['address'])
        address = parsed_dict['address'] + ', Waterloo, Ontario, Canada'
        address = address.replace(" ", "+")

        response = requests.get('https://maps.googleapis.com/maps/api/geocode/json?address='+ address + '&key=' + config.API_KEY)
        response = response.json()
        if len(response) > 0:
            parsed_dict['latitude'] = response['results'][0]['geometry']['location']['lat']
            parsed_dict['longitude'] = response['results'][0]['geometry']['location']['lng']

            campus_lat = 43.469761
            campus_long = -80.538811
            distance_url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&"
            response = requests.get(distance_url + 'origins=' + str(parsed_dict['latitude']) + ',' + str(parsed_dict['longitude']) + '&destinations=' + str(campus_lat) +',' + str(campus_long) + '&mode=driving' +'&key=' + config.API_KEY)
            try:
                campus_distance = response.json()['rows'][0]['elements'][0]['distance']['value']
                campus_distance = campus_distance
                parsed_dict['campus_distance'] = float(campus_distance)
            except KeyError:
                parsed_dict['campus_distance'] = 0      

            try:
                driving_time = response.json()['rows'][0]['elements'][0]['duration']['value']
                driving_time = driving_time / 60
                parsed_dict['car_time'] = round(driving_time)
            except KeyError:
                parsed_dict['car_time'] = 0

            response = requests.get(distance_url + 'origins=' + str(parsed_dict['latitude']) + ',' + str(parsed_dict['longitude']) + '&destinations=' + str(campus_lat) +',' + str(campus_long) + '&mode=transit' +'&key=' + config.API_KEY)
            
            try:   
                bus_time = response.json()['rows'][0]['elements'][0]['duration']['value']
                bus_time = bus_time / 60
                parsed_dict['bus_time'] = round(bus_time)
            except KeyError:
              print("bus failed")
              parsed_dict['bus_time'] = 0

            response = requests.get(distance_url + 'origins=' + str(parsed_dict['latitude']) + ',' + str(parsed_dict['longitude']) + '&destinations=' + str(campus_lat) +',' + str(campus_long) + '&mode=walking' +'&key=' + config.API_KEY)
            
            try:
                walk_time = response.json()['rows'][0]['elements'][0]['duration']['value']
                walk_time = walk_time / 60
                parsed_dict['walk_time'] = round(walk_time)
            except KeyError:
                parsed_dict['walk_time'] = 0


            
        parsed_dict['city'] = "Waterloo, ON, Canada"        
        

    ####

    if 'sublet' in parsed_dict:
        parsed_dict['sublet'] = True

    if 'lease' in parsed_dict:
        parsed_dict['lease'] = True

    if ('sublet' in parsed_dict) and ('sublet1' in parsed_dict):
        if (parsed_dict['sublet']!= '') and (parsed_dict['sublet'] != parsed_dict['sublet1']):
            del parsed_dict['sublet1']
            parsed_dict['sublet'] = True
    
    if ('sublet' not in parsed_dict) and ('sublet1' in parsed_dict):
        parsed_dict['sublet'] = parsed_dict.pop('sublet1')
        parsed_dict['sublet'] = True
    #####

    ####
    if ('lease' in parsed_dict) and ('lease1' in parsed_dict):
        if (parsed_dict['lease']!= '') and (parsed_dict['lease'] != parsed_dict['lease1']):
            del parsed_dict['lease1']
            parsed_dict['lease'] = True
    
    if ('lease' not in parsed_dict) and ('lease1' in parsed_dict):
        parsed_dict['lease'] = parsed_dict.pop('lease1')
        parsed_dict['lease'] = True
    #####

    #####
    if ('sublease' in parsed_dict) and ('sublease1' in parsed_dict):
        if (parsed_dict['sublease']!= '') and (parsed_dict['sublease'] != parsed_dict['sublease1']):
            del parsed_dict['sublease1']
            parsed_dict['sublease'] = True
    
    if ('sublease' not in parsed_dict) and ('sublease1' in parsed_dict):
        parsed_dict['sublease'] = parsed_dict.pop('sublease1')
        parsed_dict['sublease'] = True
    ####

    if ('sublease' in parsed_dict and 'sublet' in parsed_dict) or ('sublease' in parsed_dict and 'sublet' not in parsed_dict):
        del parsed_dict['sublease']
        parsed_dict['sublet'] = True


    if 'sublet' not in parsed_dict:
        parsed_dict['sublet'] = False
    if 'lease' not in parsed_dict:
        parsed_dict['lease'] = False

    # if parsed_dict['sublet'] == False and parsed_dict['lease'] == False:
    #     print('skipped')
    #     continue

    if isinstance(parsed_dict['sublet'], bool) == False:
        print('sublet not bool', parsed_dict['sublet'])
        # parsed_dict['sublet'] = True
        continue

    if isinstance(parsed_dict['lease'], bool) == False:
        print('lease not bool',parsed_dict['lease'])
        # parsed_dict['lease'] = True
        continue

    
    valid_keys = ["post_id","listing_title", "price", "bed", "bath", "address", "post_url", "city", "latitude", "longitude", "post_text", "sublet", "lease", "bus_time", "car_time", "walk_time"]
    if all(key in parsed_dict for key in valid_keys):
        parsed_dict['parsed'] = True

        url = "http://localhost:5000/add-processed-posts/"
        post = requests.post(url, json = parsed_dict)

        url = "http://localhost:5000/update-parsed-bool/"
        data = {"post_id":post_id,"parsed":True}
        result = requests.post(url, json = data)

    