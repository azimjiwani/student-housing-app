import re
import pymongo
import jsonify
import requests
import urllib.parse

url = "http://localhost:5000/get-unprocessed-posts/"
data = requests.get(url = url).json()

for post in data['result']:
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

    # parsed_dict['price'] = post['listing_price'].replace("$","")
    # if "," in parsed_dict['price']:
    #     parsed_dict['price'] = float(parsed_dict['price'].replace(',', ''))


    '''if "," in parsed_dict['price']:
                    parsed_dict['price'] = parsed_dict['price'].replace(",","")
                    parsed_dict['price'] = float(parsed_dict['price'].replace("$",""))
                else:
                    parsed_dict['price'] = float(parsed_dict['price'].replace("$",""))'''

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
        parsed_dict['address'] = str(parsed_dict['address']) + ', Waterloo, Canada'
        address = parsed_dict['address']
        url = 'https://nominatim.openstreetmap.org/search/' + urllib.parse.quote(address) +'?format=json'
        response = requests.get(url).json()
        if len(response) > 0:
            parsed_dict['latitude'] = float(response[0]["lat"])
            parsed_dict['longitude'] = float(response[0]["lon"])
        
        parsed_dict['city'] = "Waterloo, ON, Canada"

    ####
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

    valid_keys = ["post_id", "listing_title", "price", "bed", "bath", "address", "post_url", "city", "latitude", "longitude", "post_text"]
    if all(key in parsed_dict for key in valid_keys):

        parsed_dict['parsed'] = True
        url = "http://localhost:5000/add-processed-posts/"
        post = requests.post(url, json = parsed_dict)

        url = "http://localhost:5000/update-parsed-bool/"
        data = {"post_id":post_id,"parsed":True}
        result = requests.post(url, json = data)

    