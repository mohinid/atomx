## Transaction History Management System

### Overview
This Rails application maintains a database of transaction histories and provides option to generate Excel reports and list transactions with pagination and filtering.

![Alt text for image](/atomx/lib/assets/atomx.png)

### Database
Database Engine: MySQL

Fields:

id (auto-increment/primary key)

type (string: credit or debit)

invoice (string, 8-digit, unique)

timestamp (integer, Unix timestamp)

mobile (string)

status (string)

created_at and updated_at (Rails timestamps)

### Features
Transaction Record Management: Store and retrieve transaction records.

Excel Report Generation: Download a report with two sheets:

Summary: Aggregated data (e.g., totals, counts by type/status)

Dump: Complete list of transactions

API for Transaction Listing: List transactions with pagination and filtering by date and/or type.

API Endpoints
Endpoint	Method	Description
/transactions	GET	List transactions (paginated, filter by date and/or type) & Directly click on Download Report Button.
/transactions/report	GET	Download Excel report (summary and dump sheets) 

### How to Use
Clone the repository.

Set up the database:

Configure config/database.yml for MySQL.

Run rails db:create and rails db:migrate.

Seed data (optional): Use rails db:seed

Start the server: rails server

### Access APIs:

List transactions: GET /transactions

Download report: GET /transactions/report

### Dependencies
Ruby on Rails

MySQL (or MongoDB if configured)

Excel report generation gem (e.g., axlsx or xlsx_writer)

### Notes
Invoice numbers must be unique and exactly 8 digits.

Filtering by date uses the Unix timestamp; conversion may be required in the API.

Excel report generation should use a library compatible with Rails.