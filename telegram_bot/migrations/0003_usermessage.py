# Generated by Django 2.0.6 on 2018-08-10 11:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('telegram_bot', '0002_auto_20180702_0626'),
    ]

    operations = [
        migrations.CreateModel(
            name='UserMessage',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_id', models.CharField(max_length=50)),
                ('message_id', models.CharField(max_length=50)),
            ],
        ),
    ]