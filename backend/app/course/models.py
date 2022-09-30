from django.db import models

# Create your models here.
class Code(models.Model):
    area = models.CharField(max_length=6)