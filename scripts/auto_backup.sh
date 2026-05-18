#!/bin/bash

# Khai báo đường dẫn
PROJECT_DIR=~/automation_project
DATA_DIR=$PROJECT_DIR/data
BACKUP_DIR=$PROJECT_DIR/backups
LOG_DIR=$PROJECT_DIR/logs
LOG_FILE=$LOG_DIR/backup.log

# Lấy thời gian hiện tại
TIME=$(date +"%Y-%m-%d_%H-%M")

# Tên file backup
BACKUP_FILE="data_backup_$TIME.tar.gz"

echo "===== BAT DAU BACKUP ====="

# =========================
# YEU CAU 1
# KIEM TRA THU MUC BACKUP
# =========================

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "Da tao thu muc backups/"
else
    echo "Thu muc backups da ton tai"
fi

# =========================
# YEU CAU 2
# NEN THU MUC DATA
# =========================

tar -czf $BACKUP_DIR/$BACKUP_FILE $DATA_DIR

# Kiểm tra backup thành công hay không
if [ $? -eq 0 ]; then
    STATUS="Thanh cong"
    echo "Backup thanh cong"
else
    STATUS="That bai"
    echo "Backup that bai"
fi

# =========================
# YEU CAU 4
# KIEM TRA INTERNET
# =========================

ping -c 1 google.com > /dev/null 2>&1

if [ $? -eq 0 ]; then
    NETWORK_STATUS="Co ket noi Internet"
    echo $NETWORK_STATUS
else
    NETWORK_STATUS="Khong co ket noi Internet"
    echo $NETWORK_STATUS
fi

# =========================
# YEU CAU 3
# GHI FILE LOG
# =========================

echo "============================" >> $LOG_FILE
echo "Thoi gian: $(date)" >> $LOG_FILE
echo "Ten file backup: $BACKUP_FILE" >> $LOG_FILE
echo "Trang thai backup: $STATUS" >> $LOG_FILE
echo "Trang thai mang: $NETWORK_STATUS" >> $LOG_FILE

# =========================
# BONUS 1
# CHI GIU LAI 5 FILE MOI NHAT
# =========================

cd $BACKUP_DIR

ls -t | tail -n +6 | xargs rm -f

echo "Da xoa backup cu"

# =========================
# BONUS 3
# THONG BAO HOAN THANH
# =========================

echo "===== BACKUP HOAN TAT ====="
