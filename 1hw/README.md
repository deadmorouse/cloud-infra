# Домашнее задание  «Организация сети»  
### 1. Отработка terraform, созданы в публичные и приватные подсети  
<img width="928" height="282" alt="15 1_output" src="https://github.com/user-attachments/assets/17ab9fd0-3dff-4f3d-8055-0131cfdd15c4" />  

Результат создания в yandex-cloud:  
<img width="1036" height="436" alt="15 1_subnets" src="https://github.com/user-attachments/assets/8cf09449-6780-4481-a411-2b36840d3761" />  
<img width="1288" height="292" alt="15 1_vms" src="https://github.com/user-attachments/assets/7751d126-b5a0-409a-b94b-6c6d0b50dd3a" />  
### 2. Проверка доступности public и private subnets  
Заходим через ssh в виртуалку, которая находится в public subnet. Пингуем: 
<img width="566" height="170" alt="15 1_pingpublic" src="https://github.com/user-attachments/assets/fb2b6906-f611-49e8-a9f5-6b477b9387f1" />  
Далее пытаемся зайти по ssh через виртуалку , которая находится в public на виртуалку, которая находится в private. Обязательно копируем закрытый ключ с локального хоста на виртуалку (public):  
<img width="645" height="153" alt="15 1_copyprivate" src="https://github.com/user-attachments/assets/965a9cbd-d1ed-40fa-8f0b-11ecabdd958c" />  
И при переходе на виртуалку (private) также проверяем доступ с помощью пинга:  
<img width="663" height="201" alt="15 1_pingprivate" src="https://github.com/user-attachments/assets/b6f9cf1f-7a6e-4402-8321-4759e4e93800" />
