# Website Monitoring System

## Overview

A lightweight website monitoring and alerting system built using Bash scripting on Linux. The system continuously monitors website availability, measures response times, logs health metrics, generates uptime reports, and triggers alerts when websites become unavailable.

## Features

* Monitor multiple websites from a configuration file
* HTTP status code monitoring
* Response time measurement
* Retry mechanism to reduce false alerts
* Downtime detection
* Recovery detection
* Alert suppression using state tracking
* Detailed logging
* Uptime percentage reporting
* Cron-based automation

## Project Architecture

```text
Cron Scheduler
      |
      v
monitor.sh
      |
      +--> Website Health Check (curl)
      |
      +--> Response Time Monitoring
      |
      +--> Retry Logic
      |
      +--> State Tracking
      |
      +--> Alert Generation
      |
      +--> Log Storage
```

## Project Structure

```text
website-monitor/
│
├── monitor.sh
├── report.sh
├── config.txt
│
├── logs/
│   ├── monitor.log
│   └── alerts.log
│
├── alerts/
│   ├── alert.sh
│   └── state/
│
├── screenshots/
│
├── .gitignore
└── README.md
```

## Technologies Used

* Bash Shell Scripting
* Linux (Ubuntu)
* Curl
* Cron
* AWK
* Grep
* Sed
* BC

## Installation

Clone the repository:

```bash
git clone <repository-url>
cd website-monitor
```

Make scripts executable:

```bash
chmod +x monitor.sh
chmod +x report.sh
chmod +x alerts/alert.sh
```

Install dependencies:

```bash
sudo apt update
sudo apt install curl bc
```

## Configuration

Edit `config.txt` and add websites to monitor:

```text
https://google.com
https://github.com
https://example.com
```

## Running the Monitor

```bash
./monitor.sh
```

Example output:

```text
2026-06-10 01:13:26 | https://github.com | UP | Status: 200 | Time: 0.815024s | Attempts: 1
```

## Generating Uptime Reports

```bash
./report.sh
```

Sample report:

```text
Website : https://github.com
Total Checks : 120
Successful : 118
Failures : 2
Uptime (%) : 98.33
```

## Future Enhancements

* Email notifications
* Slack integration
* HTML dashboard
* Docker deployment
* Web-based monitoring interface

## Learning Outcomes

This project demonstrates:

* Linux automation
* Shell scripting
* Monitoring concepts
* Log analysis
* Alerting systems
* Cron job scheduling
* System administration fundamentals

## Author

Shivam Tiwari

