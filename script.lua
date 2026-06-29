-- Настройки ссылок и файлов
local raw_audio_url = "https://github.com/twiceAA/Music_script_roblox_vibecode/raw/refs/heads/main/09624684deb3ada88cf5ee21c257fa45.ogg"
local filename = "09624684deb3ada88cf5ee21c257fa45.ogg"

-- 1. Скачивание файла через эксплоит (если его еще нет в папке workspace)
if not isfile(filename) then
    print("[Research] Скачивание звука с GitHub...")
    local success, result = pcall(function()
        return game:HttpGet(raw_audio_url)
    end)
    
    if success and result then
        writefile(filename, result)
        print("[Research] Звук успешно сохранен!")
    else
        warn("[Research] Ошибка скачивания: " .. tostring(result))
        return
    end
end

-- 2. Превращение локального файла в Roblox Asset ID
local asset_id
local success, err = pcall(function()
    asset_id = getcustomasset(filename)
end)

if not success or not asset_id then
    warn("[Research] Эксплоит не поддерживает getcustomasset: " .. tostring(err))
    return
end

-- 3. Создание объекта Sound и его воспроизведение
local SoundService = game:GetService("SoundService")
local sound = Instance.new("Sound")

sound.SoundId = asset_id
sound.Volume = 1
sound.PlayOnRemove = false
sound.Parent = SoundService -- Помещаем в SoundService, чтобы звук был слышен везде

-- Воспроизведение 1 раз
sound:Play()
print("[Research] Звук воспроизводится!")

-- Удаляем объект звука после завершения, чтобы не засорять память
sound.Ended:Connect(function()
    sound:Destroy()
    print("[Research] Звук завершен и объект удален.")
end)
