from dataclasses import field
from email.policy import default
from rest_framework import serializers

class Course(object):
    def __init__(self, code, areaCode, id, name,rating, lat, lng, img):
        self.code = code
        self.areaCode = areaCode
        self.id= id
        self.name = name
        self.img = img
        self.rating = rating
        self.lat = lat
        self.lng = lng
        


    def update(self, instance, validated_data):
        instance.time = validated_data.get('time', instance.time)
        instance.save()
        return instance

class CourseSerializer(serializers.Serializer):
    code = serializers.ChoiceField(choices=["관광지", "식당", "호텔"])
    areaCode = serializers.IntegerField()
    id = serializers.IntegerField()
    name = serializers.CharField(max_length = 40)
 
    rating = serializers.FloatField()
    lat = serializers.DecimalField(10,8)
    lng = serializers.DecimalField(10,7)
    time = serializers.IntegerField(required=False, allow_null=True)
    distance = serializers.IntegerField(required=False, allow_null=True)
    img = serializers.CharField(max_length=200)


    class Meta:
        model = Course
        fields = '__all__' 
    

