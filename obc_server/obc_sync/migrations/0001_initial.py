# Generated by Django 2.2.14 on 2020-07-07 09:07

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='RideParams',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('added', models.DateTimeField(auto_now_add=True)),
                ('circumference', models.IntegerField(verbose_name='size of the wheel with tire')),
                ('rotations', models.IntegerField()),
                ('rideTime', models.IntegerField(verbose_name='total ride time in miliseconds')),
            ],
            options={
                'ordering': ['added'],
            },
        ),
    ]
