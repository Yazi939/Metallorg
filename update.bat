@echo off
cd /d "D:\WEB\metal"
echo Проверка обновлений...
git fetch origin
git status
echo.
echo Получение обновлений...
git pull origin master
echo.
echo Обновление завершено!
pause
