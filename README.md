# TheatreFlow Optimizer — Lukyamuzi Brian

TheatreFlow Optimizer is a local theatre operations platform built for managing cases, users, analytics, and reporting in a hospital or surgical environment. The application is designed to run on a single workstation or private internal deployment and provides a browser-based interface backed by a Node.js server and SQLite database.

This document explains how the system works, what it contains, how to install it, and how to use it safely in a local environment.

## Purpose and scope

The system is intended to help theatre teams manage daily operational work such as:

- recording patient procedures and theatre cases
- tracking surgeon, theatre, procedure, and priority information
- monitoring actual versus estimated durations
- viewing dashboard summaries and operational metrics
- managing users and access roles
- reviewing activity and generating reports

It is best suited for a small healthcare department or theatre unit that needs a practical internal solution without relying on a large enterprise application.

## Overview of the application

The project consists of:

- a frontend UI in `public/index.html`
- a server and API layer in `server.js`
- a local SQLite database in `data/theatreflow.db`
- startup scripts for Windows and Mac/Linux
- configuration data in `package.json`

The front end is served by Express, and the main business logic and authentication are handled by the Node.js server.

## Features

### 1. Case management

The app includes a full case workflow for theatre operations:

- add new cases
- review existing records
- search by patient, procedure, surgeon, theatre, or status
- filter and sort records
- update the status and notes of cases
- see estimated versus actual duration

Each case can include information such as:

- patient name
- procedure type
- surgeon name
- procedure date
- theatre allocation
- priority
- case status
- notes
- actual and expected duration information

### 2. Dashboard summaries

The dashboard highlights the current operational picture, including:

- daily case volume
- theatre activity
- key performance statistics
- recent activity and alerts
- summary information for quick operational review

### 3. Analytics

The analytics module calculates and displays operational metrics based on historical case data. This includes:

- average duration by procedure
- procedure trends across records
- estimated versus actual performance
- surgeon and procedure performance summaries

### 4. User management

User administration supports:

- registering new users
- assigning roles such as staff or patient
- enabling or disabling accounts
- reviewing account metadata
- controlling access to protected areas of the system

### 5. Activity and notifications

The platform records activity events and surfaces them in the UI, enabling:

- operational auditing
- review of recent changes
- visibility into user actions
- internal notifications and alerts

### 6. Reporting

Users with report permissions can generate operational reports and export them in a readily usable format for operational review.

### 7. Security controls

The app uses basic but meaningful safeguards for a local system:

- password hashing with bcrypt
- signed session handling
- rate limiting on API routes
- security headers using Helmet
- permission checks on sensitive API endpoints

## Default user and login

On first run, the system creates a default administrator account:

- Email: `admin@theatreflow.local`
- Password: `Admin@12345`

This user is intended for local setup and testing. In any real deployment, it is strongly recommended to change the password immediately and restrict access to authorized staff.

## Supported environment

The application is designed for:

- local desktop use
- private clinic or theatre network use
- lightweight internal operation without external cloud infrastructure

It is not designed as a large multi-user production SaaS system out of the box.

## Requirements

Before running the app, ensure the following are available:

- Node.js 22 or later
- npm
- access to port 8080 on the local machine

## Installation

1. Open a terminal in the project root.
2. Run:

```bash
npm install
```

This will install the Express and SQLite dependencies required by the system.

## Running the application

### Method 1: Use npm

From the project root:

```bash
npm start
```

The server will launch and expose the app at:

- http://localhost:8080

### Method 2: Windows launcher

Double-click `START_WINDOWS.bat`.

This script:

- verifies that Node.js is installed
- closes any old process using port 8080
- installs dependencies if needed
- opens the app in a browser
- starts the server

### Method 3: Mac/Linux launcher

Run:

```bash
./START_MAC_LINUX.sh
```

The script checks for local dependencies and then starts the server.

## Project structure

```text
.
├── data/
│   └── theatreflow.db
├── public/
│   └── index.html
├── README.md
├── package.json
├── server.js
├── START_WINDOWS.bat
├── START_MAC_LINUX.sh
├── .gitignore
└── node_modules/
```

