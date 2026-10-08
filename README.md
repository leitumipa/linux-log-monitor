# Linux Log Monitoring & Error Detection

## Project Overview

**Linux Log Monitoring & Error Detection** adalah project Bash sederhana untuk memonitor dan menganalisis file log pada Linux.

Project ini membaca log, mencari event `ERROR` dan `WARNING`, menghitung jumlah event, menampilkan event terbaru, menentukan status monitoring, dan menghasilkan report.

Project dibuat sebagai latihan Linux pemula untuk memahami hubungan antara:

- Linux filesystem
- Linux logging
- Bash scripting
- Text processing
- Pipeline
- Error handling
- Exit status
- Troubleshooting
- Git & GitHub

---

## Objectives

Project ini dibuat untuk mempraktikkan:

1. Membaca file log Linux.
2. Mencari event `ERROR`.
3. Mencari event `WARNING`.
4. Menghitung jumlah error dan warning.
5. Menampilkan event terbaru.
6. Menggunakan pipeline untuk memproses data log.
7. Menggunakan `grep`, `tail`, `wc`, `awk`, dan `sed`.
8. Membuat Bash script yang reusable.
9. Menggunakan function dalam Bash.
10. Melakukan input validation.
11. Menghasilkan report monitoring.
12. Mencatat aktivitas monitoring.
13. Menggunakan exit status.
14. Melakukan simulasi incident sederhana.
15. Menggunakan Git untuk version control.

---

## Technologies

- Linux
- Ubuntu
- WSL2
- Bash
- Git
- GitHub

---

## Project Structure

```text
linux-log-monitor/
├── scripts/
│   └── log_monitor.sh
│
├── logs/
│   ├── application.log
│   ├── scenario-ok.log
│   ├── scenario-warning.log
│   └── scenario-error.log
│
├── reports/
│   └── log_report.txt
│
├── screenshots/
│
├── .gitignore
└── README.md
```

`monitor.log` dan file report runtime tidak disimpan ke repository karena merupakan hasil eksekusi program.

---

## Log Format

Contoh format log yang digunakan:

```text
2026-10-08 09:03:10 ERROR Database connection failed
```

Format tersebut terdiri dari:

```text
DATE       TIME       LEVEL    MESSAGE
2026-10-08 09:03:10  ERROR    Database connection failed
```

Script menggunakan informasi tersebut untuk melakukan filtering dan analisis.

---

## How the Script Works

Alur utama script:

```text
Log File
   │
   ▼
Input Validation
   │
   ▼
Log Analysis
   │
   ├── Count ERROR
   ├── Count WARNING
   ├── Latest Events
   ├── Latest Errors
   └── Latest Warnings
   │
   ▼
Determine Status
   │
   ▼
Generate Report
   │
   ├── log_report.txt
   └── monitor.log
```

---

## Main Script

Script utama berada di:

```text
scripts/log_monitor.sh
```

Script menerima file log sebagai argument.

Contoh:

```bash
./scripts/log_monitor.sh logs/application.log
```

---

## How to Run

### 1. Clone Repository

```bash
git clone git@github.com:USERNAME/linux-log-monitor.git
```

Ganti `USERNAME` dengan username GitHub.

### 2. Masuk ke Project

```bash
cd linux-log-monitor
```

### 3. Pastikan Script Executable

```bash
chmod +x scripts/log_monitor.sh
```

### 4. Jalankan Monitoring

```bash
./scripts/log_monitor.sh logs/application.log
```

### 5. Lihat Report

```bash
cat reports/log_report.txt
```

### 6. Lihat Monitoring Log

```bash
cat logs/monitor.log
```

---

## Example Output

Contoh:

```text
========================================
 Linux Log Monitoring
========================================

Log file : logs/application.log
Report   : reports/log_report.txt
Status   : ERROR

ERROR    : 4
WARNING  : 3
```

Report kemudian disimpan ke:

```text
reports/log_report.txt
```

---

## Exit Status

Script menggunakan exit status untuk menunjukkan hasil monitoring.

| Exit Status | Meaning |
|---:|---|
| `0` | Tidak ditemukan ERROR atau WARNING |
| `1` | WARNING ditemukan |
| `2` | ERROR ditemukan |
| `3` | Monitoring gagal dijalankan |

Exit status dapat digunakan oleh script atau automation lain untuk mengetahui hasil monitoring.

Contoh:

```bash
./scripts/log_monitor.sh logs/application.log

echo $?
```

Jika ditemukan ERROR:

```text
2
```

---

## Testing Scenarios

Project memiliki beberapa scenario untuk testing.

### Scenario 1 — OK

