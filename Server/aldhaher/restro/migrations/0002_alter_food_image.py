# Generated by Django 4.2.5 on 2023-09-20 14:57

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("restro", "0001_initial"),
    ]

    operations = [
        migrations.AlterField(
            model_name="food",
            name="image",
            field=models.ImageField(null=True, upload_to="food_images/"),
        ),
    ]