### Key files

- `server.js` — entry point for the application, database initialization, auth, and API logic
- `public/index.html` — all application UI and browser-side functionality
- `data/theatreflow.db` — local SQLite database
- `package.json` — Node package metadata and scripts
- `START_WINDOWS.bat` — Windows startup helper
- `START_MAC_LINUX.sh` — Unix-like operating system startup helper

## Application architecture

### Front end

The front end is a single-page application served from `public/index.html`. It includes multiple sections for:

- login / registration
- dashboard overview
- case management
- analytics
- user administration
- system activity
- notifications
- reports
- profile and settings

The interface is implemented in HTML, CSS, and JavaScript embedded in the page.

### Back end

The server file initializes:

- Express for HTTP routes
- a SQLite database
- session management
- secure password comparisons
- permission checks
- API endpoints for the client

### Data storage

The app stores data in SQLite. The database is saved under the `data` directory. On first launch, it creates required tables if they are missing and seeds the default admin account and sample records.

## API route summary

The server exposes REST-style API routes for the UI. Common endpoints include:

### Authentication

- `POST /api/login` — authenticate a user
- `POST /api/logout` — terminate the current session
- `POST /api/register` — create a new account
- `POST /api/password` — change the current password

### Case operations

- `GET /api/cases` — list cases with search/filter support
- `POST /api/cases` — add a case

### Dashboard and analytics

- `GET /api/dashboard` — fetch dashboard summary data
- `GET /api/analytics` — fetch analytics data

### User and system management

- `GET /api/users` — list users
- `POST /api/users` — add or update users
- `GET /api/activity` — view recent activity records

### Reporting

- `GET /api/report/:type` — generate report output

Most protected routes require an authenticated user and may also check permissions such as:

- `dashboard`
- `cases:view`
- `cases:create`
- `cases:update`
- `cases:delete`
- `users:view`
- `users:create`
- `users:update`
- `users:delete`
- `reports:view`
- `reports:export`
- `settings`
- `activity`

## Security notes

This system includes several safeguards appropriate for a local internal app, but users should still apply good deployment practices:

- change the default admin password as soon as possible
- verify the system is not accessible externally unless intentionally configured
- keep backups of the SQLite data directory
- restrict account permissions by role
- review access logs regularly

The app uses `better-sqlite3` for local data operations and `bcryptjs` for password hashing, which is standard for small server-side applications.

## Data model

The main entities are:

### Users

A user record includes:

- name
- email
- password hash
- role
- phone number
- avatar
- active status
- creation timestamps

### Cases

A case record includes:

- patient
- procedure
- surgeon
- theatre
- date
- priority
- status
- notes
- actual duration
- estimate metadata

### Activities

The activity table stores event history for auditing and operational review. These entries are useful when reviewing who changed what and when.

## Operational usage

A typical day in the application would include:

1. logging in as an authorized user
2. checking the dashboard summary
3. creating or updating theatre cases
4. reviewing daily theatre performance
5. reviewing activity logs
6. generating a report for administrative review

## Troubleshooting

### Application will not start

Check that:

- Node.js is installed
- dependencies are present
- another process is not using port 8080
- the server has permission to create `data/` files

### Login fails

Confirm:

- the correct email and password are being used
- the account exists and is active
- the server is running
- the browser is connected to the correct local URL

### Data issues

If the database becomes corrupted or unusable, you may need to remove or restore the SQLite file in `data/theatreflow.db`, then relaunch the app to recreate the environment.

## Maintenance guidance

To keep the app stable:

- run `npm install` when dependencies change
- keep the data directory backed up
- avoid exposing the app publicly without additional security hardening
- review role assignments and permissions regularly

## Final summary

TheatreFlow Optimizer is a practical local management system for theatre and surgical operations. It combines an easy-to-run browser application with a small backend and local database, giving departments a lightweight way to manage case records, user access, analytics, and reporting from a single platform.

This project is best suited for local use in a trusted hospital or theatre environment where a simple operational workflow is more important than a large multi-tenant enterprise architecture.
