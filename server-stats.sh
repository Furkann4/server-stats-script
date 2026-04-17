#!/bin/bash

echo "--- Sunucu Performans İstatikleri ---"

echo "CPU Kullanımı:"
top -bn1 | grep "Cpu(s)" | awk '{print "Kullanılan: " $2 + $4 "%"}'


echo -e "\nBellek (RAM) Kullanımı:"
free -m | awk 'NR==2{printf "Kullanılan: %sMB / Toplam: %sMB (%.2f%%)\n", $3, $2, $3*100/$2 }'

echo -e "\nDisk Kullanımı:"
df -h | awk '$NF=="/"{printf "Kullanılan: %s / Toplam: %s (%s)\n", $3, $2, $5}'

echo -e "\nEn Çok CPU Kullanan 5 Süreç:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

echo -e "\nEn Çok Bellek Kullanan 5 Süreç:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6

echo -e "\n--- Ekstra Sistem Bilgileri ---"
echo "İşletim Sistemi:" $(cat /etc/os-release | grep "PRETTY_NAME" | cut -d '"' -f 2)
echo "Sistem Ne Kadar Süredir Açık (Uptime):" $(uptime -p)
echo "Şu an Giriş Yapmış Kullanıcılar:" $(who | wc -l)
