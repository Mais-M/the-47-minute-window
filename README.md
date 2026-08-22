The 47-Minute Window
A Fictional MySQL Financial Forensics Investigation
Project Overview

The 47-Minute Window is a fictional financial-forensics investigation built with MySQL.

The case begins when $487 million disappears from a protected reserve account within minutes.

The objective of the project is to reconstruct the movement of the stolen funds and determine whether the transaction activity can be connected to suspicious internal system access.

The investigation combines multiple synthetic evidence sources, including financial transactions, authentication logs, privilege changes, device information, and fictional interview timelines.

The central investigation asks:

Can transaction data and system-access evidence be combined to reconstruct the theft and identify the strongest insider-risk indicators?

The Scenario

At 02:13:07, the first suspicious transfer leaves RESERVE_001.

Within minutes, a total of $487 million has been distributed across several recipient accounts.

But the money does not remain there.

Some of the recipient accounts immediately begin forwarding the funds through additional accounts, payment services, and cryptocurrency-exchange destinations.

At the same time, system-access analysis reveals privileged activity immediately before the first transfer.

The investigation therefore develops around two questions:

Where did the money go?
Who had the access necessary to authorize the activity?
Dataset

This project uses a completely synthetic and fictional dataset created for educational and portfolio purposes.

The MySQL database contains five primary evidence sources:

transactions — records of financial transfers between accounts
access_logs — authentication and privileged system events
permission_changes — historical privilege grants and revocations
devices — corporate and personal device information
interview_claims — fictional statements describing where suspects claimed to be during the incident
Investigation Process
1. Detecting the Theft

The first stage identifies all transactions originating from the protected reserve account.

SQL aggregation is then used to calculate the total amount transferred.

The analysis reveals that approximately:

$487,000,000

left the reserve account during the incident window.

2. Measuring the Theft Window

The next step compares the timestamp of the first suspicious transaction with the final transaction.

This establishes how quickly the funds disappeared and demonstrates that the theft occurred within only a few minutes.

The investigation now has both:

the total financial loss
the critical time window
3. Identifying Initial Recipient Accounts

The transactions are grouped by destination account to identify where the largest portions of the money were initially transferred.

This produces a list of high-value recipient accounts that would become priority entities for further investigation.

4. Tracing Secondary Transfers

The next stage investigates whether the original recipient accounts kept the money.

A self-join reveals that some recipient accounts quickly became senders themselves.

The transaction pattern begins to look like:

RESERVE_001 → Recipient Account → Payment Service → Exchange

This suggests that the first recipient accounts may have been temporary staging points rather than final destinations.

5. Reconstructing the Money Trail

A recursive Common Table Expression (WITH RECURSIVE) is used to follow the movement of funds across multiple transaction hops.

This allows the investigation to reconstruct a larger transaction network instead of examining each transfer independently.

Example:

RESERVE_001 → ACC_8821 → PAYMENT_193 → EXCHANGE_72

At this stage, the investigation changes from simply identifying suspicious transactions to reconstructing an entire financial trail.

From the Money to the People

Tracing the stolen money answers only one part of the investigation.

The next question is:

Who had access to the system immediately before the theft?

The financial evidence is therefore combined with authentication and system-access records.

System Access Analysis

Access logs are examined during the minutes surrounding the first transfer.

One user becomes particularly interesting:

USER_017

The recorded sequence is:

02:11:48 — LOGIN_SUCCESS

02:12:03 — PRIVILEGED_SESSION

02:13:07 — PAYMENT_AUTHORIZATION

At exactly:

02:13:07

the first $120 million transfer also leaves the reserve account.

The timing creates a significant correlation between privileged system activity and the beginning of the financial theft.

The 47-Minute Discovery

The investigation then moves backward in time.

Historical permission records reveal that USER_017 had previously received a powerful:

PAYMENT_OVERRIDE

privilege.

But the unusual part is the duration.

The permission had been active for only:

47 minutes

and the event occurred approximately three months before the theft.

This changes the interpretation of the incident.

