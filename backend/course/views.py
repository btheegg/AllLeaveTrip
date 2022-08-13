import json
import resource
from turtle import distance
from course.api import getTimeAndDistance
from course.recommend import get_attractions, get_restaurants, get_hotels

from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializer import  Course, CourseSerializer

from django.shortcuts import render


def getUseTmapInfo(course):
    useTmapInfo = []
    
    for courseinfo in course:
        useTmapInfo.append({"name": courseinfo["name"],"lat": courseinfo["lat"], "lng": courseinfo["lng"]})
    return useTmapInfo


# Create your views here.
@api_view(['GET'])
def get_course(request):
    courses = []
    time = []
    distance = []
    
    # Query Params
    userId = int(request.GET['userId'])
    day = int(request.GET['day'])
    areaCode = int(request.GET['areaCode'])
    
    # AI를 통해 추천받은 데이터(관광지,식당,호텔)를 가져온다
    attractions = get_attractions(day, userId, areaCode)
    hotels = get_hotels(day, userId, areaCode)
    restaurants = get_restaurants(day, userId, areaCode)
   
    # 사용자의 여행 날짜(day)에 맞게 AI 추천 코스, 소요 시간/거리를 구한다
    for i in range(day):
        
        # 랜덤하게 코스를 지정 한다
        course = [restaurants[0+(i*2)], attractions[0 + (3*i)],  attractions[1 + (3*i)],
                        restaurants[1+(i*2)], attractions[2 + (3*i)], hotels[0 + i]]
        # zz(course.all().values())
        if i == day - 1:
            course.pop()

        serializer = CourseSerializer(course,many = True)

        # 여행의 마지막 장소를 저장한다
        lastTrace = []
        for i in serializer.data:
            if(i['code']=='호텔'):
                lastTrace.append({"name": i['name'], "lat": i['lat'], "lng":i['lng']})

        # 추천 받은 코스의 각 명소에 대한 이름, 위치(위도,경도) 정보
        useTmapInfo = getUseTmapInfo(serializer.data)

        # 각 경유지 간 소요시간, 거리에 대한 데이터를 구한다
        timeAndDistanceInfo = getTimeAndDistance(useTmapInfo, lastTrace)
        for timeAndDistance in timeAndDistanceInfo:
            for eachInfo in timeAndDistance:
                time.append(eachInfo['time'])
                distance.append(eachInfo['distance'])
        
        # 각 명소에 대한 소요시간/거리 추가한다
        i=0
        for data in serializer.data:
            data['time'], data['distance'] = time[i], distance[i]
            i = i + 1

        courses.append(serializer.data)
    
    return Response(courses)

@api_view(['GET'])
def attractions(request):
    return get_attractions()

@api_view(['GET'])
def restaurants(request):
    return get_restaurants()


@api_view(['GET'])
def hotels(request):
    return get_hotels()




