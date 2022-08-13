import json
import resource
from course.recommend import get_attractions, get_restaurants, get_hotels

from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializer import  Course, CourseSerializer

from django.shortcuts import render
from haversine import haversine

# Create your views here.
@api_view(['GET'])
def get_course(request):
    courses = []
    
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
        
        # 코스의 마지막 날에는 호텔을 제외한다.
        if i == day - 1:
            course.pop()

        # 코스 데이터를 직렬화 한다.
        serializer = CourseSerializer(course,many = True)

        # 추천 받은 코스의 각 명소에 대한 이름, 위치(위도,경도) 정보
        useTmapInfo = getUseTmapInfo(serializer.data)
        
        # 각 경유지 간 소요시간, 거리에 대한 데이터를 구한다
        timeAndDistanceInfo = getTimeAndDistance(useTmapInfo, 33.25217874,126.6231007)
        print(timeAndDistanceInfo)
        
        
        for index, data in enumerate(serializer.data):
            data['time'], data['distance'] = timeAndDistanceInfo[index][1], timeAndDistanceInfo[index][0]
          
        courses.append(serializer.data)
    
    return Response(courses)


def getUseTmapInfo(course):
    useTmapInfo = []
    
    for courseinfo in course:
        useTmapInfo.append({"name": courseinfo["name"],"lat": float(courseinfo["lat"]), "lng": float(courseinfo["lng"])})
    return useTmapInfo

def getTimeAndDistance(attractions, lat, lng):
    result = []
    user = (lat, lng)
    print(user)
    for index, attraction in enumerate(attractions):
        now = (attraction['lat'], attraction['lng'])
        
        # 사용자 위치에 대한 좌표를 입력 받아서, 그 좌표에 대한 거리를 계산한다
        if index == 0:
            distance = round(haversine(user, now),2)
            time = distance / 60
        else:
            distance = round(haversine(last, now),2)
            time = distance / 60
        
        last = now
 
        result.append((distance, int(time * 60)))
    
    return result