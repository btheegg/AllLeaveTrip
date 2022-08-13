from django.shortcuts import render
from rest_framework.decorators import api_view
import requests

apiCalled = 0
lastTraces = []

# 각 경유지의 소요시간, 소요거리를 가져온다
def convert_to_each(each):
    eachInfo = each["properties"]
    availableData = []
    if((is_json_key_present(eachInfo, "time", "distance"))):
        availableData.append({"time" : round(int(eachInfo["time"])/60), "distance": round(int(eachInfo["distance"])/1000, 2)})
    return availableData


# 경유지 중 소요시간, 소요거리의 데이터 유무를 확인한다
def is_json_key_present(json, key1, key2):
    try:
        buf1 = json[key1]
        buf2 = json[key2]
    except KeyError:
        return False

    return True


# 각 체류 시간은 1시간씩 잡는다.
def getTimeAndDistance(useTmapInfo, lastTrace):
    global apiCalled
    global lastTraces
    apiCalled = apiCalled+1
    lastTraces.append(lastTrace)

    # 최초 출발지 설정
    startLat="37.56523875839218"
    startLng="126.977613738705"

    # api 가 다시 한번 불렸을 시, 그 날 사용자가 묵은 호텔을 기록한다.
    if apiCalled >= 2:
        lastTraceInfo = lastTraces[-2]
        for info in lastTraceInfo:
            startLat, startLng = info['lat'], info['lng']

    # sk open api 를 불러온다
    url = "https://apis.openapi.sk.com/tmap/routes/routeSequential30?version=1"
    viaPoints = []

    print("출발지: ", startLat, startLng)
    
    # 각 여행지의 경유지 명과 위치(위도, 경도)를 입력받는다
    # 머무는 시간은 1시간을 기준으로 한다
    for data in useTmapInfo:
        viaPoints.append(
            {
                "viaPointId": "1",
                "viaPointName": data["name"],
                "viaX": data["lng"],
                "viaY": data["lat"],
                "viaDetailAddress": data["name"],
                "viaTime": int(3600/60),
            }
        )

    # 사용자의 출발지, 도착지에 대한 정보를 받는다 (X: longitude(경도), Y: Latitude(위도))
    payload = {
        "reqCoordType": "WGS84GEO",
        "resCoordType": "WGS84GEO",
        "startName": "출발지",
        "startX": startLng,
        "startY": startLat,
        "startTime": "202208120800",
        "endName": "목적지",
        "endX": "126.9111805",
        "endY": "37.54652759",
        "searchOption": "0",
        "carType": "4",
        "viaPoints": viaPoints,
        "truckType": "1",
        "truckWidth": "250",
        "truckHeight": "340",
        "truckWeight": "35500",
        "truckTotalWeight": "26000",
        "truckLength": "880"
    }

    # 데이터에 대한 형식을 지정한다
    headers = {
        "Accept": "application/json",
        "appKey": "l7xxc1639bfca04849f7b088a3d69dac4f92",
        "Content-Type": "application/json"
    }
    
    response = requests.post(url, json=payload, headers=headers)

    # features 로부터 각 경유지마다의 데이터를 가져온다
    sources = response.json()["features"]
    timeAndDistance = []

    # 각 경유지마다의 데이터 중 맵핑을 통해 시간과 거리에 대한 데이터를 도출한다
    for data in map(convert_to_each, sources):
        # 맵핑을 통해 처리된 데이터 중 유효한 데이터만을 반환한다.
        if(len(data) > 0):
            timeAndDistance.append(data)

    return timeAndDistance

