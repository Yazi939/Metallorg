# Настройка автоматического обновления Git репозитория

## Способ 1: Использование cron (Linux/Mac) или Task Scheduler (Windows)

### Для Linux/Mac:
```bash
# Добавить в crontab (crontab -e)
*/5 * * * * cd /path/to/your/project && git pull origin master
```

### Для Windows:
Создать .bat файл и добавить в Task Scheduler:
```batch
@echo off
cd /d "D:\WEB\metal"
git pull origin master
```

## Способ 2: Webhook с локальным сервером

Создать простой локальный сервер, который будет получать уведомления от GitHub/GitLab:

### webhook-server.js (Node.js)
```javascript
const express = require('express');
const { exec } = require('child_process');
const app = express();

app.use(express.json());

app.post('/webhook', (req, res) => {
    console.log('Webhook received, pulling changes...');
    
    exec('git pull origin master', { cwd: 'D:\\WEB\\metal' }, (error, stdout, stderr) => {
        if (error) {
            console.error('Error:', error);
            return res.status(500).send('Error pulling changes');
        }
        console.log('Pull completed:', stdout);
        res.send('Changes pulled successfully');
    });
});

app.listen(3000, () => {
    console.log('Webhook server running on port 3000');
});
```

## Способ 3: GitHub Desktop с автообновлением

1. Установить GitHub Desktop
2. В настройках включить "Automatically fetch changes from the remote"
3. Настроить автоматический pull при обнаружении изменений

## Способ 4: VS Code с расширением

Использовать расширение "Auto Pull" в VS Code:
1. Установить расширение "Auto Pull"
2. Настроить интервал проверки изменений
3. Включить автоматический pull

## Способ 5: PowerShell скрипт для Windows

```powershell
# auto-pull.ps1
while ($true) {
    Set-Location "D:\WEB\metal"
    git fetch origin
    $local = git rev-parse HEAD
    $remote = git rev-parse origin/master
    
    if ($local -ne $remote) {
        Write-Host "Changes detected, pulling..."
        git pull origin master
        Write-Host "Pull completed at $(Get-Date)"
    }
    
    Start-Sleep -Seconds 300  # Проверка каждые 5 минут
}
```

Запустить: `powershell -ExecutionPolicy Bypass -File auto-pull.ps1`