```bash
./scripts/log_monitor.sh logs/scenario-ok.log
```

Expected:

```text
ERROR   : 0
WARNING : 0
STATUS  : OK
```

Exit status:

```text
0
```

---

### Scenario 2 — WARNING

```bash
./scripts/log_monitor.sh logs/scenario-warning.log
```

Expected:

```text
ERROR   : 0
WARNING : 2
STATUS  : WARNING
```

Exit status:

```text
1
```

---

### Scenario 3 — ERROR

```bash
./scripts/log_monitor.sh logs/scenario-error.log
```

Expected:

```text
ERROR   : 3
WARNING : 1
STATUS  : ERROR
```

Exit status:

```text
2
```

---

## Incident Simulation

Salah satu scenario mensimulasikan masalah koneksi database.

Contoh log:

```text
2026-10-08 09:02:30 WARNING Database response time high
2026-10-08 09:03:10 ERROR Database connection failed
2026-10-08 09:03:25 ERROR Database connection failed
2026-10-08 09:04:00 INFO Retrying database connection
2026-10-08 09:04:30 ERROR Database connection failed
2026-10-08 09:05:20 INFO Database connection restored
```

Dari timeline tersebut dapat diamati bahwa:

1. Database mulai mengalami response time yang tinggi.
2. Koneksi kemudian gagal.
3. Kegagalan terjadi beberapa kali.
4. Application melakukan retry.
5. Database akhirnya kembali terhubung.

Contoh analisis:

```bash
grep -i "database" logs/scenario-error.log
```

Mencari error:

```bash
grep -i "ERROR" logs/scenario-error.log
```

Menghitung error:

```bash
grep -ic "ERROR" logs/scenario-error.log
```

Mengambil error terbaru:

```bash
grep -i "ERROR" logs/scenario-error.log | tail -n 1
```

---

## Linux Concepts Learned

Project ini digunakan untuk mempraktikkan beberapa konsep Linux.

### Logging

Memahami fungsi log sebagai catatan event sistem atau aplikasi.

### `/var/log`

Memahami bahwa Linux biasanya menggunakan `/var/log` untuk berbagai system dan application log, walaupun struktur log dapat berbeda antar environment.

### `grep`

Digunakan untuk mencari pola tertentu dalam text.

```bash
grep "ERROR" application.log
```

### `tail`

Digunakan untuk melihat bagian akhir file.

```bash
tail -n 5 application.log
```

### Pipeline

Menghubungkan output sebuah command ke input command berikutnya.

```bash
grep "ERROR" application.log | tail -n 3
```

### `wc`

Digunakan untuk menghitung jumlah baris atau data.

### `awk`

Digunakan untuk memproses field pada text.

### `sed`

Digunakan untuk melakukan transformasi text.

### Bash Function

Membagi script menjadi beberapa bagian yang mempunyai tanggung jawab masing-masing.

### Exit Status

Memahami bahwa command atau script mengembalikan status eksekusi.

```text
0     = success
non-0 = condition/error
```

Project ini menggunakan exit status yang lebih spesifik untuk hasil monitoring.

---

## Lessons Learned

Melalui project ini saya mempelajari bahwa log monitoring bukan hanya tentang mencari kata `ERROR`.

Proses troubleshooting membutuhkan:

```text
What happened?
      ↓
When did it happen?
      ↓
How often?
      ↓
What happened before?
      ↓
What happened after?
      ↓
Has the problem recovered?
```

Log dapat digunakan untuk membangun timeline sebuah incident dan membantu menentukan langkah troubleshooting berikutnya.

---

## Future Improvements

Project ini dapat dikembangkan lebih lanjut dengan:

- Monitoring real-time menggunakan `tail -f`.
- Support terhadap lebih banyak log format.
- Filtering berdasarkan timestamp.
- Monitoring multiple log files.
- Alert ketika ERROR ditemukan.
- Integrasi dengan cron.
- Integrasi dengan systemd journal.
- Support terhadap `journalctl`.
- Disk usage monitoring.
- Service status monitoring.
- Network connectivity checking.
- Automated incident report.
- Email atau notification alert.

---

## Portfolio Goal

Project ini merupakan bagian dari pembelajaran Linux dari fundamental menuju Linux Server administration.

Fokus utama project:

```text
Linux
  ↓
Filesystem
  ↓
Logs
  ↓
Text Processing
  ↓
Bash
  ↓
Monitoring
  ↓
Troubleshooting
```

Project ini dibuat untuk menunjukkan pemahaman dasar Linux administration dan Bash scripting melalui project yang dapat dijalankan dan diuji secara langsung.