The theft may not have begun on the night the money disappeared.

The system environment may have been prepared months earlier.

This discovery gives the project its name:

The 47-Minute Window
Device Evidence

The investigation then connects system-access logs with device records.

The privileged activity associated with USER_017 is linked to:

DEVICE_8841

The device is classified as:

PERSONAL_LAPTOP

and:

is_corporate = 0

This means sensitive activity was associated with a non-corporate device, creating another important anomaly.

Human Claims vs. Machine Evidence

The fictional investigation also includes interview statements.

One suspect claims:

“At home asleep.”

The database, however, records activity during the same period:

02:11:48 — LOGIN_SUCCESS

02:12:03 — PRIVILEGED_SESSION

02:13:07 — PAYMENT_AUTHORIZATION

This allows the investigation to compare:

Human Claim

vs.

Recorded System Evidence

SQL joins are used to identify cases where a suspect's claimed timeline conflicts with verified system events.

Final Timeline Reconstruction

The final stage combines access events and financial transactions into a single chronological timeline.

The result looks like this:

02:11:48
USER_017 — LOGIN_SUCCESS

        ↓

02:12:03
USER_017 — PRIVILEGED_SESSION

        ↓

02:13:07
USER_017 — PAYMENT_AUTHORIZATION

        ↓

02:13:07
$120,000,000 → ACC_8821

        ↓

02:14:32
$95,000,000 → ACC_7712

        ↓

02:16:04
$72,000,000 → ACC_6620

        ↓

02:18:51
$100,000,000 → ACC_5541

        ↓

02:24:44
$100,000,000 → ACC_4410

The database does not independently establish criminal guilt.

Instead, it reveals a series of correlated indicators that would justify deeper investigation.

Key Findings

The analysis identifies several major anomalies:

$487 million leaves the reserve account within minutes.
Recipient accounts rapidly forward portions of the funds.
Part of the transaction trail reaches payment-service and cryptocurrency-exchange destinations.
Privileged system activity occurs immediately before the first transfer.
A historical PAYMENT_OVERRIDE permission existed before the incident.
The unusual permission window lasted only 47 minutes.
Sensitive activity is associated with a personal device.
A fictional suspect statement conflicts with recorded system events.
Combining financial and access data produces a much stronger investigative picture than examining either dataset independently.
SQL Techniques Demonstrated

This project demonstrates the use of:

CREATE DATABASE
CREATE TABLE
INSERT
SELECT
WHERE
ORDER BY
SUM()
COUNT()
AVG()
MIN()
MAX()
GROUP BY
HAVING
INNER JOIN
LEFT JOIN
Self-joins
CASE
Conditional aggregation
TIMESTAMPDIFF
UNION ALL
Recursive Common Table Expressions (CTEs)
Multi-table evidence correlation
Transaction tracing
Timeline reconstruction
Tools
MySQL 8.0+
MySQL Workbench
GitHub
Repository Structure
the-47-minute-window/
│
├── README.md
└── the_47_minute_window.sql

The SQL file contains the complete fictional investigation, including database creation, synthetic data, transaction analysis, access-log analysis, device correlation, permission analysis, and final timeline reconstruction.

Project Purpose

This project was created as a portfolio case study demonstrating how SQL can be used not only for traditional data analysis, but also for investigative reasoning.

The main analytical idea is to combine separate datasets and ask whether they tell the same story.

Financial transactions alone reveal where the money moved.

Access logs alone reveal who interacted with the system.

Device records reveal how the system was accessed.

Permission records reveal historical opportunities.

Interview timelines provide claims that can be compared with machine-recorded evidence.

When these datasets are joined together, patterns emerge that would be difficult to identify from any single table.

Disclaimer

This project is entirely fictional.

All users, accounts, devices, transactions, timestamps, financial values, permissions, interview statements, and investigation events were created as synthetic data for educational and portfolio purposes.

The project demonstrates SQL-based analytical and forensic reasoning and does not represent a real financial incident, real organization, or real individuals.
