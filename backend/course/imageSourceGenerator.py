from unittest import result
import pandas as pd
import os
import requests

module_dir = os.path.dirname(__file__)  
attraction_csv = os.path.join(module_dir, 'csv/관광지.csv')
restaurant_csv = os.path.join(module_dir, 'csv/맛집.csv')
hotel_csv = os.path.join(module_dir, 'csv/숙박.csv')

headers = {'X-Naver-Client-Id' : 'fFmnSDg6r_o_pqMrnTcs', 'X-Naver-Client-Secret' : 'P9Phbz1C2v'}

# 관광지
# df = pd.read_csv(attraction_csv)
# results = []
# print(df.shape[0])
# count = 0
# for column_name, item in df.iterrows():
    
#     res = requests.get(f'https://openapi.naver.com/v1/search/image?query={item[1]}&sort=sim', headers=headers)
#     image = res.json()
#     try:
#         photo = image['items'][0]['link']
#         results.append(photo)
#     except:
#         results.append("")
        
#     print(f"{count}번째 : {results[count]}")
#     count += 1
    
    
# print(results)
# df.insert(5,"이미지", results)
# df.to_csv(path_or_buf = "./course/csv/관광지.csv", index=False)

# 맛집
# df = pd.read_csv(restaurant_csv)
# results = []
# print(df.shape[0])
# count = 0
# for column_name, item in df.iterrows():
    
#     res = requests.get(f'https://openapi.naver.com/v1/search/image?query={item[1]}&sort=sim', headers=headers)
#     image = res.json()
#     try:
#         photo = image['items'][0]['link']
#         results.append(photo)
#     except:
#         results.append("")
        
#     print(f"{count}번째 : {results[count]}")
#     count += 1
    
    
# print(results)
# df.insert(6,"이미지", results)
# df.to_csv(path_or_buf = "./course/csv/맛집.csv", index=False)

# 호텔
df = pd.read_csv(hotel_csv)
results = []
print(df.shape[0])
count = 0
for column_name, item in df.iterrows():
    
    res = requests.get(f'https://openapi.naver.com/v1/search/image?query={item[1]}&sort=sim', headers=headers)
    image = res.json()
    try:
        photo = image['items'][0]['link']
        results.append(photo)
    except:
        results.append("")
        
    print(f"{count}번째 : {results[count]}")
    count += 1
    
    
print(results)
df.insert(5,"이미지", results)
df.to_csv(path_or_buf = "./course/csv/숙박.csv", index=False)